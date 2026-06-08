-- Schema for Domain: contract | Business: Advertising | Version: v1_mvm
-- Generated on: 2026-05-08 03:52:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`contract` COMMENT 'SSOT for all commercial agreements between the agency and its clients or media vendors — including MSAs, SOWs, RFP/RFI responses, IOs, and vendor contracts. Manages terms, pricing models, deliverables, SLAs, renewal cycles, scope, and contract compliance. Supports Proposal Development and Pitching and Budget Management processes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the commercial agreement. Primary key for the agreement entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client advertiser party to this agreement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Master service agreements are budgeted and tracked against specific cost centers for P&L management, overhead allocation, and profitability analysis in agency operations.',
    `parent_agreement_id` BIGINT COMMENT 'Reference to the parent or master agreement if this is a child agreement (e.g., SOW under an MSA, Amendment to an IO). Nullable for top-level agreements.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Master Service Agreements in advertising are negotiated with specific vendors/suppliers. Linking agreement.supplier_id enables vendor contract portfolio management, renewal tracking, and compliance re',
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
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: SOWs are executed under a specific agency-client AOR relationship governing commission rates, scope, and approval workflows. Linking SOW to agency_relationship enables relationship-level SOW tracking ',
    `agreement_id` BIGINT COMMENT 'Reference to the parent Master Service Agreement under which this SOW is executed. Null if this is a standalone SOW without a parent MSA.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: SOWs in advertising are scoped to a specific brand — media budgets, deliverables, and fee structures are brand-specific. Brand-level SOW reporting and budget reconciliation require this link. A domain',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: A Statement of Work may reference a specific rate card that governs the pricing for its deliverables and services. While the rate card is linked to the parent agreement, different SOWs under the same ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SOWs are executed within cost center budgets; finance tracks SOW spend by cost center for profitability analysis and resource allocation decisions.',
    `advertiser_id` BIGINT COMMENT 'Reference to the specific advertiser entity under the client organization. May differ from client_id in holding company structures.',
    `sow_client_advertiser_id` BIGINT COMMENT 'Reference to the client or advertiser for whom this SOW is executed. Links to the client master record.',
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
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: IOs in advertising are executed under a specific agency-client relationship governing commission rates, approval workflows, and billing. Agency-relationship-level IO spend reporting and commission rec',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Media insertion orders in advertising execute at brand level within advertisers. Tracking which brand each IO supports is essential for brand-level budget allocation, pacing reports, media mix analysi',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign for which this insertion order authorizes media spend.',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: An Insertion Order authorizes media spend at specific rates. While the IO captures execution-specific rate_amount and rate_type fields (which are kept as IO-specific overrides), linking to the governi',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: IOs authorize media spend against approved campaign budgets; budget management requires linking IO commitments to budgets for spend control and variance reporting.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent master service agreement or contract under which this insertion order is executed.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Contract IOs and media IOs represent the same business artifact from contract management vs. media execution perspectives. Linking enables reconciliation between contract commitments and media executi',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Insertion Orders are often executed under a specific Statement of Work that defines the scope and deliverables. N:1 relationship (many IOs can be under one SOW). No reverse FK exists. This links media',
    `supplier_id` BIGINT COMMENT 'Reference to the publisher or media vendor with whom this insertion order establishes a media buying commitment.',
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
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: Terms and conditions clauses can be attached to specific Insertion Orders (e.g., IO-specific cancellation terms, make-good provisions, trafficking requirements). While term already links to agreement ',
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
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Contractual deliverables are frequently added, modified, or removed via amendments (scope changes). Adding amendment_id to contract_deliverable links each deliverable to the amendment that introduced ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Creative deliverables (ads, videos, copy) are produced for specific brands. Brand guidelines compliance, brand safety review, digital asset management, and brand portfolio reporting all require knowin',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign or project to which this deliverable is associated, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deliverables consume resources from specific cost centers; finance tracks actual costs by deliverable for margin analysis and cost center performance reporting.',
    `asset_id` BIGINT COMMENT 'The identifier of the final deliverable asset stored in the Digital Asset Management (DAM) system.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Contract deliverables are tracked in project management systems as initiatives/projects. Currently workfront_project_id is stored as an unlinked string. Normalizing to initiative_id FK enables joining',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Each contractual deliverable may be governed by a specific SLA defining its turnaround time, quality standard, revision cycle, or acceptance criteria. While contract_deliverable already has acceptance',
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
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: SLAs in advertising frequently govern specific media buys at the IO level — e.g., impression delivery guarantees, viewability thresholds, brand safety commitments tied to a specific publisher IO. Whil',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SLA performance is tracked by the cost center responsible for delivery; finance monitors SLA compliance costs and penalty exposure.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Service Level Agreements can be defined at SOW level with specific performance commitments for that scope of work. N:1 relationship (many SLAs can belong to one SOW). No reverse FK exists. This allows',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: SLAs in advertising are negotiated with specific vendors (ad servers, publishers, DSPs). Linking sla.supplier_id enables vendor SLA breach tracking, penalty enforcement, and supplier performance repor',
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
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: Rate cards are channel-scoped (e.g., a digital rate card vs. broadcast rate card). Linking contract_rate_card to ad_channel enables channel-specific rate card lookup during media planning and buying. ',
    `advertiser_id` BIGINT COMMENT 'Foreign key linking to client.advertiser. Business justification: Rate cards in advertising are negotiated per advertiser. Direct advertiser-level rate card linkage enables advertiser pricing governance, rate card audits, and pricing reports without joining through ',
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: Rate cards are negotiated as part of the agency-client relationship and govern fees across all work under that relationship. Linking rate card to agency_relationship enables relationship-level pricing',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this rate card is attached. Links to the master contract entity.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Brand-specific rate cards are common in advertising — different brands under the same advertiser may have distinct negotiated rates. Brand-level rate card management and pricing reports require this d',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rate cards define billing rates that vary by cost center (creative vs. strategy teams have different overhead structures); finance uses this for margin calculation.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Contract rate cards represent pricing negotiated with a specific vendor. Linking contract_rate_card.supplier_id enables vendor rate management, rate compliance auditing, and spend analysis by vendor —',
    `vendor_rate_card_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_rate_card. Business justification: Negotiated contract rate cards are derived from vendor-published rate cards. This link enables rate negotiation tracking — comparing contracted rates against vendors published rates — a standard proc',
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
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: Rate card lines are structured by channel (digital, broadcast, OOH). Linking rate_card_line to ad_channel enables channel-specific rate enforcement during media buying and supports channel-level rate ',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: Rate card lines are priced by ad format (e.g., :30 video spot vs. 300x250 display). Linking rate_card_line to ad_format enables format-specific rate validation during media buying and supports rate ca',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`contract`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique identifier for the contract amendment record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract, Statement of Work (SOW), Master Service Agreement (MSA), or Insertion Order (IO) being amended.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to campaign.campaign. Business justification: Amendments to insertion orders or SOWs frequently adjust campaign budgets, timelines, or scope. Linking amendment→campaign enables budget reconciliation, change order tracking, and campaign financial ',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.insertion_order. Business justification: Amendments can modify Insertion Orders (budget changes, flight date extensions, placement adjustments). N:1 relationship (many amendments can apply to one IO). No reverse FK exists. This allows tracki',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: Amendments frequently modify pricing terms, which may involve updating or replacing a rate card. Adding contract_rate_card_id to amendment allows tracking which rate card was introduced or modified by',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Amendments can modify SLA terms — e.g., changing performance targets, penalty thresholds, or measurement methodologies. Adding sla_id to amendment allows tracking which SLA record was affected by the ',
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
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: Contract renewals in advertising are directly tied to agency-client relationship reviews. When an AOR relationship is up for renewal, the contract renewal process is triggered. Relationship-level rene',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract being renewed. Links this renewal event to the master agreement.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: In agency practice, a contract renewal is frequently formalized through an amendment to the existing agreement rather than a new standalone agreement. Adding amendment_id to renewal links the renewal ',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: Contract renewals typically involve rate renegotiation, resulting in a new or revised rate card. Adding contract_rate_card_id to renewal links the renewal event to the rate card that will govern the r',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Contract renewals in advertising require a new or extended budget allocation. Linking renewal to finance_budget enables finance teams to confirm budget availability before renewal approval and support',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Renewals often involve SLA renegotiation — performance targets may be raised, penalty structures revised, or new metrics introduced. Adding sla_id to renewal links the renewal event to the SLA record ',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Renewals can be specific to SOWs (renewing a specific scope of work under a master agreement). N:1 relationship (many renewals can relate to one SOW). No reverse FK exists. This allows tracking SOW-le',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Contract renewals are managed per vendor relationship. Linking renewal.supplier_id enables vendor renewal pipeline reporting, churn risk analysis by supplier, and preferred vendor tier decisions — a n',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_parent_agreement_id` FOREIGN KEY (`parent_agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sow` ADD CONSTRAINT `fk_contract_sow_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ADD CONSTRAINT `fk_contract_contract_insertion_order_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`term` ADD CONSTRAINT `fk_contract_term_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`term` ADD CONSTRAINT `fk_contract_term_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`contract`.`term` ADD CONSTRAINT `fk_contract_term_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `advertising_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ADD CONSTRAINT `fk_contract_contract_deliverable_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`contract`.`sla` ADD CONSTRAINT `fk_contract_sla_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ADD CONSTRAINT `fk_contract_contract_rate_card_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ADD CONSTRAINT `fk_contract_rate_card_line_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_insertion_order_id` FOREIGN KEY (`contract_insertion_order_id`) REFERENCES `advertising_ecm`.`contract`.`contract_insertion_order`(`contract_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_superseded_by_amendment_id` FOREIGN KEY (`superseded_by_amendment_id`) REFERENCES `advertising_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `advertising_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `advertising_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_contract_rate_card_id` FOREIGN KEY (`contract_rate_card_id`) REFERENCES `advertising_ecm`.`contract`.`contract_rate_card`(`contract_rate_card_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `advertising_ecm`.`contract`.`sla`(`sla_id`);
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_sow_id` FOREIGN KEY (`sow_id`) REFERENCES `advertising_ecm`.`contract`.`sow`(`sow_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `advertising_ecm`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` SET TAGS ('dbx_subdomain' = 'contract_foundations');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `parent_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`contract`.`sow` SET TAGS ('dbx_subdomain' = 'contract_foundations');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`sow` ALTER COLUMN `sow_client_advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
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
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order (IO) Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_insertion_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Media Vendor Identifier');
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
ALTER TABLE `advertising_ecm`.`contract`.`term` SET TAGS ('dbx_subdomain' = 'contract_foundations');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`term` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Asset Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_deliverable` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`contract`.`sla` SET TAGS ('dbx_subdomain' = 'contract_foundations');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`sla` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`contract_rate_card` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rate Card Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `rate_card_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Line Identifier');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`rate_card_line` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`contract`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` SET TAGS ('dbx_subdomain' = 'contract_foundations');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`amendment` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`contract`.`renewal` SET TAGS ('dbx_subdomain' = 'contract_foundations');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`contract`.`renewal` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
