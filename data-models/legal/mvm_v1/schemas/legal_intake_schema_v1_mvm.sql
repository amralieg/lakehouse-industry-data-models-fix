-- Schema for Domain: intake | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`intake` COMMENT 'Manages the end-to-end new business intake and client onboarding pipeline from RFP receipt through LOE execution. Owns prospect qualification, pitch and proposal tracking, engagement scope definition, fee arrangement negotiation (AFA), and handoff to the matter domain upon matter opening. Bridges the CRM pipeline in Microsoft Dynamics 365 with operational matter creation in Elite 3E.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`prospect` (
    `prospect_id` BIGINT COMMENT 'Unique identifier for the prospect record. Primary key for the prospect entity representing a pre-engagement organization or individual in the new business intake pipeline.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Prospects undergo initial AML/KYC screening before conversion to client, governed by the firms AML/KYC program. Real process: pre-client compliance screening in business development.',
    `individual_id` BIGINT COMMENT 'Foreign key linking to client.individual. Business justification: Prospects can be individuals (personal legal services, estate planning, etc.) before becoming formal clients. This FK links individual prospects to the individual master. is_new_attribute=true because',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Prospects are evaluated for specific legal services to scope conflict checks, determine pricing models, and track service-level pipeline. Legal BD experts expect prospects to reference the specific se',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Prospects in legal services are often organizations before they become formal clients. This FK links corporate prospects to the organisation master. is_new_attribute=true because organisation_id is no',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Prospect onboarding and AML/KYC screening is governed by specific compliance policies. The existing link is to aml_kyc_program; a direct policy link enables policy-level prospect screening audit trail',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Prospects must be routed to the correct practice group for BD pipeline reporting and team assignment. Legal BD teams track prospect pipeline by practice area. The existing practice_area plain string',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the client record created upon successful prospect conversion. Nullable until the prospect is converted to a client. Links the pre-engagement prospect state to the post-engagement client entity.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Prospect onboarding requires a risk register entry to track AML, reputational, and jurisdictional risks before matter opening. Legal risk teams maintain prospect-level risk registers as a standard AML',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Prospect onboarding must satisfy specific regulatory obligations (AML Regulations, SRA Conduct Rules). This is distinct from the aml_kyc_program link and supports regulatory obligation tracking and re',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Prospect tier classification determines service scope, pricing approach, and KYC/AML level during BD. Tier-based prospect pipeline analytics are standard in legal BD reporting and partner compensation',
    `aml_screening_status` STRING COMMENT 'Status of Anti-Money Laundering (AML) screening and sanctions list checks. Must be cleared before engagement acceptance.. Valid values are `not_started|in_progress|cleared|flagged|escalated`',
    `competitor_firms` STRING COMMENT 'Names of competing law firms known to be pitching for the same engagement. Used for competitive intelligence and win/loss analysis.',
    `conflict_check_status` STRING COMMENT 'Status of the ethical conflict of interest check performed against existing clients, matters, and adverse parties. Must be cleared before engagement.. Valid values are `not_started|in_progress|cleared|conflict_identified|waived|declined`',
    `conflicts_system_reference` STRING COMMENT 'External identifier linking this prospect to the new business intake record in Intapp Conflicts system. Used for conflict check workflow integration.',
    `converted_to_client_date` DATE COMMENT 'Date on which the prospect was successfully converted to a formal client upon Letter of Engagement (LOE) execution and matter opening. Nullable until conversion occurs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prospect record was first created in the system. Represents the moment the prospect entered the intake pipeline.',
    `crm_account_reference` STRING COMMENT 'External identifier linking this prospect to the corresponding account or lead record in Microsoft Dynamics 365 CRM. Enables bi-directional synchronization.',
    `disqualification_reason` STRING COMMENT 'Reason for disqualifying or declining the prospect opportunity. Populated when pipeline stage moves to lost or declined. Used for loss analysis and process improvement.',
    `engagement_scope_summary` STRING COMMENT 'High-level description of the prospective engagement scope, legal services required, and business objectives. Used for practice group routing and conflict assessment.',
    `estimated_matter_value` DECIMAL(18,2) COMMENT 'Estimated total value or revenue potential of the prospective engagement. Used for pipeline forecasting and resource allocation planning.',
    `estimated_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated matter value. Supports multi-currency pipeline reporting.. Valid values are `^[A-Z]{3}$`',
    `expected_decision_date` DATE COMMENT 'Anticipated date by which the prospect is expected to make a decision on the engagement. Used for pipeline forecasting and follow-up scheduling.',
    `industry_sector` STRING COMMENT 'The primary industry or business sector of the prospect organization. Used for conflict checking, practice group assignment, and sector expertise matching.',
    `jurisdiction` STRING COMMENT 'The primary legal jurisdiction or geographic location where the prospect operates or resides. Critical for conflict checking and regulatory compliance assessment.',
    `kyc_status` STRING COMMENT 'Current status of the Know Your Client (KYC) due diligence and identity verification process. Required before engagement acceptance per AML regulations.. Valid values are `not_started|in_progress|completed|failed|waived`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the prospect record. Used for change tracking and data freshness monitoring.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, meeting notes, special requirements, or internal observations about the prospect and intake process.',
    `pipeline_stage` STRING COMMENT 'Current stage of the prospect in the new business intake pipeline. Tracks progression from initial lead through to engagement or disqualification. [ENUM-REF-CANDIDATE: lead|qualified|pitch_scheduled|proposal_submitted|negotiation|won|lost|on_hold — 8 candidates stripped; promote to reference product]',
    `pitch_date` DATE COMMENT 'Date of the formal pitch or presentation to the prospect. Nullable if no pitch meeting is scheduled or has occurred.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for the prospect. Used for all formal intake communications, RFP responses, and engagement correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the prospect organization or the individual prospect themselves. Key relationship owner for intake communications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the prospect contact. Includes country code and extension where applicable.',
    `proposal_submitted_date` DATE COMMENT 'Date on which the formal engagement proposal or fee quote was submitted to the prospect.',
    `proposed_fee_arrangement_type` STRING COMMENT 'The proposed billing structure or Alternative Fee Arrangement (AFA) for the prospective engagement. Influences pricing strategy and profitability analysis. [ENUM-REF-CANDIDATE: hourly|fixed_fee|contingency|afa_blended|afa_capped|retainer|success_fee|hybrid — 8 candidates stripped; promote to reference product]',
    `prospect_name` STRING COMMENT 'The legal or trading name of the prospective client organization or individual. For organizations, this is the registered business name; for individuals, the full legal name.',
    `prospect_type` STRING COMMENT 'Classification of the prospect entity type. Determines the intake workflow, KYC requirements, and conflict checking scope.. Valid values are `corporate|government|individual|non_profit|partnership|trust`',
    `referral_date` DATE COMMENT 'Date on which the prospect was referred to the firm. Nullable if the prospect source is not a referral. Used for referral attribution and relationship tracking.',
    `referral_source_type` STRING COMMENT 'Classification of the referring party when the prospect source is a referral. Used for referral network analytics and attribution reporting.. Valid values are `client|attorney|professional_advisor|business_contact|alumni|other`',
    `referring_party_name` STRING COMMENT 'Name of the individual or organization that referred this prospect. Nullable if the prospect source is not a referral.',
    `rfp_received_date` DATE COMMENT 'Date on which a formal Request for Proposal (RFP) or engagement inquiry was received from the prospect. Nullable if no formal RFP was issued.',
    `rfp_response_due_date` DATE COMMENT 'Deadline for submitting the proposal or RFP response to the prospect. Used for intake workflow prioritization and resource scheduling.',
    `source_type` STRING COMMENT 'The channel or method through which the prospect entered the new business intake pipeline. Used for business development attribution and marketing effectiveness analysis. [ENUM-REF-CANDIDATE: rfp|referral|bd_outreach|directory|conference|panel|alumni_network|existing_client|website_inquiry|cold_contact — 10 candidates stripped; promote to reference product]',
    `win_probability_percent` DECIMAL(18,2) COMMENT 'Estimated probability of winning the engagement expressed as a percentage (0.00 to 100.00). Used for weighted pipeline forecasting and resource planning.',
    CONSTRAINT pk_prospect PRIMARY KEY(`prospect_id`)
) COMMENT 'Master record for prospective clients entering the new business intake pipeline. Captures the pre-engagement identity of an organization or individual before formal client status is established in the client domain. Tracks prospect source (RFP, referral, BD outreach, directory, conference, panel, alumni network), prospect type (corporate, government, individual), referral attribution (referral source type, referring party, relationship owner, referral date), KYC/AML pre-screening status, originating attorney, and pipeline stage. Bridges Microsoft Dynamics 365 CRM lead/account records with the intake workflow. Supports BD attribution reporting and referral network analytics. Distinct from the client domains client entity — prospect represents the pre-onboarding state prior to conflict clearance and LOE execution.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`rfp_submission` (
    `rfp_submission_id` BIGINT COMMENT 'Unique identifier for the RFP submission record. Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: RFP responses must comply with firm policies on risk acceptance, conflicts, and client acceptance before submission. Real process: policy-driven RFP compliance review and approval.',
    `contact_id` BIGINT COMMENT 'Reference to the primary client contact person who issued or is managing the RFP on behalf of the issuing organisation.',
    `organisation_id` BIGINT COMMENT 'Reference to the prospective or existing client organisation that issued this RFP.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: An RFP is a request for a specific legal service; this link enables service-level win/loss analytics, pricing model selection, and SLA template identification during the RFP response process.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: RFPs are categorized by practice area for pitch team assembly, resource planning, and win/loss reporting by practice group. The existing practice_area plain string is a denormalized representation r',
    `prospect_id` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Every RFP is received from a prospect — this FK is required for pipeline attribution and BD reporting. Without it, RFPs cannot be associated with their originating prospect.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.profile. Business justification: RFP pipeline reporting, rate card application, and conflict clearance require the RFP to be traceable to a client profile. rfp_submission links to organisation and client_contact but lacks a direct pr',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: RFP submissions for regulated sectors (financial services, government) must satisfy specific regulatory obligations. Linking enables compliance-driven RFP eligibility filtering and regulatory obligati',
    `matter_id` BIGINT COMMENT 'Reference to the matter record created in Elite 3E if the RFP was awarded and the engagement proceeded to matter opening.',
    `rfp_prospect_id` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Every RFP is received from a prospect or existing client. The prospect FK is essential for tracking which prospects are generating RFP activity and for pipeline reporting.',
    `competitive_firms` STRING COMMENT 'Names or identifiers of other law firms known to be competing for this RFP, if disclosed by the client or identified through market intelligence.',
    `conflict_check_completed_date` DATE COMMENT 'The date on which the conflict check process was completed for this RFP submission.',
    `conflict_check_status` STRING COMMENT 'The status of the conflict check process for this RFP, indicating whether conflicts of interest have been identified or cleared.. Valid values are `not_started|in_progress|cleared|conflict_identified|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this RFP submission record was first created in the system.',
    `decision_outcome` STRING COMMENT 'The final outcome of the RFP process from the clients perspective (awarded to the firm, declined, no decision made, or withdrawn by client).. Valid values are `awarded|declined|no_decision|withdrawn_by_client`',
    `decision_received_date` DATE COMMENT 'The date on which the firm received notification of the clients decision regarding the RFP (awarded, declined, or no decision).',
    `decline_reason` STRING COMMENT 'The reason why the firm declined to respond to the RFP or why the client declined the firms proposal. [ENUM-REF-CANDIDATE: conflict_of_interest|capacity_constraints|fee_expectations|practice_area_mismatch|strategic_fit|competitive_pricing|other — 7 candidates stripped; promote to reference product]',
    `decline_reason_notes` STRING COMMENT 'Additional free-text notes providing context or details about the decline reason.',
    `estimated_value_amount` DECIMAL(18,2) COMMENT 'The estimated monetary value of the engagement or matter if it proceeds, as assessed by the business development team during initial qualification.',
    `estimated_value_currency` STRING COMMENT 'The currency code for the estimated value amount, following ISO 4217 three-letter standard.. Valid values are `^[A-Z]{3}$`',
    `fee_arrangement_type` STRING COMMENT 'The type of fee arrangement requested or proposed for this engagement (e.g., hourly billing, fixed fee, contingency, capped fee, blended rate, success fee).. Valid values are `hourly|fixed_fee|contingency|capped_fee|blended_rate|success_fee`',
    `gdpr_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the RFP and proposed engagement scope comply with GDPR requirements, relevant for EU-based clients or matters involving EU personal data.',
    `internal_notes` STRING COMMENT 'Free-text internal notes and observations recorded by the pitch team, business development, or intake staff regarding this RFP submission.',
    `is_existing_client` BOOLEAN COMMENT 'Boolean flag indicating whether the issuing organisation is an existing client of the firm (True) or a prospective new client (False).',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction(s) in which the services are required. May include country, state, or multi-jurisdictional scope.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this RFP submission record was last updated or modified.',
    `matter_type` STRING COMMENT 'The specific type of legal matter or engagement being requested (e.g., M&A transaction, patent prosecution, employment dispute, regulatory investigation).',
    `priority_level` STRING COMMENT 'The priority level assigned to this RFP submission by the business development or intake team, reflecting strategic importance or urgency.. Valid values are `high|medium|low`',
    `proposal_submitted_date` DATE COMMENT 'The date on which the firms proposal response was submitted to the issuing organisation.',
    `received_date` DATE COMMENT 'The date on which the RFP was received by the firm. This is the principal business event timestamp marking the start of the intake process.',
    `requires_panel_approval` BOOLEAN COMMENT 'Boolean flag indicating whether this RFP requires approval from a clients legal panel or preferred provider list.',
    `response_deadline_date` DATE COMMENT 'The date by which the firm must submit its response to the RFP, as specified by the issuing organisation.',
    `response_deadline_time` TIMESTAMP COMMENT 'The precise timestamp (including time of day) by which the RFP response must be submitted, if specified by the issuing organisation.',
    `rfp_description` STRING COMMENT 'Detailed description of the legal services being requested, including scope, objectives, and key requirements outlined in the RFP document.',
    `rfp_reference_number` STRING COMMENT 'The external reference number or identifier assigned by the issuing organisation to this RFP. This is the business identifier used in client communications.',
    `rfp_title` STRING COMMENT 'The title or subject of the RFP as provided by the issuing organisation.',
    `source_channel` STRING COMMENT 'The channel or method through which the RFP was received by the firm (e.g., email, client portal, direct mail, referral, existing client relationship). [ENUM-REF-CANDIDATE: email|portal|direct_mail|referral|existing_client|conference|other — 7 candidates stripped; promote to reference product]',
    `submission_status` STRING COMMENT 'The current lifecycle status of the RFP submission within the firms intake workflow (received, under review, declined, responded, withdrawn, awarded).. Valid values are `received|under_review|declined|responded|withdrawn|awarded`',
    `win_probability_percentage` DECIMAL(18,2) COMMENT 'The estimated probability (0-100%) that the firm will win this RFP, as assessed by the pitch team or business development team.',
    CONSTRAINT pk_rfp_submission PRIMARY KEY(`rfp_submission_id`)
) COMMENT 'Transactional record capturing each Request for Proposal received from a prospective or existing client. Tracks RFP receipt date, issuing organization, RFP reference number, practice area scope, response deadline, assigned pitch team, submission status (received, under review, declined, responded), and the resulting pitch or proposal linkage. Sourced from Microsoft Dynamics 365 opportunity pipeline. Serves as the intake trigger event that initiates the prospect qualification and conflict check workflow.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`pitch` (
    `pitch_id` BIGINT COMMENT 'Unique identifier for the pitch record. Primary key.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: A pitch proposes specific legal services to a client; this link enables service-level pitch performance tracking, pricing model alignment, and post-pitch conversion analysis by service type.',
    `matter_id` BIGINT COMMENT 'Reference to the matter opened in Elite 3E following a successful pitch and LOE execution. Null if pitch was lost or matter not yet opened.',
    `package_id` BIGINT COMMENT 'Foreign key linking to service.package. Business justification: Legal service packages are frequently pitched as bundled offerings; linking pitch to package enables package-level win/loss tracking and informs package design based on pitch outcomes.',
    `legal_document_id` BIGINT COMMENT 'Reference to the pitch deck or credentials presentation document stored in the Document Management System (iManage Work or NetDocuments).',
    `pitch_proposal_legal_document_id` BIGINT COMMENT 'Reference to the written proposal document submitted as part of the pitch, stored in the Document Management System.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Pitches are organized by practice area for BD win-rate reporting, team assignment, and competitive analysis by practice group. The existing practice_area plain string is a denormalized representatio',
    `profile_id` BIGINT COMMENT 'Reference to the prospective or existing client organization to whom the pitch was delivered.',
    `rfp_submission_id` BIGINT COMMENT 'FK to intake.rfp_submission.rfp_submission_id — Pitches are made in response to RFPs. This is the core pipeline progression link. Without it, cannot trace RFP→pitch→opportunity flow.',
    `client_attendees` STRING COMMENT 'Names and titles of client representatives who attended the pitch, captured for relationship tracking and follow-up. Comma-separated list.',
    `competing_firms` STRING COMMENT 'Names of known competing law firms participating in the pitch process, if disclosed by the client. Comma-separated list.',
    `competitive_context` STRING COMMENT 'Indicates whether the pitch was sole-sourced or competitive, and if competitive, the approximate number of competing firms: sole_pitch (no competition), competitive_2_firms, competitive_3_firms, competitive_4plus_firms, or unknown.. Valid values are `sole_pitch|competitive_2_firms|competitive_3_firms|competitive_4plus_firms|unknown`',
    `conflict_check_status` STRING COMMENT 'Status of the conflict check performed prior to the pitch: cleared (no conflicts identified), pending (check in progress), flagged (potential conflict identified, under review), or waived (conflict waived by client).. Valid values are `cleared|pending|flagged|waived`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost to the firm of pursuing the pitch, including attorney time, travel, materials, and external consultants. Used for BD ROI analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pitch record was first created in the system.',
    `duration_minutes` STRING COMMENT 'Total duration of the pitch presentation in minutes, including Q&A if applicable.',
    `estimated_matter_value` DECIMAL(18,2) COMMENT 'Estimated total fee value of the engagement if won, in the firms base currency. Used for pipeline forecasting and win/loss analysis.',
    `follow_up_due_date` DATE COMMENT 'Target date by which post-pitch follow-up actions must be completed, if applicable.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether post-pitch follow-up actions are required (e.g., additional information requests, clarifications, supplemental proposals). True if follow-up is needed, False otherwise.',
    `location` STRING COMMENT 'Physical location or virtual platform where the pitch was delivered (e.g., client office address, firm office, video conference platform).',
    `loss_reason_code` STRING COMMENT 'Standardized code or category explaining why the pitch was lost, if applicable (e.g., fee too high, lack of experience, conflict of interest, relationship with competitor, client chose incumbent). Used for win/loss analysis and BD strategy refinement.',
    `matter_type` STRING COMMENT 'Specific type of legal matter or engagement being pitched (e.g., Share Purchase Agreement, Patent Prosecution, Employment Tribunal Defense, Regulatory Investigation).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pitch record was last modified.',
    `outcome` STRING COMMENT 'Final outcome of the pitch: won (firm selected and engagement awarded), lost (firm not selected), pending (decision not yet received), withdrawn (firm withdrew from consideration), or no_decision (client did not proceed with engagement).. Valid values are `won|lost|pending|withdrawn|no_decision`',
    `outcome_date` DATE COMMENT 'Date on which the pitch outcome was communicated to the firm by the client or became known.',
    `pitch_date` DATE COMMENT 'The date on which the pitch was delivered or presented to the prospective client.',
    `pitch_name` STRING COMMENT 'Descriptive name or title of the pitch, typically reflecting the matter type or client engagement scope being pursued.',
    `pitch_status` STRING COMMENT 'Current lifecycle status of the pitch: scheduled (pitch date set but not yet delivered), delivered (pitch completed, awaiting outcome), won (firm selected), lost (firm not selected), pending (outcome not yet known), withdrawn (firm withdrew from consideration), or no_decision (client did not proceed with engagement). [ENUM-REF-CANDIDATE: scheduled|delivered|won|lost|pending|withdrawn|no_decision — 7 candidates stripped; promote to reference product]',
    `pitch_type` STRING COMMENT 'Classification of the pitch format: beauty parade (competitive multi-firm presentation), credentials deck (written credentials submission), oral presentation (in-person or virtual pitch), written proposal (detailed written submission), panel interview (Q&A with client panel), or finalist presentation (final round competitive pitch).. Valid values are `beauty_parade|credentials_deck|oral_presentation|written_proposal|panel_interview|finalist_presentation`',
    `preparation_hours` DECIMAL(18,2) COMMENT 'Total non-billable hours invested by the firm in preparing for the pitch, including research, deck creation, rehearsal, and travel. Used for BD cost analysis.',
    `proposed_fee_arrangement` STRING COMMENT 'Type of fee arrangement proposed in the pitch: hourly (standard time-based billing), fixed_fee (flat fee for scope), capped_fee (hourly with upper limit), contingency (success-based), blended_rate (single rate for all timekeepers), afa_other (alternative fee arrangement not otherwise specified), retainer (ongoing monthly/quarterly fee), or success_fee (bonus upon outcome). [ENUM-REF-CANDIDATE: hourly|fixed_fee|capped_fee|contingency|blended_rate|afa_other|retainer|success_fee — 8 candidates stripped; promote to reference product]',
    `reference_number` STRING COMMENT 'Business-facing unique reference number or code assigned to the pitch for tracking and communication purposes.',
    `rfp` BIGINT COMMENT 'FK to intake.rfp_submission.rfp_submission_id — Pitches are made in response to RFPs — this FK links the response activity to the triggering request. Critical for win/loss analysis.',
    `rfp_submission` BIGINT COMMENT 'FK to intake.rfp_submission.rfp_submission_id — Pitches are made in response to RFPs. This link is critical for tracking RFP-to-pitch conversion rates and pipeline progression.',
    `score` DECIMAL(18,2) COMMENT 'Internal qualitative or quantitative score assigned to the pitch performance by the pitch team or BD leadership, used for continuous improvement. Scale and methodology defined by firm policy.',
    `team_size` STRING COMMENT 'Total number of attorneys and professionals from the firm who participated in the pitch presentation or preparation.',
    `win_loss_notes` STRING COMMENT 'Free-text narrative capturing detailed feedback from the client or internal debrief regarding the pitch outcome, including strengths, weaknesses, and lessons learned.',
    `win_reason_code` STRING COMMENT 'Standardized code or category explaining why the pitch was won, if applicable (e.g., expertise, relationship, fee competitiveness, innovation, diversity). Used for win/loss analysis and BD strategy refinement.',
    CONSTRAINT pk_pitch PRIMARY KEY(`pitch_id`)
) COMMENT 'Master record representing a formal pitch or credentials presentation made to a prospective or existing client in response to an RFP or BD opportunity. Tracks pitch type (beauty parade, credentials deck, oral presentation), pitch date, presenting attorneys, practice areas covered, competitive context, pitch outcome (won, lost, pending, withdrawn), and win/loss reason codes. Linked to the originating RFP submission and the resulting engagement opportunity. Sourced from Microsoft Dynamics 365 opportunity and activity records.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`engagement_opportunity` (
    `engagement_opportunity_id` BIGINT COMMENT 'Unique identifier for the engagement opportunity record. Primary key.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Engagement opportunities require AML/KYC screening under the firms program before conversion to matter. Real process: opportunity-stage compliance screening for high-value or high-risk prospects.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Engagement opportunities track proposal documents (fee proposals, scope documents, capability statements) submitted during business development. Essential for win/loss analysis, proposal reuse, and tr',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: An engagement opportunity is for a specific legal service; this drives service-level pipeline reporting, resource forecasting, and pricing model selection. Legal BD experts expect opportunities to ref',
    `matter_risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.matter_risk_profile. Business justification: Matter risk profiling begins at the engagement opportunity stage in legal operations. Risk teams need to link the opportunity to its matter risk profile for pipeline risk reporting and pre-matter risk',
    `package_id` BIGINT COMMENT 'Foreign key linking to service.package. Business justification: Opportunities may be for packaged service offerings; linking enables package-level pipeline tracking and informs package pricing strategy based on opportunity conversion rates.',
    `pitch_id` BIGINT COMMENT 'FK to intake.pitch.pitch_id — Engagement opportunities are often created from successful pitches. Links the BD pipeline stages.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Engagement opportunities require policy compliance checks before progressing through the BD pipeline. Linking to the governing compliance policy supports opportunity-level compliance gate reporting, d',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Opportunities tracked by practice area for pipeline reporting, resource forecasting, capacity planning, and practice-level revenue projections. Critical for business development dashboards and partner',
    `prospect_id` BIGINT COMMENT 'Reference to the prospective client or existing client organization pursuing this opportunity.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.profile. Business justification: Engagement opportunities for existing clients must link directly to the client profile for revenue forecasting, conflict clearance, and KYC status verification. The opportunity may exist independently',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Opportunities undergo risk assessment during business development; high-risk prospects (sanctions exposure, reputational concerns, conflict complexity) require documented risk register entries and par',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Opportunities in regulated sectors (financial services, healthcare, energy) must identify applicable regulatory obligations early for risk assessment and scoping. Real process: regulatory risk evaluat',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Client tier determines service scope and pricing for an engagement opportunity; this link enables tier-based pipeline analytics and ensures appropriate service scoping during opportunity qualification',
    `actual_close_date` DATE COMMENT 'Actual date the opportunity was closed (won or lost).',
    `afa_type` STRING COMMENT 'Type of fee arrangement under consideration or negotiated for this opportunity. [ENUM-REF-CANDIDATE: hourly|fixed_fee|capped_fee|contingency|blended_rate|success_fee|retainer — 7 candidates stripped; promote to reference product]',
    `competitor_name` STRING COMMENT 'Name of the competing law firm or ALSP that won the engagement, if known.',
    `conflict_check_completed_date` DATE COMMENT 'Date the conflict check was completed and cleared (or waived) for this opportunity.',
    `conflict_check_status` STRING COMMENT 'Current status of the conflict check process in Intapp Conflicts for this opportunity.. Valid values are `not_started|in_progress|cleared|conflict_identified|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created in the CRM system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated matter value.. Valid values are `^[A-Z]{3}$`',
    `dynamics_opportunity_guid` STRING COMMENT 'Globally unique identifier (GUID) of the corresponding Opportunity record in Microsoft Dynamics 365 CRM.',
    `elite_matter_number` STRING COMMENT 'The matter number assigned in Elite 3E if the opportunity was converted to an active matter.',
    `engagement_prospect` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Each engagement opportunity is associated with a prospect. This is the core CRM pipeline link.',
    `engagement_scope_summary` STRING COMMENT 'High-level description of the anticipated scope of work and services to be provided.',
    `estimated_matter_value` DECIMAL(18,2) COMMENT 'Projected total revenue for the matter if the opportunity is won, in the firms base currency.',
    `expected_close_date` DATE COMMENT 'Forecasted date by which the opportunity will reach a closed-won or closed-lost decision.',
    `expected_matter_open_date` DATE COMMENT 'Anticipated date the matter will be opened in Elite 3E if the opportunity is won.',
    `industry_sector` STRING COMMENT 'Industry sector of the prospect organization (e.g., Financial Services, Technology, Healthcare, Energy).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the opportunity is currently active (true) or has been closed or archived (false).',
    `jurisdiction` STRING COMMENT 'Primary legal jurisdiction or geographic region relevant to the anticipated matter.',
    `kyc_completed_date` DATE COMMENT 'Date the KYC and AML due diligence was completed for this opportunity.',
    `kyc_status` STRING COMMENT 'Current status of the KYC and AML due diligence process for the prospect.. Valid values are `not_started|in_progress|completed|failed`',
    `lead_source` STRING COMMENT 'Channel or method through which the opportunity was generated. [ENUM-REF-CANDIDATE: referral|existing_client|rfp|conference|website|cold_outreach|other — 7 candidates stripped; promote to reference product]',
    `loe_executed_date` DATE COMMENT 'Date the Letter of Engagement was signed by both the firm and the client, formalizing the engagement.',
    `loss_reason` STRING COMMENT 'Primary reason the opportunity was lost (e.g., fee, competitor selected, timing, conflict).',
    `matter_opened_in_elite_flag` BOOLEAN COMMENT 'Indicates whether a corresponding matter has been opened in Elite 3E following a closed-won opportunity.',
    `matter_type` STRING COMMENT 'Specific type of legal matter anticipated (e.g., M&A, Patent Prosecution, Employment Dispute, Regulatory Compliance).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was last modified.',
    `opportunity_name` STRING COMMENT 'Descriptive name of the engagement opportunity, typically reflecting the matter type or transaction name.',
    `opportunity_number` STRING COMMENT 'Business-facing unique identifier for the opportunity, typically generated by Microsoft Dynamics 365 CRM.',
    `opportunity_stage` STRING COMMENT 'Current stage of the opportunity in the business development pipeline.. Valid values are `qualification|proposal|negotiation|closed_won|closed_lost|on_hold`',
    `pitch_team_notes` STRING COMMENT 'Internal notes and observations from the pitch team regarding client needs, competitive positioning, and strategy.',
    `probability_percent` DECIMAL(18,2) COMMENT 'Estimated probability of converting this opportunity to a matter, expressed as a percentage (0.00 to 100.00).',
    `proposal_due_date` DATE COMMENT 'Deadline by which the firm must submit its proposal or pitch to the prospect.',
    `proposal_submitted_date` DATE COMMENT 'Date the firm submitted its formal proposal or pitch to the prospect.',
    `prospect` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Each engagement opportunity is associated with a prospect. Required for pipeline conversion reporting.',
    `rfp_received_date` DATE COMMENT 'Date the firm received the RFP or initial inquiry from the prospect.',
    `source_campaign` STRING COMMENT 'Marketing campaign or business development initiative that generated this opportunity.',
    CONSTRAINT pk_engagement_opportunity PRIMARY KEY(`engagement_opportunity_id`)
) COMMENT 'Core CRM pipeline entity representing a qualified business development opportunity for a specific legal matter or ongoing client relationship. Tracks opportunity stage (qualification, proposal, negotiation, closed-won, closed-lost), estimated matter value, practice group, responsible partner, probability of conversion, expected matter open date, and AFA type under consideration. Maps directly to Microsoft Dynamics 365 Opportunity records and serves as the commercial anchor linking prospect, pitch, and eventual matter opening in Elite 3E.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`request` (
    `request_id` BIGINT COMMENT 'Unique identifier for the new business intake request. Primary key for the intake workflow orchestration record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: Intake requests that require a trust account reference the resulting trust account once opened. This link supports matter onboarding workflows, enables compliance teams to verify trust account setup a',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Intake requests execute under the firms AML/KYC program, which defines screening protocols, risk appetite, and approval thresholds. Real process: client acceptance procedures governed by AML/KYC prog',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: New matter requests involve personal data processing that must be registered under GDPR Article 30. Linking request to the data privacy register entry supports GDPR compliance reporting and DPO oversi',
    `eligibility_rule_id` BIGINT COMMENT 'Foreign key linking to service.eligibility_rule. Business justification: Eligibility rules are evaluated during intake to determine if a client qualifies for a service; this link provides the audit trail of which rule was applied and enables automated eligibility checking ',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: The intake request is the formal workflow record initiated from a qualified engagement opportunity in the CRM pipeline. Linking request.engagement_opportunity_id → engagement_opportunity.engagement_op',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Intake requests require supporting documentation (engagement letters, conflict waivers, client correspondence, corporate records) for conflict clearance, KYC compliance, and matter opening approval wo',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: An intake request is for a specific legal service; this is fundamental to routing, conflict check scoping, eligibility rule evaluation, and matter opening. Legal intake experts consider this a core FK',
    `matter_id` BIGINT COMMENT 'Reference to the opened matter record in Elite 3E. Populated upon successful matter opening and handoff to the matter domain.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: New matter requests are evaluated and approved against firm compliance policies (AML, conflicts, data protection). The request approval workflow depends on identifying which policy governs the intake,',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Intake requests must be routed to the correct practice area for staffing, conflict checking, and billing setup. The existing practice_area plain string is a denormalized representation requiring nor',
    `profile_id` BIGINT COMMENT 'Reference to an existing client record if this intake request is for a new matter for an existing client. Null if this is a completely new client.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Intake requests identify conflicts, AML, sanctions, and reputational risks during client onboarding that must be formally logged in the risk register for compliance reporting, risk committee review, a',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Intake requests must verify applicable regulatory obligations (AML, sanctions, jurisdiction-specific requirements) before client acceptance. Real process: regulatory compliance screening during intake',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: Intake requests initiate retainer arrangements; the resulting retainer_agreement is the trust-side execution. Linking request to retainer_agreement supports matter onboarding audit trails, confirms re',
    `rfp_submission_id` BIGINT COMMENT 'Reference to the RFP or pitch opportunity in Microsoft Dynamics 365 CRM that originated this intake request. Links intake to business development pipeline.',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: SLA templates govern response and turnaround commitments from the moment of intake request; linking enables SLA compliance tracking and breach alerting from request submission through matter opening.',
    `adverse_parties` STRING COMMENT 'Names of opposing parties, counterparties, or other entities adverse to the clients interests. Critical for conflict checking and ethical wall determination.',
    `aml_screening_status` STRING COMMENT 'Status of the anti-money laundering screening against sanctions lists, PEP databases, and adverse media sources.. Valid values are `Not Started|In Progress|Clear|Alert Identified|Escalated|Cleared with Conditions`',
    `approval_status` STRING COMMENT 'Status of the engagement approval decision by the supervising partner, conflicts committee, or other governance body.. Valid values are `Pending|Approved|Rejected|Conditional Approval`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the engagement was formally approved and authorized to proceed to matter opening.',
    `conflict_check_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict check process was completed and a determination was made.',
    `conflict_check_status` STRING COMMENT 'Status of the ethical conflict screening process. Indicates whether conflicts have been identified and whether they have been waived or require declination.. Valid values are `Not Started|In Progress|Clear|Conflict Identified|Waived|Declined`',
    `conflict_waiver_obtained` BOOLEAN COMMENT 'Indicates whether a formal conflict waiver was obtained from affected parties to proceed despite an identified conflict.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the intake request record was first created in the system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated fee amount and billing currency.. Valid values are `^[A-Z]{3}$`',
    `estimated_fee_amount` DECIMAL(18,2) COMMENT 'Estimated total professional fees for the matter. Used for budgeting, resource planning, and client communication.',
    `intake_status` STRING COMMENT 'Current stage of the intake request in the workflow lifecycle. Progresses from submission through conflict clearance, compliance screening, approval, and matter opening. [ENUM-REF-CANDIDATE: Submitted|Conflict Check In Progress|KYC In Progress|Pending Approval|Approved|Rejected|Matter Opened|Withdrawn — 8 candidates stripped; promote to reference product]',
    `kyc_status` STRING COMMENT 'Status of the client due diligence and identity verification process required for AML compliance and risk management.. Valid values are `Not Started|In Progress|Completed|Failed|Waived`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the intake request record was last updated. Used for audit trail and change tracking.',
    `loe_executed_date` DATE COMMENT 'Date on which the engagement letter was signed by both the firm and the client, formalizing the attorney-client relationship.',
    `loe_required` BOOLEAN COMMENT 'Indicates whether a formal letter of engagement or engagement letter must be executed before matter opening.',
    `loe_status` STRING COMMENT 'Status of the engagement letter execution process. Tracks whether the LOE has been drafted, sent, and signed by the client.. Valid values are `Not Required|Draft|Sent to Client|Executed|Declined`',
    `matter_description` STRING COMMENT 'Detailed description of the proposed legal matter, including nature of work, transaction details, or dispute summary. Used for conflict checking and scope definition.',
    `matter_opened_flag` BOOLEAN COMMENT 'Indicates whether the matter has been successfully opened in Elite 3E and the intake process is complete.',
    `matter_opened_timestamp` TIMESTAMP COMMENT 'Date and time when the matter was formally opened in Elite 3E and transitioned from intake to active matter management.',
    `matter_type` STRING COMMENT 'Specific classification of the legal work within the practice area (e.g., M&A, Patent Prosecution, Commercial Litigation, Employment Dispute).',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or context relevant to the intake request and approval process.',
    `office_code` STRING COMMENT 'Code identifying the firm office location that will be responsible for the matter. Used for jurisdiction, staffing, and billing purposes.. Valid values are `^[A-Z]{2,4}$`',
    `proposed_client_name` STRING COMMENT 'Name of the prospective client or organization for whom legal services are being requested. May be an existing client for a new matter or a completely new client.',
    `proposed_fee_arrangement_type` STRING COMMENT 'Type of billing arrangement proposed for the matter. May be traditional hourly or an alternative fee arrangement negotiated with the client. [ENUM-REF-CANDIDATE: Hourly|Fixed Fee|Contingency|Blended|Capped Fee|Success Fee|Retainer — 7 candidates stripped; promote to reference product]',
    `proposed_matter_number` STRING COMMENT 'Reserved or proposed matter number that will be assigned in Elite 3E upon matter opening. May follow firm numbering conventions.. Valid values are `^[0-9]{6,10}(-[0-9]{3})?$`',
    `rejection_reason` STRING COMMENT 'Explanation for why the intake request was rejected or declined. May include conflict details, risk concerns, or capacity constraints.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the intake request, typically formatted as office code followed by sequential number. Used for tracking and reference in communications.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `risk_rating` STRING COMMENT 'Overall risk assessment for the engagement based on conflict analysis, client profile, matter complexity, and regulatory exposure.. Valid values are `Low|Medium|High|Critical`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the intake request was formally submitted into the workflow system. Marks the start of the intake lifecycle.',
    `target_matter_open_date` DATE COMMENT 'Requested or target date by which the matter should be opened in Elite 3E and work can commence.',
    `urgency_flag` BOOLEAN COMMENT 'Indicates whether this intake request requires expedited processing due to time-sensitive business needs, court deadlines, or transaction timelines.',
    CONSTRAINT pk_request PRIMARY KEY(`request_id`)
) COMMENT 'Central workflow orchestration record for the new business intake lifecycle. Represents the formal request submitted by an attorney or BD professional to initiate conflict checking, KYC/AML screening, engagement approval, and ultimately matter opening in Elite 3E. Captures requesting timekeeper, proposed client name, adverse parties, matter description, practice area, office, supervising partner, urgency flag, submission timestamp, and matter opening details (proposed matter number, billing arrangement, approval status). Progresses through stages from submission through conflict clearance, LOE execution, and matter number reservation. Acts as the operational trigger in Intapp Conflicts and the handoff record to the matter domain. Encompasses the full intake-to-open lifecycle including onboarding task tracking and matter opening request details.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`conflict_search` (
    `conflict_search_id` BIGINT COMMENT 'Primary key for conflict_search',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Conflict searches are governed by the firms conflicts of interest policy. Linking to the governing policy enables policy-driven conflict search workflows and supports policy effectiveness reporting f',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Conflict searches are scoped by practice area to apply correct conflict rules and ethical wall requirements; practice-area-specific conflict protocols are a regulatory and professional responsibility ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Conflict searches are conducted to satisfy specific regulatory obligations (SRA Code of Conduct Chapter 6, professional conduct rules). Linking to the regulatory obligation supports regulatory complia',
    `request_id` BIGINT COMMENT 'Reference to the parent new business intake request that triggered this conflict search.',
    `alternate_names_searched` STRING COMMENT 'Comma-separated list of alternate names, aliases, DBA names, former names, or related entity names included in the conflict search parameters to ensure comprehensive coverage.',
    `automated_search_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) whether this conflict search was triggered automatically by system workflow rules (True) or manually initiated by a user (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this conflict search record was first created in the system, used for audit trail and data lineage.',
    `database_snapshot_timestamp` TIMESTAMP COMMENT 'The timestamp of the relationship and matter database snapshot against which this search was executed, important for understanding data currency and reproducibility.',
    `error_message` STRING COMMENT 'Technical error message or exception details if the conflict search failed or encountered issues during execution. Null for successful searches.',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) whether this search result requires escalation to conflicts counsel or senior management for clearance decision. True indicates high-risk conflicts detected.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict search was escalated to conflicts counsel for review. Null if no escalation occurred.',
    `high_risk_hits_count` STRING COMMENT 'Number of search results flagged by the system as high-risk conflicts requiring immediate escalation and review by conflicts counsel.',
    `intake_request` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — Conflict searches are executed as part of processing an intake request. This is the core operational trigger link.',
    `jurisdiction_filter` STRING COMMENT 'Geographic or legal jurisdiction filter applied to the conflict search to limit results to matters in specific regions or court systems.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this conflict search record was last updated, used for audit trail and change tracking.',
    `low_risk_hits_count` STRING COMMENT 'Number of search results flagged as low-risk or informational matches that may not constitute actual conflicts but warrant awareness.',
    `match_threshold_percentage` DECIMAL(18,2) COMMENT 'The minimum similarity percentage threshold (0-100) used to determine whether a potential match is included in search results. Lower thresholds return more results but may include false positives.',
    `matter_type_filter` STRING COMMENT 'The matter type or practice area filter applied to the conflict search (e.g., M&A, litigation, IP prosecution) to narrow results to relevant engagements.',
    `medium_risk_hits_count` STRING COMMENT 'Number of search results flagged as medium-risk conflicts requiring standard review and potential waiver or ethical wall consideration.',
    `office_location_code` STRING COMMENT 'Code identifying the firm office location from which the conflict search was initiated, used for multi-office conflict management and jurisdiction-specific rules.',
    `party_name_searched` STRING COMMENT 'The primary party name (individual or organization) that was the subject of this conflict search. May be client, adverse party, or related entity.',
    `party_role` STRING COMMENT 'The role of the party being searched in the context of the prospective engagement. Prospective_client indicates the party seeking representation; adverse_party indicates opposing party; related_entity indicates affiliated organization; counterparty indicates transaction opposite party.. Valid values are `prospective_client|adverse_party|related_entity|counterparty|witness|other`',
    `party_type` STRING COMMENT 'Classification of the party being searched: individual person, corporate/organizational entity, or government/public sector entity.. Valid values are `individual|organization|government_entity`',
    `practice_group_code` STRING COMMENT 'Code identifying the practice group or department conducting the conflict search, used for practice-specific conflict rules and reporting.',
    `results_export_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict search results were exported. Null if results have not been exported.',
    `results_exported_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) whether the conflict search results were exported to external format (PDF, Excel, or report) for distribution or review.',
    `search_algorithm_type` STRING COMMENT 'The matching algorithm used for this conflict search. Exact_match requires precise name matches; fuzzy_match allows for spelling variations; phonetic_match uses soundex-style matching; ai_enhanced uses natural language processing and machine learning.. Valid values are `exact_match|fuzzy_match|phonetic_match|ai_enhanced`',
    `search_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict search processing completed and results were returned. Null if search is still in progress or failed.',
    `search_date_range_end` DATE COMMENT 'End date of the matter date range filter applied to the conflict search, if search_scope is specific_date_range. Null for other scopes.',
    `search_date_range_start` DATE COMMENT 'Start date of the matter date range filter applied to the conflict search, if search_scope is specific_date_range. Null for other scopes.',
    `search_engine_version` STRING COMMENT 'Version identifier of the Intapp Conflicts search engine used to execute this search, important for audit trail and result reproducibility.',
    `search_executed_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict search was executed against the relationship and matter database. This is the principal business event timestamp for the search.',
    `search_execution_duration_seconds` STRING COMMENT 'The elapsed time in seconds from search initiation to completion, used for performance monitoring and system optimization.',
    `search_intake` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — Conflict searches are executed as part of an intake request workflow. Required for tracking which searches belong to which intake.',
    `search_notes` STRING COMMENT 'Free-text notes entered by the searcher documenting search rationale, special considerations, or preliminary assessment of results. May contain attorney work product.',
    `search_priority` STRING COMMENT 'The business priority assigned to this conflict search. Urgent indicates time-sensitive RFP or pitch deadline; high indicates important prospective client; normal indicates standard intake workflow; low indicates preliminary inquiry.. Valid values are `urgent|high|normal|low`',
    `search_reference_number` STRING COMMENT 'Business-facing unique reference number for the conflict search, typically generated by Intapp Conflicts system in format CS-YYYYMMDD-NNNN.. Valid values are `^CS-[0-9]{8}-[0-9]{4}$`',
    `search_retry_count` STRING COMMENT 'Number of times this conflict search was re-executed due to technical failures, timeout errors, or user-requested refinement. Zero indicates first successful execution.',
    `search_scope` STRING COMMENT 'The temporal scope of the conflict search. Current_matters searches only active engagements; all_matters includes historical; closed_matters searches only concluded engagements; specific_date_range searches a defined period.. Valid values are `current_matters|all_matters|closed_matters|specific_date_range`',
    `search_status` STRING COMMENT 'Current lifecycle status of the conflict search execution. Pending indicates queued; in_progress indicates actively running; complete indicates search finished with results; escalated indicates potential conflicts requiring review; cancelled indicates search was aborted; failed indicates technical error.. Valid values are `pending|in_progress|complete|escalated|cancelled|failed`',
    `searcher_name` STRING COMMENT 'Full name of the individual who executed the conflict search, captured for audit trail purposes.',
    `total_hits_returned` STRING COMMENT 'The total number of potential conflict matches (matters, clients, or relationships) returned by the search engine. Zero indicates no conflicts found; higher numbers indicate potential issues requiring review.',
    CONSTRAINT pk_conflict_search PRIMARY KEY(`conflict_search_id`)
) COMMENT 'Transactional record of each conflict-of-interest search executed against the firms relationship and matter database during the intake workflow. Tracks search parameters (party names, roles, matter type), execution timestamp, search engine version, number of hits returned, searcher identity, and overall search status (pending, complete, escalated). Each intake request may generate multiple conflict searches for different parties. Sourced from Intapp Conflicts search execution logs. Boundary: this entity captures the search execution act and raw results within the intake workflow; formal clearance decisions, waiver approvals, and ethical wall configurations are owned by the conflict domain.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`intake_party` (
    `intake_party_id` BIGINT COMMENT 'Unique identifier for the intake party record. Primary key for the intake party entity representing unverified parties at the pre-clearance stage before formal client onboarding.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Parties being onboarded are screened against the firms AML/KYC program requirements for PEP, sanctions, and adverse media. Real process: party-level compliance screening during intake.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Intake parties require linking to entity formation documents, corporate registrations, certificates of incorporation, and organizational charts for conflict checking, KYC verification, and corporate s',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Conflict checking requires identifying when an adverse or counterparty in an intake request is an existing client organisation. Linking intake_party to client.organisation enables automated conflict a',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Intake party onboarding is governed by specific compliance policies (AML, KYC, data protection). Linking to the governing policy enables policy-driven onboarding workflows and supports SRA/regulatory ',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Parties with PEP flags, sanctions matches, or adverse media generate individual risk register entries. AML regulations and SRA rules require party-level risk tracking. intake_party has aml_risk_rating',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Intake parties are screened against specific regulatory obligations (AML Regulations, Sanctions Regulations, SRA rules). Linking to the regulatory obligation supports regulatory compliance reporting f',
    `request_id` BIGINT COMMENT 'Reference to the parent new business intake request that this party is associated with. Links the party to the originating RFP or engagement opportunity.',
    `adverse_media_flag` BOOLEAN COMMENT 'Indicates whether adverse media or negative news was identified during screening. Triggers enhanced review and risk assessment.',
    `aml_risk_rating` STRING COMMENT 'The assessed AML risk level for this party based on jurisdiction, industry, ownership structure, and screening results. Determines enhanced due diligence requirements.. Valid values are `low|medium|high|prohibited`',
    `aml_screening_date` DATE COMMENT 'The date when AML screening was completed for this party. Required for compliance documentation and regulatory reporting.',
    `aml_screening_status` STRING COMMENT 'Status of the AML screening process for this party. Tracks sanctions list checks, PEP screening, and adverse media searches required for regulatory compliance.. Valid values are `not-started|in-progress|completed|failed|waived`',
    `business_address_line1` STRING COMMENT 'The first line of the partys primary business address. For individuals, the primary residence or business location.',
    `business_address_line2` STRING COMMENT 'The second line of the partys primary business address, including suite, floor, or building information.',
    `business_city` STRING COMMENT 'The city of the partys primary business address.',
    `business_country_code` STRING COMMENT 'The three-letter ISO country code of the partys primary business address. Used for jurisdiction analysis and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `business_postal_code` STRING COMMENT 'The postal or ZIP code of the partys primary business address.',
    `business_state_province` STRING COMMENT 'The state or province of the partys primary business address.',
    `conflict_check_date` DATE COMMENT 'The date when the conflict check was performed for this party. Required for ethics compliance and audit documentation.',
    `conflict_check_status` STRING COMMENT 'Status of the conflict of interest check for this party. Tracks whether the party has been searched against existing client and matter databases to identify potential conflicts.. Valid values are `not-started|in-progress|cleared|conflict-identified|waived`',
    `conflict_description` STRING COMMENT 'Detailed description of any identified conflicts, including the nature of the conflict, related matters, and affected parties. Used for conflict resolution and waiver analysis.',
    `conflict_identified_flag` BOOLEAN COMMENT 'Indicates whether a conflict of interest was identified for this party during conflict checking. True requires conflict resolution or engagement rejection.',
    `conflict_waiver_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent waivers have been obtained from all affected parties to proceed despite an identified conflict.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this intake party record was first created in the system. Used for audit trails and intake process analytics.',
    `entity_type` STRING COMMENT 'The legal classification of the party. Determines applicable conflict checking rules, KYC requirements, and regulatory obligations. [ENUM-REF-CANDIDATE: corporation|individual|partnership|government|non-profit|trust|llc — 7 candidates stripped; promote to reference product]',
    `industry_sector` STRING COMMENT 'The primary industry or business sector of the party. Used for conflict analysis, expertise matching, and risk assessment.',
    `intake_request_fk` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — Parties are associated with a specific intake request for conflict checking purposes. Core operational link.',
    `jurisdiction_of_incorporation` STRING COMMENT 'The legal jurisdiction where the party is incorporated, registered, or domiciled. For individuals, the jurisdiction of primary residence. Critical for conflict checking and regulatory compliance.',
    `kyc_screening_date` DATE COMMENT 'The date when KYC screening was completed for this party. Used for compliance audit trails and periodic re-screening requirements.',
    `kyc_screening_status` STRING COMMENT 'Status of the KYC due diligence process for this party. Tracks completion of identity verification, sanctions screening, and AML checks required before engagement.. Valid values are `not-started|in-progress|completed|failed|waived`',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special considerations, or intake team observations about this party. Used for handoff to matter management.',
    `party_name` STRING COMMENT 'The full legal name of the party as it appears in official records. For individuals, includes full given and family names. For organizations, the registered legal entity name.',
    `party_role` STRING COMMENT 'The role this party plays in the intake request. Client represents the prospective client, adverse represents opposing parties, related represents affiliated entities, guarantor represents financial guarantors, co-counsel represents collaborating law firms, and subsidiary represents dependent entities.. Valid values are `client|adverse|related|guarantor|co-counsel|subsidiary`',
    `party_status` STRING COMMENT 'Current lifecycle status of the party within the intake process. Pending indicates initial capture, screening indicates KYC/AML checks in progress, cleared indicates conflict-free and approved, rejected indicates conflicts identified or failed screening, escalated indicates manual review required.. Valid values are `pending|screening|cleared|rejected|escalated`',
    `pep_flag` BOOLEAN COMMENT 'Indicates whether the party is identified as a Politically Exposed Person requiring enhanced due diligence under AML regulations.',
    `primary_contact_email` STRING COMMENT 'The email address of the primary contact for this party. Used for intake communications and engagement correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person for this party during the intake process. For organizations, the key decision-maker or authorized representative.',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary contact for this party. Used for intake discussions and engagement negotiations.',
    `registration_number` STRING COMMENT 'The official registration or incorporation number assigned by the jurisdiction of incorporation. Used for entity verification and due diligence.',
    `sanctions_match_flag` BOOLEAN COMMENT 'Indicates whether the party matched any sanctions lists during screening (OFAC, UN, EU, etc.). True indicates a match requiring investigation or rejection.',
    `source_system` STRING COMMENT 'The system from which this party record originated (e.g., Microsoft Dynamics 365 CRM, Intapp Conflicts, manual entry). Used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier for this party in the source system. Enables traceability and synchronization with upstream systems.',
    `tax_identification_number` STRING COMMENT 'The tax identification number for the party (EIN for US entities, VAT number for EU entities, etc.). Required for billing and tax reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this intake party record was last modified. Tracks the most recent change to any attribute for audit and synchronization purposes.',
    `website_url` STRING COMMENT 'The primary website URL for the party. Used for background research and entity verification during intake.',
    CONSTRAINT pk_intake_party PRIMARY KEY(`intake_party_id`)
) COMMENT 'Master record of each party (client, adverse party, related entity, guarantor, subsidiary) associated with a new business intake request. Captures party name, party role (client, adverse, related, guarantor, co-counsel), entity type (corporation, individual, government), jurisdiction of incorporation, parent entity reference, and KYC/AML screening status. Supports multi-party conflict searches and adverse party tracking. Distinct from the client domains client entity — intake_party represents unverified parties at the pre-clearance stage before formal client onboarding.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`kyc_screening` (
    `kyc_screening_id` BIGINT COMMENT 'Unique identifier for the KYC screening record. Primary key.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: KYC screenings are conducted under a specific AML/KYC programs methodology, risk rating framework, and regulatory requirements. Real process: program-governed client due diligence execution.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: KYC screening activities execute specific compliance controls (CDD, EDD controls). Linking screening results to the compliance control being tested supports control effectiveness measurement and regul',
    `control_framework_id` BIGINT COMMENT 'Foreign key linking to compliance.control_framework. Business justification: KYC screening is executed under a specific compliance control framework (e.g., FATF CDD framework, internal AML controls). Legal firms must evidence which control framework governed each screening for',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: KYC screenings may be associated with specific engagement opportunities in addition to intake requests. This links the screening to the opportunity for traceability, enabling tracking of which opportu',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: KYC screenings require linking to supporting documentation (corporate registrations, beneficial ownership records, sanctions screening reports, AML verification documents) for regulatory compliance, a',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: KYC screening is conducted under specific compliance policies (AML Policy, Client Acceptance Policy). The existing link is to aml_kyc_program; a direct policy link supports policy-level KYC audit repo',
    `intake_party_id` BIGINT COMMENT 'FK to intake.intake_party.intake_party_id — KYC screenings are performed on specific intake parties. Required for compliance traceability.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: KYC screening outcomes (high-risk ratings, PEP flags, adverse media hits, sanctions matches) automatically generate risk register entries for client acceptance committee review, enhanced due diligence',
    `request_id` BIGINT COMMENT 'Reference to the parent intake record for which this KYC screening was performed.',
    `adverse_media_hit_flag` BOOLEAN COMMENT 'Boolean indicator of whether adverse media or negative news was found associated with the party. True if adverse media found, False otherwise.',
    `approval_date` DATE COMMENT 'Date on which the final approval or rejection decision was made by the compliance officer.',
    `approval_notes` STRING COMMENT 'Detailed notes or rationale provided by the compliance officer explaining the approval or rejection decision, including any conditions or mitigating factors.',
    `approval_status` STRING COMMENT 'Final approval status determined by the compliance officer: approved (client may be onboarded), rejected (onboarding declined), conditional (approved with restrictions), or pending (awaiting decision).. Valid values are `approved|rejected|conditional|pending`',
    `comments` STRING COMMENT 'Additional free-text comments or notes related to the screening process, findings, or decision-making rationale.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this KYC screening record was first created in the system.',
    `data_classification` STRING COMMENT 'Data classification level assigned to this screening record based on sensitivity and regulatory requirements.. Valid values are `restricted|confidential|internal|public`',
    `edd_completion_date` DATE COMMENT 'Date on which Enhanced Due Diligence procedures were completed, if required.',
    `edd_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether Enhanced Due Diligence is required for this party based on risk rating or regulatory requirements. True if EDD required, False otherwise.',
    `escalation_date` DATE COMMENT 'Date on which the screening was escalated to compliance officer or senior management for review.',
    `escalation_reason` STRING COMMENT 'Detailed explanation of why the screening was escalated for further review, including specific match details, risk factors, or compliance concerns.',
    `jurisdiction_risk_level` STRING COMMENT 'Risk level associated with the jurisdiction or country of the party being screened, based on FATF assessments, corruption indices, and regulatory environment.. Valid values are `low|medium|high`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this KYC screening record was last updated or modified.',
    `match_count` STRING COMMENT 'Number of potential matches or hits returned by the screening provider against sanctions lists, PEP databases, or adverse media sources.',
    `party` BIGINT COMMENT 'FK to intake.party.party_id — KYC/AML screenings are performed on specific parties. This link is essential for compliance audit trails.',
    `pep_hit_flag` BOOLEAN COMMENT 'Boolean indicator of whether the party is identified as a Politically Exposed Person or close associate. True if PEP match found, False otherwise.',
    `re_screening_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether periodic re-screening is required for this party. True if re-screening required, False otherwise.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a Suspicious Activity Report (SAR) or other regulatory filing is required based on the screening results. True if filing required, False otherwise.',
    `review_date` DATE COMMENT 'Date on which the compliance review of the screening results was completed.',
    `reviewer_name` STRING COMMENT 'Full name of the compliance officer or staff member who reviewed and approved or rejected the screening.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the party based on the screening results: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned by the screening provider or internal risk model, typically on a scale of 0-100.',
    `sanctions_hit_flag` BOOLEAN COMMENT 'Boolean indicator of whether the party matched any sanctions lists (OFAC, UN, EU, HMT, etc.). True if match found, False otherwise.',
    `sar_filing_date` DATE COMMENT 'Date on which a Suspicious Activity Report was filed with the relevant authority (e.g., National Crime Agency in UK, FinCEN in US) based on screening findings.',
    `sar_reference_number` STRING COMMENT 'Reference number assigned by the regulatory authority upon submission of the Suspicious Activity Report.',
    `screening_cost_amount` DECIMAL(18,2) COMMENT 'Cost incurred for conducting the screening, typically charged by the third-party screening provider.',
    `screening_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the screening cost amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `screening_date` DATE COMMENT 'Date on which the KYC or AML screening was performed.',
    `screening_expiry_date` DATE COMMENT 'Date on which the current screening results expire and re-screening is required, typically based on firm policy or regulatory requirements (e.g., annual re-screening).',
    `screening_outcome` STRING COMMENT 'Final outcome of the screening: cleared (no issues found), escalated (flagged for further review), rejected (onboarding declined), pending review, or requires EDD (Enhanced Due Diligence).. Valid values are `cleared|escalated|rejected|pending_review|requires_edd`',
    `screening_party` BIGINT COMMENT 'FK to intake.party.party_id — KYC/AML screenings are performed on specific intake parties. Required for compliance audit trail.',
    `screening_provider` STRING COMMENT 'Name of the third-party screening service provider or internal system used to conduct the screening (e.g., Dow Jones Risk & Compliance, LexisNexis Bridger, World-Check, internal compliance database).',
    `screening_reference_number` STRING COMMENT 'External reference number or case identifier assigned by the screening provider or internal compliance system.',
    `screening_status` STRING COMMENT 'Current lifecycle status of the screening record: initiated, in progress, completed, expired (requires re-screening), or cancelled.. Valid values are `initiated|in_progress|completed|expired|cancelled`',
    `screening_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the screening was initiated or completed, including time zone information.',
    `screening_type` STRING COMMENT 'Type of due diligence screening performed: KYC (Know Your Client), AML (Anti-Money Laundering), sanctions list check, PEP (Politically Exposed Person) check, adverse media search, or credit check.. Valid values are `kyc|aml|sanctions|pep|adverse_media|credit`',
    `source_of_funds_verified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the source of funds or wealth for the party has been verified as part of the KYC process. True if verified, False otherwise.',
    CONSTRAINT pk_kyc_screening PRIMARY KEY(`kyc_screening_id`)
) COMMENT 'Transactional record capturing the Know Your Client (KYC) and Anti-Money Laundering (AML) due diligence screening performed on a prospective client or intake party during the onboarding process. Tracks screening type (KYC, AML, sanctions, PEP check), screening provider, screening date, risk rating assigned (low, medium, high), screening outcome (cleared, escalated, rejected), escalation reason, and approving compliance officer. Supports FATF, AML, and SRA regulatory obligations. Each intake party requiring due diligence generates one or more KYC screening records.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`letter_of_engagement` (
    `letter_of_engagement_id` BIGINT COMMENT 'Unique identifier for the Letter of Engagement. Primary key for the LOE master record.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: The LOE type must align with the contract agreement_type to ensure correct billing codes, approval workflows, and compliance requirements are applied. Legal operations teams classify LOEs by agreement',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: LOE execution requires a completed risk assessment to have cleared the engagement. Regulatory audit trails require direct traceability from the executed LOE to the specific risk assessment that approv',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: LOEs must reference applicable compliance policies (data protection, conflicts, confidentiality, client acceptance) to ensure engagement terms comply with firm governance. Real process: policy-complia',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: LOEs involving personal data processing must link to ROPA entries for GDPR Article 30 compliance and lawful basis documentation. Real process: privacy impact assessment at engagement inception.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Letter of engagement must link to its executed document version for signature verification, version control, matter opening authorization, and regulatory compliance. Critical for engagement terms enfo',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: An LOE defines the scope of legal services to be provided; linking to the specific legal service enables service-level engagement tracking, compliance with service-specific terms, and billing model va',
    `matter_id` BIGINT COMMENT 'Reference to the matter record created in Elite 3E upon LOE acceptance. Nullable until the matter is opened. Represents the handoff from intake domain to matter domain.',
    `outside_counsel_guideline_id` BIGINT COMMENT 'Reference to the clients Outside Counsel Guidelines that govern billing practices, staffing, and service delivery standards for this engagement. Nullable if client has no formal OCG.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: LOEs reference pricing models to define billing terms, rate structures, and payment terms before matter opening. Essential for client billing setup and engagement letter generation. Ensures consistenc',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.profile. Business justification: The LOE is the primary client engagement contract and must be directly traceable to the client profile for billing configuration, KYC status verification at execution, and matter opening. Legal-servic',
    `prospect_id` BIGINT COMMENT 'Reference to the prospective client for whom this Letter of Engagement is issued. Links to the client domain prospect or client_profile entity.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to service.rate_card. Business justification: The LOE specifies agreed fee rates; linking to the applicable rate card ensures billing consistency, enables rate card compliance auditing, and supports outside counsel guideline adherence tracking.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: LOEs contain risk-relevant contractual terms (liability caps, indemnity clauses, scope limitations, fee arrangements) that trigger risk register entries for professional indemnity exposure tracking, i',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Letters of engagement must satisfy specific regulatory obligations (SRA Code of Conduct, GDPR consent, AML Regulations). Linking LOE to the regulatory obligation it fulfils is a standard compliance au',
    `request_id` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — LOE is the output artifact of a successful intake request. Links the formal agreement back to the originating workflow.',
    `rfp_submission_id` BIGINT COMMENT 'Reference to the originating Request for Proposal that led to this Letter of Engagement. Nullable if the engagement did not originate from a formal RFP process.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: The LOE signatory must be a verified client contact with tracked authority level (signatory_authority_level on client_contact). client_signatory_name/email/title are denormalized representations of th',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: LOEs incorporate SLA commitments; linking to the governing SLA template ensures correct service levels are embedded in the engagement and enables SLA breach tracking from engagement inception.',
    `superseded_by_loe_letter_of_engagement_id` BIGINT COMMENT 'Reference to the newer Letter of Engagement that supersedes this one. Nullable if this LOE is current or was not superseded. Used to track LOE version history.',
    `template_id` BIGINT COMMENT 'Foreign key linking to contract.template. Business justification: LOEs are generated from contract templates. Linking LOE to the template used supports document generation audit, template usage tracking, and ensures LOE version aligns with the approved template — a ',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.tier. Business justification: Client tier determines service scope and pricing terms in the LOE; this link enables tier-based LOE reporting, compliance checks, and ensures the correct service tier terms are applied in the engageme',
    `acceptance_date` DATE COMMENT 'Date on which the client formally accepted and signed the Letter of Engagement. Nullable until acceptance occurs. Triggers handoff to matter domain for matter opening in Elite 3E.',
    `acceptance_deadline_date` DATE COMMENT 'Date by which the client must accept and sign the Letter of Engagement. After this date, the LOE may expire or require reissuance.',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices will be issued to the client under this engagement. Defines the billing cycle for Work in Progress (WIP) conversion.. Valid values are `monthly|quarterly|milestone|upon_completion|as_incurred`',
    `conflict_waiver_reference` STRING COMMENT 'Reference to any conflict of interest waiver or ethical wall arrangement documented in the conflict checking system (Intapp Conflicts). Nullable if no conflicts identified.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this Letter of Engagement record was first created in the system. Audit trail for record creation.',
    `data_protection_jurisdiction` STRING COMMENT 'Primary data protection regulatory framework applicable to this engagement. GDPR = EU General Data Protection Regulation; CCPA = California Consumer Privacy Act; DPA UK = UK Data Protection Act; Other = jurisdiction-specific; Not Applicable = no specific data protection requirements.. Valid values are `gdpr|ccpa|dpa_uk|other|not_applicable`',
    `dispute_resolution_method` STRING COMMENT 'Agreed method for resolving disputes arising from the engagement. Litigation = court proceedings; Arbitration = binding arbitration; Mediation = facilitated negotiation; ADR = other alternative dispute resolution.. Valid values are `litigation|arbitration|mediation|adr`',
    `effective_from_date` DATE COMMENT 'Date from which the attorney-client relationship and terms of engagement become binding. Typically the acceptance date or a future date specified in the LOE.',
    `effective_until_date` DATE COMMENT 'Date on which the engagement terms expire or the matter is expected to conclude. Nullable for open-ended engagements.',
    `estimated_fee_amount` DECIMAL(18,2) COMMENT 'Estimated total professional fees for the engagement. For fixed-fee arrangements, this is the agreed amount. For hourly arrangements, this is the estimated range or budget.',
    `firm_signatory_name` STRING COMMENT 'Full name of the law firm partner or authorized representative signing the Letter of Engagement on behalf of the firm.',
    `firm_signatory_title` STRING COMMENT 'Title or role of the firm signatory (e.g., Managing Partner, Equity Partner, Practice Group Leader).',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the client has provided consent for data processing under GDPR or equivalent data protection regulations. True = consent given; False = consent not given. Required for EU/UK clients.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the Letter of Engagement (e.g., State of New York, England and Wales).',
    `issue_date` DATE COMMENT 'Date on which the Letter of Engagement was formally issued to the prospective client. Represents the business event timestamp for LOE issuance.',
    `kyc_aml_completed_flag` BOOLEAN COMMENT 'Indicates whether Know Your Client and Anti-Money Laundering due diligence has been completed and cleared for this engagement. True = completed and cleared; False = pending or not completed. Required before LOE can be issued.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this Letter of Engagement record was last updated. Audit trail for record modification.',
    `loe_fee_arrangement` BIGINT COMMENT 'FK to intake.fee_arrangement.fee_arrangement_id — The LOE incorporates the agreed fee arrangement. Essential for ensuring commercial terms are properly documented.',
    `loe_number` STRING COMMENT 'Business-facing unique identifier for the Letter of Engagement, typically formatted as LOE-YYYYNNNNNN. Used for external reference and client communication.. Valid values are `^LOE-[0-9]{6,10}$`',
    `loe_status` STRING COMMENT 'Current lifecycle status of the Letter of Engagement. Draft = under preparation; Issued = sent to client; Accepted = client signed; Declined = client rejected; Superseded = replaced by newer version; Withdrawn = firm retracted; Expired = acceptance deadline passed. [ENUM-REF-CANDIDATE: draft|issued|accepted|declined|superseded|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `loe_type` STRING COMMENT 'Classification of the Letter of Engagement purpose. New Matter = initial engagement; Additional Scope = expansion of existing matter; Amendment = modification of terms; Renewal = extension of existing engagement.. Valid values are `new_matter|additional_scope|amendment|renewal`',
    `loe_version` STRING COMMENT 'Version number of this Letter of Engagement. Increments when the LOE is revised or reissued. Version 1 is the initial issuance.',
    `lpp_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the client has acknowledged and agreed to the terms regarding Legal Professional Privilege and attorney-client confidentiality. True = acknowledged; False = not acknowledged.',
    `matter_type` STRING COMMENT 'Primary practice area or legal service category for this engagement. Used for matter classification and resource allocation planning. [ENUM-REF-CANDIDATE: litigation|corporate_transaction|ip_portfolio|regulatory_compliance|employment|real_estate|tax|bankruptcy|other — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, or internal comments regarding this Letter of Engagement. Used for context that does not fit structured fields.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due. Standard terms are 30, 60, or 90 days.',
    `retainer_amount` DECIMAL(18,2) COMMENT 'Initial retainer or advance payment required from the client. Nullable if no retainer is required. May be held in Interest on Lawyers Trust Accounts (IOLTA).',
    `scope_of_services` STRING COMMENT 'Detailed description of the legal services to be provided under this engagement. Defines the boundaries of the attorney-client relationship and the work to be performed.',
    CONSTRAINT pk_letter_of_engagement PRIMARY KEY(`letter_of_engagement_id`)
) COMMENT 'Master record representing the Letter of Engagement (LOE) issued to a prospective client formalizing the attorney-client relationship, scope of services, fee arrangement, and terms of engagement. Tracks LOE version, issue date, acceptance date, signatory details, governing law, jurisdiction, LPP acknowledgment, data protection consent (GDPR/DPA), conflict waiver references, and execution status (draft, issued, accepted, declined, superseded). The LOE execution event triggers the handoff from the intake domain to the matter domain for matter opening in Elite 3E. Owned by the intake domain as the pre-matter commercial instrument.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`matter_opening_request` (
    `matter_opening_request_id` BIGINT COMMENT 'Unique identifier for the matter opening request. Primary key for this transactional record representing the formal request to open a new matter in Elite 3E following successful conflict clearance and Letter of Engagement (LOE) execution.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: Matter opening requests with requires_trust_account=true result in a trust account being opened. Linking MOR to the resulting trust account supports matter lifecycle tracking, confirms trust account s',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: AML/KYC program completion is a mandatory gate for matter opening in legal services. Linking matter_opening_request to the governing AML/KYC program enables compliance-driven matter opening approval a',
    `check_id` BIGINT COMMENT 'Reference to the conflict check record that was successfully cleared prior to this matter opening request. Links to Intapp Conflicts system clearance record.',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: Matter opening requires registration of data processing activities under GDPR Article 30. Linking matter_opening_request to the data privacy register entry governing the matters data processing suppo',
    `delivery_model_id` BIGINT COMMENT 'Foreign key linking to service.delivery_model. Business justification: Delivery model (e.g., secondment, managed service, traditional) is selected at matter opening and drives staffing, resourcing, and cost structure decisions. Legal operations experts select delivery mo',
    `matter_id` BIGINT COMMENT 'The system-generated matter identifier assigned by Elite 3E upon matter creation. Nullable until matter is opened. Used for cross-system reconciliation.',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Matter opening requests are generated when CRM opportunities are won. This links the matter opening to the CRM opportunity, enabling tracking of which opportunities resulted in opened matters. Standar',
    `fee_arrangement_id` BIGINT COMMENT 'Reference to the billing arrangement negotiated for this matter. May reference Alternative Fee Arrangement (AFA), hourly billing, fixed fee, contingency, or blended rate structure.',
    `indemnity_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_policy. Business justification: Matter opening in high-risk practice areas requires confirmation of professional indemnity coverage. Legal firms gate matter opening on indemnity policy coverage verification — a standard risk managem',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Matter opening requests require linking to authorization documents (approved engagement letters, conflict clearance memos, partner approval emails, client authorization) for matter opening approval wo',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Matter opening requires specifying the legal service being opened; fundamental to matter classification, billing setup, UTBMS coding, and resource assignment. Legal operations experts consider this a ',
    `letter_of_engagement_id` BIGINT COMMENT 'Reference to the executed Letter of Engagement (LOE) that authorizes the opening of this matter. The LOE defines scope, terms, and fee arrangements.',
    `lpm_template_id` BIGINT COMMENT 'Foreign key linking to service.lpm_template. Business justification: LPM templates define the project management framework for the matter; selecting at opening enables budget, milestone, and phase tracking from day one, supporting legal project management and AFAs.',
    `matter_risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.matter_risk_profile. Business justification: Matter risk profile creation is a direct output of the matter opening request process. Risk governance requires linking the opening request to its matter risk profile for pipeline risk reporting and a',
    `outside_counsel_guideline_id` BIGINT COMMENT 'Foreign key linking to client.outside_counsel_guideline. Business justification: Matter opening must apply the clients specific OCG version to configure billing rates, UTBMS coding, staffing restrictions, and invoice delivery. matter_opening_request has requires_outside_counsel_g',
    `package_id` BIGINT COMMENT 'Foreign key linking to service.package. Business justification: If the matter is opened under a service package, this link enables package utilization tracking, bundled billing, and package performance analytics across the matter lifecycle.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Matter opening requests must be approved against the firms governing compliance policies (conflicts, AML, data protection). This link enables policy-driven approval gate workflows and compliance repo',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Matter opening must reference the practice area for routing, staffing, billing setup, and UTBMS task code assignment. The existing practice_group_code is a denormalized string; a proper FK to practi',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Matter opening requests specify pricing model for billing system configuration, rate card assignment, and invoice generation setup. Critical for transitioning from intake to active matter with correct',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom the matter is being opened. Links to the client master record in the client domain.',
    `prospect_id` BIGINT COMMENT 'Reference to the prospect record in the CRM pipeline (Microsoft Dynamics 365) from which this matter opening request originated. Nullable for existing clients.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to service.rate_card. Business justification: Rate card selection at matter opening determines billing rates for the matter; this link enables rate card compliance, billing setup automation, and outside counsel guideline adherence verification.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Matter opening is a formal risk gate in legal operations — a risk register entry is created or referenced at approval. Risk teams need direct linkage from the matter opening request to the risk regist',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Matter opening must verify regulatory obligations applicable to matter type, jurisdiction, and practice area for compliance risk management. Real process: matter-level regulatory compliance check.',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.intake_request. Business justification: Matter opening requests are the final step in the intake workflow, generated from intake requests. This links the matter opening to the originating intake request, providing end-to-end traceability fr',
    `retainer_agreement_id` BIGINT COMMENT 'Foreign key linking to trust.retainer_agreement. Business justification: Matter opening requests establish retainer terms that are formalized in a trust retainer_agreement. Linking MOR to the resulting retainer_agreement supports matter onboarding workflows, confirms retai',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to intake.rfp_submission. Business justification: Matter opening requests may originate from RFP wins. This links the matter opening to the RFP submission for traceability, enabling tracking of which RFP submissions resulted in opened matters. Standa',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: SLA template governs service commitments for the matter being opened; linking ensures correct SLA terms are applied at matter creation and enables SLA compliance tracking from matter inception.',
    `template_id` BIGINT COMMENT 'Foreign key linking to contract.template. Business justification: Matter opening requests specify which contract template should be used for the engagement agreement. Linking matter_opening_request to contract.template supports standardized engagement setup, templat',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the matter opening request was approved by the responsible partner or practice group leader. Nullable if not yet approved.',
    `billing_frequency` STRING COMMENT 'Agreed billing frequency for the matter. Values: monthly (standard monthly billing), quarterly (quarterly invoicing), milestone (bill upon completion of defined milestones), completion (single invoice at matter close), retainer (advance retainer with periodic true-up), on_demand (ad-hoc billing as requested).. Valid values are `monthly|quarterly|milestone|completion|retainer|on_demand`',
    `confidentiality_level` STRING COMMENT 'Classification of the matters confidentiality and sensitivity. Values: standard (normal client confidentiality), high (elevated confidentiality with restricted access), critical (highly sensitive requiring ethical walls and strict access controls). Used to enforce information barriers and Legal Professional Privilege (LPP).. Valid values are `standard|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the matter opening request record was first created in the system. Audit trail for record creation.',
    `department_code` STRING COMMENT 'Code representing the department or cost center to which the matter will be allocated for financial reporting and profitability analysis.',
    `estimated_disbursement_amount` DECIMAL(18,2) COMMENT 'Estimated total disbursements (out-of-pocket expenses) for the matter, as projected at the time of opening request. Includes court fees, filing fees, expert witness costs, travel, etc.',
    `estimated_duration_months` STRING COMMENT 'Estimated duration of the matter in months, as projected at the time of opening request. Used for resource planning and Legal Project Management (LPM).',
    `estimated_fee_amount` DECIMAL(18,2) COMMENT 'Estimated total professional fees for the matter, as projected at the time of opening request. Used for budgeting and revenue forecasting.',
    `ethical_wall_required` BOOLEAN COMMENT 'Boolean flag indicating whether an ethical wall (information barrier) must be established for this matter to prevent conflicts of interest. True if ethical wall is required per conflict check results.',
    `jurisdiction_code` STRING COMMENT 'Primary legal jurisdiction governing the matter (e.g., US-NY, GB-ENG, EU, HK). Used for regulatory compliance, ethical rules, and court filing requirements.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the matter opening request record was last updated. Audit trail for record modification.',
    `ledes_billing_required` BOOLEAN COMMENT 'Boolean flag indicating whether invoices for this matter must be submitted in Legal Electronic Data Exchange Standard (LEDES) format for electronic billing. True if LEDES submission is required by the client.',
    `matter_description` STRING COMMENT 'Detailed description of the matter scope, legal issues, and engagement objectives. Provides context for matter administration and knowledge management.',
    `matter_name` STRING COMMENT 'Descriptive name for the matter. Typically includes client name, transaction type, and brief description (e.g., Acme Corp - Series B Financing or Smith v. Jones - Employment Dispute).',
    `matter_opened_timestamp` TIMESTAMP COMMENT 'Date and time when the matter was successfully created in Elite 3E following approval. Marks the completion of the intake workflow and handoff to the matter domain.',
    `matter_type_code` STRING COMMENT 'Standardized code classifying the type of legal matter (e.g., M&A transaction, patent prosecution, commercial litigation, regulatory compliance advisory). Aligns with Uniform Task-Based Management System (UTBMS) phase codes where applicable.',
    `office_code` STRING COMMENT 'Three-letter code representing the primary office location responsible for the matter (e.g., NYC, LON, SFO, HKG). Used for revenue allocation and conflict of interest management.. Valid values are `^[A-Z]{3}$`',
    `practice_group_code` STRING COMMENT 'Code representing the primary practice group responsible for the matter. Values: CORP (Corporate), LIT (Litigation), IP (Intellectual Property), EMP (Employment), REG (Regulatory), RE (Real Estate), TAX (Tax), BANK (Banking & Finance), MA (Mergers & Acquisitions), ESG (Environmental Social Governance). [ENUM-REF-CANDIDATE: CORP|LIT|IP|EMP|REG|RE|TAX|BANK|MA|ESG — 10 candidates stripped; promote to reference product]',
    `proposed_matter_number` STRING COMMENT 'The proposed matter number to be assigned in Elite 3E upon approval. Follows firm matter numbering convention. May be system-generated or manually specified based on client requirements.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver for rejecting the matter opening request. Nullable if not rejected.',
    `rejection_timestamp` TIMESTAMP COMMENT 'Date and time when the matter opening request was rejected. Nullable if not rejected.',
    `request_status` STRING COMMENT 'Current lifecycle status of the matter opening request. Values: draft (being prepared), submitted (awaiting review), pending_approval (under partner review), approved (authorized to open), rejected (denied), opened (matter created in Elite 3E), cancelled (request withdrawn). [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|opened|cancelled — 7 candidates stripped; promote to reference product]',
    `requires_outside_counsel_guidelines` BOOLEAN COMMENT 'Boolean flag indicating whether the client has imposed Outside Counsel Guidelines (OCG) that must be followed for billing, staffing, and matter administration. True if OCG compliance is mandatory.',
    `requires_trust_account` BOOLEAN COMMENT 'Boolean flag indicating whether this matter requires a client trust account (IOLTA - Interest on Lawyers Trust Accounts) for holding client funds. True if trust accounting is required per engagement terms or jurisdictional rules.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the matter opening request was formally submitted for approval. Marks the start of the approval workflow.',
    `utbms_coding_required` BOOLEAN COMMENT 'Boolean flag indicating whether time entries and invoices for this matter must include Uniform Task-Based Management System (UTBMS) task and activity codes. True if UTBMS coding is required by the client.',
    CONSTRAINT pk_matter_opening_request PRIMARY KEY(`matter_opening_request_id`)
) COMMENT 'Transactional record representing the formal request to open a new matter in Elite 3E following successful conflict clearance and LOE execution. Captures requested matter name, client reference, practice group, responsible partner, billing attorney, originating attorney, office, matter type, proposed matter number, billing arrangement reference, and submission status (pending, approved, rejected, opened). Serves as the handoff record between the intake domain and the matter domain. Triggers matter creation in Elite 3E and closes the intake workflow lifecycle.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`origination_credit` (
    `origination_credit_id` BIGINT COMMENT 'Unique identifier for the origination credit record. Primary key for this entity.',
    `check_id` BIGINT COMMENT 'Reference to the conflict check record performed during intake to ensure ethical compliance. Links to Intapp Conflicts system.',
    `fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.fee_arrangement. Business justification: Origination credits track business development value tied to specific fee arrangements. Linking credits to billing fee arrangements enables accurate origination compensation calculations based on actu',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Origination credit is tied to the specific legal service that generated the revenue; this enables service-level origination analytics for partner compensation, strategic planning, and BD investment de',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Origination credits are finalized when the LOE is executed. This links the credit to the executed LOE. The existing loe_execution_date can be retrieved from the letter_of_engagement table via JOIN, el',
    `matter_id` BIGINT COMMENT 'Reference to the matter for which this origination credit is allocated. Links to the matter opened in Elite 3E following successful intake.',
    `engagement_opportunity_id` BIGINT COMMENT 'FK to intake.engagement_opportunity.engagement_opportunity_id — Origination credits are allocated per engagement opportunity. Required for partner compensation attribution.',
    `pitch_id` BIGINT COMMENT 'Foreign key linking to intake.pitch. Business justification: Origination credits may be allocated based on pitch participation. This links the credit to the pitch, enabling tracking of which pitches generated origination credits. The existing pitch_date can be ',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Origination credit is allocated by practice area for partner compensation reporting; this FK enables accurate practice-area-level credit reporting and compensation calculations. The existing credited',
    `primary_origination_engagement_opportunity_id` BIGINT COMMENT 'Reference to the engagement scope record established during intake. Links to the Letter of Engagement (LOE) and scope definition.',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom this engagement was originated. Links to the client profile in Elite 3E.',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.intake_request. Business justification: Origination credits are allocated based on intake requests. This links the credit to the originating intake request for traceability, enabling tracking of which intake requests generated origination c',
    `rfp_submission_id` BIGINT COMMENT 'Reference to the Request for Proposal (RFP) record if this engagement originated from a competitive bid process. Links to the RFP tracking system in Microsoft Dynamics 365 CRM. Null if not applicable.',
    `allocation_date` DATE COMMENT 'Date on which the origination credit was initially allocated. Typically coincides with engagement acceptance or Letter of Engagement (LOE) execution date.',
    `allocation_status` STRING COMMENT 'Current approval status of the origination credit allocation. Draft indicates initial entry; pending approval indicates submission for partner review; approved indicates final acceptance; rejected indicates non-acceptance requiring revision; revised indicates updated allocation; locked indicates finalized allocation that cannot be changed without special authorization.. Valid values are `draft|pending_approval|approved|rejected|revised|locked`',
    `approval_date` DATE COMMENT 'Date on which the origination credit allocation was formally approved by the managing partner or compensation committee. Null if not yet approved.',
    `business_development_notes` STRING COMMENT 'Free-text notes capturing the business development context, relationship history, competitive positioning, and strategic importance of this origination. Used for internal knowledge management and future business development planning.',
    `compensation_year` STRING COMMENT 'Fiscal or calendar year in which this origination credit is recognized for partner compensation purposes. Typically the year of engagement acceptance or Letter of Engagement (LOE) execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this origination credit record was first created in the system. Audit trail for record creation.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary value of origination credit allocated to this timekeeper. May be calculated as a percentage of expected engagement value or Alternative Fee Arrangement (AFA) amount. Denominated in the firms base currency.',
    `credit_intake` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — Origination credits are allocated at the point of intake. Required for partner compensation attribution.',
    `credit_percentage` DECIMAL(18,2) COMMENT 'Percentage of origination credit allocated to this timekeeper for this engagement. Multiple timekeepers may share credit with percentages summing to 100% across all credit records for the same engagement. Used in partner compensation calculations including Profit Per Equity Partner (PEP) and Revenue Per Equity Partner (RPE).',
    `credit_type` STRING COMMENT 'Type of origination credit being allocated. Originating credit recognizes the attorney who brought in the client or matter; responsible credit recognizes the attorney managing the relationship; billing credit recognizes the primary billing attorney; cross-selling credit recognizes attorneys who expanded services to existing clients; referral credit recognizes internal or external referrals; relationship credit recognizes ongoing client stewardship.. Valid values are `originating|responsible|billing|cross_selling|referral|relationship`',
    `credited_office` STRING COMMENT 'Office location of the credited timekeeper at the time of origination. Used for office-level revenue attribution and geographic performance analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit amount. Typically the firms base currency but may vary for international engagements.. Valid values are `^[A-Z]{3}$`',
    `expected_engagement_value` DECIMAL(18,2) COMMENT 'Estimated total revenue expected from this engagement at the time of origination. Used as the basis for calculating origination credit amounts. May be based on Alternative Fee Arrangement (AFA) fixed fees, estimated hours, or historical matter value.',
    `fee_arrangement_type` STRING COMMENT 'Type of Alternative Fee Arrangement (AFA) or billing structure agreed for this engagement. Hourly indicates standard time-based billing; fixed fee indicates a predetermined total; contingency indicates payment contingent on outcome; blended indicates mixed hourly rates; capped indicates hourly with a maximum; retainer indicates ongoing monthly fee; success fee indicates bonus upon achievement; hybrid indicates combination of multiple structures. [ENUM-REF-CANDIDATE: hourly|fixed_fee|contingency|blended|capped|retainer|success_fee|hybrid — 8 candidates stripped; promote to reference product]',
    `industry_sector` STRING COMMENT 'Industry sector of the client for whom this engagement was originated. Examples include financial services, healthcare, technology, energy, manufacturing, retail, etc. Used for industry-focused business development and market analysis.',
    `intake_request` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — Origination credits are allocated at the point of intake for a specific new matter. Links compensation attribution to the intake event.',
    `is_cross_border` BOOLEAN COMMENT 'Boolean flag indicating whether this engagement involves cross-border legal work spanning multiple jurisdictions. Cross-border matters may warrant additional origination credit due to complexity and coordination requirements.',
    `is_strategic_client` BOOLEAN COMMENT 'Boolean flag indicating whether this engagement is with a client designated as strategically important to the firm. Strategic clients may receive enhanced origination credit recognition or special compensation treatment.',
    `lock_date` DATE COMMENT 'Date on which this origination credit record was locked for final compensation calculations. Once locked, changes require special authorization from the compensation committee. Null if not yet locked.',
    `matter_type` STRING COMMENT 'High-level classification of the matter type for this engagement. Examples include corporate transaction, litigation, intellectual property prosecution, regulatory compliance, employment advisory, real estate, tax planning, etc. Used for practice area revenue attribution.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this origination credit record was last modified. Audit trail for record updates.',
    `origination_source` STRING COMMENT 'Source or channel through which this engagement was originated. New client indicates first engagement with a new client; existing client new matter indicates additional work for current client; cross-sell indicates expansion of services; referral external indicates referral from outside the firm; referral internal indicates referral from another practice group; Request for Proposal (RFP) response indicates competitive bid; direct approach indicates proactive business development; marketing event indicates conference or seminar lead; alumni network indicates former firm member referral. [ENUM-REF-CANDIDATE: new_client|existing_client_new_matter|cross_sell|referral_external|referral_internal|rfp_response|direct_approach|marketing_event|alumni_network — 9 candidates stripped; promote to reference product]',
    `primary_jurisdiction` STRING COMMENT 'Primary legal jurisdiction or country in which this engagement is focused. Used for geographic revenue attribution and regulatory compliance reporting.',
    `revision_number` STRING COMMENT 'Sequential revision number tracking changes to this origination credit allocation. Incremented each time the allocation is revised and resubmitted for approval. Initial allocation is revision 1.',
    `revision_reason` STRING COMMENT 'Free-text explanation for why this origination credit allocation was revised. Null if this is the initial allocation (revision 1).',
    CONSTRAINT pk_origination_credit PRIMARY KEY(`origination_credit_id`)
) COMMENT 'Master record capturing the business origination and relationship credit allocation for a new engagement at the point of intake. Records which attorneys (originating, responsible, billing, cross-selling) receive credit for bringing in the client or matter, including credit type, percentage split, credited timekeeper, practice group, office, and approval status. Established during intake as the commercial attribution record and feeds partner compensation calculations (PPP/PEP) in Elite 3E. Distinct from billing-domain revenue allocation — this captures the agreed credit split at engagement inception before any billing activity occurs.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`referral_source` (
    `referral_source_id` BIGINT COMMENT 'Unique identifier for the referral source record. Primary key.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: When the referral source is a corporate entity (e.g., a bank, accountancy firm, or existing client organisation), linking to client.organisation enables referral network analysis, panel relationship t',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Referral sources specialize in specific practice areas; this FK enables practice-area-level referral source performance reporting and BD targeting. The existing practice_area_focus plain string is a',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.profile. Business justification: Referral sources are frequently existing clients whose referrals generate origination credit and relationship management obligations. Linking referral_source to client.profile enables client referral ',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to intake.prospect. Business justification: Referral sources may be linked to specific prospects they referred. This links the referral source to the prospect for tracking referral effectiveness. This is an optional FK (nullable) as referral so',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Referral fee arrangements are subject to specific regulatory obligations (SRA Referral Fee Regulations, LASPO). Linking referral sources to the governing regulatory obligation supports regulatory comp',
    `acknowledgment_protocol` STRING COMMENT 'Description of the standard acknowledgment or thank-you protocol for referrals from this source (e.g., partner phone call, gift, event invitation). Used to maintain relationship quality.',
    `contact_email` STRING COMMENT 'Primary email address for the referral source contact. Used for relationship management and acknowledgment communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person at the referral source organization or the individual referrer.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the referral source contact.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this referral source record was first created in the system. Audit trail field.',
    `dynamics_contact_guid` STRING COMMENT 'Globally unique identifier linking this referral source to the corresponding contact record in Microsoft Dynamics 365 CRM. Used for system integration and data synchronization.. Valid values are `^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$`',
    `first_referral_date` DATE COMMENT 'Date when the first engagement opportunity was referred by this source. Marks the beginning of the referral relationship.',
    `industry_sector_focus` STRING COMMENT 'Primary industry sector or vertical associated with referrals from this source (e.g., Technology, Financial Services, Healthcare). Used for market segmentation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this referral source record is currently active and available for use in business processes. True if active; False if logically deleted or archived.',
    `jurisdiction` STRING COMMENT 'Primary geographic jurisdiction or country associated with the referral source. Three-letter ISO country code (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `last_referral_date` DATE COMMENT 'Date of the most recent engagement opportunity referred by this source. Used to identify active vs dormant referral relationships.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this referral source record was last modified. Audit trail field.',
    `notes` STRING COMMENT 'Free-text notes capturing relationship history, preferences, special considerations, or other contextual information about the referral source.',
    `referral_agreement_date` DATE COMMENT 'Date when the referral agreement was executed. Null if no formal agreement exists.',
    `referral_agreement_executed_flag` BOOLEAN COMMENT 'Indicates whether a formal referral agreement or memorandum of understanding has been executed with this source. True if agreement is in place; False otherwise.',
    `referral_agreement_expiry_date` DATE COMMENT 'Date when the referral agreement expires or requires renewal. Null for evergreen agreements or when no formal agreement exists.',
    `referral_fee_arrangement` STRING COMMENT 'Type of fee arrangement or compensation structure associated with referrals from this source. Values: none (no fee), percentage (percentage of fees), flat_fee (fixed amount per referral), reciprocal (mutual referral agreement).. Valid values are `none|percentage|flat_fee|reciprocal`',
    `referral_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of fees paid to the referral source when referral_fee_arrangement is percentage-based. Expressed as a decimal (e.g., 10.00 for 10%).',
    `source_category` STRING COMMENT 'High-level categorization of the referral source for segmentation and reporting. Values: individual (person-based referral), organization (company or institution referral), digital_channel (website, online directory, social media), event (conference, seminar, networking event), publication (legal publication, directory listing).. Valid values are `individual|organization|digital_channel|event|publication`',
    `source_name` STRING COMMENT 'The full name or title of the referral source entity (individual, organization, or channel).',
    `source_number` STRING COMMENT 'Business identifier for the referral source, typically assigned by the business development or intake system. Format: RS-NNNNNN.. Valid values are `^RS-[0-9]{6,10}$`',
    `source_quality_rating` STRING COMMENT 'Qualitative assessment of the referral source based on conversion rate, matter value, and client quality. Used for relationship prioritization and BD resource allocation.. Valid values are `excellent|good|fair|poor|unrated`',
    `source_status` STRING COMMENT 'Current lifecycle status of the referral source. Active sources are currently generating referrals; inactive sources are no longer producing leads; suspended sources are temporarily paused; archived sources are historical records.. Valid values are `active|inactive|suspended|archived`',
    `source_tier` STRING COMMENT 'Strategic tier classification of the referral source for relationship management prioritization. Tier 1 sources are highest value and receive most attention.. Valid values are `tier_1|tier_2|tier_3|unclassified`',
    `source_type` STRING COMMENT 'Classification of the referral source indicating the channel or relationship through which the opportunity was referred. Values: existing_client (referral from current client), attorney_referral (referral from external attorney or law firm), alumni (referral from firm alumni), intermediary (referral from broker, consultant, or other intermediary), directory_listing (lead from legal directory such as Chambers, Legal 500), conference (lead from industry conference or event).. Valid values are `existing_client|attorney_referral|alumni|intermediary|directory_listing|conference`',
    `successful_referrals_count` STRING COMMENT 'Count of referred opportunities that resulted in executed Letter of Engagement (LOE) and opened matters. Measures referral source conversion quality.',
    `total_referrals_count` STRING COMMENT 'Cumulative count of engagement opportunities referred by this source since inception. Used for referral source performance tracking.',
    CONSTRAINT pk_referral_source PRIMARY KEY(`referral_source_id`)
) COMMENT 'Master reference record identifying the source through which a prospect or new business opportunity was referred to the firm. Captures referral source type (existing client, attorney referral, alumni, intermediary, directory listing, conference, website, panel appointment), referral source name, relationship owner, referral date, and associated engagement opportunity. Supports BD attribution reporting, referral network management, and client relationship analytics. Owned by the intake domain as the commercial origination attribution record.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_rfp_prospect_id` FOREIGN KEY (`rfp_prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_pitch_id` FOREIGN KEY (`pitch_id`) REFERENCES `legal_ecm`.`intake`.`pitch`(`pitch_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ADD CONSTRAINT `fk_intake_conflict_search_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_intake_party_id` FOREIGN KEY (`intake_party_id`) REFERENCES `legal_ecm`.`intake`.`intake_party`(`intake_party_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_superseded_by_loe_letter_of_engagement_id` FOREIGN KEY (`superseded_by_loe_letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_pitch_id` FOREIGN KEY (`pitch_id`) REFERENCES `legal_ecm`.`intake`.`pitch`(`pitch_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_primary_origination_engagement_opportunity_id` FOREIGN KEY (`primary_origination_engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`intake` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `legal_ecm`.`intake` SET TAGS ('dbx_domain' = 'intake');
ALTER TABLE `legal_ecm`.`intake`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`prospect` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|flagged|escalated');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `competitor_firms` SET TAGS ('dbx_business_glossary_term' = 'Competitor Law Firms');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `competitor_firms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|conflict_identified|waived|declined');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `conflicts_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Conflicts System Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `converted_to_client_date` SET TAGS ('dbx_business_glossary_term' = 'Converted to Client Date');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `crm_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `engagement_scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Summary');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `engagement_scope_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `estimated_matter_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Matter Value');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `estimated_matter_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `estimated_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value Currency Code');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `estimated_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `expected_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Decision Date');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Primary Jurisdiction');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Status');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed|waived');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prospect Notes');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `pitch_date` SET TAGS ('dbx_business_glossary_term' = 'Pitch Presentation Date');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `proposal_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Submitted Date');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `proposed_fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Proposed Fee Arrangement Type (Alternative Fee Arrangement - AFA)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Name');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_business_glossary_term' = 'Prospect Type');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_value_regex' = 'corporate|government|individual|non_profit|partnership|trust');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `referral_source_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Type');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `referral_source_type` SET TAGS ('dbx_value_regex' = 'client|attorney|professional_advisor|business_contact|alumni|other');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `referring_party_name` SET TAGS ('dbx_business_glossary_term' = 'Referring Party Name');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `referring_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `rfp_received_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Received Date');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `rfp_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Response Due Date');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Prospect Source Type');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Submission ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organisation ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Matter ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `competitive_firms` SET TAGS ('dbx_business_glossary_term' = 'Competitive Firms');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `competitive_firms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `conflict_check_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Completed Date');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|conflict_identified|waived');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'awarded|declined|no_decision|withdrawn_by_client');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `decision_received_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Received Date');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `decline_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Notes');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `estimated_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value Amount');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `estimated_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `estimated_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value Currency');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `estimated_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Type');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'hourly|fixed_fee|contingency|capped_fee|blended_rate|success_fee');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `is_existing_client` SET TAGS ('dbx_business_glossary_term' = 'Is Existing Client');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `proposal_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Submitted Date');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'RFP Received Date');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `requires_panel_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Panel Approval');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `response_deadline_time` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Time');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `rfp_description` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Description');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `rfp_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Reference Number');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `rfp_title` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Title');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'received|under_review|declined|responded|withdrawn|awarded');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `win_probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `legal_ecm`.`intake`.`pitch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`pitch` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_id` SET TAGS ('dbx_business_glossary_term' = 'Pitch Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Pitch Deck Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_proposal_legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `client_attendees` SET TAGS ('dbx_business_glossary_term' = 'Client Attendees');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `client_attendees` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `competing_firms` SET TAGS ('dbx_business_glossary_term' = 'Competing Firms');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `competing_firms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `competitive_context` SET TAGS ('dbx_business_glossary_term' = 'Competitive Context');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `competitive_context` SET TAGS ('dbx_value_regex' = 'sole_pitch|competitive_2_firms|competitive_3_firms|competitive_4plus_firms|unknown');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `competitive_context` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|waived');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Pitch Cost Estimate');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Pitch Duration (Minutes)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `estimated_matter_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Matter Value');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `estimated_matter_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Pitch Location');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `loss_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Code');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Pitch Outcome');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'won|lost|pending|withdrawn|no_decision');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Date');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_date` SET TAGS ('dbx_business_glossary_term' = 'Pitch Date');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_name` SET TAGS ('dbx_business_glossary_term' = 'Pitch Name');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_status` SET TAGS ('dbx_business_glossary_term' = 'Pitch Status');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_type` SET TAGS ('dbx_business_glossary_term' = 'Pitch Type');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_type` SET TAGS ('dbx_value_regex' = 'beauty_parade|credentials_deck|oral_presentation|written_proposal|panel_interview|finalist_presentation');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `preparation_hours` SET TAGS ('dbx_business_glossary_term' = 'Pitch Preparation Hours');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `preparation_hours` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `proposed_fee_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Proposed Fee Arrangement');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `proposed_fee_arrangement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Pitch Reference Number');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Pitch Score');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Pitch Team Size');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `win_loss_notes` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Notes');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `win_loss_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `win_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Win Reason Code');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity ID');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `matter_risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `afa_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Type');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `conflict_check_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Completed Date');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|conflict_identified|waived');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `dynamics_opportunity_guid` SET TAGS ('dbx_business_glossary_term' = 'Microsoft Dynamics 365 Opportunity GUID');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `elite_matter_number` SET TAGS ('dbx_business_glossary_term' = 'Elite Matter Number');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `engagement_scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Summary');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `estimated_matter_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Matter Value');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `estimated_matter_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `expected_matter_open_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Matter Open Date');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `kyc_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Completed Date');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Status');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `loe_executed_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Executed Date');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `matter_opened_in_elite_flag` SET TAGS ('dbx_business_glossary_term' = 'Matter Opened in Elite Flag');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `opportunity_stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `opportunity_stage` SET TAGS ('dbx_value_regex' = 'qualification|proposal|negotiation|closed_won|closed_lost|on_hold');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `pitch_team_notes` SET TAGS ('dbx_business_glossary_term' = 'Pitch Team Notes');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `pitch_team_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `proposal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Due Date');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `proposal_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Submitted Date');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `rfp_received_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Received Date');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `source_campaign` SET TAGS ('dbx_business_glossary_term' = 'Source Campaign');
ALTER TABLE `legal_ecm`.`intake`.`request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`intake`.`request` SET TAGS ('dbx_subdomain' = 'client_onboarding');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Existing Client ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Source Request for Proposal (RFP) ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `adverse_parties` SET TAGS ('dbx_business_glossary_term' = 'Adverse Parties');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `adverse_parties` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Clear|Alert Identified|Escalated|Cleared with Conditions');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Rejected|Conditional Approval');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `conflict_check_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Completed Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Clear|Conflict Identified|Waived|Declined');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `conflict_waiver_obtained` SET TAGS ('dbx_business_glossary_term' = 'Conflict Waiver Obtained');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `estimated_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fee Amount');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `estimated_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `intake_status` SET TAGS ('dbx_business_glossary_term' = 'Intake Status');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Status');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Failed|Waived');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `loe_executed_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Executed Date');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `loe_required` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Required');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `loe_status` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Status');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `loe_status` SET TAGS ('dbx_value_regex' = 'Not Required|Draft|Sent to Client|Executed|Declined');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `matter_description` SET TAGS ('dbx_business_glossary_term' = 'Matter Description');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `matter_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `matter_opened_flag` SET TAGS ('dbx_business_glossary_term' = 'Matter Opened Flag');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `matter_opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Matter Opened Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `office_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_client_name` SET TAGS ('dbx_business_glossary_term' = 'Proposed Client Name');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_client_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Proposed Fee Arrangement Type (Alternative Fee Arrangement - AFA)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_matter_number` SET TAGS ('dbx_business_glossary_term' = 'Proposed Matter Number');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_matter_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}(-[0-9]{3})?$');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `target_matter_open_date` SET TAGS ('dbx_business_glossary_term' = 'Target Matter Open Date');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_business_glossary_term' = 'Urgency Flag');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` SET TAGS ('dbx_subdomain' = 'client_onboarding');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `conflict_search_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Identifier');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request ID');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `alternate_names_searched` SET TAGS ('dbx_business_glossary_term' = 'Alternate Names Searched');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `alternate_names_searched` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `automated_search_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Search Flag');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `database_snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Database Snapshot Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Search Error Message');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `high_risk_hits_count` SET TAGS ('dbx_business_glossary_term' = 'High Risk Hits Count');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `jurisdiction_filter` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Filter');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `low_risk_hits_count` SET TAGS ('dbx_business_glossary_term' = 'Low Risk Hits Count');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `match_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Match Threshold Percentage');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `matter_type_filter` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Filter');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `medium_risk_hits_count` SET TAGS ('dbx_business_glossary_term' = 'Medium Risk Hits Count');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `office_location_code` SET TAGS ('dbx_business_glossary_term' = 'Office Location Code');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `party_name_searched` SET TAGS ('dbx_business_glossary_term' = 'Party Name Searched');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `party_name_searched` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `party_role` SET TAGS ('dbx_business_glossary_term' = 'Party Role');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `party_role` SET TAGS ('dbx_value_regex' = 'prospective_client|adverse_party|related_entity|counterparty|witness|other');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'individual|organization|government_entity');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `results_export_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Results Export Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `results_exported_flag` SET TAGS ('dbx_business_glossary_term' = 'Results Exported Flag');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_algorithm_type` SET TAGS ('dbx_business_glossary_term' = 'Search Algorithm Type');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_algorithm_type` SET TAGS ('dbx_value_regex' = 'exact_match|fuzzy_match|phonetic_match|ai_enhanced');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Search Completed Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Search Date Range End');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Search Date Range Start');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Engine Version');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Search Executed Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_execution_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Search Execution Duration (Seconds)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Notes');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_priority` SET TAGS ('dbx_business_glossary_term' = 'Search Priority');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Reference Number');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_reference_number` SET TAGS ('dbx_value_regex' = '^CS-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Search Retry Count');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_scope` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Scope');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_scope` SET TAGS ('dbx_value_regex' = 'current_matters|all_matters|closed_matters|specific_date_range');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Status');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `search_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|complete|escalated|cancelled|failed');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `searcher_name` SET TAGS ('dbx_business_glossary_term' = 'Searcher Name');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `total_hits_returned` SET TAGS ('dbx_business_glossary_term' = 'Total Hits Returned');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` SET TAGS ('dbx_subdomain' = 'client_onboarding');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `intake_party_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Party Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `adverse_media_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Flag');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|completed|failed|waived');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_country_code` SET TAGS ('dbx_business_glossary_term' = 'Business Country Code');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_state_province` SET TAGS ('dbx_business_glossary_term' = 'Business State or Province');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `conflict_check_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Date');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|cleared|conflict-identified|waived');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `conflict_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `conflict_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Identified Flag');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `conflict_waiver_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Waiver Obtained Flag');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `kyc_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Screening Date');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `kyc_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Screening Status');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `kyc_screening_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|completed|failed|waived');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Party Notes');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Legal Name');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `party_role` SET TAGS ('dbx_business_glossary_term' = 'Party Role');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `party_role` SET TAGS ('dbx_value_regex' = 'client|adverse|related|guarantor|co-counsel|subsidiary');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'pending|screening|cleared|rejected|escalated');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `pep_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Flag');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `sanctions_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Match Flag');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` SET TAGS ('dbx_subdomain' = 'client_onboarding');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `kyc_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Screening ID');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `control_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Control Framework Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake ID');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `adverse_media_hit_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Hit Flag');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional|pending');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `edd_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Due Diligence (EDD) Completion Date');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `edd_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Due Diligence (EDD) Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `jurisdiction_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Risk Level');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `jurisdiction_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `match_count` SET TAGS ('dbx_business_glossary_term' = 'Match Count');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `pep_hit_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Hit Flag');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `re_screening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Screening Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `sanctions_hit_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Hit Flag');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Reference Number');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Screening Cost Amount');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Screening Cost Currency');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Expiry Date');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_outcome` SET TAGS ('dbx_business_glossary_term' = 'Screening Outcome');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_outcome` SET TAGS ('dbx_value_regex' = 'cleared|escalated|rejected|pending_review|requires_edd');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_provider` SET TAGS ('dbx_business_glossary_term' = 'Screening Provider');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|completed|expired|cancelled');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_type` SET TAGS ('dbx_business_glossary_term' = 'Screening Type');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `screening_type` SET TAGS ('dbx_value_regex' = 'kyc|aml|sanctions|pep|adverse_media|credit');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `source_of_funds_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds Verified Flag');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` SET TAGS ('dbx_subdomain' = 'client_onboarding');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Loe Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline (OCG) ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `superseded_by_loe_letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Letter of Engagement (LOE) ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `acceptance_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Deadline Date');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|upon_completion|as_incurred');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `conflict_waiver_reference` SET TAGS ('dbx_business_glossary_term' = 'Conflict Waiver Reference');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `data_protection_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Jurisdiction');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `data_protection_jurisdiction` SET TAGS ('dbx_value_regex' = 'gdpr|ccpa|dpa_uk|other|not_applicable');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method (Alternative Dispute Resolution - ADR)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|adr');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `estimated_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fee Amount');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `estimated_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `firm_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Firm Signatory Name');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `firm_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Firm Signatory Title');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Issue Date');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `kyc_aml_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) and Anti-Money Laundering (AML) Completed Flag');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `loe_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Number');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `loe_number` SET TAGS ('dbx_value_regex' = '^LOE-[0-9]{6,10}$');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `loe_status` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Status');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `loe_type` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Type');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `loe_type` SET TAGS ('dbx_value_regex' = 'new_matter|additional_scope|amendment|renewal');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `loe_version` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Version');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `lpp_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Acknowledgment Flag');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainer Amount');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` SET TAGS ('dbx_subdomain' = 'client_onboarding');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `matter_opening_request_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Opening Request ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Elite 3E Matter ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `lpm_template_id` SET TAGS ('dbx_business_glossary_term' = 'Lpm Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `matter_risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `retainer_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Retainer Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Submission Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|completion|retainer|on_demand');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|high|critical');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `estimated_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Disbursement Amount');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `estimated_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Months)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `estimated_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fee Amount');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `ledes_billing_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Billing Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `matter_description` SET TAGS ('dbx_business_glossary_term' = 'Matter Description');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `matter_name` SET TAGS ('dbx_business_glossary_term' = 'Matter Name');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `matter_opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Matter Opened Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `matter_type_code` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Code');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `office_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `proposed_matter_number` SET TAGS ('dbx_business_glossary_term' = 'Proposed Matter Number');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `proposed_matter_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `rejection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejection Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Matter Opening Request Status');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `requires_outside_counsel_guidelines` SET TAGS ('dbx_business_glossary_term' = 'Requires Outside Counsel Guidelines Flag');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `requires_trust_account` SET TAGS ('dbx_business_glossary_term' = 'Requires Trust Account Flag');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `utbms_coding_required` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Coding Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` SET TAGS ('dbx_subdomain' = 'client_onboarding');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `origination_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Credit Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `pitch_id` SET TAGS ('dbx_business_glossary_term' = 'Pitch Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `primary_origination_engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|revised|locked');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `business_development_notes` SET TAGS ('dbx_business_glossary_term' = 'Business Development Notes');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `business_development_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `compensation_year` SET TAGS ('dbx_business_glossary_term' = 'Compensation Year');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `compensation_year` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `compensation_year` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `credit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Credit Percentage');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'originating|responsible|billing|cross_selling|referral|relationship');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `credited_office` SET TAGS ('dbx_business_glossary_term' = 'Credited Office');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `expected_engagement_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Engagement Value');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `expected_engagement_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Border Engagement Flag');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `is_strategic_client` SET TAGS ('dbx_business_glossary_term' = 'Is Strategic Client Flag');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Lock Date');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `origination_source` SET TAGS ('dbx_business_glossary_term' = 'Origination Source');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `primary_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Primary Jurisdiction');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` SET TAGS ('dbx_subdomain' = 'business_development');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `referral_source_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Source ID');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `acknowledgment_protocol` SET TAGS ('dbx_business_glossary_term' = 'Referral Acknowledgment Protocol');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Contact Email');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Contact Name');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Contact Phone');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `dynamics_contact_guid` SET TAGS ('dbx_business_glossary_term' = 'Microsoft Dynamics 365 Contact GUID (Globally Unique Identifier)');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `dynamics_contact_guid` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `first_referral_date` SET TAGS ('dbx_business_glossary_term' = 'First Referral Date');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `industry_sector_focus` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Industry Sector Focus');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Jurisdiction');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `last_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Last Referral Date');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Notes');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `referral_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Agreement Date');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `referral_agreement_executed_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Agreement Executed Flag');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `referral_agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Agreement Expiry Date');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `referral_fee_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Arrangement');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `referral_fee_arrangement` SET TAGS ('dbx_value_regex' = 'none|percentage|flat_fee|reciprocal');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `referral_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Percentage');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `referral_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_category` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Category');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_category` SET TAGS ('dbx_value_regex' = 'individual|organization|digital_channel|event|publication');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Name');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Number');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_number` SET TAGS ('dbx_value_regex' = '^RS-[0-9]{6,10}$');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Quality Rating');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_quality_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|unrated');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Status');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_tier` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Tier');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|unclassified');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Type');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'existing_client|attorney_referral|alumni|intermediary|directory_listing|conference');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `successful_referrals_count` SET TAGS ('dbx_business_glossary_term' = 'Successful Referrals Count');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `total_referrals_count` SET TAGS ('dbx_business_glossary_term' = 'Total Referrals Count');
