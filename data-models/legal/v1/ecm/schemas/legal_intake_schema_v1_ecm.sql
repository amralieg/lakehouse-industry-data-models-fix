-- Schema for Domain: intake | Business: Legal | Version: v1_ecm
-- Generated on: 2026-05-07 11:59:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`intake` COMMENT 'Manages the end-to-end new business intake and client onboarding pipeline from RFP receipt through LOE execution. Owns prospect qualification, pitch and proposal tracking, engagement scope definition, fee arrangement negotiation (AFA), and handoff to the matter domain upon matter opening. Bridges the CRM pipeline in Microsoft Dynamics 365 with operational matter creation in Elite 3E.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`prospect` (
    `prospect_id` BIGINT COMMENT 'Unique identifier for the prospect record. Primary key for the prospect entity representing a pre-engagement organization or individual in the new business intake pipeline.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Prospects undergo initial AML/KYC screening before conversion to client, governed by the firms AML/KYC program. Real process: pre-client compliance screening in business development.',
    `individual_id` BIGINT COMMENT 'Foreign key linking to client.individual. Business justification: Prospects can be individuals (personal legal services, estate planning, etc.) before becoming formal clients. This FK links individual prospects to the individual master. is_new_attribute=true because',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Prospects in legal services are often organizations before they become formal clients. This FK links corporate prospects to the organisation master. is_new_attribute=true because organisation_id is no',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney credited with originating this prospect opportunity. Used for origination credit and compensation calculations.',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the client record created upon successful prospect conversion. Nullable until the prospect is converted to a client. Links the pre-engagement prospect state to the post-engagement client entity.',
    `prospect_attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney who owns the relationship with this prospect and is responsible for business development and intake progression.',
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
    `practice_area` STRING COMMENT 'The primary legal practice area or service line relevant to the prospective engagement. Used for practice group routing and expertise matching.',
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
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner or senior lawyer assigned as the lead for coordinating the pitch and proposal response.',
    `client_contact_id` BIGINT COMMENT 'Reference to the primary client contact person who issued or is managing the RFP on behalf of the issuing organisation.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: RFP responses must comply with firm policies on risk acceptance, conflicts, and client acceptance before submission. Real process: policy-driven RFP compliance review and approval.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: RFP responses routinely attach or reference firm standard templates, sample deliverables, and precedent forms to demonstrate capability and methodology. Proposal assembly process in legal services dep',
    `organisation_id` BIGINT COMMENT 'Reference to the prospective or existing client organisation that issued this RFP.',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this RFP submission record.',
    `primary_prospect_id` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Every RFP is received from a prospect — this FK is required for pipeline attribution and BD reporting. Without it, RFPs cannot be associated with their originating prospect.',
    `prospect_id` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Every RFP is received from a prospect or existing client. The prospect FK is essential for tracking which prospects are generating RFP activity and for pipeline reporting.',
    `reputational_risk_id` BIGINT COMMENT 'Foreign key linking to risk.reputational_risk. Business justification: RFP responses to high-profile, controversial, or sanctioned clients require reputational risk assessment before submission; the reputational_risk flag must reference the specific RFP for risk committe',
    `matter_id` BIGINT COMMENT 'Reference to the matter record created in Elite 3E if the RFP was awarded and the engagement proceeded to matter opening.',
    `rfp_prospect_id` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Every RFP is received from a prospect or existing client. This is the primary intake trigger and must link to the prospect who issued it. Day-1 operational requirement for pipeline tracking.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user (business development staff or partner) who created this RFP submission record.',
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
    `practice_area` STRING COMMENT 'The primary legal practice area or service line that this RFP pertains to. [ENUM-REF-CANDIDATE: corporate|litigation|intellectual_property|employment|regulatory_compliance|mergers_and_acquisitions|real_estate|tax|banking_and_finance|dispute_resolution|antitrust|environmental|healthcare|technology|energy — promote to reference product]',
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
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner who led the pitch and will serve as the primary relationship owner if the engagement is won.',
    `check_id` BIGINT COMMENT 'Reference to the conflict check record in Intapp Conflicts system performed for this pitch.',
    `letter_of_engagement_id` BIGINT COMMENT 'Reference to the Letter of Engagement (LOE) executed following a successful pitch. Null if pitch was lost or engagement not yet formalized.',
    `matter_id` BIGINT COMMENT 'Reference to the matter opened in Elite 3E following a successful pitch and LOE execution. Null if pitch was lost or matter not yet opened.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified the pitch record.',
    `legal_document_id` BIGINT COMMENT 'Reference to the pitch deck or credentials presentation document stored in the Document Management System (iManage Work or NetDocuments).',
    `pitch_proposal_legal_document_id` BIGINT COMMENT 'Reference to the written proposal document submitted as part of the pitch, stored in the Document Management System.',
    `pitch_rfp` BIGINT COMMENT 'FK to intake.rfp_submission.rfp_submission_id — Pitches are made in response to RFPs — this FK links the response activity to the triggering request. Critical for win/loss analysis.',
    `pitch_rfp_submission` BIGINT COMMENT 'FK to intake.rfp_submission.rfp_submission_id — Pitches are made in response to RFPs. This link is critical for tracking RFP-to-pitch conversion rates and pipeline progression.',
    `pitch_rfp_submission_id` BIGINT COMMENT 'Reference to the RFP submission that triggered this pitch, if applicable. Null for proactive pitches not tied to a formal RFP.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Pitch presentations showcase relevant precedent transactions, sample work product, and comparable engagements to demonstrate firm experience and capability. Business development process in legal servi',
    `profile_id` BIGINT COMMENT 'Reference to the prospective or existing client organization to whom the pitch was delivered.',
    `rfp_submission_id` BIGINT COMMENT 'FK to intake.rfp_submission.rfp_submission_id — Pitches are made in response to RFPs. This is the core pipeline progression link. Without it, cannot trace RFP→pitch→opportunity flow.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created the pitch record, typically a BD professional or partner.',
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
    `practice_area` STRING COMMENT 'Primary practice area or legal service line covered by the pitch (e.g., M&A, Litigation, IP, Employment, Regulatory Compliance). May be a comma-separated list for multi-practice pitches.',
    `preparation_hours` DECIMAL(18,2) COMMENT 'Total non-billable hours invested by the firm in preparing for the pitch, including research, deck creation, rehearsal, and travel. Used for BD cost analysis.',
    `proposed_fee_arrangement` STRING COMMENT 'Type of fee arrangement proposed in the pitch: hourly (standard time-based billing), fixed_fee (flat fee for scope), capped_fee (hourly with upper limit), contingency (success-based), blended_rate (single rate for all timekeepers), afa_other (alternative fee arrangement not otherwise specified), retainer (ongoing monthly/quarterly fee), or success_fee (bonus upon outcome). [ENUM-REF-CANDIDATE: hourly|fixed_fee|capped_fee|contingency|blended_rate|afa_other|retainer|success_fee — 8 candidates stripped; promote to reference product]',
    `reference_number` STRING COMMENT 'Business-facing unique reference number or code assigned to the pitch for tracking and communication purposes.',
    `score` DECIMAL(18,2) COMMENT 'Internal qualitative or quantitative score assigned to the pitch performance by the pitch team or BD leadership, used for continuous improvement. Scale and methodology defined by firm policy.',
    `team_size` STRING COMMENT 'Total number of attorneys and professionals from the firm who participated in the pitch presentation or preparation.',
    `win_loss_notes` STRING COMMENT 'Free-text narrative capturing detailed feedback from the client or internal debrief regarding the pitch outcome, including strengths, weaknesses, and lessons learned.',
    `win_reason_code` STRING COMMENT 'Standardized code or category explaining why the pitch was won, if applicable (e.g., expertise, relationship, fee competitiveness, innovation, diversity). Used for win/loss analysis and BD strategy refinement.',
    CONSTRAINT pk_pitch PRIMARY KEY(`pitch_id`)
) COMMENT 'Master record representing a formal pitch or credentials presentation made to a prospective or existing client in response to an RFP or BD opportunity. Tracks pitch type (beauty parade, credentials deck, oral presentation), pitch date, presenting attorneys, practice areas covered, competitive context, pitch outcome (won, lost, pending, withdrawn), and win/loss reason codes. Linked to the originating RFP submission and the resulting engagement opportunity. Sourced from Microsoft Dynamics 365 opportunity and activity records.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`engagement_opportunity` (
    `engagement_opportunity_id` BIGINT COMMENT 'Unique identifier for the engagement opportunity record. Primary key.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Engagement opportunities require AML/KYC screening under the firms program before conversion to matter. Real process: opportunity-stage compliance screening for high-value or high-risk prospects.',
    `engagement_opportunity_prospect` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Each engagement opportunity is associated with a prospect. Required for pipeline conversion reporting.',
    `engagement_prospect` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Each engagement opportunity is associated with a prospect. This is the core CRM pipeline link.',
    `engagement_prospect_id` BIGINT COMMENT 'Reference to the prospective client or existing client organization pursuing this opportunity.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Engagement opportunities track proposal documents (fee proposals, scope documents, capability statements) submitted during business development. Essential for win/loss analysis, proposal reuse, and tr',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified the opportunity record.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner who originated the client relationship or opportunity, relevant for credit allocation.',
    `pitch_id` BIGINT COMMENT 'FK to intake.pitch.pitch_id — Engagement opportunities are often created from successful pitches. Links the BD pipeline stages.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Opportunities tracked by practice area for pipeline reporting, resource forecasting, capacity planning, and practice-level revenue projections. Critical for business development dashboards and partner',
    `primary_engagement_attorney_profile_id` BIGINT COMMENT 'Reference to the partner leading the business development effort and expected to be the originating or responsible partner if the matter opens.',
    `prospect_id` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Every opportunity is associated with a prospect. Core CRM pipeline relationship required for conversion tracking.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Opportunities undergo risk assessment during business development; high-risk prospects (sanctions exposure, reputational concerns, conflict complexity) require documented risk register entries and par',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Opportunities in regulated sectors (financial services, healthcare, energy) must identify applicable regulatory obligations early for risk assessment and scoping. Real process: regulatory risk evaluat',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created the opportunity record.',
    `actual_close_date` DATE COMMENT 'Actual date the opportunity was closed (won or lost).',
    `afa_type` STRING COMMENT 'Type of fee arrangement under consideration or negotiated for this opportunity. [ENUM-REF-CANDIDATE: hourly|fixed_fee|capped_fee|contingency|blended_rate|success_fee|retainer — 7 candidates stripped; promote to reference product]',
    `competitor_name` STRING COMMENT 'Name of the competing law firm or ALSP that won the engagement, if known.',
    `conflict_check_completed_date` DATE COMMENT 'Date the conflict check was completed and cleared (or waived) for this opportunity.',
    `conflict_check_status` STRING COMMENT 'Current status of the conflict check process in Intapp Conflicts for this opportunity.. Valid values are `not_started|in_progress|cleared|conflict_identified|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created in the CRM system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated matter value.. Valid values are `^[A-Z]{3}$`',
    `dynamics_opportunity_guid` STRING COMMENT 'Globally unique identifier (GUID) of the corresponding Opportunity record in Microsoft Dynamics 365 CRM.',
    `elite_matter_number` STRING COMMENT 'The matter number assigned in Elite 3E if the opportunity was converted to an active matter.',
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
    `rfp_received_date` DATE COMMENT 'Date the firm received the RFP or initial inquiry from the prospect.',
    `source_campaign` STRING COMMENT 'Marketing campaign or business development initiative that generated this opportunity.',
    CONSTRAINT pk_engagement_opportunity PRIMARY KEY(`engagement_opportunity_id`)
) COMMENT 'Core CRM pipeline entity representing a qualified business development opportunity for a specific legal matter or ongoing client relationship. Tracks opportunity stage (qualification, proposal, negotiation, closed-won, closed-lost), estimated matter value, practice group, responsible partner, probability of conversion, expected matter open date, and AFA type under consideration. Maps directly to Microsoft Dynamics 365 Opportunity records and serves as the commercial anchor linking prospect, pitch, and eventual matter opening in Elite 3E.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`request` (
    `request_id` BIGINT COMMENT 'Unique identifier for the new business intake request. Primary key for the intake workflow orchestration record.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Intake requests execute under the firms AML/KYC program, which defines screening protocols, risk appetite, and approval thresholds. Real process: client acceptance procedures governed by AML/KYC prog',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to knowledge.checklist. Business justification: Intake processes apply matter-type-specific checklists (M&A intake, litigation intake, regulatory compliance intake) to ensure completeness of information gathering, conflict checks, and compliance re',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: New matter intake identifies required court forms, regulatory filings, and standard templates needed for engagement scope. Intake assessment process evaluates template availability and customization r',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Intake requests require supporting documentation (engagement letters, conflict waivers, client correspondence, corporate records) for conflict clearance, KYC compliance, and matter opening approval wo',
    `matter_id` BIGINT COMMENT 'Reference to the opened matter record in Elite 3E. Populated upon successful matter opening and handoff to the matter domain.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney who originated the client relationship or business opportunity. Used for credit allocation and compensation.',
    `profile_id` BIGINT COMMENT 'Reference to an existing client record if this intake request is for a new matter for an existing client. Null if this is a completely new client.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Intake requests identify conflicts, AML, sanctions, and reputational risks during client onboarding that must be formally logged in the risk register for compliance reporting, risk committee review, a',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Intake requests must verify applicable regulatory obligations (AML, sanctions, jurisdiction-specific requirements) before client acceptance. Real process: regulatory compliance screening during intake',
    `request_approved_by_partner_attorney_profile_id` BIGINT COMMENT 'Identifier of the partner or committee member who granted final approval for the engagement.',
    `request_attorney_profile_id` BIGINT COMMENT 'Identifier of the equity or non-equity partner who will supervise and have ultimate responsibility for the matter.',
    `requesting_timekeeper_id` BIGINT COMMENT 'Identifier of the attorney or business development professional who submitted the intake request.',
    `rfp_submission_id` BIGINT COMMENT 'Reference to the RFP or pitch opportunity in Microsoft Dynamics 365 CRM that originated this intake request. Links intake to business development pipeline.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the system user who last modified the intake request record. Used for audit trail and accountability.',
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
    `practice_area` STRING COMMENT 'Primary legal practice area or department that will handle the matter. Used for routing, conflict checking, and resource allocation. [ENUM-REF-CANDIDATE: Corporate|Litigation|Intellectual Property|Employment|Real Estate|Tax|Regulatory Compliance — 7 candidates stripped; promote to reference product]',
    `proposed_client_name` STRING COMMENT 'Name of the prospective client or organization for whom legal services are being requested. May be an existing client for a new matter or a completely new client.',
    `proposed_fee_arrangement_type` STRING COMMENT 'Type of billing arrangement proposed for the matter. May be traditional hourly or an alternative fee arrangement negotiated with the client. [ENUM-REF-CANDIDATE: Hourly|Fixed Fee|Contingency|Blended|Capped Fee|Success Fee|Retainer — 7 candidates stripped; promote to reference product]',
    `proposed_matter_number` STRING COMMENT 'Reserved or proposed matter number that will be assigned in Elite 3E upon matter opening. May follow firm numbering conventions.. Valid values are `^[0-9]{6,10}(-[0-9]{3})?$`',
    `rejection_reason` STRING COMMENT 'Explanation for why the intake request was rejected or declined. May include conflict details, risk concerns, or capacity constraints.',
    `related_parties` STRING COMMENT 'Names of other parties involved in the matter who are not adverse but require conflict screening (e.g., co-counsel, transaction participants, witnesses).',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the intake request, typically formatted as office code followed by sequential number. Used for tracking and reference in communications.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `risk_rating` STRING COMMENT 'Overall risk assessment for the engagement based on conflict analysis, client profile, matter complexity, and regulatory exposure.. Valid values are `Low|Medium|High|Critical`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the intake request was formally submitted into the workflow system. Marks the start of the intake lifecycle.',
    `target_matter_open_date` DATE COMMENT 'Requested or target date by which the matter should be opened in Elite 3E and work can commence.',
    `urgency_flag` BOOLEAN COMMENT 'Indicates whether this intake request requires expedited processing due to time-sensitive business needs, court deadlines, or transaction timelines.',
    CONSTRAINT pk_request PRIMARY KEY(`request_id`)
) COMMENT 'Central workflow orchestration record for the new business intake lifecycle. Represents the formal request submitted by an attorney or BD professional to initiate conflict checking, KYC/AML screening, engagement approval, and ultimately matter opening in Elite 3E. Captures requesting timekeeper, proposed client name, adverse parties, matter description, practice area, office, supervising partner, urgency flag, submission timestamp, and matter opening details (proposed matter number, billing arrangement, approval status). Progresses through stages from submission through conflict clearance, LOE execution, and matter number reservation. Acts as the operational trigger in Intapp Conflicts and the handoff record to the matter domain. Encompasses the full intake-to-open lifecycle including onboarding task tracking and matter opening request details.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`conflict_search` (
    `conflict_search_id` BIGINT COMMENT 'Primary key for conflict_search',
    `timekeeper_id` BIGINT COMMENT 'Reference to the employee (typically intake coordinator, conflicts analyst, or attorney) who initiated the conflict search.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`conflict_hit` (
    `conflict_hit_id` BIGINT COMMENT 'Primary key for conflict_hit',
    `conflict_search_id` BIGINT COMMENT 'FK to intake.conflict_search.conflict_search_id — Each conflict hit is a result of a specific conflict search. Parent-child relationship required for hit resolution tracking.',
    `intake_party_id` BIGINT COMMENT 'Foreign key linking to intake.intake_party. Business justification: Conflict hits may be associated with specific intake parties. This links the conflict hit to the party for traceability, enabling tracking of which parties generated conflict hits. The existing matche',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Conflict hits require linking to specific documents from the conflicted matter (engagement letters, pleadings, correspondence) for conflict waiver analysis, ethical wall implementation, and partner re',
    `matter_id` BIGINT COMMENT 'Reference to the existing matter record that contains the conflicting party or relationship. Null if the match is at client level only.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or conflicts analyst assigned to review and disposition this hit. Typically a partner or conflicts counsel.',
    `primary_conflict_search_id` BIGINT COMMENT 'Reference to the parent conflict search request that generated this hit. Links to the conflict search entity in the intake domain.',
    `profile_id` BIGINT COMMENT 'Reference to the existing client record that matched in the conflict search. Null if the match is not a current client.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: High-severity conflict hits identified during intake represent actual risk events requiring formal risk register entry for escalation to risk committee, mitigation tracking (ethical walls, waivers), a',
    `tertiary_conflict_escalated_to_attorney_profile_id` BIGINT COMMENT 'Reference to the senior reviewer or committee to whom this hit was escalated. Null if no escalation occurred.',
    `assigned_reviewer_name` STRING COMMENT 'Full name of the assigned reviewer for display and notification purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this conflict hit record was first created in the lakehouse. Audit trail for data lineage.',
    `disposition` STRING COMMENT 'Final resolution decision for this conflict hit. Determines whether the engagement can proceed and under what conditions.. Valid values are `cleared_no_conflict|cleared_with_waiver|false_positive|requires_ethical_wall|declined|pending`',
    `disposition_notes` STRING COMMENT 'Detailed explanation of the disposition decision, including rationale, mitigating factors, and any conditions imposed. Subject to Legal Professional Privilege (LPP).',
    `escalated_to_name` STRING COMMENT 'Full name of the senior reviewer or committee to whom this hit was escalated.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this hit requires escalation to senior conflicts counsel, the General Counsel (GC), or the conflicts committee for final decision.',
    `ethical_wall_required_flag` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) must be established to mitigate the conflict and allow the engagement to proceed.',
    `hit_identified_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict hit was first identified by the conflict checking system. Marks the start of the review clock.',
    `hit_sequence_number` STRING COMMENT 'Sequential ordering of this hit within the parent conflict search. Used to maintain display order and priority ranking.',
    `hit_severity` STRING COMMENT 'Classification of the conflict severity. Actual conflicts require declination or waiver; potential conflicts require further review; waivable conflicts may proceed with client consent; informational hits are for awareness only.. Valid values are `actual|potential|waivable|informational`',
    `hit_status` STRING COMMENT 'Current workflow status of the conflict hit within the intake review process. Tracks progression from identification through resolution.. Valid values are `pending_review|under_review|cleared|escalated|requires_waiver|declined`',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction of the matched matter. Relevant for assessing conflict rules and regulatory requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this conflict hit record was last updated. Tracks changes to status, disposition, or reviewer assignments.',
    `match_score` DECIMAL(18,2) COMMENT 'Algorithmic confidence score (0.00 to 100.00) indicating the strength of the name match. Higher scores indicate stronger matches requiring priority review.',
    `match_type` STRING COMMENT 'Type of matching algorithm that identified this hit. Exact matches have highest confidence; fuzzy and phonetic matches require manual verification.. Valid values are `exact|fuzzy|phonetic|alias|dba|former_name`',
    `matched_matter_description` STRING COMMENT 'Brief description of the matter containing the conflict. Provides context for conflict assessment without requiring full matter access.',
    `practice_area` STRING COMMENT 'Legal practice area of the matched matter. Used to assess substantive conflict risk and cross-practice exposure.',
    `relationship_type` STRING COMMENT 'Nature of the relationship between the matched party and the existing matter or client. Determines conflict severity and waivability. [ENUM-REF-CANDIDATE: client|adverse_party|co_counsel|opposing_counsel|related_entity|affiliate|subsidiary|parent_company|officer|director|shareholder|witness|expert|other — 14 candidates stripped; promote to reference product]',
    `responsible_partner_name` STRING COMMENT 'Full name of the partner responsible for the matched matter. Displayed for conflict review context.',
    `review_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the conflict hit review was completed and a disposition was recorded. Marks the end of the review cycle.',
    `review_priority` STRING COMMENT 'Urgency level for reviewing this hit. Critical and high priority hits require immediate attention to avoid intake delays.. Valid values are `critical|high|medium|low`',
    `review_started_timestamp` TIMESTAMP COMMENT 'Date and time when a reviewer first opened this hit for assessment. Used to track review cycle time.',
    `source_system` STRING COMMENT 'Name of the system that generated this conflict hit record. Typically Intapp Conflicts, but may include legacy or integrated systems.',
    `source_system_hit_reference` STRING COMMENT 'Original hit identifier from the source conflict checking system. Used for traceability and audit purposes.',
    `waiver_obtained_flag` BOOLEAN COMMENT 'Indicates whether the required conflict waiver has been successfully obtained and documented.',
    `waiver_required_flag` BOOLEAN COMMENT 'Indicates whether a formal conflict waiver must be obtained from affected clients before proceeding with the engagement.',
    CONSTRAINT pk_conflict_hit PRIMARY KEY(`conflict_hit_id`)
) COMMENT 'Individual conflict search result record representing a potential conflict match identified during intake conflict screening. Captures matched party name, matched matter or client reference, relationship type, hit severity (potential, actual, waivable), assigned reviewer, review status, and disposition notes. Multiple hits may be generated per conflict search. Sourced from Intapp Conflicts hit results. Boundary: this entity owns the raw hit record and initial triage within the intake workflow; formal clearance decisions, conflict waivers, and ethical wall enforcement are owned by the conflict domain.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`intake_party` (
    `intake_party_id` BIGINT COMMENT 'Unique identifier for the intake party record. Primary key for the intake party entity representing unverified parties at the pre-clearance stage before formal client onboarding.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Parties being onboarded are screened against the firms AML/KYC program requirements for PEP, sanctions, and adverse media. Real process: party-level compliance screening during intake.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Intake parties require linking to entity formation documents, corporate registrations, certificates of incorporation, and organizational charts for conflict checking, KYC verification, and corporate s',
    `request_id` BIGINT COMMENT 'Reference to the parent new business intake request that this party is associated with. Links the party to the originating RFP or engagement opportunity.',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Parties identified in intake undergo sanctions screening against OFAC, UN, EU lists. Real process: party-level sanctions verification before client/matter acceptance.',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to risk.sanctions_screening. Business justification: Each party in an intake request requires individual sanctions screening per AML regulations; the sanctions_screening result must link to the specific intake_party record to support party-level risk de',
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
    `jurisdiction_of_incorporation` STRING COMMENT 'The legal jurisdiction where the party is incorporated, registered, or domiciled. For individuals, the jurisdiction of primary residence. Critical for conflict checking and regulatory compliance.',
    `kyc_screening_date` DATE COMMENT 'The date when KYC screening was completed for this party. Used for compliance audit trails and periodic re-screening requirements.',
    `kyc_screening_status` STRING COMMENT 'Status of the KYC due diligence process for this party. Tracks completion of identity verification, sanctions screening, and AML checks required before engagement.. Valid values are `not-started|in-progress|completed|failed|waived`',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special considerations, or intake team observations about this party. Used for handoff to matter management.',
    `parent_entity_name` STRING COMMENT 'The name of the parent or controlling entity if this party is a subsidiary or affiliate. Used to identify corporate family relationships for comprehensive conflict searches.',
    `party_intake_request_fk` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — Parties are associated with a specific intake request for conflict checking purposes. Core operational link.',
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
    `ultimate_parent_entity_name` STRING COMMENT 'The name of the ultimate beneficial owner or top-level parent entity in the corporate hierarchy. Essential for identifying all related parties in conflict analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this intake party record was last modified. Tracks the most recent change to any attribute for audit and synchronization purposes.',
    `website_url` STRING COMMENT 'The primary website URL for the party. Used for background research and entity verification during intake.',
    CONSTRAINT pk_intake_party PRIMARY KEY(`intake_party_id`)
) COMMENT 'Master record of each party (client, adverse party, related entity, guarantor, subsidiary) associated with a new business intake request. Captures party name, party role (client, adverse, related, guarantor, co-counsel), entity type (corporation, individual, government), jurisdiction of incorporation, parent entity reference, and KYC/AML screening status. Supports multi-party conflict searches and adverse party tracking. Distinct from the client domains client entity — intake_party represents unverified parties at the pre-clearance stage before formal client onboarding.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`kyc_screening` (
    `kyc_screening_id` BIGINT COMMENT 'Unique identifier for the KYC screening record. Primary key.',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: KYC screenings are conducted under a specific AML/KYC programs methodology, risk rating framework, and regulatory requirements. Real process: program-governed client due diligence execution.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the compliance officer or staff member who reviewed the screening results.',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: KYC screenings may be associated with specific engagement opportunities in addition to intake requests. This links the screening to the opportunity for traceability, enabling tracking of which opportu',
    `intake_party_id` BIGINT COMMENT 'Reference to the intake party (prospective client, beneficial owner, or related entity) being screened.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: KYC screenings require linking to supporting documentation (corporate registrations, beneficial ownership records, sanctions screening reports, AML verification documents) for regulatory compliance, a',
    `primary_intake_party_id` BIGINT COMMENT 'FK to intake.intake_party.intake_party_id — KYC screenings are performed on specific intake parties. Required for compliance traceability.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: KYC screening outcomes (high-risk ratings, PEP flags, adverse media hits, sanctions matches) automatically generate risk register entries for client acceptance committee review, enhanced due diligence',
    `request_id` BIGINT COMMENT 'Reference to the parent intake record for which this KYC screening was performed.',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: KYC screening results must reference specific sanctions screening records for audit trail and regulatory reporting. Real process: sanctions verification as component of KYC due diligence.',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to risk.sanctions_screening. Business justification: KYC screening during intake triggers mandatory sanctions checks; the sanctions_screening record must reference the originating KYC screening for complete audit trail, regulatory reporting (SAR filings',
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

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`intake_engagement_scope` (
    `intake_engagement_scope_id` BIGINT COMMENT 'Unique identifier for the engagement scope record. Primary key for the intake engagement scope entity.',
    `engagement_opportunity_id` BIGINT COMMENT 'FK to intake.engagement_opportunity.engagement_opportunity_id — Engagement scope is defined for a specific opportunity. Links commercial specification to the pipeline record.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: Scope definition identifies required deliverable templates, filing forms, and standard work product formats that will be produced during engagement. Scoping process evaluates template availability to ',
    `intake_engagement_opportunity_id` BIGINT COMMENT 'Reference to the parent engagement opportunity in the intake pipeline from which this scope definition was created. Links to the CRM opportunity record in Microsoft Dynamics 365.',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier for the user who last modified the engagement scope record. Tracks negotiation and revision activity.',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: The engagement scope is formalized in the Letter of Engagement. This links the scope to the executed LOE. The existing loe_reference_number (STRING) should be replaced with a proper FK to enable relat',
    `matter_id` BIGINT COMMENT 'Identifier for the matter record created in Elite 3E upon LOE execution and engagement commencement. Represents the handoff from intake to matter domain.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Intake scopes reference firms pricing models during opportunity estimation to calculate fees, set client expectations, and ensure billing system compatibility before matter opening. Essential for pro',
    `attorney_profile_id` BIGINT COMMENT 'Identifier for the partner who will lead the engagement and serve as primary client relationship owner. Links to timekeeper or workforce records.',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.intake_request. Business justification: Engagement scope is defined during the intake process. Linking scope to the intake request provides traceability from scope definition back to the originating intake workflow. This is a standard paren',
    `timekeeper_id` BIGINT COMMENT 'Identifier for the user who created the initial engagement scope record. Typically a business development professional or intake coordinator.',
    `approved_date` DATE COMMENT 'Date when the engagement scope was formally approved by the lead partner or practice group head. Triggers LOE drafting process.',
    `client_responsibilities` STRING COMMENT 'Explicit list of responsibilities, actions, or deliverables expected from the client to enable successful engagement execution (e.g., document provision, decision-making, access to personnel).',
    `conflict_check_reference` STRING COMMENT 'Reference number or identifier for the conflict check record in Intapp Conflicts system associated with this engagement scope.',
    `conflict_check_status` STRING COMMENT 'Status of the conflict check process for this engagement scope. Must be cleared before LOE execution. Values: pending (check in progress), cleared (no conflicts), conditional (cleared with ethical walls), declined (conflict identified).. Valid values are `pending|cleared|conditional|declined`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the engagement scope record was first created in the intake system. Marks the beginning of scope definition activity.',
    `engagement_duration_months` STRING COMMENT 'Estimated duration of the engagement in months. Used for resource planning and AFA structuring. Null for open-ended or event-driven engagements.',
    `estimated_associate_hours` DECIMAL(18,2) COMMENT 'Estimated total hours to be worked by associate-level timekeepers on this engagement. Used for resource planning and AFA pricing.',
    `estimated_completion_date` DATE COMMENT 'Anticipated completion or end date for the engagement. Null for ongoing or open-ended matters. Used for pipeline forecasting and resource planning.',
    `estimated_paralegal_hours` DECIMAL(18,2) COMMENT 'Estimated total hours to be worked by paralegal staff on this engagement. Used for resource planning and AFA pricing.',
    `estimated_partner_hours` DECIMAL(18,2) COMMENT 'Estimated total hours to be worked by partner-level timekeepers on this engagement. Used for resource planning and AFA pricing.',
    `estimated_start_date` DATE COMMENT 'Anticipated start date for the engagement if the scope is approved and LOE is executed. Used for resource allocation and capacity planning.',
    `estimated_total_hours` DECIMAL(18,2) COMMENT 'Total estimated hours across all timekeeper roles for the engagement. Sum of partner, associate, paralegal, and other staff hours. Used for capacity planning and fee estimation.',
    `excluded_services` STRING COMMENT 'Explicit list of services, tasks, and activities that are outside the agreed engagement scope. Critical for scope management and preventing scope creep.',
    `geographic_scope` STRING COMMENT 'Geographic jurisdictions, countries, or regions covered by the engagement scope. Relevant for multi-jurisdictional matters and cross-border transactions.',
    `included_services` STRING COMMENT 'Explicit list of services, tasks, and deliverables that are included within the agreed engagement scope. Used to define boundaries and manage client expectations.',
    `intake_fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to intake.intake_fee_arrangement. Business justification: Engagement scope and fee arrangement are negotiated together during intake. This links the scope to the fee arrangement, enabling tracking of which fee arrangements apply to which scopes. The existing',
    `key_assumptions` STRING COMMENT 'Critical assumptions underlying the scope definition and fee estimate (e.g., client cooperation, document availability, no material changes in law, third-party responsiveness).',
    `key_deliverables` STRING COMMENT 'List of major deliverables, milestones, or work products to be produced during the engagement (e.g., draft agreements, legal opinions, filings, closing documents).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the engagement scope record. Tracks negotiation evolution and version history.',
    `matter_type_code` STRING COMMENT 'Specific matter type classification within the practice area. Aligns with Elite 3E matter type taxonomy and UTBMS task codes for billing and matter management.',
    `notes` STRING COMMENT 'Free-text notes, comments, or internal observations related to the engagement scope definition, negotiation, or client discussions. For internal use only.',
    `practice_area_code` STRING COMMENT 'Primary practice area for the engagement scope. Values: CORP (Corporate), LIT (Litigation), IP (Intellectual Property), EMP (Employment), REG (Regulatory), TAX (Tax), RE (Real Estate), MA (Mergers and Acquisitions), COMP (Compliance), OTHER. [ENUM-REF-CANDIDATE: CORP|LIT|IP|EMP|REG|TAX|RE|MA|COMP|OTHER — 10 candidates stripped; promote to reference product]',
    `risk_factors` STRING COMMENT 'Identified risks, uncertainties, or scope variables that could impact the engagement (e.g., regulatory changes, opposing party behavior, complexity escalation).',
    `scope_change_protocol` STRING COMMENT 'Agreed process for handling scope changes, additional services, or out-of-scope requests during the engagement. Defines approval and pricing mechanisms.',
    `scope_reference_number` STRING COMMENT 'Business-facing unique reference number for the engagement scope document. Format: practice area code, year-month-sequence, scope version (e.g., CORP-202401-SC01). Used in client communications and LOE drafting.. Valid values are `^[A-Z]{2,4}-[0-9]{6}-SC[0-9]{2}$`',
    `scope_status` STRING COMMENT 'Current lifecycle status of the engagement scope definition. Tracks progression from initial draft through client negotiation to final approval or withdrawal. [ENUM-REF-CANDIDATE: draft|under_review|client_review|negotiation|approved|superseded|withdrawn — 7 candidates stripped; promote to reference product]',
    `scope_version_number` STRING COMMENT 'Version number of the engagement scope definition. Increments with each negotiation iteration or material change to scope terms. Version 1 is the initial draft; subsequent versions track negotiation evolution.',
    `service_description` STRING COMMENT 'Detailed narrative description of the legal services to be provided under this engagement scope. Includes objectives, deliverables, and approach. Forms the basis for the scope section of the LOE.',
    `staffing_plan` STRING COMMENT 'Narrative description of the proposed staffing model for the engagement, including roles, seniority levels, and team composition (partner, associate, paralegal, support staff).',
    `technology_tools_required` STRING COMMENT 'List of technology platforms, tools, or systems required for engagement delivery (e.g., eDiscovery platform, contract management system, data room, collaboration tools).',
    CONSTRAINT pk_intake_engagement_scope PRIMARY KEY(`intake_engagement_scope_id`)
) COMMENT 'Master record defining the agreed scope of legal services for a proposed engagement, negotiated during the intake process prior to LOE execution. Captures practice area, matter type, service description, geographic scope, included and excluded services, staffing plan (partner, associate, paralegal), estimated hours by role, and scope version number. Serves as the commercial specification that feeds the LOE drafting process and AFA negotiation. Linked to the engagement opportunity and the resulting letter of engagement. Owned by the intake domain as the pre-matter scope definition.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` (
    `intake_fee_arrangement_id` BIGINT COMMENT 'Unique identifier for the intake fee arrangement record. Primary key for this entity.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner who approved this fee arrangement. Ensures appropriate authority and risk oversight for non-standard or discounted fee structures.',
    `billing_fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.fee_arrangement. Business justification: Proposed intake fee arrangements convert to active billing fee arrangements upon matter opening. Tracking this lineage enables analysis of proposal-to-execution variance, supports fee arrangement amen',
    `client_engagement_scope_id` BIGINT COMMENT 'Reference to the engagement scope that this fee arrangement supports. Links the commercial agreement to the defined scope of legal services.',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Fee arrangements are associated with specific opportunities in the CRM pipeline. This links the fee arrangement to the CRM opportunity, enabling tracking of negotiated fee arrangements against pipelin',
    `intake_engagement_scope_id` BIGINT COMMENT 'FK to intake.intake_engagement_scope.intake_engagement_scope_id — Fee arrangements are negotiated in context of a defined engagement scope. Commercial terms link to scope definition.',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Fee arrangements are formalized in the Letter of Engagement. This links the fee arrangement to the executed LOE, enabling tracking of which fee arrangements were formalized in which LOEs. Standard par',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Fee arrangements negotiated during intake reference firms standard pricing models to ensure consistency, compliance with billing guidelines, and proper billing system setup. Critical for LOE terms an',
    `profile_id` BIGINT COMMENT 'Reference to the prospective client for whom this fee arrangement is being negotiated during intake.',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.intake_request. Business justification: Fee arrangements are negotiated during the intake workflow. Linking to intake_request provides workflow traceability from fee arrangement back to the originating intake request. This is a standard par',
    `agreed_fee_amount` DECIMAL(18,2) COMMENT 'The total fee amount agreed for fixed fee, capped fee, or retainer arrangements. Null for hourly or contingency arrangements where the amount is variable. Represents the commercial commitment in the engagement.',
    `approval_date` DATE COMMENT 'The date on which the fee arrangement was formally approved by the approving partner. Marks the transition from proposed to approved status.',
    `arrangement_number` STRING COMMENT 'Business identifier for the fee arrangement, typically generated during intake negotiation. Used for tracking and reference in proposals and letters of engagement.',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the fee arrangement. Tracks progression from initial draft through negotiation to final approval or rejection. Superseded indicates a revised arrangement has replaced this one.. Valid values are `draft|proposed|negotiating|approved|rejected|superseded`',
    `billing_frequency` STRING COMMENT 'The agreed frequency at which invoices will be issued to the client. Monthly and quarterly are common for ongoing matters; milestone and completion are typical for project-based work; on-demand for ad-hoc arrangements.. Valid values are `monthly|quarterly|milestone|completion|on_demand`',
    `blended_rate` DECIMAL(18,2) COMMENT 'The single averaged hourly rate applied across all timekeepers for blended rate arrangements. Simplifies billing by eliminating individual rate variations. Null for non-blended arrangements.',
    `cap_amount` DECIMAL(18,2) COMMENT 'The maximum fee amount that can be billed for capped fee arrangements. Provides cost certainty to the client while allowing hourly billing up to the cap. Null for non-capped arrangements.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The percentage of recovery or settlement that the firm will receive as its fee in contingency arrangements. Typically ranges from 10% to 40% depending on jurisdiction and matter type. Null for non-contingency arrangements.',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this fee arrangement record. Typically a business development professional, partner, or pricing analyst involved in the intake process.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fee arrangement record was first created in the source system. Represents the start of the fee arrangement negotiation lifecycle.',
    `disbursement_handling` STRING COMMENT 'Defines how disbursements (out-of-pocket expenses such as court fees, filing fees, expert fees) are treated in the fee arrangement. Included means absorbed in the fixed fee; pass-through means billed at cost; marked-up means billed with an administrative margin.. Valid values are `included|pass_through|marked_up`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to standard rates as part of the negotiated fee arrangement. Common in competitive pitches or for high-volume clients. Zero if no discount applied.',
    `effective_date` DATE COMMENT 'The date from which this fee arrangement becomes active and governs billing for the engagement. Typically aligns with the letter of engagement execution date.',
    `expiry_date` DATE COMMENT 'The date on which this fee arrangement expires or terminates. Null for open-ended arrangements. Used for time-limited retainers or project-based fixed fees.',
    `is_outside_counsel_guideline_compliant` BOOLEAN COMMENT 'Indicates whether this fee arrangement complies with the clients outside counsel guidelines. Many corporate clients impose billing guidelines that restrict rate increases, require task-based billing codes (UTBMS), and mandate electronic invoicing (LEDES).',
    `ledes_format_required` BOOLEAN COMMENT 'Indicates whether invoices under this fee arrangement must be submitted in LEDES electronic format. LEDES is the industry standard for electronic billing data exchange between law firms and corporate clients.',
    `loe_reference` STRING COMMENT 'Reference number or identifier of the letter of engagement that formalizes this fee arrangement. Links the commercial agreement to the binding engagement contract.',
    `minimum_fee_commitment` DECIMAL(18,2) COMMENT 'The minimum total fee the client commits to pay over a defined period, regardless of actual work performed. Common in retainer and volume-based arrangements to guarantee revenue. Null if no minimum applies.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this fee arrangement record. Tracks accountability for changes during negotiation and approval.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fee arrangement record was last modified in the source system. Tracks changes during negotiation and approval cycles.',
    `negotiation_notes` STRING COMMENT 'Free-text notes capturing key points from fee negotiation discussions, client concerns, competitive pressures, and rationale for the final agreed terms. Supports knowledge management and future client interactions.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due. Standard terms are 30 days, but may be negotiated to 14, 60, or other periods based on client relationship and creditworthiness.',
    `rate_schedule_reference` STRING COMMENT 'Reference to the rate schedule or rate card that underpins this fee arrangement. Links to the firms rate table in Elite 3E. Used for hourly and blended rate arrangements to track the base rates before discounts.',
    `rejection_reason` STRING COMMENT 'Explanation for why the fee arrangement was rejected, either by the client or by internal approval authority. Captures business intelligence for future pricing and negotiation strategies. Null if not rejected.',
    `retainer_period` STRING COMMENT 'The recurring period for retainer fee arrangements. Defines how frequently the retainer fee is charged (e.g., monthly retainer for ongoing advisory services). Null for non-retainer arrangements.. Valid values are `monthly|quarterly|annual`',
    `source_system` STRING COMMENT 'The operational system from which this fee arrangement record was sourced. Typically Elite 3E rate and billing configuration or Microsoft Dynamics 365 CRM during the intake pipeline stage.',
    `source_system_code` STRING COMMENT 'The unique identifier of this fee arrangement in the source system (e.g., Elite 3E fee arrangement ID). Enables traceability and reconciliation between the lakehouse and operational systems.',
    `success_criteria_description` STRING COMMENT 'Detailed description of the conditions that must be met to trigger the success fee. Defines measurable outcomes such as settlement amount thresholds, deal completion, or favorable court rulings.',
    `success_fee_amount` DECIMAL(18,2) COMMENT 'Additional fee payable upon achieving defined success criteria (e.g., favorable judgment, transaction close, regulatory approval). Common in M&A, litigation, and regulatory matters. Null if no success fee applies.',
    `utbms_task_code_required` BOOLEAN COMMENT 'Indicates whether time entries under this fee arrangement must be coded using UTBMS task codes for billing compliance. Required by many corporate clients for invoice transparency and spend analytics.',
    CONSTRAINT pk_intake_fee_arrangement PRIMARY KEY(`intake_fee_arrangement_id`)
) COMMENT 'Master record capturing the negotiated fee arrangement (AFA) agreed with a prospective client during the intake and engagement scoping process. Tracks AFA type (hourly, fixed fee, capped fee, contingency, blended rate, retainer, success fee), agreed fee amount or rate schedule reference, billing frequency, currency, discount applied, approval status, approving partner, and effective date. Linked to the engagement scope and letter of engagement. Sourced from Elite 3E rate and billing configuration. Distinct from the billing domains rate schedule — this entity captures the negotiated commercial agreement, not the rate table.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`letter_of_engagement` (
    `letter_of_engagement_id` BIGINT COMMENT 'Unique identifier for the Letter of Engagement. Primary key for the LOE master record.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: LOEs must reference applicable compliance policies (data protection, conflicts, confidentiality, client acceptance) to ensure engagement terms comply with firm governance. Real process: policy-complia',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: LOEs involving personal data processing must link to ROPA entries for GDPR Article 30 compliance and lawful basis documentation. Real process: privacy impact assessment at engagement inception.',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user or system account that last modified this Letter of Engagement record. Audit trail for accountability.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Letter of engagement must link to its executed document version for signature verification, version control, matter opening authorization, and regulatory compliance. Critical for engagement terms enfo',
    `matter_id` BIGINT COMMENT 'Reference to the matter record created in Elite 3E upon LOE acceptance. Nullable until the matter is opened. Represents the handoff from intake domain to matter domain.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner who originated the client relationship or business development opportunity. May differ from the responsible partner. Used for origination credit and compensation.',
    `outside_counsel_guideline_id` BIGINT COMMENT 'Reference to the clients Outside Counsel Guidelines that govern billing practices, staffing, and service delivery standards for this engagement. Nullable if client has no formal OCG.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: LOE drafting pulls from precedent engagement letter library, standard scope-of-work templates, and approved terms libraries. Document assembly process for client engagement agreements depends on prece',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: LOEs reference pricing models to define billing terms, rate structures, and payment terms before matter opening. Essential for client billing setup and engagement letter generation. Ensures consistenc',
    `primary_letter_attorney_profile_id` BIGINT COMMENT 'Reference to the equity partner or senior attorney responsible for this engagement. Primary relationship owner and signatory on the LOE.',
    `prospect_id` BIGINT COMMENT 'Reference to the prospective client for whom this Letter of Engagement is issued. Links to the client domain prospect or client_profile entity.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: LOEs contain risk-relevant contractual terms (liability caps, indemnity clauses, scope limitations, fee arrangements) that trigger risk register entries for professional indemnity exposure tracking, i',
    `rfp_submission_id` BIGINT COMMENT 'Reference to the originating Request for Proposal that led to this Letter of Engagement. Nullable if the engagement did not originate from a formal RFP process.',
    `superseded_by_loe_letter_of_engagement_id` BIGINT COMMENT 'Reference to the newer Letter of Engagement that supersedes this one. Nullable if this LOE is current or was not superseded. Used to track LOE version history.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user or system account that created this Letter of Engagement record. Audit trail for accountability.',
    `acceptance_date` DATE COMMENT 'Date on which the client formally accepted and signed the Letter of Engagement. Nullable until acceptance occurs. Triggers handoff to matter domain for matter opening in Elite 3E.',
    `acceptance_deadline_date` DATE COMMENT 'Date by which the client must accept and sign the Letter of Engagement. After this date, the LOE may expire or require reissuance.',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices will be issued to the client under this engagement. Defines the billing cycle for Work in Progress (WIP) conversion.. Valid values are `monthly|quarterly|milestone|upon_completion|as_incurred`',
    `client_signatory_email` STRING COMMENT 'Email address of the client signatory for LOE delivery and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `client_signatory_name` STRING COMMENT 'Full name of the individual authorized to sign the Letter of Engagement on behalf of the client organization or as the individual client.',
    `client_signatory_title` STRING COMMENT 'Job title or role of the client signatory (e.g., General Counsel, Chief Legal Officer, CEO, individual capacity).',
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
    `loe_intake` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — The LOE formalizes the engagement initiated by an intake request. Required for lifecycle completion tracking.',
    `loe_intake_request` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — The LOE formalizes the engagement initiated by the intake request. This link closes the intake lifecycle loop.',
    `loe_intake_request_fk` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — LOE is the output artifact of a successful intake request. Links the formal agreement back to the originating workflow.',
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
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney responsible for billing and collections on this matter. May be the same as responsible partner or a designated billing partner.',
    `billing_fee_arrangement_id` BIGINT COMMENT 'Reference to the billing arrangement negotiated for this matter. May reference Alternative Fee Arrangement (AFA), hourly billing, fixed fee, contingency, or blended rate structure.',
    `check_id` BIGINT COMMENT 'Reference to the conflict check record that was successfully cleared prior to this matter opening request. Links to Intapp Conflicts system clearance record.',
    `matter_id` BIGINT COMMENT 'The system-generated matter identifier assigned by Elite 3E upon matter creation. Nullable until matter is opened. Used for cross-system reconciliation.',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Matter opening requests are generated when CRM opportunities are won. This links the matter opening to the CRM opportunity, enabling tracking of which opportunities resulted in opened matters. Standar',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'User identifier of the person who last modified the matter opening request record. Audit trail for change tracking.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Matter opening requests require linking to authorization documents (approved engagement letters, conflict clearance memos, partner approval emails, client authorization) for matter opening approval wo',
    `letter_of_engagement_id` BIGINT COMMENT 'Reference to the executed Letter of Engagement (LOE) that authorizes the opening of this matter. The LOE defines scope, terms, and fee arrangements.',
    `originating_attorney_attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who originated the client relationship or brought in the matter. Used for origination credit and compensation calculations.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Matter opening requests specify pricing model for billing system configuration, rate card assignment, and invoice generation setup. Critical for transitioning from intake to active matter with correct',
    `primary_matter_attorney_profile_id` BIGINT COMMENT 'Reference to the equity or non-equity partner who has overall responsibility for the matter. This partner oversees matter strategy, client relationship, and profitability.',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom the matter is being opened. Links to the client master record in the client domain.',
    `prospect_id` BIGINT COMMENT 'Reference to the prospect record in the CRM pipeline (Microsoft Dynamics 365) from which this matter opening request originated. Nullable for existing clients.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Matter opening must verify regulatory obligations applicable to matter type, jurisdiction, and practice area for compliance risk management. Real process: matter-level regulatory compliance check.',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.intake_request. Business justification: Matter opening requests are the final step in the intake workflow, generated from intake requests. This links the matter opening to the originating intake request, providing end-to-end traceability fr',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to intake.rfp_submission. Business justification: Matter opening requests may originate from RFP wins. This links the matter opening to the RFP submission for traceability, enabling tracking of which RFP submissions resulted in opened matters. Standa',
    `tertiary_matter_approved_by_attorney_attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or partner who approved the matter opening request. Nullable if not yet approved.',
    `timekeeper_id` BIGINT COMMENT 'User identifier of the person who created the matter opening request record. Typically a business development coordinator, intake specialist, or attorney.',
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
    `billing_fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.fee_arrangement. Business justification: Origination credits track business development value tied to specific fee arrangements. Linking credits to billing fee arrangements enables accurate origination compensation calculations based on actu',
    `check_id` BIGINT COMMENT 'Reference to the conflict check record performed during intake to ensure ethical compliance. Links to Intapp Conflicts system.',
    `engagement_opportunity_id` BIGINT COMMENT 'FK to intake.engagement_opportunity.engagement_opportunity_id — Origination credits are allocated per engagement opportunity. Required for partner compensation attribution.',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Origination credits are finalized when the LOE is executed. This links the credit to the executed LOE. The existing loe_execution_date can be retrieved from the letter_of_engagement table via JOIN, el',
    `matter_id` BIGINT COMMENT 'Reference to the matter for which this origination credit is allocated. Links to the matter opened in Elite 3E following successful intake.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'User identifier of the person who last modified this origination credit record. Audit trail for accountability.',
    `origination_engagement_opportunity_id` BIGINT COMMENT 'Reference to the engagement scope record established during intake. Links to the Letter of Engagement (LOE) and scope definition.',
    `panel_appointment_id` BIGINT COMMENT 'Foreign key linking to intake.panel_appointment. Business justification: Origination credits may be allocated for securing panel appointments. This links the credit to the panel appointment, enabling tracking of which panel appointments generated origination credits. Stand',
    `pitch_id` BIGINT COMMENT 'Foreign key linking to intake.pitch. Business justification: Origination credits may be allocated based on pitch participation. This links the credit to the pitch, enabling tracking of which pitches generated origination credits. The existing pitch_date can be ',
    `primary_origination_credited_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney or professional) receiving this origination credit. Links to the timekeeper master in Elite 3E or Aderant Expert.',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom this engagement was originated. Links to the client profile in Elite 3E.',
    `request_id` BIGINT COMMENT 'Foreign key linking to intake.intake_request. Business justification: Origination credits are allocated based on intake requests. This links the credit to the originating intake request for traceability, enabling tracking of which intake requests generated origination c',
    `rfp_submission_id` BIGINT COMMENT 'Reference to the Request for Proposal (RFP) record if this engagement originated from a competitive bid process. Links to the RFP tracking system in Microsoft Dynamics 365 CRM. Null if not applicable.',
    `timekeeper_id` BIGINT COMMENT 'User identifier of the person who created this origination credit record. Typically a practice administrator or business development coordinator.',
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
    `credited_practice_group` STRING COMMENT 'Practice group of the credited timekeeper at the time of origination. Used for practice-level revenue attribution and Profit Per Partner (PPP) calculations.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`client_onboarding_task` (
    `client_onboarding_task_id` BIGINT COMMENT 'Unique identifier for the client onboarding task. Primary key for this entity.',
    `task_id` BIGINT COMMENT 'Reference to another onboarding task that must be completed before this task can begin. Supports task sequencing and dependency resolution.',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to knowledge.checklist. Business justification: Onboarding task lists are generated from or validated against knowledge management checklists for client intake, KYC procedures, conflict clearance, and matter opening. Quality assurance process ensur',
    `completed_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who completed the task. May differ from assigned user if task was reassigned or escalated.',
    `created_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who created the task record. Typically the intake coordinator or system automation.',
    `engagement_opportunity_id` BIGINT COMMENT 'Reference to the engagement scope record associated with this onboarding task. Links to the engagement definition that will transition to a matter in Elite 3E.',
    `escalated_to_user_timekeeper_id` BIGINT COMMENT 'Reference to the user to whom the task has been escalated due to SLA breach risk or blocking issues.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified the task record. Supports audit trail and accountability.',
    `request_id` BIGINT COMMENT 'Reference to the parent new business intake record that this task belongs to. Links to the intake pipeline in Microsoft Dynamics 365 and Intapp Conflicts.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user or staff member responsible for completing this onboarding task. Links to workforce/user management system.',
    `waived_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the authorized user who approved the task waiver. Typically a partner, general counsel, or compliance officer.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent completing the task. Used for process improvement and future estimation accuracy.',
    `assigned_date` DATE COMMENT 'Date when the task was assigned to the responsible party. Marks the start of the task lifecycle for SLA tracking purposes.',
    `assigned_to_role` STRING COMMENT 'Functional role or job title of the person assigned to complete the task (e.g., Conflicts Analyst, Billing Coordinator, Practice Support Manager).',
    `blocking_reason` STRING COMMENT 'Explanation of why the task is blocked. Captures impediments such as missing client information, pending approvals, or external dependencies.',
    `completed_date` DATE COMMENT 'Actual date when the task was marked as complete. Null if task is still pending or in progress. Used for SLA performance measurement.',
    `completion_notes` STRING COMMENT 'Free-text notes entered by the task owner upon completion, documenting outcomes, issues encountered, or follow-up actions required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding task record was first created in the system. Audit field for record lifecycle tracking.',
    `document_reference` STRING COMMENT 'Reference identifier or path to supporting documents stored in the DMS (iManage Work or NetDocuments) related to this task, such as signed engagement letters or KYC documents.',
    `due_date` DATE COMMENT 'Target completion date for the onboarding task. Used for SLA compliance monitoring and escalation triggers.',
    `escalation_date` DATE COMMENT 'Date when the task was escalated. Used to track escalation frequency and resolution time at higher tiers.',
    `escalation_level` STRING COMMENT 'Current escalation tier for overdue or at-risk tasks. Drives notification routing to progressively senior stakeholders.. Valid values are `none|level_1|level_2|level_3`',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours required to complete the task. Used for resource planning and capacity management.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the task is mandatory for engagement approval and matter opening, or optional/conditional based on engagement characteristics.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the task record. Audit field for change tracking and data lineage.',
    `sla_status` STRING COMMENT 'Current SLA compliance status for the task. Indicates whether the task is on track, at risk of breach, or has exceeded the threshold.. Valid values are `within_sla|at_risk|breached|waived`',
    `sla_threshold_hours` STRING COMMENT 'Number of hours allocated for task completion per service level agreement. Used to calculate SLA breach risk and actual performance.',
    `system_reference_code` STRING COMMENT 'External system identifier linking this task to records in Elite 3E, Intapp Conflicts, or Microsoft Dynamics 365 for cross-system traceability.',
    `task_description` STRING COMMENT 'Detailed description of the onboarding task requirements, instructions, and any specific notes or context needed for completion.',
    `task_intake` BIGINT COMMENT 'FK to intake.intake_request.intake_request_id — Onboarding tasks are generated as part of the intake request workflow. Required for checklist management and SLA tracking.',
    `task_name` STRING COMMENT 'Human-readable name or title of the onboarding task, providing clear description of the action item for workflow participants.',
    `task_number` STRING COMMENT 'Business-facing unique identifier for the onboarding task, typically auto-generated in the format OBT-YYYYMMDD-NNNN for tracking and reference purposes.',
    `task_priority` STRING COMMENT 'Priority level assigned to the onboarding task, indicating urgency and sequencing within the overall onboarding checklist.. Valid values are `critical|high|medium|low`',
    `task_status` STRING COMMENT 'Current lifecycle status of the onboarding task. Tracks progression through the workflow from assignment through completion or waiver.. Valid values are `pending|in_progress|complete|waived|blocked|cancelled`',
    `task_type` STRING COMMENT 'Classification of the onboarding task type. Defines the nature of the action required to complete client onboarding and transition to active matter management. [ENUM-REF-CANDIDATE: kyc_document_collection|conflict_waiver_execution|engagement_letter_signature|matter_number_assignment|billing_setup|ethical_wall_configuration|dms_folder_creation|aml_screening|client_credit_check|retainer_collection — 10 candidates stripped; promote to reference product]',
    `waived_date` DATE COMMENT 'Date when the task waiver was approved. Used for audit trail and compliance reporting.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving a mandatory task. Required when task status is set to waived. Subject to compliance review.',
    CONSTRAINT pk_client_onboarding_task PRIMARY KEY(`client_onboarding_task_id`)
) COMMENT 'Transactional record representing an individual task or action item within the client onboarding checklist for a new engagement. Tracks task type (KYC document collection, conflict waiver execution, engagement letter signature, matter number assignment, billing setup, ethical wall configuration, DMS folder creation), assigned owner, due date, completion date, status (pending, in progress, complete, waived), blocking dependencies, and SLA threshold. Supports structured onboarding workflow management, task dependency resolution, and SLA compliance tracking from intake through matter handoff in Elite 3E.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`referral_source` (
    `referral_source_id` BIGINT COMMENT 'Unique identifier for the referral source record. Primary key.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this referral source record. Links to user/workforce master data for audit purposes.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the partner who originally established the referral source relationship. Used for origination credit and relationship attribution. Links to workforce/attorney master data.',
    `primary_referral_attorney_profile_id` BIGINT COMMENT 'Identifier of the partner or business development professional responsible for managing the relationship with this referral source. Links to workforce/attorney master data.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to intake.prospect. Business justification: Referral sources may be linked to specific prospects they referred. This links the referral source to the prospect for tracking referral effectiveness. This is an optional FK (nullable) as referral so',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this referral source record. Links to user/workforce master data for audit purposes.',
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
    `organization_name` STRING COMMENT 'Name of the organization or firm associated with the referral source, if applicable (e.g., referring law firm, consulting firm, client company).',
    `practice_area_focus` STRING COMMENT 'Primary practice area or legal specialty associated with referrals from this source (e.g., M&A, IP, Litigation). Used for targeting and relationship strategy.',
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

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`panel_appointment` (
    `panel_appointment_id` BIGINT COMMENT 'Unique identifier for the panel appointment record. Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Panel appointments must comply with firm policies on panel management, conflicts, and client acceptance criteria. Real process: policy-governed panel appointment approval and governance.',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Panel appointments may originate from engagement opportunities in the CRM pipeline. This links the panel appointment to the CRM opportunity, enabling tracking of which opportunities resulted in panel ',
    `guideline_id` BIGINT COMMENT 'Foreign key linking to billing.billing_guideline. Business justification: Panel appointments establish ongoing billing guidelines that apply to all matters under the panel relationship. Linking panel appointments to billing guidelines enables automated guideline inheritance',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Panel appointments require linking to executed panel agreements, rate cards, and service level agreements for billing compliance, scope verification, and renewal management. Essential for outside coun',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: Panel appointments may be formalized through Letters of Engagement. This links the panel appointment to the LOE, enabling tracking of which panel appointments were formalized through LOEs. This is an ',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this panel appointment record.',
    `panel_prospect_id` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Panel appointments are held with specific client organizations (prospects/clients). Links panel context to the entity.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Panel appointments reference agreed pricing models for panel work to ensure consistent billing across panel matters, volume discount application, and compliance with panel terms. Essential for panel m',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner who is the primary relationship owner and accountable for performance under this panel appointment.',
    `primary_prospect_id` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Panel appointments are held with specific client organizations that may enter as prospects. Required for panel-driven intake routing.',
    `profile_id` BIGINT COMMENT 'Reference to the client organization that granted this panel appointment. Links to the client master record in Elite 3E.',
    `prospect_id` BIGINT COMMENT 'FK to intake.prospect.prospect_id — Panel appointments are held with specific client organizations (prospects or existing clients). Links panel-driven intake volume to the client pipeline.',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to intake.rfp_submission. Business justification: Panel appointments often result from RFP wins. This links the panel appointment to the RFP submission. The existing rfp_reference (STRING) should be replaced with a proper FK to enable relational inte',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created this panel appointment record.',
    `appointment_date` DATE COMMENT 'The date on which the panel appointment became effective and the firm was formally authorized to receive instructions.',
    `appointment_notes` STRING COMMENT 'Free-text field for internal notes, special conditions, or additional context regarding this panel appointment that is relevant for matter intake and relationship management.',
    `conflict_check_required_flag` BOOLEAN COMMENT 'Indicates whether a full conflict check in Intapp Conflicts is required for each new matter under this panel, or whether the panel appointment itself constitutes pre-clearance for routine instructions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this panel appointment record was first created in the system.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount from standard rates that has been agreed for matters under this panel appointment (e.g., 10.00 for 10% discount). Null if no discount applies.',
    `dynamics_account_guid` STRING COMMENT 'The unique GUID of the corresponding account record in Microsoft Dynamics 365 CRM, enabling integration between the CRM pipeline and panel appointment tracking.',
    `elite_client_number` STRING COMMENT 'The client number in Elite 3E practice management system for the appointing client, enabling linkage between panel appointments and matter creation.',
    `exclusions` STRING COMMENT 'A description of any specific matter types, jurisdictions, or circumstances that are explicitly excluded from the scope of this panel appointment.',
    `expiry_date` DATE COMMENT 'The date on which the panel appointment is scheduled to expire or terminate, unless renewed. Null for open-ended appointments.',
    `geographic_scope` STRING COMMENT 'The geographic territories or jurisdictions covered by this panel appointment (e.g., Global, EMEA, United Kingdom, North America). May be comma-separated list of ISO 3166-1 alpha-3 country codes or region names.',
    `kyc_completed_date` DATE COMMENT 'The date on which KYC and AML due diligence was completed and approved for the appointing client in relation to this panel appointment.',
    `kyc_expiry_date` DATE COMMENT 'The date on which the current KYC clearance expires and must be refreshed to continue accepting instructions under this panel.',
    `kyc_status` STRING COMMENT 'The current status of Know Your Client due diligence and Anti-Money Laundering (AML) compliance checks for the appointing client organization in relation to this panel appointment.. Valid values are `not started|in progress|completed|expired|waived`',
    `last_report_submitted_date` DATE COMMENT 'The date on which the most recent performance or management information report was submitted to the appointing client for this panel.',
    `matter_type_scope` STRING COMMENT 'A description or comma-separated list of the specific matter types or transaction categories that are within scope for this panel appointment (e.g., Commercial Litigation, Employment Tribunal, Share Purchase Agreements).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this panel appointment record was last modified.',
    `next_report_due_date` DATE COMMENT 'The date on which the next scheduled performance or management information report is due to be submitted to the appointing client.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal performance review or renewal discussion with the appointing client.',
    `panel_category` STRING COMMENT 'The primary practice area or legal service category for which the firm has been appointed to the panel. [ENUM-REF-CANDIDATE: general counsel|litigation|mergers and acquisitions|regulatory|employment|intellectual property|real estate|tax|corporate|compliance|other — 11 candidates stripped; promote to reference product]',
    `panel_name` STRING COMMENT 'The official name or title of the legal panel or preferred supplier list (e.g., Global Litigation Panel 2024, EMEA Employment Law Panel).',
    `panel_reference_number` STRING COMMENT 'External reference number or code assigned by the appointing client to identify this panel appointment (e.g., clients procurement system reference).',
    `panel_status` STRING COMMENT 'Current lifecycle status of the panel appointment indicating whether the firm is authorized to receive instructions under this panel.. Valid values are `active|under review|suspended|expired|terminated`',
    `panel_tier` STRING COMMENT 'The tier or ranking level assigned by the appointing client within their panel structure, indicating priority or preferred status for instruction allocation.. Valid values are `tier 1|tier 2|tier 3|preferred|approved|other`',
    `practice_group` STRING COMMENT 'The internal practice group or department within the firm that is responsible for delivering services under this panel appointment.',
    `rate_card_reference` STRING COMMENT 'Reference identifier or version number of the agreed rate card or fee schedule that applies to matters instructed under this panel appointment.',
    `reporting_frequency` STRING COMMENT 'The frequency at which the firm is required to provide management information, performance reports, or spend analysis to the appointing client under this panel appointment.. Valid values are `monthly|quarterly|semi-annually|annually|ad hoc|none`',
    `review_cycle_months` STRING COMMENT 'The frequency in months at which the panel appointment is subject to performance review by the appointing client (e.g., 12 for annual review, 24 for biennial).',
    `termination_date` DATE COMMENT 'The actual date on which this panel appointment was terminated or withdrawn, if applicable. Null for active or expired appointments that were not formally terminated.',
    `termination_notice_days` STRING COMMENT 'The number of days advance notice required by either party to terminate this panel appointment, as specified in the panel terms.',
    `termination_reason` STRING COMMENT 'A description of the reason for termination if the panel appointment was ended before its natural expiry (e.g., Client restructure, Performance issues, Conflict of interest).',
    `volume_commitment_amount` DECIMAL(18,2) COMMENT 'The minimum annual or total fee volume (in the panel currency) that the appointing client has committed or projected for this panel appointment. Null if no commitment exists.',
    CONSTRAINT pk_panel_appointment PRIMARY KEY(`panel_appointment_id`)
) COMMENT 'Master record representing a formal legal panel or preferred supplier appointment under which the firm is pre-authorized to receive instructions from a client organization. Captures panel name, appointing client, panel category (general counsel, litigation, M&A, regulatory, employment), appointment and expiry dates, geographic scope, agreed rate card reference, volume commitment, review cycle, and panel status (active, under review, expired, terminated). Panel appointments are a primary driver of intake volume for large corporate and government clients — new matters arriving under panel terms bypass certain BD stages and flow directly into the intake request workflow.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`risk_action` (
    `risk_action_id` BIGINT COMMENT 'Unique identifier for this intake-action assignment record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the timekeeper or system user who created this intake-action assignment, typically the conflicts analyst or intake coordinator.',
    `mitigation_action_id` BIGINT COMMENT 'Foreign key linking to the specific risk mitigation action assigned to address risks identified in this intake request',
    `request_id` BIGINT COMMENT 'Foreign key linking to the intake request that triggered or requires this risk mitigation action',
    `action_priority` STRING COMMENT 'Priority level assigned to this mitigation action in the context of this intake request, based on intake urgency flag and risk severity.',
    `action_status` STRING COMMENT 'Current lifecycle status of this mitigation action in the context of this specific intake request. Tracks progression from assignment through completion.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent completing this mitigation action for this intake request, captured for performance tracking and future estimation.',
    `assigned_date` DATE COMMENT 'Date when this mitigation action was formally assigned to address risks identified in this intake request.',
    `assignment_notes` STRING COMMENT 'Context-specific notes explaining why this mitigation action was assigned to this intake request, including specific risk factors identified during intake screening.',
    `completion_date` DATE COMMENT 'Actual date when this mitigation action was completed for this intake request. Null if action is still in progress.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this intake-action assignment record was created.',
    `due_date` DATE COMMENT 'Target completion date for this mitigation action in the context of this intake request, driven by the intake urgency and target matter open date.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours required to complete this mitigation action for this specific intake request, used for resource planning and intake timeline forecasting.',
    CONSTRAINT pk_risk_action PRIMARY KEY(`risk_action_id`)
) COMMENT 'This association product represents the assignment of risk mitigation actions to specific intake requests in the new business intake lifecycle. It captures the operational linkage between intake requests that trigger risk concerns (conflicts, sanctions, reputational issues) and the specific mitigation actions assigned to address those concerns. Each record links one intake request to one risk mitigation action with attributes that track the assignment context, timing, priority, effort, and completion status specific to that intake-action pairing.. Existence Justification: In legal firm intake operations, a single intake request can trigger multiple distinct risk mitigation actions (conflict waiver, enhanced KYC, sanctions clearance, ethical wall implementation, reputational review) based on the specific risk profile of the proposed matter. Conversely, a single mitigation action template (e.g., implementing an ethical wall protocol) can be assigned to address risks identified across multiple concurrent intake requests involving related parties or overlapping conflicts. The business actively manages these assignments as operational records with timing, priority, and completion tracking specific to each intake-action pairing.';

CREATE OR REPLACE TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` (
    `opportunity_risk_assessment_id` BIGINT COMMENT 'Unique identifier for this opportunity risk assessment relationship record. Primary key.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to the formal risk assessment record conducted for this opportunity',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to the engagement opportunity being evaluated for risk',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the senior timekeeper or partner who reviewed and approved this risk assessment in the context of this specific opportunity.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key to the risk assessment record',
    `assessment_date` DATE COMMENT 'The date this specific risk assessment was conducted for this opportunity. Tracks when in the opportunity lifecycle the assessment occurred (initial screening, detailed due diligence, pre-engagement final review).',
    `assessment_stage` STRING COMMENT 'The stage in the opportunity lifecycle at which this risk assessment was conducted. Supports tracking multiple assessments over the opportunity progression.',
    `assessment_status` STRING COMMENT 'Current lifecycle state of this risk assessment in the context of this opportunity. Tracks progression through the approval workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity risk assessment relationship record was first created in the system.',
    `inherent_risk_score` DECIMAL(18,2) COMMENT 'Numerical composite score representing the unmitigated risk level for this specific opportunity at the time of assessment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity risk assessment relationship record was most recently modified.',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Numerical composite score representing the remaining risk level after controls for this specific opportunity at the time of assessment.',
    `within_appetite` BOOLEAN COMMENT 'Indicates whether the residual risk score for this opportunity falls within the firms defined risk appetite threshold at the time of assessment.',
    CONSTRAINT pk_opportunity_risk_assessment PRIMARY KEY(`opportunity_risk_assessment_id`)
) COMMENT 'This association product represents the formal risk evaluation performed for a specific engagement opportunity during the business development lifecycle. It captures the point-in-time risk assessment conducted as part of client acceptance, conflict clearance, and engagement approval processes. Each record links one engagement opportunity to one risk assessment with attributes that exist only in the context of this evaluation relationship.. Existence Justification: In legal services business development, engagement opportunities undergo multiple formal risk assessments at different stages of the pipeline (initial screening at qualification, detailed due diligence during proposal, pre-engagement final review before LOE execution). A single comprehensive risk assessment can also evaluate multiple related opportunities simultaneously (e.g., panel appointment covering multiple anticipated matters, multi-jurisdiction engagement with separate opportunity records). The business actively manages these assessment relationships with stage-specific scores, approval workflows, and reviewer assignments.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_primary_prospect_id` FOREIGN KEY (`primary_prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ADD CONSTRAINT `fk_intake_rfp_submission_rfp_prospect_id` FOREIGN KEY (`rfp_prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_pitch_rfp` FOREIGN KEY (`pitch_rfp`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_pitch_rfp_submission` FOREIGN KEY (`pitch_rfp_submission`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_pitch_rfp_submission_id` FOREIGN KEY (`pitch_rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`pitch` ADD CONSTRAINT `fk_intake_pitch_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_engagement_opportunity_prospect` FOREIGN KEY (`engagement_opportunity_prospect`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_engagement_prospect` FOREIGN KEY (`engagement_prospect`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_engagement_prospect_id` FOREIGN KEY (`engagement_prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_pitch_id` FOREIGN KEY (`pitch_id`) REFERENCES `legal_ecm`.`intake`.`pitch`(`pitch_id`);
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ADD CONSTRAINT `fk_intake_engagement_opportunity_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`request` ADD CONSTRAINT `fk_intake_request_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ADD CONSTRAINT `fk_intake_conflict_search_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_conflict_search_id` FOREIGN KEY (`conflict_search_id`) REFERENCES `legal_ecm`.`intake`.`conflict_search`(`conflict_search_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_intake_party_id` FOREIGN KEY (`intake_party_id`) REFERENCES `legal_ecm`.`intake`.`intake_party`(`intake_party_id`);
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ADD CONSTRAINT `fk_intake_conflict_hit_primary_conflict_search_id` FOREIGN KEY (`primary_conflict_search_id`) REFERENCES `legal_ecm`.`intake`.`conflict_search`(`conflict_search_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ADD CONSTRAINT `fk_intake_intake_party_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_intake_party_id` FOREIGN KEY (`intake_party_id`) REFERENCES `legal_ecm`.`intake`.`intake_party`(`intake_party_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_primary_intake_party_id` FOREIGN KEY (`primary_intake_party_id`) REFERENCES `legal_ecm`.`intake`.`intake_party`(`intake_party_id`);
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ADD CONSTRAINT `fk_intake_kyc_screening_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_intake_engagement_opportunity_id` FOREIGN KEY (`intake_engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ADD CONSTRAINT `fk_intake_intake_engagement_scope_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_intake_engagement_scope_id` FOREIGN KEY (`intake_engagement_scope_id`) REFERENCES `legal_ecm`.`intake`.`intake_engagement_scope`(`intake_engagement_scope_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ADD CONSTRAINT `fk_intake_intake_fee_arrangement_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ADD CONSTRAINT `fk_intake_letter_of_engagement_superseded_by_loe_letter_of_engagement_id` FOREIGN KEY (`superseded_by_loe_letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ADD CONSTRAINT `fk_intake_matter_opening_request_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_origination_engagement_opportunity_id` FOREIGN KEY (`origination_engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_panel_appointment_id` FOREIGN KEY (`panel_appointment_id`) REFERENCES `legal_ecm`.`intake`.`panel_appointment`(`panel_appointment_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_pitch_id` FOREIGN KEY (`pitch_id`) REFERENCES `legal_ecm`.`intake`.`pitch`(`pitch_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ADD CONSTRAINT `fk_intake_origination_credit_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ADD CONSTRAINT `fk_intake_client_onboarding_task_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ADD CONSTRAINT `fk_intake_referral_source_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_letter_of_engagement_id` FOREIGN KEY (`letter_of_engagement_id`) REFERENCES `legal_ecm`.`intake`.`letter_of_engagement`(`letter_of_engagement_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_panel_prospect_id` FOREIGN KEY (`panel_prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_primary_prospect_id` FOREIGN KEY (`primary_prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `legal_ecm`.`intake`.`prospect`(`prospect_id`);
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ADD CONSTRAINT `fk_intake_panel_appointment_rfp_submission_id` FOREIGN KEY (`rfp_submission_id`) REFERENCES `legal_ecm`.`intake`.`rfp_submission`(`rfp_submission_id`);
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ADD CONSTRAINT `fk_intake_risk_action_request_id` FOREIGN KEY (`request_id`) REFERENCES `legal_ecm`.`intake`.`request`(`request_id`);
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ADD CONSTRAINT `fk_intake_opportunity_risk_assessment_engagement_opportunity_id` FOREIGN KEY (`engagement_opportunity_id`) REFERENCES `legal_ecm`.`intake`.`engagement_opportunity`(`engagement_opportunity_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`intake` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `legal_ecm`.`intake` SET TAGS ('dbx_domain' = 'intake');
ALTER TABLE `legal_ecm`.`intake`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`prospect` SET TAGS ('dbx_subdomain' = 'client_acquisition');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Attorney Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `prospect_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Owner Attorney Identifier (ID)');
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
ALTER TABLE `legal_ecm`.`intake`.`prospect` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
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
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` SET TAGS ('dbx_subdomain' = 'client_acquisition');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Submission ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Pitch Lead ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organisation ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `reputational_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Reputational Risk Flag Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Matter ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `legal_ecm`.`intake`.`rfp_submission` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
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
ALTER TABLE `legal_ecm`.`intake`.`pitch` SET TAGS ('dbx_subdomain' = 'client_acquisition');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_id` SET TAGS ('dbx_business_glossary_term' = 'Pitch Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Partner Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Letter Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Pitch Deck Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_proposal_legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `pitch_rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `legal_ecm`.`intake`.`pitch` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
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
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` SET TAGS ('dbx_subdomain' = 'client_acquisition');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity ID');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `engagement_prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `primary_engagement_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`engagement_opportunity` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `legal_ecm`.`intake`.`request` SET TAGS ('dbx_subdomain' = 'engagement_setup');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Attorney ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Existing Client ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `request_approved_by_partner_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `request_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `requesting_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Timekeeper ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Source Request for Proposal (RFP) ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_client_name` SET TAGS ('dbx_business_glossary_term' = 'Proposed Client Name');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_client_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Proposed Fee Arrangement Type (Alternative Fee Arrangement - AFA)');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_matter_number` SET TAGS ('dbx_business_glossary_term' = 'Proposed Matter Number');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `proposed_matter_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}(-[0-9]{3})?$');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `related_parties` SET TAGS ('dbx_business_glossary_term' = 'Related Parties');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `related_parties` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `target_matter_open_date` SET TAGS ('dbx_business_glossary_term' = 'Target Matter Open Date');
ALTER TABLE `legal_ecm`.`intake`.`request` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_business_glossary_term' = 'Urgency Flag');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `conflict_search_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Identifier');
ALTER TABLE `legal_ecm`.`intake`.`conflict_search` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Searcher Employee ID');
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
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `conflict_hit_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Hit Identifier');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `intake_party_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Conflicted Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `primary_conflict_search_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Search Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `tertiary_conflict_escalated_to_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `assigned_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer Name');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Hit Disposition');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'cleared_no_conflict|cleared_with_waiver|false_positive|requires_ethical_wall|declined|pending');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `escalated_to_name` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Name');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `ethical_wall_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `hit_identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hit Identified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `hit_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Hit Sequence Number');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `hit_severity` SET TAGS ('dbx_business_glossary_term' = 'Hit Severity');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `hit_severity` SET TAGS ('dbx_value_regex' = 'actual|potential|waivable|informational');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `hit_status` SET TAGS ('dbx_business_glossary_term' = 'Hit Status');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `hit_status` SET TAGS ('dbx_value_regex' = 'pending_review|under_review|cleared|escalated|requires_waiver|declined');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Match Type');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'exact|fuzzy|phonetic|alias|dba|former_name');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `matched_matter_description` SET TAGS ('dbx_business_glossary_term' = 'Matched Matter Description');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `matched_matter_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `responsible_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner Name');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `review_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `review_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Started Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `source_system_hit_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Hit Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `waiver_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Obtained Flag');
ALTER TABLE `legal_ecm`.`intake`.`conflict_hit` ALTER COLUMN `waiver_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` SET TAGS ('dbx_subdomain' = 'engagement_setup');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `intake_party_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Party Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Sanctions Screening Result Id (Foreign Key)');
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
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `parent_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Name');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `parent_entity_name` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `ultimate_parent_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Entity Name');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `ultimate_parent_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`intake_party` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `kyc_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Screening ID');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `intake_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake ID');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`kyc_screening` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Sanctions Screening Result Id (Foreign Key)');
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
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` SET TAGS ('dbx_subdomain' = 'engagement_setup');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `intake_engagement_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Engagement Scope Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `intake_engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Partner Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `client_responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Client Responsibilities');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `conflict_check_reference` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Reference');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|conditional|declined');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `engagement_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Engagement Duration in Months');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `estimated_associate_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Associate Hours');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `estimated_paralegal_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Paralegal Hours');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `estimated_partner_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Partner Hours');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `estimated_start_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Start Date');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `estimated_total_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Hours');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `excluded_services` SET TAGS ('dbx_business_glossary_term' = 'Excluded Services');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `included_services` SET TAGS ('dbx_business_glossary_term' = 'Included Services');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `intake_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `key_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Key Assumptions');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `key_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Key Deliverables');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `matter_type_code` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Code');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `practice_area_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Code');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `risk_factors` SET TAGS ('dbx_business_glossary_term' = 'Risk Factors');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `scope_change_protocol` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Protocol');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `scope_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Scope Reference Number');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `scope_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6}-SC[0-9]{2}$');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Scope Status');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `scope_version_number` SET TAGS ('dbx_business_glossary_term' = 'Scope Version Number');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `staffing_plan` SET TAGS ('dbx_business_glossary_term' = 'Staffing Plan');
ALTER TABLE `legal_ecm`.`intake`.`intake_engagement_scope` ALTER COLUMN `technology_tools_required` SET TAGS ('dbx_business_glossary_term' = 'Technology Tools Required');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` SET TAGS ('dbx_subdomain' = 'engagement_setup');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `intake_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Fee Arrangement ID');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `billing_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `client_engagement_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope ID');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile ID');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `agreed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Fee Amount');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Number');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Status');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_value_regex' = 'draft|proposed|negotiating|approved|rejected|superseded');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|completion|on_demand');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `blended_rate` SET TAGS ('dbx_business_glossary_term' = 'Blended Hourly Rate');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Fee Percentage');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `disbursement_handling` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Handling');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `disbursement_handling` SET TAGS ('dbx_value_regex' = 'included|pass_through|marked_up');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `is_outside_counsel_guideline_compliant` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline (OCG) Compliant Flag');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `ledes_format_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Format Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `loe_reference` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Reference');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `minimum_fee_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Commitment');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `negotiation_notes` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Notes');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `rate_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Reference');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `retainer_period` SET TAGS ('dbx_business_glossary_term' = 'Retainer Period');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `retainer_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `success_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Success Criteria Description');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `success_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Success Fee Amount');
ALTER TABLE `legal_ecm`.`intake`.`intake_fee_arrangement` ALTER COLUMN `utbms_task_code_required` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` SET TAGS ('dbx_subdomain' = 'engagement_setup');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Loe Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `outside_counsel_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Outside Counsel Guideline (OCG) ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `primary_letter_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `superseded_by_loe_letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Letter of Engagement (LOE) ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `acceptance_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Deadline Date');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|upon_completion|as_incurred');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `client_signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Email Address');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `client_signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `client_signatory_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `client_signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Name');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `client_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`letter_of_engagement` ALTER COLUMN `client_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Client Signatory Title');
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
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` SET TAGS ('dbx_subdomain' = 'engagement_setup');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `matter_opening_request_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Opening Request ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Attorney ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `billing_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Elite 3E Matter ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `originating_attorney_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Attorney ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `primary_matter_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Submission Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `tertiary_matter_approved_by_attorney_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Attorney ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`matter_opening_request` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` SET TAGS ('dbx_subdomain' = 'engagement_setup');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `origination_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Credit Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `billing_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `origination_engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `panel_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Appointment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `pitch_id` SET TAGS ('dbx_business_glossary_term' = 'Pitch Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `primary_origination_credited_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Credited Timekeeper Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `legal_ecm`.`intake`.`origination_credit` ALTER COLUMN `credited_practice_group` SET TAGS ('dbx_business_glossary_term' = 'Credited Practice Group');
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
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` SET TAGS ('dbx_subdomain' = 'engagement_setup');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `client_onboarding_task_id` SET TAGS ('dbx_business_glossary_term' = 'Client Onboarding Task ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Blocking Dependency Task ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `completed_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Completed By User ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `completed_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `completed_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `escalated_to_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To User ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `escalated_to_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `escalated_to_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `waived_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Waived By User ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `waived_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `waived_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `assigned_to_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Role');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|level_1|level_2|level_3');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'within_sla|at_risk|breached|waived');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `sla_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Threshold Hours');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `system_reference_code` SET TAGS ('dbx_business_glossary_term' = 'System Reference ID');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|complete|waived|blocked|cancelled');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `waived_date` SET TAGS ('dbx_business_glossary_term' = 'Waived Date');
ALTER TABLE `legal_ecm`.`intake`.`client_onboarding_task` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` SET TAGS ('dbx_subdomain' = 'client_acquisition');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `referral_source_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Source ID');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User ID');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `primary_referral_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Owner ID');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Organization Name');
ALTER TABLE `legal_ecm`.`intake`.`referral_source` ALTER COLUMN `practice_area_focus` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Practice Area Focus');
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
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` SET TAGS ('dbx_subdomain' = 'client_acquisition');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `panel_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Appointment ID');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Agreement Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner ID');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Appointing Client ID');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Submission Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `appointment_notes` SET TAGS ('dbx_business_glossary_term' = 'Appointment Notes');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `conflict_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Required Flag');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `dynamics_account_guid` SET TAGS ('dbx_business_glossary_term' = 'Microsoft Dynamics 365 Account Globally Unique Identifier (GUID)');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `elite_client_number` SET TAGS ('dbx_business_glossary_term' = 'Elite 3E Client Number');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `kyc_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Completed Date');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `kyc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Expiry Date');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Status');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'not started|in progress|completed|expired|waived');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `last_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Submitted Date');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `matter_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Scope');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `panel_category` SET TAGS ('dbx_business_glossary_term' = 'Panel Category');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `panel_name` SET TAGS ('dbx_business_glossary_term' = 'Panel Name');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `panel_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Panel Reference Number');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Panel Status');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'active|under review|suspended|expired|terminated');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `panel_tier` SET TAGS ('dbx_business_glossary_term' = 'Panel Tier');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `panel_tier` SET TAGS ('dbx_value_regex' = 'tier 1|tier 2|tier 3|preferred|approved|other');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `practice_group` SET TAGS ('dbx_business_glossary_term' = 'Practice Group');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Reference');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|ad hoc|none');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Months');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `volume_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Amount');
ALTER TABLE `legal_ecm`.`intake`.`panel_appointment` ALTER COLUMN `volume_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` SET TAGS ('dbx_association_edges' = 'intake.intake_request,risk.risk_mitigation_action');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `risk_action_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Risk Action ID');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Attorney Profile ID');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `mitigation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Risk Action - Risk Mitigation Action Id');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Risk Action - Intake Request Id');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `action_priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `legal_ecm`.`intake`.`risk_action` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` SET TAGS ('dbx_association_edges' = 'intake.engagement_opportunity,risk.risk_assessment');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `opportunity_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Risk Assessment ID');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Risk Assessment - Risk Assessment Id');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Risk Assessment - Engagement Opportunity Id');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Attorney Profile ID');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `assessment_stage` SET TAGS ('dbx_business_glossary_term' = 'Assessment Stage');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `legal_ecm`.`intake`.`opportunity_risk_assessment` ALTER COLUMN `within_appetite` SET TAGS ('dbx_business_glossary_term' = 'Within Appetite');
