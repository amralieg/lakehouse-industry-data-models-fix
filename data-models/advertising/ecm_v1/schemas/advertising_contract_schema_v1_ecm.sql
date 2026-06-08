-- Schema for Domain: contract | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`contract` COMMENT 'SSOT for all commercial agreements between the agency and its clients or media vendors — including MSAs, SOWs, RFP/RFI responses, IOs, and vendor contracts. Manages terms, pricing models, deliverables, SLAs, renewal cycles, scope, and contract compliance. Supports Proposal Development and Pitching and Budget Management processes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the commercial agreement. Primary key for the agreement entity.',
    `account_team_id` BIGINT COMMENT 'Reference to the internal account team responsible for managing this agreement and the client relationship.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client advertiser party to this agreement.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Master service agreements in advertising are often scoped to specific brands within multi-brand advertisers. Enables brand-level contract management, brand P&L reporting, and brand-specific budget all',
    `contract_template_id` BIGINT COMMENT 'Foreign key linking to contract.template. Business justification: Agreements are often created from pre-approved contract templates that define standard terms and clause libraries. N:1 relationship (many agreements from one template). No reverse FK exists. This trac',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Master service agreements are budgeted and tracked against specific cost centers for P&L management, overhead allocation, and profitability analysis in agency operations.',
    `parent_agreement_id` BIGINT COMMENT 'Reference to the parent or master agreement if this is a child agreement (e.g., SOW under an MSA, Amendment to an IO). Nullable for top-level agreements.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the agreement, used in client communications and invoicing.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the agreement. [ENUM-REF-CANDIDATE: Draft|Pending Approval|Active|Suspended|Terminated|Expired|Renewed — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the commercial agreement. MSA = Master Service Agreement, SOW = Statement of Work, IO = Insertion Order, RFP = Request for Proposal, RFI = Request for Information. [ENUM-REF-CANDIDATE: MSA|SOW|IO|RFP Response|RFI Response|Vendor Media Supply|Technology License|Production Services|Amendment — 9 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'Date when internal approval was granted to execute this agreement.',
    `approved_by` STRING COMMENT 'Name or identifier of the internal authority who approved this agreement.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiry unless terminated.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance or legal review of this agreement.',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a confidentiality or non-disclosure provision.',
    `contract_owner` STRING COMMENT 'Name or identifier of the individual responsible for ongoing management and compliance of this agreement.',
    `counterparty_type` STRING COMMENT 'Indicates whether the agreement is with a client (revenue-generating), vendor (cost-generating), or strategic partner.. Valid values are `Client|Vendor|Partner`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this agreement.. Valid values are `^[A-Z]{3}$`',
    `deliverables_summary` STRING COMMENT 'High-level summary of key deliverables, milestones, or outputs expected under this agreement.',
    `dispute_resolution_method` STRING COMMENT 'Agreed mechanism for resolving disputes arising from this agreement.. Valid values are `Litigation|Arbitration|Mediation`',
    `document_storage_url` STRING COMMENT 'URL or file path to the signed agreement document in the Digital Asset Management (DAM) or document management system.',
    `effective_date` DATE COMMENT 'Date when the agreement becomes legally binding and enforceable.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the agreement grants exclusive rights to the agency or client within a defined scope or territory.',
    `expiry_date` DATE COMMENT 'Date when the agreement terminates. Nullable for open-ended agreements.',
    `governing_law` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of this agreement (e.g., State of New York, England and Wales).',
    `indemnity_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an indemnity provision protecting one or both parties from third-party claims.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement record was last updated in the system.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount either party can be held responsible for under this agreement. Nullable if no cap applies.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or renewal discussion of this agreement.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or internal notes about this agreement.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due (e.g., Net 30, Net 60).',
    `performance_bonus_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes performance-based bonus or incentive provisions.',
    `pricing_model` STRING COMMENT 'Commercial pricing structure for this agreement. CPM = Cost Per Mille, CPC = Cost Per Click, CPA = Cost Per Acquisition. [ENUM-REF-CANDIDATE: Fixed Fee|Time and Materials|Retainer|Commission|CPM|CPC|CPA|Hybrid — 8 candidates stripped; promote to reference product]',
    `renewal_notice_period_days` STRING COMMENT 'Number of days advance notice required to prevent auto-renewal or to initiate renewal negotiation.',
    `scope_of_work_description` STRING COMMENT 'Detailed description of the services, deliverables, and work products covered by this agreement.',
    `signed_date` DATE COMMENT 'Date when all parties executed the agreement.',
    `sla_included_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes defined Service Level Agreements with performance targets and penalties.',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated, if applicable. Nullable for active agreements.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required for either party to terminate the agreement.',
    `termination_reason` STRING COMMENT 'Explanation or business reason for early termination of the agreement, if applicable.',
    `total_committed_value` DECIMAL(18,2) COMMENT 'Total monetary value committed under this agreement over its full term. For client agreements, represents expected revenue; for vendor agreements, represents committed spend.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Master record for all commercial agreements between the agency and its clients or media vendors — including MSAs (Master Service Agreements), SOWs (Statements of Work), IOs (Insertion Orders), vendor media supply agreements, technology licenses, and production services contracts. Captures contract type (client or vendor), counterparty reference, status, effective and expiry dates, governing law, jurisdiction, auto-renewal flags, notice periods, total committed value, and the owning account team. Serves as the SSOT for all contractual relationships — both client-facing and supply-side — and is the anchor entity for the contract domain.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`sow` (
    `sow_id` BIGINT COMMENT 'Unique identifier for the Statement of Work record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent Master Service Agreement under which this SOW is executed. Null if this is a standalone SOW without a parent MSA.',
    `client_contact_id` BIGINT COMMENT 'Reference to the client contact who provided formal approval for this SOW. Typically a senior marketing or procurement executive.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Statements of Work in advertising agencies are created at the brand level, not just advertiser level. Essential for brand-specific scope definition, brand campaign planning, brand budget tracking, and',
    `contract_template_id` BIGINT COMMENT 'Foreign key linking to contract.template. Business justification: SOWs are often created from templates that define standard scope structures and deliverable formats. N:1 relationship (many SOWs from one template). No reverse FK exists. This tracks SOW template usag',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SOWs are executed within cost center budgets; finance tracks SOW spend by cost center for profitability analysis and resource allocation decisions.',
    `advertiser_id` BIGINT COMMENT 'Reference to the specific advertiser entity under the client organization. May differ from client_id in holding company structures.',
    `worker_id` BIGINT COMMENT 'Reference to the agency contact who provided internal approval for this SOW. Typically an account director or managing director.',
    `sow_client_advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser for whom this SOW is executed. Links to the client master record.',
    `sow_worker_id` BIGINT COMMENT 'Reference to the agency account manager responsible for this SOW. Primary point of contact for client relationship and SOW execution.',
    `agency_fee_amount` DECIMAL(18,2) COMMENT 'Total agency service fees for the SOW, excluding media costs and third-party pass-throughs. Represents the agencys revenue from this engagement.',
    `approval_date` DATE COMMENT 'Date when the SOW was formally approved by the client and agency, making it legally binding.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the SOW automatically renews unless either party provides notice of termination. True if auto-renewal clause exists.',
    `billing_model` STRING COMMENT 'Pricing structure for the SOW. Determines how the client is invoiced (fixed price, hourly rates, monthly retainer, media commission, performance incentives, or combination).. Valid values are `fixed_fee|time_and_materials|retainer|commission|performance_based|hybrid`',
    `confidentiality_clause` STRING COMMENT 'Text of the confidentiality and non-disclosure provisions governing how both parties handle sensitive information shared during the engagement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SOW record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this SOW (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverables_summary` STRING COMMENT 'High-level summary of key deliverables expected under this SOW (e.g., 3 TV spots, 10 digital banners, monthly performance reports).',
    `effective_end_date` DATE COMMENT 'Date when the SOW expires or the engagement concludes. Null for open-ended retainer agreements.',
    `effective_start_date` DATE COMMENT 'Date when the SOW becomes effective and work may commence. Marks the beginning of the engagement period.',
    `intellectual_property_ownership` STRING COMMENT 'Specifies who owns the intellectual property rights to work created under this SOW (client owns all, agency retains rights, shared ownership, or work-for-hire arrangement).. Valid values are `client|agency|shared|work_for_hire`',
    `invoicing_frequency` STRING COMMENT 'Cadence at which the client will be invoiced under this SOW. Aligns with billing model and cash flow requirements.. Valid values are `monthly|quarterly|milestone|upon_completion|weekly|biweekly`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SOW record was last updated. Audit trail for record changes.',
    `media_budget_amount` DECIMAL(18,2) COMMENT 'Total media spend budget allocated under this SOW for media buying and placement. Excludes agency fees and production costs.',
    `payment_terms` STRING COMMENT 'Contractual payment terms specifying when and how invoices are to be paid (e.g., Net 30, Net 60, 50% upfront, 50% on completion).',
    `performance_bonus_amount` DECIMAL(18,2) COMMENT 'Maximum potential performance bonus amount payable to the agency if all performance criteria are met. Null if no performance incentives exist.',
    `performance_bonus_criteria` STRING COMMENT 'Description of performance metrics and thresholds that trigger bonus payments to the agency (e.g., ROAS exceeds 5:1, Campaign CTR above 2%).',
    `production_budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for creative production, including video, photography, design, and other content creation costs.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to terminate or opt out of renewal. Null if no renewal option exists.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the SOW includes an option for renewal or extension beyond the initial term. True if renewal clause exists.',
    `scope_of_work` STRING COMMENT 'Comprehensive description of all services, deliverables, and activities included in the SOW. Defines what is in-scope and out-of-scope.',
    `sla_deliverable_turnaround_days` STRING COMMENT 'Standard number of business days committed for deliverable turnaround under normal circumstances. Part of service level commitments.',
    `sla_response_time_hours` STRING COMMENT 'Maximum number of hours the agency commits to respond to client requests or issues under this SOW. Part of service level commitments.',
    `sow_description` STRING COMMENT 'Detailed narrative description of the SOW scope, objectives, and high-level deliverables. Provides context for the engagement.',
    `sow_number` STRING COMMENT 'Business-facing unique identifier for the SOW, typically formatted as SOW-XXXXXX. Used in client communications, invoicing, and contract references.. Valid values are `^SOW-[A-Z0-9]{6,12}$`',
    `sow_status` STRING COMMENT 'Current lifecycle status of the SOW. Tracks progression from draft through approval, execution, and closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `sow_type` STRING COMMENT 'Classification of the SOW by engagement type. Determines billing model, resource allocation, and deliverable expectations. [ENUM-REF-CANDIDATE: project|retainer|campaign|media_buy|creative_services|consulting|production|research|strategy — 9 candidates stripped; promote to reference product]',
    `termination_clause` STRING COMMENT 'Text of the termination provisions, specifying conditions under which either party may terminate the SOW and associated notice periods or penalties.',
    `title` STRING COMMENT 'Descriptive title of the SOW, summarizing the engagement or campaign scope (e.g., Q1 2024 Brand Awareness Campaign, Digital Media Planning Services).',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the SOW across its entire duration, including all fees, media spend, and pass-through costs. Expressed in the contract currency.',
    `version_number` STRING COMMENT 'Version identifier for the SOW document, typically in major.minor format (e.g., 1.0, 2.1). Incremented with each amendment or revision.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_sow PRIMARY KEY(`sow_id`)
) COMMENT 'Statement of Work entity capturing the detailed scope, deliverables, milestones, timelines, and pricing for a specific client engagement under a parent MSA or standalone agreement. Tracks SOW number, version, approval status, total value, start and end dates, billing model (fixed-fee, T&M, retainer), and the responsible account manager. Supports Proposal Development and Pitching and Budget Management processes.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`contract_insertion_order` (
    `contract_insertion_order_id` BIGINT COMMENT 'Unique identifier for the insertion order record. Primary key for the insertion order entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client advertiser on whose behalf this media spend is authorized.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Media insertion orders are executed at brand level in advertising operations. Critical for brand-level media planning, campaign trafficking, media reconciliation, and brand share-of-voice tracking—fun',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign for which this insertion order authorizes media spend.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Media insertion orders in advertising execute at brand level within advertisers. Tracking which brand each IO supports is essential for brand-level budget allocation, pacing reports, media mix analysi',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: IOs authorize media spend against approved campaign budgets; budget management requires linking IO commitments to budgets for spend control and variance reporting.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent master service agreement or contract under which this insertion order is executed.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Contract IOs and media IOs represent the same business artifact from contract management vs. media execution perspectives. Linking enables reconciliation between contract commitments and media executi',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Insertion Orders are often executed under a specific Statement of Work that defines the scope and deliverables. N:1 relationship (many IOs can be under one SOW). No reverse FK exists. This links media',
    `supplier_id` BIGINT COMMENT 'Reference to the publisher or media vendor with whom this insertion order establishes a media buying commitment.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Insertion Orders can be executed under vendor contracts that define pricing and terms with specific publishers/vendors. N:1 relationship (many IOs under one vendor contract). No reverse FK exists. Thi',
    `agency_commission_rate` DECIMAL(18,2) COMMENT 'The percentage commission rate earned by the agency on media spend under this insertion order, typically ranging from 0% to 20%.',
    `billing_contact_email` STRING COMMENT 'Email address of the billing contact for invoice delivery and payment-related communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Name of the primary billing contact responsible for invoice processing and payment authorization for this insertion order.',
    `buying_method` STRING COMMENT 'The method by which media inventory is purchased under this insertion order. RTB (Real-Time Bidding) indicates auction-based programmatic buying.. Valid values are `direct|programmatic_guaranteed|programmatic_non_guaranteed|RTB|private_marketplace|preferred_deal`',
    `cancellation_policy` STRING COMMENT 'Terms and conditions governing cancellation or early termination of the insertion order, including notice periods and financial penalties.',
    `committed_clicks` BIGINT COMMENT 'The total number of clicks committed or guaranteed under this insertion order for CPC-based campaigns. Null for non-click-based rate types.',
    `committed_conversions` BIGINT COMMENT 'The total number of conversions or acquisitions committed under this insertion order for CPA-based campaigns. Null for non-conversion-based rate types.',
    `committed_impressions` BIGINT COMMENT 'The total number of ad impressions committed or guaranteed by the media vendor under this insertion order. Null for non-guaranteed or performance-based deals.',
    `created_by_user` STRING COMMENT 'Identifier of the user who created this insertion order record, supporting accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this insertion order record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this insertion order.. Valid values are `^[A-Z]{3}$`',
    `flight_end_date` DATE COMMENT 'The date when the media campaign flight ends and ad serving authorization under this insertion order expires.',
    `flight_start_date` DATE COMMENT 'The date when the media campaign flight begins and ad serving is authorized to commence under this insertion order.',
    `io_approved_date` DATE COMMENT 'The date when the insertion order was approved by the media vendor, authorizing campaign setup and trafficking.',
    `io_name` STRING COMMENT 'Human-readable descriptive name for the insertion order, typically including campaign reference and media vendor for easy identification.',
    `io_number` STRING COMMENT 'The externally-known unique business identifier for this insertion order, used in communications with media vendors and internal tracking systems.. Valid values are `^IO-[A-Z0-9]{6,12}$`',
    `io_signed_date` DATE COMMENT 'The date when the insertion order was executed and signed by all required parties, establishing the binding commitment.',
    `io_status` STRING COMMENT 'Current lifecycle status of the insertion order in the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|pending_signature|executed|active|paused|cancelled|completed|expired — 8 candidates stripped; promote to reference product]',
    `io_submitted_date` DATE COMMENT 'The date when the insertion order was submitted to the media vendor for review and approval.',
    `io_type` STRING COMMENT 'Classification of the insertion order based on the media buying model and inventory commitment type.. Valid values are `standard|programmatic|direct|guaranteed|non_guaranteed|preferred_deal`',
    `make_good_policy` STRING COMMENT 'Terms governing make-good provisions when the media vendor fails to deliver committed impressions or performance metrics, including remediation options.',
    `media_channel` STRING COMMENT 'The primary media channel or platform type for this insertion order. OOH (Out-of-Home), DOOH (Digital Out-of-Home), OTT (Over-the-Top), CTV (Connected TV). [ENUM-REF-CANDIDATE: display|video|mobile|social|search|native|audio|OOH|DOOH|OTT|CTV|email — 12 candidates stripped; promote to reference product]',
    `modified_by_user` STRING COMMENT 'Identifier of the user who last modified this insertion order record, supporting change accountability and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this insertion order record was last modified, supporting change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-form notes capturing additional terms, special instructions, or contextual information relevant to this insertion order.',
    `payment_terms` STRING COMMENT 'The agreed payment terms specifying when payment is due after invoice receipt (e.g., Net 30 means payment due within 30 days).. Valid values are `net_30|net_60|net_90|prepay|upon_receipt|custom`',
    `placement_specifications` STRING COMMENT 'Detailed specifications for ad placements including ad formats, sizes, positions, targeting criteria, and creative requirements as agreed with the media vendor.',
    `rate_amount` DECIMAL(18,2) COMMENT 'The unit rate or price associated with the rate type (e.g., $5.00 CPM, $0.50 CPC). Precision supports fractional cent pricing common in programmatic media.',
    `rate_type` STRING COMMENT 'The pricing model used for this insertion order. CPM (Cost Per Mille), CPC (Cost Per Click), CPA (Cost Per Acquisition), CPV (Cost Per View), CPCV (Cost Per Completed View), or other billing structure. [ENUM-REF-CANDIDATE: CPM|CPC|CPA|CPV|CPCV|flat_fee|cost_plus|percentage_of_spend — 8 candidates stripped; promote to reference product]',
    `third_party_ad_serving_fee` DECIMAL(18,2) COMMENT 'Additional fee charged for third-party ad serving technology, tracking, and verification services associated with this insertion order.',
    `total_authorized_spend` DECIMAL(18,2) COMMENT 'The total budget amount authorized for media spend under this insertion order, representing the maximum financial commitment.',
    `trafficking_contact_email` STRING COMMENT 'Email address of the trafficking contact for campaign setup and creative asset coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `trafficking_contact_name` STRING COMMENT 'Name of the primary trafficking contact responsible for campaign setup, creative delivery, and ad serving coordination.',
    CONSTRAINT pk_contract_insertion_order PRIMARY KEY(`contract_insertion_order_id`)
) COMMENT 'Formal IO (Insertion Order) record authorizing media spend with a specific publisher or vendor for a defined campaign flight. Captures IO number, media vendor reference, campaign reference, total authorized spend, flight start and end dates, placement specifications, rate type (CPM, CPC, CPA, flat fee), and IO status (draft, pending signature, executed, paused, cancelled). The authoritative transactional record linking media buying commitments to contractual obligations under a parent agreement. Supports media cost reconciliation and vendor payment authorization workflows.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`term` (
    `term_id` BIGINT COMMENT 'Primary key for term',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this term belongs.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Terms and conditions can be specific to a SOW (not just agreement-level). N:1 relationship (many terms can belong to one SOW). No reverse FK exists. This allows SOW-specific terms to be tracked separa',
    `amendment_count` STRING COMMENT 'Number of times this term clause has been amended or modified since the original contract execution.',
    `approval_status` STRING COMMENT 'Current approval state of the term clause within the contract review and approval workflow (e.g., draft, pending legal review, pending finance review, pending executive approval, approved, rejected, superseded). [ENUM-REF-CANDIDATE: draft|pending_legal_review|pending_finance_review|pending_executive_approval|approved|rejected|superseded — 7 candidates stripped; promote to reference product]',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who provided final approval for this term clause.',
    `approved_date` DATE COMMENT 'Date when the term clause received final approval and was authorized for inclusion in the executed contract.',
    `audit_frequency` STRING COMMENT 'Specified frequency or trigger for audit rights when audit_rights_flag is True (e.g., annual, semi-annual, quarterly, upon request).. Valid values are `annual|semi_annual|quarterly|upon_request|not_specified`',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether this term grants audit rights to either party (True) or does not include audit provisions (False).',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this term includes automatic renewal provisions (True) or requires explicit renewal action (False).',
    `clause_category` STRING COMMENT 'High-level categorization of the clause into legal, commercial, operational, compliance, financial, or technical domains for organizational and reporting purposes.. Valid values are `legal|commercial|operational|compliance|financial|technical`',
    `clause_summary` STRING COMMENT 'Plain-language summary of the clause for business users, highlighting key obligations, rights, and implications.',
    `clause_text` STRING COMMENT 'Full legal text of the term clause as negotiated and executed. Contains the complete wording of the contractual provision.',
    `clause_title` STRING COMMENT 'Short descriptive title or heading of the term clause as it appears in the contract document.',
    `clause_type` STRING COMMENT 'Classification of the term clause by its legal or commercial function (e.g., payment terms, IP ownership, confidentiality, indemnification, termination rights, audit rights, liability limitation, warranty, SLA, scope, deliverable, pricing, renewal). [ENUM-REF-CANDIDATE: payment|intellectual_property|confidentiality|indemnification|termination|audit_rights|liability_limitation|warranty|service_level|scope_of_work|deliverable|pricing|renewal — 13 candidates stripped; promote to reference product]',
    `compliance_framework` STRING COMMENT 'Name of the regulatory or compliance framework that governs this term (e.g., GDPR, CCPA, IAB Standards, MRC Guidelines, TAG Certification) when compliance_requirement_flag is True.',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this term clause is subject to regulatory compliance monitoring and reporting requirements (True) or is a standard commercial term (False).',
    `confidentiality_duration_years` STRING COMMENT 'Number of years that confidentiality obligations remain in effect after contract termination when the clause type is confidentiality-related.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this term record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this specific term clause becomes binding and enforceable within the contract lifecycle.',
    `expiration_date` DATE COMMENT 'Date when this term clause ceases to be in effect, if applicable. Null for terms that remain in force for the duration of the contract.',
    `indemnification_scope` STRING COMMENT 'Description of the scope and limitations of indemnification obligations when the clause type is indemnification-related.',
    `intellectual_property_ownership` STRING COMMENT 'Specifies the ownership model for intellectual property created under the contract when the clause type is IP-related (e.g., client owns, agency owns, joint ownership, work-for-hire, licensed).. Valid values are `client|agency|joint|work_for_hire|licensed`',
    `last_amended_date` DATE COMMENT 'Date of the most recent amendment to this term clause.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount specified in the term clause when the clause type is liability limitation, expressed in the contract currency.',
    `liability_cap_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the liability cap amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this term record was last modified in the system.',
    `negotiated_flag` BOOLEAN COMMENT 'Indicates whether this term was negotiated and modified from the standard template (True) or accepted as-is from the standard contract language (False).',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the term clause, including negotiation history, special considerations, or implementation guidance.',
    `payment_method` STRING COMMENT 'Specified payment instrument or mechanism for financial settlement (e.g., wire transfer, ACH, check, credit card, EFT) when applicable to the term.. Valid values are `wire_transfer|ach|check|credit_card|electronic_funds_transfer`',
    `payment_term_days` STRING COMMENT 'Number of days for payment terms (e.g., net-30, net-60, net-90) when the clause type is payment-related.',
    `penalty_provision` STRING COMMENT 'Description of financial or contractual penalties for non-compliance with the term, including service level breaches, late payments, or other violations.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to opt out of automatic renewal or to initiate renewal discussions.',
    `risk_level` STRING COMMENT 'Assessment of the legal or financial risk associated with this term clause, used for prioritization of legal review and compliance monitoring.. Valid values are `low|medium|high|critical`',
    `sequence` STRING COMMENT 'Ordering or numbering of the term within the parent contract or Statement of Work (SOW), used to maintain clause hierarchy and presentation order.',
    `service_level_metric` STRING COMMENT 'Name of the performance metric or Key Performance Indicator (KPI) specified in the service level term (e.g., response time, uptime percentage, delivery timeframe).',
    `service_level_target` STRING COMMENT 'Target value or threshold for the service level metric (e.g., 99.9% uptime, 24-hour response time, 5-day delivery).',
    `standard_clause_flag` BOOLEAN COMMENT 'Indicates whether this term is part of the organizations standard contract template (True) or is a custom clause specific to this agreement (False).',
    `term_number` STRING COMMENT 'Business identifier for the term clause, often used for legal reference and cross-referencing within contract documents.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for contract termination when the clause type is termination-related (e.g., 30-day notice, 60-day notice).',
    CONSTRAINT pk_term PRIMARY KEY(`term_id`)
) COMMENT 'Granular terms and conditions clauses attached to an agreement or SOW — including payment terms (net-30, net-60), IP ownership clauses, confidentiality obligations, indemnification provisions, termination-for-convenience rights, and audit rights. Each term record captures clause type, clause text, effective date, negotiated flag, and approval status. Enables clause-level compliance tracking and legal review workflows.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`contract_deliverable` (
    `contract_deliverable_id` BIGINT COMMENT 'Unique identifier for the contractual deliverable. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser for whom this deliverable is being produced.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or Statement of Work (SOW) under which this deliverable is committed.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign or project to which this deliverable is associated, if applicable.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Creative deliverables (ads, videos, copy) are produced for specific brands. Brand guidelines compliance, brand safety review, digital asset management, and brand portfolio reporting all require knowin',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.milestone. Business justification: Deliverables can be tied to contractual milestones representing payment triggers or checkpoints. N:1 relationship (many deliverables can be associated with one milestone). No reverse FK exists. This i',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deliverables consume resources from specific cost centers; finance tracks actual costs by deliverable for margin analysis and cost center performance reporting.',
    `creative_asset_id` BIGINT COMMENT 'The identifier of the final deliverable asset stored in the Digital Asset Management (DAM) system.',
    `flowchart_id` BIGINT COMMENT 'Foreign key linking to media.media_flowchart. Business justification: Flowcharts are contractual deliverables with acceptance criteria. Linking deliverables to flowcharts enables acceptance tracking, milestone payment triggers, and provides audit trail for deliverable s',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Contract deliverables are tracked in project management systems as initiatives/projects. Currently workfront_project_id is stored as an unlinked string. Normalizing to initiative_id FK enables joining',
    `sow_id` BIGINT COMMENT 'Reference to the specific Statement of Work (SOW) that defines this deliverable.',
    `acceptance_criteria` STRING COMMENT 'The specific criteria, standards, or requirements that must be met for the client to accept the deliverable.',
    `acceptance_date` DATE COMMENT 'The date on which the client formally accepted the deliverable as meeting contractual requirements.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual total cost incurred to produce this deliverable, used for budget reconciliation and profitability analysis.',
    `actual_hours` DECIMAL(18,2) COMMENT 'The actual number of labor hours spent on completing this deliverable, tracked for billing and performance analysis.',
    `billable_amount` DECIMAL(18,2) COMMENT 'The amount that will be billed to the client for this deliverable, as specified in the contract or SOW.',
    `client_feedback` STRING COMMENT 'Detailed feedback or comments provided by the client during the review process.',
    `contract_deliverable_description` STRING COMMENT 'Detailed description of the deliverable scope, content, and specifications as outlined in the contract or SOW.',
    `contract_deliverable_status` STRING COMMENT 'Current lifecycle status of the deliverable (e.g., pending, in-progress, submitted, under review, accepted, rejected, on hold, cancelled). [ENUM-REF-CANDIDATE: pending|in_progress|submitted|under_review|accepted|rejected|on_hold|cancelled — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this deliverable record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this deliverable (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverable_code` STRING COMMENT 'Unique business identifier or code for the deliverable, often used for tracking and billing purposes.',
    `deliverable_name` STRING COMMENT 'The business name or title of the deliverable as specified in the contract (e.g., Q1 Brand Strategy Deck, Creative Asset Package - Summer Campaign).',
    `deliverable_type` STRING COMMENT 'Classification of the deliverable by type (e.g., creative asset, media plan, campaign report, brand strategy deck, analytics dashboard). [ENUM-REF-CANDIDATE: creative_asset|media_plan|campaign_report|brand_strategy|research_report|analytics_dashboard|presentation|video_production|digital_content|print_collateral — 10 candidates stripped; promote to reference product]',
    `delivery_format` STRING COMMENT 'The file format or medium in which the deliverable will be provided (e.g., PDF, PowerPoint, video file, HTML, ZIP archive). [ENUM-REF-CANDIDATE: pdf|pptx|video|html|zip|jpeg|png|mp4|xlsx|docx — 10 candidates stripped; promote to reference product]',
    `delivery_method` STRING COMMENT 'The method or channel through which the deliverable will be transmitted to the client (e.g., email, file share, DAM platform, physical delivery, client portal).. Valid values are `email|file_share|dam_platform|physical_delivery|client_portal|ftp`',
    `due_date` DATE COMMENT 'The contractually committed date by which the deliverable must be completed and submitted to the client.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The estimated total cost to produce this deliverable, including labor, materials, and third-party expenses.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'The estimated number of labor hours required to complete this deliverable, used for resource planning and budgeting.',
    `internal_notes` STRING COMMENT 'Internal notes or comments from the production team regarding the deliverable, not shared with the client.',
    `is_milestone` BOOLEAN COMMENT 'Boolean flag indicating whether this deliverable represents a major milestone in the contract or project timeline.',
    `modified_by` STRING COMMENT 'The username or identifier of the person who last modified this deliverable record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this deliverable record was last modified or updated.',
    `priority` STRING COMMENT 'The business priority level assigned to this deliverable, used for resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `rejection_reason` STRING COMMENT 'The reason provided by the client for rejecting the deliverable, if applicable, used to guide revisions.',
    `requires_client_approval` BOOLEAN COMMENT 'Boolean flag indicating whether this deliverable requires formal client approval before being considered complete.',
    `responsible_team` STRING COMMENT 'The internal team or department responsible for producing and delivering this deliverable (e.g., Creative, Media Planning, Analytics, Strategy).',
    `revision_number` STRING COMMENT 'The current revision or version number of the deliverable, incremented with each resubmission or update.',
    `submission_date` DATE COMMENT 'The actual date on which the deliverable was submitted to the client for review.',
    `created_by` STRING COMMENT 'The username or identifier of the person who created this deliverable record.',
    CONSTRAINT pk_contract_deliverable PRIMARY KEY(`contract_deliverable_id`)
) COMMENT 'Specific contractual deliverable committed under a SOW or agreement — such as a creative asset package, media plan, campaign report, or brand strategy deck. Captures deliverable name, description, due date, acceptance criteria, responsible team, delivery format, and current status (pending, in-progress, submitted, accepted, rejected). Bridges contract obligations to operational execution tracked in Workfront.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`sla` (
    `sla_id` BIGINT COMMENT 'Unique identifier for the service level agreement record.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or statement of work (SOW) that contains this SLA commitment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SLA performance is tracked by the cost center responsible for delivery; finance monitors SLA compliance costs and penalty exposure.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Service Level Agreements can be defined at SOW level with specific performance commitments for that scope of work. N:1 relationship (many SLAs can belong to one SOW). No reverse FK exists. This allows',
    `approval_authority` STRING COMMENT 'Role or individual who has authority to approve SLA modifications, waivers, or breach remediation plans.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this SLA automatically renews at the end of its term (true) or requires explicit renegotiation (false).',
    `baseline_measurement_period` STRING COMMENT 'The time period over which the baseline performance was measured (e.g., Q4 2023, Last 6 months, Prior contract term).',
    `baseline_performance` DECIMAL(18,2) COMMENT 'Historical or benchmark performance level used as a reference point for setting the SLA target, captured at contract negotiation.',
    `breach_threshold` DECIMAL(18,2) COMMENT 'The performance level at which an SLA breach is triggered, may differ from target to allow tolerance (e.g., target 24 hours, breach at 30 hours).',
    `breach_threshold_unit` STRING COMMENT 'Unit of measure for the breach threshold value.. Valid values are `hours|business_days|calendar_days|percentage|minutes|count`',
    `client_acceptance_date` DATE COMMENT 'The date when the client formally accepted and signed off on this SLA commitment.',
    `compliance_tracking_enabled` BOOLEAN COMMENT 'Indicates whether automated compliance monitoring and breach alerting is enabled for this SLA (true) or manual tracking only (false).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date when this SLA commitment expires or is superseded, nullable for open-ended commitments.',
    `effective_start_date` DATE COMMENT 'The date when this SLA commitment becomes active and enforceable.',
    `escalation_contact` STRING COMMENT 'Name or role of the individual or team to be notified when an SLA breach occurs or is imminent.',
    `exclusions` STRING COMMENT 'Circumstances or conditions explicitly excluded from SLA measurement (e.g., force majeure, client-caused delays, third-party platform outages, holiday periods).',
    `last_review_date` DATE COMMENT 'The most recent date when this SLA was reviewed during a quarterly business review (QBR) or contract review cycle.',
    `measurement_frequency` STRING COMMENT 'How often the SLA performance is measured and reported (per transaction, daily, weekly, monthly, quarterly, annual).. Valid values are `per_transaction|daily|weekly|monthly|quarterly|annual`',
    `measurement_methodology` STRING COMMENT 'Detailed description of how the SLA metric is calculated, what data sources are used, and any rounding or aggregation rules applied.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the target value (hours, business days, calendar days, percentage, minutes, count).. Valid values are `hours|business_days|calendar_days|percentage|minutes|count`',
    `metric_name` STRING COMMENT 'The specific measurable performance indicator being tracked (e.g., Response Time, Delivery Time, Uptime Percentage, Approval Cycle Duration).',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified this SLA record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA record was last modified.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of this SLA commitment, typically aligned with QBR cycles.',
    `notes` STRING COMMENT 'Additional context, clarifications, or special conditions related to this SLA that do not fit in structured fields.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary value or percentage of the penalty applied per breach occurrence, if applicable.',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `penalty_mechanism` STRING COMMENT 'The contractual remedy applied when an SLA is breached (service credit, fee reduction, termination right, penalty payment, none).. Valid values are `service_credit|fee_reduction|termination_right|penalty_payment|none`',
    `remediation_terms` STRING COMMENT 'Detailed description of the corrective actions, escalation procedures, and resolution commitments when an SLA breach occurs.',
    `reporting_schedule` STRING COMMENT 'Frequency at which SLA performance reports are delivered to the client or stakeholders (real-time, daily, weekly, monthly, quarterly, on-demand).. Valid values are `real_time|daily|weekly|monthly|quarterly|on_demand`',
    `sla_code` STRING COMMENT 'Business identifier or code for the SLA, often referenced in contract documents and quarterly business reviews (QBRs).',
    `sla_name` STRING COMMENT 'Human-readable name of the SLA commitment (e.g., Creative Turnaround Time, Campaign Go-Live SLA, Reporting Delivery Deadline).',
    `sla_status` STRING COMMENT 'Current lifecycle status of the SLA (active, suspended, expired, terminated, draft, under review).. Valid values are `active|suspended|expired|terminated|draft|under_review`',
    `sla_type` STRING COMMENT 'Category of SLA defining the nature of the performance commitment (creative turnaround, campaign go-live, reporting delivery, platform uptime, trafficking response, client approval).. Valid values are `creative_turnaround|campaign_go_live|reporting_delivery|platform_uptime|trafficking_response|client_approval`',
    `target_value` DECIMAL(18,2) COMMENT 'The committed performance target value that must be met or exceeded (e.g., 24 hours, 99.9 percent, 2 business days).',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this SLA record.',
    CONSTRAINT pk_sla PRIMARY KEY(`sla_id`)
) COMMENT 'Service Level Agreement record defining measurable performance commitments within a client or vendor contract — including creative turnaround times, campaign go-live SLAs, reporting delivery deadlines, platform uptime guarantees, and media trafficking response times. Captures SLA type, metric name, target value, measurement unit, measurement frequency, breach threshold, penalty mechanism (credit, fee reduction, termination right), and remediation terms. Supports contract compliance monitoring, QBR scorecards, and automated breach alerting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`contract_rate_card` (
    `contract_rate_card_id` BIGINT COMMENT 'Unique identifier for the contract rate card. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this rate card is attached. Links to the master contract entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rate cards define billing rates that vary by cost center (creative vs. strategy teams have different overhead structures); finance uses this for margin calculation.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this rate card for use. Supports approval audit trail.',
    `approved_date` DATE COMMENT 'Date when this rate card was formally approved for use. Supports approval audit trail and compliance tracking.',
    `audience_segment` STRING COMMENT 'Target audience segment or demographic to which this rate applies, such as Adults 18-34, High-Income Households, B2B Decision Makers. Supports audience-based pricing.',
    `base_rate` DECIMAL(18,2) COMMENT 'The standard or base rate amount for this rate card entry, before any adjustments, discounts, or surcharges. Precision supports fractional currency units and CPM calculations.',
    `billing_frequency` STRING COMMENT 'How often charges under this rate card are invoiced: weekly, biweekly, monthly, quarterly, milestone (upon reaching project milestones), on_completion (at project end), or custom (bespoke schedule). [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|quarterly|milestone|on_completion|custom — 7 candidates stripped; promote to reference product]',
    `contract_rate_card_status` STRING COMMENT 'Current lifecycle status of the rate card: draft (being prepared), pending_approval (submitted for review), approved (authorized but not yet effective), active (currently in force), suspended (temporarily inactive), expired (past effective period), superseded (replaced by newer version). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|expired|superseded — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate card record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all rates in this rate card (e.g., USD, EUR, GBP). Ensures consistent currency handling in multi-currency environments.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Negotiated discount percentage applied to the base rate, expressed as a percentage (e.g., 15.00 for 15% discount). Supports volume discounts or client-specific pricing.',
    `effective_end_date` DATE COMMENT 'Date when this rate card expires and is no longer applicable. Nullable for open-ended rate cards.',
    `effective_start_date` DATE COMMENT 'Date when this rate card becomes effective and applicable for billing. Supports time-bound pricing agreements.',
    `geography_scope` STRING COMMENT 'Geographic scope or market to which this rate card applies, such as USA, EMEA, APAC, New York DMA, Global. Supports geo-specific pricing.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this is the default rate card for the associated contract or service line. True if default, False otherwise.',
    `is_negotiable` BOOLEAN COMMENT 'Flag indicating whether rates in this card are open to negotiation or are fixed. True if negotiable, False if fixed.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Agency markup or commission percentage applied to vendor costs or media spend, expressed as a percentage (e.g., 20.00 for 20% markup).',
    `maximum_rate` DECIMAL(18,2) COMMENT 'Ceiling rate or maximum charge applicable under this rate card. Used for rate caps or maximum allowable charges.',
    `media_type` STRING COMMENT 'For media inventory rate cards, the type of media covered: display, video, audio, social, search, native, OOH (Out-of-Home), DOOH (Digital Out-of-Home), CTV (Connected TV), OTT (Over-the-Top), print, radio, TV, mobile, or email. [ENUM-REF-CANDIDATE: display|video|audio|social|search|native|ooh|dooh|ctv|ott|print|radio|tv|mobile|email — 15 candidates stripped; promote to reference product]',
    `minimum_rate` DECIMAL(18,2) COMMENT 'Floor rate or minimum charge applicable under this rate card. Used for CPM floors, minimum hourly charges, or minimum project fees.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this rate card record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate card record was last modified. Supports audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, conditions, or clarifications related to this rate card. Supports business context and exception handling.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due under this rate card (e.g., 30 for Net 30, 60 for Net 60).',
    `pricing_model` STRING COMMENT 'The pricing structure used in this rate card: hourly (time-based), daily, monthly, per_unit (per deliverable), CPM (Cost Per Mille), CPC (Cost Per Click), CPA (Cost Per Acquisition), flat_fee (fixed price), commission_percentage (percentage of media spend), tiered (volume-based pricing), or custom (bespoke arrangement). [ENUM-REF-CANDIDATE: hourly|daily|monthly|per_unit|cpm|cpc|cpa|flat_fee|commission_percentage|tiered|custom — 11 candidates stripped; promote to reference product]',
    `rate_card_name` STRING COMMENT 'Descriptive name of the rate card for business reference, such as Q1 2024 Agency Services Rate Card or Premium Media Inventory Pricing.',
    `rate_card_number` STRING COMMENT 'Business identifier for the rate card, typically used in invoicing and billing reconciliation. Format: RC- followed by alphanumeric code.. Valid values are `^RC-[A-Z0-9]{6,12}$`',
    `rate_card_type` STRING COMMENT 'Classification of the rate card by its purpose: agency_services (hourly FTE rates by role), media_inventory (CPM/CPC rates for ad placements), production (creative production cost rates), vendor_services (third-party vendor pricing), commission (media commission percentages), or hybrid (combination of multiple types).. Valid values are `agency_services|media_inventory|production|vendor_services|commission|hybrid`',
    `rate_category` STRING COMMENT 'Business classification or grouping for the rates in this card, such as Senior Creative Staff, Digital Media Placements, Video Production Services, or Programmatic Inventory. Supports rate organization and reporting.',
    `role_level` STRING COMMENT 'For agency services rate cards, the seniority or role level to which this rate applies, such as Junior Designer, Senior Account Director, Executive Creative Director. Supports role-based billing.',
    `service_line` STRING COMMENT 'The agency service line or practice area covered by this rate card, such as Creative Services, Media Planning, Digital Strategy, Production, Analytics. Supports service-based rate organization.',
    `unit_of_measure` STRING COMMENT 'The unit by which the rate is measured and billed: hour (hourly rate), day (daily rate), month (monthly retainer), impression (per 1000 impressions for CPM), click (per click for CPC), acquisition (per conversion for CPA), unit (per deliverable), project (per project), percentage (commission), or flat (one-time fee). [ENUM-REF-CANDIDATE: hour|day|month|impression|click|acquisition|unit|project|percentage|flat — 10 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Version identifier for the rate card, supporting version control and change tracking. Format: v1.0, v2.1, etc.. Valid values are `^v?d+.d+(.d+)?$`',
    `volume_tier` STRING COMMENT 'Volume-based pricing tier identifier for tiered rate cards, such as Tier 1: 0-100K impressions, Tier 2: 100K-500K impressions. Supports tiered pricing models.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this rate card record. Supports audit trail and accountability.',
    CONSTRAINT pk_contract_rate_card PRIMARY KEY(`contract_rate_card_id`)
) COMMENT 'Negotiated pricing schedule attached to a client agreement or vendor contract — defining unit rates for agency services (hourly FTE rates by role, production cost rates, media commission percentages) or vendor media inventory pricing (CPM floors, CPC rates, flat placement fees). Captures rate card version, effective date range, currency, rate type, and approval status. The SSOT for contractual pricing used in billing reconciliation.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`rate_card_line` (
    `rate_card_line_id` BIGINT COMMENT 'Primary key for rate_card_line',
    `contract_rate_card_id` BIGINT COMMENT 'Reference to the parent rate card document that contains this line item. Links this line to the master rate card agreement.',
    `approval_status` STRING COMMENT 'Approval workflow status for this rate card line. Tracks whether pricing has been reviewed and authorized by appropriate stakeholders.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this rate card line item. Supports audit trail and accountability for pricing decisions.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this rate card line item was approved. Provides temporal audit trail for pricing authorization.',
    `billing_frequency` STRING COMMENT 'Cadence at which this line item is invoiced to the client. Aligns billing cycles with contract terms and cash flow management. [ENUM-REF-CANDIDATE: hourly|daily|weekly|monthly|quarterly|milestone|upon_completion — 7 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'Internal cost center or department code for financial allocation and profit and loss (P&L) tracking. Links rate card revenue to organizational units.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rate card line record was first created in the system. Provides audit trail for record inception.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit rate (e.g., USD, EUR, GBP). Enables multi-currency rate card management.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the unit rate for this line item. Used for volume discounts, promotional pricing, or negotiated rate reductions.',
    `effective_end_date` DATE COMMENT 'Date when this rate card line item expires or is superseded. Null for open-ended rates. Enables rate change management and historical tracking.',
    `effective_start_date` DATE COMMENT 'Date when this rate card line item becomes active and applicable for billing. Supports rate versioning and temporal pricing.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue recognition. Maps rate card line items to chart of accounts for financial reporting.. Valid values are `^[0-9]{4,10}$`',
    `is_retainer_eligible` BOOLEAN COMMENT 'Indicates whether this line item can be included in retainer-based billing arrangements. Supports hybrid fee structures combining retainer and project-based work.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this line item is subject to sales tax or value-added tax (VAT). Drives tax calculation in billing systems.',
    `line_item_code` STRING COMMENT 'Business identifier code for this rate card line item. Used for billing system integration and invoice reconciliation.. Valid values are `^[A-Z0-9]{3,20}$`',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of this line item within the parent rate card. Determines display order in proposals and invoices.',
    `line_status` STRING COMMENT 'Current lifecycle status of this rate card line item. Controls whether the line is available for use in proposals and billing.. Valid values are `draft|active|suspended|expired|superseded`',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Agency markup or commission percentage applied on top of base cost for pass-through expenses or media buys. Common in media buying and vendor management.',
    `maximum_commitment_quantity` DECIMAL(18,2) COMMENT 'Maximum volume or hours available for this line item under the contract terms. Null if no cap applies. Manages scope and resource allocation.',
    `minimum_commitment_quantity` DECIMAL(18,2) COMMENT 'Minimum volume or hours the client must purchase for this line item under the contract terms. Null if no minimum applies. Enforces contractual commitments.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this rate card line record. Supports change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rate card line record was last updated. Enables change detection and temporal analysis.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, or clarifications related to this rate card line item. Supports operational communication and edge case documentation.',
    `overage_rate` DECIMAL(18,2) COMMENT 'Rate charged for usage exceeding the maximum commitment quantity. Typically higher than the standard unit rate. Null if no overage pricing applies.',
    `role_title` STRING COMMENT 'Job title or role designation for labor-based rate card lines (e.g., Senior Art Director, Media Planner, Account Executive). Null for non-labor items.',
    `seniority_level` STRING COMMENT 'Experience tier for labor-based rate card lines. Determines rate differential based on expertise and responsibility level.. Valid values are `junior|mid_level|senior|principal|executive`',
    `service_description` STRING COMMENT 'Detailed description of the service, role, or media placement type covered by this line item. Provides clarity on scope and deliverables.',
    `service_type` STRING COMMENT 'Category of service or deliverable covered by this rate card line. Classifies the type of work being priced.. Valid values are `creative_services|media_planning|media_buying|account_management|strategy_consulting|production`',
    `tax_category_code` STRING COMMENT 'Tax classification code for this line item. Used by financial systems to apply correct tax rates and comply with jurisdictional tax rules.. Valid values are `^[A-Z0-9]{2,10}$`',
    `unit_of_measure` STRING COMMENT 'The unit by which this service or media placement is quantified and billed (e.g., hourly rate, cost per thousand impressions, flat fee per placement). [ENUM-REF-CANDIDATE: hour|day|week|month|impression|click|placement|project|deliverable — 9 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'The base price charged per unit of measure. Core pricing element used for billing calculations and budget forecasting.',
    `volume_tier_threshold_max` DECIMAL(18,2) COMMENT 'Maximum quantity threshold for volume-based pricing tier. Null for open-ended top tier. Defines upper bound of pricing tier range.',
    `volume_tier_threshold_min` DECIMAL(18,2) COMMENT 'Minimum quantity threshold for volume-based pricing tier. Null if no volume discounting applies. Used with volume_tier_threshold_max to define tier ranges.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this rate card line record. Supports data lineage and accountability.',
    CONSTRAINT pk_rate_card_line PRIMARY KEY(`rate_card_line_id`)
) COMMENT 'Individual line-item entry within a rate card defining the unit price for a specific service, role, or media placement type. Captures line item code, service or role description, unit of measure (hour, impression, click, placement), unit rate, volume tier thresholds, discount percentage, and effective date range. Enables granular billing calculations and spend reconciliation against contracted rates.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`rfp_response` (
    `rfp_response_id` BIGINT COMMENT 'Primary key for rfp_response',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: RFPs in multi-brand advertiser relationships are often brand-specific. Agencies pitch for individual brand business. Essential for brand-specific pitch development, brand win/loss analysis, and brand ',
    `contract_template_id` BIGINT COMMENT 'Foreign key linking to contract.template. Business justification: RFP responses often use contract templates as starting points for proposed terms and pricing models. N:1 relationship (many responses can use one template). No reverse FK exists. This tracks which tem',
    `last_modified_by_user_worker_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this RFP response record. Links to user or talent entity for audit purposes.',
    `advertiser_id` BIGINT COMMENT 'Identifier of the client or prospect organization that issued the RFP or RFI. Links to the advertiser or client entity.',
    `primary_rfp_worker_id` BIGINT COMMENT 'Identifier of the primary team member leading the pitch and response effort. Typically links to an employee or talent record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract or master service agreement (MSA) that resulted from winning this RFP. Null if the response was lost or no contract was signed.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: RFP responses evaluate potential vendor suppliers for new business. Procurement teams track which suppliers responded to RFPs, compare supplier proposals, and link winning RFP responses to resulting a',
    `worker_id` BIGINT COMMENT 'Identifier of the user or system account that created this RFP response record. Links to user or talent entity for audit purposes.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the proposed budget amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `client_feedback` STRING COMMENT 'Qualitative feedback received from the client regarding the response, presentation, or pitch. Captures strengths, weaknesses, and areas for improvement as communicated by the client.',
    `client_industry` STRING COMMENT 'Industry or vertical market of the issuing client or prospect (e.g., automotive, financial services, retail, healthcare). Used for segmentation and expertise matching.',
    `competitive_intelligence_notes` STRING COMMENT 'Internal notes capturing competitive intelligence gathered during the RFP process, including known competitors, their strengths/weaknesses, and strategic positioning insights.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RFP response record was first created in the system. Audit trail field.',
    `decision_date` DATE COMMENT 'Date when the client communicated their decision (win, loss, or no-bid outcome) to the agency.',
    `estimated_contract_duration_months` STRING COMMENT 'Estimated duration of the resulting contract in months, as proposed or anticipated in the RFP response.',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Internal estimate of the total contract value or annual revenue potential if the RFP is won. Used for pipeline forecasting and resource planning.',
    `geographic_scope` STRING COMMENT 'Geographic markets or regions covered by the proposed scope of work (e.g., North America, EMEA, Global). May be comma-separated list of regions or countries.',
    `internal_approval_date` DATE COMMENT 'Date when the RFP response received final internal approval from agency leadership before submission to the client.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this RFP response record was last updated or modified. Audit trail field.',
    `no_bid_reason` STRING COMMENT 'Explanation of why the agency decided not to respond to the RFP (no-bid decision). Captures strategic, resource, or conflict-of-interest considerations.',
    `pitch_team_members` STRING COMMENT 'List of team members involved in preparing and presenting the response. May include names, roles, or identifiers in a delimited format.',
    `presentation_date` DATE COMMENT 'Date when the agency presented or pitched the response to the client in person or virtually. Null if no presentation was required or conducted.',
    `presentation_location` STRING COMMENT 'Physical location or virtual platform where the pitch presentation took place (e.g., client office address, Zoom, Microsoft Teams).',
    `probability_of_win_percent` DECIMAL(18,2) COMMENT 'Internal assessment of the likelihood of winning the RFP, expressed as a percentage (0-100). Used for pipeline forecasting and resource allocation decisions.',
    `proposed_budget_max` DECIMAL(18,2) COMMENT 'Maximum value of the proposed budget range included in the response. Represents the upper bound of the financial commitment proposed to the client.',
    `proposed_budget_min` DECIMAL(18,2) COMMENT 'Minimum value of the proposed budget range included in the response. Represents the lower bound of the financial commitment proposed to the client.',
    `proposed_scope_summary` STRING COMMENT 'High-level summary of the scope of work, services, and deliverables proposed in the response. Captures the strategic approach and key offerings.',
    `proposed_services` STRING COMMENT 'Detailed list or description of specific services proposed (e.g., media planning, creative development, digital marketing, analytics). May be comma-separated or narrative format.',
    `response_document_url` STRING COMMENT 'URL or file path to the submitted RFP response document or presentation deck stored in the agencys DAM (Digital Asset Management) system or document repository.',
    `response_status` STRING COMMENT 'Current lifecycle status of the RFP response: draft (being prepared), internal review (under agency review), submitted (sent to client), shortlisted (advanced to next round), won (contract awarded), lost (not selected), or no-bid (declined to respond).. Valid values are `draft|internal_review|submitted|shortlisted|won|lost`',
    `rfp_received_date` DATE COMMENT 'Date when the agency received the RFP or RFI from the client or prospect.',
    `rfp_reference_number` STRING COMMENT 'The externally-known reference number or identifier assigned to the RFP or RFI by the issuing client or prospect. This is the business identifier used in communications and documentation.',
    `rfp_type` STRING COMMENT 'Classification of the request type: RFP (Request for Proposal), RFI (Request for Information), RFQ (Request for Quote), pitch invitation, tender, or general proposal request.. Valid values are `rfp|rfi|rfq|pitch_invitation|tender|proposal_request`',
    `submission_date` TIMESTAMP COMMENT 'Actual date and time when the agency submitted the response to the client or prospect.',
    `submission_deadline` TIMESTAMP COMMENT 'Date and time by which the RFP response must be submitted to the client. This is the principal business event timestamp for the response lifecycle.',
    `win_loss_category` STRING COMMENT 'Categorical classification of the primary factor contributing to the win or loss outcome: pricing, creative approach, team expertise, strategic fit, incumbent advantage, or timing.. Valid values are `pricing|creative_approach|team_expertise|strategic_fit|incumbent_advantage|timing`',
    `win_loss_reason` STRING COMMENT 'Explanation or categorization of why the response was won or lost. Captures feedback from the client, internal assessment, or competitive factors. Used for pipeline analysis and continuous improvement.',
    CONSTRAINT pk_rfp_response PRIMARY KEY(`rfp_response_id`)
) COMMENT 'Agency response to a client or prospect RFP (Request for Proposal) or RFI (Request for Information). Captures RFP reference number, issuing client/prospect, submission deadline, response status (draft, internal review, submitted, shortlisted, won, lost, no-bid), proposed budget range, proposed scope summary, pitch team members, competitive intelligence notes, and win/loss reason. Supports the Proposal Development and Pitching business process and feeds pipeline reporting. Links to resulting agreement upon win.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique identifier for the contract amendment record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract, Statement of Work (SOW), Master Service Agreement (MSA), or Insertion Order (IO) being amended.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to campaign.campaign. Business justification: Amendments to insertion orders or SOWs frequently adjust campaign budgets, timelines, or scope. Linking amendment→campaign enables budget reconciliation, change order tracking, and campaign financial ',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.insertion_order. Business justification: Amendments can modify Insertion Orders (budget changes, flight date extensions, placement adjustments). N:1 relationship (many amendments can apply to one IO). No reverse FK exists. This allows tracki',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Amendments can modify SOWs (scope changes, deliverable adjustments) in addition to modifying master agreements. N:1 relationship (many amendments can apply to one SOW). No reverse FK exists. This allo',
    `superseded_by_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that supersedes or replaces this amendment, if applicable.',
    `agency_signatory_name` STRING COMMENT 'Full name of the agency representative who signed the amendment on behalf of the agency.',
    `agency_signatory_title` STRING COMMENT 'Job title or role of the agency representative who signed the amendment.',
    `amendment_number` STRING COMMENT 'Sequential or hierarchical amendment identifier (e.g., A-001, Amendment 1, 2024-A-03) used for external reference and tracking.',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment in the approval and execution workflow.. Valid values are `draft|pending_approval|approved|executed|rejected|superseded`',
    `amendment_type` STRING COMMENT 'Classification of the amendment based on the nature of the contractual change being made.. Valid values are `scope_change|budget_adjustment|timeline_extension|term_revision|pricing_modification|deliverable_change`',
    `approval_date` DATE COMMENT 'Date on which the amendment received formal approval from the authorized approver.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or authority who approved the amendment.',
    `budget_delta_amount` DECIMAL(18,2) COMMENT 'The net change in budget amount resulting from the amendment (revised minus original).',
    `change_description` STRING COMMENT 'Detailed narrative describing the specific contractual changes, modifications, or adjustments being made through this amendment.',
    `change_reason` STRING COMMENT 'Business justification or rationale for the amendment, explaining why the contractual modification is necessary.',
    `client_signatory_name` STRING COMMENT 'Full name of the client representative who signed the amendment on behalf of the client organization.',
    `client_signatory_title` STRING COMMENT 'Job title or role of the client representative who signed the amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this amendment.. Valid values are `^[A-Z]{3}$`',
    `document_url` STRING COMMENT 'URL or file path to the signed amendment document stored in the Digital Asset Management (DAM) system or document repository.',
    `effective_date` DATE COMMENT 'Date on which the amendment terms become binding and enforceable.',
    `execution_date` DATE COMMENT 'Date on which all required parties signed and executed the amendment.',
    `expiration_date` DATE COMMENT 'Date on which the amendment terms expire or are no longer applicable, if applicable.',
    `legal_review_completed` BOOLEAN COMMENT 'Indicates whether the required legal review has been completed for this amendment.',
    `legal_review_date` DATE COMMENT 'Date on which the legal review of the amendment was completed.',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether the amendment requires formal legal review before execution.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was last modified or updated in the system.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or internal observations related to the amendment.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The original contracted budget amount before the amendment, if the amendment involves budget changes.',
    `original_end_date` DATE COMMENT 'The original contract end date before the amendment, if the amendment involves timeline changes.',
    `original_value` DECIMAL(18,2) COMMENT 'The original contractual value, term, or specification before the amendment (stored as text to accommodate various data types).',
    `requested_by` STRING COMMENT 'Name or identifier of the individual or party who initiated the amendment request.',
    `requested_date` DATE COMMENT 'Date on which the amendment was formally requested by the client or agency.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'The new contracted budget amount after the amendment is applied, if the amendment involves budget changes.',
    `revised_end_date` DATE COMMENT 'The new contract end date after the amendment is applied, if the amendment involves timeline changes.',
    `revised_value` DECIMAL(18,2) COMMENT 'The new contractual value, term, or specification after the amendment is applied (stored as text to accommodate various data types).',
    `version_number` STRING COMMENT 'Version number of the amendment document, incremented with each revision during the draft and approval process.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Formal change record modifying an existing agreement, SOW, or IO — capturing scope changes, budget adjustments, timeline extensions, or term revisions. Each amendment records the parent contract reference, amendment number, change type, original value, revised value, effective date, reason for change, and approval chain. Maintains a complete audit trail of all contractual modifications throughout the agreement lifecycle.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`renewal` (
    `renewal_id` BIGINT COMMENT 'Unique identifier for the contract renewal event record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract being renewed. Links this renewal event to the master agreement.',
    `client_contact_id` BIGINT COMMENT 'Reference to the internal executive or approver who authorized this renewal. Null if no approval was required.',
    `renewal_client_contact_id` BIGINT COMMENT 'Reference to the client contact who has authority to approve or decline the renewal. Key stakeholder for renewal negotiations.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Renewals can be specific to SOWs (renewing a specific scope of work under a master agreement). N:1 relationship (many renewals can relate to one SOW). No reverse FK exists. This allows tracking SOW-le',
    `worker_id` BIGINT COMMENT 'Reference to the agency account manager responsible for managing this renewal process and client relationship.',
    `alert_sent_flag` BOOLEAN COMMENT 'Indicates whether automated renewal alerts (90/60/30-day notifications) were successfully sent to the account team. True if alerts sent, False otherwise.',
    `approval_date` DATE COMMENT 'Date when internal approval was granted for this renewal. Null if no approval was required.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this renewal required executive or legal approval due to value threshold, term length, or risk factors. True if approval required, False otherwise.',
    `auto_renewal_clause_flag` BOOLEAN COMMENT 'Indicates whether the renewed contract includes an automatic renewal clause for the next term. True if auto-renewal is enabled, False if manual renewal required.',
    `churn_risk_flag` BOOLEAN COMMENT 'Indicates whether this renewal was flagged as high churn risk based on client health indicators, payment issues, or competitive threats. True if at-risk, False otherwise.',
    `competitive_threat_flag` BOOLEAN COMMENT 'Indicates whether the renewal process involved known competitive pressure or client evaluation of alternative agencies. True if competitive threat identified, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewal record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this renewal record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `decision_date` DATE COMMENT 'Date when the client or vendor formally communicated their renewal decision (renew, renegotiate, or decline).',
    `effective_date` DATE COMMENT 'Date when the renewed contract terms become binding and the new contract period begins. Typically aligns with the expiration date of the prior term.',
    `negotiation_end_date` DATE COMMENT 'Date when renewal negotiations concluded, either with agreement or termination of discussions.',
    `negotiation_start_date` DATE COMMENT 'Date when formal renewal negotiations began with the client. Marks the transition from renewal notice to active discussion phase.',
    `new_term_end_date` DATE COMMENT 'End date of the renewed contract term. Defines the duration of the new agreement period.',
    `new_term_start_date` DATE COMMENT 'Start date of the renewed contract term. Typically matches renewal_effective_date but may differ if there is a gap or overlap period.',
    `new_term_value` DECIMAL(18,2) COMMENT 'Total contract value of the renewed term, expressed in the contract currency. Captures pricing adjustments, scope changes, or inflationary increases.',
    `notes` STRING COMMENT 'Free-text field for account team notes, client feedback, negotiation highlights, or special considerations related to this renewal event.',
    `notice_date` DATE COMMENT 'Date when the renewal notice was sent to the client or vendor, triggering the renewal evaluation period. Critical for tracking compliance with contractual notice requirements (e.g., 90-day notice clauses).',
    `outcome` STRING COMMENT 'Final result of the renewal process: renewed (client accepted renewal on existing or similar terms), renegotiated (client renewed with material changes), lapsed (client did not respond or declined passively), terminated (client actively ended relationship).. Valid values are `renewed|renegotiated|lapsed|terminated`',
    `pricing_model_change_flag` BOOLEAN COMMENT 'Indicates whether the renewal involved a change to the pricing model (e.g., shift from CPM to CPA, or from fixed fee to performance-based). True if pricing model changed, False otherwise.',
    `prior_term_end_date` DATE COMMENT 'End date of the contract term that is being renewed. Marks the expiration of the prior agreement and the trigger point for renewal evaluation.',
    `prior_term_start_date` DATE COMMENT 'Start date of the contract term that is being renewed. Used to calculate term length and renewal cycle metrics.',
    `prior_term_value` DECIMAL(18,2) COMMENT 'Total contract value of the term being renewed, expressed in the contract currency. Used to calculate renewal rate and revenue retention metrics.',
    `probability_score` DECIMAL(18,2) COMMENT 'Predictive score (0-100) representing the likelihood of successful renewal at the time of renewal notice. Derived from client health metrics, engagement scores, and historical renewal patterns.',
    `reason` STRING COMMENT 'Free-text explanation of the drivers behind the renewal outcome. Captures client feedback, competitive factors, performance issues, or strategic rationale.',
    `renewal_number` STRING COMMENT 'Business-facing identifier for this renewal event, typically formatted as contract number plus renewal sequence (e.g., MSA-2024-001-R2).',
    `renewal_status` STRING COMMENT 'Current lifecycle state of the renewal event: pending (renewal window opened, no action yet), in_negotiation (active discussions), approved (client committed), renewed (executed and effective), lapsed (client did not renew), terminated (client ended relationship), cancelled (renewal process aborted). [ENUM-REF-CANDIDATE: pending|in_negotiation|approved|renewed|lapsed|terminated|cancelled — 7 candidates stripped; promote to reference product]',
    `renewal_type` STRING COMMENT 'Classification of the renewal mechanism: auto (automatic renewal per contract terms), manual (proactive renewal negotiation), renegotiation (renewal with material term changes), amendment (renewal with scope or pricing adjustments).. Valid values are `auto|manual|renegotiation|amendment`',
    `scope_change_flag` BOOLEAN COMMENT 'Indicates whether the renewal involved a change to the scope of services or deliverables (e.g., added channels, reduced markets, new service lines). True if scope changed, False otherwise.',
    `sow_updated_flag` BOOLEAN COMMENT 'Indicates whether the renewal required an updated Statement of Work (SOW) document due to scope, deliverable, or Service Level Agreement (SLA) changes. True if SOW updated, False otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewal record was last modified. Audit field for data lineage and compliance.',
    `value_change_amount` DECIMAL(18,2) COMMENT 'Net change in contract value from prior term to new term (new_term_value minus prior_term_value). Positive values indicate upsell, negative values indicate downsell or discount.',
    `value_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change in contract value from prior term to new term, calculated as (value_change_amount / prior_term_value) * 100. Key metric for renewal pricing analysis.',
    CONSTRAINT pk_renewal PRIMARY KEY(`renewal_id`)
) COMMENT 'Contract renewal event record tracking the lifecycle of agreement renewals — including auto-renewal triggers, manual renewal negotiations, pricing adjustments, and final outcome (renewed, renegotiated, lapsed, terminated). Captures renewal notice date, renewal effective date, prior term value, new term value, renewal type (auto, manual, renegotiation), responsible account manager, and client decision-maker. Supports proactive renewal pipeline management, revenue retention forecasting, and 90/60/30-day renewal alerting workflows.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`compliance_obligation` (
    `compliance_obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement from which this compliance obligation arises.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance obligations are managed and funded by specific cost centers; finance tracks compliance costs for budgeting and regulatory reporting.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Compliance obligations can arise from SOW-specific terms (e.g., data handling requirements for a specific project). N:1 relationship (many obligations can relate to one SOW). No reverse FK exists. Thi',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Compliance obligations can arise from vendor contracts (e.g., data processing addendum requirements, SLA commitments). N:1 relationship (many obligations can relate to one vendor contract). No reverse',
    `audit_frequency` STRING COMMENT 'Frequency at which this compliance obligation is reviewed or audited to ensure ongoing adherence.. Valid values are `annual|semi_annual|quarterly|monthly|on_demand|continuous`',
    `compliance_deadline` DATE COMMENT 'Target date by which the compliance obligation must be fully satisfied or achieved.',
    `compliance_status` STRING COMMENT 'Current compliance status of the obligation indicating whether the requirement is being met, in progress, under review, waived, or not applicable.. Valid values are `compliant|non_compliant|in_progress|pending_review|waived|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the compliance obligation becomes active and enforceable.',
    `escalation_date` DATE COMMENT 'Date when the compliance obligation was escalated to higher authority or governance body.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this compliance obligation requires escalation to senior management, legal counsel, or the board due to its risk or complexity.',
    `evidence_location` STRING COMMENT 'File path, document management system reference, or URL where compliance evidence is stored and accessible for audit purposes.',
    `evidence_required` STRING COMMENT 'Description of the evidence, documentation, or proof required to demonstrate compliance with this obligation (e.g., audit reports, certifications, signed agreements, consent records).',
    `expiration_date` DATE COMMENT 'Date when the compliance obligation expires or is no longer applicable. Null for ongoing obligations.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this compliance obligation is currently active and enforceable (true) or has been archived or superseded (false).',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit or compliance review for this obligation.',
    `next_audit_date` DATE COMMENT 'Date of the next scheduled audit or compliance review for this obligation.',
    `non_compliance_penalty` STRING COMMENT 'Description of the penalties, fines, sanctions, or consequences that may result from failure to meet this compliance obligation.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to the compliance obligation, including historical decisions, exceptions, or special considerations.',
    `obligation_description` STRING COMMENT 'Detailed description of the compliance obligation, including specific requirements, scope, and context.',
    `obligation_number` STRING COMMENT 'Business-facing unique reference number for the compliance obligation, used in communications and reporting.. Valid values are `^OBL-[0-9]{6,10}$`',
    `obligation_title` STRING COMMENT 'Short descriptive title of the compliance obligation for quick identification and reporting.',
    `obligation_type` STRING COMMENT 'Classification of the compliance obligation by its origin and nature (regulatory mandate, contractual commitment, industry standard, certification requirement, data privacy rule, brand safety requirement, disclosure mandate, or consent management). [ENUM-REF-CANDIDATE: regulatory|contractual|industry_standard|certification|data_privacy|brand_safety|disclosure|consent_management — 8 candidates stripped; promote to reference product]',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary value of the potential fine or penalty for non-compliance, if quantifiable.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `priority_level` STRING COMMENT 'Business priority assigned to this compliance obligation based on risk, regulatory impact, and business criticality.. Valid values are `critical|high|medium|low`',
    `regulation_reference` STRING COMMENT 'Specific citation or reference to the regulation, law, standard, or contractual clause that creates this obligation (e.g., GDPR Article 28, CCPA Section 1798.100, IAB TCF v2.0, FTC Act Section 5).',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority, governing body, or standards organization that mandates this obligation (e.g., FTC, GDPR Authority, IAB, ASA, TAG, MRC).',
    `remediation_deadline` DATE COMMENT 'Target date by which remediation actions must be completed to restore compliance.',
    `remediation_owner` STRING COMMENT 'Name or identifier of the individual or team responsible for executing the remediation plan.',
    `remediation_plan` STRING COMMENT 'Description of the action plan or steps required to achieve or restore compliance if the obligation is currently not met.',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual, team, or department responsible for ensuring compliance with this obligation.',
    `responsible_party_email` STRING COMMENT 'Primary email contact for the responsible party overseeing this compliance obligation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `risk_level` STRING COMMENT 'Assessment of the risk exposure if this compliance obligation is not met, considering financial, reputational, and legal consequences.. Valid values are `critical|high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was last modified or updated.',
    CONSTRAINT pk_compliance_obligation PRIMARY KEY(`compliance_obligation_id`)
) COMMENT 'Specific regulatory or contractual compliance obligation arising from an agreement — such as GDPR data processing addenda, CCPA opt-out provisions, IAB TCF consent requirements, TAG brand safety certifications, FTC disclosure mandates, or ASA advertising standards compliance. Captures obligation type, regulatory body, compliance deadline, responsible owner, evidence required, and current compliance status. Enables contract-level regulatory risk management.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'Unique identifier for the vendor contract. Primary key for this entity.',
    `accreditation_id` BIGINT COMMENT 'Foreign key linking to vendor.accreditation. Business justification: Vendor contracts reference required certifications (TAG, MRC, brand safety) as contract conditions. Procurement teams enforce accreditation requirements in vendor_contract terms, trigger compliance re',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Vendor contracts can be governed by master service agreements that set overarching terms. N:1 relationship (many vendor contracts under one master agreement). No reverse FK exists. This links vendor-s',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Production and specialist vendor contracts are often negotiated at brand level, especially for brands with unique production standards (e.g., luxury brands). Enables brand-specific vendor management a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor contracts are managed within specific cost centers for budget control, spend tracking, and vendor management accountability.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Vendor contracts specify default GL accounts for expense posting and accrual management; finance uses this for automated posting and audit trail.',
    `supplier_id` BIGINT COMMENT 'Reference to the third-party vendor, technology partner, or supplier that is the counterparty to this contract.',
    `worker_id` BIGINT COMMENT 'Reference to the internal employee responsible for managing this vendor contract, typically from procurement, finance, or operations.',
    `approval_date` DATE COMMENT 'Date when the vendor contract was formally approved by authorized signatories and became legally binding.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of the term unless explicitly terminated. True if auto-renewal is enabled, False otherwise.',
    `confidentiality_clause` STRING COMMENT 'Text outlining confidentiality obligations, non-disclosure requirements, and data protection responsibilities for both parties.',
    `contract_document_url` STRING COMMENT 'URL or file path to the digitally stored contract document in the Digital Asset Management (DAM) system or document repository.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the vendor contract, typically used in communications and invoicing.. Valid values are `^VC-[0-9]{6,10}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the vendor contract. Tracks progression from draft through approval, active execution, and eventual termination or renewal. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the vendor contract based on the nature of services or products provided. Distinguishes media supply agreements, technology licenses (DSP, SSP, DMP, CDP), production services, and other vendor relationships.. Valid values are `media_supply_agreement|technology_license|production_services|data_services|creative_services|consulting_services`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contract record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_processing_addendum_flag` BOOLEAN COMMENT 'Indicates whether a Data Processing Addendum (DPA) is attached to this contract to comply with GDPR, CCPA, or other privacy regulations. True if DPA is in place, False otherwise.',
    `dispute_resolution_method` STRING COMMENT 'Preferred method for resolving disputes between the agency and vendor, such as arbitration, mediation, or litigation.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `effective_end_date` DATE COMMENT 'Date when the vendor contract expires or terminates. Nullable for open-ended or evergreen agreements.',
    `effective_start_date` DATE COMMENT 'Date when the vendor contract becomes legally binding and services or products may begin to be delivered.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law that applies to the contract (e.g., State of New York, England and Wales). Defines where disputes will be resolved.',
    `indemnification_clause` STRING COMMENT 'Text describing indemnification obligations, specifying which party is responsible for legal claims, intellectual property disputes, or third-party liabilities.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the contract terms. Nullable if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contract record was last updated. Supports audit trail and change tracking.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum financial liability either party may incur under the contract for damages, breaches, or other claims. Nullable if no cap is specified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or internal comments related to the vendor contract.',
    `payment_terms` STRING COMMENT 'Standard payment terms defining when payment is due after invoice receipt or milestone completion. [ENUM-REF-CANDIDATE: net_15|net_30|net_45|net_60|net_90|upon_receipt|prepaid|milestone_based — 8 candidates stripped; promote to reference product]',
    `penalty_clause_description` STRING COMMENT 'Description of financial penalties, service credits, or other remedies applicable if the vendor fails to meet performance guarantees or SLA commitments.',
    `performance_guarantee_description` STRING COMMENT 'Description of any Service Level Agreements (SLAs), Key Performance Indicators (KPIs), or performance guarantees the vendor has committed to meet, including uptime, delivery timelines, or quality metrics.',
    `pricing_model` STRING COMMENT 'Structure defining how the vendor charges for services or products. Includes fixed fees, variable rates, performance incentives, or volume-based discounts. [ENUM-REF-CANDIDATE: fixed_fee|cost_plus|time_and_materials|performance_based|volume_tiered|cpm_based|cpc_based|hybrid — 8 candidates stripped; promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to contract expiration that notice must be given to prevent auto-renewal or to initiate renewal negotiations. Nullable if not applicable.',
    `signed_date` DATE COMMENT 'Date when the contract was signed by both the agency and the vendor. May differ from approval or effective start date.',
    `sla_target_uptime_percent` DECIMAL(18,2) COMMENT 'Target uptime percentage guaranteed by the vendor for technology platforms or services (e.g., 99.9% for DSP or DMP platforms). Nullable if not applicable.',
    `termination_for_cause_clause` STRING COMMENT 'Text describing the conditions under which either party may terminate the contract immediately for cause, such as breach of terms, non-performance, or regulatory violations.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required to terminate the contract without penalty. Defines the minimum notice period for contract exit.',
    `total_committed_spend` DECIMAL(18,2) COMMENT 'Total monetary value committed to the vendor over the contract term. Represents the agencys financial obligation under this agreement.',
    `volume_discount_threshold` DECIMAL(18,2) COMMENT 'Minimum spend or volume level required to trigger volume-based pricing discounts or rebates. Nullable if no volume discounts apply.',
    CONSTRAINT pk_vendor_contract PRIMARY KEY(`vendor_contract_id`)
) COMMENT 'Commercial agreement between the agency and a third-party media vendor, technology partner (DSP, SSP, DMP, CDP), or production supplier. Captures vendor reference, contract type (media supply agreement, technology license, production services), total committed spend, volume discount thresholds, payment terms, termination clauses, and performance guarantees. Distinct from client-facing agreements — governs the agencys supply-side commercial relationships.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`scope_item` (
    `scope_item_id` BIGINT COMMENT 'Unique identifier for the scope item within the contract management system.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or Statement of Work (SOW) that contains this scope item.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to campaign.campaign. Business justification: SOW scope items frequently specify campaign-level services (e.g., Q3 Brand Campaign: 3 video assets, 5 display banners). Linking scope_item→campaign enables traceability from contracted scope to cam',
    `sow_id` BIGINT COMMENT 'Reference to the specific Statement of Work document that defines this scope item.',
    `approval_status` STRING COMMENT 'Approval state of the scope item indicating whether it has been reviewed and approved by authorized stakeholders.. Valid values are `pending|approved|rejected|not_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this scope item.',
    `approved_date` DATE COMMENT 'Date on which this scope item was formally approved.',
    `billable_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this scope item is billable to the client (True) or non-billable (False).',
    `change_order_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this scope item was added via a change order or amendment (True) or was part of the original contract (False).',
    `change_order_number` STRING COMMENT 'Reference number of the change order or amendment that added or modified this scope item, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this scope item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit_rate and total_value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverable_category` STRING COMMENT 'Specific classification of the deliverable type when item_type is deliverable (e.g., Campaign Brief, Media Plan, Creative Assets, Performance Report).',
    `effective_end_date` DATE COMMENT 'The date on which this scope item expires or is no longer in effect, if applicable.',
    `effective_start_date` DATE COMMENT 'The date from which this scope item becomes active and work can commence.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete this scope item, used for resource planning and pricing.',
    `estimated_units` DECIMAL(18,2) COMMENT 'Estimated quantity of units for this scope item when priced on a unit basis (e.g., number of ads, number of reports, number of campaigns).',
    `inclusion_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this item is included in scope (True) or explicitly excluded from scope (False).',
    `item_description` STRING COMMENT 'Detailed description of the work, service, activity, or deliverable covered by this scope item.',
    `item_name` STRING COMMENT 'Short descriptive name or title of the scope item (e.g., Digital Campaign Creative Development, Media Buying Services).',
    `item_number` STRING COMMENT 'Business identifier or line number for the scope item within the contract or SOW (e.g., 1.1, 2.3, A-5).',
    `item_sequence` STRING COMMENT 'Numeric ordering of the scope item within the parent contract or SOW for display and processing purposes.',
    `item_type` STRING COMMENT 'Classification of the scope item indicating whether it represents a service, deliverable, activity, milestone, exclusion, or assumption.. Valid values are `service|deliverable|activity|milestone|exclusion|assumption`',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this scope item record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this scope item record was last modified in the system.',
    `notes` STRING COMMENT 'Additional free-text notes, clarifications, or special instructions related to this scope item.',
    `pricing_model` STRING COMMENT 'The pricing methodology applied to this scope item (e.g., fixed fee, time and materials, retainer, performance-based, cost-plus, unit-based).. Valid values are `fixed_fee|time_and_materials|retainer|performance_based|cost_plus|unit_based`',
    `priority` STRING COMMENT 'Business priority level assigned to this scope item for resource allocation and scheduling purposes.. Valid values are `critical|high|medium|low`',
    `scope_item_status` STRING COMMENT 'Current lifecycle status of the scope item indicating its state in the contract execution process.. Valid values are `draft|active|completed|cancelled|on_hold|amended`',
    `service_category` STRING COMMENT 'High-level categorization of the service or work type covered by this scope item aligned with agency service offerings. [ENUM-REF-CANDIDATE: creative|media_planning|media_buying|strategy|analytics|production|account_management|digital_marketing|public_relations|brand_strategy — 10 candidates stripped; promote to reference product]',
    `sla_target_days` STRING COMMENT 'Number of days within which this scope item or deliverable must be completed per the agreed Service Level Agreement.',
    `total_value` DECIMAL(18,2) COMMENT 'Total contracted value for this scope item calculated as estimated_units multiplied by unit_rate, or as a fixed fee.',
    `unit_of_measure` STRING COMMENT 'The unit by which this scope item is measured and priced (e.g., hour, campaign, asset, report, month).',
    `unit_rate` DECIMAL(18,2) COMMENT 'Agreed price per unit for this scope item in the contract currency.',
    `created_by` STRING COMMENT 'Name or identifier of the user who created this scope item record.',
    CONSTRAINT pk_scope_item PRIMARY KEY(`scope_item_id`)
) COMMENT 'Granular in-scope or out-of-scope work item defined within a SOW or agreement — specifying individual services, activities, or deliverable categories included in or excluded from the contracted engagement. Captures scope item description, inclusion/exclusion flag, estimated hours or units, agreed unit rate, total value, and change history. Enables precise scope management and out-of-scope billing identification.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`contract_milestone` (
    `contract_milestone_id` BIGINT COMMENT 'Unique identifier for the contractual milestone record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent agreement or Statement of Work (SOW) to which this milestone belongs.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to campaign.campaign. Business justification: Agency SOWs often include campaign launch milestones (e.g., Campaign Go-Live, Creative Approval). Linking milestone→campaign enables project managers to track campaign readiness, gate payments to ',
    `initiative_id` BIGINT COMMENT 'External identifier linking this milestone to the corresponding project or task in Workfront project management system for resource planning and tracking integration.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Milestones can be defined within a Statement of Work (not just at agreement level). N:1 relationship (many milestones can belong to one SOW). No reverse FK exists. This allows milestones to be scoped ',
    `acceptance_criteria` STRING COMMENT 'Specific, measurable criteria that must be met for the milestone to be considered complete and accepted by the client.',
    `actual_completion_date` DATE COMMENT 'Date when the milestone was actually completed or achieved. Null if milestone is not yet completed.',
    `approval_date` DATE COMMENT 'Date when the milestone completion was formally approved or accepted by the client or designated authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the client stakeholder or internal approver who signed off on milestone completion.',
    `baseline_date` DATE COMMENT 'Approved baseline date for milestone completion, used for variance analysis and performance tracking. May differ from planned_date if the project has been re-baselined.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this milestone is on the project critical path (True), meaning any delay will impact the overall project completion date, or not (False).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deliverable_description` STRING COMMENT 'Detailed description of the deliverable(s) or work product(s) associated with this milestone, including acceptance criteria and quality standards.',
    `dependency_milestone_ids` STRING COMMENT 'Comma-separated list of milestone_id values representing predecessor milestones that must be completed before this milestone can begin or be completed.',
    `invoice_number` STRING COMMENT 'Reference to the invoice generated as a result of this milestone completion, if applicable. Null if milestone has not triggered invoicing or is not a payment trigger.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was most recently updated.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone (e.g., Creative Concept Approval, Campaign Launch, Final Deliverable Acceptance).',
    `milestone_number` STRING COMMENT 'Business-readable identifier for the milestone, often used in client communications and invoicing (e.g., M-001, MS-2023-Q1-01).',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone: planned (not yet started), in_progress (work underway), completed (milestone achieved), delayed (past due date), cancelled (no longer applicable), or on_hold (temporarily suspended).. Valid values are `planned|in_progress|completed|delayed|cancelled|on_hold`',
    `milestone_type` STRING COMMENT 'Classification of the milestone indicating its purpose in the engagement lifecycle: payment trigger (invoice generation), phase gate (project stage transition), deliverable acceptance (client sign-off), go-live (campaign launch), creative review (creative approval checkpoint), or final acceptance (project closure).. Valid values are `payment_trigger|phase_gate|deliverable_acceptance|go_live|creative_review|final_acceptance`',
    `notes` STRING COMMENT 'Free-form text field for additional context, comments, or special instructions related to this milestone, including reasons for delays, scope changes, or client feedback.',
    `owner_name` STRING COMMENT 'Name of the internal team member or project manager responsible for ensuring this milestone is completed on time and meets acceptance criteria.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount associated with this milestone if it is a payment trigger. Null if milestone does not trigger payment or uses percentage-based calculation.',
    `payment_percentage` DECIMAL(18,2) COMMENT 'Percentage of total contract value to be paid upon milestone completion (e.g., 25.00 for 25%). Null if milestone uses fixed payment_amount or does not trigger payment.',
    `payment_trigger_flag` BOOLEAN COMMENT 'Indicates whether completion of this milestone triggers a payment or invoice generation event (True) or not (False).',
    `planned_date` DATE COMMENT 'Originally scheduled date for milestone completion as defined in the SOW or project plan.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue associated with this milestone is recognized in financial statements, per ASC 606 / IFRS 15 revenue recognition standards.',
    `risk_level` STRING COMMENT 'Assessment of risk associated with achieving this milestone on time and within scope: low (minimal risk), medium (some concerns), high (significant challenges), or critical (major impediments identified).. Valid values are `low|medium|high|critical`',
    `sequence_number` STRING COMMENT 'Ordinal position of this milestone within the parent agreement or SOW, used to establish chronological order and dependencies.',
    `variance_days` STRING COMMENT 'Number of days between planned_date and actual_completion_date. Positive values indicate delay; negative values indicate early completion. Null if milestone is not yet completed.',
    CONSTRAINT pk_contract_milestone PRIMARY KEY(`contract_milestone_id`)
) COMMENT 'Contractual milestone record tied to a SOW or agreement — representing a scheduled checkpoint, payment trigger, or deliverable acceptance gate in the engagement lifecycle. Captures milestone name, sequence number, planned date, actual completion date, milestone type (payment trigger, phase gate, go-live, creative review, final acceptance), associated payment amount or percentage, dependencies, and completion status. Supports project billing schedules, revenue recognition triggers, and Workfront project tracking integration.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`contract_template` (
    `contract_template_id` BIGINT COMMENT 'Unique identifier for the contract template record. Primary key.',
    `derived_from_contract_template_id` BIGINT COMMENT 'Self-referencing FK on contract_template (derived_from_contract_template_id)',
    `applicable_client_tier` STRING COMMENT 'Client segmentation tier for which this template is designed. Ensures appropriate terms and pricing structures are applied based on client size and strategic importance.. Valid values are `enterprise|mid-market|small business|startup|all tiers`',
    `approval_date` DATE COMMENT 'Date on which the template received legal and compliance approval.',
    `approval_status` STRING COMMENT 'Legal and compliance approval status of the template. Only approved templates may be used in production contract generation.. Valid values are `pending|approved|rejected|expired`',
    `approved_by` STRING COMMENT 'Name or identifier of the legal authority or compliance officer who approved the template for use.',
    `auto_renewal_clause_flag` BOOLEAN COMMENT 'Indicates whether the template includes an automatic renewal clause. True if auto-renewal language is present, false otherwise.',
    `clause_library_reference` STRING COMMENT 'Reference identifier or URL to the pre-approved clause library or playbook that this template draws from. Supports traceability to approved legal language.',
    `compliance_framework` STRING COMMENT 'Comma-separated list of regulatory and compliance frameworks addressed in the template (e.g., GDPR, CCPA, IAB standards, TAG certification requirements).',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the template includes confidentiality and non-disclosure provisions. True if confidentiality language is present, false otherwise.',
    `contract_template_description` STRING COMMENT 'Detailed description of the templates purpose, scope, and intended use cases. Guides account teams and legal staff in selecting the appropriate template.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the template record was first created in the system.',
    `document_storage_url` STRING COMMENT 'URL or file path to the master template document stored in the document management system or Digital Asset Management (DAM) platform.',
    `effective_end_date` DATE COMMENT 'Date after which the template is no longer valid for new contract creation. Null for templates with indefinite validity.',
    `effective_start_date` DATE COMMENT 'Date from which the template becomes available for use in contract creation. Supports phased rollout of new template versions.',
    `format` STRING COMMENT 'File format of the template document. Determines compatibility with contract generation and document automation systems.. Valid values are `Word|PDF|HTML|XML|JSON`',
    `geographic_scope` STRING COMMENT 'Geographic regions or jurisdictions for which this template is designed, using ISO 3166-1 alpha-3 country codes or regional identifiers. Ensures compliance with local legal and regulatory requirements.',
    `governing_law` STRING COMMENT 'Default jurisdiction and legal framework specified in the template (e.g., New York law, English law). May be overridden in specific agreements.',
    `indemnity_clause_flag` BOOLEAN COMMENT 'Indicates whether the template includes indemnification provisions. True if indemnity language is present, false otherwise.',
    `industry_vertical_applicability` STRING COMMENT 'Comma-separated list of industry verticals (e.g., retail, healthcare, financial services) for which this template is optimized. Supports industry-specific compliance and terminology requirements.',
    `last_review_date` DATE COMMENT 'Date of the most recent legal or compliance review of the template. Used to track review currency and trigger periodic re-reviews.',
    `liability_cap_flag` BOOLEAN COMMENT 'Indicates whether the template includes a limitation of liability clause. True if liability cap language is present, false otherwise.',
    `modified_by` STRING COMMENT 'Name or identifier of the user or system that last modified the template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the template record was last modified in the system.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic legal or compliance review of the template. Ensures templates remain current with regulatory changes.',
    `notes` STRING COMMENT 'Free-form notes and comments about the template, including usage guidance, known limitations, or special considerations.',
    `owning_legal_team` STRING COMMENT 'Name or identifier of the legal team or department responsible for maintaining and updating this template.',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between scheduled reviews of the template. Supports proactive template maintenance and compliance.',
    `self_service_enabled_flag` BOOLEAN COMMENT 'Indicates whether account teams are authorized to use this template without legal review for standard deals. True if self-service is permitted, false if legal review is required.',
    `sla_included_flag` BOOLEAN COMMENT 'Indicates whether the template includes service level agreement provisions. True if SLA language is present, false otherwise.',
    `standard_payment_terms_days` STRING COMMENT 'Default payment terms in days (e.g., Net 30, Net 60) specified in the template. May be negotiated in individual agreements.',
    `standard_pricing_model` STRING COMMENT 'Default pricing structure embedded in the template. Guides account teams in structuring commercial terms.. Valid values are `fixed fee|time and materials|retainer|performance-based|commission|hybrid`',
    `template_name` STRING COMMENT 'Human-readable name of the contract template, describing its purpose and scope.',
    `template_number` STRING COMMENT 'Business-facing unique identifier or code for the template, used for reference in legal operations and contract management systems.',
    `template_status` STRING COMMENT 'Current lifecycle status of the template. Only approved or active templates may be used for new agreement creation.. Valid values are `draft|under review|approved|active|deprecated|archived`',
    `template_type` STRING COMMENT 'Classification of the template by agreement type. Determines which contract lifecycle stage and legal framework the template supports.. Valid values are `MSA template|SOW template|IO template|NDA template|Amendment template|Rate card template`',
    `termination_notice_period_days` STRING COMMENT 'Standard number of days notice required for contract termination as specified in the template.',
    `usage_count` STRING COMMENT 'Number of times this template has been used to generate actual agreements. Supports template effectiveness analysis and optimization.',
    `version_number` STRING COMMENT 'Version identifier for the template, following organizational versioning conventions (e.g., 1.0, 2.1). Incremented with each substantive revision.',
    `created_by` STRING COMMENT 'Name or identifier of the user or system that created the template record.',
    CONSTRAINT pk_contract_template PRIMARY KEY(`contract_template_id`)
) COMMENT 'Reusable contract template or playbook defining pre-approved clause libraries, standard terms, pricing structures, and document frameworks used to accelerate new agreement creation. Captures template name, template type (MSA template, SOW template, IO template, NDA template), version, approval status, owning legal team, applicable client tier, industry vertical applicability, and last review date. Enables legal operations to maintain governance over contract language while empowering account teams to self-serve standard agreements. Supports compliance with approved clause requirements and reduces legal review cycle time.';

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`vendor_agreement` (
    `vendor_agreement_id` BIGINT COMMENT 'Unique identifier for this vendor agreement association record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to the master commercial agreement record',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier/vendor master record',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this vendor-specific agreement automatically renews at expiry. May differ from master agreement auto-renewal settings for individual vendor relationships.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this vendor-specific agreement. May differ from master agreement currency for international vendor relationships.',
    `effective_date` DATE COMMENT 'Date when this vendor-specific agreement becomes legally binding and enforceable. May differ from the master agreement effective date when vendors are added to an existing MSA.',
    `expiry_date` DATE COMMENT 'Date when this vendor-specific agreement terminates. May differ from the master agreement expiry date for phased vendor onboarding/offboarding.',
    `payment_terms` STRING COMMENT 'Supplier-specific payment terms negotiated under this agreement (e.g., Net 30, Net 60, prepayment required). May differ from standard supplier payment terms or master agreement defaults.',
    `performance_tier` STRING COMMENT 'Supplier performance classification under this agreement based on historical delivery, compliance, and relationship quality. Drives preferential treatment, volume commitments, or probationary status.',
    `pricing_model` STRING COMMENT 'Commercial pricing structure for this supplier under this agreement. CPM = Cost Per Mille, CPC = Cost Per Click, CPA = Cost Per Acquisition, CPV = Cost Per View. Different suppliers within the same MSA may have different pricing models.',
    `signed_date` DATE COMMENT 'Date when this vendor-specific agreement or addendum was executed by all parties.',
    `sla_target` STRING COMMENT 'Service Level Agreement performance target specific to this supplier under this agreement. Examples: 99.9% uptime, 24-hour response time, viewability threshold, brand safety score minimum.',
    `total_committed_spend` DECIMAL(18,2) COMMENT 'Total monetary value committed to this specific supplier under this agreement over the full term. Represents the supplier-specific spend commitment within a multi-vendor MSA.',
    `vendor_agreement_status` STRING COMMENT 'Current lifecycle status of this vendor-specific agreement. Allows individual vendor relationships to be suspended or terminated while the master agreement remains active with other vendors.',
    CONSTRAINT pk_vendor_agreement PRIMARY KEY(`vendor_agreement_id`)
) COMMENT 'This association product represents the contractual relationship between a commercial agreement and a supplier/vendor. It captures supplier-specific commercial terms, pricing models, spend commitments, and performance targets that exist only in the context of a specific agreement-supplier pairing. Each record links one agreement to one supplier with relationship-specific attributes such as effective dates, committed spend, pricing structure, payment terms, and SLA targets. This enables master service agreements (MSAs) to cover multiple vendors with distinct terms per vendor, and allows suppliers to participate in multiple agreements across different agency entities or advertiser subsidiaries.. Existence Justification: In advertising agency operations, master service agreements (MSAs) frequently cover multiple media vendors or technology platform suppliers with distinct commercial terms per vendor—different pricing models (CPM vs. fixed fee), spend commitments, SLA targets, and payment terms. Conversely, large suppliers (e.g., Google, Meta, Comcast) maintain separate agreements with multiple agency entities, advertiser subsidiaries, or holding company divisions. The business actively manages these vendor agreements as distinct contractual relationships, tracking supplier-specific performance, spend pacing, and compliance within the context of each agreement.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `advertising_ecm`.`contract`.`contract_template`(`contract_template_id`);
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_parent_agreement_id` FOREIGN KEY (`parent_agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `advertising_ecm`.`contract`.`contract_template`(`contract_template_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`contract`.`term` ADD CONSTRAINT `fk_contract_term_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`term` ADD CONSTRAINT `fk_contract_term_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `advertising_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ADD CONSTRAINT `fk_contract_rate_card_line_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ADD CONSTRAINT `fk_contract_rfp_response_contract_template_id` FOREIGN KEY (`contract_template_id`) REFERENCES `advertising_ecm`.`contract`.`contract_template`(`contract_template_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ADD CONSTRAINT `fk_contract_rfp_response_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_superseded_by_amendment_id` FOREIGN KEY (`superseded_by_amendment_id`) REFERENCES `advertising_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `advertising_ecm`.`contract`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ADD CONSTRAINT `fk_contract_vendor_contract_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ADD CONSTRAINT `fk_contract_scope_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ADD CONSTRAINT `fk_contract_scope_item_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ADD CONSTRAINT `fk_contract_contract_template_derived_from_contract_template_id` FOREIGN KEY (`derived_from_contract_template_id`) REFERENCES `advertising_ecm`.`contract`.`contract_template`(`contract_template_id`);
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ADD CONSTRAINT `fk_contract_vendor_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `advertising_ecm`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `account_team_id` SET TAGS ('dbx_business_glossary_term' = 'Account Team Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `parent_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'Client|Vendor|Partner');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `deliverables_summary` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Summary');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'Litigation|Arbitration|Mediation');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `document_storage_url` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `document_storage_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `indemnity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Clause Flag');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `performance_bonus_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Bonus Clause Flag');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `scope_of_work_description` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work (SOW) Description');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `sla_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Included Flag');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `total_committed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Value');
ALTER TABLE `advertising_ecm`.`contract`.`sow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`sow` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Client Contact Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Agency Contact Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_client_advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `agency_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Fee Amount');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'fixed_fee|time_and_materials|retainer|commission|performance_based|hybrid');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `deliverables_summary` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Summary');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `intellectual_property_ownership` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `intellectual_property_ownership` SET TAGS ('dbx_value_regex' = 'client|agency|shared|work_for_hire');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Frequency');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|upon_completion|weekly|biweekly');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `media_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Media Budget Amount');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `performance_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bonus Amount');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `performance_bonus_criteria` SET TAGS ('dbx_business_glossary_term' = 'Performance Bonus Criteria');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `production_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Amount');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sla_deliverable_turnaround_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Deliverable Turnaround Days');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_description` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Description');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_number` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Number');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_number` SET TAGS ('dbx_value_regex' = '^SOW-[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_status` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Status');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_type` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Type');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Title');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order (IO) Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Media Vendor Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Rate Percentage');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `buying_method` SET TAGS ('dbx_business_glossary_term' = 'Buying Method');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `buying_method` SET TAGS ('dbx_value_regex' = 'direct|programmatic_guaranteed|programmatic_non_guaranteed|RTB|private_marketplace|preferred_deal');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `committed_clicks` SET TAGS ('dbx_business_glossary_term' = 'Committed Clicks');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `committed_conversions` SET TAGS ('dbx_business_glossary_term' = 'Committed Conversions');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `committed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Committed Impressions');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `io_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Approved Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `io_name` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Name');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `io_number` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Number');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `io_number` SET TAGS ('dbx_value_regex' = '^IO-[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `io_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Signed Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `io_status` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Status');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `io_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Submitted Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `io_type` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Type');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `io_type` SET TAGS ('dbx_value_regex' = 'standard|programmatic|direct|guaranteed|non_guaranteed|preferred_deal');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `make_good_policy` SET TAGS ('dbx_business_glossary_term' = 'Make Good Policy');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `media_channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Notes');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|prepay|upon_receipt|custom');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `placement_specifications` SET TAGS ('dbx_business_glossary_term' = 'Placement Specifications');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `third_party_ad_serving_fee` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Ad Serving Fee Amount');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `total_authorized_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Authorized Spend Amount');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `trafficking_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Contact Email Address');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `trafficking_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `trafficking_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `trafficking_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `trafficking_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Contact Name');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `trafficking_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `trafficking_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`term` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`term` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|upon_request|not_specified');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `clause_category` SET TAGS ('dbx_business_glossary_term' = 'Clause Category');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `clause_category` SET TAGS ('dbx_value_regex' = 'legal|commercial|operational|compliance|financial|technical');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `clause_summary` SET TAGS ('dbx_business_glossary_term' = 'Clause Summary');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `clause_text` SET TAGS ('dbx_business_glossary_term' = 'Clause Text');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `clause_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `clause_title` SET TAGS ('dbx_business_glossary_term' = 'Clause Title');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `clause_type` SET TAGS ('dbx_business_glossary_term' = 'Clause Type');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `confidentiality_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Duration Years');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `indemnification_scope` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Scope');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `intellectual_property_ownership` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `intellectual_property_ownership` SET TAGS ('dbx_value_regex' = 'client|agency|joint|work_for_hire|licensed');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `last_amended_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amended Date');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Currency');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `liability_cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `negotiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Flag');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|electronic_funds_transfer');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `payment_term_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Days');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `penalty_provision` SET TAGS ('dbx_business_glossary_term' = 'Penalty Provision');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `penalty_provision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Term Sequence');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `service_level_metric` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `service_level_target` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `standard_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Standard Clause Flag');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `term_number` SET TAGS ('dbx_business_glossary_term' = 'Term Number');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` SET TAGS ('dbx_subdomain' = 'scope_delivery');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `flowchart_id` SET TAGS ('dbx_business_glossary_term' = 'Media Flowchart Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `billable_amount` SET TAGS ('dbx_business_glossary_term' = 'Billable Amount');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `client_feedback` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `contract_deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `contract_deliverable_status` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Status');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `deliverable_code` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Code');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `deliverable_name` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Name');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|file_share|dam_platform|physical_delivery|client_portal|ftp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `requires_client_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Client Approval');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`contract`.`sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`sla` SET TAGS ('dbx_subdomain' = 'scope_delivery');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `baseline_measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Baseline Measurement Period');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `baseline_performance` SET TAGS ('dbx_business_glossary_term' = 'Baseline Performance');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `breach_threshold` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `breach_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold Unit');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `breach_threshold_unit` SET TAGS ('dbx_value_regex' = 'hours|business_days|calendar_days|percentage|minutes|count');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `client_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Client Acceptance Date');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `compliance_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tracking Enabled');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'per_transaction|daily|weekly|monthly|quarterly|annual');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'hours|business_days|calendar_days|percentage|minutes|count');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `penalty_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Penalty Mechanism');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `penalty_mechanism` SET TAGS ('dbx_value_regex' = 'service_credit|fee_reduction|termination_right|penalty_payment|none');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `remediation_terms` SET TAGS ('dbx_business_glossary_term' = 'Remediation Terms');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `reporting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reporting Schedule');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `reporting_schedule` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|terminated|draft|under_review');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'creative_turnaround|campaign_go_live|reporting_delivery|platform_uptime|trafficking_response|client_approval');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` SET TAGS ('dbx_subdomain' = 'pricing_terms');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `contract_rate_card_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Status');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Rate Card');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `is_negotiable` SET TAGS ('dbx_business_glossary_term' = 'Is Negotiable');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `maximum_rate` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rate');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `minimum_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rate');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Notes');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Number');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_value_regex' = '^RC-[A-Z0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `rate_card_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Type');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `rate_card_type` SET TAGS ('dbx_value_regex' = 'agency_services|media_inventory|production|vendor_services|commission|hybrid');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `rate_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Category');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `role_level` SET TAGS ('dbx_business_glossary_term' = 'Role Level');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^v?d+.d+(.d+)?$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` SET TAGS ('dbx_subdomain' = 'pricing_terms');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `rate_card_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Line Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `is_retainer_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Retainer Eligible Flag');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `line_item_code` SET TAGS ('dbx_business_glossary_term' = 'Line Item Code');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `line_item_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|superseded');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `maximum_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Commitment Quantity');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `minimum_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Quantity');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `overage_rate` SET TAGS ('dbx_business_glossary_term' = 'Overage Rate');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `seniority_level` SET TAGS ('dbx_value_regex' = 'junior|mid_level|senior|principal|executive');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'creative_services|media_planning|media_buying|account_management|strategy_consulting|production');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `volume_tier_threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold Maximum');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `volume_tier_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Threshold Minimum');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `rfp_response_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Response Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `last_modified_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `last_modified_by_user_worker_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `last_modified_by_user_worker_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Client ID');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `primary_rfp_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Pitch Team Lead ID');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Agreement ID');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `worker_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `worker_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `client_feedback` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `client_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `client_industry` SET TAGS ('dbx_business_glossary_term' = 'Client Industry');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `competitive_intelligence_notes` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intelligence Notes');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `competitive_intelligence_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `estimated_contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Duration Months');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `internal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `no_bid_reason` SET TAGS ('dbx_business_glossary_term' = 'No Bid Reason');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `pitch_team_members` SET TAGS ('dbx_business_glossary_term' = 'Pitch Team Members');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `presentation_location` SET TAGS ('dbx_business_glossary_term' = 'Presentation Location');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `probability_of_win_percent` SET TAGS ('dbx_business_glossary_term' = 'Probability of Win Percent');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `proposed_budget_max` SET TAGS ('dbx_business_glossary_term' = 'Proposed Budget Maximum');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `proposed_budget_min` SET TAGS ('dbx_business_glossary_term' = 'Proposed Budget Minimum');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `proposed_scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Proposed Scope Summary');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `proposed_services` SET TAGS ('dbx_business_glossary_term' = 'Proposed Services');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `response_document_url` SET TAGS ('dbx_business_glossary_term' = 'Response Document URL');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `response_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'draft|internal_review|submitted|shortlisted|won|lost');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `rfp_received_date` SET TAGS ('dbx_business_glossary_term' = 'RFP (Request for Proposal) Received Date');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `rfp_reference_number` SET TAGS ('dbx_business_glossary_term' = 'RFP (Request for Proposal) Reference Number');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `rfp_type` SET TAGS ('dbx_business_glossary_term' = 'RFP (Request for Proposal) Type');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `rfp_type` SET TAGS ('dbx_value_regex' = 'rfp|rfi|rfq|pitch_invitation|tender|proposal_request');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `win_loss_category` SET TAGS ('dbx_business_glossary_term' = 'Win Loss Category');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `win_loss_category` SET TAGS ('dbx_value_regex' = 'pricing|creative_approach|team_expertise|strategic_fit|incumbent_advantage|timing');
ALTER TABLE `advertising_ecm`.`contract`.`rfp_response` ALTER COLUMN `win_loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Win Loss Reason');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `superseded_by_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `agency_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Signatory Name');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `agency_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Agency Signatory Title');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|executed|rejected|superseded');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'scope_change|budget_adjustment|timeline_extension|term_revision|pricing_modification|deliverable_change');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `budget_delta_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Delta Amount');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Name');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `client_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Title');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Expiration Date');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `legal_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Contract End Date');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `original_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Requested Date');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `revised_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract End Date');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `revised_value` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract Value');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Contact Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Decision Maker Contact Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `alert_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Alert Sent Flag');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `auto_renewal_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Clause Flag');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `churn_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Flag');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `competitive_threat_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Threat Flag');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `negotiation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation End Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `new_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'New Term End Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `new_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'New Term Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `new_term_value` SET TAGS ('dbx_business_glossary_term' = 'New Term Value');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'renewed|renegotiated|lapsed|terminated');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `pricing_model_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Change Flag');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `prior_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Term End Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `prior_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Term Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `prior_term_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Term Value');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `probability_score` SET TAGS ('dbx_business_glossary_term' = 'Renewal Probability Score');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reason');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Number');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto|manual|renegotiation|amendment');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `scope_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Flag');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `sow_updated_flag` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Updated Flag');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `value_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Value Change Amount');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `value_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Value Change Percentage');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` SET TAGS ('dbx_subdomain' = 'pricing_terms');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|on_demand|continuous');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|pending_review|waived|not_applicable');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Storage Location');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence or Documentation Required');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `non_compliance_penalty` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Penalty or Consequence');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference Number');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_value_regex' = '^OBL-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation or Standard Reference');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body or Authority');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party or Owner');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^VC-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'media_supply_agreement|technology_license|production_services|data_services|creative_services|consulting_services');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `data_processing_addendum_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Addendum (DPA) Flag');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `indemnification_clause` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Clause');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `penalty_clause_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Description');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `performance_guarantee_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Description');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `sla_target_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Uptime Percent');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `termination_for_cause_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Clause');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Spend');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `volume_discount_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Threshold');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_contract` ALTER COLUMN `volume_discount_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` SET TAGS ('dbx_subdomain' = 'scope_delivery');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `scope_item_id` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `change_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `deliverable_category` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Category');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `estimated_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Units');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Flag');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Description');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Name');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Number');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `item_sequence` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Sequence');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Type');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `item_type` SET TAGS ('dbx_value_regex' = 'service|deliverable|activity|milestone|exclusion|assumption');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Notes');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'fixed_fee|time_and_materials|retainer|performance_based|cost_plus|unit_based');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Priority');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `scope_item_status` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Status');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `scope_item_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|cancelled|on_hold|amended');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Scope Item Value');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`scope_item` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` SET TAGS ('dbx_subdomain' = 'scope_delivery');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Workfront Project Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Completion Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `dependency_milestone_ids` SET TAGS ('dbx_business_glossary_term' = 'Dependency Milestone Identifiers (IDs)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Number');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|delayed|cancelled|on_hold');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'payment_trigger|phase_gate|deliverable_acceptance|go_live|creative_review|final_acceptance');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Owner Name');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `payment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Payment Percentage');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `payment_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Trigger Flag');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `advertising_ecm`.`contract`.`contract_milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Variance Days');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `derived_from_contract_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `applicable_client_tier` SET TAGS ('dbx_business_glossary_term' = 'Applicable Client Tier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `applicable_client_tier` SET TAGS ('dbx_value_regex' = 'enterprise|mid-market|small business|startup|all tiers');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `auto_renewal_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Clause Flag');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `clause_library_reference` SET TAGS ('dbx_business_glossary_term' = 'Clause Library Reference');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `contract_template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `document_storage_url` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Template Format');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'Word|PDF|HTML|XML|JSON');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `indemnity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Clause Flag');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `industry_vertical_applicability` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical Applicability');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `liability_cap_flag` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Flag');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `owning_legal_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Legal Team');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `self_service_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Service Enabled Flag');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `sla_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Included Flag');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `standard_payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Payment Terms (Days)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `standard_pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Standard Pricing Model');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `standard_pricing_model` SET TAGS ('dbx_value_regex' = 'fixed fee|time and materials|retainer|performance-based|commission|hybrid');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `template_number` SET TAGS ('dbx_business_glossary_term' = 'Template Number');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'draft|under review|approved|active|deprecated|archived');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `template_type` SET TAGS ('dbx_value_regex' = 'MSA template|SOW template|IO template|NDA template|Amendment template|Rate card template');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`contract`.`contract_template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` SET TAGS ('dbx_association_edges' = 'contract.agreement,vendor.supplier');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement ID');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement - Agreement Id');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement - Supplier Id');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `sla_target` SET TAGS ('dbx_business_glossary_term' = 'SLA Target');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Spend');
ALTER TABLE `advertising_ecm`.`contract`.`vendor_agreement` ALTER COLUMN `vendor_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Status');
