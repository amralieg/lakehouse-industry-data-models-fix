-- Schema for Domain: talent | Business: Media Broadcasting | Version: v1_mvm
-- Generated on: 2026-05-08 19:23:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `media_broadcasting_ecm`.`talent` COMMENT 'Manages all on-screen and off-screen talent relationships — actors, directors, writers, producers, hosts, correspondents, and crew. Tracks talent contracts, guild affiliations (SAG-AFTRA, WGA, DGA), residual payment eligibility, exclusivity clauses, compensation structures, usage rights, appearance schedules, and credit attribution. Serves as the authoritative source for talent identity referenced by production, rights, and royalty workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` (
    `talent_profile_id` BIGINT COMMENT 'Unique identifier for the talent profile record. Primary key for the talent master entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Talent profiles must map to employing legal entity for tax withholding jurisdiction, I-9 compliance, payroll processing, and work authorization tracking in multi-entity broadcasters.',
    `talent_agency_id` BIGINT COMMENT 'FK to talent.talent_agency',
    `biometric_consent_flag` BOOLEAN COMMENT 'Indicates whether the talent has provided consent for collection and use of biometric data (facial recognition, voice prints) for digital effects, deepfake prevention, and AI training. Required for GDPR and CCPA compliance.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the talent has opted out of the sale or sharing of their personal information under CCPA. Required for California-based talent or productions.',
    `clearance_expiration_date` DATE COMMENT 'The date when the talents current clearance status expires and requires renewal. Used for compliance tracking and production eligibility verification.',
    `clearance_status` STRING COMMENT 'The current clearance status of the talent for production work. Indicates whether background checks, work authorization, insurance verification, and legal clearances are complete and current.. Valid values are `cleared|pending|restricted|blocked|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the talent profile record was first created in the system. Used for audit trail and data lineage tracking.',
    `date_of_birth` DATE COMMENT 'The talents date of birth. Required for age verification, child labor law compliance (COPPA), insurance underwriting, and residual payment calculations.',
    `email_address` STRING COMMENT 'The primary email address for talent communication, contract delivery, and digital correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `exclusivity_clause_flag` BOOLEAN COMMENT 'Indicates whether the talent is currently bound by an exclusivity clause that restricts their ability to work with competing networks, studios, or brands. Used for conflict checking during casting and booking.',
    `gdpr_consent_status` STRING COMMENT 'The current status of the talents GDPR consent for data processing. Tracks whether the talent has provided, withdrawn, or is pending consent for personal data usage under EU regulations.. Valid values are `consented|withdrawn|not_applicable|pending`',
    `gender_identity` STRING COMMENT 'The talents self-identified gender. Used for diversity reporting, casting analytics, and compliance with equal opportunity regulations.. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `imdb_identifier` STRING COMMENT 'The talents unique identifier in the Internet Movie Database (IMDb). Used for cross-referencing filmography, public profile linking, and industry data integration.. Valid values are `^nm[0-9]{7,8}$`',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether the talent is currently covered by production insurance (liability, workers compensation, errors and omissions). Required for on-set work authorization.',
    `insurance_policy_number` STRING COMMENT 'The policy number for the talents production insurance coverage. Used for claims processing and certificate of insurance verification.',
    `isni_code` STRING COMMENT 'The International Standard Name Identifier (ISNI) for the talent. A globally unique identifier for creators used in rights management and royalty distribution systems.. Valid values are `^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{3}[0-9X]$`',
    `legal_name` STRING COMMENT 'The full legal name of the talent as it appears on official documents and contracts. Used for contract execution, payroll, and legal compliance.',
    `nationality` STRING COMMENT 'The talents nationality represented as a 3-letter ISO country code. Used for work authorization, tax treaty eligibility, and international co-production compliance.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special requirements, or contextual information about the talent. Used for casting notes, production preferences, and internal communication.',
    `phone_number` STRING COMMENT 'The primary contact phone number for the talent. Used for production scheduling, emergency contact, and direct communication.',
    `primary_language` STRING COMMENT 'The talents primary working language represented as a 2-letter ISO language code. Used for casting, dubbing, and localization workflows.. Valid values are `^[a-z]{2}$`',
    `profile_status` STRING COMMENT 'The current lifecycle status of the talent profile. Determines availability for casting, contract execution, and system access.. Valid values are `active|inactive|suspended|retired|deceased`',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of their work in syndication, streaming, or international distribution. Determined by union status and contract terms.',
    `stage_name` STRING COMMENT 'The professional or stage name used by the talent for public appearances, credits, and marketing materials. May differ from legal name.',
    `talent_tier` STRING COMMENT 'The classification tier of the talent based on industry recognition, box office draw, and compensation level. Used for budgeting, marketing strategy, and billing rate determination.. Valid values are `a_list|b_list|c_list|emerging|supporting|background`',
    `talent_type` STRING COMMENT 'The primary professional category or role type of the talent. Determines applicable guild rules, contract templates, and credit attribution standards. [ENUM-REF-CANDIDATE: actor|director|writer|producer|host|correspondent|crew|voice_artist|composer|cinematographer — 10 candidates stripped; promote to reference product]',
    `tax_id_number` STRING COMMENT 'The talents tax identification number (SSN, EIN, or international equivalent). Required for payroll processing, tax withholding, and IRS 1099 reporting.',
    `union_affiliation` STRING COMMENT 'The primary labor union or guild affiliation of the talent. Determines contract terms, minimum compensation, residual eligibility, and working conditions.. Valid values are `sag_aftra|wga|dga|iatse|non_union|multiple`',
    `union_member_number` STRING COMMENT 'The talents membership identifier within their primary union or guild. Required for residual payment processing and contract compliance verification.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the talent profile record was last modified. Used for change tracking and data freshness verification.',
    `work_authorization_status` STRING COMMENT 'The talents current work authorization status in the primary production jurisdiction. Determines eligibility for employment and production participation.. Valid values are `citizen|permanent_resident|work_visa|pending|expired`',
    `work_visa_expiration_date` DATE COMMENT 'The expiration date of the talents work visa. Critical for production scheduling and compliance with immigration regulations.',
    `work_visa_type` STRING COMMENT 'The specific type of work visa held by the talent (e.g., O-1, P-1, H-1B). Used for compliance tracking and production planning for international talent.',
    CONSTRAINT pk_talent_profile PRIMARY KEY(`talent_profile_id`)
) COMMENT 'Master identity record for all on-screen and off-screen talent — actors, directors, writers, producers, hosts, correspondents, crew, and voice artists. Stores legal name, stage name, date of birth, nationality, gender identity, primary language, union membership references, talent tier classification, representation agency references, IMDb/ISNI identifiers, biometric consent flags, data privacy status (GDPR/CCPA), clearance status, and active/inactive lifecycle state. Serves as the authoritative SSOT for talent identity referenced by production, rights, royalty, and scheduling workflows across the enterprise.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` (
    `guild_affiliation_id` BIGINT COMMENT 'Unique identifier for the guild affiliation record. Primary key.',
    `cba_rate_card_id` BIGINT COMMENT 'Foreign key linking to talent.cba_rate_card. Business justification: guild_affiliation.cba_version is a denormalized STRING field referencing the applicable Collective Bargaining Agreement version. cba_rate_card is the authoritative reference table for CBA versions, ra',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Guild pension and health contributions require specific GL account mapping for regulatory remittance, union compliance reporting, and audit trail documentation mandated by CBAs.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Guild affiliations must comply with specific labor regulations governing union membership, dues collection, benefits eligibility, and collective bargaining agreement terms. Provides direct link to reg',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, crew member) who holds this guild membership.',
    `cba_effective_date` DATE COMMENT 'Date when the current collective bargaining agreement became effective for this membership.',
    `cba_expiration_date` DATE COMMENT 'Date when the current collective bargaining agreement expires. Used to track contract renewal cycles and potential rate changes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this guild affiliation record was first created in the system.',
    `dues_payment_status` STRING COMMENT 'Current status of membership dues payment obligations. Current (all dues paid up to date), overdue (payment past due but within grace period), delinquent (significantly past due, may affect standing), exempt (not required to pay dues), waived (dues forgiven by guild).. Valid values are `current|overdue|delinquent|exempt|waived`',
    `guild_code` STRING COMMENT 'Standardized code identifying the entertainment industry guild or union. SAG-AFTRA (Screen Actors Guild - American Federation of Television and Radio Artists), WGA (Writers Guild of America), DGA (Directors Guild of America), IATSE (International Alliance of Theatrical Stage Employees), AFM (American Federation of Musicians), BECTU (Broadcasting Entertainment Communications and Theatre Union - UK), ACTRA (Alliance of Canadian Cinema Television and Radio Artists). [ENUM-REF-CANDIDATE: SAG-AFTRA|WGA|DGA|IATSE|AFM|BECTU|ACTRA|OTHER — 8 candidates stripped; promote to reference product]',
    `guild_name` STRING COMMENT 'Full legal name of the guild or union organization.',
    `health_benefits_eligible_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible for guild-provided health insurance benefits based on this membership and earnings thresholds. True if eligible, false otherwise.',
    `join_date` DATE COMMENT 'Date when the talent officially became a member of this guild. Used to determine seniority and eligibility for certain benefits.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction or country where this guild membership is registered and governed. USA (United States), CAN (Canada), GBR (United Kingdom), AUS (Australia), NZL (New Zealand), IRL (Ireland). [ENUM-REF-CANDIDATE: USA|CAN|GBR|AUS|NZL|IRL|OTHER — 7 candidates stripped; promote to reference product]',
    `last_dues_payment_date` DATE COMMENT 'Date of the most recent membership dues payment received by the guild.',
    `local_chapter` STRING COMMENT 'Local chapter, branch, or regional division of the guild to which this membership is assigned. Used for regional governance and event coordination.',
    `membership_number` STRING COMMENT 'Unique membership identifier assigned by the guild to the talent member. Required for residual payment processing and production compliance verification.',
    `membership_status` STRING COMMENT 'Current standing of the talent within the guild. Good standing (active member in compliance), suspended (temporarily barred due to dues or violations), resigned (voluntarily terminated membership), expelled (involuntarily removed), inactive (not currently active but not terminated), pending (application under review).. Valid values are `good_standing|suspended|resigned|expelled|inactive|pending`',
    `membership_tier` STRING COMMENT 'Classification of membership level within the guild. Full member (standard active membership with full benefits), fi-core (financial core member with limited participation), apprentice (trainee or provisional member), honorary (recognition membership), lifetime (permanent membership status), emeritus (retired member with recognition).. Valid values are `full_member|fi_core|apprentice|honorary|lifetime|emeritus`',
    `next_dues_payment_date` DATE COMMENT 'Date when the next membership dues payment is due.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or remarks about this guild membership. May include information about membership restrictions, special accommodations, or historical context.',
    `pension_eligible_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible for guild pension plan contributions and benefits. True if eligible, false otherwise.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this guild membership makes the talent eligible to receive residual payments for reuse of their work. True if eligible, false otherwise. Critical for royalty calculation workflows.',
    `termination_date` DATE COMMENT 'Date when the guild membership ended, whether through resignation, expulsion, or other termination. Null for active memberships.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this guild affiliation record was last modified in the system.',
    `verification_date` DATE COMMENT 'Date when the guild membership status was last verified with the guild organization. Used to ensure data accuracy for production compliance.',
    `verification_method` STRING COMMENT 'Method used to verify the guild membership status. API (automated guild system integration), manual (direct guild contact), document (membership card or certificate scan), self-reported (talent declaration), third-party (verification service).. Valid values are `api|manual|document|self_reported|third_party`',
    CONSTRAINT pk_guild_affiliation PRIMARY KEY(`guild_affiliation_id`)
) COMMENT 'Tracks each talents formal membership and standing within entertainment industry guilds and unions — SAG-AFTRA, WGA (Writers Guild of America), DGA (Directors Guild of America), IATSE, AFM (American Federation of Musicians), and international equivalents (BECTU, ACTRA). Records membership number, guild code, membership tier (full member, fi-core, apprentice), join date, current standing (good standing, suspended, resigned), dues payment status, and applicable collective bargaining agreement (CBA) version. Critical for residual eligibility determination and production compliance.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique identifier for the talent contract record. Primary key for the talent contract entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Talent contracts in co-productions, distribution deals, or partner-supplied talent reference master partner agreements for terms inheritance, compliance verification, and dispute resolution. Essential',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Talent contracts require billing accounts for payment processing, AP/AR reconciliation, tax reporting, and financial audit trails. Standard production finance practice links contracts to billing accou',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Talent contracts reference content ratings for age-appropriate casting, union restrictions on minors, and compensation adjustments based on content maturity. Casting directors verify rating constraint',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Talent costs must be allocated to cost centers for departmental P&L, overhead allocation, EBITDA reporting, and management accountability. Production companies track talent spend by cost center (Drama',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Talent contracts often include demographic performance guarantees (e.g., guaranteed A18-49 rating). Contract terms are structured around expected demographic delivery. Talent deals include demo-specif',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: contract.guild_affiliation is a denormalized STRING field capturing the governing guild. Replacing it with a FK to guild_affiliation normalizes this reference, enabling JOIN to the authoritative guild',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Contracts are executed by specific legal entities for liability assignment, tax treatment determination, intercompany eliminations, and consolidated financial statement preparation in broadcasting gro',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Talent contracts are executed with production partners (studios, networks, streamers) as the contracting entity. Essential for contract administration, payment routing, rights clearance, and partner r',
    `project_id` BIGINT COMMENT 'Reference to the production (series, film, episode, special) for which this talent is contracted. Nullable for overall deals and first-look deals not tied to a specific production.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Talent contracts must comply with specific regulatory obligations including union rules, labor laws, minimum compensation requirements, and content regulations. Essential for contract compliance audit',
    `representation_agreement_id` BIGINT COMMENT 'Foreign key linking to talent.representation_agreement. Business justification: contract contains denormalized fields talent_representative_agency (STRING) and talent_representative_name (STRING) that duplicate data captured on representation_agreement (agency legal name via tale',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-scoped talent contracts are standard in episodic TV production. Finance production budget allocation, residual eligibility windows, and guild reporting all require season-level contract scoping',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Talent contracts for episodic content are series-level agreements with episode guarantees, option periods, and multi-season terms. Fundamental to TV production contracting and long-form content busine',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) engaged under this contract.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Film and standalone content talent contracts must be linked to a specific title for rights clearance, residual tracking, and P&A budget reporting. contract has series_id for episodic content but no ti',
    `amendment_count` STRING COMMENT 'The total number of formal amendments made to this contract since initial execution. Tracks contract modification history.',
    `backend_participation_percentage` DECIMAL(18,2) COMMENT 'The percentage of net profits, adjusted gross, or other revenue streams the talent is entitled to receive after recoupment of production costs. Common for above-the-line talent.',
    `backend_participation_type` STRING COMMENT 'The revenue calculation basis for backend participation. Net profits are after all costs; adjusted gross is after specific deductions; gross receipts are from first dollar. None indicates no backend participation.. Valid values are `net_profits|adjusted_gross|gross_receipts|none`',
    `base_compensation_amount` DECIMAL(18,2) COMMENT 'The guaranteed base fee or salary payable to the talent for services rendered under this contract, excluding bonuses, backend participation, and residuals.',
    `billing_credit_position` STRING COMMENT 'The contractually specified position and format of the talents on-screen credit (e.g., First Position Main Title, Shared Card, Single Card, Above the Title). Critical for talent reputation and guild compliance.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the base compensation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `compensation_structure` STRING COMMENT 'The payment model for the base compensation. Flat fee is a single lump sum; per-episode is paid per episode produced; weekly/annual/day/hourly rates define periodic payment schedules.. Valid values are `flat_fee|per_episode|weekly_rate|annual_salary|day_rate|hourly_rate`',
    `contract_number` STRING COMMENT 'Business identifier for the contract, typically assigned by legal or business affairs. Used for external reference and tracking.',
    `contract_status` STRING COMMENT 'Current stage of the contract in its lifecycle. Deal memo represents initial short-form agreement; countersigned indicates mutual acceptance; long-form executed is the final detailed contract; amended reflects modifications; suspended indicates temporary hold; terminated is early cancellation; expired is natural end. [ENUM-REF-CANDIDATE: deal_memo|countersigned|long_form_executed|amended|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the talent engagement type. Series regular deals cover multi-episode commitments; episodic guest agreements are single or limited appearances; overall deals provide exclusive services across multiple projects; first-look deals grant priority rights to talent-developed content; crew contracts cover technical and production staff; talent holding deals reserve talent availability; development deals fund content creation. [ENUM-REF-CANDIDATE: series_regular|episodic_guest|overall_deal|first_look_deal|crew_contract|talent_holding_deal|development_deal — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was first created in the system.',
    `credit_placement_requirements` STRING COMMENT 'Detailed contractual requirements for credit placement, including main title vs end credits, paid advertising inclusion, promotional materials, and any special formatting or adjacency requirements.',
    `credit_size_percentage` DECIMAL(18,2) COMMENT 'The minimum size of the talents on-screen credit as a percentage of the title or other reference credit size. Null if not contractually specified.',
    `document_reference_uri` STRING COMMENT 'The storage location or document management system URI for the executed contract document and all amendments. Used for legal reference and audit.',
    `effective_end_date` DATE COMMENT 'The date on which the contract expires or the engagement period ends. Nullable for open-ended overall deals or holding deals with option-based extensions.',
    `effective_start_date` DATE COMMENT 'The date on which the contract becomes binding and the talent engagement period begins.',
    `engagement_role` STRING COMMENT 'The specific role or position the talent is contracted to perform (e.g., Lead Actor, Director, Showrunner, Writer, Executive Producer, Director of Photography, Host).',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the contract includes exclusivity restrictions preventing the talent from working on competing projects or for other networks/studios during the contract period.',
    `exclusivity_scope` STRING COMMENT 'Detailed description of the exclusivity restrictions, including prohibited activities, competing platforms, genre restrictions, and geographic scope. Null if exclusivity_flag is false.',
    `governing_cba` STRING COMMENT 'The specific collective bargaining agreement that governs this contract, including version and effective date (e.g., SAG-AFTRA Television Agreement 2020-2023). Defines minimum compensation, working conditions, and residual structures.',
    `guaranteed_episodes` STRING COMMENT 'The minimum number of episodes for which the talent is guaranteed compensation, regardless of actual production. Common in series regular deals. Null for non-episodic contracts.',
    `holdback_period_days` STRING COMMENT 'The number of days after contract end during which the talent is restricted from working on similar projects or for competing entities. Common in overall deals and first-look agreements.',
    `last_amendment_date` DATE COMMENT 'The date of the most recent contract amendment. Null if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was most recently updated in the system.',
    `option_exercise_deadline` DATE COMMENT 'The date by which the company must notify the talent of its decision to exercise or decline the next option period. Null if no active option exists.',
    `option_exercise_status` STRING COMMENT 'Current status of the most recent option period. Not applicable if no options exist; pending if decision deadline has not passed; exercised if company extended; declined if company chose not to extend; expired if deadline passed without action.. Valid values are `not_applicable|pending|exercised|declined|expired`',
    `option_periods_count` STRING COMMENT 'The number of option periods (typically annual) the company holds to extend the contract beyond the initial term. Common in series regular and overall deals.',
    `pay_or_play_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a pay-or-play provision, guaranteeing full compensation even if the talent services are not ultimately used or the production is cancelled.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of the content (reruns, streaming, international distribution, home video). Governed by guild CBAs.',
    `step_up_amount` DECIMAL(18,2) COMMENT 'The incremental increase in base compensation for each exercised option period or season renewal. Null if no step-up provision exists.',
    `termination_date` DATE COMMENT 'The date on which the contract was terminated prior to its natural expiration. Null if contract was not terminated early.',
    `termination_reason` STRING COMMENT 'The primary reason for early contract termination. Null if contract was not terminated early. [ENUM-REF-CANDIDATE: mutual_agreement|breach_of_contract|force_majeure|production_cancellation|talent_unavailability|company_convenience|talent_request|other — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Authoritative record of each talent engagement from initial deal memo through executed long-form contract — covering series regular deals, episodic guest agreements, overall deals, first-look deals, and crew contracts. Captures contract lifecycle stage (deal memo, countersigned, long-form executed), compensation structure (base fee, guarantees, backend participation, step-ups, pay-or-play), exclusivity and holdback restrictions, option periods with exercise status, amendment history, billing credit position, governing CBA, and document references. Source of truth for all commercial terms, obligations, and contractual modifications throughout the talent engagement lifecycle.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` (
    `compensation_structure_id` BIGINT COMMENT 'Unique identifier for the compensation structure record. Primary key.',
    `cba_rate_card_id` BIGINT COMMENT 'Foreign key linking to talent.cba_rate_card. Business justification: compensation_structure defines detailed compensation terms for talent contracts. Currently has union_scale_tier (STRING) and guild_affiliation (STRING) but no FK to the CBA rate card that defines mini',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Compensation structures define GL account classification for talent payments. Different compensation types (base fee, residuals, backend participation) map to specific GL accounts for expense recognit',
    `contract_id` BIGINT COMMENT 'Reference to the parent talent contract to which this compensation structure is attached.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compensation structures must map to cost centers for budget tracking, variance analysis by department/show, and actuals-vs-forecast reporting required in production financial management.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Compensation structures include demo-specific bonuses (e.g., additional payment if show delivers X rating in A25-54). Backend participation often tied to demographic performance. Talent compensation i',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: compensation_structure.guild_affiliation is a denormalized STRING field capturing the guild governing the compensation terms. Replacing it with a FK to guild_affiliation normalizes this reference, ena',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: P&L reporting requires compensation structures mapped to profit centers for segment profitability analysis, EBITDA calculation, and business unit performance measurement in broadcasting.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compensation structures must comply with minimum wage laws, union CBA requirements, overtime regulations, and tax withholding rules. Critical for payroll compliance audits and ensuring pay structures ',
    `backend_gross_participation_pct` DECIMAL(18,2) COMMENT 'The percentage of adjusted gross receipts or backend profits the talent is entitled to receive (e.g., 0.05 for 5% backend participation). Null if no backend participation is granted.',
    `base_episode_fee` DECIMAL(18,2) COMMENT 'The guaranteed compensation amount per episode for episodic talent (actors, writers, directors). Expressed in the contract currency.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'The fixed or maximum bonus amount payable when the bonus threshold is met. Expressed in the contract currency. Null if no bonus provision exists.',
    `bonus_threshold_description` STRING COMMENT 'Textual description of the performance or milestone thresholds that trigger bonus payments (e.g., Nielsen rating above 2.0 in key demo, box office exceeds $100M domestic).',
    `compensation_type` STRING COMMENT 'Classification of the compensation arrangement: union scale (SAG-AFTRA, WGA, DGA minimum), over-scale (above union minimum), flat fee, episodic rate, weekly guarantee, daily rate, backend gross participation, deferred compensation, or residual-only deal. [ENUM-REF-CANDIDATE: union_scale|over_scale|flat_fee|episodic|weekly|daily|backend_participation|deferred|residual_only — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation structure record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts in this compensation structure are denominated (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `daily_rate` DECIMAL(18,2) COMMENT 'The guaranteed daily compensation amount for talent engaged on a day-player or daily basis. Expressed in the contract currency.',
    `deferred_compensation_amount` DECIMAL(18,2) COMMENT 'The total amount of compensation deferred to a future payment date or contingent event (e.g., series pickup, profitability milestone). Expressed in the contract currency.',
    `deferred_payment_trigger` STRING COMMENT 'The business event or milestone that triggers payment of deferred compensation (e.g., series_pickup, profitability_threshold_met, syndication_sale, specific_date).',
    `effective_end_date` DATE COMMENT 'The date on which this compensation structure ceases to be effective. Null for open-ended structures or those tied to contract termination.',
    `effective_start_date` DATE COMMENT 'The date on which this compensation structure becomes effective and applicable to the talent contract.',
    `exclusivity_clause_flag` BOOLEAN COMMENT 'Indicates whether this compensation structure includes an exclusivity provision restricting the talent from working on competing projects (True) or not (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation structure record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special provisions, or clarifications regarding this compensation structure that do not fit into structured fields.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base rate for overtime hours worked (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if overtime is not applicable.',
    `pay_or_play_flag` BOOLEAN COMMENT 'Indicates whether this compensation structure includes a pay-or-play provision, guaranteeing payment even if the talent is not used (True) or not (False).',
    `pension_health_rate` DECIMAL(18,2) COMMENT 'The percentage rate of gross compensation contributed to the guild pension and health plan (e.g., 0.185 for 18.5% SAG-AFTRA P&H). Used to calculate employer contributions.',
    `residual_base_formula` STRING COMMENT 'The formula or method used to calculate the residual base for reuse payments (e.g., initial_compensation, applicable_minimum, pro_rata_share). Defines how residuals are computed per guild rules.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of the content under this compensation structure (True) or not (False). Typically True for union deals, may be False for buyouts.',
    `step_up_amount` DECIMAL(18,2) COMMENT 'The incremental compensation increase amount when the step-up trigger is met. Expressed in the contract currency. Null if no step-up provision exists.',
    `step_up_trigger` STRING COMMENT 'The condition or event that triggers an automatic increase in compensation (e.g., season_2_pickup, episode_13_renewal, ratings_threshold). Null if no step-up provision exists.',
    `structure_name` STRING COMMENT 'Business-friendly name or label for this compensation structure (e.g., Series Regular Season 1, Guest Star Rate Card).',
    `structure_status` STRING COMMENT 'Current lifecycle status of the compensation structure: draft (under negotiation), active (in force), amended (modified after execution), superseded (replaced by a newer structure), or terminated (no longer applicable).. Valid values are `draft|active|amended|superseded|terminated`',
    `usage_rights_scope` STRING COMMENT 'Description of the media usage rights covered by this compensation structure (e.g., initial broadcast only, all media in perpetuity, theatrical and SVOD, domestic free television). Defines what exploitation is covered by the base compensation.',
    `weekly_guarantee` DECIMAL(18,2) COMMENT 'The guaranteed weekly compensation amount for talent engaged on a weekly basis (e.g., series regulars, production staff). Expressed in the contract currency.',
    CONSTRAINT pk_compensation_structure PRIMARY KEY(`compensation_structure_id`)
) COMMENT 'Defines the detailed compensation terms attached to a talent contract — including base episode fee, weekly guarantee, daily rate, overtime multipliers, pension and health (P&H) contribution rates, residual base formula, backend gross participation percentage, deferred compensation schedule, and currency. Supports both union scale (SAG-AFTRA scale, DGA scale) and over-scale deals. Tracks step-up triggers (e.g., series pickup escalators), bonus thresholds, and pay-or-play provisions. Used by payroll and royalty workflows to calculate gross compensation and residual bases.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` (
    `appearance_schedule_id` BIGINT COMMENT 'Unique identifier for the appearance schedule record. Primary key for the appearance schedule entity.',
    `availability_id` BIGINT COMMENT 'Foreign key linking to talent.availability. Business justification: An appearance schedule (confirmed booking) is the downstream result of a confirmed availability record. Linking appearance_schedule back to the availability record that enabled the booking provides op',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Appearance schedules for episodic content must specify exact episode for production call sheets, per-episode compensation tracking, and daily production scheduling. Critical for episodic production op',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: An appearance schedule is the operational execution of a talent engagement governed by a specific contract. Linking appearance_schedule to contract enables direct traceability from a confirmed booking',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Appearance schedules generate labor costs that must be tracked against specific cost centers for actuals-vs-budget reconciliation and production cost reporting in broadcast operations.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Talent scheduling for live/linear broadcasts (news anchors, talk show hosts, sports commentators) must reference the specific delivery channel to manage exclusivity conflicts, guild notification requi',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Talent appearance scheduling must consider target demographic alignment. Booking decisions depend on whether talent appeals to the intended audience segment. Casting and booking teams match talent to ',
    `project_id` BIGINT COMMENT 'Reference to the production (film, television episode, live broadcast, promotional event) for which the talent is scheduled.',
    `rescheduled_from_appearance_schedule_id` BIGINT COMMENT 'Reference to the original appearance schedule record if this schedule is a rescheduled version of a previous booking.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Links scheduled talent appearances (talk shows, live events, promotional shoots) to the resulting recorded media assets. Required for archival cross-reference, rights verification, and tracking which ',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: An appearance schedule records a talents operational booking for a specific role performance. Linking appearance_schedule to role connects the operational scheduling record to the specific role defin',
    `shoot_schedule_id` BIGINT COMMENT 'Foreign key linking to production.shoot_schedule. Business justification: Talent appearance schedules are tied to specific shoot days for call sheet generation, guild notification compliance, and conflict resolution. Production coordinators reconcile appearance_schedule aga',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) associated with this appearance schedule.',
    `title_id` BIGINT COMMENT 'Reference to the content title (series, film, special) associated with this appearance.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'The actual number of hours the talent was engaged for this appearance, recorded after completion for payroll and residual calculation purposes.',
    `appearance_type` STRING COMMENT 'Classification of the type of appearance or activity scheduled for the talent. ADR (Automated Dialogue Replacement) refers to post-production voice recording sessions. [ENUM-REF-CANDIDATE: principal_photography|adr_session|promotional_appearance|press_junket|live_broadcast|table_read|rehearsal|wardrobe_fitting|makeup_test|screen_test — 10 candidates stripped; promote to reference product]',
    `availability_window_end` DATE COMMENT 'The end date of the period during which the talent has indicated availability for scheduling.',
    `availability_window_start` DATE COMMENT 'The start date of the period during which the talent has indicated availability for scheduling.',
    `booking_reference` STRING COMMENT 'Externally-known unique booking reference code assigned to this appearance schedule by the production scheduling system.. Valid values are `^[A-Z0-9]{8,20}$`',
    `call_date` DATE COMMENT 'The scheduled date on which the talent is required to appear for the activity. Follows yyyy-MM-dd format.',
    `call_time` TIMESTAMP COMMENT 'The specific date and time when the talent must report to the location. Follows yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the appearance schedule was cancelled, such as production delays, talent unavailability, or budget constraints.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when this appearance schedule was cancelled, if applicable.',
    `confirmation_status` STRING COMMENT 'Current lifecycle status of the appearance schedule indicating whether the booking is pending confirmation, confirmed, cancelled, rescheduled, completed, or resulted in a no-show.. Valid values are `pending|confirmed|cancelled|rescheduled|completed|no_show`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this appearance schedule record was first created in the system.',
    `daypart` STRING COMMENT 'The time segment of the broadcast day during which the appearance is scheduled, relevant for live broadcast appearances and promotional activities. [ENUM-REF-CANDIDATE: early_morning|morning|midday|afternoon|prime_time|late_night|overnight — 7 candidates stripped; promote to reference product]',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'The estimated number of hours the talent is expected to be engaged for this appearance, used for scheduling and compensation planning.',
    `exclusivity_conflict_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this appearance schedule conflicts with any exclusivity clauses in the talents contract.',
    `guild_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether guild notification is required for this appearance per union agreements (SAG-AFTRA, WGA, DGA).',
    `guild_notification_sent_timestamp` TIMESTAMP COMMENT 'The date and time when notification was sent to the relevant guild regarding this appearance schedule.',
    `hold_level` STRING COMMENT 'Priority level of the talent booking indicating the strength of the commitment. First hold is highest priority, second and third holds are lower priority backups, first refusal gives talent right to accept or decline before offering to others.. Valid values are `confirmed|first_hold|second_hold|third_hold|first_refusal|tentative`',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who most recently modified this appearance schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this appearance schedule record was most recently updated.',
    `playout_system_sync_status` STRING COMMENT 'Status indicating whether this appearance schedule has been synchronized with the playout and channel management system (Ericsson MediaFirst) for live broadcast coordination.. Valid values are `not_synced|pending|synced|sync_failed`',
    `playout_system_sync_timestamp` TIMESTAMP COMMENT 'The date and time when this appearance schedule was last synchronized with the playout system.',
    `release_tracking_status` STRING COMMENT 'Status of obtaining necessary talent releases, waivers, or permissions required for the appearance, particularly for promotional and publicity activities.. Valid values are `not_required|pending|obtained|expired|declined`',
    `scheduling_notes` STRING COMMENT 'Free-text field for additional scheduling information, special requirements, or coordination notes relevant to this appearance.',
    `unavailability_reason` STRING COMMENT 'Free-text explanation of why the talent is unavailable during certain periods, such as personal commitments, conflicting bookings, or contractual exclusivity.',
    `wrap_time` TIMESTAMP COMMENT 'The actual or estimated date and time when the talent completed their scheduled activity and was released from the set or location.',
    CONSTRAINT pk_appearance_schedule PRIMARY KEY(`appearance_schedule_id`)
) COMMENT 'Operational schedule of talent time allocation — covering confirmed bookings, holds (first/second/third), first refusals, availability windows, and personal unavailability alongside specific call times for principal photography, ADR sessions, promotional appearances, press junkets, and live broadcast slots. Records production reference, call date/time, wrap time, location, appearance type, hold level, confirmation status, and release tracking. Integrates with production scheduling and playout systems to ensure talent availability aligns with broadcast calendars.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` (
    `residual_payment_id` BIGINT COMMENT 'Unique identifier for the residual payment transaction.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Residual payments flow through AP for payment processing, cash management, and financial reconciliation. Proper FK enables AP aging reports, payment status tracking, clearing reconciliation, and finan',
    `compensation_structure_id` BIGINT COMMENT 'Foreign key linking to talent.compensation_structure. Business justification: A residual payment is calculated based on the residual_base_formula and residual_eligibility_flag defined in a specific compensation structure. While residual_payment already links to contract_id, a c',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing this residual payment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Residual payments must be charged to cost centers managing ongoing content exploitation. When titles generate residuals (syndication, streaming, international), costs are allocated to the responsible ',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: CBA residual formulas require the specific distribution medium (SVOD, AVOD, FAST, linear) to calculate correct residual rates. The delivery_channels monetization_model and channel_type directly deter',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Residual payments triggered by partner distribution deals must link to the specific distribution agreement for royalty calculation accuracy, audit trail compliance, guild reporting requirements, and r',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: residual_payment.guild_affiliation is a denormalized STRING field capturing the guild governing the residual. Replacing it with a FK to guild_affiliation normalizes this reference, enabling JOIN to th',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Residual payments are invoiced line items requiring invoice-level tracking for revenue recognition, audit compliance, guild reporting, and payment reconciliation. Completes payment-to-invoice chain fo',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each residual payment generates a journal entry for accrual accounting, audit trail linkage, and SOX compliance documentation required in financial close processes.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Residual payments must track paying legal entity for consolidated financial statements, intercompany reconciliation, and multi-entity cash flow management in broadcasting operations.',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (title, episode, or version) for which the residual is being paid.',
    `nielsen_rating_id` BIGINT COMMENT 'Foreign key linking to audience.nielsen_rating. Business justification: Residual payments are calculated based on actual Nielsen ratings achieved during exhibition windows. The rating record is the source of truth for residual formulas. Guild CBAs mandate residual calcula',
    `cycle_id` BIGINT COMMENT 'Reference to the payment cycle or batch in which this residual was processed.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Residual payments are financial disbursements that must link to billing payment records for cash reconciliation, bank transaction tracking, and audit trail. Media companies reconcile residual checks a',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: SAG-AFTRA, WGA, and DGA residual obligations are calculated and reported at the episode level. Linking residual_payment to production_episode enables episode-level residual audit trails, guild remitta',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Residual payments to talent may require regulatory filings for tax reporting, guild reporting, and pension/health fund contributions. Finance teams include residual payment data in quarterly guild fil',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.role. Business justification: A residual payment is issued for reuse of a specific role performance in content. Linking residual_payment to role provides granular traceability — identifying exactly which role performance (characte',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Syndication airings generate residuals per guild rules. Linking payments to specific syndication agreements enables accurate royalty calculation based on territory, run count, and revenue share terms.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent receiving the residual payment.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: SAG-AFTRA, WGA, and DGA residual reporting mandates title-level attribution of all reuse payments. Residual payment currently has no content domain FK (only media_asset), making guild compliance repor',
    `ach_trace_number` STRING COMMENT 'The ACH trace number if the payment method is ACH or direct deposit, used for reconciliation and audit.',
    `agent_commission_amount` DECIMAL(18,2) COMMENT 'The agent or manager commission amount deducted from the residual payment, if applicable.',
    `audit_report_date` DATE COMMENT 'The date on which this residual payment was included in a guild audit report.',
    `audit_report_flag` BOOLEAN COMMENT 'Indicates whether this residual payment has been included in a guild audit report (SAG-AFTRA, WGA, DGA).',
    `check_number` STRING COMMENT 'The check number if the payment method is check, used for reconciliation and audit.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was first created in the system.',
    `distribution_window` STRING COMMENT 'The specific distribution window or platform for which the residual is being paid (e.g., Network Prime Time, Basic Cable, Netflix SVOD, International Theatrical).',
    `exhibition_end_date` DATE COMMENT 'The end date of the exhibition period for which this residual is calculated.',
    `exhibition_start_date` DATE COMMENT 'The start date of the exhibition period for which this residual is calculated.',
    `gross_residual_amount` DECIMAL(18,2) COMMENT 'The gross residual amount calculated before deductions, in the payment currency.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net residual payment amount after all deductions, paid to the talent.',
    `payment_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the residual payment (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the residual payment was issued or disbursed to the talent.',
    `payment_method` STRING COMMENT 'The method used to disburse the residual payment to the talent.. Valid values are `check|ACH|wire_transfer|direct_deposit|payroll`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments related to this residual payment, including special circumstances, adjustments, or exceptions.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the residual payment transaction.. Valid values are `pending|approved|processed|paid|cancelled|on_hold`',
    `pension_health_amount` DECIMAL(18,2) COMMENT 'The pension and health contribution amount deducted from the gross residual, as required by guild agreements.',
    `remittance_advice_sent_date` DATE COMMENT 'The date on which the remittance advice was sent to the talent.',
    `remittance_advice_sent_flag` BOOLEAN COMMENT 'Indicates whether a remittance advice document was sent to the talent for this payment.',
    `royalty_calculation_reference` BIGINT COMMENT 'Reference to the Rightsline royalty calculation record that generated this residual payment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was last modified.',
    `use_type` STRING COMMENT 'The type of content reuse triggering the residual payment (broadcast, cable, SVOD, AVOD, TVOD, FAST, home video, foreign distribution, theatrical). [ENUM-REF-CANDIDATE: broadcast|cable|SVOD|AVOD|TVOD|FAST|home_video|foreign|theatrical — 9 candidates stripped; promote to reference product]',
    `wire_reference_number` STRING COMMENT 'The wire transfer reference number if the payment method is wire transfer, used for reconciliation and audit.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The tax amount withheld from the residual payment for federal, state, or foreign tax obligations.',
    CONSTRAINT pk_residual_payment PRIMARY KEY(`residual_payment_id`)
) COMMENT 'Transactional record of each residual payment issued to talent for reuse of content across broadcast, home video, streaming (SVOD, AVOD, TVOD), FAST, and foreign distribution windows. Captures payment cycle, content asset reference, use type, distribution window, gross residual amount, P&H contribution amount, withholding tax amount, net payment amount, payment method, payment date, check or ACH reference, and remittance advice sent flag. Reconciles against Rightsline royalty calculations and SAP S/4HANA AP postings. Supports SAG-AFTRA and WGA audit requirements.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` (
    `deal_memo_id` BIGINT COMMENT 'Unique identifier for the talent deal memo record. Primary key.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Guest star and day-player deal memos are episode-specific contracts standard in TV production. SAG-AFTRA daily contract compliance and episode-level casting cost tracking require linking deal memos to',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: deal_memo.guild_affiliation is a denormalized STRING field. Replacing it with a FK to guild_affiliation normalizes the guild reference, enabling JOIN to the authoritative guild record for the talents',
    `contract_id` BIGINT COMMENT 'Reference to the executed long-form talent contract that supersedes this deal memo. Null if the long-form contract has not yet been executed.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Deal memos reference the commissioning partner entity (studio, network, streamer) for deal tracking and relationship management. Critical for converting deal memos to long-form contracts and tracking ',
    `production_budget_id` BIGINT COMMENT 'Foreign key linking to finance.production_budget. Business justification: Deal memos represent preliminary budget commitments that must reconcile to formal production budgets during greenlight process for cost control and financial approval workflows.',
    `title_id` BIGINT COMMENT 'Reference to the production title (series, episode, film, special) for which the talent is engaged.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Deal memos are preliminary agreements that must comply with regulatory frameworks including guild rules, labor laws, and contract formation requirements. Essential for tracking compliance obligations ',
    `representation_agreement_id` BIGINT COMMENT 'Foreign key linking to talent.representation_agreement. Business justification: deal_memo contains denormalized agent contact fields (agent_name, agent_contact_email, agent_contact_phone) that duplicate data already captured on representation_agreement. Linking deal_memo to the g',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-specific deal memos are standard in TV production — talent is frequently contracted for a defined season (e.g., Season 3 only). Budget allocation, residual scoping, and option exercise tracking',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Deal memos for episodic content reference series for series commitment tracking, multi-season option terms, and episode count guarantees. Essential for TV talent deal management.',
    `opportunity_id` BIGINT COMMENT 'The Salesforce Media Cloud opportunity or proposal record identifier from which this deal memo was generated.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) engaged under this deal memo.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The primary monetary compensation amount agreed in the deal memo (e.g., total fee, per-episode rate, or guaranteed minimum).',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `compensation_summary` STRING COMMENT 'High-level summary of the compensation structure agreed in the deal memo (e.g., per-episode fee, flat fee, day rate, backend participation). Detailed breakdowns are captured in the long-form contract.',
    `countersigned_date` DATE COMMENT 'The date on which the deal memo was countersigned by both the talent (or agent) and the production company, making it a binding interim agreement. Null if not yet countersigned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deal memo record was first created in the system.',
    `credit_position` STRING COMMENT 'The agreed on-screen or off-screen credit position and format (e.g., Main Title Card, Opening Credits, End Crawl, Shared Card, Single Card).',
    `deal_date` DATE COMMENT 'The date on which the deal terms were verbally agreed or the deal memo was initially drafted.',
    `deal_memo_number` STRING COMMENT 'Externally-known unique business identifier for the deal memo, typically generated by the CRM or legal system.. Valid values are `^DM-[0-9]{6,10}$`',
    `deal_memo_status` STRING COMMENT 'Current lifecycle status of the deal memo: draft (under negotiation), countersigned (binding interim agreement), superseded_by_long_form (replaced by executed contract), expired (lapsed without execution), cancelled (deal fell through).. Valid values are `draft|countersigned|superseded_by_long_form|expired|cancelled`',
    `effective_date` DATE COMMENT 'The date on which the deal memo becomes binding (typically the date of countersignature by both parties).',
    `engagement_end_date` DATE COMMENT 'The date on which the talent engagement is scheduled to end. Null for open-ended or option-based engagements.',
    `engagement_start_date` DATE COMMENT 'The date on which the talent engagement is scheduled to begin (first day of work, rehearsal, or availability).',
    `episode_count` STRING COMMENT 'Number of episodes or production units covered by this deal memo. Null if the engagement is for a single film or special.',
    `exclusivity_summary` STRING COMMENT 'High-level summary of exclusivity terms (e.g., exclusive to network during production, non-exclusive, first-look, holdback period). Detailed clauses are in the long-form contract.',
    `expiration_date` DATE COMMENT 'The date by which the deal memo must be superseded by a long-form contract or it will expire. Null if no expiration is set.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the deal memo record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the deal memo record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special provisions, or negotiation history relevant to the deal memo.',
    `option_terms` STRING COMMENT 'Summary of any option clauses (e.g., network option for additional seasons, talent option to extend, mutual option). Null if no options are included.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible for residual payments under guild agreements for reuse, syndication, or secondary distribution. True if eligible, False otherwise.',
    `role_function` STRING COMMENT 'The specific role or function the talent will perform (e.g., Lead Actor, Director, Writer, Executive Producer, Host, Correspondent, Camera Operator).',
    `superseded_date` DATE COMMENT 'The date on which the deal memo was superseded by the execution of a long-form contract. Null if not yet superseded.',
    CONSTRAINT pk_deal_memo PRIMARY KEY(`deal_memo_id`)
) COMMENT 'Pre-contract deal memo capturing the agreed commercial terms for a talent engagement before the formal long-form contract is executed — including deal date, production title, role or function, episode count, start date, compensation summary, credit position, exclusivity summary, option terms, and deal memo status (draft, countersigned, superseded by long-form). Serves as the binding interim agreement used by production and legal teams during the gap between verbal deal and executed contract. Sourced from Salesforce Media Cloud opportunity and proposal records.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`role` (
    `role_id` BIGINT COMMENT 'Unique identifier for the talent role assignment. Primary key for the talent role entity.',
    `cba_rate_card_id` BIGINT COMMENT 'Foreign key linking to talent.cba_rate_card. Business justification: role.residual_rate_code is a denormalized STRING reference to a CBA rate card entry. Replacing it with a FK to cba_rate_card normalizes this reference, enabling JOIN to the authoritative rate card (mi',
    `compensation_structure_id` BIGINT COMMENT 'Foreign key linking to talent.compensation_structure. Business justification: A role is governed by a specific compensation structure that defines the base episode fee, overtime multiplier, and residual formula applicable to that role. While role already links to contract_id an',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing the terms of this role engagement, including compensation, usage rights, and obligations.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Role casting decisions are driven by demographic targeting. Specific roles are cast to appeal to key demographic segments. Casting directors receive demographic briefs specifying target audience for e',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: role.guild_affiliation is a denormalized STRING field. Replacing it with a FK to guild_affiliation normalizes the guild reference for the role, enabling JOIN to the authoritative guild record for memb',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Talent roles (character appearances) must track episode-level granularity for episodic series. Residual calculations, credit attribution per episode, and production scheduling all require knowing whic',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Rights clearance, residual payment calculation, and credit reporting require linking each contracted role directly to the media asset capturing that performance. Talent rights teams and residual audit',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Roles often span specific seasons requiring season-level tracking for season-specific compensation, per-season credits, and availability scheduling. Eliminates denormalized season_number and provides ',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Roles in episodic content must link to series for multi-season contract tracking, series-level residuals, and long-term talent availability management. Essential for TV production business model.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent individual performing this role. Links to the talent master entity.',
    `title_id` BIGINT COMMENT 'Reference to the content asset or production in which this role is performed. Links to the content master entity.',
    `above_the_line_flag` BOOLEAN COMMENT 'Indicates whether this role is classified as above-the-line (creative principals: actors, directors, writers, producers) or below-the-line (technical crew and support staff). Impacts budget allocation and residual calculations.',
    `appearance_count` STRING COMMENT 'Total number of episodes, segments, or appearances in which this talent role is featured. Used for episodic and recurring roles.',
    `billing_position` STRING COMMENT 'The numerical order in which the talent appears in the credits (1 = first billed, 2 = second billed, etc.). Determines prominence in marketing materials and on-screen credits.',
    `character_name` STRING COMMENT 'The name of the character portrayed by the talent for on-screen roles. Null for off-screen roles such as crew, directors, or producers.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The monetary compensation amount for this role engagement in the contract currency. Excludes residuals and backend participation.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `compensation_type` STRING COMMENT 'The structure of compensation for this role (flat fee, daily rate, weekly rate, episodic fee, backend participation, royalty, deferred payment). [ENUM-REF-CANDIDATE: flat_fee|daily_rate|weekly_rate|episodic_fee|backend_participation|royalty|deferred|other — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this talent role record was first created in the system.',
    `credit_text` STRING COMMENT 'The exact text of the credit as it appears on-screen or in marketing materials, including any special formatting or possessory credits (e.g., A Film By, Created By).',
    `credit_type` STRING COMMENT 'Specifies where and how the talents credit appears in the production (opening credits, closing credits, main titles, end titles, special thanks, or no credit).. Valid values are `opening_credits|closing_credits|main_titles|end_titles|special_thanks|no_credit`',
    `end_date` DATE COMMENT 'The date on which the talents engagement for this role concludes. Null for ongoing or open-ended engagements.',
    `episode_scope_end` STRING COMMENT 'The last episode number in which this talent role appears. Null indicates ongoing engagement or single-episode appearance.',
    `episode_scope_start` STRING COMMENT 'The first episode number in which this talent role appears. Used for episodic content to define the scope of the talents engagement.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the talent is bound by exclusivity clauses preventing them from performing similar roles for competing productions during the engagement period.',
    `exclusivity_scope` STRING COMMENT 'Description of the scope and limitations of any exclusivity clause (e.g., No competing streaming series, No theatrical films during production).',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about this talent role assignment (e.g., special credit requirements, scheduling constraints, performance notes).',
    `residual_eligible_flag` BOOLEAN COMMENT 'Indicates whether this role is eligible for residual payments based on subsequent distribution, reuse, or syndication of the content. Determined by guild agreements and contract terms.',
    `role_category` STRING COMMENT 'Classification of the role type indicating the nature and scope of the talents engagement. Determines compensation structure, credit placement, and residual eligibility. [ENUM-REF-CANDIDATE: series_regular|recurring|guest_star|day_player|featured_extra|host|correspondent|narrator|voice_artist|director|writer|showrunner|executive_producer|line_producer|cinematographer|editor|composer|production_designer|costume_designer|makeup_artist|stunt_coordinator|other — promote to reference product]',
    `role_name` STRING COMMENT 'The specific role or function the talent is engaged to perform (e.g., Lead Actor, Director, Executive Producer, Cinematographer, Script Supervisor).',
    `role_status` STRING COMMENT 'Current lifecycle status of the talent role assignment indicating the stage of engagement from negotiation through completion. [ENUM-REF-CANDIDATE: confirmed|tentative|in_negotiation|contracted|active|completed|cancelled|suspended — 8 candidates stripped; promote to reference product]',
    `screen_time_minutes` DECIMAL(18,2) COMMENT 'Total on-screen time in minutes for this talent role across all appearances. Used for on-screen talent to measure prominence and for residual calculations.',
    `start_date` DATE COMMENT 'The date on which the talents engagement for this role begins, typically the first day of principal photography, recording, or production work.',
    `stunt_double_flag` BOOLEAN COMMENT 'Indicates whether this role involves stunt work or if a stunt double is used for this character. Impacts insurance, safety protocols, and credit attribution.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this talent role record was last modified in the system.',
    `usage_rights_duration_years` STRING COMMENT 'Number of years for which usage rights are granted. Null indicates perpetual rights.',
    `usage_rights_media` STRING COMMENT 'Media platforms and formats for which usage rights are granted (e.g., Theatrical, Home Video, Streaming, Broadcast TV).',
    `usage_rights_territory` STRING COMMENT 'Geographic territories in which the content featuring this talent role may be distributed and exploited (e.g., Worldwide, North America, USA and Canada).',
    `voice_only_flag` BOOLEAN COMMENT 'Indicates whether this is a voice-only role (voice-over, narration, animation, ADR) with no on-screen physical appearance by the talent.',
    CONSTRAINT pk_role PRIMARY KEY(`role_id`)
) COMMENT 'Defines the specific role or function a talent is engaged to perform within a production or content asset — capturing role name, character name (for on-screen talent), role category (series regular, recurring, guest star, day player, featured extra, host, correspondent, narrator, voice artist, director, writer, showrunner, executive producer, line producer, DP, editor), above-the-line or below-the-line classification, episode or segment scope, and role status. Provides the granular link between talent identity and their specific creative contribution to each content asset.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` (
    `talent_agency_id` BIGINT COMMENT 'Unique identifier for the talent agency or management company. Primary key for the talent_agency product.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Agency relationships are maintained by specific legal entities for contract enforceability, jurisdiction determination, and intercompany transaction tracking in multi-entity broadcasting organizations',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Talent agencies are business partners in the media ecosystem, tracked for commission payment routing, franchise compliance verification, and strategic relationship management. Essential for partner pe',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Talent agencies must comply with state franchise laws, licensing requirements, bonding regulations, and commission restrictions. Essential for tracking which regulatory obligations govern agency opera',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Talent agencies act as licensors/sellers of talent services to networks/advertisers, tracked as sales accounts for commission payments, contract management, and revenue recognition. Real business proc',
    `address_line_1` STRING COMMENT 'The first line of the agencys primary business address, typically containing street number and street name.',
    `address_line_2` STRING COMMENT 'The second line of the agencys primary business address, typically containing suite, floor, or building information.',
    `agency_type` STRING COMMENT 'Classification of the representation entity: talent agency (licensed to procure employment), literary agency (represents writers), management company (career guidance), law firm (legal representation), publicity firm (public relations), or hybrid (multiple services).. Valid values are `talent_agency|literary_agency|management_company|law_firm|publicity_firm|hybrid`',
    `bank_account_name` STRING COMMENT 'The name on the bank account used for commission and residual payments to the agency.',
    `bank_account_number` STRING COMMENT 'The bank account number for electronic funds transfer of commissions and residuals to the agency.',
    `bank_routing_number` STRING COMMENT 'The bank routing number (ABA number in the US, sort code in UK, or equivalent) for electronic funds transfer of commissions and residuals.',
    `city` STRING COMMENT 'The city or municipality where the agencys primary office is located.',
    `country_code` STRING COMMENT 'The three-letter ISO country code for the country where the agencys primary office is located (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent agency record was first created in the system. Immutable audit field.',
    `dba_name` STRING COMMENT 'The trade name or doing-business-as name under which the agency operates, if different from the legal name.',
    `established_date` DATE COMMENT 'The date on which the talent agency was originally established or incorporated.',
    `fax_number` STRING COMMENT 'The fax number for the agency, used for contract transmission and official correspondence in jurisdictions where fax is still required.',
    `franchise_effective_date` DATE COMMENT 'The date on which the SAG-AFTRA franchise agreement became effective for this agency.',
    `franchise_expiration_date` DATE COMMENT 'The date on which the current SAG-AFTRA franchise agreement expires and must be renewed.',
    `franchise_number` STRING COMMENT 'The unique franchise identification number issued by SAG-AFTRA to franchised talent agencies.',
    `franchise_status` STRING COMMENT 'Indicates whether the agency holds a valid SAG-AFTRA franchise agreement, which authorizes the agency to represent union talent. Franchised agencies agree to standard commission rates and contract terms.. Valid values are `franchised|non_franchised|pending|revoked|expired`',
    `legal_name` STRING COMMENT 'The full legal registered name of the talent agency or management company as it appears on contracts and official documents.',
    `license_effective_date` DATE COMMENT 'The date on which the state talent agency license became effective.',
    `license_expiration_date` DATE COMMENT 'The date on which the state talent agency license expires and must be renewed.',
    `license_number` STRING COMMENT 'The state-issued license number authorizing the agency to operate as a talent agency. Required in jurisdictions such as California under the Talent Agencies Act.',
    `license_state` STRING COMMENT 'The state or province that issued the talent agency license. Use standard two-letter state/province codes.',
    `notes` STRING COMMENT 'Free-form notes field for additional context, special handling instructions, historical information, or relationship management details relevant to the agency.',
    `payment_terms` STRING COMMENT 'The standard payment terms and conditions for commission remittance, including timing and method of payment (e.g., net 30 days, upon talent payment receipt).',
    `postal_code` STRING COMMENT 'The postal or ZIP code for the agencys primary business address.',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person at the agency for contract negotiations, deal correspondence, and residual remittances.',
    `primary_contact_title` STRING COMMENT 'The job title or role of the primary contact person (e.g., President, Partner, Agent, Business Affairs Manager).',
    `primary_email` STRING COMMENT 'The primary email address for official correspondence, contract delivery, and residual payment notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'The primary telephone number for the agency, including country and area codes.',
    `roster_size` STRING COMMENT 'The approximate number of talent clients currently represented by the agency. Used for agency scale assessment and negotiation context.',
    `specialization` STRING COMMENT 'The primary area of talent specialization or focus for the agency (e.g., film and television actors, commercial talent, voice-over artists, writers, directors, below-the-line crew, music artists). Free-text field to accommodate multiple specializations.',
    `standard_commission_rate` DECIMAL(18,2) COMMENT 'The standard commission rate percentage that the agency charges for talent representation, typically 10% for franchised agencies under SAG-AFTRA rules. Expressed as a percentage (e.g., 10.00 for 10%).',
    `state_province` STRING COMMENT 'The state, province, or region where the agencys primary office is located. Use standard two-letter codes where applicable.',
    `status_effective_date` DATE COMMENT 'The date on which the current status became effective.',
    `talent_agency_status` STRING COMMENT 'The current operational status of the talent agency: active (currently representing talent), inactive (not currently operating), suspended (temporarily not authorized), pending_verification (under review), or dissolved (permanently closed).. Valid values are `active|inactive|suspended|pending_verification|dissolved`',
    `tax_identifier` STRING COMMENT 'The tax identification number (EIN in the US, VAT number in EU) for the agency, used for tax reporting and residual payment processing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent agency record was last modified. Updated automatically on any change to the record.',
    `verification_date` DATE COMMENT 'The date on which the agency information was last verified for accuracy and currency, typically through direct contact or regulatory registry check.',
    `website_url` STRING COMMENT 'The primary website URL for the talent agency, used for public information and talent roster visibility.',
    CONSTRAINT pk_talent_agency PRIMARY KEY(`talent_agency_id`)
) COMMENT 'Master record for talent representation agencies and management companies — capturing agency legal name, agency type (talent agency, literary agency, management company, law firm), primary contact, address, phone, email, franchise status (SAG-AFTRA franchised agency flag), commission rate standard, and active/inactive status. Serves as the reference for routing deal negotiations, contract correspondence, and residual remittances to the correct representative. Distinct from the partner domain which manages distribution and content partners.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` (
    `representation_agreement_id` BIGINT COMMENT 'Unique identifier for the representation agreement record. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Representation agreements must comply with state talent agency franchise laws, licensing requirements, commission caps, and guild regulations. Critical for ensuring agent-talent relationships meet all',
    `talent_agency_id` BIGINT COMMENT 'Foreign key linking to talent.talent_agency. Business justification: representation_agreement currently has agency_name (STRING) duplicating data from talent_agency. Adding FK enables normalization - agency legal name, DBA name, contact details, and franchise status sh',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent being represented under this agreement.',
    `agent_contact_email` STRING COMMENT 'Primary email address for the agent or representative, used for deal negotiation and residual routing communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agent_contact_phone` STRING COMMENT 'Primary phone number for the agent or representative.',
    `agent_name` STRING COMMENT 'Full name of the individual agent, manager, or attorney assigned as primary contact for this representation.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for this representation agreement, used for contract reference and audit trails.',
    `commission_cap_amount` DECIMAL(18,2) COMMENT 'Maximum commission amount per engagement or per year, if a cap is specified in the agreement. Null if no cap applies.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Percentage of talent earnings paid to the representative as commission (typically 10% for agents, 15% for managers per industry standards).',
    `contract_document_uri` STRING COMMENT 'URI or file path to the signed representation agreement contract document stored in the Media Asset Management (MAM) system or document repository.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this representation agreement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the representation agreement expires or terminates. Null for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the representation agreement becomes binding and the representative begins acting on behalf of the talent.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this representation is exclusive (true) or non-exclusive (false). Exclusive agreements prohibit the talent from engaging other representatives in the same category and territory.',
    `guild_franchise_flag` BOOLEAN COMMENT 'Indicates whether the agency or representative is franchised by a talent guild (SAG-AFTRA, WGA, DGA). Franchised agents must comply with guild-mandated commission caps and contract terms.',
    `notes` STRING COMMENT 'Free-text notes capturing special clauses, amendments, or contextual information about the representation agreement.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an automatic renewal option or requires explicit renegotiation at expiration.',
    `renewal_terms` STRING COMMENT 'Description of renewal terms if renewal_option_flag is true, including renewal period length and any modified commission rates.',
    `representation_agreement_status` STRING COMMENT 'Current lifecycle status of the representation agreement: active (in force), expired (end date reached), terminated (ended early by either party), suspended (temporarily inactive), or pending (signed but not yet effective).. Valid values are `active|expired|terminated|suspended|pending`',
    `representation_type` STRING COMMENT 'Classification of the representation relationship: exclusive agent (sole representation), co-agent (shared representation), manager (career management), entertainment attorney (legal counsel), business manager (financial management), or publicist (public relations).. Valid values are `exclusive_agent|co_agent|manager|entertainment_attorney|business_manager|publicist`',
    `residual_routing_flag` BOOLEAN COMMENT 'Indicates whether residual payments for work performed during this representation period should be routed through this representative for commission deduction.',
    `scope_of_services` STRING COMMENT 'Detailed description of services the representative will provide: deal negotiation, career guidance, audition scheduling, contract review, brand partnerships, etc.',
    `signing_date` DATE COMMENT 'Date when the representation agreement was signed by both parties.',
    `termination_date` DATE COMMENT 'Actual date the representation agreement was terminated, if applicable. Used for residual routing cutoff and historical audit trails.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the representation agreement (commonly 30, 60, or 90 days).',
    `termination_reason` STRING COMMENT 'Reason for early termination of the representation agreement, if applicable. [ENUM-REF-CANDIDATE: mutual_agreement|talent_initiated|agent_initiated|breach_of_contract|expiration|non_performance|conflict_of_interest — 7 candidates stripped; promote to reference product]',
    `territory_scope` STRING COMMENT 'Geographic territory or market scope covered by this representation agreement (e.g., worldwide, North America, USA, specific states). Multiple territories may be comma-separated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this representation agreement record was last modified.',
    CONSTRAINT pk_representation_agreement PRIMARY KEY(`representation_agreement_id`)
) COMMENT 'Records the formal representation relationship between a talent and their agency or management company — capturing representation type (exclusive agent, co-agent, manager, entertainment attorney), territory scope, commission percentage, agreement start and end dates, exclusivity flag, termination notice period, and current status. Tracks historical representation changes to support residual routing and deal negotiation audit trails. A talent may have multiple concurrent representation agreements across different territories or function types.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`availability` (
    `availability_id` BIGINT COMMENT 'Unique identifier for the talent availability record. Primary key.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Talent availability holds placed for sales opportunities requiring specific talent (celebrity host for advertiser-sponsored special, talent-driven content pitch). Real business process: sales team pit',
    `project_id` BIGINT COMMENT 'Reference to the production requesting or holding this availability. Null if this is a general unavailability not tied to a specific production.',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) whose availability is being tracked.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Casting directors track talent holds and availability against specific film titles for scheduling and conflict checking. availability has production_project_id but no content domain anchor, making it ',
    `availability_type` STRING COMMENT 'Classification of the availability status: available (talent is free), hold (production has placed a hold), first_refusal (talent has granted first right to book), confirmed_booking (talent is booked), personal_unavailability (talent is unavailable for personal reasons), conflicting_production (talent is committed to another production).. Valid values are `available|hold|first_refusal|confirmed_booking|personal_unavailability|conflicting_production`',
    `booking_confirmed_date` DATE COMMENT 'The date when the booking was confirmed and the talent was officially committed to the production. Null if not yet confirmed.',
    `booking_status` STRING COMMENT 'Current lifecycle status of the availability record: tentative (hold placed but not confirmed), confirmed (booking finalized), cancelled (booking or hold cancelled), released (hold dropped by production), expired (hold expired without confirmation).. Valid values are `tentative|confirmed|cancelled|released|expired`',
    `conflict_production_network` STRING COMMENT 'Network or studio associated with the conflicting production. Used to identify potential exclusivity clause violations.',
    `conflict_production_title` STRING COMMENT 'Title of the conflicting production when availability_type is conflicting_production. Null if not applicable.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this availability record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this availability record was first created in the system.',
    `end_date` DATE COMMENT 'The end date of the availability or unavailability window. Represents the last day the talent is available or unavailable. Null for open-ended availability.',
    `exclusivity_conflict_flag` BOOLEAN COMMENT 'Indicates whether this availability record represents a conflict with an existing exclusivity clause in the talents contract. True if conflict exists, False otherwise.',
    `guild_notification_date` DATE COMMENT 'The date when the guild was notified of this booking. Null if notification not yet sent or not required.',
    `guild_notification_required_flag` BOOLEAN COMMENT 'Indicates whether guild notification is required for this booking per collective bargaining agreement rules (SAG-AFTRA, WGA, DGA). True if notification required, False otherwise.',
    `hold_expiration_date` DATE COMMENT 'The date by which the production must confirm the booking or the hold will expire. Null if not applicable.',
    `hold_level` STRING COMMENT 'Priority level of the hold when availability_type is hold or first_refusal. First hold has highest priority, second and third holds are backup options. Null if not a hold.. Valid values are `first_hold|second_hold|third_hold`',
    `hold_placed_date` DATE COMMENT 'The date when the hold was initially placed on the talent. Null if availability_type is not hold or first_refusal.',
    `hold_released_date` DATE COMMENT 'The date when the hold was released or dropped by the requesting production. Null if hold was not released.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, or instructions related to this availability record.',
    `priority_level` STRING COMMENT 'Business priority assigned to this availability request. High priority requests receive preferential treatment in conflict resolution.. Valid values are `high|medium|low`',
    `requesting_contact_email` STRING COMMENT 'Email address of the production contact who placed the availability request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requesting_contact_phone` STRING COMMENT 'Phone number of the production contact who placed the availability request.',
    `requesting_department` STRING COMMENT 'The department or business unit that requested the availability hold or booking (e.g., Drama Production, News, Sports, Documentary Unit).',
    `requesting_producer_name` STRING COMMENT 'Name of the producer or production manager who requested the availability hold or booking.',
    `start_date` DATE COMMENT 'The start date of the availability or unavailability window. Represents the first day the talent is available or unavailable.',
    `unavailability_reason` STRING COMMENT 'Detailed explanation of why the talent is unavailable during this period (e.g., personal commitment, vacation, medical leave, prior contractual obligation).',
    `updated_by_user` STRING COMMENT 'Username or identifier of the system user who last updated this availability record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this availability record was last modified in the system.',
    CONSTRAINT pk_availability PRIMARY KEY(`availability_id`)
) COMMENT 'Operational record of a talents confirmed availability or unavailability for production bookings — capturing availability window start and end dates, availability type (available, hold, first refusal, confirmed booking, personal unavailability, conflicting production), hold level (first hold, second hold, third hold), requesting production, and release date if hold is dropped. Supports production scheduling, casting decisions, and conflict resolution across concurrent productions. Integrates with appearance_schedule and Dalet Galaxy workflow orchestration.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` (
    `cba_rate_card_id` BIGINT COMMENT 'Unique identifier for the CBA rate card entry. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: CBA minimum scale rates must map to specific GL accounts for union compliance reporting, cost allocation by production type, and regulatory audit support.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: CBA rate cards implement regulatory obligations defined by collective bargaining agreements between guilds and producers. Direct link between union-negotiated minimum rates and the regulatory framewor',
    `superseded_by_rate_card_cba_rate_card_id` BIGINT COMMENT 'Reference to the newer CBA rate card entry that replaces this one, if applicable.',
    `budget_tier` STRING COMMENT 'Production budget classification that determines applicable rates (e.g., high budget, low budget, ultra-low budget, modified low budget).',
    `cba_code` STRING COMMENT 'Standardized code identifying the specific collective bargaining agreement (e.g., SAG_AFTRA_TV, DGA_BASIC, WGA_MBA, IATSE_BASIC).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `cba_name` STRING COMMENT 'Full legal name of the collective bargaining agreement (e.g., SAG-AFTRA Television Agreement, DGA Basic Agreement, WGA Minimum Basic Agreement).',
    `cba_ratification_date` DATE COMMENT 'Date when the CBA was ratified by the guild membership.',
    `cba_version` STRING COMMENT 'Version identifier of the CBA document (e.g., 2023-2026, v4.2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CBA rate card record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the minimum scale rate (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when this CBA rate becomes effective and enforceable.',
    `expiration_date` DATE COMMENT 'Date when this CBA rate expires and is no longer enforceable. Null if the rate remains in effect indefinitely or until superseded.',
    `forced_call_penalty_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied when talent is called back to work before the minimum turnaround period has elapsed.',
    `golden_time_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base rate for hours worked beyond double-time threshold (e.g., 3.0 for triple-time), applicable in certain guild agreements.',
    `guild_code` STRING COMMENT 'Code representing the labor guild or union that negotiated this CBA (SAG-AFTRA, DGA, WGA, IATSE, NABET, AFM, OTHER). [ENUM-REF-CANDIDATE: SAG-AFTRA|DGA|WGA|IATSE|NABET|AFM|OTHER — 7 candidates stripped; promote to reference product]',
    `job_classification` STRING COMMENT 'Specific job title or classification within the performer category (e.g., Series Regular, Guest Star, Co-Star, Director of Photography, Script Supervisor).',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction where this CBA rate applies, using three-letter country code (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `local_chapter` STRING COMMENT 'Local guild chapter or regional office that administers this rate (e.g., SAG-AFTRA Los Angeles, IATSE Local 600).',
    `meal_penalty_amount` DECIMAL(18,2) COMMENT 'Penalty payment owed to talent when meal breaks are not provided within the CBA-mandated timeframe.',
    `minimum_scale_rate` DECIMAL(18,2) COMMENT 'Minimum compensation amount defined by the CBA for this rate type and performer category.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or special conditions related to this CBA rate card entry.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time).',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours worked before overtime rates apply (e.g., 8.0 for daily overtime, 40.0 for weekly overtime).',
    `pension_health_contribution_rate` DECIMAL(18,2) COMMENT 'Percentage of gross compensation that the employer must contribute to pension and health funds as mandated by the CBA (e.g., 0.1850 for 18.5%).',
    `performer_category` STRING COMMENT 'Classification of the talent role covered by this rate (e.g., principal performer, day player, stunt performer, background actor, director, writer, producer, crew member).',
    `production_type` STRING COMMENT 'Type of production this rate applies to (e.g., theatrical motion picture, television series, television movie, new media, commercial, industrial).',
    `rate_status` STRING COMMENT 'Current lifecycle status of this rate card entry (active, expired, superseded, pending, draft).. Valid values are `active|expired|superseded|pending|draft`',
    `rate_type` STRING COMMENT 'Type of compensation rate defined in this CBA entry (day rate, weekly rate, episodic rate, theatrical rate, session rate, hourly rate).. Valid values are `day_rate|weekly_rate|episodic_rate|theatrical_rate|session_rate|hourly_rate`',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this rate category qualifies for residual payments under the CBA (True/False).',
    `residual_formula_code` STRING COMMENT 'Code identifying the residual calculation formula applicable to this rate (e.g., NETWORK_PRIME, BASIC_CABLE, SVOD_HIGH_BUDGET).',
    `turnaround_hours` DECIMAL(18,2) COMMENT 'Minimum rest period required between work days as mandated by the CBA (e.g., 12.0 hours).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CBA rate card record was last modified in the system.',
    CONSTRAINT pk_cba_rate_card PRIMARY KEY(`cba_rate_card_id`)
) COMMENT 'Reference table of minimum scale rates and contribution percentages defined by each Collective Bargaining Agreement (CBA) applicable to Media Broadcasting — covering SAG-AFTRA Codified Basic Agreement, SAG-AFTRA Television Agreement, DGA Basic Agreement, WGA Minimum Basic Agreement, and IATSE Basic Agreement. Captures rate type (day rate, weekly rate, episodic rate, theatrical rate), performer category, effective date, expiration date, P&H contribution rate, and overtime multiplier. Used by compensation_structure and residual_eligibility to validate scale compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ADD CONSTRAINT `fk_talent_talent_profile_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ADD CONSTRAINT `fk_talent_guild_affiliation_cba_rate_card_id` FOREIGN KEY (`cba_rate_card_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`cba_rate_card`(`cba_rate_card_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ADD CONSTRAINT `fk_talent_guild_affiliation_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_representation_agreement_id` FOREIGN KEY (`representation_agreement_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`representation_agreement`(`representation_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_cba_rate_card_id` FOREIGN KEY (`cba_rate_card_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`cba_rate_card`(`cba_rate_card_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_availability_id` FOREIGN KEY (`availability_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`availability`(`availability_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_rescheduled_from_appearance_schedule_id` FOREIGN KEY (`rescheduled_from_appearance_schedule_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`appearance_schedule`(`appearance_schedule_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_role_id` FOREIGN KEY (`role_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`role`(`role_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ADD CONSTRAINT `fk_talent_appearance_schedule_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_compensation_structure_id` FOREIGN KEY (`compensation_structure_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`compensation_structure`(`compensation_structure_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_role_id` FOREIGN KEY (`role_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`role`(`role_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_representation_agreement_id` FOREIGN KEY (`representation_agreement_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`representation_agreement`(`representation_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_cba_rate_card_id` FOREIGN KEY (`cba_rate_card_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`cba_rate_card`(`cba_rate_card_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_compensation_structure_id` FOREIGN KEY (`compensation_structure_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`compensation_structure`(`compensation_structure_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`contract`(`contract_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ADD CONSTRAINT `fk_talent_availability_talent_profile_id` FOREIGN KEY (`talent_profile_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`talent_profile`(`talent_profile_id`);
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ADD CONSTRAINT `fk_talent_cba_rate_card_superseded_by_rate_card_cba_rate_card_id` FOREIGN KEY (`superseded_by_rate_card_cba_rate_card_id`) REFERENCES `media_broadcasting_ecm`.`talent`.`cba_rate_card`(`cba_rate_card_id`);

-- ========= TAGS =========
ALTER SCHEMA `media_broadcasting_ecm`.`talent` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `media_broadcasting_ecm`.`talent` SET TAGS ('dbx_domain' = 'talent');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Data Consent Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Talent Clearance Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|blocked|expired');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_value_regex' = 'consented|withdrawn|not_applicable|pending');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_business_glossary_term' = 'Internet Movie Database (IMDb) Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_value_regex' = '^nm[0-9]{7,8}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Name Identifier (ISNI) Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `isni_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{3}[0-9X]$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Full Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality Country Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired|deceased');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Eligibility Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_business_glossary_term' = 'Stage Name or Professional Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_business_glossary_term' = 'Talent Tier Classification');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `talent_tier` SET TAGS ('dbx_value_regex' = 'a_list|b_list|c_list|emerging|supporting|background');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `talent_type` SET TAGS ('dbx_business_glossary_term' = 'Talent Type or Role Category');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union or Guild Affiliation');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_value_regex' = 'sag_aftra|wga|dga|iatse|non_union|multiple');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|pending|expired');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `work_visa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Work Visa Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_profile` ALTER COLUMN `work_visa_type` SET TAGS ('dbx_business_glossary_term' = 'Work Visa Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `cba_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Rate Card Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `cba_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `cba_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Dues Payment Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_value_regex' = 'current|overdue|delinquent|exempt|waived');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `guild_code` SET TAGS ('dbx_business_glossary_term' = 'Guild Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `guild_name` SET TAGS ('dbx_business_glossary_term' = 'Guild Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Benefits Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Join Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Guild Jurisdiction');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `last_dues_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dues Payment Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `local_chapter` SET TAGS ('dbx_business_glossary_term' = 'Local Chapter');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'good_standing|suspended|resigned|expelled|inactive|pending');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `membership_tier` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `membership_tier` SET TAGS ('dbx_value_regex' = 'full_member|fi_core|apprentice|honorary|lifetime|emeritus');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `next_dues_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Dues Payment Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `pension_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Pension Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership Termination Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Verification Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`guild_affiliation` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'api|manual|document|self_reported|third_party');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` SET TAGS ('dbx_subdomain' = 'engagement_terms');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Backend Participation Percentage');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_business_glossary_term' = 'Backend Participation Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `backend_participation_type` SET TAGS ('dbx_value_regex' = 'net_profits|adjusted_gross|gross_receipts|none');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Compensation Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Credit Position');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_value_regex' = 'flat_fee|per_episode|weekly_rate|annual_salary|day_rate|hourly_rate');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_business_glossary_term' = 'Credit Placement Requirements');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_business_glossary_term' = 'Credit Size Percentage');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference Uniform Resource Identifier (URI)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_business_glossary_term' = 'Engagement Role');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope Description');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_business_glossary_term' = 'Governing Collective Bargaining Agreement (CBA)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `guaranteed_episodes` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Episode Count');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period in Days');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Deadline Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `option_exercise_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|exercised|declined|expired');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `option_periods_count` SET TAGS ('dbx_business_glossary_term' = 'Option Periods Count');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay-or-Play Clause Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Compensation Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` SET TAGS ('dbx_subdomain' = 'engagement_terms');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `cba_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Rate Card Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_business_glossary_term' = 'Backend Gross Participation Percentage');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_business_glossary_term' = 'Base Episode Fee');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_business_glossary_term' = 'Bonus Threshold Description');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Rate');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Compensation Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Deferred Payment Trigger');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay-or-Play Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Rate');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_business_glossary_term' = 'Residual Base Formula');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Trigger');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `structure_status` SET TAGS ('dbx_value_regex' = 'draft|active|amended|superseded|terminated');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Scope');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Weekly Guarantee');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `appearance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Appearance Schedule ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `availability_id` SET TAGS ('dbx_business_glossary_term' = 'Availability Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `rescheduled_from_appearance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled From Appearance Schedule ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `shoot_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shoot Schedule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Hours');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `appearance_type` SET TAGS ('dbx_business_glossary_term' = 'Appearance Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `availability_window_end` SET TAGS ('dbx_business_glossary_term' = 'Availability Window End Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `availability_window_start` SET TAGS ('dbx_business_glossary_term' = 'Availability Window Start Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `booking_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `call_time` SET TAGS ('dbx_business_glossary_term' = 'Call Time');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|cancelled|rescheduled|completed|no_show');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Hours');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `exclusivity_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Conflict Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `guild_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `guild_notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Sent Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `hold_level` SET TAGS ('dbx_business_glossary_term' = 'Hold Level');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `hold_level` SET TAGS ('dbx_value_regex' = 'confirmed|first_hold|second_hold|third_hold|first_refusal|tentative');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `playout_system_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Playout System Sync Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `playout_system_sync_status` SET TAGS ('dbx_value_regex' = 'not_synced|pending|synced|sync_failed');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `playout_system_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Playout System Sync Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `release_tracking_status` SET TAGS ('dbx_business_glossary_term' = 'Release Tracking Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `release_tracking_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|obtained|expired|declined');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `scheduling_notes` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `unavailability_reason` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`appearance_schedule` ALTER COLUMN `wrap_time` SET TAGS ('dbx_business_glossary_term' = 'Wrap Time');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `nielsen_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Cycle ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Role Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `distribution_window` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition End Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition Start Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Residual Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ACH|wire_transfer|direct_deposit|payroll');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|processed|paid|cancelled|on_hold');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `royalty_calculation_reference` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `use_type` SET TAGS ('dbx_business_glossary_term' = 'Use Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` SET TAGS ('dbx_subdomain' = 'engagement_terms');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Deal Memo ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Long-Form Contract ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Production Title ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_business_glossary_term' = 'Compensation Summary');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_business_glossary_term' = 'Countersigned Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_business_glossary_term' = 'Credit Position');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `deal_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_value_regex' = '^DM-[0-9]{6,10}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_status` SET TAGS ('dbx_value_regex' = 'draft|countersigned|superseded_by_long_form|expired|cancelled');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Summary');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_business_glossary_term' = 'Option Terms');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_business_glossary_term' = 'Role or Function');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `cba_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Rate Card Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_business_glossary_term' = 'Above-The-Line Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_business_glossary_term' = 'Appearance Count');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_business_glossary_term' = 'Character Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_business_glossary_term' = 'Credit Text');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'opening_credits|closing_credits|main_titles|end_titles|special_thanks|no_credit');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Role End Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `episode_scope_end` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope End');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `episode_scope_start` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope Start');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Role Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `role_category` SET TAGS ('dbx_business_glossary_term' = 'Role Category');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `screen_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Screen Time Minutes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Role Start Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_business_glossary_term' = 'Stunt Double Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `usage_rights_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Duration Years');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Media');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Territory');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice Only Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Identifier');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type Classification');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'talent_agency|literary_agency|management_company|law_firm|publicity_firm|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Established Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `franchise_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `franchise_number` SET TAGS ('dbx_business_glossary_term' = 'SAG-AFTRA Franchise Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_business_glossary_term' = 'SAG-AFTRA Franchise Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `franchise_status` SET TAGS ('dbx_value_regex' = 'franchised|non_franchised|pending|revoked|expired');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Legal Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'State Talent Agency License Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'Licensing State or Province');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `roster_size` SET TAGS ('dbx_business_glossary_term' = 'Talent Roster Size');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Agency Specialization');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Commission Rate Percentage');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification|dissolved');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` SET TAGS ('dbx_subdomain' = 'workforce_identity');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Email');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Phone');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Cap Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Identifier (URI)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Franchise Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_status` SET TAGS ('dbx_value_regex' = 'active|expired|terminated|suspended|pending');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_business_glossary_term' = 'Representation Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `representation_type` SET TAGS ('dbx_value_regex' = 'exclusive_agent|co_agent|manager|entertainment_attorney|business_manager|publicist');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `residual_routing_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Routing Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Signing Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `availability_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Availability ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_business_glossary_term' = 'Availability Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_value_regex' = 'available|hold|first_refusal|confirmed_booking|personal_unavailability|conflicting_production');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `booking_confirmed_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Confirmed Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|cancelled|released|expired');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `conflict_production_network` SET TAGS ('dbx_business_glossary_term' = 'Conflict Production Network');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `conflict_production_title` SET TAGS ('dbx_business_glossary_term' = 'Conflict Production Title');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `exclusivity_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Conflict Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `guild_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `guild_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Notification Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `hold_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `hold_level` SET TAGS ('dbx_business_glossary_term' = 'Hold Level');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `hold_level` SET TAGS ('dbx_value_regex' = 'first_hold|second_hold|third_hold');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `hold_placed_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `hold_released_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Availability Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Requesting Contact Email');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `requesting_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Requesting Contact Phone');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `requesting_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `requesting_producer_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Producer Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `unavailability_reason` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`availability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` SET TAGS ('dbx_subdomain' = 'engagement_terms');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `cba_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Rate Card ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `superseded_by_rate_card_cba_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate Card ID');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `budget_tier` SET TAGS ('dbx_business_glossary_term' = 'Budget Tier');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `cba_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `cba_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `cba_name` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Name');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `cba_ratification_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Ratification Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `cba_version` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Version');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `forced_call_penalty_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Forced Call Penalty Multiplier');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `golden_time_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Golden Time Multiplier');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `guild_code` SET TAGS ('dbx_business_glossary_term' = 'Guild Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `local_chapter` SET TAGS ('dbx_business_glossary_term' = 'Local Chapter');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `meal_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Meal Penalty Amount');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `minimum_scale_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Scale Rate');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Threshold Hours');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `pension_health_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Rate');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `pension_health_contribution_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `pension_health_contribution_rate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `performer_category` SET TAGS ('dbx_business_glossary_term' = 'Performer Category');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|expired|superseded|pending|draft');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'day_rate|weekly_rate|episodic_rate|theatrical_rate|session_rate|hourly_rate');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `residual_formula_code` SET TAGS ('dbx_business_glossary_term' = 'Residual Formula Code');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Hours');
ALTER TABLE `media_broadcasting_ecm`.`talent`.`cba_rate_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
