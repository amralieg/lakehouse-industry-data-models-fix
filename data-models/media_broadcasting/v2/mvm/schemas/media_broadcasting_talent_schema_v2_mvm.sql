-- Schema for Domain: talent | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-23 04:24:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`talent` COMMENT 'Manages all on-screen and off-screen talent relationships — actors, directors, writers, producers, hosts, correspondents, and crew. Tracks talent contracts, guild affiliations (SAG-AFTRA, WGA, DGA), residual payment eligibility, exclusivity clauses, compensation structures, usage rights, appearance schedules, and credit attribution. Serves as the authoritative source for talent identity referenced by production, rights, and royalty workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique identifier for the talent profile record. Primary key for the talent master entity.',
    `talent_agency_id` BIGINT COMMENT 'FK to talent.talent_agency',
    `biometric_consent_flag` BOOLEAN COMMENT 'Indicates whether the talent has provided consent for collection and use of biometric data (facial recognition, voice prints) for digital effects, deepfake prevention, and AI training. Required for GDPR and CCPA compliance.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the talent has opted out of the sale or sharing of their personal information under CCPA. Required for California-based talent or productions.',
    `clearance_expiration_date` DATE COMMENT 'The date when the talents current clearance status expires and requires renewal. Used for compliance tracking and production eligibility verification.',
    `clearance_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the talent profile record was first created in the system. Used for audit trail and data lineage tracking.',
    `date_of_birth` DATE COMMENT 'The talents date of birth. Required for age verification, child labor law compliance (COPPA), insurance underwriting, and residual payment calculations.',
    `email_address` STRING COMMENT 'The primary email address for talent communication, contract delivery, and digital correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `exclusivity_clause_flag` BOOLEAN COMMENT 'Indicates whether the talent is currently bound by an exclusivity clause that restricts their ability to work with competing networks, studios, or brands. Used for conflict checking during casting and booking.',
    `gdpr_consent_status` STRING COMMENT '',
    `gender_identity` STRING COMMENT 'The talents self-identified gender. Used for diversity reporting, casting analytics, and compliance with equal opportunity regulations.. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `imdb_identifier` STRING COMMENT 'The talents unique identifier in the Internet Movie Database (IMDb). Used for cross-referencing filmography, public profile linking, and industry data integration.. Valid values are `^nm[0-9]{7,8}$`',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether the talent is currently covered by production insurance (liability, workers compensation, errors and omissions). Required for on-set work authorization.',
    `insurance_policy_number` STRING COMMENT 'The policy number for the talents production insurance coverage. Used for claims processing and certificate of insurance verification.',
    `isni_code` STRING COMMENT '',
    `legal_name` STRING COMMENT 'The full legal name of the talent as it appears on official documents and contracts. Used for contract execution, payroll, and legal compliance.',
    `nationality` STRING COMMENT 'The talents nationality represented as a 3-letter ISO country code. Used for work authorization, tax treaty eligibility, and international co-production compliance.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special requirements, or contextual information about the talent. Used for casting notes, production preferences, and internal communication.',
    `phone_number` STRING COMMENT 'The primary contact phone number for the talent. Used for production scheduling, emergency contact, and direct communication.',
    `primary_language` STRING COMMENT 'The talents primary working language represented as a 2-letter ISO language code. Used for casting, dubbing, and localization workflows.. Valid values are `^[a-z]{2}$`',
    `profile_status` STRING COMMENT '',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of their work in syndication, streaming, or international distribution. Determined by union status and contract terms.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `stage_name` STRING COMMENT 'The professional or stage name used by the talent for public appearances, credits, and marketing materials. May differ from legal name.',
    `talent_tier` STRING COMMENT '',
    `talent_type` STRING COMMENT '',
    `tax_id_number` STRING COMMENT 'The talents tax identification number (SSN, EIN, or international equivalent). Required for payroll processing, tax withholding, and IRS 1099 reporting.',
    `union_affiliation` STRING COMMENT 'The primary labor union or guild affiliation of the talent. Determines contract terms, minimum compensation, residual eligibility, and working conditions.. Valid values are `sag_aftra|wga|dga|iatse|non_union|multiple`',
    `union_member_number` STRING COMMENT 'The talents membership identifier within their primary union or guild. Required for residual payment processing and contract compliance verification.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the talent profile record was last modified. Used for change tracking and data freshness verification.',
    `work_authorization_status` STRING COMMENT '',
    `work_visa_expiration_date` DATE COMMENT 'The expiration date of the talents work visa. Critical for production scheduling and compliance with immigration regulations.',
    `work_visa_type` STRING COMMENT '',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Master identity record for all on-screen and off-screen talent — actors, directors, writers, producers, hosts, correspondents, crew, and voice artists. Stores legal name, stage name, date of birth, nationality, gender identity, primary language, union membership references, talent tier classification, representation agency references, IMDb/ISNI identifiers, biometric consent flags, data privacy status (GDPR/CCPA), clearance status, and active/inactive lifecycle state. Serves as the authoritative SSOT for talent identity referenced by production, rights, royalty, and scheduling workflows across the enterprise.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` (
    `guild_affiliation_id` BIGINT COMMENT 'Unique identifier for the guild affiliation record. Primary key.',
    `profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, crew member) who holds this guild membership.',
    `cba_effective_date` DATE COMMENT 'Date when the current collective bargaining agreement became effective for this membership.',
    `cba_expiration_date` DATE COMMENT 'Date when the current collective bargaining agreement expires. Used to track contract renewal cycles and potential rate changes.',
    `cba_version` STRING COMMENT 'Version or year identifier of the collective bargaining agreement that governs this membership. Critical for determining applicable residual rates, working conditions, and compensation structures.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this guild affiliation record was first created in the system.',
    `dues_payment_status` STRING COMMENT 'Current status of membership dues payment obligations. Current (all dues paid up to date), overdue (payment past due but within grace period), delinquent (significantly past due, may affect standing), exempt (not required to pay dues), waived (dues forgiven by guild).. Valid values are `current|overdue|delinquent|exempt|waived`',
    `guild_code` STRING COMMENT '',
    `guild_name` STRING COMMENT 'Full legal name of the guild or union organization.',
    `health_benefits_eligible_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible for guild-provided health insurance benefits based on this membership and earnings thresholds. True if eligible, false otherwise.',
    `join_date` DATE COMMENT 'Date when the talent officially became a member of this guild. Used to determine seniority and eligibility for certain benefits.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction or country where this guild membership is registered and governed. USA (United States), CAN (Canada), GBR (United Kingdom), AUS (Australia), NZL (New Zealand), IRL (Ireland). [ENUM-REF-CANDIDATE: USA|CAN|GBR|AUS|NZL|IRL|OTHER — 7 candidates stripped; promote to reference product]',
    `last_dues_payment_date` DATE COMMENT 'Date of the most recent membership dues payment received by the guild.',
    `local_chapter` STRING COMMENT 'Local chapter, branch, or regional division of the guild to which this membership is assigned. Used for regional governance and event coordination.',
    `membership_number` STRING COMMENT 'Unique membership identifier assigned by the guild to the talent member. Required for residual payment processing and production compliance verification.',
    `membership_status` STRING COMMENT '',
    `next_dues_payment_date` DATE COMMENT 'Date when the next membership dues payment is due.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or remarks about this guild membership. May include information about membership restrictions, special accommodations, or historical context.',
    `pension_eligible_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible for guild pension plan contributions and benefits. True if eligible, false otherwise.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this guild membership makes the talent eligible to receive residual payments for reuse of their work. True if eligible, false otherwise. Critical for royalty calculation workflows.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `termination_date` DATE COMMENT 'Date when the guild membership ended, whether through resignation, expulsion, or other termination. Null for active memberships.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this guild affiliation record was last modified in the system.',
    `verification_date` DATE COMMENT 'Date when the guild membership status was last verified with the guild organization. Used to ensure data accuracy for production compliance.',
    CONSTRAINT pk_guild_affiliation PRIMARY KEY(`guild_affiliation_id`)
) COMMENT 'Tracks each talents formal membership and standing within entertainment industry guilds and unions — SAG-AFTRA, WGA (Writers Guild of America), DGA (Directors Guild of America), IATSE, AFM (American Federation of Musicians), and international equivalents (BECTU, ACTRA). Records membership number, guild code, membership tier (full member, fi-core, apprentice), join date, current standing (good standing, suspended, resigned), dues payment status, and applicable collective bargaining agreement (CBA) version. Critical for residual eligibility determination and production compliance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique identifier for the talent contract record. Primary key for the talent contract entity.',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: contract.guild_affiliation is a denormalized STRING storing the guild name/code. Replacing it with guild_affiliation_id FK to guild_affiliation normalizes this to the authoritative guild record for th',
    `profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) engaged under this contract.',
    `representation_agreement_id` BIGINT COMMENT 'Foreign key linking to talent.representation_agreement. Business justification: contract.talent_representative_agency and contract.talent_representative_name are denormalized STRINGs capturing the agency and agent at contract signing. Replacing these with representation_agreement',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Talent contracts for episodic content are series-level agreements with episode guarantees, option periods, and multi-season terms. Fundamental to TV production contracting and long-form content busine',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Film and one-off special talent contracts attach to a specific title, not a series. The existing series_id only covers episodic TV. Without title_id, film actor and director contracts have no content ',
    `amendment_count` STRING COMMENT 'The total number of formal amendments made to this contract since initial execution. Tracks contract modification history.',
    `backend_participation_percentage` DECIMAL(18,2) COMMENT 'The percentage of net profits, adjusted gross, or other revenue streams the talent is entitled to receive after recoupment of production costs. Common for above-the-line talent.',
    `base_compensation_amount` DECIMAL(18,2) COMMENT 'The guaranteed base fee or salary payable to the talent for services rendered under this contract, excluding bonuses, backend participation, and residuals.',
    `billing_credit_position` STRING COMMENT 'The contractually specified position and format of the talents on-screen credit (e.g., First Position Main Title, Shared Card, Single Card, Above the Title). Critical for talent reputation and guild compliance.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the base compensation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `compensation_structure` STRING COMMENT 'The payment model for the base compensation. Flat fee is a single lump sum; per-episode is paid per episode produced; weekly/annual/day/hourly rates define periodic payment schedules.. Valid values are `flat_fee|per_episode|weekly_rate|annual_salary|day_rate|hourly_rate`',
    `contract_number` STRING COMMENT 'Business identifier for the contract, typically assigned by legal or business affairs. Used for external reference and tracking.',
    `contract_status` STRING COMMENT '',
    `contract_type` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
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
    `option_periods_count` STRING COMMENT 'The number of option periods (typically annual) the company holds to extend the contract beyond the initial term. Common in series regular and overall deals.',
    `pay_or_play_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a pay-or-play provision, guaranteeing full compensation even if the talent services are not ultimately used or the production is cancelled.',
    `residual_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the talent is eligible to receive residual payments for reuse of the content (reruns, streaming, international distribution, home video). Governed by guild CBAs.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `step_up_amount` DECIMAL(18,2) COMMENT 'The incremental increase in base compensation for each exercised option period or season renewal. Null if no step-up provision exists.',
    `termination_date` DATE COMMENT 'The date on which the contract was terminated prior to its natural expiration. Null if contract was not terminated early.',
    `termination_reason` STRING COMMENT 'The primary reason for early contract termination. Null if contract was not terminated early. [ENUM-REF-CANDIDATE: mutual_agreement|breach_of_contract|force_majeure|production_cancellation|talent_unavailability|company_convenience|talent_request|other — 8 candidates stripped; promote to reference product]',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Authoritative record of each talent engagement from initial deal memo through executed long-form contract — covering series regular deals, episodic guest agreements, overall deals, first-look deals, and crew contracts. Captures contract lifecycle stage (deal memo, countersigned, long-form executed), compensation structure (base fee, guarantees, backend participation, step-ups, pay-or-play), exclusivity and holdback restrictions, option periods with exercise status, amendment history, billing credit position, governing CBA, and document references. Source of truth for all commercial terms, obligations, and contractual modifications throughout the talent engagement lifecycle.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` (
    `compensation_structure_id` BIGINT COMMENT 'Unique identifier for the compensation structure record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent talent contract to which this compensation structure is attached.',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: compensation_structure.guild_affiliation is a denormalized STRING. Compensation terms — particularly pension_health_rate, residual_base_formula, and overtime_multiplier — are directly governed by the ',
    `backend_gross_participation_pct` DECIMAL(18,2) COMMENT 'The percentage of adjusted gross receipts or backend profits the talent is entitled to receive (e.g., 0.05 for 5% backend participation). Null if no backend participation is granted.',
    `base_episode_fee` DECIMAL(18,2) COMMENT 'The guaranteed compensation amount per episode for episodic talent (actors, writers, directors). Expressed in the contract currency.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'The fixed or maximum bonus amount payable when the bonus threshold is met. Expressed in the contract currency. Null if no bonus provision exists.',
    `bonus_threshold_description` STRING COMMENT 'Textual description of the performance or milestone thresholds that trigger bonus payments (e.g., Nielsen rating above 2.0 in key demo, box office exceeds $100M domestic).',
    `compensation_type` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation structure record was first created in the system.',
    `currency_code` STRING COMMENT '',
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
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `step_up_amount` DECIMAL(18,2) COMMENT 'The incremental compensation increase amount when the step-up trigger is met. Expressed in the contract currency. Null if no step-up provision exists.',
    `step_up_trigger` STRING COMMENT 'The condition or event that triggers an automatic increase in compensation (e.g., season_2_pickup, episode_13_renewal, ratings_threshold). Null if no step-up provision exists.',
    `structure_name` STRING COMMENT 'Business-friendly name or label for this compensation structure (e.g., Series Regular Season 1, Guest Star Rate Card).',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `usage_rights_scope` STRING COMMENT 'Description of the media usage rights covered by this compensation structure (e.g., initial broadcast only, all media in perpetuity, theatrical and SVOD, domestic free television). Defines what exploitation is covered by the base compensation.',
    `weekly_guarantee` DECIMAL(18,2) COMMENT 'The guaranteed weekly compensation amount for talent engaged on a weekly basis (e.g., series regulars, production staff). Expressed in the contract currency.',
    CONSTRAINT pk_compensation_structure PRIMARY KEY(`compensation_structure_id`)
) COMMENT 'Defines the detailed compensation terms attached to a talent contract — including base episode fee, weekly guarantee, daily rate, overtime multipliers, pension and health (P&H) contribution rates, residual base formula, backend gross participation percentage, deferred compensation schedule, and currency. Supports both union scale (SAG-AFTRA scale, DGA scale) and over-scale deals. Tracks step-up triggers (e.g., series pickup escalators), bonus thresholds, and pay-or-play provisions. Used by payroll and royalty workflows to calculate gross compensation and residual bases.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` (
    `residual_payment_id` BIGINT COMMENT 'Unique identifier for the residual payment transaction.',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing this residual payment.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Guild residual formulas (SAG-AFTRA, WGA, DGA) apply different rates by distribution medium. Linking residual_payment to delivery_channel enables automated, auditable residual calculation by medium (br',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: residual_payment.guild_affiliation is a denormalized STRING. Residual payments are calculated and governed by guild CBA rules — the applicable guild determines the residual formula, pension/health con',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (title, episode, or version) for which the residual is being paid.',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Production finance teams track total residual obligations per project for P&L reporting and guild audit compliance. Residual payments are triggered by exhibition of content from a specific production ',
    `profile_id` BIGINT COMMENT 'Reference to the talent receiving the residual payment.',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Residual payments are triggered by specific exhibition windows. Linking residual_payment to release_window replaces the denormalized distribution_window text field with a precise FK, enabling guild au',
    `representation_agreement_id` BIGINT COMMENT 'Foreign key linking to talent.representation_agreement. Business justification: residual_payment.agent_commission_amount is calculated based on the commission_percentage in the representation_agreement. Adding representation_agreement_id FK links each residual payment to the gove',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Residual payments are triggered by exhibition of a specific title. Guild compliance (SAG-AFTRA, WGA, DGA) requires residual audit reports by title. Without this FK, residual payment records cannot be ',
    `ach_trace_number` STRING COMMENT 'The ACH trace number if the payment method is ACH or direct deposit, used for reconciliation and audit.',
    `agent_commission_amount` DECIMAL(18,2) COMMENT 'The agent or manager commission amount deducted from the residual payment, if applicable.',
    `audit_report_date` DATE COMMENT 'The date on which this residual payment was included in a guild audit report.',
    `audit_report_flag` BOOLEAN COMMENT 'Indicates whether this residual payment has been included in a guild audit report (SAG-AFTRA, WGA, DGA).',
    `check_number` STRING COMMENT 'The check number if the payment method is check, used for reconciliation and audit.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was first created in the system.',
    `exhibition_end_date` DATE COMMENT 'The end date of the exhibition period for which this residual is calculated.',
    `exhibition_start_date` DATE COMMENT 'The start date of the exhibition period for which this residual is calculated.',
    `gross_residual_amount` DECIMAL(18,2) COMMENT 'The gross residual amount calculated before deductions, in the payment currency.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net residual payment amount after all deductions, paid to the talent.',
    `payment_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the residual payment (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the residual payment was issued or disbursed to the talent.',
    `payment_method` STRING COMMENT 'The method used to disburse the residual payment to the talent.. Valid values are `check|ACH|wire_transfer|direct_deposit|payroll`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments related to this residual payment, including special circumstances, adjustments, or exceptions.',
    `payment_number` STRING COMMENT 'Business identifier for the residual payment, used for external reference and reconciliation.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the residual payment transaction.. Valid values are `pending|approved|processed|paid|cancelled|on_hold`',
    `pension_health_amount` DECIMAL(18,2) COMMENT 'The pension and health contribution amount deducted from the gross residual, as required by guild agreements.',
    `remittance_advice_sent_date` DATE COMMENT 'The date on which the remittance advice was sent to the talent.',
    `remittance_advice_sent_flag` BOOLEAN COMMENT 'Indicates whether a remittance advice document was sent to the talent for this payment.',
    `royalty_calculation_reference` BIGINT COMMENT 'Reference to the Rightsline royalty calculation record that generated this residual payment.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this residual payment record was last modified.',
    `wire_reference_number` STRING COMMENT 'The wire transfer reference number if the payment method is wire transfer, used for reconciliation and audit.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The tax amount withheld from the residual payment for federal, state, or foreign tax obligations.',
    CONSTRAINT pk_residual_payment PRIMARY KEY(`residual_payment_id`)
) COMMENT 'Transactional record of each residual payment issued to talent for reuse of content across broadcast, home video, streaming (SVOD, AVOD, TVOD), FAST, and foreign distribution windows. Captures payment cycle, content asset reference, use type, distribution window, gross residual amount, P&H contribution amount, withholding tax amount, net payment amount, payment method, payment date, check or ACH reference, and remittance advice sent flag. Reconciles against Rightsline royalty calculations and SAP S/4HANA AP postings. Supports SAG-AFTRA and WGA audit requirements.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` (
    `deal_memo_id` BIGINT COMMENT 'Unique identifier for the talent deal memo record. Primary key.',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: deal_memo.guild_affiliation is a denormalized STRING. Deal memos capture pre-contract commercial terms that must reference the applicable guild agreement to ensure CBA compliance from the earliest sta',
    `contract_id` BIGINT COMMENT 'Reference to the executed long-form talent contract that supersedes this deal memo. Null if the long-form contract has not yet been executed.',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Deal memos are issued for specific production projects; production managers need to retrieve all active deal memos per project for greenlight approvals, above-the-line budget validation, and cast/crew',
    `title_id` BIGINT COMMENT 'Reference to the production title (series, episode, film, special) for which the talent is engaged.',
    `profile_id` BIGINT COMMENT 'Reference to the talent (actor, director, writer, producer, host, correspondent, crew member) engaged under this deal memo.',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to sales.sales_proposal. Business justification: In branded content and sponsorship workflows, an approved sales proposal triggers a talent deal memo for the featured talent. Linking deal_memo to sales_proposal enables end-to-end traceability from s',
    `representation_agreement_id` BIGINT COMMENT 'Foreign key linking to talent.representation_agreement. Business justification: deal_memo.agent_name, agent_contact_email, and agent_contact_phone are denormalized STRINGs duplicating data from the representation_agreement. Replacing these with representation_agreement_id FK link',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Deal memos for episodic content reference series for series commitment tracking, multi-season option terms, and episode count guarantees. Essential for TV talent deal management.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The primary monetary compensation amount agreed in the deal memo (e.g., total fee, per-episode rate, or guaranteed minimum).',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `compensation_summary` STRING COMMENT 'High-level summary of the compensation structure agreed in the deal memo (e.g., per-episode fee, flat fee, day rate, backend participation). Detailed breakdowns are captured in the long-form contract.',
    `countersigned_date` DATE COMMENT 'The date on which the deal memo was countersigned by both the talent (or agent) and the production company, making it a binding interim agreement. Null if not yet countersigned.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deal memo record was first created in the system.',
    `credit_position` STRING COMMENT 'The agreed on-screen or off-screen credit position and format (e.g., Main Title Card, Opening Credits, End Crawl, Shared Card, Single Card).',
    `deal_date` DATE COMMENT 'The date on which the deal terms were verbally agreed or the deal memo was initially drafted.',
    `deal_memo_number` STRING COMMENT 'Externally-known unique business identifier for the deal memo, typically generated by the CRM or legal system.. Valid values are `^DM-[0-9]{6,10}$`',
    `deal_memo_status` STRING COMMENT '',
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
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `superseded_date` DATE COMMENT 'The date on which the deal memo was superseded by the execution of a long-form contract. Null if not yet superseded.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_deal_memo PRIMARY KEY(`deal_memo_id`)
) COMMENT 'Pre-contract deal memo capturing the agreed commercial terms for a talent engagement before the formal long-form contract is executed — including deal date, production title, role or function, episode count, start date, compensation summary, credit position, exclusivity summary, option terms, and deal memo status (draft, countersigned, superseded by long-form). Serves as the binding interim agreement used by production and legal teams during the gap between verbal deal and executed contract. Sourced from Salesforce Media Cloud opportunity and proposal records.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`role` (
    `role_id` BIGINT COMMENT 'Unique identifier for the talent role assignment. Primary key for the talent role entity.',
    `contract_id` BIGINT COMMENT 'Reference to the talent contract governing the terms of this role engagement, including compensation, usage rights, and obligations.',
    `episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level talent appearance tracking is required for SAG-AFTRA/WGA residual calculation and credit verification. A role is performed in specific episodes; without this FK, residual audits and epis',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: role.guild_affiliation is a denormalized STRING. Each role performed by talent is governed by the applicable guild agreement — determining residual_rate_code, usage_rights_media scope, and above_the_l',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Rights clearance, residual calculation, and usage tracking require knowing which media asset contains a talents performance. A rights analyst running all assets featuring talent X or all talent in',
    `profile_id` BIGINT COMMENT 'Reference to the talent individual performing this role. Links to the talent master entity.',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Roles often span specific seasons requiring season-level tracking for season-specific compensation, per-season credits, and availability scheduling. Eliminates denormalized season_number and provides ',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Roles in episodic content must link to series for multi-season contract tracking, series-level residuals, and long-term talent availability management. Essential for TV production business model.',
    `title_id` BIGINT COMMENT 'Reference to the content asset or production in which this role is performed. Links to the content master entity.',
    `above_the_line_flag` BOOLEAN COMMENT 'Indicates whether this role is classified as above-the-line (creative principals: actors, directors, writers, producers) or below-the-line (technical crew and support staff). Impacts budget allocation and residual calculations.',
    `appearance_count` STRING COMMENT 'Total number of episodes, segments, or appearances in which this talent role is featured. Used for episodic and recurring roles.',
    `billing_position` STRING COMMENT 'The numerical order in which the talent appears in the credits (1 = first billed, 2 = second billed, etc.). Determines prominence in marketing materials and on-screen credits.',
    `role_category` STRING COMMENT '',
    `character_name` STRING COMMENT 'The name of the character portrayed by the talent for on-screen roles. Null for off-screen roles such as crew, directors, or producers.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The monetary compensation amount for this role engagement in the contract currency. Excludes residuals and backend participation.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this talent role record was first created in the system.',
    `credit_text` STRING COMMENT 'The exact text of the credit as it appears on-screen or in marketing materials, including any special formatting or possessory credits (e.g., A Film By, Created By).',
    `end_date` DATE COMMENT 'The date on which the talents engagement for this role concludes. Null for ongoing or open-ended engagements.',
    `episode_scope_end` STRING COMMENT 'The last episode number in which this talent role appears. Null indicates ongoing engagement or single-episode appearance.',
    `episode_scope_start` STRING COMMENT 'The first episode number in which this talent role appears. Used for episodic content to define the scope of the talents engagement.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the talent is bound by exclusivity clauses preventing them from performing similar roles for competing productions during the engagement period.',
    `exclusivity_scope` STRING COMMENT 'Description of the scope and limitations of any exclusivity clause (e.g., No competing streaming series, No theatrical films during production).',
    `role_name` STRING COMMENT 'The specific role or function the talent is engaged to perform (e.g., Lead Actor, Director, Executive Producer, Cinematographer, Script Supervisor).',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about this talent role assignment (e.g., special credit requirements, scheduling constraints, performance notes).',
    `residual_eligible_flag` BOOLEAN COMMENT 'Indicates whether this role is eligible for residual payments based on subsequent distribution, reuse, or syndication of the content. Determined by guild agreements and contract terms.',
    `residual_rate_code` STRING COMMENT 'Code identifying the residual payment rate schedule applicable to this role based on guild agreements, role category, and distribution windows.',
    `screen_time_minutes` DECIMAL(18,2) COMMENT 'Total on-screen time in minutes for this talent role across all appearances. Used for on-screen talent to measure prominence and for residual calculations.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `start_date` DATE COMMENT 'The date on which the talents engagement for this role begins, typically the first day of principal photography, recording, or production work.',
    `stunt_double_flag` BOOLEAN COMMENT 'Indicates whether this role involves stunt work or if a stunt double is used for this character. Impacts insurance, safety protocols, and credit attribution.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this talent role record was last modified in the system.',
    `usage_rights_duration_years` STRING COMMENT 'Number of years for which usage rights are granted. Null indicates perpetual rights.',
    `usage_rights_media` STRING COMMENT 'Media platforms and formats for which usage rights are granted (e.g., Theatrical, Home Video, Streaming, Broadcast TV).',
    `usage_rights_territory` STRING COMMENT 'Geographic territories in which the content featuring this talent role may be distributed and exploited (e.g., Worldwide, North America, USA and Canada).',
    `voice_only_flag` BOOLEAN COMMENT 'Indicates whether this is a voice-only role (voice-over, narration, animation, ADR) with no on-screen physical appearance by the talent.',
    CONSTRAINT pk_role PRIMARY KEY(`role_id`)
) COMMENT 'Defines the specific role or function a talent is engaged to perform within a production or content asset — capturing role name, character name (for on-screen talent), role category (series regular, recurring, guest star, day player, featured extra, host, correspondent, narrator, voice artist, director, writer, showrunner, executive producer, line producer, DP, editor), above-the-line or below-the-line classification, episode or segment scope, and role status. Provides the granular link between talent identity and their specific creative contribution to each content asset.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` (
    `talent_agency_id` BIGINT COMMENT 'Unique identifier for the talent agency or management company. Primary key for the talent_agency product.',
    `address_line_1` STRING COMMENT 'The first line of the agencys primary business address, typically containing street number and street name.',
    `address_line_2` STRING COMMENT 'The second line of the agencys primary business address, typically containing suite, floor, or building information.',
    `bank_account_name` STRING COMMENT 'The name on the bank account used for commission and residual payments to the agency.',
    `bank_account_number` STRING COMMENT 'The bank account number for electronic funds transfer of commissions and residuals to the agency.',
    `bank_routing_number` STRING COMMENT 'The bank routing number (ABA number in the US, sort code in UK, or equivalent) for electronic funds transfer of commissions and residuals.',
    `city` STRING COMMENT 'The city or municipality where the agencys primary office is located.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent agency record was first created in the system. Immutable audit field.',
    `dba_name` STRING COMMENT 'The trade name or doing-business-as name under which the agency operates, if different from the legal name.',
    `established_date` DATE COMMENT 'The date on which the talent agency was originally established or incorporated.',
    `fax_number` STRING COMMENT 'The fax number for the agency, used for contract transmission and official correspondence in jurisdictions where fax is still required.',
    `franchise_effective_date` DATE COMMENT 'The date on which the SAG-AFTRA franchise agreement became effective for this agency.',
    `franchise_expiration_date` DATE COMMENT 'The date on which the current SAG-AFTRA franchise agreement expires and must be renewed.',
    `franchise_number` STRING COMMENT 'The unique franchise identification number issued by SAG-AFTRA to franchised talent agencies.',
    `legal_name` STRING COMMENT 'The full legal registered name of the talent agency or management company as it appears on contracts and official documents.',
    `license_effective_date` DATE COMMENT 'The date on which the state talent agency license became effective.',
    `license_expiration_date` DATE COMMENT 'The date on which the state talent agency license expires and must be renewed.',
    `license_number` STRING COMMENT 'The state-issued license number authorizing the agency to operate as a talent agency. Required in jurisdictions such as California under the Talent Agencies Act.',
    `notes` STRING COMMENT 'Free-form notes field for additional context, special handling instructions, historical information, or relationship management details relevant to the agency.',
    `payment_terms` STRING COMMENT 'The standard payment terms and conditions for commission remittance, including timing and method of payment (e.g., net 30 days, upon talent payment receipt).',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person at the agency for contract negotiations, deal correspondence, and residual remittances.',
    `primary_contact_title` STRING COMMENT 'The job title or role of the primary contact person (e.g., President, Partner, Agent, Business Affairs Manager).',
    `primary_email` STRING COMMENT 'The primary email address for official correspondence, contract delivery, and residual payment notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'The primary telephone number for the agency, including country and area codes.',
    `roster_size` STRING COMMENT 'The approximate number of talent clients currently represented by the agency. Used for agency scale assessment and negotiation context.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `specialization` STRING COMMENT 'The primary area of talent specialization or focus for the agency (e.g., film and television actors, commercial talent, voice-over artists, writers, directors, below-the-line crew, music artists). Free-text field to accommodate multiple specializations.',
    `standard_commission_rate` DECIMAL(18,2) COMMENT 'The standard commission rate percentage that the agency charges for talent representation, typically 10% for franchised agencies under SAG-AFTRA rules. Expressed as a percentage (e.g., 10.00 for 10%).',
    `state_province` STRING COMMENT 'The state, province, or region where the agencys primary office is located. Use standard two-letter codes where applicable.',
    `status_effective_date` DATE COMMENT 'The date on which the current status became effective.',
    `talent_agency_status` STRING COMMENT '',
    `tax_identifier` STRING COMMENT 'The tax identification number (EIN in the US, VAT number in EU) for the agency, used for tax reporting and residual payment processing.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent agency record was last modified. Updated automatically on any change to the record.',
    `verification_date` DATE COMMENT 'The date on which the agency information was last verified for accuracy and currency, typically through direct contact or regulatory registry check.',
    `website_url` STRING COMMENT 'The primary website URL for the talent agency, used for public information and talent roster visibility.',
    CONSTRAINT pk_talent_agency PRIMARY KEY(`talent_agency_id`)
) COMMENT 'Master record for talent representation agencies and management companies — capturing agency legal name, agency type (talent agency, literary agency, management company, law firm), primary contact, address, phone, email, franchise status (SAG-AFTRA franchised agency flag), commission rate standard, and active/inactive status. Serves as the reference for routing deal negotiations, contract correspondence, and residual remittances to the correct representative. Distinct from the partner domain which manages distribution and content partners.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` (
    `representation_agreement_id` BIGINT COMMENT 'Unique identifier for the representation agreement record. Primary key.',
    `profile_id` BIGINT COMMENT 'Reference to the talent being represented under this agreement.',
    `talent_agency_id` BIGINT COMMENT 'Foreign key linking to talent.talent_agency. Business justification: representation_agreement currently has agency_name (STRING) duplicating data from talent_agency. Adding FK enables normalization - agency legal name, DBA name, contact details, and franchise status sh',
    `agent_contact_email` STRING COMMENT 'Primary email address for the agent or representative, used for deal negotiation and residual routing communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agent_contact_phone` STRING COMMENT 'Primary phone number for the agent or representative.',
    `agent_name` STRING COMMENT 'Full name of the individual agent, manager, or attorney assigned as primary contact for this representation.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for this representation agreement, used for contract reference and audit trails.',
    `commission_cap_amount` DECIMAL(18,2) COMMENT 'Maximum commission amount per engagement or per year, if a cap is specified in the agreement. Null if no cap applies.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Percentage of talent earnings paid to the representative as commission (typically 10% for agents, 15% for managers per industry standards).',
    `contract_document_uri` STRING COMMENT 'URI or file path to the signed representation agreement contract document stored in the Media Asset Management (MAM) system or document repository.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this representation agreement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the representation agreement expires or terminates. Null for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the representation agreement becomes binding and the representative begins acting on behalf of the talent.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this representation is exclusive (true) or non-exclusive (false). Exclusive agreements prohibit the talent from engaging other representatives in the same category and territory.',
    `guild_franchise_flag` BOOLEAN COMMENT 'Indicates whether the agency or representative is franchised by a talent guild (SAG-AFTRA, WGA, DGA). Franchised agents must comply with guild-mandated commission caps and contract terms.',
    `notes` STRING COMMENT 'Free-text notes capturing special clauses, amendments, or contextual information about the representation agreement.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an automatic renewal option or requires explicit renegotiation at expiration.',
    `renewal_terms` STRING COMMENT 'Description of renewal terms if renewal_option_flag is true, including renewal period length and any modified commission rates.',
    `representation_agreement_status` STRING COMMENT '',
    `residual_routing_flag` BOOLEAN COMMENT 'Indicates whether residual payments for work performed during this representation period should be routed through this representative for commission deduction.',
    `scope_of_services` STRING COMMENT 'Detailed description of services the representative will provide: deal negotiation, career guidance, audition scheduling, contract review, brand partnerships, etc.',
    `signing_date` DATE COMMENT 'Date when the representation agreement was signed by both parties.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `termination_date` DATE COMMENT 'Actual date the representation agreement was terminated, if applicable. Used for residual routing cutoff and historical audit trails.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the representation agreement (commonly 30, 60, or 90 days).',
    `termination_reason` STRING COMMENT 'Reason for early termination of the representation agreement, if applicable. [ENUM-REF-CANDIDATE: mutual_agreement|talent_initiated|agent_initiated|breach_of_contract|expiration|non_performance|conflict_of_interest — 7 candidates stripped; promote to reference product]',
    `territory_scope` STRING COMMENT 'Geographic territory or market scope covered by this representation agreement (e.g., worldwide, North America, USA, specific states). Multiple territories may be comma-separated.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this representation agreement record was last modified.',
    CONSTRAINT pk_representation_agreement PRIMARY KEY(`representation_agreement_id`)
) COMMENT 'Records the formal representation relationship between a talent and their agency or management company — capturing representation type (exclusive agent, co-agent, manager, entertainment attorney), territory scope, commission percentage, agreement start and end dates, exclusivity flag, termination notice period, and current status. Tracks historical representation changes to support residual routing and deal negotiation audit trails. A talent may have multiple concurrent representation agreements across different territories or function types.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ADD CONSTRAINT `fk_talent_profile_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_agency`(`talent_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ADD CONSTRAINT `fk_talent_guild_affiliation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ADD CONSTRAINT `fk_talent_contract_representation_agreement_id` FOREIGN KEY (`representation_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`representation_agreement`(`representation_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ADD CONSTRAINT `fk_talent_compensation_structure_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ADD CONSTRAINT `fk_talent_residual_payment_representation_agreement_id` FOREIGN KEY (`representation_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`representation_agreement`(`representation_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ADD CONSTRAINT `fk_talent_deal_memo_representation_agreement_id` FOREIGN KEY (`representation_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`representation_agreement`(`representation_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`contract`(`contract_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_guild_affiliation_id` FOREIGN KEY (`guild_affiliation_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`(`guild_affiliation_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ADD CONSTRAINT `fk_talent_role_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`profile`(`profile_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ADD CONSTRAINT `fk_talent_representation_agreement_talent_agency_id` FOREIGN KEY (`talent_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`talent`.`talent_agency`(`talent_agency_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`talent` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`talent` SET TAGS ('dbx_domain' = 'talent');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the talent profile record. Primary key for the talent master entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_column_comment' = 'FK to talent.talent_agency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Data Consent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent has provided consent for collection and use of biometric data (facial recognition');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_voice_prints)_for_digital_effects' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_deepfake_prevention' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_and_AI_training_Required_for_GDPR_and_CCPA_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `biometric_consent_flag` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent has opted out of the sale or sharing of their personal information under CCPA. Required for California-based talent or productions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_regulation' = 'CCPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `clearance_expiration_date` SET TAGS ('dbx_column_comment' = 'The date when the talents current clearance status expires and requires renewal. Used for compliance tracking and production eligibility verification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when the talent profile record was first created in the system. Used for audit trail and data lineage tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_column_comment' = 'The talents date of birth. Required for age verification');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_child_labor_law_compliance_(COPPA)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_insurance_underwriting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_and_residual_payment_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_column_comment' = 'The primary email address for talent communication');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_contract_delivery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_and_digital_correspondence' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is currently bound by an exclusivity clause that restricts their ability to work with competing networks');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_studios' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_or_brands_Used_for_conflict_checking_during_casting_and_booking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_column_comment' = 'The talents self-identified gender. Used for diversity reporting');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_casting_analytics' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_and_compliance_with_equal_opportunity_regulations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_business_glossary_term' = 'Internet Movie Database (IMDb) Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_value_regex' = '^nm[0-9]{7,8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_column_comment' = 'The talents unique identifier in the Internet Movie Database (IMDb). Used for cross-referencing filmography');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_public_profile_linking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `imdb_identifier` SET TAGS ('dbx_and_industry_data_integration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is currently covered by production insurance (liability');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_workers_compensation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_errors_and_omissions)_Required_for_on_set_work_authorization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_column_comment' = 'The policy number for the talents production insurance coverage. Used for claims processing and certificate of insurance verification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_column_comment' = 'The full legal name of the talent as it appears on official documents and contracts. Used for contract execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_payroll' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_and_legal_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `legal_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_column_comment' = 'The talents nationality represented as a 3-letter ISO country code. Used for work authorization');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_tax_treaty_eligibility' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `nationality` SET TAGS ('dbx_and_international_co_production_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-form text field for additional notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_special_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_or_contextual_information_about_the_talent_Used_for_casting_notes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_production_preferences' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_and_internal_communication' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_column_comment' = 'The primary contact phone number for the talent. Used for production scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_emergency_contact' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_and_direct_communication' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_column_comment' = 'The talents primary working language represented as a 2-letter ISO language code. Used for casting');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_dubbing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_and_localization_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is eligible to receive residual payments for reuse of their work in syndication');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_or_international_distribution_Determined_by_union_status_and_contract_terms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_business_glossary_term' = 'Stage Name or Professional Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_column_comment' = 'The professional or stage name used by the talent for public appearances');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_credits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_and_marketing_materials_May_differ_from_legal_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `stage_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_column_comment' = 'The talents tax identification number (SSN');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_EIN' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_or_international_equivalent)_Required_for_payroll_processing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_tax_withholding' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_and_IRS_1099_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union or Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_value_regex' = 'sag_aftra|wga|dga|iatse|non_union|multiple');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_column_comment' = 'The primary labor union or guild affiliation of the talent. Determines contract terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_minimum_compensation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_residual_eligibility' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_and_working_conditions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `union_member_number` SET TAGS ('dbx_column_comment' = 'The talents membership identifier within their primary union or guild. Required for residual payment processing and contract compliance verification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when the talent profile record was last modified. Used for change tracking and data freshness verification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `work_visa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Work Visa Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `work_visa_expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`profile` ALTER COLUMN `work_visa_expiration_date` SET TAGS ('dbx_column_comment' = 'The expiration date of the talents work visa. Critical for production scheduling and compliance with immigration regulations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the guild affiliation record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment' = 'Reference to the talent (actor');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `profile_id` SET TAGS ('dbx_director' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `profile_id` SET TAGS ('dbx_writer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `profile_id` SET TAGS ('dbx_producer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `profile_id` SET TAGS ('dbx_crew_member)_who_holds_this_guild_membership' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_effective_date` SET TAGS ('dbx_column_comment' = 'Date when the current collective bargaining agreement became effective for this membership.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_expiration_date` SET TAGS ('dbx_column_comment' = 'Date when the current collective bargaining agreement expires. Used to track contract renewal cycles and potential rate changes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_version` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_version` SET TAGS ('dbx_column_comment' = 'Version or year identifier of the collective bargaining agreement that governs this membership. Critical for determining applicable residual rates');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_version` SET TAGS ('dbx_working_conditions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `cba_version` SET TAGS ('dbx_and_compensation_structures' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this guild affiliation record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Dues Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_value_regex' = 'current|overdue|delinquent|exempt|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_column_comment' = 'Current status of membership dues payment obligations. Current (all dues paid up to date)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_overdue_(payment_past_due_but_within_grace_period)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_delinquent_(significantly_past_due' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_may_affect_standing)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_exempt_(not_required_to_pay_dues)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_waived_(dues_forgiven_by_guild)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_name` SET TAGS ('dbx_business_glossary_term' = 'Guild Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_name` SET TAGS ('dbx_column_comment' = 'Full legal name of the guild or union organization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `guild_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Benefits Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is eligible for guild-provided health insurance benefits based on this membership and earnings thresholds. True if eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `health_benefits_eligible_flag` SET TAGS ('dbx_false_otherwise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Join Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `join_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `join_date` SET TAGS ('dbx_column_comment' = 'Date when the talent officially became a member of this guild. Used to determine seniority and eligibility for certain benefits.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Guild Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_column_comment' = 'Geographic jurisdiction or country where this guild membership is registered and governed. USA (United States)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_CAN_(Canada)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_GBR_(United_Kingdom)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_AUS_(Australia)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_NZL_(New_Zealand)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_IRL_(Ireland)_[ENUM_REF_CANDIDATE' = 'USA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_CAN' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_GBR' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_AUS' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_NZL' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_IRL' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_OTHER_—_7_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `last_dues_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dues Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `last_dues_payment_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `last_dues_payment_date` SET TAGS ('dbx_column_comment' = 'Date of the most recent membership dues payment received by the guild.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `last_dues_payment_date` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `local_chapter` SET TAGS ('dbx_business_glossary_term' = 'Local Chapter');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `local_chapter` SET TAGS ('dbx_column_comment' = 'Local chapter');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `local_chapter` SET TAGS ('dbx_branch' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `local_chapter` SET TAGS ('dbx_or_regional_division_of_the_guild_to_which_this_membership_is_assigned_Used_for_regional_governance_and_event_coordination' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `membership_number` SET TAGS ('dbx_column_comment' = 'Unique membership identifier assigned by the guild to the talent member. Required for residual payment processing and production compliance verification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `next_dues_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Dues Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `next_dues_payment_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `next_dues_payment_date` SET TAGS ('dbx_column_comment' = 'Date when the next membership dues payment is due.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `next_dues_payment_date` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional context');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_special_conditions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_or_remarks_about_this_guild_membership_May_include_information_about_membership_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_special_accommodations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `notes` SET TAGS ('dbx_or_historical_context' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `pension_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Pension Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `pension_eligible_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `pension_eligible_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is eligible for guild pension plan contributions and benefits. True if eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `pension_eligible_flag` SET TAGS ('dbx_false_otherwise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this guild membership makes the talent eligible to receive residual payments for reuse of their work. True if eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_false_otherwise_Critical_for_royalty_calculation_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Guild Membership Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_column_comment' = 'Date when the guild membership ended');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_whether_through_resignation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_expulsion' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_or_other_termination_Null_for_active_memberships' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this guild affiliation record was last modified in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `verification_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`guild_affiliation` ALTER COLUMN `verification_date` SET TAGS ('dbx_column_comment' = 'Date when the guild membership status was last verified with the guild organization. Used to ensure data accuracy for production compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` SET TAGS ('dbx_subdomain' = 'engagement_compensation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the talent contract record. Primary key for the talent contract entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment' = 'Reference to the talent (actor');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `profile_id` SET TAGS ('dbx_director' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `profile_id` SET TAGS ('dbx_writer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `profile_id` SET TAGS ('dbx_producer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `profile_id` SET TAGS ('dbx_host' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `profile_id` SET TAGS ('dbx_correspondent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `profile_id` SET TAGS ('dbx_crew_member)_engaged_under_this_contract' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_series_Business_justification' = 'Talent contracts for episodic content are series-level agreements with episode guarantees');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_option_periods' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `series_id` SET TAGS ('dbx_and_multi_season_terms_Fundamental_to_TV_production_contracting_and_long_form_content_busine' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_column_comment' = 'The total number of formal amendments made to this contract since initial execution. Tracks contract modification history.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Backend Participation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_column_comment' = 'The percentage of net profits');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_adjusted_gross' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_or_other_revenue_streams_the_talent_is_entitled_to_receive_after_recoupment_of_production_costs_Common_for_above_the_line_talent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `backend_participation_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_column_comment' = 'The guaranteed base fee or salary payable to the talent for services rendered under this contract');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_excluding_bonuses' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_backend_participation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `base_compensation_amount` SET TAGS ('dbx_and_residuals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_column_comment' = 'The contractually specified position and format of the talents on-screen credit (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_'First_Position_Main_Title'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_'Shared_Card'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_'Single_Card'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `billing_credit_position` SET TAGS ('dbx_'Above_the_Title')_Critical_for_talent_reputation_and_guild_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_column_comment' = 'Three-letter ISO 4217 currency code for the base compensation amount (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_EUR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_value_regex' = 'flat_fee|per_episode|weekly_rate|annual_salary|day_rate|hourly_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_column_comment' = 'The payment model for the base compensation. Flat fee is a single lump sum; per-episode is paid per episode produced; weekly/annual/day/hourly rates define periodic payment schedules.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_column_comment' = 'Business identifier for the contract');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_typically_assigned_by_legal_or_business_affairs_Used_for_external_reference_and_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this contract record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_business_glossary_term' = 'Credit Placement Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_column_comment' = 'Detailed contractual requirements for credit placement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_including_main_title_vs_end_credits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_paid_advertising_inclusion' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_promotional_materials' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_placement_requirements` SET TAGS ('dbx_and_any_special_formatting_or_adjacency_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_business_glossary_term' = 'Credit Size Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_column_comment' = 'The minimum size of the talents on-screen credit as a percentage of the title or other reference credit size. Null if not contractually specified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `credit_size_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `document_reference_uri` SET TAGS ('dbx_column_comment' = 'The storage location or document management system URI for the executed contract document and all amendments. Used for legal reference and audit.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_column_comment' = 'The date on which the contract expires or the engagement period ends. Nullable for open-ended overall deals or holding deals with option-based extensions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_column_comment' = 'The date on which the contract becomes binding and the talent engagement period begins.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_business_glossary_term' = 'Engagement Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_column_comment' = 'The specific role or position the talent is contracted to perform (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_Lead_Actor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_Director' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_Showrunner' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_Writer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_Executive_Producer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_Director_of_Photography' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_Host)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `engagement_role` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the contract includes exclusivity restrictions preventing the talent from working on competing projects or for other networks/studios during the contract period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_column_comment' = 'Detailed description of the exclusivity restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_including_prohibited_activities' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_competing_platforms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_genre_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_and_geographic_scope_Null_if_exclusivity_flag_is_false' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_business_glossary_term' = 'Governing Collective Bargaining Agreement (CBA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_column_comment' = 'The specific collective bargaining agreement that governs this contract');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_including_version_and_effective_date_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_SAG_AFTRA_Television_Agreement_2020_2023)_Defines_minimum_compensation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_working_conditions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `governing_cba` SET TAGS ('dbx_and_residual_structures' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guaranteed_episodes` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guaranteed_episodes` SET TAGS ('dbx_column_comment' = 'The minimum number of episodes for which the talent is guaranteed compensation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `guaranteed_episodes` SET TAGS ('dbx_regardless_of_actual_production_Common_in_series_regular_deals_Null_for_non_episodic_contracts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_column_comment' = 'The number of days after contract end during which the talent is restricted from working on similar projects or for competing entities. Common in overall deals and first-look agreements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_column_comment' = 'The date of the most recent contract amendment. Null if no amendments have been made.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this contract record was most recently updated in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_column_comment' = 'The date by which the company must notify the talent of its decision to exercise or decline the next option period. Null if no active option exists.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_periods_count` SET TAGS ('dbx_business_glossary_term' = 'Option Periods Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `option_periods_count` SET TAGS ('dbx_column_comment' = 'The number of option periods (typically annual) the company holds to extend the contract beyond the initial term. Common in series regular and overall deals.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay-or-Play Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the contract includes a pay-or-play provision');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_guaranteeing_full_compensation_even_if_the_talent_services_are_not_ultimately_used_or_the_production_is_cancelled' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is eligible to receive residual payments for reuse of the content (reruns');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_international_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_home_video)_Governed_by_guild_CBAs' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_column_comment' = 'The incremental increase in base compensation for each exercised option period or season renewal. Null if no step-up provision exists.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_column_comment' = 'The date on which the contract was terminated prior to its natural expiration. Null if contract was not terminated early.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_column_comment_The_primary_reason_for_early_contract_termination_Null_if_contract_was_not_terminated_early_[ENUM_REF_CANDIDATE' = 'mutual_agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_breach_of_contract' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_force_majeure' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_production_cancellation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_talent_unavailability' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_company_convenience' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_talent_request' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_other_—_8_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`contract` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` SET TAGS ('dbx_subdomain' = 'engagement_compensation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_structure_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the compensation structure record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `contract_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent talent contract to which this compensation structure is attached.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_business_glossary_term' = 'Backend Gross Participation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_column_comment' = 'The percentage of adjusted gross receipts or backend profits the talent is entitled to receive (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `backend_gross_participation_pct` SET TAGS ('dbx_0_05_for_5%_backend_participation)_Null_if_no_backend_participation_is_granted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_business_glossary_term' = 'Base Episode Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_column_comment' = 'The guaranteed compensation amount per episode for episodic talent (actors');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_writers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `base_episode_fee` SET TAGS ('dbx_directors)_Expressed_in_the_contract_currency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_column_comment' = 'The fixed or maximum bonus amount payable when the bonus threshold is met. Expressed in the contract currency. Null if no bonus provision exists.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_business_glossary_term' = 'Bonus Threshold Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_column_comment' = 'Textual description of the performance or milestone thresholds that trigger bonus payments (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_'Nielsen_rating_above_2_0_in_key_demo'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `bonus_threshold_description` SET TAGS ('dbx_'box_office_exceeds_$100M_domestic')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this compensation structure record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `daily_rate` SET TAGS ('dbx_column_comment' = 'The guaranteed daily compensation amount for talent engaged on a day-player or daily basis. Expressed in the contract currency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_column_comment' = 'The total amount of compensation deferred to a future payment date or contingent event (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_series_pickup' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_compensation_amount` SET TAGS ('dbx_profitability_milestone)_Expressed_in_the_contract_currency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Deferred Payment Trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_column_comment' = 'The business event or milestone that triggers payment of deferred compensation (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_'series_pickup'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_'profitability_threshold_met'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_'syndication_sale'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_'specific_date')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `deferred_payment_trigger` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_column_comment' = 'The date on which this compensation structure ceases to be effective. Null for open-ended structures or those tied to contract termination.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_column_comment' = 'The date on which this compensation structure becomes effective and applicable to the talent contract.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this compensation structure includes an exclusivity provision restricting the talent from working on competing projects (True) or not (False).');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this compensation structure record was last updated or modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_special_provisions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `notes` SET TAGS ('dbx_or_clarifications_regarding_this_compensation_structure_that_do_not_fit_into_structured_fields' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_column_comment' = 'The multiplier applied to the base rate for overtime hours worked (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_1_5_for_time_and_a_half' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_2_0_for_double_time)_Null_if_overtime_is_not_applicable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay-or-Play Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this compensation structure includes a pay-or-play provision');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pay_or_play_flag` SET TAGS ('dbx_guaranteeing_payment_even_if_the_talent_is_not_used_(True)_or_not_(False)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_column_comment' = 'The percentage rate of gross compensation contributed to the guild pension and health plan (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `pension_health_rate` SET TAGS ('dbx_0_185_for_18_5%_SAG_AFTRA_P&H)_Used_to_calculate_employer_contributions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_business_glossary_term' = 'Residual Base Formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_column_comment' = 'The formula or method used to calculate the residual base for reuse payments (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_'initial_compensation'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_'applicable_minimum'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_base_formula` SET TAGS ('dbx_'pro_rata_share')_Defines_how_residuals_are_computed_per_guild_rules' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is eligible to receive residual payments for reuse of the content under this compensation structure (True) or not (False). Typically True for union deals');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_may_be_False_for_buyouts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_amount` SET TAGS ('dbx_column_comment' = 'The incremental compensation increase amount when the step-up trigger is met. Expressed in the contract currency. Null if no step-up provision exists.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_business_glossary_term' = 'Step-Up Trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_column_comment' = 'The condition or event that triggers an automatic increase in compensation (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_'season_2_pickup'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_'episode_13_renewal'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `step_up_trigger` SET TAGS ('dbx_'ratings_threshold')_Null_if_no_step_up_provision_exists' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_column_comment' = 'Business-friendly name or label for this compensation structure (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_'Series_Regular_Season_1'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_'Guest_Star_Rate_Card')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `structure_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_column_comment' = 'Description of the media usage rights covered by this compensation structure (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_'initial_broadcast_only'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_'all_media_in_perpetuity'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_'theatrical_and_SVOD'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_'domestic_free_television')_Defines_what_exploitation_is_covered_by_the_base_compensation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Weekly Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_column_comment' = 'The guaranteed weekly compensation amount for talent engaged on a weekly basis (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_series_regulars' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`compensation_structure` ALTER COLUMN `weekly_guarantee` SET TAGS ('dbx_production_staff)_Expressed_in_the_contract_currency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` SET TAGS ('dbx_subdomain' = 'engagement_compensation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Residual Payment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the residual payment transaction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `residual_payment_id` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `contract_id` SET TAGS ('dbx_column_comment' = 'Reference to the talent contract governing this residual payment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the content asset (title');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_or_version)_for_which_the_residual_is_being_paid' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment' = 'Reference to the talent receiving the residual payment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Trace Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_column_comment' = 'The ACH trace number if the payment method is ACH or direct deposit');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_used_for_reconciliation_and_audit' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `ach_trace_number` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_column_comment' = 'The agent or manager commission amount deducted from the residual payment');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_if_applicable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_column_comment' = 'The date on which this residual payment was included in a guild audit report.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this residual payment has been included in a guild audit report (SAG-AFTRA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_WGA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_DGA)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `audit_report_flag` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_column_comment' = 'The check number if the payment method is check');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_used_for_reconciliation_and_audit' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this residual payment record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_end_date` SET TAGS ('dbx_column_comment' = 'The end date of the exhibition period for which this residual is calculated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exhibition Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `exhibition_start_date` SET TAGS ('dbx_column_comment' = 'The start date of the exhibition period for which this residual is calculated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Residual Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_column_comment' = 'The gross residual amount calculated before deductions');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `gross_residual_amount` SET TAGS ('dbx_in_the_payment_currency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_column_comment' = 'The net residual payment amount after all deductions');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_paid_to_the_talent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_column_comment' = 'The three-letter ISO 4217 currency code for the residual payment (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_EUR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_column_comment' = 'The date on which the residual payment was issued or disbursed to the talent.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ACH|wire_transfer|direct_deposit|payroll');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_column_comment' = 'The method used to disburse the residual payment to the talent.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_column_comment' = 'Free-text notes or comments related to this residual payment');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_including_special_circumstances' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_adjustments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_or_exceptions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_column_comment' = 'Business identifier for the residual payment');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_used_for_external_reference_and_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|processed|paid|cancelled|on_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_column_comment' = 'Current lifecycle status of the residual payment transaction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_business_glossary_term' = 'Pension and Health (P&H) Contribution Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_column_comment' = 'The pension and health contribution amount deducted from the gross residual');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `pension_health_amount` SET TAGS ('dbx_as_required_by_guild_agreements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_column_comment' = 'The date on which the remittance advice was sent to the talent.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `remittance_advice_sent_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether a remittance advice document was sent to the talent for this payment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `royalty_calculation_reference` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `royalty_calculation_reference` SET TAGS ('dbx_column_comment' = 'Reference to the Rightsline royalty calculation record that generated this residual payment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this residual payment record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_column_comment' = 'The wire transfer reference number if the payment method is wire transfer');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_used_for_reconciliation_and_audit' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_column_comment' = 'The tax amount withheld from the residual payment for federal');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_state' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_or_foreign_tax_obligations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`residual_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` SET TAGS ('dbx_subdomain' = 'engagement_compensation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Deal Memo ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the talent deal memo record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Long-Form Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `contract_id` SET TAGS ('dbx_column_comment' = 'Reference to the executed long-form talent contract that supersedes this deal memo. Null if the long-form contract has not yet been executed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Production Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the production title (series');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_film' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `title_id` SET TAGS ('dbx_special)_for_which_the_talent_is_engaged' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment' = 'Reference to the talent (actor');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `profile_id` SET TAGS ('dbx_director' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `profile_id` SET TAGS ('dbx_writer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `profile_id` SET TAGS ('dbx_producer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `profile_id` SET TAGS ('dbx_host' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `profile_id` SET TAGS ('dbx_correspondent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `profile_id` SET TAGS ('dbx_crew_member)_engaged_under_this_deal_memo' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_series_Business_justification' = 'Deal memos for episodic content reference series for series commitment tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_multi_season_option_terms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `series_id` SET TAGS ('dbx_and_episode_count_guarantees_Essential_for_TV_talent_deal_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_column_comment' = 'The primary monetary compensation amount agreed in the deal memo (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_total_fee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_per_episode_rate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_or_guaranteed_minimum)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_column_comment' = 'Three-letter ISO 4217 currency code for the compensation amount (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_EUR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_business_glossary_term' = 'Compensation Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_column_comment' = 'High-level summary of the compensation structure agreed in the deal memo (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_per_episode_fee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_flat_fee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_day_rate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `compensation_summary` SET TAGS ('dbx_backend_participation)_Detailed_breakdowns_are_captured_in_the_long_form_contract' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_business_glossary_term' = 'Countersigned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_column_comment' = 'The date on which the deal memo was countersigned by both the talent (or agent) and the production company');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `countersigned_date` SET TAGS ('dbx_making_it_a_binding_interim_agreement_Null_if_not_yet_countersigned' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the deal memo record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_business_glossary_term' = 'Credit Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_column_comment' = 'The agreed on-screen or off-screen credit position and format (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_'Main_Title_Card'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_'Opening_Credits'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_'End_Crawl'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_'Shared_Card'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `credit_position` SET TAGS ('dbx_'Single_Card')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_date` SET TAGS ('dbx_column_comment' = 'The date on which the deal terms were verbally agreed or the deal memo was initially drafted.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_value_regex' = '^DM-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_column_comment' = 'Externally-known unique business identifier for the deal memo');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `deal_memo_number` SET TAGS ('dbx_typically_generated_by_the_CRM_or_legal_system' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `effective_date` SET TAGS ('dbx_column_comment' = 'The date on which the deal memo becomes binding (typically the date of countersignature by both parties).');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_column_comment' = 'The date on which the talent engagement is scheduled to end. Null for open-ended or option-based engagements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_column_comment' = 'The date on which the talent engagement is scheduled to begin (first day of work');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_rehearsal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_or_availability)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `episode_count` SET TAGS ('dbx_column_comment' = 'Number of episodes or production units covered by this deal memo. Null if the engagement is for a single film or special.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_column_comment' = 'High-level summary of exclusivity terms (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_exclusive_to_network_during_production' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_non_exclusive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_first_look' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `exclusivity_summary` SET TAGS ('dbx_holdback_period)_Detailed_clauses_are_in_the_long_form_contract' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_column_comment' = 'The date by which the deal memo must be superseded by a long-form contract or it will expire. Null if no expiration is set.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_column_comment' = 'Username or identifier of the user who last modified the deal memo record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the deal memo record was last modified in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Memo Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text notes capturing additional context');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_special_provisions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `notes` SET TAGS ('dbx_or_negotiation_history_relevant_to_the_deal_memo' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_business_glossary_term' = 'Option Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_column_comment' = 'Summary of any option clauses (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_network_option_for_additional_seasons' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_talent_option_to_extend' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `option_terms` SET TAGS ('dbx_mutual_option)_Null_if_no_options_are_included' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is eligible for residual payments under guild agreements for reuse');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_syndication' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_or_secondary_distribution_True_if_eligible' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `residual_eligibility_flag` SET TAGS ('dbx_False_otherwise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_business_glossary_term' = 'Role or Function');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_column_comment' = 'The specific role or function the talent will perform (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_Lead_Actor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_Director' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_Writer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_Executive_Producer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_Host' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_Correspondent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `role_function` SET TAGS ('dbx_Camera_Operator)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `superseded_date` SET TAGS ('dbx_column_comment' = 'The date on which the deal memo was superseded by the execution of a long-form contract. Null if not yet superseded.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`deal_memo` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the talent role assignment. Primary key for the talent role entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_column_comment' = 'Reference to the talent contract governing the terms of this role engagement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_including_compensation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_usage_rights' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `contract_id` SET TAGS ('dbx_and_obligations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment' = 'Reference to the talent individual performing this role. Links to the talent master entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_season_Business_justification' = 'Roles often span specific seasons requiring season-level tracking for season-specific compensation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_per_season_credits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_and_availability_scheduling_Eliminates_denormalized_season_number_and_provides' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `season_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_series_Business_justification' = 'Roles in episodic content must link to series for multi-season contract tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_series_level_residuals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `series_id` SET TAGS ('dbx_and_long_term_talent_availability_management_Essential_for_TV_production_business_model' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the content asset or production in which this role is performed. Links to the content master entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_business_glossary_term' = 'Above-The-Line Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_column_comment_Indicates_whether_this_role_is_classified_as_above_the_line_(creative_principals' = 'actors');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_writers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `above_the_line_flag` SET TAGS ('dbx_producers)_or_below_the_line_(technical_crew_and_support_staff)_Impacts_budget_allocation_and_residual_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_business_glossary_term' = 'Appearance Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_column_comment' = 'Total number of episodes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_segments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `appearance_count` SET TAGS ('dbx_or_appearances_in_which_this_talent_role_is_featured_Used_for_episodic_and_recurring_roles' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_column_comment' = 'The numerical order in which the talent appears in the credits (1 = first billed');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_2' = 'second billed');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `billing_position` SET TAGS ('dbx_etc_)_Determines_prominence_in_marketing_materials_and_on_screen_credits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_business_glossary_term' = 'Character Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_column_comment' = 'The name of the character portrayed by the talent for on-screen roles. Null for off-screen roles such as crew');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_or_producers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `character_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_column_comment' = 'The monetary compensation amount for this role engagement in the contract currency. Excludes residuals and backend participation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_column_comment' = 'Three-letter ISO 4217 currency code for the compensation amount (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_EUR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this talent role record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_business_glossary_term' = 'Credit Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_column_comment' = 'The exact text of the credit as it appears on-screen or in marketing materials');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_including_any_special_formatting_or_possessory_credits_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_'A_Film_By'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `credit_text` SET TAGS ('dbx_'Created_By')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Role End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `end_date` SET TAGS ('dbx_column_comment' = 'The date on which the talents engagement for this role concludes. Null for ongoing or open-ended engagements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_end` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope End');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_end` SET TAGS ('dbx_column_comment' = 'The last episode number in which this talent role appears. Null indicates ongoing engagement or single-episode appearance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_start` SET TAGS ('dbx_business_glossary_term' = 'Episode Scope Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `episode_scope_start` SET TAGS ('dbx_column_comment' = 'The first episode number in which this talent role appears. Used for episodic content to define the scope of the talents engagement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is bound by exclusivity clauses preventing them from performing similar roles for competing productions during the engagement period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_column_comment' = 'Description of the scope and limitations of any exclusivity clause (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_'No_competing_streaming_series'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_'No_theatrical_films_during_production')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_column_comment' = 'The specific role or function the talent is engaged to perform (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_Lead_Actor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_Director' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_Executive_Producer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_Cinematographer' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_Script_Supervisor)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `role_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Role Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_special_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_or_contextual_information_about_this_talent_role_assignment_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_special_credit_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_scheduling_constraints' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `notes` SET TAGS ('dbx_performance_notes)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this role is eligible for residual payments based on subsequent distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_reuse' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_eligible_flag` SET TAGS ('dbx_or_syndication_of_the_content_Determined_by_guild_agreements_and_contract_terms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Residual Rate Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_column_comment' = 'Code identifying the residual payment rate schedule applicable to this role based on guild agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_role_category' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `residual_rate_code` SET TAGS ('dbx_and_distribution_windows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `screen_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Screen Time Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `screen_time_minutes` SET TAGS ('dbx_column_comment' = 'Total on-screen time in minutes for this talent role across all appearances. Used for on-screen talent to measure prominence and for residual calculations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Role Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_column_comment' = 'The date on which the talents engagement for this role begins');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_typically_the_first_day_of_principal_photography' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_recording' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `start_date` SET TAGS ('dbx_or_production_work' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_business_glossary_term' = 'Stunt Double Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this role involves stunt work or if a stunt double is used for this character. Impacts insurance');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_safety_protocols' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `stunt_double_flag` SET TAGS ('dbx_and_credit_attribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this talent role record was last modified in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Duration Years');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_duration_years` SET TAGS ('dbx_column_comment' = 'Number of years for which usage rights are granted. Null indicates perpetual rights.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_duration_years` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Media');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_column_comment' = 'Media platforms and formats for which usage rights are granted (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_'Theatrical' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_Home_Video' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_Streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_Broadcast_TV')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_media` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_column_comment' = 'Geographic territories in which the content featuring this talent role may be distributed and exploited (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_'Worldwide'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_'North_America'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_'USA_and_Canada')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `usage_rights_territory` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice Only Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this is a voice-only role (voice-over');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_narration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_animation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`role` ALTER COLUMN `voice_only_flag` SET TAGS ('dbx_ADR)_with_no_on_screen_physical_appearance_by_the_talent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the talent agency or management company. Primary key for the talent_agency product.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_column_comment' = 'The first line of the agencys primary business address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_typically_containing_street_number_and_street_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_column_comment' = 'The second line of the agencys primary business address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_typically_containing_suite' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_floor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_or_building_information' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_column_comment' = 'The name on the bank account used for commission and residual payments to the agency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_column_comment' = 'The bank account number for electronic funds transfer of commissions and residuals to the agency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_column_comment' = 'The bank routing number (ABA number in the US');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_sort_code_in_UK' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_or_equivalent)_for_electronic_funds_transfer_of_commissions_and_residuals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `city` SET TAGS ('dbx_column_comment' = 'The city or municipality where the agencys primary office is located.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this talent agency record was first created in the system. Immutable audit field.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_column_comment' = 'The trade name or doing-business-as name under which the agency operates');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_if_different_from_the_legal_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Established Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `established_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `established_date` SET TAGS ('dbx_column_comment' = 'The date on which the talent agency was originally established or incorporated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_column_comment' = 'The fax number for the agency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_used_for_contract_transmission_and_official_correspondence_in_jurisdictions_where_fax_is_still_required' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_effective_date` SET TAGS ('dbx_column_comment' = 'The date on which the SAG-AFTRA franchise agreement became effective for this agency.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_column_comment' = 'The date on which the current SAG-AFTRA franchise agreement expires and must be renewed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_number` SET TAGS ('dbx_business_glossary_term' = 'SAG-AFTRA Franchise Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `franchise_number` SET TAGS ('dbx_column_comment' = 'The unique franchise identification number issued by SAG-AFTRA to franchised talent agencies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_column_comment' = 'The full legal registered name of the talent agency or management company as it appears on contracts and official documents.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_column_comment' = 'The date on which the state talent agency license became effective.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_column_comment' = 'The date on which the state talent agency license expires and must be renewed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'State Talent Agency License Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_number` SET TAGS ('dbx_column_comment' = 'The state-issued license number authorizing the agency to operate as a talent agency. Required in jurisdictions such as California under the Talent Agencies Act.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `license_number` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-form notes field for additional context');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_special_handling_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_historical_information' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `notes` SET TAGS ('dbx_or_relationship_management_details_relevant_to_the_agency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_column_comment' = 'The standard payment terms and conditions for commission remittance');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_including_timing_and_method_of_payment_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_net_30_days' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_upon_talent_payment_receipt)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_column_comment' = 'The name of the primary contact person at the agency for contract negotiations');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_deal_correspondence' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_and_residual_remittances' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_column_comment' = 'The job title or role of the primary contact person (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_President' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_Partner' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_Agent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_Business_Affairs_Manager)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_column_comment' = 'The primary email address for official correspondence');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_contract_delivery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_and_residual_payment_notifications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_email` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_column_comment' = 'The primary telephone number for the agency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_including_country_and_area_codes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `primary_phone` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `roster_size` SET TAGS ('dbx_business_glossary_term' = 'Talent Roster Size');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `roster_size` SET TAGS ('dbx_column_comment' = 'The approximate number of talent clients currently represented by the agency. Used for agency scale assessment and negotiation context.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Agency Specialization');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_column_comment' = 'The primary area of talent specialization or focus for the agency (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_film_and_television_actors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_commercial_talent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_voice_over_artists' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_writers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_below_the_line_crew' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `specialization` SET TAGS ('dbx_music_artists)_Free_text_field_to_accommodate_multiple_specializations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Commission Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_column_comment' = 'The standard commission rate percentage that the agency charges for talent representation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_typically_10%_for_franchised_agencies_under_SAG_AFTRA_rules_Expressed_as_a_percentage_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `standard_commission_rate` SET TAGS ('dbx_10_00_for_10%)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_column_comment' = 'The state');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_province' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_or_region_where_the_agency's_primary_office_is_located_Use_standard_two_letter_codes_where_applicable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_column_comment' = 'The date on which the current status became effective.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_column_comment' = 'The tax identification number (EIN in the US');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_VAT_number_in_EU)_for_the_agency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_used_for_tax_reporting_and_residual_payment_processing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this talent agency record was last modified. Updated automatically on any change to the record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_column_comment' = 'The date on which the agency information was last verified for accuracy and currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `verification_date` SET TAGS ('dbx_typically_through_direct_contact_or_regulatory_registry_check' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_column_comment' = 'The primary website URL for the talent agency');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`talent_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_used_for_public_information_and_talent_roster_visibility' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` SET TAGS ('dbx_subdomain' = 'talent_identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `representation_agreement_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the representation agreement record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment' = 'Reference to the talent being represented under this agreement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Agency Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_talent_talent_agency_Business_justification' = 'representation_agreement currently has agency_name (STRING) duplicating data from talent_agency. Adding FK enables normalization - agency legal name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_DBA_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_contact_details' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_and_franchise_status_sh' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `talent_agency_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_column_comment' = 'Primary email address for the agent or representative');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_used_for_deal_negotiation_and_residual_routing_communications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_email` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_column_comment' = 'Primary phone number for the agent or representative.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_contact_phone` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_column_comment' = 'Full name of the individual agent');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_manager' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_or_attorney_assigned_as_primary_contact_for_this_representation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agent_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_column_comment' = 'Externally-known unique business identifier for this representation agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_used_for_contract_reference_and_audit_trails' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Cap Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_column_comment' = 'Maximum commission amount per engagement or per year');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_cap_amount` SET TAGS ('dbx_if_a_cap_is_specified_in_the_agreement_Null_if_no_cap_applies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_column_comment' = 'Percentage of talent earnings paid to the representative as commission (typically 10% for agents');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_15%_for_managers_per_industry_standards)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `contract_document_uri` SET TAGS ('dbx_column_comment' = 'URI or file path to the signed representation agreement contract document stored in the Media Asset Management (MAM) system or document repository.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this representation agreement record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_column_comment' = 'Date when the representation agreement expires or terminates. Null for open-ended agreements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_column_comment' = 'Date when the representation agreement becomes binding and the representative begins acting on behalf of the talent.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this representation is exclusive (true) or non-exclusive (false). Exclusive agreements prohibit the talent from engaging other representatives in the same category and territory.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_business_glossary_term' = 'Guild Franchise Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the agency or representative is franchised by a talent guild (SAG-AFTRA');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_WGA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `guild_franchise_flag` SET TAGS ('dbx_DGA)_Franchised_agents_must_comply_with_guild_mandated_commission_caps_and_contract_terms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text notes capturing special clauses');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_amendments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_or_contextual_information_about_the_representation_agreement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the agreement includes an automatic renewal option or requires explicit renegotiation at expiration.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_column_comment' = 'Description of renewal terms if renewal_option_flag is true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_including_renewal_period_length_and_any_modified_commission_rates' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `residual_routing_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Routing Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `residual_routing_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `residual_routing_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether residual payments for work performed during this representation period should be routed through this representative for commission deduction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_column_comment_Detailed_description_of_services_the_representative_will_provide' = 'deal negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_career_guidance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_audition_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_contract_review' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_brand_partnerships' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_etc' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Signing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `signing_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `signing_date` SET TAGS ('dbx_column_comment' = 'Date when the representation agreement was signed by both parties.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_column_comment' = 'Actual date the representation agreement was terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_if_applicable_Used_for_residual_routing_cutoff_and_historical_audit_trails' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_column_comment' = 'Number of days advance notice required by either party to terminate the representation agreement (commonly 30');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_60' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_or_90_days)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_column_comment' = 'Reason for early termination of the representation agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_if_applicable_[ENUM_REF_CANDIDATE' = 'mutual_agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_talent_initiated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_agent_initiated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_breach_of_contract' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_expiration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_non_performance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_conflict_of_interest_—_7_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_column_comment' = 'Geographic territory or market scope covered by this representation agreement (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_worldwide' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_North_America' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_USA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_specific_states)_Multiple_territories_may_be_comma_separated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this representation agreement record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`talent`.`representation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
