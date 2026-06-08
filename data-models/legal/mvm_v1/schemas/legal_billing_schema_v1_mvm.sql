-- Schema for Domain: billing | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`billing` COMMENT 'Single source of truth for all revenue cycle operations including timekeeping, WIP management, prebilling, invoice generation, payment processing, accounts receivable, collections, and write-offs. Supports multiple fee arrangements including hourly, contingency, flat fee, AFA, and blended rates. Integrates LEDES and UTBMS standards for electronic billing and task-based management. Covers PPP, PEP, RPE, and ARPU financial KPIs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`timekeeper_rate` (
    `timekeeper_rate_id` BIGINT COMMENT 'Unique surrogate identifier for each timekeeper rate record in the master rate card. Primary key for the timekeeper_rate data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Timekeeper rates are negotiated in client service agreements. Rate approval workflows verify rates against contracted terms, billing guideline compliance checks rates against agreements, rate disputes',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Contract amendments are the primary authorization mechanism for timekeeper rate changes in legal services. Linking timekeeper_rate to the authorizing amendment supports rate approval audit trails, bil',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Timekeeper rates are negotiated and authorized within the LOE. Legal billing managers must verify approved rates against the LOE during rate setup and audits. A legal-services expert would expect to t',
    `matter_id` BIGINT COMMENT 'Reference to the specific matter for which this rate applies. Null when the rate is client-level or firm-wide rather than matter-specific.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Timekeeper rates in legal firms are always scoped to a practice area (M&A rates differ from litigation rates). Legal billing managers report and approve rates by practice area for realization analysis',
    `primary_superseded_by_rate_timekeeper_rate_id` BIGINT COMMENT 'Reference to the newer timekeeper_rate record that replaced this one when a rate was updated or renegotiated. Enables full rate history chain traversal for audit and billing dispute resolution.',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom this negotiated rate applies. Null when the rate is a standard firm-wide or practice-group rate not tied to a specific client.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to service.rate_card. Business justification: Timekeeper rates are derived from or negotiated against a specific rate card. Legal pricing teams track which rate card a timekeeper rate implements for rate approval workflows and client billing guid',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Timekeeper rates are differentiated by client service tier (Tier 1 clients receive discounted rates vs. standard clients). Legal pricing teams set and approve rates by tier. This link enables tier-bas',
    `afa_arrangement_code` STRING COMMENT 'Reference code linking this rate to a specific Alternative Fee Arrangement (AFA) structure such as a fixed fee, capped fee, success fee, or retainer. Populated when rate_type is afa or flat_fee.',
    `approval_status` STRING COMMENT 'Workflow approval state of this rate record. Rates must progress through the approval workflow before being activated for time entry billing. Distinct from rate_status which reflects the operational lifecycle.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `approved_by` STRING COMMENT 'Name or identifier of the firm personnel (e.g., billing manager, CFO, managing partner) who approved this rate record. Required for audit trail and rate governance compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this rate record received formal approval. Part of the rate governance audit trail.',
    `billing_increment_mins` STRING COMMENT 'Minimum time increment in minutes used for rounding time entries billed at this rate (e.g., 6 minutes = 0.1 hour, 15 minutes = 0.25 hour). Governs WIP calculation granularity.',
    `blended_rate_pool_code` STRING COMMENT 'Identifier for the blended rate pool to which this timekeeper rate contributes. Applicable when rate_type is blended; allows multiple timekeepers at different levels to be billed at a single agreed blended rate.',
    `client_agreed` BOOLEAN COMMENT 'Indicates whether the client has formally agreed to or acknowledged this rate (True) or whether it is a firm-proposed rate pending client acceptance (False). Critical for billing disputes and engagement letter compliance.',
    `client_agreement_date` DATE COMMENT 'Date on which the client formally agreed to or acknowledged this rate, as documented in the engagement letter or rate agreement. Null if client_agreed is False.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rate record was first created in the system. Part of the audit trail for rate governance and compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the hourly rate is denominated (e.g., USD, GBP, EUR). Critical for multi-jurisdictional matters and cross-border billing.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'The date from which this rate becomes effective and may be applied to time entries. Defines the start of the rate validity period for WIP calculation and billing.',
    `effective_until` DATE COMMENT 'The date on which this rate ceases to be effective (inclusive). Null indicates an open-ended rate with no scheduled expiry. Enables rate history tracking and audit compliance.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The billable monetary rate per hour applied to time entries for this timekeeper under this rate record. This is the principal quantitative value of the rate card. Used in WIP (Work in Progress) calculation during time entry posting.',
    `jurisdiction_code` STRING COMMENT 'Code identifying the legal jurisdiction or geographic market to which this rate tier applies (e.g., US-NY, GB-ENG, EU). Supports jurisdiction-specific rate tiers required for multi-office and cross-border billing.. Valid values are `^[A-Z]{2,6}$`',
    `ledes_timekeeper_class` STRING COMMENT 'LEDES-standard timekeeper classification code used in electronic billing submissions to corporate clients and insurers (e.g., PT for Partner, AS for Associate, PL for Paralegal). Required for LEDES 1998B and LEDES XML format compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rate record was last modified. Used for change tracking, audit compliance, and incremental data loading in the Databricks lakehouse silver layer.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context about this rate record, such as negotiation history, special conditions, client-specific billing instructions, or exceptions to standard rate policy.',
    `office_code` STRING COMMENT 'Code identifying the firm office or location associated with this rate (e.g., NYC, LON, HKG). Rates may vary by office due to local market conditions and overhead structures.. Valid values are `^[A-Z0-9]{2,10}$`',
    `pro_bono_flag` BOOLEAN COMMENT 'Indicates whether this rate record applies to pro bono work (True), where the hourly_rate may be zero or nominal. Used for pro bono hour tracking and ABA 50-hour pro bono reporting.',
    `rate_basis` STRING COMMENT 'The unit of measure or billing basis against which the rate is applied. Most commonly per hour for standard timekeeping, but may be per day, per matter, per month, or fixed for AFA structures.. Valid values are `per_hour|per_day|per_matter|per_month|fixed`',
    `rate_cap_amount` DECIMAL(18,2) COMMENT 'Maximum monetary ceiling applied to this rate arrangement. Applicable for capped fee or AFA structures where total billing under this rate cannot exceed a defined threshold.',
    `rate_category` STRING COMMENT 'Business classification indicating the commercial basis of the rate: standard firm rate, client-negotiated rate, preferred panel rate, pro bono (zero or reduced), or secondment arrangement.. Valid values are `standard|negotiated|preferred|pro_bono|secondment`',
    `rate_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this rate record within the billing system (e.g., STD-PRTNR-2024, CLI-ABC-ASSOC). Used for LEDES electronic billing submissions and rate reconciliation.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `rate_discount_pct` DECIMAL(18,2) COMMENT 'Percentage discount applied from the standard rate to arrive at the negotiated hourly rate for this client or matter. Used for rate realization analysis and profitability reporting (RPE, PPP, PEP KPIs).',
    `rate_floor_amount` DECIMAL(18,2) COMMENT 'Minimum monetary floor for this rate arrangement. Used in contingency or success-fee structures where a minimum guaranteed fee applies regardless of outcome.',
    `rate_increase_pct` DECIMAL(18,2) COMMENT 'Percentage change in the hourly rate compared to the prior rate record for this timekeeper/client/matter combination. Used for rate increase tracking, client notification compliance, and year-over-year rate analytics.',
    `rate_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this rate. Supports annual rate increase cycles and client rate negotiation planning.',
    `rate_status` STRING COMMENT 'Current lifecycle state of the rate record. Rates must be approved before being applied to time entries. Superseded rates are replaced by a newer version; expired rates have passed their effective end date.. Valid values are `pending_approval|approved|active|superseded|expired|rejected`',
    `rate_type` STRING COMMENT 'Classification of the fee arrangement type governing this rate. Supports standard hourly, blended rate pools, contingency, flat fee, Alternative Fee Arrangement (AFA), and capped fee structures. [ENUM-REF-CANDIDATE: hourly|blended|contingency|flat_fee|afa|capped|success_fee|retainer — promote to reference product]. Valid values are `hourly|blended|contingency|flat_fee|afa|capped`',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this rate record originated (Elite 3E, Aderant Expert, or manually entered). Supports data lineage and reconciliation in the lakehouse silver layer.. Valid values are `elite_3e|aderant_expert|manual`',
    `source_system_rate_code` STRING COMMENT 'The native primary key or identifier of this rate record in the originating operational system (Elite 3E or Aderant Expert). Enables traceability and reconciliation between the lakehouse silver layer and the system of record.',
    `standard_rate` DECIMAL(18,2) COMMENT 'The timekeepers published standard rack rate before any client-specific negotiation or discount. Retained alongside the negotiated hourly_rate to enable rate discount analysis and realization reporting.',
    `timekeeper_level` STRING COMMENT 'Professional classification or seniority tier of the timekeeper at the time this rate was set. Used for rate benchmarking, PPP/PEP analytics, and UTBMS task-based billing. [ENUM-REF-CANDIDATE: equity_partner|non_equity_partner|of_counsel|senior_associate|associate|paralegal|legal_assistant|staff_attorney|trainee — promote to reference product]',
    `utbms_task_code` STRING COMMENT 'UTBMS task code scoping this rate to a specific task category (e.g., L110 Fact Investigation, L210 Pleadings). Enables task-based billing and rate differentiation by activity type as required by corporate clients.. Valid values are `^[A-Z][0-9]{3}$`',
    `wip_rate_flag` BOOLEAN COMMENT 'Indicates whether this rate is the currently active rate used for WIP (Work in Progress) valuation on time entries. Only one rate per timekeeper/client/matter combination should be flagged True at any point in time.',
    CONSTRAINT pk_timekeeper_rate PRIMARY KEY(`timekeeper_rate_id`)
) COMMENT 'Master rate card defining billable rates for each timekeeper by client, matter, practice group, and effective date period. Supports standard hourly rates, blended rates, client-negotiated rates, and alternative fee arrangement rate structures. Tracks rate currency, jurisdiction-specific rate tiers, rate approval status, and rate history for audit purposes. Governs the monetary value applied to time entries during WIP calculation.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique system-generated identifier for each time entry record. Primary key for the time_entry data product in the billing domain.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.ip_asset. Business justification: IP prosecution billing requires tracking billable hours per IP asset for portfolio cost analysis and client reporting. Law firms run per-asset time reports to show clients prosecution costs by patent/',
    `doc_review_assignment_id` BIGINT COMMENT 'Foreign key linking to document.doc_review_assignment. Business justification: Reviewers log time against specific document review assignments. Linking time entries to review assignments enables review productivity reporting (cost per assignment, hours per batch), supports TAR/C',
    `doc_version_id` BIGINT COMMENT 'Foreign key linking to document.doc_version. Business justification: Time entries for drafting, reviewing, or revising documents should reference the specific document version worked on. Enables version-level cost tracking, supports billing narrative accuracy, and is e',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Attorneys record billable time directly against litigation dockets for LEDES billing, client reporting, and matter profitability analysis. Essential for court-related time tracking and outside counsel',
    `hearing_id` BIGINT COMMENT 'Foreign key linking to court.hearing. Business justification: Time entries for hearing preparation, attendance, and follow-up reference specific hearings for accurate UTBMS task coding, client transparency, and billing guideline compliance in litigation matters.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Time entries reference specific documents worked on (drafting motions, reviewing contracts, redlining agreements). Required for task-based billing, UTBMS coding validation, and detailed client reporti',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Time entries record work performed for a specific legal service (e.g., contract drafting, litigation support). Legal billing analysts report time and realization by service type for profitability anal',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: Time entries for license negotiation, drafting, and enforcement work are tied to specific license agreements. IP licensing billing requires tracking hours per license agreement for client matter budge',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter against which this time entry is recorded. Every billable or non-billable time entry must be associated with an active matter.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Time entries are directly coded to practice areas for WIP reporting, realization analysis, and partner compensation calculations. This is a standard LEDES/e-billing requirement. Legal finance teams ru',
    `timekeeper_rate_id` BIGINT COMMENT 'Foreign key linking to billing.timekeeper_rate. Business justification: Time entries are billed using specific rate card entries. Currently time_entry has billing_rate (amount) and timekeeper_level (string) but no FK to the authoritative rate record. Adding timekeeper_rat',
    `profile_id` BIGINT COMMENT 'Reference to the client associated with the matter for which time is being recorded. Denormalized from the matter for direct billing and reporting queries.',
    `prosecution_event_id` BIGINT COMMENT 'Foreign key linking to ip.prosecution_event. Business justification: Time entries for office action responses, examination interviews, and prosecution filings must link to the triggering prosecution event. IP billing reports require hours-by-prosecution-stage analysis.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was approved by the responsible billing attorney or billing supervisor. Marks the transition from submitted to approved status and authorizes inclusion in prebilling and invoicing.',
    `billable_hours` DECIMAL(18,2) COMMENT 'Hours approved for billing to the client after any reductions, write-downs, or non-billable designations applied during the prebilling review process. May differ from hours_worked due to courtesy reductions, write-downs, or billing guidelines. Used as the basis for WIP value calculation.',
    `billed_timestamp` TIMESTAMP COMMENT 'Date and time when this time entry was included in a finalized invoice and transitioned to billed status. Used for WIP clearance, revenue recognition timing, and billing cycle reporting.',
    `billing_guideline_compliant` BOOLEAN COMMENT 'Indicates whether this time entry has been reviewed and confirmed as compliant with the clients outside counsel billing guidelines (True) or flagged as non-compliant (False). Non-compliant entries may be subject to write-down or rejection by the client.',
    `billing_period_end` DATE COMMENT 'End date of the billing period or billing cycle to which this time entry is allocated. Defines the cutoff for WIP inclusion in a billing run and supports period-close reporting.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period or billing cycle to which this time entry is allocated. Used for period-based WIP reporting, billing cutoff management, and monthly/quarterly revenue recognition.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was first created in the source system. Serves as the record audit creation timestamp for data lineage and compliance purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the billing rate and WIP amount (e.g., USD, GBP, EUR). Supports multi-currency billing for international matters and cross-border transactions.. Valid values are `^[A-Z]{3}$`',
    `entry_method` STRING COMMENT 'Method by which the time entry was captured in the system. Manual entries are typed directly; timer entries are captured via running timer tools; mobile entries are submitted via mobile app; bulk_import entries are loaded from external sources; api entries are submitted programmatically.. Valid values are `manual|timer|mobile|bulk_import|api`',
    `entry_number` STRING COMMENT 'Human-readable, externally referenceable identifier for the time entry as generated by the practice management system (e.g., Elite 3E or Aderant Expert). Used in prebilling, invoice line references, and LEDES export.',
    `entry_status` STRING COMMENT 'Current lifecycle status of the time entry as it progresses through the WIP management and billing workflow. Draft entries are in progress; submitted entries await approval; approved entries are ready for invoicing; billed entries have been included on an invoice; written_off entries have been removed from WIP; rejected entries require correction. [ENUM-REF-CANDIDATE: draft|submitted|approved|billed|written_off|rejected — promote to reference product]. Valid values are `draft|submitted|approved|billed|written_off|rejected`',
    `fee_arrangement_type` STRING COMMENT 'Classification of the fee arrangement governing this time entry. Determines how the entry contributes to billing and revenue recognition. AFA (Alternative Fee Arrangement) entries may include capped fees, fixed fees, or success fees. [ENUM-REF-CANDIDATE: hourly|flat_fee|contingency|blended_rate|afa|pro_bono|retainer — promote to reference product]. Valid values are `hourly|flat_fee|contingency|blended_rate|afa|pro_bono`',
    `hours_worked` DECIMAL(18,2) COMMENT 'Actual hours spent performing the work as recorded by the timekeeper, prior to any billing adjustments. Typically recorded in tenths of an hour (0.1 increments) per standard legal billing practice. Serves as the raw input before billable hours are determined.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this time entry is designated as billable to the client (True) or non-billable (False). Non-billable entries may include pro bono work, administrative time, or courtesy write-offs. Drives WIP accumulation and invoice inclusion logic.',
    `is_contingency` BOOLEAN COMMENT 'Indicates whether this time entry is recorded under a contingency fee arrangement (True), where billing is conditional on case outcome. Contingency entries accumulate WIP but are not invoiced until the contingency event occurs. Supports AFA tracking.',
    `ledes_line_item_number` STRING COMMENT 'The line item number assigned to this time entry in the LEDES electronic billing file submitted to the client or client billing system. Required for LEDES 1998B and LEDES XML format compliance and for reconciliation of electronic billing submissions.',
    `lpp_protected` BOOLEAN COMMENT 'Indicates whether the narrative or details of this time entry are subject to Legal Professional Privilege (LPP) or attorney-client privilege protections (True). LPP-protected entries require restricted access controls and must be handled in compliance with privilege preservation obligations during eDiscovery and regulatory inquiries.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was last modified in the source system. Used for change detection, incremental data loading, and audit trail maintenance.',
    `narrative` STRING COMMENT 'Free-text description of the legal work performed, as entered by the timekeeper. Appears on client invoices and prebilling reports. Subject to Legal Professional Privilege (LPP) protections. Must be sufficiently detailed to satisfy ABA Model Rule 1.5 billing transparency requirements and client billing guidelines.',
    `no_charge` BOOLEAN COMMENT 'Indicates whether this time entry has been designated as no-charge (True), meaning the work was performed but will not be billed to the client. Distinct from non-billable entries; no-charge entries may appear on invoices at zero value for transparency.',
    `office_code` STRING COMMENT 'Code identifying the firm office or practice location associated with this time entry. Used for office-level revenue reporting, profitability analysis, and jurisdictional billing compliance.',
    `phase_code` STRING COMMENT 'Code identifying the phase or stage of the matter to which this time entry belongs (e.g., pleadings, discovery, trial, closing). Used in Legal Project Management (LPM) for budget tracking against matter phases and milestone-based billing.',
    `practice_group_code` STRING COMMENT 'Code identifying the practice group or department (e.g., Corporate, Litigation, IP, Employment) to which the timekeeper belongs at the time of entry. Supports practice group profitability reporting and resource allocation analytics.',
    `pro_bono_category` STRING COMMENT 'Classification of the pro bono service type when the time entry is designated as pro bono (e.g., access to justice, nonprofit representation, government service). Null for non-pro-bono entries. Supports ABA pro bono reporting requirements and firm CSR metrics.',
    `source_system` STRING COMMENT 'Identifies the originating operational system from which this time entry record was sourced into the data lakehouse. Supports data lineage, reconciliation, and audit traceability across the billing technology stack.. Valid values are `elite_3e|aderant_expert|mobile_app|api_integration|manual_upload`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the timekeeper formally submitted the time entry for approval. Marks the transition from draft to submitted status. Used for timekeeping compliance monitoring and late submission reporting.',
    `task_description` STRING COMMENT 'Structured description of the specific legal task performed, distinct from the free-text narrative. May be derived from or supplement the UTBMS task code with matter-specific context. Used in task-based matter management and Legal Project Management (LPM) reporting.',
    `utbms_activity_code` STRING COMMENT 'UTBMS standardized activity code describing the specific activity performed within the task (e.g., A101 for Plan and Prepare, A102 for Research, A103 for Draft/Revise). Used in conjunction with utbms_task_code for granular task-based billing analysis and LEDES export.',
    `utbms_expense_code` STRING COMMENT 'UTBMS expense code applicable when the time entry is associated with a disbursement or expense component (e.g., E101 for Copying, E106 for Computer Research). Nullable for pure time entries with no expense component.',
    `utbms_task_code` STRING COMMENT 'UTBMS standardized task code classifying the type of legal work performed (e.g., L110 for Fact Investigation, L120 for Analysis/Strategy, B110 for Retention/Billing). Required for LEDES electronic billing submissions and task-based matter management reporting.',
    `wip_amount` DECIMAL(18,2) COMMENT 'The monetary value of unbilled work represented by this time entry, calculated as billable_hours multiplied by billing_rate. Represents the WIP balance contribution of this entry. Reduced to zero when the entry is billed or written off.',
    `work_date` DATE COMMENT 'The calendar date on which the legal work was actually performed. This is the principal business event date for the time entry, distinct from the date the entry was created or submitted in the system. Critical for WIP aging, billing period cutoffs, and matter chronology.',
    `write_down_amount` DECIMAL(18,2) COMMENT 'The monetary amount by which the original WIP value of this entry was reduced during prebilling review or billing adjustment. Represents the difference between the originally recorded WIP value and the amount actually billed. Used for realization rate analysis and partner performance reporting.',
    `write_down_reason_code` STRING COMMENT 'Standardized code indicating the reason for any write-down applied to this time entry (e.g., client discount, billing guideline non-compliance, courtesy reduction, duplicate entry). Required for realization analysis and billing adjustment reporting.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Granular transactional record of billable and non-billable time recorded by timekeepers against a matter. Captures UTBMS task and activity codes, narrative descriptions, hours worked, billable hours, billing rate at time of entry, WIP value, and timekeeper identity. Supports LEDES export format for electronic billing. Tracks entry status through draft, submitted, approved, billed, and written-off lifecycle stages. Primary source record for WIP accumulation and invoice generation.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`billing_disbursement` (
    `billing_disbursement_id` BIGINT COMMENT 'Unique surrogate identifier for each disbursement record in the billing domain. Primary key for the disbursement data product in the Databricks Silver Layer.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: IP-specific disbursements (filing fees, annuity payments, prosecution expenses, translation costs) are directly attributable to specific IP assets for cost recovery, portfolio profitability analysis, ',
    `docket_deadline_id` BIGINT COMMENT 'Foreign key linking to ip.docket_deadline. Business justification: Annuity payments and official fee disbursements are triggered by docket deadlines. Linking disbursement to the deadline that triggered it supports IP compliance cost reporting and confirms that deadli',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Court-related expenses (filing fees, service costs, transcript fees) are tracked against specific dockets for client billing, cost recovery, and LEDES expense reporting in litigation matters.',
    `fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.fee_arrangement. Business justification: Disbursements occur within the context of a fee arrangement, which governs whether expenses are billable, subject to caps, or excluded. Currently disbursement has fee_arrangement_type (string code) bu',
    `filing_id` BIGINT COMMENT 'Foreign key linking to court.filing. Business justification: Filing fees are direct costs tied to specific court filings. Firms track disbursements per filing for accurate cost recovery, client transparency, and LEDES compliance.',
    `matter_id` BIGINT COMMENT 'Reference to the client matter against which this disbursement is recorded. Links the disbursement to the matter for Work in Progress (WIP) accumulation and billing purposes.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Disbursements are tracked by practice area for expense policy compliance, reimbursement approval, and profitability analysis. Practice area determines expense policies, markup rules, and cost manageme',
    `production_set_id` BIGINT COMMENT 'Foreign key linking to document.production_set. Business justification: Document productions incur disbursements (printing, media, delivery, processing vendor fees) tracked at the production set level. Firms bill clients for production costs per set. A litigation billing ',
    `profile_id` BIGINT COMMENT 'Reference to the client on whose behalf the disbursement was incurred. Used for client-level cost reporting and billing aggregation.',
    `prosecution_event_id` BIGINT COMMENT 'Foreign key linking to ip.prosecution_event. Business justification: Official fees and filing disbursements are incurred at specific prosecution events (filing responses, paying issue fees). IP cost tracking and client billing require linking each disbursement to the p',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: Billing disbursements (court fees, filing costs) are frequently funded directly from client trust accounts. Regulatory compliance and three-way reconciliation require tracing each trust-funded disburs',
    `amount` DECIMAL(18,2) COMMENT 'The gross amount of the disbursement as incurred or paid, before any tax, markup, or write-down adjustments. Represents the base cost for WIP accumulation and billing calculations.',
    `approved_by` STRING COMMENT 'Name or identifier of the partner or billing supervisor who approved the disbursement for billing. Required for disbursements above the firms approval threshold and for audit trail purposes.',
    `approved_date` DATE COMMENT 'The date on which the disbursement was approved for billing by the responsible partner or billing supervisor. Used for billing workflow tracking and audit compliance.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'The disbursement amount converted to the firms base billing currency using the applicable exchange rate. Used for consolidated financial reporting, Profit Per Partner (PPP) and Revenue Per Equity Partner (RPE) KPI calculations.',
    `billed_amount` DECIMAL(18,2) COMMENT 'The amount actually billed to the client on the invoice, after applying any markup, write-down, or billing adjustment. May differ from the disbursement amount if a write-down was applied during prebilling review.',
    `billing_disbursement_description` STRING COMMENT 'Narrative description of the disbursement as it will appear on the client invoice and in the billing system. Describes the nature of the expense incurred (e.g., Court filing fee — Superior Court of California, Expert witness fee — Dr. J. Smith). Supports LEDES line-item narrative requirements.',
    `billing_period` STRING COMMENT 'The billing period (YYYY-MM) to which the disbursement is allocated for invoicing purposes. Used for period-based WIP reporting, prebilling, and financial close processes.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `cost_centre_code` STRING COMMENT 'The internal cost centre code to which the disbursement is attributed for management accounting and profitability reporting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the disbursement record was first created in the source system. Used for audit trail, WIP aging, and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the disbursement amount is denominated (e.g., USD, GBP, EUR). Required for multi-currency matters and cross-border transactions.. Valid values are `^[A-Z]{3}$`',
    `disbursement_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to the disbursement record. Used for audit trails, client queries, and cross-system reconciliation with Elite 3E and Aderant Expert.',
    `disbursement_status` STRING COMMENT 'Current lifecycle state of the disbursement record. wip indicates the cost is in Work in Progress (WIP) awaiting billing; billed indicates it has been included on a client invoice; written_off indicates the amount has been written off and will not be recovered.. Valid values are `draft|wip|billed|written_off|cancelled|on_hold`',
    `disbursement_type` STRING COMMENT 'Classifies the disbursement as a hard disbursement (direct out-of-pocket cost paid to a third party on behalf of the client, e.g., court filing fees, expert witness fees) or a soft disbursement (internal overhead recovery, e.g., photocopying, internal printing). Determines pass-through billing treatment.. Valid values are `hard|soft`',
    `entry_date` DATE COMMENT 'The date on which the disbursement was entered into the practice management system. May differ from the expense date when costs are posted retrospectively. Used for WIP aging calculations from the entry date perspective.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the disbursement amount from the transaction currency to the firms base billing currency at the time of entry. Used for multi-currency matter billing and financial consolidation.',
    `expense_category` STRING COMMENT 'Internal firm classification of the disbursement type used for cost management and reporting (e.g., court_filing, expert_witness, travel, courier, photocopying, translation, process_server, deposition). [ENUM-REF-CANDIDATE: court_filing|expert_witness|travel|courier|photocopying|translation|process_server|deposition|search_fee|recording_fee — promote to reference product]',
    `expense_date` DATE COMMENT 'The real-world date on which the disbursement was incurred or the expense was paid. This is the principal business event date used for WIP aging, billing period allocation, and financial reporting.',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code to which the disbursement is posted in the firms accounting system. Used for financial reporting, cost allocation, and Sarbanes-Oxley (SOX) compliance.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the disbursement is billable to the client (True) or is a non-billable internal cost (False). Non-billable disbursements are absorbed by the firm and excluded from client invoices but included in matter cost reporting.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the disbursement is subject to applicable taxes (e.g., VAT, GST) when billed to the client. Drives tax calculation logic in the billing system.',
    `ledes_expense_code` STRING COMMENT 'The Legal Electronic Data Exchange Standard (LEDES) expense code used in electronic billing submissions to corporate clients and insurance companies. Aligns with LEDES 1998B and LEDES XML format requirements.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Percentage markup applied to the base disbursement amount when billing to the client. Common for soft disbursements such as photocopying or printing where the firm applies a standard recovery rate above cost. Zero for hard disbursements passed through at cost.',
    `narrative_for_client` STRING COMMENT 'The client-facing narrative or description of the disbursement as it appears on the client invoice. May differ from the internal description field. Supports compliance with client billing guidelines and Alternative Fee Arrangement (AFA) reporting requirements.',
    `office_code` STRING COMMENT 'Code identifying the firm office or location from which the disbursement was incurred. Used for geographic cost allocation, multi-office financial reporting, and jurisdictional tax compliance.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity or unit count associated with the disbursement where applicable (e.g., number of pages photocopied, number of miles travelled, number of documents served). Used with unit_rate to derive the disbursement amount for volume-based expenses.',
    `receipt_reference` STRING COMMENT 'Reference number or identifier for the receipt or proof of payment supporting the disbursement. Used for expense substantiation, audit compliance, and client billing dispute resolution.',
    `recovery_status` STRING COMMENT 'Indicates the current recovery status of the disbursement cost from the client. unrecovered means the cost has not yet been billed or paid; partially_recovered means a portion has been collected; fully_recovered means the full amount has been received; written_off means recovery has been abandoned.. Valid values are `unrecovered|partially_recovered|fully_recovered|written_off`',
    `source_system` STRING COMMENT 'Identifies the originating operational system from which the disbursement record was sourced (e.g., Elite 3E, Aderant Expert, manual entry, expense portal). Used for data lineage, reconciliation, and Silver Layer provenance tracking.. Valid values are `elite_3e|aderant_expert|manual|expense_portal|other`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount (e.g., VAT, GST, sales tax) applicable to the disbursement as billed to the client. Calculated based on the applicable tax code and jurisdiction. Required for tax compliance reporting.',
    `tax_code` STRING COMMENT 'The tax code applied to the disbursement to determine the applicable tax rate and treatment (e.g., VAT standard rate, zero-rated, exempt). Sourced from the firms tax configuration in Elite 3E.',
    `unit_rate` DECIMAL(18,2) COMMENT 'The per-unit rate applied to the quantity to calculate the disbursement amount (e.g., cost per page, cost per mile). Used for volume-based soft disbursements such as photocopying and mileage recovery.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the disbursement record was last modified in the source system. Used for change data capture (CDC), audit trail, and Silver Layer incremental load processing.',
    `utbms_expense_code` STRING COMMENT 'Standardised Uniform Task-Based Management System (UTBMS) expense code classifying the nature of the disbursement (e.g., E101 for copying, E106 for computer research, E112 for court fees). Required for LEDES electronic billing submissions to corporate clients.. Valid values are `^E[0-9]{3}$`',
    `vendor_invoice_number` STRING COMMENT 'The invoice or reference number from the third-party vendors invoice supporting the disbursement. Used for accounts payable reconciliation and audit trail purposes.',
    `vendor_name` STRING COMMENT 'Name of the third-party vendor, supplier, or service provider from whom the disbursement cost was incurred (e.g., court, expert witness firm, courier company, translation agency). Applicable primarily to hard disbursements.',
    `write_down_amount` DECIMAL(18,2) COMMENT 'The monetary amount by which the disbursement was reduced during prebilling review before invoicing. Represents the difference between the recorded amount and the billed amount. Used for realization rate analysis and profitability reporting.',
    `write_off_reason` STRING COMMENT 'The reason code explaining why the disbursement was written off or written down. Used for profitability analysis, billing quality management, and partner performance reporting.. Valid values are `client_dispute|fee_arrangement|goodwill|uncollectable|billing_error|other`',
    CONSTRAINT pk_billing_disbursement PRIMARY KEY(`billing_disbursement_id`)
) COMMENT 'Transactional record of out-of-pocket expenses and costs incurred on behalf of a client matter, including court filing fees, expert witness fees, travel, courier, photocopying, and third-party vendor costs. Captures UTBMS expense codes, disbursement type, amount, tax treatment, billable flag, and recovery status. Supports both hard disbursements (direct client pass-through costs) and soft disbursements (overhead recoveries). Feeds WIP accumulation alongside time entries.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`wip_ledger` (
    `wip_ledger_id` BIGINT COMMENT 'Unique surrogate identifier for each WIP ledger entry. Primary key for the wip_ledger data product in the billing domain.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.ip_asset. Business justification: IP portfolio WIP aging reports require WIP ledger entries to be tracked per IP asset. Law firms run per-asset WIP reports to identify unbilled prosecution costs and manage IP portfolio billing cycles.',
    `billing_disbursement_id` BIGINT COMMENT 'FK to billing.disbursement.disbursement_id — WIP ledger entries also accumulate from disbursements. This link enables complete WIP composition analysis showing both time and expense components.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: WIP accumulates against litigation matters with dockets. Essential for matter-level WIP aging, prebilling review, litigation profitability tracking, and partner oversight of court-related unbilled wor',
    `fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.fee_arrangement. Business justification: WIP accumulates under a specific fee arrangement, which determines billing rules, rate structures, and conversion to invoices. Currently wip_ledger has fee_arrangement_type (string) but no FK to the a',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: WIP aging and realization reports in legal firms are always segmented by practice area for partner compensation and profitability analysis. Legal finance teams run WIP-by-practice-area reports for mon',
    `matter_id` BIGINT COMMENT 'Reference to the matter against which this WIP entry is recorded. Matters are the primary billing unit in legal practice management.',
    `profile_id` BIGINT COMMENT 'Reference to the client associated with the matter for which WIP is being tracked. Used in client-level WIP reporting and PPP/PEP calculations.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: WIP entries funded from or converted via trust (earned-fee transfers from trust-to-office) must reference the source trust account. Supports WIP-to-trust reconciliation and earned-fee transfer audit t',
    `time_entry_id` BIGINT COMMENT 'FK to billing.time_entry.time_entry_id — WIP ledger entries accumulate from time entries. This link enables WIP drill-down to source time records and supports WIP aging analysis at the entry level.',
    `aging_bucket` STRING COMMENT 'Categorical aging classification of the WIP entry based on wip_age_days. Used in WIP aging reports for financial management, partner reviews, and collections strategy. Buckets align with standard legal industry WIP aging reporting conventions.. Valid values are `0_30_days|31_60_days|61_90_days|91_180_days|over_180_days`',
    `approved_date` DATE COMMENT 'The date on which the WIP entry was approved for billing or the write-off/write-down was authorised. Used in billing workflow tracking and SOX compliance audit trails.',
    `billing_office_code` BIGINT COMMENT 'Reference to the firm office responsible for billing this WIP entry. Used for office-level revenue attribution, PPP/PEP calculations by office, and financial reporting segmentation.',
    `billing_rate` DECIMAL(18,2) COMMENT 'The standard billing rate per hour applied to this WIP entry, expressed in the matter currency. Reflects the timekeepers rate for the applicable billing period and client rate agreement. Confidential as it reflects negotiated client pricing.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this WIP ledger record was first created in the source practice management system. Provides the authoritative record creation audit timestamp for data lineage and compliance purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this WIP entry (e.g., USD, GBP, EUR). Supports multi-currency billing for international matters and cross-border client engagements.. Valid values are `^[A-Z]{3}$`',
    `entry_date` DATE COMMENT 'The calendar date on which the WIP entry was recorded in the practice management system. May differ from work_date due to late time entry. Used for compliance monitoring of timekeeping policies and WIP aging from entry perspective.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the WIP entry amount from the matter currency to the firms functional reporting currency at the time of entry. Used for consolidated financial reporting and multi-currency WIP analysis.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Number of billable hours recorded for this WIP entry. Applicable when wip_type is time. Expressed in decimal hours (e.g., 1.50 = 1 hour 30 minutes). Null for disbursement and fixed-fee entries.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this WIP entry is designated as billable to the client (True) or non-billable/internal (False). Non-billable WIP is tracked for cost management and matter profitability analysis but excluded from client invoices.',
    `is_contingency_accrual` BOOLEAN COMMENT 'Indicates whether this WIP entry represents an accrued contingency fee amount (True) that is not yet realised pending case outcome. Contingency WIP is tracked separately for financial reporting and is only recognised as revenue upon successful resolution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this WIP ledger record was most recently updated in the source practice management system. Used for incremental data loading, change detection, and audit trail maintenance in the Silver layer.',
    `phase_code` STRING COMMENT 'Matter phase code identifying the stage of the legal engagement to which this WIP entry belongs (e.g., pleadings, discovery, trial). Used in matter budgeting, phase-based billing, and LPM (Legal Project Management) reporting.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this WIP ledger entry was sourced. Supports data lineage, reconciliation, and audit traceability in the Silver layer of the Databricks Lakehouse.. Valid values are `elite_3e|aderant_expert|manual`',
    `standard_amount` DECIMAL(18,2) COMMENT 'The WIP value calculated at the timekeepers standard rack rate (hours_worked multiplied by standard_rate). Used to measure the variance between standard and billed value, supporting write-up/write-down analysis and profitability reporting.',
    `standard_rate` DECIMAL(18,2) COMMENT 'The timekeepers published standard rack rate per hour before any client-specific discounts or negotiated rate agreements are applied. Used to calculate write-up/write-down variance against billing_rate for financial KPI reporting including RPE.',
    `utbms_activity_code` STRING COMMENT 'UTBMS standardised activity code describing the specific activity performed within a task (e.g., A101 for Plan and Prepare, A102 for Research). Complements the task code for granular task-based billing and client invoice compliance.. Valid values are `^A[0-9]{3}$`',
    `utbms_expense_code` STRING COMMENT 'UTBMS standardised expense code for disbursement and expense WIP entries (e.g., E101 for Copying, E106 for Online Research). Populated only when wip_type is disbursement or expense.. Valid values are `^E[0-9]{3}$`',
    `utbms_task_code` STRING COMMENT 'UTBMS standardised task code classifying the legal work performed (e.g., L110 for Fact Investigation, L120 for Analysis/Strategy). Enables task-based billing analysis, client reporting, and benchmarking against industry spend data.. Valid values are `^[A-Z][0-9]{3}$`',
    `wip_accumulates_disbursement` BIGINT COMMENT 'FK to billing.disbursement.disbursement_id — WIP ledger entries also accumulate from disbursements. This FK enables complete WIP composition analysis.',
    `wip_age_days` STRING COMMENT 'Number of calendar days elapsed since the work_date of this WIP entry. Used to populate WIP aging buckets (0-30, 31-60, 61-90, 90+ days) for financial reporting, collections prioritisation, and partner performance reviews.',
    `wip_amount` DECIMAL(18,2) COMMENT 'The gross WIP value of this entry calculated as hours_worked multiplied by billing_rate for time entries, or the disbursement amount for expense entries. Represents the unbilled revenue value before any write-up or write-down adjustments. Core field for PPP, PEP, and RPE financial KPI calculations.',
    `wip_amount_firm_currency` DECIMAL(18,2) COMMENT 'The WIP amount converted to the firms functional reporting currency using the exchange_rate. Enables consolidated WIP reporting, PPP, PEP, and RPE calculations across matters billed in multiple currencies.',
    `wip_entry_number` STRING COMMENT 'Externally visible, human-readable business identifier for this WIP ledger entry as assigned by the practice management system (e.g., Elite 3E transaction number). Used for cross-system reconciliation and audit trails.',
    `wip_status` STRING COMMENT 'Current lifecycle state of the WIP ledger entry. open indicates unbilled WIP available for prebilling; billed indicates the entry has been included on an invoice; written_off indicates the amount has been written off; transferred indicates the WIP has been moved to another matter; on_hold indicates billing is suspended; reversed indicates the entry has been reversed.. Valid values are `open|billed|written_off|transferred|on_hold|reversed`',
    `wip_type` STRING COMMENT 'Classification of the WIP entry by nature of the charge. time represents billable hours; disbursement represents client-chargeable out-of-pocket costs; expense represents firm expenses; fixed_fee represents flat-fee milestone charges; contingency represents contingency-based accruals.. Valid values are `time|disbursement|expense|fixed_fee|contingency`',
    `work_date` DATE COMMENT 'The calendar date on which the billable work or disbursement was performed. This is the principal real-world event date for the WIP entry, distinct from the date the entry was recorded in the system. Critical for WIP aging calculations and billing period allocation.',
    `work_description` STRING COMMENT 'Narrative description of the work performed or disbursement incurred as entered by the timekeeper. Appears on prebill and client invoice. Subject to billing guidelines review and may be edited during the prebilling process.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The monetary value of WIP that has been written off and will not be billed to the client. Populated when wip_status is written_off. Used in realisation rate calculations and partner performance reviews.',
    `write_off_reason_code` STRING COMMENT 'Standardised reason code explaining why the WIP entry was written off (e.g., client dispute, fee cap exceeded, courtesy write-off, uncollectable). Populated when wip_status is written_off. Used in write-off analysis and partner performance reporting. [ENUM-REF-CANDIDATE: client_dispute|fee_cap_exceeded|courtesy|uncollectable|billing_error|matter_closed — promote to reference product]',
    `write_up_down_amount` DECIMAL(18,2) COMMENT 'The monetary adjustment applied to the WIP entry representing the difference between the standard amount and the billed amount. Positive values indicate a write-up (billing above standard); negative values indicate a write-down (billing below standard). Critical for realisation rate analysis and partner performance reporting.',
    CONSTRAINT pk_wip_ledger PRIMARY KEY(`wip_ledger_id`)
) COMMENT 'Accumulated Work in Progress ledger representing unbilled time and disbursements for each matter. Tracks WIP balance by timekeeper, matter, billing period, and fee arrangement type. Provides the authoritative WIP snapshot used in prebilling and financial reporting. Captures WIP aging buckets, write-up/write-down adjustments, and transfer history. Critical for PPP (Profit Per Partner), PEP (Profit Per Equity Partner), and RPE (Revenue Per Employee) financial KPI calculations.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`prebill` (
    `prebill_id` BIGINT COMMENT 'Unique system-generated identifier for the prebill record. Primary key for the prebill data product in the billing domain.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Prebills for litigation matters reference specific dockets for attorney review of court-related charges, billing guideline compliance checking, and client communication before final invoicing.',
    `fee_arrangement_id` BIGINT COMMENT 'Reference to the fee arrangement governing this prebill, such as hourly, flat fee, contingency, or Alternative Fee Arrangement (AFA). Determines billing calculation methodology.',
    `invoice_id` BIGINT COMMENT 'Reference to the final invoice generated from this approved prebill. Populated once the prebill transitions to approved status and the invoice is created. Null if the prebill has not yet been converted to an invoice.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Prebills are generated for work performed on a specific legal service. Legal billing teams review prebills by service type for service-level revenue recognition and billing guideline compliance. prebi',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Prebill review validates proposed charges against the letter of engagement terms before invoice finalization. Billing attorneys must verify scope compliance, rate adherence, and guideline conformance ',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Prebills are reviewed and approved by practice area leadership. Practice area determines approval authority, billing guideline compliance rules, and realization targets used in prebill review workflow',
    `matter_id` BIGINT COMMENT 'Client-assigned matter identifier formatted per LEDES electronic billing standards. Required for electronic invoice submission to corporate clients and insurance carriers using LEDES-compliant billing systems.',
    `prebill_matter_id` BIGINT COMMENT 'Reference to the matter against which this prebill is generated. Links the prebill to the specific legal matter or case being billed.',
    `profile_id` BIGINT COMMENT 'Reference to the client entity responsible for payment of this prebill. Derived from the matter-client relationship for billing purposes.',
    `wip_ledger_id` BIGINT COMMENT 'FK to billing.wip_ledger.wip_ledger_id — Prebills are generated from WIP balances. This link enables the prebilling workflow to pull unbilled WIP for attorney review and ensures WIP-to-invoice traceability.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing attorney formally approved the prebill for invoice generation. Marks the transition to approved status and triggers the invoice creation workflow.',
    `billing_frequency` STRING COMMENT 'Cadence at which invoices are issued for this matter, as agreed in the engagement letter. Drives prebill generation scheduling: monthly, quarterly, at defined milestones, on-demand, or annually.. Valid values are `monthly|quarterly|milestone|on_demand|annual`',
    `billing_guideline_compliant` BOOLEAN COMMENT 'Indicates whether the prebill has passed automated billing guideline compliance checks against the applicable client billing guidelines. True = compliant; False = one or more violations detected requiring attorney review.',
    `billing_guideline_version` STRING COMMENT 'Version identifier of the client billing guidelines applied during prebill review and compliance checking. Corporate clients and insurers issue versioned billing guidelines that restrict rates, timekeepers, task codes, and narrative formats.',
    `billing_period_end_date` DATE COMMENT 'Last date of the billing period covered by this prebill. Defines the inclusive end of the Work in Progress (WIP) window extracted for review.',
    `billing_period_start_date` DATE COMMENT 'First date of the billing period covered by this prebill. Defines the inclusive start of the Work in Progress (WIP) window extracted for review.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the prebill record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this prebill (e.g., USD, GBP, EUR). Supports multi-currency billing for international matters.. Valid values are `^[A-Z]{3}$`',
    `disbursement_adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustment applied to disbursements on this prebill. Positive values indicate write-up; negative values indicate write-down or non-billable disbursement exclusions.',
    `fee_arrangement_type` STRING COMMENT 'Classification of the billing fee structure applied to this prebill. Determines how WIP is calculated and presented: hourly (time-based), flat_fee (fixed amount), contingency (outcome-based percentage), afa (Alternative Fee Arrangement), blended_rate (composite rate across timekeepers), retainer (periodic fixed fee). [ENUM-REF-CANDIDATE: hourly|flat_fee|contingency|afa|blended_rate|retainer — promote to reference product]. Valid values are `hourly|flat_fee|contingency|afa|blended_rate|retainer`',
    `fee_writedown_amount` DECIMAL(18,2) COMMENT 'Negative adjustment applied to WIP fees to reduce the billed amount below the standard rate value. Reflects billing guideline compliance, client relationship management, or billing attorney discretion. Stored as a positive number representing the reduction.',
    `fee_writeup_amount` DECIMAL(18,2) COMMENT 'Positive adjustment applied to WIP fees to increase the billed amount above the standard rate value. Reflects premium billing for exceptional work, complexity, or successful outcomes. A zero value indicates no write-up was applied.',
    `generated_date` DATE COMMENT 'Calendar date on which the prebill draft was generated from the WIP ledger. Represents the principal business event timestamp for the prebill lifecycle.',
    `guideline_violation_count` STRING COMMENT 'Number of individual billing guideline violations detected on this prebill during automated compliance checking. A count of zero indicates full compliance. Used to prioritize prebill review effort.',
    `narrative_edited` BOOLEAN COMMENT 'Indicates whether any time entry or disbursement narrative was edited during the prebill review process. True = narratives were modified; False = original narratives retained. Supports billing quality audit and Legal Professional Privilege (LPP) review.',
    `office_code` STRING COMMENT 'Code identifying the firm office responsible for this prebill. Supports revenue allocation, profitability reporting, and Revenue Per Equity Partner (RPE) calculations at the office level.',
    `on_account_credit_applied` DECIMAL(18,2) COMMENT 'Amount of retainer or on-account funds applied against this prebill to reduce the net amount due. Relevant for matters operating under a retainer or advance payment arrangement. Zero if no on-account funds are applied.',
    `prebill_number` STRING COMMENT 'Externally visible, human-readable identifier for the prebill draft. Used by billing staff and attorneys to reference the prebill during review and approval workflows. Format: PB-YYYY-NNNNNN.. Valid values are `^PB-[0-9]{4}-[0-9]{6}$`',
    `prebill_status` STRING COMMENT 'Current workflow state of the prebill in the billing quality control process. Drives routing logic: draft (initial WIP extraction), under_review (sent to billing attorney), approved (ready for invoice generation), rejected (returned for correction), on_hold (pending client instruction), cancelled (abandoned). [ENUM-REF-CANDIDATE: draft|under_review|approved|rejected|on_hold|cancelled — promote to reference product]. Valid values are `draft|under_review|approved|rejected|on_hold|cancelled`',
    `prior_balance_amount` DECIMAL(18,2) COMMENT 'Outstanding accounts receivable balance from prior invoices for this matter as of the prebill generation date. Displayed on the prebill for attorney awareness and collections follow-up context.',
    `proposed_disbursements_amount` DECIMAL(18,2) COMMENT 'Net disbursement amount proposed for invoicing after applying disbursement adjustments. Represents the billable expense total to be carried forward to the final invoice.',
    `proposed_fees_amount` DECIMAL(18,2) COMMENT 'Net fee amount proposed for invoicing after applying write-up and write-down adjustments to WIP fees. Equals wip_fees_amount plus fee_writeup_amount minus fee_writedown_amount.',
    `proposed_total_amount` DECIMAL(18,2) COMMENT 'Total proposed invoice value combining adjusted fees and adjusted disbursements. This is the gross amount that will appear on the final invoice if the prebill is approved without further changes.',
    `rejection_reason` STRING COMMENT 'Free-text or coded reason provided by the reviewing attorney when rejecting the prebill. Documents the basis for rejection (e.g., narrative edits required, rate corrections needed, time entries disputed) to guide billing staff corrections.',
    `sent_for_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the prebill was dispatched to the billing attorney for review. Marks the transition from draft to under_review status. Used to measure prebill review cycle time.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this prebill record was extracted. Supports data lineage tracking in the Databricks Silver layer. Expected values: elite_3e (Elite 3E Practice Management), aderant_expert (Aderant Expert Time and Billing).. Valid values are `elite_3e|aderant_expert`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Applicable tax (e.g., VAT, GST, sales tax) calculated on the proposed billable amounts. Jurisdiction-dependent; may be zero for exempt matters or jurisdictions where legal services are not taxable.',
    `timekeeper_count` STRING COMMENT 'Number of distinct timekeepers (attorneys, paralegals, legal assistants) whose time entries are included in this prebill. Used for staffing analysis and billing guideline compliance (e.g., restrictions on number of timekeepers per matter).',
    `total_hours_billed` DECIMAL(18,2) COMMENT 'Aggregate billable hours included in this prebill across all timekeepers and time entries within the billing period. Applicable for hourly and blended-rate fee arrangements.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the prebill record. Tracks changes during the review, editing, and approval workflow.',
    `wip_disbursements_amount` DECIMAL(18,2) COMMENT 'Total gross value of unbilled disbursement and expense entries extracted for this prebill before any adjustments. Includes hard costs (court fees, filing fees, expert witness fees) and soft costs (photocopying, postage).',
    `wip_fees_amount` DECIMAL(18,2) COMMENT 'Total gross value of unbilled fee time entries (Work in Progress) extracted for this prebill before any adjustments. Represents the raw billable fees from timekeeper entries within the billing period.',
    `wip_total_amount` DECIMAL(18,2) COMMENT 'Combined gross value of all WIP fees and disbursements extracted for this prebill prior to any write-up, write-down, or adjustment. Equals wip_fees_amount plus wip_disbursements_amount.',
    CONSTRAINT pk_prebill PRIMARY KEY(`prebill_id`)
) COMMENT 'Pre-invoice draft generated from WIP for attorney review and approval before final invoice issuance. Captures prebill number, matter reference, billing attorney, billing period, total WIP value, proposed adjustments, write-up/write-down amounts, and prebill status (draft, under review, approved, rejected). Supports the prebilling workflow including partner review, narrative editing, and billing guideline compliance checks. Central to the legal billing quality control process.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the invoice record in the billing system. Primary key for the invoice data product in the Databricks Silver layer.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.contract_agreement. Business justification: Invoices in legal services are directly governed by a contract agreement that sets payment terms, billing frequency, LEDES format, and dispute resolution method. Direct FK enables invoice-level contra',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Invoices bill work performed on litigation matters with dockets. Critical for client billing, LEDES submission, litigation cost tracking, and matter-level revenue recognition in court cases.',
    `fee_arrangement_id` BIGINT COMMENT 'FK to billing.fee_arrangement.fee_arrangement_id — Invoices are generated under the terms of a fee arrangement. This FK enables fee cap compliance checking and AFA billing validation.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Post-amendment invoices must reference the governing amendment to ensure correct rate application and billing guideline version compliance. Legal e-billing audits and client disputes frequently requir',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Invoices are issued for a specific legal service delivered. Legal finance teams report revenue by service type for service profitability analysis and client billing transparency. practice_area is alre',
    `matter_id` BIGINT COMMENT 'Reference to the primary matter for which legal services are billed. A single invoice may span multiple matters; this captures the primary or controlling matter.',
    `originating_invoice_id` BIGINT COMMENT 'For credit notes and adjustment invoices, the invoice_id of the original invoice being credited, reversed, or adjusted. Null for standard invoices. Enables full credit note lineage tracing.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Invoices are analyzed by practice area for revenue recognition, realization reporting, and profitability analysis. Practice area is the primary dimension for financial reporting, partner compensation,',
    `profile_id` BIGINT COMMENT 'Reference to the client entity to whom this invoice is addressed. Supports client-level AR aging, collections, and revenue reporting.',
    `amount_paid` DECIMAL(18,2) COMMENT 'Cumulative amount received against this invoice to date. Used to calculate the outstanding balance and determine partially_paid vs paid status.',
    `approved_by` STRING COMMENT 'Name or identifier of the partner or billing manager who approved this invoice for issuance during the prebilling review process. Required for audit trail and partner sign-off compliance.',
    `approved_date` DATE COMMENT 'Date on which the billing partner or authorised approver signed off on the invoice during the prebilling review stage. Marks the transition from draft/WIP to issued status.',
    `billing_office_code` STRING COMMENT 'Code identifying the firm office responsible for billing this invoice. Used for office-level revenue reporting, GL allocation, and multi-office financial consolidation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `billing_period_end` DATE COMMENT 'End date of the billing period covered by this invoice. Together with billing_period_start, defines the WIP window captured on this bill.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period covered by this invoice. Defines the range of time entries, disbursements, and WIP included in the bill.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the billing system (Elite 3E or Aderant Expert). Provides the audit trail creation marker for the Silver layer record.',
    `credit_application_status` STRING COMMENT 'Tracks whether a credit note has been applied against outstanding invoices. Pending means unapplied; applied means fully offset; partially_applied means partially offset; voided means the credit was cancelled. Populated only for credit notes.. Valid values are `pending|applied|partially_applied|voided`',
    `credit_reason` STRING COMMENT 'Narrative explanation for the issuance of a credit note, including the business justification (e.g., billing error, fee reduction, client dispute resolution, write-off). Populated only when invoice_type = credit_note.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this invoice (e.g., USD, GBP, EUR). Supports multi-currency billing for international clients and cross-border matters.. Valid values are `^[A-Z]{3}$`',
    `disbursements_amount` DECIMAL(18,2) COMMENT 'Total of all client disbursements (hard costs and soft costs) billed on this invoice, including court filing fees, expert witness fees, travel, and photocopying charges.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary discount applied to this invoice, including courtesy discounts, volume discounts, and write-downs negotiated under AFA or client billing guidelines. Reduces the gross fees amount.',
    `dispute_reason` STRING COMMENT 'Client-provided reason for disputing the invoice (e.g., rate discrepancy, unapproved timekeeper, excessive hours, duplicate charge). Populated when invoice_status = disputed.',
    `dispute_resolution_date` DATE COMMENT 'Date on which a disputed invoice was resolved, either through client agreement, write-down, or credit note issuance. Used to measure dispute cycle time and collections effectiveness.',
    `due_date` DATE COMMENT 'Date by which payment is contractually due per the engagement letter or client billing agreement. Used to calculate overdue status and trigger collections workflows.',
    `ebilling_portal` STRING COMMENT 'Name or identifier of the clients e-billing portal to which the LEDES invoice was submitted (e.g., TyMetrix 360, Legal Tracker, BillingPoint, Passport). Null if not submitted electronically.',
    `ebilling_rejection_reason` STRING COMMENT 'Reason code or narrative returned by the clients e-billing portal when an invoice submission is rejected (e.g., invalid UTBMS task code, rate not approved, timekeeper not enrolled). Populated only when ebilling_submission_status = rejected.',
    `ebilling_submission_date` DATE COMMENT 'Date the LEDES-formatted invoice was submitted to the clients e-billing portal. Used to track submission timeliness and SLA compliance with client billing guidelines.',
    `ebilling_submission_status` STRING COMMENT 'Current status of the LEDES e-billing portal submission. Tracks the full submission lifecycle from initial upload through acceptance or rejection by the clients billing system.. Valid values are `not_submitted|submitted|accepted|rejected|resubmitted`',
    `fee_arrangement_type` STRING COMMENT 'Type of fee arrangement governing this invoice. Determines how fees are calculated and reported. AFA (Alternative Fee Arrangement) includes fixed, capped, and success-fee structures. [ENUM-REF-CANDIDATE: hourly|flat_fee|contingency|blended_rate|afa|retainer|success_fee|hybrid — promote to reference product]. Valid values are `hourly|flat_fee|contingency|blended_rate|afa|retainer`',
    `fees_amount` DECIMAL(18,2) COMMENT 'Gross total of all professional fees (time charges) billed on this invoice before discounts, taxes, or write-downs. Represents the sum of all timekeeper hours multiplied by applicable rates.',
    `gl_account_code` STRING COMMENT 'General Ledger account code to which this invoices revenue is posted in the firms financial system. Supports SOX-compliant financial reporting and revenue recognition.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `invoice_date` DATE COMMENT 'The official date the invoice was issued to the client. This is the principal business event date used for revenue recognition, aging calculations, and LEDES e-billing submission headers.',
    `invoice_number` STRING COMMENT 'Externally visible, human-readable invoice reference number assigned by the billing system (e.g., Elite 3E or Aderant Expert). Used on all client-facing documents, LEDES e-billing submissions, and payment remittances.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle state of the invoice. Drives AR aging, collections workflow, and revenue recognition. Valid states: draft (prebill stage), issued (sent to client), disputed (client raised objection), paid (fully settled), partially_paid (partial remittance received), written_off (uncollectable balance removed), credited (credit note applied). [ENUM-REF-CANDIDATE: draft|issued|disputed|paid|partially_paid|written_off|credited — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document. Standard is a regular bill; credit_note is a negative invoice reversing or adjusting a prior bill; proforma is a preliminary estimate; interim is a progress bill on a long-running matter; final closes out all WIP on a matter.. Valid values are `standard|credit_note|proforma|interim|final`',
    `is_electronic_billing` BOOLEAN COMMENT 'Indicates whether this invoice is subject to electronic billing via a LEDES-compliant e-billing portal. True = invoice must be submitted electronically; False = paper or email delivery.',
    `ledes_format_version` STRING COMMENT 'Version of the LEDES (Legal Electronic Data Exchange Standard) format used for electronic billing submission to corporate clients or insurance carriers. Null if invoice is not submitted via e-billing portal.. Valid values are `LEDES1998B|LEDES1998BI|LEDESXML21|LEDESXML22`',
    `net_amount` DECIMAL(18,2) COMMENT 'Total amount due from the client after applying fees, disbursements, discounts, and taxes. This is the amount the client is expected to remit: (fees_amount + disbursements_amount - discount_amount + tax_amount).',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this invoice (net_amount minus amount_paid). Drives AR aging buckets and collections prioritisation. Updated upon each payment application.',
    `payment_terms` STRING COMMENT 'Contractual payment terms applicable to this invoice as defined in the letter of engagement (LOE) or client billing agreement (e.g., net_30 = payment due within 30 days of invoice date).. Valid values are `net_30|net_45|net_60|due_on_receipt|net_90`',
    `resubmission_count` STRING COMMENT 'Number of times this invoice has been resubmitted to the e-billing portal following a rejection. Tracks resubmission history for operational efficiency and client relationship management.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on this invoice (e.g., VAT, GST, or applicable sales tax). Calculated based on the taxable fee and disbursement amounts and the applicable tax rate for the jurisdiction.',
    `tax_jurisdiction` STRING COMMENT 'ISO country or state/province code identifying the tax jurisdiction governing the tax calculation on this invoice. Determines applicable VAT, GST, or sales tax rules.. Valid values are `^[A-Z]{2,3}$`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (as a decimal fraction, e.g., 0.2000 for 20% VAT) used to calculate the tax_amount on this invoice. Varies by jurisdiction and service type.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the invoice record in the billing system. Tracks status changes, payment applications, dispute updates, and write-off entries.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Monetary amount written off on this invoice as uncollectable or as a billing adjustment. Impacts WIP write-off reporting and partner profitability metrics (PPP, PEP).',
    `write_off_reason` STRING COMMENT 'Narrative or coded reason for the write-off (e.g., client insolvency, fee dispute settlement, courtesy adjustment, billing error). Required for financial audit trail and partner approval workflows.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Authoritative billing document issued to a client for legal services rendered on one or more matters. Captures invoice number, invoice date, billing period, total fees, total disbursements, tax amounts, discounts, net amount due, currency, and invoice status lifecycle (draft, issued, disputed, paid, partially paid, written off, credited). Supports LEDES 1998B and LEDES XML electronic billing formats for corporate clients and insurance carriers. Encompasses credit notes (negative invoices with credit reason, originating invoice reference, and application status) and LEDES e-billing portal submission tracking (submission date, format version, target portal, submission status, rejection reasons, and resubmission history). Provides complete invoice-to-payment lifecycle visibility including dispute resolution and collections integration.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique surrogate identifier for each invoice line item within the billing domain. Primary key for the invoice_line data product in the Databricks Silver Layer.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.asset. Business justification: Invoice line items in IP matters routinely specify which patent, trademark, or copyright the work/expense relates to for client billing guideline compliance, LEDES submission requirements, and portfol',
    `billing_disbursement_id` BIGINT COMMENT 'Reference to the originating disbursement or expense record from which this invoice line was generated. Null for time-based or flat fee lines. Enables disbursement traceability and client cost recovery reconciliation.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Invoice line items reference dockets for detailed billing transparency, LEDES format compliance, and client billing guideline validation in litigation matters.',
    `time_entry_id` BIGINT COMMENT 'FK to billing.time_entry.time_entry_id — Invoice lines that represent billed time must trace back to their originating time entry for audit trail, LEDES compliance, and dispute resolution. This is the core traceability link in legal billing.',
    `hearing_id` BIGINT COMMENT 'Foreign key linking to court.hearing. Business justification: Line items for hearing-related work (preparation, appearance, follow-up) reference specific hearings for client transparency, UTBMS compliance, and billing guideline validation.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Invoice line items reference supporting documents (engagement letters for rate justification, court orders for fee awards). Required for LEDES billing compliance, billing guideline validation, and dis',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Invoice lines represent individual billable items for a specific legal service. Legal billing systems report revenue by service type at the line level for LEDES compliance, client billing transparency',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this billing line item is attributed. Enables matter-level revenue reporting, WIP reconciliation, and client billing guideline compliance checks.',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header to which this line item belongs. Establishes the header/detail relationship for invoice line aggregation and LEDES electronic billing submissions.',
    `primary_invoice_time_entry_id` BIGINT COMMENT 'Reference to the originating time entry record from which this invoice line was generated. Provides full traceability from the billed line back to the WIP time entry in Elite 3E. Null for disbursement or flat fee lines.',
    `approved_by` STRING COMMENT 'The name or identifier of the billing partner, billing coordinator, or supervisor who approved this line item for inclusion on the invoice during the prebilling review process. Supports billing approval workflow audit trails.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which this line item was approved during the prebilling review workflow. Used for billing cycle time analysis and audit trail compliance.',
    `billed_amount` DECIMAL(18,2) COMMENT 'The gross amount billed to the client for this line item after applying the billing rate to the quantity, and before any write-up or write-down adjustments. Expressed in the invoice currency. Core monetary fact for revenue recognition and AR reporting.',
    `billing_guideline_compliant` BOOLEAN COMMENT 'Indicates whether this line item has been validated as compliant with the clients outside counsel billing guidelines (OCGs). False indicates a potential guideline violation (e.g., block billing, excessive hours, non-compliant timekeeper rate) that may result in client rejection or reduction.',
    `billing_guideline_exception_reason` STRING COMMENT 'Free-text description of the reason this line item was flagged as non-compliant with client billing guidelines. Populated when billing_guideline_compliant is False. Used by billing coordinators to resolve exceptions before invoice submission.',
    `billing_rate` DECIMAL(18,2) COMMENT 'The hourly billing rate applied to this line item in the invoice currency, as agreed in the engagement letter or client rate schedule. Confidential as it reflects negotiated client-specific pricing. Null for disbursement and flat fee lines.',
    `client_rejected` BOOLEAN COMMENT 'Indicates whether this line item was rejected by the client or their legal spend management system after invoice submission. Rejected lines require resolution (write-off, resubmission, or dispute) and are excluded from collected revenue until resolved.',
    `client_rejection_reason` STRING COMMENT 'The reason provided by the client or their e-billing platform for rejecting this line item. Populated when client_rejected is True. Used to identify systemic billing guideline compliance issues and improve future billing quality.',
    `cost_center_code` STRING COMMENT 'The cost center or profit center code associated with the practice group or office responsible for this line item. Used for internal profitability reporting, partner compensation calculations, and PPP/PEP financial KPI attribution.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this invoice line record was first created in the billing system. Used for audit trail, data lineage, and billing cycle time analysis in the Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the currency in which this line item is denominated (e.g., USD, GBP, EUR). Supports multi-currency billing for international matters and foreign currency realization reporting.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert this line item from the billing currency to the firms functional currency at the time of invoicing. Relevant for international matters billed in a currency other than the firms base currency. Null for lines in the functional currency.',
    `fee_arrangement_type` STRING COMMENT 'The type of fee arrangement under which this line item is billed. Reflects the engagement-level fee structure: hourly (standard time-based), contingency (success-based), flat_fee (fixed price), Alternative Fee Arrangement (AFA), blended_rate (single rate across timekeepers), or capped_fee (hourly with a ceiling). Drives billing logic and revenue recognition treatment.. Valid values are `hourly|contingency|flat_fee|afa|blended_rate|capped_fee`',
    `from_disbursement` BIGINT COMMENT 'FK to billing.disbursement.disbursement_id — Invoice lines representing expenses must trace back to the originating disbursement record. Required for LEDES compliance and client billing guideline validation.',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code to which the revenue or expense for this line item is posted in the firms financial system. Enables reconciliation between the billing sub-ledger and the GL for financial reporting and SOX compliance.',
    `hours_worked` DECIMAL(18,2) COMMENT 'The number of hours recorded for this time-based line item, expressed in decimal format (e.g., 1.50 for one hour thirty minutes). Null for disbursement and flat fee lines. The billable unit of measure for time charges before rate application.',
    `ledes_export_timestamp` TIMESTAMP COMMENT 'The date and time at which this line item was last exported in a LEDES electronic billing file for submission to the client or their e-billing platform. Null if the line has not yet been exported. Used to track LEDES submission status and prevent duplicate submissions.',
    `ledes_line_item_number` STRING COMMENT 'The line item number as formatted and exported in the LEDES electronic billing file submitted to the client or their legal spend management platform. Ensures traceability between the internal billing record and the external LEDES submission.',
    `line_sequence` STRING COMMENT 'Sequential ordering number of this line item within the parent invoice. Used to maintain the presentation order of line items on the invoice as rendered to the client and in LEDES output files.',
    `line_status` STRING COMMENT 'Current workflow status of the invoice line item within the billing lifecycle. Draft lines are in prebilling review; approved lines are ready for invoice generation; billed lines have been sent to the client; written_off lines have been removed from AR; on_hold lines are pending client or internal review.. Valid values are `draft|approved|billed|written_off|on_hold`',
    `line_type` STRING COMMENT 'Classification of the invoice line item indicating whether it represents a time charge, a disbursement/expense, a flat fee component, an Alternative Fee Arrangement (AFA) component, a tax charge, or a credit adjustment. Drives downstream billing logic and LEDES field mapping.. Valid values are `time|disbursement|flat_fee|afa_component|tax|credit`',
    `lpp_protected` BOOLEAN COMMENT 'Indicates whether the narrative or details of this line item are subject to Legal Professional Privilege (LPP) and must be redacted or withheld in any disclosure to third parties. Critical for eDiscovery, regulatory investigations, and client data sharing compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time at which this invoice line record was last modified in the billing system. Tracks prebilling edits, write-up/write-down adjustments, and status changes for audit trail and data lineage purposes.',
    `narrative` STRING COMMENT 'The descriptive text narrative for this line item as it appears on the client invoice. Describes the legal work performed or disbursement incurred. Subject to billing guideline requirements for narrative specificity. May be edited from the original time entry description during prebilling review.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final net amount for this line item after applying write-up/write-down adjustments to the billed amount. This is the amount that contributes to the invoice total and is recognized as revenue. Equals billed_amount plus write_up_down_amount.',
    `original_narrative` STRING COMMENT 'The unedited narrative text from the originating time entry or disbursement record before any prebilling edits were applied. Retained for audit trail purposes and to support billing guideline compliance reviews comparing original versus billed descriptions.',
    `phase_code` STRING COMMENT 'The matter phase or stage code to which this line item is attributed (e.g., Phase 1 - Due Diligence, Phase 2 - Negotiation). Used in phased billing arrangements and Legal Project Management (LPM) budget tracking to allocate costs to defined matter phases.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity or unit count for this line item. For time lines this mirrors hours_worked; for disbursement lines it represents the number of units (e.g., pages copied, miles travelled). Used in conjunction with billing_rate to derive the billed amount.',
    `sources_disbursement` BIGINT COMMENT 'FK to billing.disbursement.disbursement_id — Invoice lines that represent billed disbursements must trace back to the originating disbursement record for cost recovery tracking and LEDES compliance.',
    `standard_rate` DECIMAL(18,2) COMMENT 'The timekeepers standard rack rate at the time of billing, before any client-specific discounts or negotiated rate reductions. Used to calculate write-up/write-down variance and to support rate realization analysis for PPP and RPE KPI reporting.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount applicable to this line item (e.g., VAT, GST, or sales tax) calculated based on the applicable tax code and jurisdiction. Null if the line item is tax-exempt. Required for tax reporting and compliance with jurisdiction-specific tax regulations.',
    `tax_code` STRING COMMENT 'The tax code applied to this line item identifying the applicable tax rate and jurisdiction rule (e.g., VAT20, EXEMPT, ZERO). Drives automated tax calculation in Elite 3E and supports VAT/GST return preparation and audit compliance.',
    `timekeeper_level` STRING COMMENT 'The seniority classification of the timekeeper who performed the work on this line item (e.g., partner, senior associate, associate, paralegal). Denormalized from the timekeeper record for billing analytics and client billing guideline compliance without requiring a join. [ENUM-REF-CANDIDATE: partner|senior_associate|associate|paralegal|trainee|of_counsel|staff_attorney|law_clerk — promote to reference product]. Valid values are `partner|senior_associate|associate|paralegal|trainee|of_counsel`',
    `utbms_activity_code` STRING COMMENT 'UTBMS activity code describing the specific activity performed within the task (e.g., A101 for Plan and Prepare, A102 for Research). Used alongside the task code in LEDES billing files to provide granular task-based cost management data to clients.',
    `utbms_expense_code` STRING COMMENT 'UTBMS expense code classifying the type of disbursement on this line item (e.g., E101 for Copying, E106 for Computer Research). Populated only for disbursement line types. Required for LEDES electronic billing of expense items.',
    `utbms_task_code` STRING COMMENT 'UTBMS task code classifying the legal work performed on this line item (e.g., L110 for Fact Investigation, L210 for Pleadings). Mandatory for LEDES electronic billing submissions and client billing guideline compliance. Sourced from the UTBMS code set maintained by the ABA and ACCA.',
    `wip_amount` DECIMAL(18,2) COMMENT 'The original Work in Progress (WIP) value of this line item at the standard billing rate before any prebilling adjustments, write-ups, or write-downs. Used to calculate the realization rate (net_amount / wip_amount) and to reconcile WIP balances in the general ledger.',
    `work_date` DATE COMMENT 'The calendar date on which the legal work or disbursement represented by this line item was performed. Distinct from the invoice date. Used for WIP aging analysis, billing guideline compliance (e.g., time entry submission within N days of work), and matter timeline reporting.',
    `write_off_reason_code` STRING COMMENT 'Coded reason for any write-off or write-down applied to this line item (e.g., CLIENT_DISPUTE, BILLING_ERROR, COURTESY_REDUCTION, BUDGET_CAP). Populated when write_up_down_amount is negative. Supports write-off analysis and partner compensation adjustments.',
    `write_up_down_amount` DECIMAL(18,2) COMMENT 'The monetary adjustment applied to this line item at the prebilling or billing stage. A positive value represents a write-up (increase above standard); a negative value represents a write-down (reduction below standard). Critical for realization rate analysis and partner compensation calculations.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line item on a legal invoice representing a single time entry, disbursement, or flat fee component. Captures UTBMS task code, activity code, timekeeper, narrative, quantity, rate, amount, tax code, and line-level write-up/write-down adjustments. Provides the granular detail required for LEDES electronic billing submissions and client billing guideline compliance. Each line traces back to an originating time entry or disbursement record.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`fee_arrangement` (
    `fee_arrangement_id` BIGINT COMMENT 'Unique surrogate identifier for the fee arrangement record. Primary key for the fee_arrangement data product in the billing domain.',
    `delivery_model_id` BIGINT COMMENT 'Foreign key linking to service.delivery_model. Business justification: The delivery model (managed service, project-based, on-demand) directly determines fee arrangement structure and AFA type. Legal pricing teams structure fee arrangements based on delivery model. This ',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Engagement opportunities capture AFA type and estimated matter value that directly feed fee arrangement setup. Business development reporting on won-opportunity-to-fee-arrangement conversion and AFA a',
    `guideline_id` BIGINT COMMENT 'Foreign key linking to billing.billing_guideline. Business justification: Fee arrangements must comply with client-specific billing guidelines (outside counsel guidelines) that govern rate caps, timekeeper restrictions, and billing format requirements. Currently fee_arrange',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Fee arrangements govern how a specific legal service is billed. Legal pricing teams negotiate AFAs and fixed fees for defined service scopes. billing_fee_arrangement links to pricing_model and rate_ca',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case to which this fee arrangement applies. A fee arrangement governs how WIP is converted to invoiced amounts for the associated matter.',
    `package_id` BIGINT COMMENT 'Foreign key linking to service.package. Business justification: Fee arrangements are frequently structured around a service package (e.g., fixed-fee litigation package, M&A transaction package). Legal operations teams track which service package a fee arrangement ',
    `parent_arrangement_billing_fee_arrangement_id` BIGINT COMMENT 'Self-referencing identifier pointing to the original or predecessor fee arrangement that this record amends or supersedes. Enables reconstruction of the full amendment history chain. Null for original (version 1) arrangements.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Fee arrangements are scoped to practice areas for engagement structuring, conflict checking, and approval workflows. Practice area determines pricing authority, AFA eligibility, and engagement letter ',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Fee arrangements implement pricing models (hourly, fixed fee, contingency, blended, AFA). Pricing model defines calculation rules, billing frequency, payment terms, and revenue recognition used in eng',
    `profile_id` BIGINT COMMENT 'Reference to the client entity that is party to this fee arrangement. Supports portfolio-level fee arrangements spanning multiple matters for the same client.',
    `rate_card_id` BIGINT COMMENT 'Reference to the negotiated rate card defining timekeeper-level or role-level hourly rates applicable under this fee arrangement. Used for hourly and blended rate arrangements to constrain rates during time entry and prebilling in Aderant Expert.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Fee arrangements must comply with specific regulatory obligations (SRA transparency rules, consumer protection pricing disclosure). Legal compliance teams track which regulatory obligation mandates ea',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to intake.rfp_submission. Business justification: Won RFP submissions specify fee arrangement types and estimated values that directly govern fee arrangement creation. Pitch-to-revenue reporting and panel compliance tracking require tracing fee arran',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: Fee arrangements in legal firms incorporate SLA commitments (response time guarantees, delivery milestones tied to fee structure). Legal operations teams link SLA templates to fee arrangements for bre',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Client service tier directly determines fee arrangement terms and AFA eligibility (Tier 1 clients receive different structures). Legal pricing teams set fee arrangements based on client tier. This lin',
    `agreed_amount` DECIMAL(18,2) COMMENT 'The total agreed fee amount for flat fee, capped fee, retainer, subscription, and success fee arrangements. Represents the contractually committed monetary value. For hourly and blended rate arrangements, this field is null and rate fields govern billing. Expressed in the arrangement currency.',
    `amendment_version` STRING COMMENT 'Sequential version number tracking amendments to the fee arrangement. Version 1 represents the original arrangement; subsequent amendments increment this counter. Supports audit trail and supersession chain tracking in Elite 3E.',
    `approved_by` STRING COMMENT 'Name or identifier of the partner or authorized approver who sanctioned this fee arrangement on behalf of the firm. Required for AFA arrangements above firm-defined approval thresholds. Supports governance and audit trail requirements.',
    `approved_date` DATE COMMENT 'Date on which the fee arrangement was formally approved by the authorized partner or pricing committee. Marks the transition from draft to active status and triggers engagement setup workflows in Elite 3E.',
    `arrangement_number` STRING COMMENT 'Externally-known unique business identifier for the fee arrangement, used in client communications, engagement letters (LOE), and billing correspondence. Typically follows firm-defined numbering conventions in Elite 3E.',
    `arrangement_status` STRING COMMENT 'Current lifecycle state of the fee arrangement. Controls whether the arrangement is actively governing billing operations. Draft indicates pending approval; active indicates currently in force; suspended indicates temporarily paused; expired indicates past effective end date; terminated indicates early cancellation; superseded indicates replaced by a newer arrangement.. Valid values are `draft|active|suspended|expired|terminated|superseded`',
    `billing_frequency` STRING COMMENT 'Agreed cadence at which invoices are generated and submitted to the client under this fee arrangement. Governs the prebilling cycle in Elite 3E and Aderant Expert. Milestone-based frequency requires milestone trigger configuration. [ENUM-REF-CANDIDATE: monthly|quarterly|semi_annual|annual|milestone|on_demand|upon_completion — 7 candidates stripped; promote to reference product]',
    `blended_hourly_rate` DECIMAL(18,2) COMMENT 'Single agreed hourly rate applied uniformly across all timekeepers on the matter, regardless of individual timekeeper seniority or standard rate. Used for blended rate AFA arrangements. Null for non-blended arrangements.',
    `contingency_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of the recovery or settlement amount payable to the firm under a contingency fee arrangement. Expressed as a decimal percentage (e.g., 33.3333 for 33.33%). Null for non-contingency arrangement types. Governed by jurisdiction-specific caps on contingency fees.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee arrangement record was first created in the system. Represents the audit creation event. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per firm data standards.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the fee arrangement amounts are denominated (e.g., USD, GBP, EUR). Governs currency conversion rules during invoice generation and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `discount_pct` DECIMAL(18,2) COMMENT 'Negotiated discount percentage applied to standard rates or fees under this arrangement. Expressed as a decimal percentage (e.g., 10.0000 for 10%). Reduces the billable amount during invoice generation. Supports client relationship management and competitive pricing strategies.',
    `effective_date` DATE COMMENT 'Date from which the fee arrangement becomes binding and governs billing for the associated matter or client portfolio. Aligns with the engagement commencement date in the Letter of Engagement (LOE).',
    `expense_cap_amount` DECIMAL(18,2) COMMENT 'Maximum disbursement or expense amount the firm may incur and bill to the client under this arrangement without prior written approval. Governs disbursement billing controls during invoice generation.',
    `expenses_billable` BOOLEAN COMMENT 'Indicates whether disbursements and out-of-pocket expenses are billable to the client under this fee arrangement. When false, all expenses are absorbed by the firm. Governs disbursement line inclusion during prebilling.',
    `expiry_date` DATE COMMENT 'Date on which the fee arrangement ceases to be binding. Nullable for open-ended arrangements. When populated, triggers review or renewal workflows in Elite 3E. Distinct from termination date which reflects early cancellation.',
    `fee_cap_amount` DECIMAL(18,2) COMMENT 'Maximum billable amount under a capped fee or blended rate arrangement. WIP accrued beyond this threshold cannot be invoiced without client approval or a formal cap amendment. Enforced during prebilling in Elite 3E and Aderant Expert.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code identifying the primary legal jurisdiction governing this fee arrangement. Determines applicable professional conduct rules, fee cap regulations, tax treatment, and LEDES billing format requirements.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the fee arrangement record. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit trail compliance. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per firm data standards.',
    `ledes_billing_format` STRING COMMENT 'LEDES electronic billing format required by the client for invoice submission. Governs the output format of invoices generated from this arrangement. Clients with e-billing portals (e.g., TyMetrix, Legal Tracker) mandate specific LEDES versions.. Valid values are `LEDES98B|LEDES98BI|LEDES2000|LEDESXml|none`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which the client is contractually required to remit payment. Standard terms include net-30, net-45, net-60. Used to calculate invoice due dates and trigger collections workflows in Elite 3E accounts receivable.',
    `portfolio_arrangement` BOOLEAN COMMENT 'Indicates whether this fee arrangement governs a portfolio of multiple matters for the same client rather than a single matter. Portfolio arrangements aggregate WIP and billing across matters and require consolidated invoice generation.',
    `retainer_amount` DECIMAL(18,2) COMMENT 'Periodic retainer fee amount payable by the client under a retainer or subscription arrangement. Represents the recurring fixed payment that secures the firms availability. Tracked against IOLTA trust account rules where applicable.',
    `scope_description` STRING COMMENT 'Narrative description of the legal services scope covered by this fee arrangement. Defines the boundaries of work included within the agreed fee, distinguishing in-scope from out-of-scope services that would require a separate arrangement or amendment.',
    `success_fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount payable as a success fee upon achievement of the defined trigger condition. Distinct from contingency_rate_pct which is percentage-based. Null for non-success-fee arrangements.',
    `success_fee_trigger` STRING COMMENT 'Narrative description of the milestone, outcome, or event that triggers the success fee component of the arrangement (e.g., deal closing, favourable judgment, regulatory approval). Applicable only to success fee and hybrid AFA arrangements.',
    `tax_applicable` BOOLEAN COMMENT 'Indicates whether applicable taxes (e.g., VAT, GST, sales tax) are chargeable on invoices generated under this fee arrangement. Drives tax calculation logic in Elite 3E and Aderant Expert during invoice generation.',
    `tax_rate_pct` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage (e.g., VAT, GST) applied to invoices generated under this arrangement when tax_applicable is true. Expressed as a decimal percentage (e.g., 20.0000 for 20% UK VAT). Null when tax_applicable is false.',
    `termination_date` DATE COMMENT 'Date on which the fee arrangement was early-terminated prior to its scheduled expiry date. Populated only when arrangement_status is terminated. Distinct from expiry_date which reflects the originally agreed end date.',
    `termination_reason` STRING COMMENT 'Reason code explaining why the fee arrangement was terminated prior to its scheduled expiry. Supports client relationship analytics and risk management reporting. Populated only when arrangement_status is terminated. [ENUM-REF-CANDIDATE: matter_closed|client_request|firm_withdrawal|superseded|breach|regulatory|other — 7 candidates stripped; promote to reference product]',
    `utbms_task_code_set` STRING COMMENT 'UTBMS task code set applicable to this fee arrangement, governing how time entries and disbursements are categorized for task-based billing. Required for LEDES-compliant invoice submission and client billing guideline compliance.. Valid values are `litigation|counseling|project_finance|bankruptcy|none`',
    `wip_conversion_rule` STRING COMMENT 'Rule governing how accumulated WIP is converted to invoiced amounts under this fee arrangement. Determines the timing and method of WIP recognition during prebilling. Critical for revenue recognition and financial reporting under the billing domain.. Valid values are `bill_as_incurred|bill_at_completion|bill_at_milestone|bill_at_cap|pro_rata`',
    `write_off_limit_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of WIP that the billing attorney may write off during prebilling without escalating to partner or management approval. Enforces write-off governance controls in Aderant Expert and Elite 3E.',
    CONSTRAINT pk_fee_arrangement PRIMARY KEY(`fee_arrangement_id`)
) COMMENT 'Master record defining the agreed fee structure between the firm and a client for a specific matter or portfolio of matters. Captures AFA type (hourly, flat fee, contingency, capped fee, blended rate, success fee, retainer, subscription), agreed amounts or rate caps, billing frequency, milestone triggers, and approval metadata. Governs how WIP is converted to invoiced amounts and constrains the billing rules applied during prebilling and invoice generation.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`billing_payment` (
    `billing_payment_id` BIGINT COMMENT 'Unique surrogate identifier for each payment transaction record in the billing system. Primary key for the payment data product.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Legal firms must screen payments under a specific AML/KYC program (FATF, SRA requirements). Tracing which AML program governed a payments screening is a named compliance process; aml_screening_status',
    `account_id` BIGINT COMMENT 'Reference to the client trust or IOLTA account from which funds were transferred, applicable when payment_type is trust_transfer or retainer_drawdown. Supports IOLTA compliance, trust accounting reconciliation, and regulatory reporting.',
    `billing_bank_account_id` BIGINT COMMENT 'Reference to the firms internal bank account record into which the payment was deposited (e.g., operating account, IOLTA/trust account, client account). Supports bank reconciliation and IOLTA compliance reporting.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Clients often remit payments referencing specific dockets/cases. Tracking payment-to-docket enables matter-level AR reconciliation, client account management, and litigation cost recovery tracking.',
    `invoice_id` BIGINT COMMENT 'Reference to the primary invoice satisfied by this payment. For partial or multi-invoice payments, the dominant invoice is recorded here; full allocation detail is captured in the payment allocation lines.',
    `matter_id` BIGINT COMMENT 'Reference to the primary matter against which this payment is applied. For multi-matter payments, the dominant or first-allocated matter is recorded here; full allocation detail is captured in the payment allocation lines.',
    `original_payment_billing_payment_id` BIGINT COMMENT 'Self-referencing identifier pointing to the original payment record when this record represents a reversal, reapplication, or correction of a prior payment. Enables payment lineage tracing and audit trail for reversed and reprocessed payments.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Corporate treasury departments often make payments on behalf of multiple subsidiaries/client_profiles. Tracking the paying organisation (which may differ from the client_profiles organisation) enable',
    `profile_id` BIGINT COMMENT 'Reference to the client who remitted the payment. Links the payment to the client master record for accounts receivable aging and collections tracking.',
    `retainer_id` BIGINT COMMENT 'Reference to the retainer agreement or retainer balance record from which funds are drawn, applicable when payment_type is retainer_drawdown. Links the payment to the pre-paid retainer for balance tracking and client reporting.',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.ledger_entry. Business justification: Billing payments drawn from trust must be traceable to the corresponding trust ledger entry recording the disbursement. This trust-to-office transfer reconciliation is a mandatory legal trust accounti',
    `allocation_type` STRING COMMENT 'Describes how the received funds are distributed across outstanding invoices. full means the entire invoice balance is satisfied; partial means only a portion of one or more invoices is covered; retainer_drawdown means funds are drawn from a pre-paid retainer; trust_transfer means funds originate from a client trust account; unapplied means no allocation has been made yet.. Valid values are `full|partial|retainer_drawdown|trust_transfer|unapplied`',
    `applied_amount` DECIMAL(18,2) COMMENT 'The total amount of the received funds that has been allocated and posted against one or more outstanding invoices. For fully applied payments, equals received_amount. For partially applied payments, is less than received_amount.',
    `applied_date` DATE COMMENT 'The calendar date on which the received funds were allocated and posted against outstanding invoices in the billing system. May differ from received_date when payments are held in unapplied status pending client direction or prebilling approval.',
    `bank_reference` STRING COMMENT 'The unique transaction reference number assigned by the receiving bank or payment processor for this payment (e.g., SWIFT UETR, CHAPS reference, ACH trace number, cheque number). Used for bank reconciliation, payment tracing, and AML (Anti-Money Laundering) compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the payment record was first created in the billing system. Used for audit trail, data lineage, and compliance with record-keeping obligations.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the currency in which the payment was received from the client (e.g., USD, GBP, EUR). Required for multi-currency billing and foreign exchange reconciliation.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any prompt-payment or early-settlement discount granted to the client and applied at the time of payment, reducing the net amount required to satisfy the invoice. Distinct from write_off_amount which represents a negotiated fee reduction.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the received_amount from the payment currency to the firms functional (base) currency at the time of receipt. A value of 1.0 indicates the payment was received in the firms functional currency. Required for multi-currency AR reporting and financial consolidation.',
    `fee_arrangement_type` STRING COMMENT 'The type of fee arrangement under which the invoices satisfied by this payment were billed. hourly is standard time-based billing; flat_fee is a fixed amount per matter or task; contingency is a percentage of recovery; afa is an Alternative Fee Arrangement (AFA) such as capped fees or success fees; blended_rate is a single rate across all timekeepers; retainer is a pre-paid retainer arrangement.. Valid values are `hourly|flat_fee|contingency|afa|blended_rate|retainer`',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The received_amount converted to the firms functional (base) currency using the exchange_rate at the time of receipt. Used for consolidated financial reporting, PPP (Profit Per Partner), PEP (Profit Per Equity Partner), and RPE (Revenue Per Equity Partner) KPI calculations.',
    `gl_period` STRING COMMENT 'The accounting period (YYYY-MM) to which this payment is posted in the General Ledger (GL). Used for period-close financial reporting, revenue recognition, and SOX compliance. May differ from the calendar month of received_date due to period-end adjustments.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `gl_posting_date` DATE COMMENT 'The date on which the payment was posted to the firms General Ledger (GL), which may differ from the received_date or applied_date due to period-end cut-off rules. Critical for financial period reporting, SOX compliance, and revenue recognition.',
    `is_multi_matter` BOOLEAN COMMENT 'Indicates whether this payment has been allocated across two or more matters. When True, the full allocation detail is captured in the payment allocation lines product. Supports complex multi-matter payment scenario reporting and client account management.',
    `is_reversed` BOOLEAN COMMENT 'Indicates whether this payment has been reversed (e.g., due to a returned cheque, failed ACH, or client dispute). When True, the reversal_date and reversal_reason fields are populated and the previously applied invoice balances are reinstated.',
    `is_trust_payment` BOOLEAN COMMENT 'Indicates whether this payment involves a transfer from a client trust or IOLTA account to the firms operating account. When True, the payment is subject to IOLTA compliance rules and trust accounting reconciliation requirements.',
    `notes` STRING COMMENT 'Free-text field for billing staff to record additional context about the payment, such as client instructions, special allocation directions, collection negotiation notes, or explanations for partial payments. Not intended for structured data.',
    `overpayment_amount` DECIMAL(18,2) COMMENT 'The amount by which the received funds exceed the total outstanding balance of the invoices to which the payment was applied. A non-zero value requires a decision to refund, credit, or hold as a retainer. Supports client credit and refund workflows.',
    `payment_method` STRING COMMENT 'The instrument or mechanism used by the client to remit funds. wire_transfer covers SWIFT/CHAPS/SEPA bank wires; cheque covers paper cheques; ach covers ACH/BACS electronic transfers; credit_card covers card payments; trust_transfer covers transfers from the clients trust/IOLTA account to the office account; retainer_drawdown covers application of a pre-paid retainer balance.. Valid values are `wire_transfer|cheque|ach|credit_card|trust_transfer|retainer_drawdown`',
    `payment_number` STRING COMMENT 'Externally visible, human-readable business identifier for the payment, used in client remittance advice, bank reconciliation, and collections correspondence. Follows the firms sequential payment numbering convention (e.g., PAY-2024-000123).. Valid values are `^PAY-[0-9]{4}-[0-9]{6}$`',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment within the accounts receivable workflow. received indicates funds have been confirmed in the bank; applied means fully allocated to invoices; partially_applied means some funds remain unapplied; unapplied means no allocation has occurred; reversed means the payment was reversed after application; voided means the payment was cancelled before application.. Valid values are `received|applied|partially_applied|unapplied|reversed|voided`',
    `payment_type` STRING COMMENT 'Classifies the nature of the payment transaction for accounting and AR purposes. standard is a regular client remittance; retainer_drawdown is an application of a pre-paid retainer; trust_transfer is a transfer from a client trust/IOLTA account; overpayment_credit is a credit applied from a prior overpayment; write_off_reversal is a recovery of a previously written-off amount.. Valid values are `standard|retainer_drawdown|trust_transfer|overpayment_credit|write_off_reversal`',
    `received_amount` DECIMAL(18,2) COMMENT 'The gross amount of funds received from the client in the transaction currency, as confirmed by the bank or trust account statement. This is the authoritative amount before any exchange rate conversion or allocation.',
    `received_date` DATE COMMENT 'The calendar date on which the firm confirmed receipt of funds from the client, as recorded in the bank or trust account. This is the principal business event date used for accounts receivable aging, cash flow reporting, and revenue recognition.',
    `remittance_reference` STRING COMMENT 'The reference or description provided by the client on the remittance advice or payment instruction, typically including invoice numbers, matter references, or client-side purchase order numbers. Used to match incoming funds to outstanding invoices during cash application.',
    `reversal_date` DATE COMMENT 'The calendar date on which the payment was reversed in the billing system, reinstating the outstanding invoice balances. Populated only when is_reversed is True. Used for AR aging recalculation and collections workflow re-triggering.',
    `reversal_reason` STRING COMMENT 'The reason code explaining why the payment was reversed. returned_cheque indicates a dishonoured cheque; failed_ach indicates a failed electronic transfer; client_dispute indicates the client contested the payment; duplicate_payment indicates the payment was made twice; bank_error indicates a banking error; other covers miscellaneous reasons. Populated only when is_reversed is True.. Valid values are `returned_cheque|failed_ach|client_dispute|duplicate_payment|bank_error|other`',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the received funds that has not yet been allocated to any invoice (received_amount minus applied_amount). A non-zero value triggers follow-up in the collections and AR workflow. Supports unapplied balance reporting and client credit management.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to the payment record, including status changes, allocation updates, or reversal processing. Supports audit trail and change tracking requirements.',
    `wip_cleared_amount` DECIMAL(18,2) COMMENT 'The amount of Work in Progress (WIP) that was cleared from the WIP ledger as a result of this payment being applied. Relevant for contingency and AFA matters where WIP is recognized upon collection rather than billing. Supports WIP management and revenue recognition reporting.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The amount of the outstanding invoice balance that was written off in conjunction with this payment, representing the difference between the invoiced amount and the amount the client agreed to pay (e.g., in a negotiated settlement or fee reduction). Supports bad debt reporting and partner write-off approval workflows.',
    CONSTRAINT pk_billing_payment PRIMARY KEY(`billing_payment_id`)
) COMMENT 'Transactional record of funds received from a client against one or more invoices, including the detailed allocation of received funds across outstanding invoices and line items. Captures payment date, payment method (wire transfer, cheque, ACH, credit card), amount received, currency, exchange rate, bank reference, remittance details, and per-invoice/per-line allocation amounts with allocation type (full, partial, retainer drawdown, trust transfer). Supports partial payments, overpayments, unapplied balances, retainer drawdowns, trust-to-office account transfers, and complex multi-matter payment scenarios. Feeds accounts receivable aging and collections workflows.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`payment_allocation` (
    `payment_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each payment allocation record. Primary key for the payment_allocation data product in the billing domain.',
    `account_id` BIGINT COMMENT 'Reference to the IOLTA or client trust account from which funds were drawn for this allocation, when allocation_type is trust_transfer. Required for trust accounting compliance and state bar regulatory reporting.',
    `billing_payment_id` BIGINT COMMENT 'Reference to the parent payment record from which funds are being allocated. Links this allocation to the originating payment transaction.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Payment allocations are applied to invoices for specific dockets. Required for matter-level AR accuracy, client account reconciliation, and litigation profitability tracking.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice against which this allocation is applied. Supports multi-invoice payment scenarios common in large corporate client matters.',
    `invoice_line_id` BIGINT COMMENT 'Reference to the specific invoice line item against which this allocation is applied. Enables granular line-level allocation tracking for task-based billing under UTBMS standards.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with this payment allocation. Supports multi-matter payment scenarios where a single client payment is distributed across multiple active matters.',
    `profile_id` BIGINT COMMENT 'Reference to the client entity making the payment. Enables client-level AR aging analysis and supports consolidated billing for clients with multiple matters.',
    `retainer_id` BIGINT COMMENT 'Reference to the retainer account from which funds were drawn when allocation_type is retainer_drawdown. Tracks the drawdown of pre-paid retainer balances against earned fees.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment being applied to the referenced invoice or invoice line. Core financial field for AR aging, cash application, and revenue recognition. Must be positive and not exceed the payments unapplied balance.',
    `allocated_amount_base` DECIMAL(18,2) COMMENT 'The allocated amount expressed in the firms functional (base) currency after applying the exchange rate. Used for consolidated financial reporting, PPP, PEP, and RPE KPI calculations.',
    `allocation_date` DATE COMMENT 'The business date on which the payment allocation was applied to the invoice. Determines the AR aging bucket reduction and is the principal event date for cash application reporting and period-end close.',
    `allocation_number` STRING COMMENT 'Externally visible business identifier for this payment allocation record, used in client communications, remittance advice reconciliation, and audit trails. Typically follows firm-defined numbering conventions in Elite 3E or Aderant Expert.',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the payment allocation record. posted indicates funds have been applied to the invoice; reversed indicates a corrective reversal has been processed; pending indicates awaiting approval or trust transfer confirmation; voided indicates the allocation was cancelled; unapplied indicates funds received but not yet matched to an invoice.. Valid values are `posted|reversed|pending|voided|unapplied`',
    `allocation_type` STRING COMMENT 'Classification of how the payment is being applied. full covers the entire outstanding balance; partial covers a portion; retainer_drawdown applies funds held in a retainer account; trust_transfer applies funds from an IOLTA trust account; write_off_offset offsets a previously written-off amount; credit_memo applies a credit note against the invoice balance.. Valid values are `full|partial|retainer_drawdown|trust_transfer|write_off_offset|credit_memo`',
    `approval_status` STRING COMMENT 'The approval workflow status for this payment allocation, particularly relevant for trust transfers and write-off offsets that require partner or billing manager sign-off per firm policy.. Valid values are `approved|pending_approval|rejected|not_required`',
    `approved_by` STRING COMMENT 'The name or identifier of the billing manager, partner, or authorized approver who approved this payment allocation. Required for audit trail and compliance with firm billing governance policies.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which the payment allocation was approved by the authorized approver. Part of the allocation lifecycle audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this payment allocation record was first created in the system. Part of the mandatory audit trail for financial records.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the allocated amount (e.g., USD, GBP, EUR). Required for multi-currency billing in international legal matters, particularly relevant for ICC and LCIA arbitration matters.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any prompt-payment or negotiated discount applied at the time of payment allocation, reducing the effective amount required to satisfy the invoice balance. Tracked separately from write-offs for financial reporting purposes.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert the allocated amount from the payment currency to the firms functional currency at the time of allocation. Relevant for cross-border matters billed in non-functional currencies.',
    `fee_arrangement_type` STRING COMMENT 'The billing fee arrangement type governing the invoice to which this allocation is applied. Supports analysis of cash collection performance across different fee structures including AFA (Alternative Fee Arrangement), contingency, and hourly billing.. Valid values are `hourly|flat_fee|contingency|afa|blended_rate|retainer`',
    `gl_post_date` DATE COMMENT 'The date on which this allocation was posted to the General Ledger. May differ from allocation_date due to period-end cutoff rules or delayed GL posting. Critical for financial period reconciliation and SOX compliance.',
    `invoice_balance_after` DECIMAL(18,2) COMMENT 'The remaining outstanding invoice balance immediately after this allocation is applied. Enables real-time AR aging bucket calculation and identifies fully satisfied versus partially paid invoices.',
    `invoice_balance_before` DECIMAL(18,2) COMMENT 'The outstanding invoice balance immediately prior to this allocation being applied. Provides a point-in-time snapshot for audit trail purposes and supports AR aging reconciliation.',
    `is_auto_allocated` BOOLEAN COMMENT 'Indicates whether this allocation was applied automatically by the billing system (True) or manually by a billing administrator (False). Supports audit trail requirements and cash application workflow quality monitoring.',
    `is_trust_compliant` BOOLEAN COMMENT 'Indicates whether this allocation has been reviewed and confirmed as compliant with applicable trust accounting rules (True) or flagged for review (False). Required for IOLTA compliance and state bar regulatory reporting.',
    `ledes_billing_period` STRING COMMENT 'The billing period (YYYY-MM) associated with the invoice to which this allocation is applied, formatted per LEDES standards. Supports electronic billing reconciliation with corporate clients and insurance carriers.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time at which this payment allocation record was last updated. Supports change data capture, audit trail requirements, and Silver layer incremental processing in the Databricks Lakehouse.',
    `notes` STRING COMMENT 'Free-text notes entered by billing staff regarding this payment allocation, such as client instructions, special payment conditions, or dispute context. Supports collections workflow and client communication documentation.',
    `office_code` BIGINT COMMENT 'Reference to the firm office or practice group location associated with the matter for which this allocation is applied. Supports office-level revenue and collections performance reporting.',
    `remittance_reference` STRING COMMENT 'The reference number or description provided by the client on their remittance advice, used to match the payment to the correct invoice(s). Critical for automated cash application and reconciliation in LEDES-compliant billing workflows.',
    `reversal_reason` STRING COMMENT 'The business reason for reversing this payment allocation (e.g., returned check, incorrect invoice, client dispute). Populated only when allocation_status is reversed. Supports collections and dispute resolution workflows.',
    `reversed_timestamp` TIMESTAMP COMMENT 'The date and time at which this payment allocation was reversed. Populated only when allocation_status is reversed. Used for AR aging correction and period-end reconciliation.',
    `source_system` STRING COMMENT 'The operational system of record from which this payment allocation record originated. Supports data lineage tracking and reconciliation between Elite 3E and Aderant Expert in hybrid or transitioning environments.. Valid values are `elite_3e|aderant_expert|manual|migration`',
    `source_system_ref` STRING COMMENT 'The native identifier of this payment allocation record in the originating source system (e.g., Elite 3E transaction ID or Aderant Expert allocation key). Enables traceability and reconciliation back to the system of record.',
    `unapplied_balance` DECIMAL(18,2) COMMENT 'The portion of the payment that remains unallocated after this allocation record is processed. A non-zero value indicates funds on account that require further application to outstanding invoices or return to the client.',
    `value_date` DATE COMMENT 'The date on which the funds were considered cleared and available, as confirmed by the bank or payment processor. Used for trust accounting reconciliation and IOLTA compliance reporting.',
    `wip_cleared_amount` DECIMAL(18,2) COMMENT 'The amount of WIP (Work in Progress) cleared from the matters WIP ledger as a result of this payment allocation. Relevant for revenue recognition and matter profitability reporting.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The amount written off in conjunction with this payment allocation, representing the difference between the invoice balance and the payment received when a partial settlement is accepted. Impacts PPP and PEP calculations.',
    CONSTRAINT pk_payment_allocation PRIMARY KEY(`payment_allocation_id`)
) COMMENT 'Association record linking a payment to one or more invoice lines, capturing how received funds are distributed across outstanding invoices and line items. Tracks allocated amount, allocation date, allocation type (full, partial, retainer drawdown, trust transfer), and any unapplied balance. Ensures accurate AR aging and supports complex multi-matter payment scenarios common in large corporate client relationships.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`ar_balance` (
    `ar_balance_id` BIGINT COMMENT 'Unique surrogate identifier for each accounts receivable balance record in the AR aging ledger. Primary key for the ar_balance data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.contract_agreement. Business justification: AR collections in legal services require direct reference to the governing contract agreement for credit terms, dispute resolution rights, and payment terms enforcement. Collections teams reference th',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: AR aging is tracked at the docket/matter level for litigation matters. Essential for collections prioritization, client creditworthiness assessment, and litigation portfolio management.',
    `matter_risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.matter_risk_profile. Business justification: Client credit risk reporting: AR aging buckets and collection status directly populate client_credit_risk_rating and client_payment_history_flag on matter_risk_profile. Legal finance teams link AR bal',
    `organisation_id` BIGINT COMMENT 'Reference to the client entity who owes the outstanding balance. Links the AR record to the client master for collections management and partner financial reviews.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: AR balances are monitored by practice area for collections prioritization, write-off authority, and cash flow forecasting. Practice area leaders manage collections strategy and approve write-offs with',
    `invoice_id` BIGINT COMMENT 'Reference to the originating invoice that generated this AR balance record. Supports invoice-level aging and dispute tracking.',
    `matter_id` BIGINT COMMENT 'Reference to the specific legal matter against which the outstanding balance is recorded. Enables matter-level AR aging and WIP reconciliation.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: AR aging reports, credit limit monitoring, and client payment behavior analysis require aggregation at client_profile level across all matters. Currently ar_balance links to organisation and matter bu',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: Legal finance AR aging reports must show available trust funds offsetting outstanding AR balances. Linking ar_balance to the clients trust account enables the standard legal finance AR vs. trust off',
    `write_off_id` BIGINT COMMENT 'Foreign key linking to billing.write_off. Business justification: AR balances may be partially or fully written off when deemed uncollectible. Currently ar_balance has write_off_amount, write_off_date, and write_off_approved_by as denormalized attributes, but no FK ',
    `ar_number` STRING COMMENT 'Externally-visible, human-readable reference number assigned to this AR balance record. Used in client statements, collection correspondence, and LEDES electronic billing submissions.. Valid values are `^AR-[0-9]{8,12}$`',
    `billing_frequency` STRING COMMENT 'The agreed billing cycle frequency for this matter as specified in the Letter of Engagement (LOE). Determines invoice generation cadence and expected AR turnover.. Valid values are `monthly|quarterly|milestone|on_demand|annual`',
    `bucket_0_30_amount` DECIMAL(18,2) COMMENT 'Portion of the outstanding balance aged 0 to 30 days from the invoice date. Used in the standard AR aging report for partner financial reviews and PPP/PEP calculations.',
    `bucket_31_60_amount` DECIMAL(18,2) COMMENT 'Portion of the outstanding balance aged 31 to 60 days from the invoice date. Elevated aging bucket that may trigger initial collection outreach per firm collections policy.',
    `bucket_61_90_amount` DECIMAL(18,2) COMMENT 'Portion of the outstanding balance aged 61 to 90 days from the invoice date. Triggers escalated collection action and partner notification under standard firm collections protocols.',
    `bucket_over_90_amount` DECIMAL(18,2) COMMENT 'Portion of the outstanding balance aged more than 90 days from the invoice date. Highest-risk aging bucket; typically triggers write-off evaluation, external collections referral, or matter suspension.',
    `client_matter_number` STRING COMMENT 'Combined client-matter reference code (e.g., 12345.001) as used in Elite 3E and on client invoices. Standard identifier for cross-referencing billing records with matter management systems.',
    `collection_status` STRING COMMENT 'Current collections lifecycle state of the AR balance record. Drives workflow routing in Aderant Expert collections management and partner escalation processes. [ENUM-REF-CANDIDATE: current|overdue|in_dispute|sent_to_collections|written_off|settled — promote to reference product if additional statuses are required]. Valid values are `current|overdue|in_dispute|sent_to_collections|written_off|settled`',
    `collections_notes` STRING COMMENT 'Free-text notes recorded by the collections team or responsible partner regarding collection activity, client commitments, payment plans, or dispute context for this AR balance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AR balance record was first created in the system, typically upon invoice posting. Provides the audit trail creation anchor for SOX and data governance compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the invoice and AR balance are denominated (e.g., USD, GBP, EUR). Supports multi-currency billing for international matters.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The net outstanding amount currently owed by the client on this AR record after applying all payments, credits, and write-offs to date. The authoritative balance figure for collections management and financial reporting.',
    `days_outstanding` STRING COMMENT 'Number of calendar days elapsed since the invoice date. Used as the primary aging metric for AR bucket assignment and collections prioritisation. Recalculated daily during Silver layer processing.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the client has formally disputed this invoice or AR balance. When true, collections activity is paused pending resolution and the record is flagged for billing partner review.',
    `dispute_reason` STRING COMMENT 'Categorised reason for the clients invoice dispute. Populated when dispute_flag is true. Supports root-cause analysis of billing disputes and UTBMS task code compliance reviews. [ENUM-REF-CANDIDATE: fee_dispute|task_code_error|rate_discrepancy|duplicate_invoice|scope_dispute|other — promote to reference product if additional reasons are required]. Valid values are `fee_dispute|task_code_error|rate_discrepancy|duplicate_invoice|scope_dispute|other`',
    `due_date` DATE COMMENT 'The contractual payment due date for the invoice as defined by the credit terms in the Letter of Engagement (LOE). Determines overdue status and triggers collection workflows.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert the billing currency to the firms functional reporting currency at the time of invoice generation. Required for multi-currency AR consolidation and financial reporting.',
    `fee_arrangement_type` STRING COMMENT 'The billing fee structure governing this matters invoicing. Determines how WIP is converted to billed amounts and how AR is recognised. Supports AFA (Alternative Fee Arrangement), contingency, hourly, flat fee, blended rate, and retainer models.. Valid values are `hourly|flat_fee|contingency|afa|blended_rate|retainer`',
    `interest_accrued` DECIMAL(18,2) COMMENT 'Contractual interest amount accrued on the overdue AR balance where the Letter of Engagement (LOE) provides for late payment interest. Tracked separately from the principal balance for financial reporting.',
    `iolta_flag` BOOLEAN COMMENT 'Indicates whether this AR balance is associated with funds held in an IOLTA trust account. When true, payment processing must comply with IOLTA rules and state bar trust accounting regulations.',
    `last_collection_contact_date` DATE COMMENT 'Date of the most recent collections outreach activity (call, email, or letter) made to the client regarding this outstanding balance. Supports collections workflow management and SLA compliance.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The monetary value of the most recent payment applied to this AR balance. Supports cash flow analysis and collections follow-up.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received and applied against this AR balance. Used in collections management to assess client payment behaviour and prioritise outreach.',
    `last_statement_date` DATE COMMENT 'Date the most recent client account statement was generated and dispatched for this AR balance. Used to track statement cycle compliance and client communication history.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this AR balance record, including payment applications, write-offs, credit adjustments, or status changes. Required for incremental Silver layer processing and audit compliance.',
    `matter_type_code` STRING COMMENT 'Classification code for the type of legal matter (e.g., M&A, Litigation, IP Prosecution, Employment Advisory) associated with this AR balance. Enables matter-type segmentation in AR analytics.',
    `original_invoice_amount` DECIMAL(18,2) COMMENT 'The gross billed amount on the original invoice before any payments, credits, or write-offs are applied. Denominated in the billing currency. Forms the basis for AR aging and revenue recognition.',
    `total_credits_applied` DECIMAL(18,2) COMMENT 'Cumulative value of credit notes, billing adjustments, and courtesy discounts applied against this AR balance. Distinct from write-offs; represents negotiated or corrective reductions.',
    `total_payments_applied` DECIMAL(18,2) COMMENT 'Cumulative amount of all client payments applied against this AR balance record to date. Reconciles original invoice amount to current outstanding balance.',
    CONSTRAINT pk_ar_balance PRIMARY KEY(`ar_balance_id`)
) COMMENT 'Accounts receivable balance record representing the outstanding amount owed by a client at the matter and invoice level. Tracks current balance, aged buckets (0-30, 31-60, 61-90, 90+ days), last payment date, last statement date, credit terms, and collection status. Serves as the authoritative AR aging ledger for collections management, partner financial reviews, and PPP/PEP reporting.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique surrogate identifier for each write-off or write-down transaction record in the billing system. Primary key for the write_off data product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to ip.ip_asset. Business justification: When IP assets are abandoned or lapsed, associated WIP and AR are written off in a named IP portfolio wind-down process. Linking write-offs to the specific IP asset supports portfolio cost reconciliat',
    `check_id` BIGINT COMMENT 'Foreign key linking to conflict.check. Business justification: Conflict-driven write-off reporting: when a conflict is discovered post-engagement, fees billed during the conflicted period must be written off. Legal risk and billing teams require the link between ',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Write-offs are authorized at the matter/docket level. Required for litigation profitability analysis, partner approval workflows, and accurate matter-level revenue recognition.',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Write-offs may be linked to PI claims (settlement amounts, defence costs, fee reductions). Real business process: claim financial impact tracking requires linking write-offs to claims for reserve mana',
    `indemnity_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.indemnity_exposure. Business justification: PI claim cost tracking: write-offs are frequently triggered by indemnity exposures (firm writes off fees when settling a PI claim). Legal risk teams need to link write-off amounts to indemnity_exposur',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter against which the write-off is recorded. Enables matter-level profitability analysis, realization rate calculations, and WIP aging reporting.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Write-off approval thresholds and bad debt reserves are managed at organisation level for corporate groups. Tracking the organisation enables consolidated write-off reporting, credit risk assessment a',
    `pi_claim_id` BIGINT COMMENT 'Foreign key linking to risk.pi_claim. Business justification: PI claim cost quantification for insurance reporting: write-offs directly resulting from PI claim settlements must be linked to the pi_claim record to calculate total claim cost (defence costs + write',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Write-offs require practice area leader approval and impact practice area P&L. Practice area determines approval authority thresholds, write-off policies, and profitability reporting used in partner c',
    `invoice_id` BIGINT COMMENT 'FK to billing.invoice.invoice_id — AR write-offs reference the specific invoice being written off. Essential for AR reconciliation and realization rate calculation.',
    `profile_id` BIGINT COMMENT 'Reference to the client entity associated with the write-off. Supports client-level write-off trend analysis, relationship management reporting, and bad debt exposure tracking.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Material write-offs (especially pattern write-offs by timekeeper or client) are risk events requiring registration for trend analysis, partner accountability, and realization rate monitoring. Firms es',
    `reversed_write_off_id` BIGINT COMMENT 'Reference to the original write-off record that this entry reverses. Populated only when is_reversal is True. Enables audit trail linking between original write-offs and their reversals for GL reconciliation and financial period close.',
    `wip_ledger_id` BIGINT COMMENT 'FK to billing.wip_ledger.wip_ledger_id — WIP write-offs must reference the WIP ledger entry being written off. Critical for realization rate calculations and ensuring WIP balances are properly reduced.',
    `write_invoice_id` BIGINT COMMENT 'FK to billing.invoice.invoice_id — Bad debt write-offs must reference the invoice being written off from AR. Required for AR balance accuracy and financial close procedures.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value formally written off or written down, expressed in the billing currency. Must be less than or equal to original_amount. This is the primary financial impact figure used in realization rate, profitability, and financial period close reporting.',
    `approval_date` DATE COMMENT 'The date on which the approving partner formally authorized the write-off. May differ from write_off_date if approval precedes the accounting period posting. Critical for partner approval audit trails and governance compliance.',
    `client_agreed_rate` DECIMAL(18,2) COMMENT 'The negotiated or agreed billing rate for the timekeeper applicable to this client/matter at the time of the write-off. Enables analysis of rate realization versus standard rates and identification of billing guideline-driven write-offs.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this write-off record was first created in the system of record. Represents the audit trail creation event. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per firm data conventions.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the write-off amounts (e.g., USD, GBP, EUR). Required for multi-currency matters and cross-border client billing. Enables currency-normalized financial reporting.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the write-off amount to the firms functional (home) currency at the time of posting. Relevant for multi-currency matters. Null for write-offs already denominated in the functional currency.',
    `fee_arrangement_type` STRING COMMENT 'The type of fee arrangement under which the matter was being billed at the time of write-off. Contextualizes the write-off within the billing structure (e.g., AFA budget overrun write-offs differ analytically from hourly rate cap write-offs). Supports AFA performance and profitability analysis.. Valid values are `hourly|flat_fee|contingency|afa|blended_rate|retainer`',
    `fiscal_period` STRING COMMENT 'The firms fiscal year and month in which the write-off is recognized for financial reporting purposes, formatted as YYYY-MM. Derived from gl_posting_date but stored explicitly to support period-based aggregation and financial close reporting without date arithmetic.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The write-off amount converted to the firms functional (home) currency using the exchange_rate. Used for consolidated financial reporting, partner compensation calculations (PPP/PEP), and firm-wide realization rate analysis.',
    `gl_posting_date` DATE COMMENT 'The accounting date on which the write-off is posted to the General Ledger. Determines the financial period (month/quarter/year) in which the write-off impacts the firms P&L and balance sheet. May differ from write_off_date due to period-end cut-off rules.',
    `hours_written_off` DECIMAL(18,2) COMMENT 'The number of billable hours associated with the write-off, applicable when the write-off relates to time entries. Null for expense or disbursement write-offs. Used to calculate effective realization rates and to measure the volume of written-off effort.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether this write-off record is a reversal of a previously posted write-off (True) or an original write-off entry (False). Reversals restore WIP or AR balances and must be tracked separately for accurate net write-off reporting and GL reconciliation.',
    `notes` STRING COMMENT 'Additional free-text notes or commentary entered by billing staff, the approving partner, or finance team regarding the write-off. May include client negotiation context, matter budget discussions, or collections history relevant to bad debt write-offs.',
    `office_code` STRING COMMENT 'Code identifying the firm office (geographic location) associated with the matter or billing timekeeper at the time of write-off. Supports office-level financial performance reporting and regional realization rate analysis.',
    `original_amount` DECIMAL(18,2) COMMENT 'The gross value of the WIP or AR balance before the write-off is applied, expressed in the billing currency. Represents the full amount at standard rates prior to any reduction. Used as the denominator in realization rate calculations.',
    `reason_code` STRING COMMENT 'Standardized code identifying the business reason for the write-off (e.g., client billing guideline non-compliance, rate cap exceeded, duplicate entry, uncollectable debt, client relationship courtesy, matter budget overrun). Sourced from Elite 3E or Aderant Expert reason code tables. [ENUM-REF-CANDIDATE: billing_guideline|rate_cap|duplicate_entry|bad_debt|courtesy|budget_overrun|staffing_level|task_not_approved — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative explanation provided by the billing timekeeper or approving partner describing the specific circumstances justifying the write-off. Supplements the structured reason_code with contextual detail for audit and partner review purposes.',
    `requires_secondary_approval` BOOLEAN COMMENT 'Indicates whether the write-off amount exceeds the firms threshold requiring secondary approval (e.g., managing partner or finance committee sign-off in addition to the billing partner). Supports tiered approval workflow governance and write-off policy compliance.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this write-off record originated. Supports data lineage, reconciliation between systems, and audit traceability in the Silver layer lakehouse.. Valid values are `elite_3e|aderant_expert|manual|migration`',
    `source_system_reference` STRING COMMENT 'The native identifier or transaction reference of this write-off record in the originating source system (Elite 3E or Aderant Expert). Enables reconciliation between the lakehouse Silver layer and the operational system of record.',
    `standard_rate` DECIMAL(18,2) COMMENT 'The timekeepers standard hourly billing rate at the time the original WIP entry was recorded. Used to calculate the standard value of hours written off and to measure rate realization impact. Null for flat-fee or expense write-offs.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this write-off record was last modified in the system of record or the lakehouse Silver layer. Tracks status changes, approval updates, and corrections. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per firm data conventions.',
    `utbms_activity_code` STRING COMMENT 'The UTBMS activity code associated with the time entry being written off. Provides granular activity-level classification for task-based billing analysis and client billing guideline compliance reporting.. Valid values are `^[A-Z][0-9]{3}$`',
    `utbms_task_code` STRING COMMENT 'The UTBMS task code associated with the time or expense entry being written off. Enables task-level write-off analysis aligned with client billing guidelines and AFA arrangements. Supports LEDES electronic billing compliance reporting.. Valid values are `^[A-Z][0-9]{3}$`',
    `wip_entry_date` DATE COMMENT 'The date on which the original WIP time or expense entry being written off was recorded. Used to calculate WIP aging at the time of write-off and to assess how long unbilled time was carried before being written off. Null for AR (post-billing) write-offs.',
    `write_down_amount` DECIMAL(18,2) COMMENT 'The partial reduction amount when a write-down (as opposed to a full write-off) is applied. Represents the difference between original_amount and the revised billable amount. Null for full write-offs. Supports partial realization analysis.',
    `write_off_category` STRING COMMENT 'Distinguishes whether the write-off applies to professional fees (timekeeper charges), disbursements (client-incurred costs), firm expenses, accrued interest on overdue AR, or tax components. Drives GL account mapping and realization rate segmentation.. Valid values are `fees|disbursements|expenses|interest|tax`',
    `write_off_date` DATE COMMENT 'The business event date on which the write-off was formally approved and recorded. This is the principal real-world event date used for financial period close, WIP aging, and realization rate calculations. Distinct from the system audit timestamps.',
    `write_off_number` STRING COMMENT 'Externally-known business identifier for the write-off transaction, typically generated by Elite 3E or Aderant Expert. Used in partner approval workflows, GL postings, and audit trails. Format: WO-{YYYY}-{NNNNNN}.. Valid values are `^WO-[0-9]{4}-[0-9]{6}$`',
    `write_off_status` STRING COMMENT 'Current lifecycle state of the write-off transaction. Tracks the workflow from initial submission through partner approval, GL posting, and potential reversal. [ENUM-REF-CANDIDATE: pending_approval|approved|rejected|reversed|posted|cancelled — promote to reference product]. Valid values are `pending_approval|approved|rejected|reversed|posted|cancelled`',
    `write_off_type` STRING COMMENT 'Classification of the write-off by its business nature. WIP write-off reduces unbilled time/expense value; bad debt eliminates uncollectable AR; courtesy discount reflects client relationship adjustments; billing guideline reduction reflects client-mandated rate or task reductions. [ENUM-REF-CANDIDATE: wip_write_off|bad_debt|courtesy_discount|billing_guideline_reduction|fee_waiver|expense_write_off — promote to reference product]. Valid values are `wip_write_off|bad_debt|courtesy_discount|billing_guideline_reduction|fee_waiver|expense_write_off`',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Transactional record of WIP or AR amounts formally written off or written down following partner approval. Captures write-off type (WIP write-off, bad debt write-off, courtesy discount, billing guideline reduction), original amount, write-off amount, write-off reason code, approving partner, approval date, and GL impact. Critical for realization rate calculations, profitability analysis, and financial period close.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`retainer` (
    `retainer_id` BIGINT COMMENT 'Unique surrogate identifier for the retainer arrangement record. Primary key for the retainer data product within the billing domain.',
    `account_id` BIGINT COMMENT 'Reference to the associated Interest on Lawyers Trust Accounts (IOLTA) or client trust account record in the trust accounting domain. Governs the custodial account from which retainer drawdowns are funded.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Retainers are contractual arrangements requiring documented authority. Retainer drawdowns require contractual verification, trust accounting audits trace to source agreements, disputes require governi',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Retainers require AML/KYC verification before client funds are accepted (SRA Accounts Rules, FATF). Linking each retainer to the AML/KYC program under which verification was performed is a named regul',
    `doc_execution_id` BIGINT COMMENT 'Foreign key linking to document.doc_execution. Business justification: Retainer arrangements are formalized by executed engagement letters or fee agreements. Linking retainer to the doc_execution record proves the retainer was formally executed — critical for trust accou',
    `fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.fee_arrangement. Business justification: Retainers are often governed by or linked to a specific fee arrangement that defines how retainer funds are drawn down, replenished, and applied to invoices. Currently retainer has fee_arrangement_typ',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Retainer agreements are established per the terms documented in the letter of engagement. Trust accounting and retainer drawdown rules must reference the governing LOE to ensure compliance with agreed',
    `matter_opening_request_id` BIGINT COMMENT 'Foreign key linking to intake.matter_opening_request. Business justification: Matter opening requests include a requires_trust_account flag that mandates retainer establishment. Tracing a retainer to the matter opening request that required it is a standard trust accounting com',
    `matter_risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.matter_risk_profile. Business justification: AML/KYC risk reporting: retainer adequacy and kyc_verified_flag are assessed against the matter risk profile (aml_risk_flag, sanctions_screening_required_flag). Legal compliance teams link retainers t',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Retainers in legal firms are frequently scoped to a specific practice area (e.g., employment law retainer, IP prosecution retainer). Legal finance teams track retainer utilization and replenishment by',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom this retainer arrangement has been established. Links the retainer to the client master record.',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.request. Business justification: Intake requests specify whether a retainer is required as a condition of engagement. Linking retainers to the authorizing intake request supports trust account compliance audits and AML/KYC regulatory',
    `matter_id` BIGINT COMMENT 'The client-assigned matter identifier formatted per the Legal Electronic Data Exchange Standard (LEDES) specification. Required for electronic billing submissions to corporate clients and insurance carriers that mandate LEDES-format invoices.',
    `retainer_matter_id` BIGINT COMMENT 'Reference to the specific matter associated with this retainer. Null for general retainers that span all matters for a client; populated for matter-specific retainers.',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.sar_filing. Business justification: Retainer receipts are screened for AML red flags and may trigger SAR (large cash retainers, third-party funding, high-risk jurisdictions). Real business process: client funds acceptance and AML compli',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Retainer terms (amount, replenishment thresholds, drawdown rules) are tier-dependent in legal firms. Tier 1 clients receive different retainer structures than standard clients. Legal finance teams str',
    `approval_date` DATE COMMENT 'The date on which the retainer arrangement was formally approved by the responsible partner or governance authority. Supports audit trail and compliance reporting.',
    `approved_by` STRING COMMENT 'The name or identifier of the partner or authorised signatory who approved the establishment of this retainer arrangement. Required for governance and audit trail purposes.',
    `auto_apply_to_invoice_flag` BOOLEAN COMMENT 'Indicates whether retainer funds should be automatically applied to reduce the outstanding balance of invoices upon generation, without requiring manual partner approval for each drawdown.',
    `billing_frequency` STRING COMMENT 'The agreed frequency at which fees are drawn against the retainer and invoices are generated. Drives the billing cycle schedule in the practice management system.. Valid values are `monthly|quarterly|upon_invoice|milestone|annual`',
    `billing_office_code` STRING COMMENT 'The office or cost centre code responsible for billing and administering this retainer. Used for revenue allocation, profit centre reporting, and Profit Per Partner (PPP) / Profit Per Equity Partner (PEP) analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this retainer record was first created in the system. Supports audit trail, data lineage, and compliance reporting requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the retainer amount, balance, and all drawdown transactions are denominated (e.g., USD, GBP, EUR). Supports multi-currency billing for international clients.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The current available balance of the retainer after all drawdowns and replenishments have been applied. Represents the remaining funds authorised for future billing drawdowns. Updated upon each drawdown event or replenishment receipt.',
    `drawdown_authorization_rule` STRING COMMENT 'The rule governing when and how funds may be drawn from the retainer balance against earned fees or disbursements. Automatic drawdown applies retainer funds upon invoice generation; manual approval requires explicit partner sign-off; threshold-triggered drawdown applies when WIP reaches a defined level; periodic scheduled drawdown occurs on a fixed calendar basis.. Valid values are `automatic_on_invoice|manual_approval_required|threshold_triggered|periodic_scheduled`',
    `drawdown_via_payment` BIGINT COMMENT 'FK to billing.payment.payment_id — Retainer drawdowns are processed as payment applications. This FK connects retainer balance management to the payment/AR cycle.',
    `effective_date` DATE COMMENT 'The date on which the retainer arrangement becomes binding and drawdowns may commence. Corresponds to the commencement date stated in the Letter of Engagement (LOE) or retainer agreement.',
    `evergreen_flag` BOOLEAN COMMENT 'Indicates whether this retainer is structured as an evergreen arrangement, meaning the client is contractually obligated to replenish the balance to the target amount whenever it falls below the replenishment threshold. Drives automated replenishment demand workflows.',
    `expiry_date` DATE COMMENT 'The date on which the retainer arrangement expires or is scheduled to terminate. Null for open-ended or evergreen retainers with no fixed end date. After this date, no further drawdowns are authorised without renewal.',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether the retainer funds held in the associated trust account are subject to interest accrual under IOLTA or client-specific interest arrangements. True if interest is earned and must be reported or remitted.',
    `jurisdiction_code` STRING COMMENT 'The primary legal jurisdiction governing the retainer arrangement and the associated client engagement. Determines applicable professional conduct rules, trust accounting regulations, and tax treatment. Uses ISO 3166-1 alpha-2 or alpha-3 country codes.. Valid values are `^[A-Z]{2,3}$`',
    `kyc_verified_flag` BOOLEAN COMMENT 'Indicates whether the client associated with this retainer has completed Know Your Client (KYC) and Anti-Money Laundering (AML) verification checks prior to the retainer being activated. Mandatory for regulatory compliance before funds are accepted.',
    `last_drawdown_date` DATE COMMENT 'The date on which the most recent drawdown was applied against this retainer. Used for activity monitoring, dormancy detection, and collections follow-up.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp at which this retainer record was most recently updated. Used for change tracking, data synchronisation, and audit trail purposes across the billing domain.',
    `last_replenishment_date` DATE COMMENT 'The date on which the most recent replenishment payment was received and applied to this retainer balance. Used for cash flow monitoring and client payment behaviour analysis.',
    `notes` STRING COMMENT 'Free-text field for capturing supplementary information about the retainer arrangement, including special billing instructions, client-specific conditions, or internal administrative notes not captured in structured fields.',
    `original_amount` DECIMAL(18,2) COMMENT 'The initial monetary amount deposited or committed by the client when the retainer arrangement was established. Represents the starting balance before any drawdowns or replenishments. Expressed in the billing currency.',
    `practice_group_code` STRING COMMENT 'Code identifying the practice group (e.g., Corporate, Litigation, Intellectual Property, Employment) under which this retainer is administered. Supports revenue reporting by practice area and Revenue Per Equity Partner (RPE) analytics.',
    `refundable_flag` BOOLEAN COMMENT 'Indicates whether any unused retainer balance is refundable to the client upon matter closure or retainer termination. Governs the treatment of residual balances in the billing close-out process.',
    `replenishment_demand_date` DATE COMMENT 'The date on which the most recent replenishment demand was issued to the client. Used to track outstanding replenishment requests and calculate days outstanding for collections follow-up.',
    `replenishment_due_date` DATE COMMENT 'The contractual due date by which the client must remit the replenishment amount following a demand. Drives collections escalation workflows when payment is not received by this date.',
    `replenishment_target_amount` DECIMAL(18,2) COMMENT 'The amount to which the retainer balance should be restored upon replenishment. May equal the original_amount or a separately negotiated top-up level. Used to calculate the replenishment demand sent to the client.',
    `replenishment_threshold` DECIMAL(18,2) COMMENT 'The minimum balance level at which a replenishment request is automatically triggered and sent to the client. When current_balance falls at or below this threshold, the firm initiates a top-up demand. Critical for evergreen retainer management.',
    `retainer_number` STRING COMMENT 'Externally-visible, human-readable business identifier for the retainer arrangement. Used in client correspondence, billing statements, and engagement letters. Format: RET-YYYY-NNNNNN.. Valid values are `^RET-[0-9]{4}-[0-9]{6}$`',
    `retainer_status` STRING COMMENT 'Current lifecycle state of the retainer arrangement. Active indicates funds are available for drawdown; exhausted indicates the balance has been fully applied; replenishment_pending indicates a top-up request has been issued to the client; closed indicates the arrangement has been formally terminated.. Valid values are `active|suspended|exhausted|replenishment_pending|closed|pending_approval`',
    `retainer_type` STRING COMMENT 'Classification of the retainer arrangement by its commercial structure. General retainers cover all matters for a client; matter-specific retainers are scoped to a single matter; evergreen retainers auto-replenish; security retainers are held as collateral; advance payment retainers are pre-payments for future services.. Valid values are `general|matter_specific|evergreen|security|advance_payment`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the fees drawn against this retainer are exempt from applicable taxes (e.g., VAT, GST, sales tax) based on the clients tax status or the nature of the legal services provided.',
    `termination_date` DATE COMMENT 'The date on which the retainer arrangement was formally closed or terminated, either upon matter completion, client withdrawal, or firm-initiated closure. Null for active retainers.',
    `termination_reason` STRING COMMENT 'The reason code explaining why the retainer arrangement was closed or terminated. Used for client relationship analytics and regulatory compliance reporting.. Valid values are `matter_closed|client_withdrawal|funds_exhausted|firm_initiated|superseded|regulatory_closure`',
    `total_drawn_to_date` DECIMAL(18,2) COMMENT 'Cumulative monetary amount drawn down from this retainer since its establishment. Represents the sum of all drawdown transactions applied against earned fees and disbursements. Used for retainer utilisation reporting and client billing transparency.',
    `total_replenished_to_date` DECIMAL(18,2) COMMENT 'Cumulative monetary amount received from the client as retainer replenishments since the arrangement was established. Tracks all top-up receipts to support reconciliation and client account management.',
    `under_fee_arrangement` BIGINT COMMENT 'FK to billing.fee_arrangement.fee_arrangement_id — Retainers are a component of the overall fee arrangement with a client. Linking retainer to fee_arrangement ensures the retainer terms are governed by the broader commercial agreement.',
    `wip_drawdown_limit` DECIMAL(18,2) COMMENT 'The maximum Work in Progress (WIP) amount that may accumulate before a mandatory drawdown against the retainer is triggered. Prevents unbilled WIP from exceeding the retainer balance and ensures timely billing.',
    CONSTRAINT pk_retainer PRIMARY KEY(`retainer_id`)
) COMMENT 'Master record of client retainer arrangements including general retainers, matter-specific retainers, and evergreen retainers. Tracks retainer amount, replenishment threshold, current balance, drawdown history, retainer type, and associated trust account reference. Distinct from IOLTA trust accounts (owned by the trust domain) — this entity governs the commercial retainer agreement terms and drawdown authorization rules within the billing cycle.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`guideline` (
    `guideline_id` BIGINT COMMENT 'Unique surrogate identifier for each billing guideline record. Primary key for the billing_guideline data product in the Silver Layer lakehouse.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Billing guidelines are contractual obligations embedded in or referenced by service agreements. Invoice review validates billing against contractual guidelines, disputes cite agreement clauses, guidel',
    `doc_template_id` BIGINT COMMENT 'Foreign key linking to document.doc_template. Business justification: Billing guidelines mandate specific invoice templates, narrative formats, or LEDES formats. Essential for automated billing compliance, client-specific formatting requirements, and reducing billing re',
    `matter_id` BIGINT COMMENT 'Reference to the specific matter to which this guideline applies. When populated, the guideline is matter-specific; when null, the guideline applies at the client level across all matters.',
    `organisation_id` BIGINT COMMENT 'Reference to the client for whom this billing guideline applies. Links the guideline to the client master record for enforcement during prebilling review and LEDES submission validation.',
    `outside_counsel_guideline_id` BIGINT COMMENT 'Foreign key linking to client.outside_counsel_guideline. Business justification: Billing guidelines in legal firms are directly derived from client-issued Outside Counsel Guidelines (OCGs). This link enables OCG compliance enforcement — rate caps, billing format mandates, expense ',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Billing guidelines are often practice-area-specific (e.g., IP guidelines differ from litigation). Practice area determines applicable guidelines, rate caps, and compliance rules used in invoice valida',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Billing guidelines in legal services are directly mandated by regulatory obligations (e.g., SRA Accounts Rules, price transparency rules). Compliance teams track which regulatory obligation each billi',
    `superseded_by_guideline_id` BIGINT COMMENT 'Self-referencing identifier pointing to the newer billing_guideline record that replaces this one when guideline_status is superseded. Enables version chain traceability for audit and historical billing compliance review.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Billing guidelines are tier-specific in legal firms (different rate caps, expense limits, and timekeeper approval requirements apply to different client tiers). Legal billing compliance teams apply an',
    `afa_type` STRING COMMENT 'The fee arrangement type governed by this guideline. Identifies whether the guideline applies to hourly billing, a flat fee, contingency, blended rate, capped fee, or success fee arrangement. Aligns with the firms AFA (Alternative Fee Arrangement) billing model.. Valid values are `hourly|flat_fee|contingency|blended_rate|capped_fee|success_fee`',
    `applies_to_expenses` BOOLEAN COMMENT 'Indicates whether this billing guideline applies to expense/disbursement entries in addition to or instead of time entries. When True, expense line items are subject to the same rule enforcement during prebilling review.',
    `applies_to_time_entries` BOOLEAN COMMENT 'Indicates whether this billing guideline applies to time entries. When True, time entry records are subject to the rule enforcement during prebilling review and LEDES submission validation.',
    `approved_by` STRING COMMENT 'Name or identifier of the partner, billing manager, or client representative who approved this billing guideline for enforcement. Provides accountability and audit trail for guideline activation.',
    `approved_date` DATE COMMENT 'The date on which this billing guideline was formally approved for enforcement. Distinct from effective_from, which is the date the rule becomes binding on billing entries.',
    `block_billing_prohibited` BOOLEAN COMMENT 'Indicates whether block billing (combining multiple tasks into a single time entry without itemisation) is prohibited under this guideline. When True, prebilling review must flag any time entries containing multiple tasks in a single narrative.',
    `budget_cap_amount` DECIMAL(18,2) COMMENT 'Total matter-level or phase-level budget ceiling imposed by the client under this guideline. When WIP (Work in Progress) approaches or exceeds this cap, alerts are triggered for partner review before further billing.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this billing guideline record was first created in the system. Provides the audit trail creation marker for data lineage and compliance purposes in the Silver Layer lakehouse.',
    `effective_from` DATE COMMENT 'The date from which this billing guideline becomes binding and enforceable. Time entries and expenses incurred on or after this date are subject to the rule. Aligns with the MASTER_AGREEMENT EFFECTIVE_FROM category.',
    `effective_until` DATE COMMENT 'The date on which this billing guideline ceases to be enforceable. Null indicates an open-ended guideline with no defined expiry. Used to determine which version of a guideline applies to a given billing period.',
    `enforcement_action` STRING COMMENT 'The system action triggered when a non-compliant entry is detected during prebilling review or LEDES submission validation. hard_block prevents invoice issuance; soft_warning alerts the billing team; write_off automatically reduces the entry; require_approval routes to partner; flag_for_review marks for manual review.. Valid values are `hard_block|soft_warning|write_off|require_approval|flag_for_review`',
    `exception_notes` STRING COMMENT 'Free-text field capturing any agreed exceptions or carve-outs to this billing guideline, such as approved deviations negotiated with the client or specific matter circumstances where the rule does not apply.',
    `expense_limit_amount` DECIMAL(18,2) COMMENT 'Maximum allowable disbursement or expense amount per transaction or per category as defined by this guideline. Populated when rule_type is expense_limit. Used to flag non-compliant expense entries during prebilling review.',
    `guideline_description` STRING COMMENT 'Full narrative description of the billing rule, including any conditions, exceptions, or qualifications. Provides the complete business context for the guideline as communicated by the client or as agreed in the engagement letter.',
    `guideline_name` STRING COMMENT 'Human-readable name or short title of the billing guideline, such as Block Billing Prohibition or Senior Associate Rate Cap. Used for display in prebilling dashboards and compliance reports.',
    `guideline_source` STRING COMMENT 'Identifies the originating document or instrument from which this billing guideline derives its authority. Values: ocg (client-issued Outside Counsel Guidelines), engagement_letter (Letter of Engagement / LOE), standing_instruction (ongoing client instruction), matter_specific_agreement (matter-level side agreement), court_order (court-mandated billing restriction).. Valid values are `ocg|engagement_letter|standing_instruction|matter_specific_agreement|court_order`',
    `guideline_status` STRING COMMENT 'Current lifecycle state of the billing guideline. Active guidelines are enforced during prebilling review. Superseded guidelines are retained for historical audit. Pending_approval guidelines are awaiting client or partner sign-off before enforcement.. Valid values are `active|inactive|superseded|pending_approval|draft`',
    `invoice_submission_deadline_days` STRING COMMENT 'Maximum number of days after the billing period end date within which the firm must submit an invoice to the client. Late submissions beyond this threshold may be subject to write-off or rejection per the OCG.',
    `invoice_submission_frequency` STRING COMMENT 'The required frequency at which invoices must be submitted to the client under this guideline. Governs billing cycle compliance and WIP (Work in Progress) management cadence.. Valid values are `monthly|quarterly|matter_close|milestone|on_demand`',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction (ISO 3166-1 alpha-2 or alpha-3 country code) to which this billing guideline applies. Relevant for multi-jurisdictional matters where different billing rules may apply per jurisdiction.. Valid values are `^[A-Z]{2,3}$`',
    `last_reviewed_date` DATE COMMENT 'The most recent date on which this billing guideline was reviewed for continued applicability and accuracy. Supports periodic OCG review cycles and ensures guidelines remain current with client instructions.',
    `ledes_billing_format` STRING COMMENT 'The required LEDES electronic billing format version mandated by the client for invoice submission under this guideline. Governs the file format used when submitting invoices electronically to the client or their e-billing platform.. Valid values are `LEDES98B|LEDES98BI|LEDES2000|LEDESxml|none`',
    `minimum_time_increment_mins` STRING COMMENT 'The minimum billable time increment in minutes permitted under this guideline (e.g., 6 minutes = 0.1 hour, 15 minutes = 0.25 hour). Time entries rounded to increments larger than this value may be flagged as non-compliant.',
    `narrative_min_length` STRING COMMENT 'Minimum number of characters required in a time entry or expense narrative to satisfy the clients narrative requirement under this guideline. Entries with narratives shorter than this threshold are flagged during prebilling review.',
    `new_timekeeper_rate_freeze` BOOLEAN COMMENT 'Indicates whether the client has imposed a rate freeze on newly introduced timekeepers, requiring them to bill at the same rate as the timekeeper they replace or at a pre-agreed rate. Common OCG provision to control staffing cost escalation.',
    `ocg_section_reference` STRING COMMENT 'Specific section, clause, or paragraph number within the OCG document that contains the rule captured by this guideline record. Supports precise audit trail and dispute resolution when a billing entry is challenged.',
    `rate_cap_amount` DECIMAL(18,2) COMMENT 'Maximum hourly billing rate permitted under this guideline for the applicable timekeeper level or role. Populated only when rule_type is rate_cap. Enforced during prebilling review to flag time entries exceeding the agreed rate ceiling.',
    `rate_cap_currency` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the rate_cap_amount (e.g., USD, GBP, EUR). Required when rate_cap_amount is populated to ensure multi-currency billing compliance.. Valid values are `^[A-Z]{3}$`',
    `rate_increase_notice_days` STRING COMMENT 'Number of calendar days advance notice the firm must provide to the client before implementing a rate increase under this guideline. Enforces the clients OCG requirement for rate change notification.',
    `reference_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned by the client or law firm to uniquely reference this Outside Counsel Guideline (OCG) or billing instruction document. Used for cross-referencing with client-issued OCG documents.',
    `rule_category` STRING COMMENT 'High-level grouping of the billing rule for reporting and filtering purposes. Segments guidelines into operational categories: timekeeper (rate and staffing rules), expense (disbursement rules), invoice_format (LEDES/UTBMS formatting), matter_budget (budget and cap rules), task_code (UTBMS task code restrictions), narrative (time entry description requirements).. Valid values are `timekeeper|expense|invoice_format|matter_budget|task_code|narrative`',
    `rule_type` STRING COMMENT 'Categorical classification of the billing rule being enforced. Defines the nature of the compliance requirement. [ENUM-REF-CANDIDATE: rate_cap|timekeeper_approval|task_code_restriction|narrative_requirement|block_billing_prohibition|expense_limit|staffing_restriction|budget_cap|write_off_threshold|invoice_format_requirement — promote to reference product]',
    `timekeeper_approval_required` BOOLEAN COMMENT 'Indicates whether timekeepers must be pre-approved by the client before their time can be billed under this guideline. When True, any time entry from a non-approved timekeeper is flagged as non-compliant during prebilling review.',
    `timekeeper_level` STRING COMMENT 'The seniority or role classification of the timekeeper to which this guideline applies. Used to scope rate caps and staffing restrictions to specific timekeeper grades. all indicates the rule applies universally regardless of timekeeper level.. Valid values are `partner|counsel|associate|paralegal|staff|all`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this billing guideline record was most recently modified. Used for change detection, incremental data loading, and audit trail maintenance in the Silver Layer lakehouse.',
    `utbms_activity_code` STRING COMMENT 'The UTBMS activity code (e.g., A101 Plan and Prepare, A102 Research) to which this guideline applies. Used in conjunction with utbms_task_code to restrict or govern specific task-activity combinations in LEDES invoice submissions.',
    `utbms_task_code` STRING COMMENT 'The UTBMS task code to which this guideline applies when rule_type is task_code_restriction. Identifies the specific legal task category (e.g., L110 Fact Investigation, L120 Analysis/Strategy) that is restricted or governed by this rule.',
    `wip_aging_limit_days` STRING COMMENT 'Maximum number of days that unbilled WIP (Work in Progress) may remain outstanding before it must be billed or written off per the clients guideline. Supports WIP management and collections compliance.',
    CONSTRAINT pk_guideline PRIMARY KEY(`guideline_id`)
) COMMENT 'Master record of client-specific billing guidelines and outside counsel guidelines (OCG) that govern invoice compliance requirements. Captures guideline source (client-issued OCG, engagement letter, standing instruction), rule type (rate cap, timekeeper approval, task code restriction, narrative requirement, block billing prohibition, expense limit), effective date, and enforcement action. Used during prebilling review and LEDES submission validation to flag non-compliant entries before invoice issuance.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`invoice_dispute` (
    `invoice_dispute_id` BIGINT COMMENT 'Unique system-generated identifier for each invoice dispute record. Primary key for the invoice_dispute data product within the billing domain.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Invoice disputes citing billing guideline violations or contractual terms require direct access to governing agreement. Dispute resolution reviews contractual billing terms, escalation workflows pull ',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: Invoice disputes are raised by a specific client contact. The plain attributes `client_contact_email` and `client_contact_name` on invoice_dispute are denormalized representations of client.client_con',
    `credit_note_id` BIGINT COMMENT 'Foreign key linking to billing.credit_note. Business justification: Invoice disputes often result in credit notes being issued to adjust the disputed amount. Currently invoice_dispute has credit_note_number (string) but no FK to the credit_note record. Adding credit_n',
    `time_entry_id` BIGINT COMMENT 'Reference to the specific time entry record being disputed, where the dispute is at the line-item level. Null when the dispute applies to multiple entries or the full invoice. Enables granular WIP (Work in Progress) and realization analytics.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Invoice disputes arise from specific litigation matters/dockets. Essential for dispute resolution, client relationship management, and matter-level billing accuracy in court cases.',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Invoice disputes can escalate to professional indemnity claims (alleged overbilling, negligence, guideline violations). Real business process: dispute escalation to PI claim requires linking disputes ',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Invoice disputes reference supporting documents (billing guidelines, engagement letters, court orders, fee agreements) for resolution. Critical for dispute substantiation, write-off justification, and',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Invoice disputes are adjudicated against LOE terms covering agreed scope, rates, and billing guidelines. Disputes teams must pull the LOE to determine whether a disputed charge was within agreed scope',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to contract.obligation. Business justification: Invoice disputes in legal services arise from specific contract obligations (rate caps, expense limits, billing guideline clauses). Linking to the specific obligation being disputed enables obligation',
    `pi_claim_id` BIGINT COMMENT 'Foreign key linking to risk.pi_claim. Business justification: Dispute-to-PI-claim escalation tracking: invoice disputes that allege negligence or breach of duty escalate to formal PI claims. Legal risk teams need to link the originating invoice_dispute to the re',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Invoice disputes are resolved by practice area leadership with area-specific resolution authority and client relationship management. Practice area determines dispute resolution approach, approval aut',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice against which this dispute has been raised. Links the dispute to the originating billing document in the accounts receivable cycle.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with the disputed invoice. Enables dispute analysis by practice area, matter type, and responsible attorney.',
    `profile_id` BIGINT COMMENT 'Reference to the client who raised the invoice dispute. Supports client-level dispute trend analysis and relationship management reporting.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Significant invoice disputes (especially pattern disputes or high-value disputes) are logged in the risk register as client relationship, reputational, and financial risk events. Firms track dispute-t',
    `tertiary_invoice_id` BIGINT COMMENT 'FK to billing.invoice.invoice_id — Disputes are raised against specific invoices. This FK enables dispute tracking, resolution workflow, and realization impact analysis.',
    `agreed_reduction_amount` DECIMAL(18,2) COMMENT 'The monetary amount agreed between the firm and the client as the final reduction to the invoice following dispute resolution. May be less than, equal to, or zero relative to the disputed amount. Feeds write-off and realization rate calculations.',
    `billing_guideline_reference` STRING COMMENT 'Reference to the specific client billing guideline clause or section that the client alleges was violated. Supports billing guideline compliance tracking and AFA (Alternative Fee Arrangement) governance.',
    `billing_period_end` DATE COMMENT 'The end date of the billing period covered by the disputed invoice. Used in conjunction with billing_period_start to define the scope of time entries and disbursements subject to the dispute.',
    `billing_period_start` DATE COMMENT 'The start date of the billing period covered by the disputed invoice. Provides temporal context for the dispute and supports period-based realization rate and WIP (Work in Progress) analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the invoice dispute record was first created in the data platform. Supports audit trail, data lineage, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the disputed and agreed reduction amounts (e.g., USD, GBP, EUR). Required for multi-currency billing environments and cross-border matter reporting.. Valid values are `^[A-Z]{3}$`',
    `days_to_resolve` STRING COMMENT 'Number of calendar days elapsed between the dispute_date and the resolution_date. Null while the dispute remains open. Supports SLA compliance measurement and dispute cycle time benchmarking. Note: this is a stored operational field populated at resolution, not a real-time derived metric.',
    `dispute_date` DATE COMMENT 'The calendar date on which the client formally raised the invoice dispute. Serves as the principal business event date for aging calculations, SLA tracking, and realization rate analytics.',
    `dispute_number` STRING COMMENT 'Externally-visible, human-readable reference number assigned to the dispute at the time of creation. Used in client correspondence, billing guideline audit trails, and LEDES-compliant dispute tracking. Format: DISP-YYYY-NNNNNN.. Valid values are `^DISP-[0-9]{4}-[0-9]{6}$`',
    `dispute_reason_code` STRING COMMENT 'Standardized UTBMS-aligned code categorizing the primary reason the client raised the dispute. Drives root-cause analytics and billing guideline compliance reporting. [ENUM-REF-CANDIDATE: billing_guideline_violation|rate_discrepancy|duplicate_entry|unauthorized_timekeeper|narrative_deficiency|block_billing|excessive_time|staffing_objection — promote to reference product]',
    `dispute_reason_description` STRING COMMENT 'Free-text narrative provided by the client or billing team elaborating on the specific grounds for the dispute. Supplements the structured reason code with contextual detail for resolution workflow and knowledge management.',
    `dispute_status` STRING COMMENT 'Current workflow state of the invoice dispute. Drives the dispute resolution lifecycle from initial submission through final resolution or withdrawal. [ENUM-REF-CANDIDATE: open|under_review|pending_client|resolved|withdrawn|escalated — promote to reference product if additional statuses are required]. Valid values are `open|under_review|pending_client|resolved|withdrawn|escalated`',
    `dispute_type` STRING COMMENT 'Classification of the dispute by the category of charge being contested: fees, disbursements, rates, specific timekeeper entries, or the entire invoice. Enables segmented dispute analytics by charge type.. Valid values are `fee_dispute|disbursement_dispute|rate_dispute|timekeeper_dispute|full_invoice_dispute`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The gross monetary amount the client is disputing on the invoice, expressed in the invoice currency. Represents the clients claimed reduction before any negotiation or resolution. Core input to realization rate and write-off analytics.',
    `ebilling_platform` STRING COMMENT 'Name of the clients electronic billing platform through which the dispute was submitted (e.g., TyMetrix 360, Legal Tracker, BillerXpert, Passport). Supports e-billing integration and dispute channel analytics.',
    `escalation_date` DATE COMMENT 'The date on which the dispute was escalated to senior management or the responsible partner. Null if the dispute has not been escalated. Supports escalation trend analysis and client relationship risk monitoring.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the dispute has been escalated beyond the standard billing team to senior management, the responsible partner, or the client relationship team. True when escalated; False otherwise.',
    `fee_arrangement_type` STRING COMMENT 'The type of fee arrangement under which the disputed invoice was generated. Contextualizes the dispute within the applicable billing framework (e.g., AFA disputes differ structurally from hourly billing disputes).. Valid values are `hourly|flat_fee|contingency|afa|blended_rate|retainer`',
    `invoice_amount` DECIMAL(18,2) COMMENT 'The total billed amount on the original invoice at the time the dispute was raised. Provides denominator context for calculating the dispute percentage and realization rate impact.',
    `lpp_flag` BOOLEAN COMMENT 'Indicates whether any communications or documents associated with this dispute are subject to Legal Professional Privilege (LPP). True when LPP applies; False otherwise. Governs disclosure obligations and eDiscovery handling of dispute records.',
    `office_code` STRING COMMENT 'Code identifying the firm office (e.g., LON, NYC, HKG) responsible for the matter associated with the disputed invoice. Supports geographic segmentation of dispute analytics and office-level realization rate reporting.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the dispute was received and logged in the billing system. Used for SLA (Service Level Agreement) response-time measurement and audit trail purposes.',
    `resolution_date` DATE COMMENT 'The calendar date on which the invoice dispute was formally resolved and a final outcome agreed between the firm and the client. Null while the dispute remains open. Used to calculate dispute cycle time and SLA compliance.',
    `resolution_notes` STRING COMMENT 'Free-text narrative documenting the rationale, negotiation outcome, and any conditions agreed during dispute resolution. Supports knowledge management, precedent tracking, and future billing guideline refinement.',
    `resolution_type` STRING COMMENT 'Categorizes the outcome of the dispute resolution process: whether the firm accepted the full disputed amount, a partial reduction, rejected the dispute, issued a credit note, wrote off the amount, or the client withdrew the dispute.. Valid values are `full_reduction|partial_reduction|no_reduction|credit_note|write_off|withdrawn`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this dispute record originated. Supports data lineage, reconciliation, and Silver layer provenance tracking.. Valid values are `elite_3e|aderant_expert|manual|ebilling_portal`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to the invoice dispute record. Enables change detection, incremental processing, and audit compliance.',
    `write_off_approved` BOOLEAN COMMENT 'Indicates whether the agreed reduction amount has been formally approved as a write-off in the firms financial system. True when write-off approval has been granted; False when pending or not applicable. Feeds write-off analytics and PPP/PEP impact reporting.',
    `write_off_approved_date` DATE COMMENT 'The date on which the write-off of the agreed reduction amount was formally approved by the authorized approver (e.g., managing partner, billing committee). Null if write-off has not been approved. Supports financial period close and SOX controls.',
    CONSTRAINT pk_invoice_dispute PRIMARY KEY(`invoice_dispute_id`)
) COMMENT 'Transactional record of client-raised disputes or reductions against a submitted invoice. Captures dispute date, disputed amount, dispute reason (billing guideline violation, rate discrepancy, duplicate entry, unauthorized timekeeper, narrative deficiency), resolution status, agreed reduction amount, and resolution date. Supports dispute resolution workflow and feeds realization rate and write-off analytics.';

CREATE OR REPLACE TABLE `legal_ecm`.`billing`.`credit_note` (
    `credit_note_id` BIGINT COMMENT 'Unique surrogate identifier for the credit note record in the billing system. Primary key for the credit_note data product.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Credit notes adjust billing for specific litigation matters/dockets. Required for accurate matter-level revenue recognition, client account reconciliation, and litigation profitability tracking.',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Credit notes issued as part of PI claim settlement or remediation (fee reductions, goodwill credits). Real business process: claim resolution financial adjustments require linking credit notes to clai',
    `indemnity_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.indemnity_exposure. Business justification: PI settlement cost reporting: credit notes issued as part of indemnity exposure settlements must be linked to the exposure record for reserve drawdown tracking and insurer reporting. Legal risk manage',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Credit notes reference supporting documents (court orders reducing fees, settlement agreements, billing guideline violations). Required for credit justification, audit trails, and regulatory complianc',
    `pi_claim_id` BIGINT COMMENT 'Foreign key linking to risk.pi_claim. Business justification: PI claim settlement reporting: credit notes issued as fee concessions in PI claim settlements must reference the pi_claim record. Legal risk and finance teams use this link to reconcile settlement_amo',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Credit notes impact practice area P&L and require area leader approval. Practice area determines approval authority, revenue adjustment policies, and profitability reporting used in financial manageme',
    `invoice_id` BIGINT COMMENT 'Reference to the originating invoice against which this credit note is issued. Establishes the parent-child relationship between the credit note and the billed invoice for accounts receivable (AR) reconciliation.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case associated with the credit note. Enables matter-level profitability analysis and WIP (Work in Progress) reconciliation.',
    `profile_id` BIGINT COMMENT 'Reference to the client entity to whom the credit note is issued. Used for client-level AR reconciliation, realization rate analysis, and financial reporting.',
    `application_method` STRING COMMENT 'Describes how the credit note value was or will be applied. applied_to_ar — offset against an existing outstanding AR balance on the client account; cash_refund — disbursed as a cash payment back to the client; held_on_account — retained as a credit balance for future invoices; offset_future_invoice — earmarked to reduce a specific forthcoming invoice.. Valid values are `applied_to_ar|cash_refund|held_on_account|offset_future_invoice`',
    `applied_date` DATE COMMENT 'The date on which the credit note was applied against an outstanding AR balance or processed as a cash refund. Null if the credit note has not yet been applied (status is issued or held). Used for AR ageing and cash flow reporting.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which the credit note was formally approved by the authorised approver (approved_by_id). Supports approval workflow audit trails and SOX (Sarbanes-Oxley Act) segregation of duties controls.',
    `billing_guideline_ref` STRING COMMENT 'Reference identifier for the client billing guideline or outside counsel guidelines (OCG) provision that triggered or justified this credit note (e.g., a specific guideline clause number). Supports billing guideline compliance tracking and dispute resolution documentation.',
    `billing_period_end_date` DATE COMMENT 'The end date of the billing period covered by the original invoice being credited. Together with billing_period_start_date, defines the revenue recognition period affected by this credit note.',
    `billing_period_start_date` DATE COMMENT 'The start date of the billing period covered by the original invoice being credited. Used to attribute the credit note to the correct accounting period for revenue recognition and WIP (Work in Progress) reversal.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which the credit note record was first created in the billing system. Serves as the record audit creation timestamp for data lineage, audit trail, and GDPR (General Data Protection Regulation) data processing records.',
    `credit_note_number` STRING COMMENT 'Externally visible, human-readable unique identifier for the credit note as printed on the document issued to the client. Follows the firms sequential numbering convention (e.g., CN-2024-000123). Used in client correspondence, remittance matching, and LEDES electronic billing submissions.. Valid values are `^CN-[0-9]{4}-[0-9]{6}$`',
    `credit_note_status` STRING COMMENT 'Current lifecycle state of the credit note. draft — prepared but not yet issued; issued — sent to client; applied — offset against an outstanding AR balance; refunded — cash refund disbursed to client; held — held on account for future application; voided — cancelled and reversed.. Valid values are `draft|issued|applied|refunded|held|voided`',
    `credit_reason_code` STRING COMMENT 'Standardised classification of the business reason for issuing the credit note. overbilling — fees or disbursements billed in excess of agreed rates; dispute_resolution — credit issued as part of a formal billing dispute settlement; goodwill_adjustment — discretionary reduction to maintain client relationship; fee_cap_correction — invoice exceeded an agreed AFA (Alternative Fee Arrangement) or matter budget cap; billing_error — administrative or data entry error on the original invoice; write_off — uncollectable amount formally written off. [ENUM-REF-CANDIDATE: overbilling|dispute_resolution|goodwill_adjustment|fee_cap_correction|billing_error|write_off — promote to reference product]. Valid values are `overbilling|dispute_resolution|goodwill_adjustment|fee_cap_correction|billing_error|write_off`',
    `credit_reason_narrative` STRING COMMENT 'Free-text description providing the detailed business justification for the credit note, supplementing the structured credit_reason_code. May reference specific time entries, disbursements, or billing guideline violations. Classified confidential as it may contain commercially sensitive negotiation details or LPP (Legal Professional Privilege) adjacent information.',
    `credit_type` STRING COMMENT 'Categorises the nature of the credit note by the component of the original invoice being reversed. fee_credit — applies only to professional fees; disbursement_credit — applies only to disbursements and expenses; tax_credit — applies only to the tax component; combined — spans multiple invoice components.. Valid values are `fee_credit|disbursement_credit|tax_credit|combined`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the credit note amounts are denominated (e.g., USD, GBP, EUR). Required for multi-currency billing environments and foreign exchange (FX) reporting.. Valid values are `^[A-Z]{3}$`',
    `disbursement_credit_amount` DECIMAL(18,2) COMMENT 'The amount of disbursements and client-chargeable expenses being credited on this credit note. Includes hard costs (court filing fees, expert witness fees) and soft costs (photocopying, courier). Expressed in the billing currency.',
    `dispute_reference` STRING COMMENT 'Reference number or identifier for the formal billing dispute, client complaint, or ADR (Alternative Dispute Resolution) proceeding that gave rise to this credit note. Populated when credit_reason_code is dispute_resolution. Classified confidential due to commercially sensitive negotiation context.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the credit note amounts from the billing currency to the firms functional (home) currency at the time of issuance. Required for multi-currency consolidation and financial reporting under IFRS/US GAAP.',
    `fee_arrangement_type` STRING COMMENT 'The type of fee arrangement (AFA — Alternative Fee Arrangement) under which the original invoice was billed and against which this credit note is issued. Determines the financial impact on realization rate calculations and AFA performance tracking.. Valid values are `hourly|flat_fee|contingency|afa|blended_rate|retainer`',
    `fee_credit_amount` DECIMAL(18,2) COMMENT 'The gross amount of professional fees being credited or reversed on this credit note, expressed in the billing currency. Represents the pre-tax fee reduction. Used in realization rate analysis and WIP (Work in Progress) reconciliation.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The total credit note amount converted to the firms functional (home) currency using the exchange_rate at issuance date. Used for consolidated financial reporting, GL (General Ledger) posting, and partner profit calculations (PPP/PEP).',
    `gl_account_code` STRING COMMENT 'The GL (General Ledger) account code to which the credit note is posted in the firms accounting system. Required for financial close, trial balance reconciliation, and SOX (Sarbanes-Oxley Act) internal controls compliance.',
    `issued_date` DATE COMMENT 'The calendar date on which the credit note was formally issued and transmitted to the client. This is the principal business event date for the credit note lifecycle, used for AR ageing, period-end close, and tax reporting.',
    `office_code` STRING COMMENT 'Code identifying the firm office or branch responsible for the matter associated with this credit note. Used for office-level financial reporting, GL (General Ledger) cost centre allocation, and geographic revenue analysis.',
    `originating_invoice_date` DATE COMMENT 'The issuance date of the original invoice being credited. Used to calculate the elapsed time between invoice issuance and credit note issuance for billing dispute analytics and SLA (Service Level Agreement) compliance reporting.',
    `originating_invoice_number` STRING COMMENT 'The human-readable invoice number of the original invoice being reversed or reduced by this credit note. Stored as a denormalised reference to support client-facing documents and LEDES electronic billing submissions without requiring a join.',
    `pro_bono_flag` BOOLEAN COMMENT 'Indicates whether the credit note relates to a pro bono matter (True) or a standard commercial matter (False). Required for pro bono reporting to the ABA (American Bar Association) and Law Society, and for exclusion from commercial realization rate calculations.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this credit note record originated. elite_3e — Elite 3E Practice Management and Financial System; aderant_expert — Aderant Expert Time and Billing; manual — manually entered outside a primary system. Required for data lineage and reconciliation in the Databricks Silver Layer.. Valid values are `elite_3e|aderant_expert|manual`',
    `tax_credit_amount` DECIMAL(18,2) COMMENT 'The tax component (e.g., VAT, GST, sales tax) being reversed or adjusted on this credit note. Must be reported separately for tax authority compliance and VAT/GST return reconciliation.',
    `tax_jurisdiction_code` STRING COMMENT 'ISO country or sub-national jurisdiction code identifying the tax authority under which the VAT, GST, or sales tax credit is calculated and reported. Required for multi-jurisdictional tax compliance and VAT/GST return reconciliation.. Valid values are `^[A-Z]{2,3}$`',
    `tax_rate_pct` DECIMAL(18,2) COMMENT 'The applicable tax rate (as a percentage) used to calculate the tax_credit_amount on this credit note. Stored for audit trail purposes as tax rates may change over time.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The total gross value of the credit note inclusive of fees, disbursements, and tax adjustments (fee_credit_amount + disbursement_credit_amount + tax_credit_amount). This is the net amount by which the clients AR balance is reduced or refunded. Core field for AR reconciliation and financial reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which the credit note record was last modified in the billing system. Used for incremental data pipeline processing, change data capture (CDC), and audit trail maintenance.',
    `utbms_task_code` STRING COMMENT 'The UTBMS (Uniform Task-Based Management System) task code associated with the primary fee component being credited. Used in task-based billing analysis and client billing guideline compliance reporting.',
    `voided_date` DATE COMMENT 'The date on which the credit note was voided or cancelled. Populated only when credit_note_status is voided. Required for audit trail and period-end reversal processing.',
    `write_off_approved_flag` BOOLEAN COMMENT 'Indicates whether the credit note has been formally approved as a write-off (True) by the authorised partner or finance committee. Relevant when credit_reason_code is write_off. Required for bad debt provisioning, GL (General Ledger) write-off posting, and SOX (Sarbanes-Oxley Act) internal controls.',
    CONSTRAINT pk_credit_note PRIMARY KEY(`credit_note_id`)
) COMMENT 'Transactional record of credit notes issued to clients to reverse or reduce previously invoiced amounts. Captures credit note number, originating invoice reference, credit reason (overbilling, dispute resolution, goodwill adjustment, fee cap correction), credit amount, tax adjustment, issuance date, and application status (applied to outstanding AR, refunded, held on account). Supports realization rate analysis and AR reconciliation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ADD CONSTRAINT `fk_billing_timekeeper_rate_primary_superseded_by_rate_timekeeper_rate_id` FOREIGN KEY (`primary_superseded_by_rate_timekeeper_rate_id`) REFERENCES `legal_ecm`.`billing`.`timekeeper_rate`(`timekeeper_rate_id`);
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ADD CONSTRAINT `fk_billing_time_entry_timekeeper_rate_id` FOREIGN KEY (`timekeeper_rate_id`) REFERENCES `legal_ecm`.`billing`.`timekeeper_rate`(`timekeeper_rate_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ADD CONSTRAINT `fk_billing_billing_disbursement_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_billing_disbursement_id` FOREIGN KEY (`billing_disbursement_id`) REFERENCES `legal_ecm`.`billing`.`billing_disbursement`(`billing_disbursement_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ADD CONSTRAINT `fk_billing_wip_ledger_time_entry_id` FOREIGN KEY (`time_entry_id`) REFERENCES `legal_ecm`.`billing`.`time_entry`(`time_entry_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`prebill` ADD CONSTRAINT `fk_billing_prebill_wip_ledger_id` FOREIGN KEY (`wip_ledger_id`) REFERENCES `legal_ecm`.`billing`.`wip_ledger`(`wip_ledger_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_originating_invoice_id` FOREIGN KEY (`originating_invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_billing_disbursement_id` FOREIGN KEY (`billing_disbursement_id`) REFERENCES `legal_ecm`.`billing`.`billing_disbursement`(`billing_disbursement_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_time_entry_id` FOREIGN KEY (`time_entry_id`) REFERENCES `legal_ecm`.`billing`.`time_entry`(`time_entry_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_primary_invoice_time_entry_id` FOREIGN KEY (`primary_invoice_time_entry_id`) REFERENCES `legal_ecm`.`billing`.`time_entry`(`time_entry_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `legal_ecm`.`billing`.`guideline`(`guideline_id`);
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ADD CONSTRAINT `fk_billing_fee_arrangement_parent_arrangement_billing_fee_arrangement_id` FOREIGN KEY (`parent_arrangement_billing_fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_original_payment_billing_payment_id` FOREIGN KEY (`original_payment_billing_payment_id`) REFERENCES `legal_ecm`.`billing`.`billing_payment`(`billing_payment_id`);
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ADD CONSTRAINT `fk_billing_billing_payment_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_billing_payment_id` FOREIGN KEY (`billing_payment_id`) REFERENCES `legal_ecm`.`billing`.`billing_payment`(`billing_payment_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `legal_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_retainer_id` FOREIGN KEY (`retainer_id`) REFERENCES `legal_ecm`.`billing`.`retainer`(`retainer_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ADD CONSTRAINT `fk_billing_ar_balance_write_off_id` FOREIGN KEY (`write_off_id`) REFERENCES `legal_ecm`.`billing`.`write_off`(`write_off_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_reversed_write_off_id` FOREIGN KEY (`reversed_write_off_id`) REFERENCES `legal_ecm`.`billing`.`write_off`(`write_off_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_wip_ledger_id` FOREIGN KEY (`wip_ledger_id`) REFERENCES `legal_ecm`.`billing`.`wip_ledger`(`wip_ledger_id`);
ALTER TABLE `legal_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_write_invoice_id` FOREIGN KEY (`write_invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`retainer` ADD CONSTRAINT `fk_billing_retainer_fee_arrangement_id` FOREIGN KEY (`fee_arrangement_id`) REFERENCES `legal_ecm`.`billing`.`fee_arrangement`(`fee_arrangement_id`);
ALTER TABLE `legal_ecm`.`billing`.`guideline` ADD CONSTRAINT `fk_billing_guideline_superseded_by_guideline_id` FOREIGN KEY (`superseded_by_guideline_id`) REFERENCES `legal_ecm`.`billing`.`guideline`(`guideline_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `legal_ecm`.`billing`.`credit_note`(`credit_note_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_time_entry_id` FOREIGN KEY (`time_entry_id`) REFERENCES `legal_ecm`.`billing`.`time_entry`(`time_entry_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ADD CONSTRAINT `fk_billing_invoice_dispute_tertiary_invoice_id` FOREIGN KEY (`tertiary_invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `legal_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `legal_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` SET TAGS ('dbx_subdomain' = 'time_capture');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `timekeeper_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Rate ID');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `primary_superseded_by_rate_timekeeper_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate ID');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `afa_arrangement_code` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Code');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `billing_increment_mins` SET TAGS ('dbx_business_glossary_term' = 'Billing Increment Minutes');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `blended_rate_pool_code` SET TAGS ('dbx_business_glossary_term' = 'Blended Rate Pool Code');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `client_agreed` SET TAGS ('dbx_business_glossary_term' = 'Client Agreed Flag');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `client_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Client Agreement Date');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `ledes_timekeeper_class` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Timekeeper Classification');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `office_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `pro_bono_flag` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Flag');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'per_hour|per_day|per_matter|per_month|fixed');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Cap Amount');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Category');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_category` SET TAGS ('dbx_value_regex' = 'standard|negotiated|preferred|pro_bono|secondment');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Rate Discount Percentage');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_discount_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_floor_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Floor Amount');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_floor_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Rate Increase Percentage');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Review Date');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|active|superseded|expired|rejected');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'hourly|blended|contingency|flat_fee|afa|capped');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert|manual');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `source_system_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Rate ID');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `standard_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `standard_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `timekeeper_level` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Level');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`timekeeper_rate` ALTER COLUMN `wip_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Rate Flag');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` SET TAGS ('dbx_subdomain' = 'time_capture');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `doc_review_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Review Assignment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `doc_version_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Version Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `hearing_id` SET TAGS ('dbx_business_glossary_term' = 'Hearing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `timekeeper_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Rate Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `prosecution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `billable_hours` SET TAGS ('dbx_business_glossary_term' = 'Billable Hours');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `billed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Billed Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `billing_guideline_compliant` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Compliant Flag');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `entry_method` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Method');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `entry_method` SET TAGS ('dbx_value_regex' = 'manual|timer|mobile|bulk_import|api');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Number');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Status');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|billed|written_off|rejected');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|blended_rate|afa|pro_bono');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `is_contingency` SET TAGS ('dbx_business_glossary_term' = 'Is Contingency Flag');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `ledes_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Line Item Number');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `lpp_protected` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Protected Flag');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `narrative` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Narrative');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `no_charge` SET TAGS ('dbx_business_glossary_term' = 'No Charge Flag');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `phase_code` SET TAGS ('dbx_business_glossary_term' = 'Matter Phase Code');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `pro_bono_category` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Category');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert|mobile_app|api_integration|manual_upload');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `task_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `utbms_expense_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Expense Code');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `wip_amount` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Amount');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `wip_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Down Amount');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`time_entry` ALTER COLUMN `write_down_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Down Reason Code');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` SET TAGS ('dbx_subdomain' = 'time_capture');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `billing_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `docket_deadline_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Deadline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `production_set_id` SET TAGS ('dbx_business_glossary_term' = 'Production Set Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `prosecution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `billed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `billed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `billing_disbursement_description` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Description');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `billing_period` SET TAGS ('dbx_business_glossary_term' = 'Billing Period');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `billing_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `disbursement_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Number');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_value_regex' = 'draft|wip|billed|written_off|cancelled|on_hold');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_value_regex' = 'hard|soft');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `expense_date` SET TAGS ('dbx_business_glossary_term' = 'Expense Date');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `ledes_expense_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Expense Code');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Markup Percentage');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `narrative_for_client` SET TAGS ('dbx_business_glossary_term' = 'Client-Facing Narrative');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Quantity');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `receipt_reference` SET TAGS ('dbx_business_glossary_term' = 'Receipt Reference');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `recovery_status` SET TAGS ('dbx_value_regex' = 'unrecovered|partially_recovered|fully_recovered|written_off');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert|manual|expense_portal|other');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `utbms_expense_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Expense Code');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `utbms_expense_code` SET TAGS ('dbx_value_regex' = '^E[0-9]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `vendor_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Down Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `legal_ecm`.`billing`.`billing_disbursement` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_value_regex' = 'client_dispute|fee_arrangement|goodwill|uncollectable|billing_error|other');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` SET TAGS ('dbx_subdomain' = 'time_capture');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Ledger ID');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Aging Bucket');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = '0_30_days|31_60_days|61_90_days|91_180_days|over_180_days');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `billing_office_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Office ID');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `billing_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `is_contingency_accrual` SET TAGS ('dbx_business_glossary_term' = 'Is Contingency Accrual Flag');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `phase_code` SET TAGS ('dbx_business_glossary_term' = 'Phase Code');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert|manual');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `standard_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Amount');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `standard_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `standard_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `standard_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_value_regex' = '^A[0-9]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `utbms_expense_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Expense Code');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `utbms_expense_code` SET TAGS ('dbx_value_regex' = '^E[0-9]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_age_days` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Age in Days');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_amount` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Amount');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_amount_firm_currency` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Amount in Firm Currency');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_amount_firm_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Entry Number');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_status` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Status');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_status` SET TAGS ('dbx_value_regex' = 'open|billed|written_off|transferred|on_hold|reversed');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_type` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Type');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `wip_type` SET TAGS ('dbx_value_regex' = 'time|disbursement|expense|fixed_fee|contingency');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `write_up_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Up / Write-Down Amount');
ALTER TABLE `legal_ecm`.`billing`.`wip_ledger` ALTER COLUMN `write_up_down_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`billing`.`prebill` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `prebill_id` SET TAGS ('dbx_business_glossary_term' = 'Prebill ID');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement ID');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `prebill_matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prebill Approved Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|on_demand|annual');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `billing_guideline_compliant` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Compliant Flag');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `billing_guideline_version` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Version');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `disbursement_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Adjustment Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `disbursement_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `disbursement_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|afa|blended_rate|retainer');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `fee_writedown_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Write-Down Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `fee_writedown_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `fee_writedown_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `fee_writeup_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Write-Up Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `fee_writeup_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `fee_writeup_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `generated_date` SET TAGS ('dbx_business_glossary_term' = 'Prebill Generated Date');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `guideline_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Violation Count');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `narrative_edited` SET TAGS ('dbx_business_glossary_term' = 'Narrative Edited Flag');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `on_account_credit_applied` SET TAGS ('dbx_business_glossary_term' = 'On-Account Credit Applied Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `on_account_credit_applied` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `on_account_credit_applied` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `prebill_number` SET TAGS ('dbx_business_glossary_term' = 'Prebill Number');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `prebill_number` SET TAGS ('dbx_value_regex' = '^PB-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `prebill_status` SET TAGS ('dbx_business_glossary_term' = 'Prebill Status');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `prebill_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|on_hold|cancelled');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `prior_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Balance Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `prior_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `prior_balance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `proposed_disbursements_amount` SET TAGS ('dbx_business_glossary_term' = 'Proposed Disbursements Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `proposed_disbursements_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `proposed_disbursements_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `proposed_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Proposed Fees Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `proposed_fees_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `proposed_fees_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `proposed_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Proposed Total Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `proposed_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `proposed_total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Prebill Rejection Reason');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `sent_for_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent for Review Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `timekeeper_count` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Count');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `total_hours_billed` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Billed');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `wip_disbursements_amount` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Disbursements Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `wip_disbursements_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `wip_disbursements_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `wip_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Fees Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `wip_fees_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `wip_fees_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `wip_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Total Amount');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `wip_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`prebill` ALTER COLUMN `wip_total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Amendment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `originating_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Invoice ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Approval Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `billing_office_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Office Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `billing_office_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `credit_application_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Application Status');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `credit_application_status` SET TAGS ('dbx_value_regex' = 'pending|applied|partially_applied|voided');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `credit_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reason');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `disbursements_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Disbursements Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `disbursements_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `disbursements_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Reason');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `ebilling_portal` SET TAGS ('dbx_business_glossary_term' = 'E-Billing Portal');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `ebilling_rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'E-Billing Rejection Reason');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `ebilling_submission_date` SET TAGS ('dbx_business_glossary_term' = 'E-Billing Submission Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `ebilling_submission_status` SET TAGS ('dbx_business_glossary_term' = 'E-Billing Submission Status');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `ebilling_submission_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|accepted|rejected|resubmitted');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|blended_rate|afa|retainer');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fees Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `fees_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `fees_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_note|proforma|interim|final');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `is_electronic_billing` SET TAGS ('dbx_business_glossary_term' = 'Is Electronic Billing Flag');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `ledes_format_version` SET TAGS ('dbx_business_glossary_term' = 'LEDES Format Version');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `ledes_format_version` SET TAGS ('dbx_value_regex' = 'LEDES1998B|LEDES1998BI|LEDESXML21|LEDESXML22');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|due_on_receipt|net_90');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `hearing_id` SET TAGS ('dbx_business_glossary_term' = 'Hearing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `primary_invoice_time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_guideline_compliant` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Compliant Flag');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_guideline_exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Exception Reason');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `client_rejected` SET TAGS ('dbx_business_glossary_term' = 'Client Rejected Flag');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `client_rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Client Rejection Reason');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|contingency|flat_fee|afa|blended_rate|capped_fee');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `ledes_export_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Export Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `ledes_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Line Item Number');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Status');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|approved|billed|written_off|on_hold');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Type');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'time|disbursement|flat_fee|afa_component|tax|credit');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `lpp_protected` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Protected Flag');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `narrative` SET TAGS ('dbx_business_glossary_term' = 'Line Item Narrative');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Billed Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `original_narrative` SET TAGS ('dbx_business_glossary_term' = 'Original Time Entry Narrative');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `phase_code` SET TAGS ('dbx_business_glossary_term' = 'Matter Phase Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Item Quantity');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `standard_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `standard_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `timekeeper_level` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Level');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `timekeeper_level` SET TAGS ('dbx_value_regex' = 'partner|senior_associate|associate|paralegal|trainee|of_counsel');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `utbms_expense_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Expense Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `wip_amount` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `wip_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `write_up_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Up / Write-Down Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice_line` ALTER COLUMN `write_up_down_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement ID');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `parent_arrangement_billing_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fee Arrangement ID');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Submission Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `agreed_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Fee Amount');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `agreed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `amendment_version` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Number');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Status');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|superseded');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `blended_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Blended Hourly Rate');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `blended_hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `contingency_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Contingency Rate Percentage');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `contingency_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `discount_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `expense_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Expense Cap Amount');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `expense_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `expenses_billable` SET TAGS ('dbx_business_glossary_term' = 'Expenses Billable Flag');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Expiry Date');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `ledes_billing_format` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Billing Format');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `ledes_billing_format` SET TAGS ('dbx_value_regex' = 'LEDES98B|LEDES98BI|LEDES2000|LEDESXml|none');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `portfolio_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Arrangement Flag');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainer Amount');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Scope Description');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `scope_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `success_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Success Fee Amount');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `success_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `success_fee_trigger` SET TAGS ('dbx_business_glossary_term' = 'Success Fee Trigger Condition');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `success_fee_trigger` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `tax_applicable` SET TAGS ('dbx_business_glossary_term' = 'Tax Applicable Flag');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `tax_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `utbms_task_code_set` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code Set');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `utbms_task_code_set` SET TAGS ('dbx_value_regex' = 'litigation|counseling|project_finance|bankruptcy|none');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `wip_conversion_rule` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Conversion Rule');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `wip_conversion_rule` SET TAGS ('dbx_value_regex' = 'bill_as_incurred|bill_at_completion|bill_at_milestone|bill_at_cap|pro_rata');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `write_off_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Limit Percentage');
ALTER TABLE `legal_ecm`.`billing`.`fee_arrangement` ALTER COLUMN `write_off_limit_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` SET TAGS ('dbx_subdomain' = 'receivables_settlement');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `billing_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `billing_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `billing_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `billing_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `original_payment_billing_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payment ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Paying Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `retainer_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer ID');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'full|partial|retainer_drawdown|trust_transfer|unapplied');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Applied Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `applied_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Applied Date');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `bank_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Discount Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|afa|blended_rate|retainer');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `gl_period` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Accounting Period');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `gl_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `is_multi_matter` SET TAGS ('dbx_business_glossary_term' = 'Multi-Matter Payment Indicator');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `is_reversed` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Indicator');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `is_trust_payment` SET TAGS ('dbx_business_glossary_term' = 'Trust Payment Indicator');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `overpayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `overpayment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `overpayment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|cheque|ach|credit_card|trust_transfer|retainer_drawdown');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_value_regex' = '^PAY-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'received|applied|partially_applied|unapplied|reversed|voided');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|retainer_drawdown|trust_transfer|overpayment_credit|write_off_reversal');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `received_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `received_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `received_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `remittance_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Reference');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Date');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Reason');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_value_regex' = 'returned_cheque|failed_ach|client_dispute|duplicate_payment|bank_error|other');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Payment Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `wip_cleared_amount` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Cleared Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `wip_cleared_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `wip_cleared_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`billing_payment` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_subdomain' = 'receivables_settlement');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation ID');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `billing_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `retainer_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Account ID');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount_base` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount Base Currency');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount_base` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount_base` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|voided|unapplied');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'full|partial|retainer_drawdown|trust_transfer|write_off_offset|credit_memo');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|not_required');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|afa|blended_rate|retainer');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `gl_post_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Post Date');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Invoice Balance After Allocation');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_after` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_after` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Invoice Balance Before Allocation');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_before` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_before` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `is_auto_allocated` SET TAGS ('dbx_business_glossary_term' = 'Is Auto-Allocated Flag');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `is_trust_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is Trust Compliant Flag');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `ledes_billing_period` SET TAGS ('dbx_business_glossary_term' = 'LEDES Billing Period');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `ledes_billing_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office ID');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `remittance_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Reference');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversed Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert|manual|migration');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `unapplied_balance` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Balance');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `unapplied_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `unapplied_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `wip_cleared_amount` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Cleared Amount');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `wip_cleared_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `wip_cleared_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`payment_allocation` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` SET TAGS ('dbx_subdomain' = 'receivables_settlement');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `ar_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Balance ID');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `matter_risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write Off Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `ar_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Reference Number');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `ar_number` SET TAGS ('dbx_value_regex' = '^AR-[0-9]{8,12}$');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|on_demand|annual');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_0_30_amount` SET TAGS ('dbx_business_glossary_term' = 'AR Aging Bucket 0–30 Days Amount');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_0_30_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_0_30_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_31_60_amount` SET TAGS ('dbx_business_glossary_term' = 'AR Aging Bucket 31–60 Days Amount');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_31_60_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_31_60_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_61_90_amount` SET TAGS ('dbx_business_glossary_term' = 'AR Aging Bucket 61–90 Days Amount');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_61_90_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_61_90_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_over_90_amount` SET TAGS ('dbx_business_glossary_term' = 'AR Aging Bucket Over 90 Days Amount');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_over_90_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `bucket_over_90_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `client_matter_number` SET TAGS ('dbx_business_glossary_term' = 'Client Matter Number');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'current|overdue|in_dispute|sent_to_collections|written_off|settled');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `collections_notes` SET TAGS ('dbx_business_glossary_term' = 'Collections Notes');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Outstanding Balance');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `current_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Flag');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Reason');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_value_regex' = 'fee_dispute|task_code_error|rate_discrepancy|duplicate_invoice|scope_dispute|other');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|afa|blended_rate|retainer');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `interest_accrued` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrued on Overdue Balance');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `interest_accrued` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `interest_accrued` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `iolta_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest on Lawyers Trust Accounts (IOLTA) Flag');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `last_collection_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Collection Contact Date');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `matter_type_code` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Code');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `original_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Amount');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `original_invoice_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `original_invoice_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `total_credits_applied` SET TAGS ('dbx_business_glossary_term' = 'Total Credits Applied');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `total_credits_applied` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `total_credits_applied` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `total_payments_applied` SET TAGS ('dbx_business_glossary_term' = 'Total Payments Applied');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `total_payments_applied` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`ar_balance` ALTER COLUMN `total_payments_applied` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`billing`.`write_off` SET TAGS ('dbx_subdomain' = 'receivables_settlement');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off ID');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `indemnity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Exposure Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `pi_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pi Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `reversed_write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Write-Off ID');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `client_agreed_rate` SET TAGS ('dbx_business_glossary_term' = 'Client Agreed Rate');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `client_agreed_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|afa|blended_rate|retainer');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `hours_written_off` SET TAGS ('dbx_business_glossary_term' = 'Hours Written Off');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Notes');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `original_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `original_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Description');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `requires_secondary_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Secondary Approval Flag');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert|manual|migration');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `standard_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `standard_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `wip_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Entry Date');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Down Amount');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_down_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_category` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Category');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_category` SET TAGS ('dbx_value_regex' = 'fees|disbursements|expenses|interest|tax');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Number');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|reversed|posted|cancelled');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Type');
ALTER TABLE `legal_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_value_regex' = 'wip_write_off|bad_debt|courtesy_discount|billing_guideline_reduction|fee_waiver|expense_write_off');
ALTER TABLE `legal_ecm`.`billing`.`retainer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`billing`.`retainer` SET TAGS ('dbx_subdomain' = 'receivables_settlement');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `retainer_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer ID');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account ID');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `doc_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Execution Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `matter_opening_request_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Opening Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `matter_risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Client Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `retainer_matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Retainer Approval Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `auto_apply_to_invoice_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Apply to Invoice Flag');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|upon_invoice|milestone|annual');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `billing_office_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Office Code');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Retainer Balance');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `drawdown_authorization_rule` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Authorisation Rule');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `drawdown_authorization_rule` SET TAGS ('dbx_value_regex' = 'automatic_on_invoice|manual_approval_required|threshold_triggered|periodic_scheduled');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Retainer Effective Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `evergreen_flag` SET TAGS ('dbx_business_glossary_term' = 'Evergreen Retainer Flag');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retainer Expiry Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `kyc_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Verified Flag');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `last_drawdown_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drawdown Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `last_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Retainer Notes');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Retainer Amount');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `original_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `refundable_flag` SET TAGS ('dbx_business_glossary_term' = 'Refundable Retainer Flag');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `replenishment_demand_date` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Demand Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `replenishment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Due Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `replenishment_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Target Amount');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `replenishment_target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `replenishment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Threshold Amount');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `replenishment_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `retainer_number` SET TAGS ('dbx_business_glossary_term' = 'Retainer Number');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `retainer_number` SET TAGS ('dbx_value_regex' = '^RET-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `retainer_status` SET TAGS ('dbx_business_glossary_term' = 'Retainer Status');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `retainer_status` SET TAGS ('dbx_value_regex' = 'active|suspended|exhausted|replenishment_pending|closed|pending_approval');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `retainer_type` SET TAGS ('dbx_business_glossary_term' = 'Retainer Type');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `retainer_type` SET TAGS ('dbx_value_regex' = 'general|matter_specific|evergreen|security|advance_payment');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Retainer Termination Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Retainer Termination Reason');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'matter_closed|client_withdrawal|funds_exhausted|firm_initiated|superseded|regulatory_closure');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `total_drawn_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Drawn to Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `total_drawn_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `total_replenished_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Replenished to Date');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `total_replenished_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `wip_drawdown_limit` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Drawdown Limit');
ALTER TABLE `legal_ecm`.`billing`.`retainer` ALTER COLUMN `wip_drawdown_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`guideline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`billing`.`guideline` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline ID');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `doc_template_id` SET TAGS ('dbx_business_glossary_term' = 'Doc Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `superseded_by_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Billing Guideline ID');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `afa_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Type');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `afa_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|blended_rate|capped_fee|success_fee');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `applies_to_expenses` SET TAGS ('dbx_business_glossary_term' = 'Applies to Expenses Flag');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `applies_to_time_entries` SET TAGS ('dbx_business_glossary_term' = 'Applies to Time Entries Flag');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Guideline Approved By');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Guideline Approved Date');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `block_billing_prohibited` SET TAGS ('dbx_business_glossary_term' = 'Block Billing Prohibited Flag');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `budget_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Matter Budget Cap Amount');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `budget_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Guideline Effective From Date');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Guideline Effective Until Date');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_business_glossary_term' = 'Guideline Enforcement Action');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_value_regex' = 'hard_block|soft_warning|write_off|require_approval|flag_for_review');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Guideline Exception Notes');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `expense_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Expense Limit Amount');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `expense_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `guideline_description` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Description');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `guideline_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Name');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `guideline_source` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Source');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `guideline_source` SET TAGS ('dbx_value_regex' = 'ocg|engagement_letter|standing_instruction|matter_specific_agreement|court_order');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `guideline_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Status');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `guideline_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|pending_approval|draft');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `invoice_submission_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Invoice Submission Deadline (Days)');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `invoice_submission_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoice Submission Frequency');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `invoice_submission_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|matter_close|milestone|on_demand');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Guideline Last Reviewed Date');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `ledes_billing_format` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Billing Format');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `ledes_billing_format` SET TAGS ('dbx_value_regex' = 'LEDES98B|LEDES98BI|LEDES2000|LEDESxml|none');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `minimum_time_increment_mins` SET TAGS ('dbx_business_glossary_term' = 'Minimum Time Increment (Minutes)');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `narrative_min_length` SET TAGS ('dbx_business_glossary_term' = 'Narrative Minimum Character Length');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `new_timekeeper_rate_freeze` SET TAGS ('dbx_business_glossary_term' = 'New Timekeeper Rate Freeze Flag');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `ocg_section_reference` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guidelines (OCG) Section Reference');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `rate_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Cap Amount');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `rate_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `rate_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Cap Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `rate_cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `rate_increase_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Rate Increase Notice Period (Days)');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Reference Number');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Billing Rule Category');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'timekeeper|expense|invoice_format|matter_budget|task_code|narrative');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Rule Type');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `timekeeper_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Pre-Approval Required Flag');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `timekeeper_level` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Level');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `timekeeper_level` SET TAGS ('dbx_value_regex' = 'partner|counsel|associate|paralegal|staff|all');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`billing`.`guideline` ALTER COLUMN `wip_aging_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Aging Limit (Days)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `invoice_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Time Entry ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `pi_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pi Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `agreed_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Reduction Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `agreed_reduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `agreed_reduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `billing_guideline_reference` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Reference');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `days_to_resolve` SET TAGS ('dbx_business_glossary_term' = 'Days to Resolve');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_value_regex' = '^DISP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `dispute_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|pending_client|resolved|withdrawn|escalated');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'fee_dispute|disbursement_dispute|rate_dispute|timekeeper_dispute|full_invoice_dispute');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `ebilling_platform` SET TAGS ('dbx_business_glossary_term' = 'E-Billing Platform');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|afa|blended_rate|retainer');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `lpp_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Flag');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Received Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'full_reduction|partial_reduction|no_reduction|credit_note|write_off|withdrawn');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert|manual|ebilling_portal');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `write_off_approved` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Approved Flag');
ALTER TABLE `legal_ecm`.`billing`.`invoice_dispute` ALTER COLUMN `write_off_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Approved Date');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note ID');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `indemnity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Exposure Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `pi_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pi Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `application_method` SET TAGS ('dbx_business_glossary_term' = 'Application Method');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `application_method` SET TAGS ('dbx_value_regex' = 'applied_to_ar|cash_refund|held_on_account|offset_future_invoice');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `applied_date` SET TAGS ('dbx_business_glossary_term' = 'Applied Date');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `billing_guideline_ref` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Reference');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Number');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_value_regex' = '^CN-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Status');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_status` SET TAGS ('dbx_value_regex' = 'draft|issued|applied|refunded|held|voided');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Code');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_value_regex' = 'overbilling|dispute_resolution|goodwill_adjustment|fee_cap_correction|billing_error|write_off');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_reason_narrative` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Narrative');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_reason_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'fee_credit|disbursement_credit|tax_credit|combined');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `disbursement_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Credit Amount');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `disbursement_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `disbursement_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `dispute_reference` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `dispute_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|flat_fee|contingency|afa|blended_rate|retainer');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `fee_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Credit Amount');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `fee_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `fee_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Issued Date');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `originating_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Originating Invoice Date');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `originating_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Originating Invoice Number');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `pro_bono_flag` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Flag');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert|manual');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Amount');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `voided_date` SET TAGS ('dbx_business_glossary_term' = 'Voided Date');
ALTER TABLE `legal_ecm`.`billing`.`credit_note` ALTER COLUMN `write_off_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Approved Flag');
