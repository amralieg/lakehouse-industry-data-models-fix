-- Schema for Domain: athlete | Business: Sports Entertainment | Version: v1_ecm
-- Generated on: 2026-05-09 01:42:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `sports_entertainment_ecm`.`athlete` COMMENT 'Talent management domain owning athlete identity, contracts, performance statistics (WAR, ERA, QBR), health records, eligibility status, and career lifecycle. Manages player rosters, draft selections, trades, transfers, injury tracking, NIL agreements, agent relationships, and compliance with league regulations including anti-doping (WADA) and collective bargaining agreements (CBA). Critical for league operations and broadcast content.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`roster` (
    `roster_id` BIGINT COMMENT 'Unique surrogate identifier for each roster record. Serves as the primary key for the athlete-team-season affiliation record in the Silver Layer lakehouse. Entity role: MASTER_AGREEMENT — this record represents a binding registration/affiliation between an athlete and a team within a league season.',
    `agent_id` BIGINT COMMENT 'Reference to the certified player agent or agency representing the athlete for this roster record. Used for contract negotiations, trade communications, and CBA-mandated agent certification compliance.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete master record. Identifies the specific player registered on this roster slot. Used as the primary link to athlete identity, contract, and performance data.',
    `athlete_contract_id` BIGINT COMMENT 'Reference to the active player contract record governing this roster slot. Links to the athlete contract master for salary, incentives, and CBA compliance details. Confidential as it references financial agreement data.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete master record. Identifies the specific player registered on this roster slot. Used as the primary link to athlete identity, contract, and performance data.',
    `cba_agreement_id` BIGINT COMMENT 'Foreign key linking to league.cba_agreement. Business justification: Roster slot types, practice squad eligibility, IR designation rules, and international player limits are all CBA-governed. CBA FK enables version-specific roster compliance validation, practice squad ',
    `eligibility_status_id` BIGINT COMMENT 'Foreign key linking to athlete.eligibility_status. Business justification: A roster entrys eligibility to compete is governed by the authoritative eligibility_status record. The roster table currently stores eligibility_status as a denormalized STRING field, duplicating the',
    `employee_id` BIGINT COMMENT 'Reference to the certified player agent or agency representing the athlete for this roster record. Used for contract negotiations, trade communications, and CBA-mandated agent certification compliance.',
    `franchise_id` BIGINT COMMENT 'Reference to the team or franchise master record to which the athlete is currently rostered. Establishes the athlete-team affiliation for the given season.',
    `injury_record_id` BIGINT COMMENT 'Foreign key linking to athlete.injury_record. Business justification: A roster entrys injury designation (IR, day-to-day, doubtful, out) is directly driven by the clinical injury_record. The roster table currently stores injury_designation (STRING) and injury_report_da',
    `league_id` BIGINT COMMENT 'Reference to the league or competition governing body under which this roster record is maintained. Supports multi-league operations (NFL, NBA, MLB, NHL, MLS, FIFA, etc.).',
    `loaned_from_team_franchise_id` BIGINT COMMENT 'Reference to the originating team from which the athlete is on loan to the current roster. Applicable in soccer (MLS, FIFA) and hockey (NHL) loan/conditioning assignment scenarios. Null if the athlete is not on loan.',
    `primary_roster_franchise_id` BIGINT COMMENT 'Reference to the team or franchise master record to which the athlete is currently rostered. Establishes the athlete-team affiliation for the given season.',
    `roster_franchise_id` BIGINT COMMENT 'FK to league.franchise.franchise_id — Roster-to-franchise linkage — must know which franchise a roster belongs to for cap compliance, trade eligibility, and league governance.',
    `roster_loaned_from_team_franchise_id` BIGINT COMMENT 'Reference to the originating team from which the athlete is on loan to the current roster. Applicable in soccer (MLS, FIFA) and hockey (NHL) loan/conditioning assignment scenarios. Null if the athlete is not on loan.',
    `season_id` BIGINT COMMENT 'Reference to the competitive season for which this roster record is valid. Enables point-in-time roster snapshots across multiple seasons.',
    `transaction_window_id` BIGINT COMMENT 'Foreign key linking to league.transaction_window. Business justification: Roster activations, deactivations, and IR designations must occur within valid transaction windows. Linking roster to transaction_window enables transaction window compliance validation for roster mov',
    `activation_date` DATE COMMENT 'The date on which the athlete was officially activated onto this roster slot. Marks the effective start of the athlete-team affiliation for this record. Critical for CBA compliance, salary cap calculations, and eligibility verification.',
    `cap_hit_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the salary cap hit amount (e.g., USD, CAD, EUR, GBP). Required for multi-league international operations where cap values may be denominated in different currencies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this roster record was first created in the system. Provides the audit trail creation marker for data governance, SOX compliance, and lineage tracking in the Silver Layer.',
    `deactivation_date` DATE COMMENT 'The date on which the athlete was removed from this roster slot (via trade, waiver, release, retirement, or season end). Null if the roster record is currently active. Enables point-in-time roster reconstruction for any historical date.',
    `depth_chart_rank` STRING COMMENT 'The athletes positional depth chart ranking within the team (1 = starter, 2 = first backup, etc.). Used for game-day roster decisions, broadcast graphics, and performance analytics. Updated by coaching staff via SportsCode/Hudl.',
    `draft_pick_number` STRING COMMENT 'The overall pick number at which the athlete was selected in the league draft. Used for historical analysis, WAR (Wins Above Replacement) benchmarking, and broadcast content. Null for undrafted players.',
    `draft_round` STRING COMMENT 'The round in which the athlete was selected during the league draft. Used for historical analysis, broadcast content, and talent evaluation benchmarking. Null for undrafted players.',
    `draft_year` STRING COMMENT 'The calendar year in which the athlete was originally drafted into the league, if applicable. Used for service time calculations, CBA eligibility tiers, and broadcast storytelling. Null for undrafted free agents or international transfers.',
    `effective_from` DATE COMMENT 'The date from which this roster record version is considered authoritative and binding. Supports Slowly Changing Dimension (SCD) Type 2 history tracking in the Silver Layer, enabling point-in-time roster reconstruction for any historical date.',
    `effective_until` DATE COMMENT 'The date until which this roster record version is considered authoritative. Null indicates the current active version. Supports SCD Type 2 history tracking and point-in-time roster queries for league operations, broadcast, and compliance.',
    `international_slot_flag` BOOLEAN COMMENT 'Indicates whether this roster slot is designated as an international player slot under league rules (e.g., MLS international roster designation, NHL Entry Level Contract international provisions). Affects roster construction compliance and salary cap treatment.',
    `is_captain` BOOLEAN COMMENT 'Indicates whether the athlete holds the official team captain designation for the current season. Used in broadcast graphics, fan engagement content, and league ceremonial protocols.',
    `jersey_number` STRING COMMENT 'The uniform number assigned to the athlete on this roster for the current season. Used in broadcast graphics, ticketing systems, merchandise, and fan engagement platforms. Must be unique within a team roster for a given season.',
    `nationality_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the athletes primary nationality. Used for international roster compliance (e.g., MLS international roster slots, FIFA international transfer rules), visa tracking, and broadcast content.. Valid values are `^[A-Z]{3}$`',
    `nil_agreement_flag` BOOLEAN COMMENT 'Indicates whether the athlete has an active NIL (Name, Image, and Likeness) agreement registered with the league or team. Relevant for collegiate athletes transitioning to professional rosters and for compliance with NIL disclosure rules.',
    `notes` STRING COMMENT 'Free-text field for league operations staff to record supplementary information about this roster record, such as conditional activation clauses, special designations, or transaction context not captured in structured fields.',
    `position_code` STRING COMMENT 'Standardized league-defined code for the athletes primary playing position (e.g., QB, WR, C, PG, SG, SP, RP, LW, RW, FWD, MID, DEF, GK). Used in performance analytics, broadcast overlays, and roster compliance checks. [ENUM-REF-CANDIDATE: QB|WR|RB|TE|OL|DL|LB|DB|K|P|PG|SG|SF|PF|C|SP|RP|CP|1B|2B|3B|SS|OF|LW|RW|FWD|MID|DEF|GK — promote to reference product]',
    `position_name` STRING COMMENT 'Human-readable full name of the athletes primary playing position (e.g., Quarterback, Point Guard, Starting Pitcher, Left Wing, Goalkeeper). Used in broadcast graphics, fan-facing content, and reporting.',
    `practice_squad_elevation_flag` BOOLEAN COMMENT 'Indicates whether the athlete has been temporarily elevated from the practice squad to the active roster for a specific game week, per NFL and other league rules allowing short-term elevations without permanently activating the player.',
    `roster_number` STRING COMMENT 'Externally-known business identifier for this roster record, typically assigned by the league operations system. Used in official league communications, broadcast graphics, and regulatory filings. Example: NFL-2024-KC-0042.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `roster_status` STRING COMMENT 'Current lifecycle status of the athletes roster slot. Drives eligibility for game participation, payroll processing, and broadcast credentialing. active = eligible to play; inactive = on roster but not eligible for current game; injured_reserve = on IR per league rules; practice_squad = developmental squad; waived = released from roster pending waiver wire.. Valid values are `active|inactive|injured_reserve|practice_squad|waived`',
    `salary_cap_hit` DECIMAL(18,2) COMMENT 'The annual salary cap charge attributed to this athletes roster slot for the current season, expressed in USD. Used for cap compliance reporting, trade analysis, and financial planning. Governed by CBA salary cap rules.',
    `service_years` DECIMAL(18,2) COMMENT 'Accumulated years of professional service for the athlete within the league, calculated per CBA rules. Determines eligibility for free agency, arbitration rights, minimum salary tiers, and pension benefits. Expressed as a decimal (e.g., 3.172 years).',
    `slot_type` STRING COMMENT 'Classification of the roster slot category as defined by league rules. Determines salary cap implications, game eligibility, and CBA compliance. active_roster = primary game-day roster; practice_squad = developmental; injured_reserve = IR designation; reserve = non-IR reserve list; taxi_squad = NHL-specific developmental designation.. Valid values are `active_roster|practice_squad|injured_reserve|reserve|taxi_squad`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this roster record was ingested. Supports data lineage tracking in the Silver Layer lakehouse. SAP_SF = SAP SuccessFactors HCM; ARCHTICS = Archtics Venue/Roster System; LEAGUE_API = direct league data feed.. Valid values are `SAP_SF|ARCHTICS|TICKETMASTER|MANUAL|LEAGUE_API`',
    `transaction_date` DATE COMMENT 'The official date on which the roster transaction (signing, trade, waiver, draft, transfer) was executed and reported to the league. May differ from activation_date if there is a processing lag.',
    `transaction_type` STRING COMMENT 'The type of transaction that created this roster record. Indicates how the athlete came to be on this roster slot. Used for league transaction reporting, broadcast graphics, and historical analysis. [ENUM-REF-CANDIDATE: signed|traded|waived|released|drafted|transferred|loaned|retired — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to this roster record. Used for change detection in ETL pipelines, audit trails, and data freshness monitoring in the Silver Layer lakehouse.',
    `visa_expiry_date` DATE COMMENT 'The expiration date of the athletes current work visa or immigration authorization. Used to trigger renewal workflows and ensure continuous roster eligibility for international players. Confidential HR/immigration data.',
    `visa_type` STRING COMMENT 'Type of work visa or immigration authorization held by the athlete for the jurisdiction in which they are rostered (e.g., P-1A for internationally recognized athletes in the USA, O-1 for extraordinary ability). Required for international roster compliance and HR onboarding. [ENUM-REF-CANDIDATE: P-1A|O-1|TN|H-1B|J-1|work_permit|citizen|permanent_resident — promote to reference product]',
    `wada_clearance_status` STRING COMMENT 'Current anti-doping clearance status for the athlete as reported by WADA or the applicable league anti-doping program. cleared = no active violations; pending = test results under review; suspended = serving a PED (Performance Enhancing Drug) suspension; exempted = holds a Therapeutic Use Exemption (TUE).. Valid values are `cleared|pending|suspended|exempted`',
    `wada_last_test_date` DATE COMMENT 'Date of the athletes most recent WADA-compliant anti-doping test. Used to verify testing frequency compliance and support league anti-doping audit trails.',
    CONSTRAINT pk_roster PRIMARY KEY(`roster_id`)
) COMMENT 'Master record of all athletes registered to a team or franchise within a league season. Tracks active, inactive, injured reserve (IR), practice squad, and waived status. Serves as the authoritative SSOT for athlete-team affiliation at any point in time, including jersey number, position designation, roster slot type, and activation dates. Critical for league operations, broadcast graphics, and ticketing systems.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` (
    `athlete_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the athlete profile record. Primary key for the athlete_profile data product and the single source of truth (SSOT) reference key used by all downstream athlete entities.',
    `agent_id` BIGINT COMMENT 'FK to athlete.agent',
    `league_id` BIGINT COMMENT 'FK to league.league',
    `team_id` BIGINT COMMENT 'FK to league.team',
    `athlete_type` STRING COMMENT 'Classification of the individuals role within the sports organization. Distinguishes active players from coaching staff, officials, prospects, and support personnel for roster management and credentialing.. Valid values are `player|coach|official|support_staff|prospect`',
    `bio` STRING COMMENT 'Official short-form biographical narrative for the athlete, approved for public use in broadcast, digital platforms, and media guides. Managed through the content production workflow.',
    `career_status` STRING COMMENT 'Current lifecycle status of the athletes professional career. Drives roster eligibility, broadcast availability, contract activation, and league reporting. [ENUM-REF-CANDIDATE: active|retired|suspended|injured_reserve|deceased|inactive — promote to reference product]. Valid values are `active|retired|suspended|injured_reserve|deceased|inactive`',
    `country_of_birth_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the athlete was born. Distinct from nationality; used for eligibility determinations, international federation registration, and demographic analytics.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'Identifies the operational system of record from which this athlete profile record was sourced or last updated (e.g., successfactors, league_registration). Used for data lineage, reconciliation, and audit purposes in the Databricks Silver Layer.. Valid values are `successfactors|league_registration|manual|transfer_system`',
    `date_of_birth` DATE COMMENT 'Athletes date of birth in ISO 8601 format (yyyy-MM-dd). Used for age eligibility verification, draft classification, CBA compliance, and league registration.',
    `dominant_foot` STRING COMMENT 'The athletes dominant foot for sports where foot preference is analytically significant (e.g., soccer, rugby). Used in performance analytics, tactical planning, and broadcast commentary.. Valid values are `left|right|both`',
    `dominant_hand` STRING COMMENT 'The athletes dominant hand (throwing, batting, or shooting hand). Critical for performance analytics, matchup strategy, broadcast commentary, and scouting reports.. Valid values are `left|right|ambidextrous`',
    `draft_pick_number` STRING COMMENT 'The overall pick number at which the athlete was selected in the league draft. Used for historical analytics, contract benchmarking, and scouting model validation.',
    `draft_round` STRING COMMENT 'The round number in which the athlete was selected during the league draft. Used for contract tier classification, scouting evaluation benchmarking, and CBA (Collective Bargaining Agreement) rookie scale assignment.',
    `draft_year` STRING COMMENT 'The calendar year in which the athlete was selected in the league draft. Used for career tenure analytics, contract eligibility windows, CBA (Collective Bargaining Agreement) rookie scale calculations, and historical reporting.',
    `eligibility_status` STRING COMMENT 'Current league eligibility status of the athlete, reflecting compliance with CBA (Collective Bargaining Agreement), anti-doping (WADA), and disciplinary rules. Distinct from career_status — an athlete may be active but temporarily ineligible.. Valid values are `eligible|ineligible|pending_review|suspended|banned`',
    `headshot_image_url` STRING COMMENT 'URL reference to the athletes official headshot photograph stored in the Digital Asset Management (DAM) system. Used for broadcast overlays, fan-facing platforms, merchandise, and media kits.. Valid values are `^https?://.+$`',
    `height_cm` DECIMAL(18,2) COMMENT 'Athletes official measured height in centimetres as recorded at league registration or combine. Used for scouting analytics, broadcast graphics, merchandise sizing, and physical eligibility assessments.',
    `injury_status` STRING COMMENT 'Current injury designation for the athlete as reported to the league. Drives roster availability, broadcast commentary, fantasy sports data feeds, and medical staff workflows. [ENUM-REF-CANDIDATE: healthy|day_to_day|injured_reserve|physically_unable|out_for_season — promote to reference product]. Valid values are `healthy|day_to_day|injured_reserve|physically_unable|out_for_season`',
    `jersey_number` STRING COMMENT 'The official jersey/squad number assigned to the athlete on their current roster. Used for broadcast graphics, merchandise production, ticketing displays, and fan engagement content.',
    `league_registration_number` STRING COMMENT 'Externally-known unique identifier assigned by the governing league or federation upon official registration (e.g., NFL Player ID, FIFA Registration Number). Used for inter-system reconciliation, transfer clearances, and regulatory filings.',
    `legal_first_name` STRING COMMENT 'Athletes legal given name as recorded on government-issued identification documents. Used for contract execution, league registration, and regulatory compliance filings.',
    `legal_last_name` STRING COMMENT 'Athletes legal family/surname as recorded on government-issued identification documents. Used for contract execution, league registration, and regulatory compliance filings.',
    `legal_middle_name` STRING COMMENT 'Athletes legal middle name or initial as recorded on government-issued identification. May be required for full legal name matching in contract and compliance contexts.',
    `nationality_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the athletes nationality as declared on their passport or official registration. Governs international transfer eligibility, work permit requirements, and national team selection.. Valid values are `^[A-Z]{3}$`',
    `nil_agreement_active` BOOLEAN COMMENT 'Indicates whether the athlete currently has one or more active NIL (Name, Image, and Likeness) agreements in force. Used to trigger compliance checks, sponsorship conflict reviews, and revenue tracking workflows.',
    `preferred_name` STRING COMMENT 'The name the athlete prefers to be publicly known by, such as a nickname or shortened name (e.g., LeBron or Messi). Used in broadcast graphics, merchandise, and fan-facing content.',
    `primary_position` STRING COMMENT 'The athletes primary playing position as designated by the league or team (e.g., Quarterback, Center Forward, Pitcher, Point Guard). Critical for performance analytics, WAR/ERA/QBR calculations, and broadcast commentary.',
    `pro_debut_date` DATE COMMENT 'The date on which the athlete made their first official professional appearance. Used for career tenure calculations, milestone tracking, broadcast storytelling, and eligibility determinations.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this athlete profile record was first created in the Databricks Silver Layer data product. Used for data lineage, audit trails, and GDPR data subject request processing.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this athlete profile record was most recently modified in the Databricks Silver Layer data product. Used for change data capture, incremental processing, and audit compliance.',
    `retirement_date` DATE COMMENT 'The official date on which the athlete formally retired from professional competition. Nullable for active athletes. Used for career lifecycle reporting, contract termination processing, and alumni engagement programs.',
    `secondary_position` STRING COMMENT 'An alternate playing position the athlete is qualified to fill, enabling flexible roster deployment. Used in lineup planning, injury substitution scenarios, and performance analytics.',
    `social_media_handle_instagram` STRING COMMENT 'Athletes official Instagram social media handle. Used for fan engagement campaigns, NIL (Name, Image, and Likeness) tracking, digital partnership activations, and influencer analytics.. Valid values are `^@[A-Za-z0-9_.]{1,50}$`',
    `social_media_handle_twitter` STRING COMMENT 'Athletes official X (formerly Twitter) social media handle. Used for fan engagement campaigns, NIL (Name, Image, and Likeness) tracking, digital partnership activations, and social media analytics.. Valid values are `^@[A-Za-z0-9_]{1,50}$`',
    `source_system_athlete_code` STRING COMMENT 'The native identifier for this athlete in the originating operational system of record (e.g., SAP SuccessFactors Employee ID, league registration system player ID). Used for cross-system reconciliation and data lineage tracing.',
    `sport_code` STRING COMMENT 'Standardized code identifying the primary sport the athlete competes in (e.g., SOCCER, BASKETBALL, BASEBALL, FOOTBALL, HOCKEY). Used for cross-sport analytics, content tagging, and league routing.',
    `wada_registered_testing_pool` BOOLEAN COMMENT 'Indicates whether the athlete is enrolled in the WADA (World Anti-Doping Agency) Registered Testing Pool (RTP), requiring whereabouts reporting and out-of-competition testing. Critical for anti-doping compliance management.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Athletes official measured weight in kilograms as recorded at league registration or combine. Used for scouting analytics, broadcast graphics, health monitoring, and physical eligibility assessments.',
    CONSTRAINT pk_athlete_profile PRIMARY KEY(`athlete_profile_id`)
) COMMENT 'Core master identity record for every athlete managed by Sports Entertainment. Stores biographical data (full legal name, preferred name, date of birth, nationality, country of origin), physical attributes (height, weight, dominant hand/foot), headshot image reference, social media handles, and career status (active, retired, suspended, deceased). This is the SSOT for athlete identity — all other athlete entities reference this record. Sourced from SAP SuccessFactors talent module and league registration systems.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` (
    `athlete_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the athlete contract record in the lakehouse silver layer. Primary key for the athlete.contract data product.',
    `agent_id` BIGINT COMMENT 'Reference to the certified player agent or agency representing the athlete in contract negotiations.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete (player) who is the primary party to this contract. Links to the athlete master record.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete (player) who is the primary party to this contract. Links to the athlete master record.',
    `cba_agreement_id` BIGINT COMMENT 'Foreign key linking to league.cba_agreement. Business justification: Every player contract is governed by a specific CBA version — salary minimums, cap hit calculations, grievance procedures, and option rules all derive from the governing CBA. Compliance audits and arb',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to legal.corporate_entity. Business justification: Athlete contracts are executed between the athlete and a specific corporate entity (franchise holding company, league subsidiary). The contract has franchise_id but the legal contracting party is the ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Athlete contracts are assigned to cost centers for payroll cost allocation and budget-vs-actual reporting. Sports finance teams track player compensation by cost center (typically per franchise/team).',
    `franchise_id` BIGINT COMMENT 'Reference to the team or franchise that is the employing party on this contract.',
    `insurance_policy_id` BIGINT COMMENT 'Foreign key linking to legal.insurance_policy. Business justification: High-value athlete contracts are backed by contract-specific insurance policies (career-ending injury, disability, key-man coverage). Legal and risk teams must link contracts to their insurance polici',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Contract performance bonus governance: performance_bonus_eligible contracts reference specific KPI definitions that trigger bonus payments. Linking contract to kpi_definition enables automated bonus c',
    `league_id` BIGINT COMMENT 'Reference to the league governing this contract, determining which Collective Bargaining Agreement (CBA) rules apply.',
    `matter_id` BIGINT COMMENT 'Foreign key linking to legal.legal_matter. Business justification: Athlete contract disputes (breach claims, restructuring disagreements, option exercise conflicts) generate legal matters. Linking contract to legal_matter enables legal spend tracking, counsel assignm',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Athlete contracts reference CBA version and compliance requirements. Linking to compliance.policy enables contract compliance audits, CBA version tracking, and regulatory obligation mapping — a named ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Athlete contracts are assigned to profit centers for team-level P&L reporting. Each franchises player costs must roll up to a profit center for EBITDA reporting and revenue-sharing calculations. Stan',
    `position_id` BIGINT COMMENT 'The position identifier in SAP SuccessFactors HCM corresponding to the roster slot filled by this contract. Links payroll processing, benefits administration, and talent management workflows.',
    `tax_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to finance.tax_jurisdiction. Business justification: Athlete contracts require jock tax withholding calculations by jurisdiction. The tax_jurisdiction table has jock_tax_rate_pct and athlete_compensation_taxable_flag. Finance and payroll teams link cont',
    `team_franchise_id` BIGINT COMMENT 'Reference to the team or franchise that is the employing party on this contract.',
    `aav` DECIMAL(18,2) COMMENT 'The Annual Average Value (AAV) of the contract, calculated as total contract value divided by contract years. Industry-standard metric used for salary cap comparisons, market benchmarking, and broadcast commentary.',
    `base_salary_year1` DECIMAL(18,2) COMMENT 'The base salary amount for the first year of the contract term. Used for payroll processing in SAP SuccessFactors and salary cap hit calculation in year one.',
    `cap_hit` DECIMAL(18,2) COMMENT 'The amount of the teams salary cap consumed by this contract in the current league year, calculated per CBA rules (base salary + prorated signing bonus + likely incentives). Critical for roster construction and financial planning.',
    `contract_number` STRING COMMENT 'Externally-known, league-assigned or organization-assigned unique contract reference number used in official filings, league submissions, and SAP S/4HANA SD sales contract documents.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract. Active: currently in force. Expired: term has concluded. Voided: nullified due to breach, failed physical, or mutual agreement. Restructured: terms modified via amendment. Suspended: temporarily inactive due to disciplinary action or league sanction.. Valid values are `active|expired|voided|restructured|suspended`',
    `contract_type` STRING COMMENT 'Classification of the contract by CBA-defined category. Rookie contracts apply to newly drafted players; veteran contracts apply to experienced players; max contracts represent the maximum allowable salary under the CBA; minimum contracts are the league-mandated floor; two-way contracts span both the primary league and a developmental league. [ENUM-REF-CANDIDATE: rookie|veteran|max|minimum|two_way|10_day|exhibit_10|rest_of_season — promote to reference product]. Valid values are `rookie|veteran|max|minimum|two_way`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail, data lineage, and SOX financial controls compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary values on this contract are denominated (e.g., USD for US Dollar, CAD for Canadian Dollar, EUR for Euro). Required for multi-market leagues such as NHL and MLS.. Valid values are `^[A-Z]{3}$`',
    `dead_cap_amount` DECIMAL(18,2) COMMENT 'The salary cap charge that remains against the teams cap after the athlete is released or traded, representing unearned prorated signing bonus and guaranteed money. Used for financial planning and roster management.',
    `end_date` DATE COMMENT 'The date on which the contract term concludes. Nullable for open-ended or multi-year contracts with option years pending. Maps to SAP S/4HANA SD contract validity end date.',
    `free_agency_class` STRING COMMENT 'The athletes free agency classification upon contract expiration. UFA (Unrestricted Free Agent): no team rights retained. RFA (Restricted Free Agent): team retains right of first refusal. ERFA (Exclusive Rights Free Agent): team holds exclusive negotiating rights. Franchise tag and transition tag are team-applied designations preventing free agency.. Valid values are `UFA|RFA|ERFA|franchise_tag|transition_tag|none`',
    `free_agency_open_date` DATE COMMENT 'The date on which the athlete becomes eligible to negotiate with other teams as a free agent, as defined by the league calendar and CBA provisions.',
    `guaranteed_amount` DECIMAL(18,2) COMMENT 'The portion of the total contract value that is fully guaranteed regardless of injury, performance, or termination. Critical for salary cap dead money calculations and financial liability reporting.',
    `negotiation_status` STRING COMMENT 'Current status of free agency or contract renewal negotiations for this athlete. Tracks the negotiation lifecycle from initial contact through signing or expiration of negotiating rights.. Valid values are `open|offer_extended|offer_accepted|offer_rejected|signed|expired`',
    `nil_agreement_flag` BOOLEAN COMMENT 'Indicates whether this contract includes or is associated with a Name, Image and Likeness (NIL) agreement granting the team or league rights to use the athletes identity for commercial purposes.',
    `no_cut_clause` BOOLEAN COMMENT 'Indicates whether the contract contains a no-cut clause preventing the team from releasing the athlete. True = no-cut clause present; False = standard release provisions apply.',
    `no_trade_clause` BOOLEAN COMMENT 'Indicates whether the contract contains a no-trade clause (NTC) preventing the team from trading the athlete without their consent. True = NTC present; False = no restriction. Critical for roster transaction processing.',
    `option_deadline` DATE COMMENT 'The deadline date by which the option-holding party must notify the other party of their intent to exercise or decline the option year(s). Missing this deadline typically results in automatic option declination.',
    `option_type` STRING COMMENT 'Specifies which party holds the right to exercise the option year(s): team option (team decides), player option (athlete decides), mutual option (both parties must agree), or vesting option (automatically vests upon meeting performance thresholds).. Valid values are `team|player|mutual|vesting|none`',
    `option_years` STRING COMMENT 'Number of option years appended to the base contract term. Option years may be exercisable by the team, the player, or mutually, as specified in the contract. Zero if no option years exist.',
    `performance_bonus_eligible` BOOLEAN COMMENT 'Indicates whether the contract includes performance-based incentive bonuses (e.g., statistical thresholds, award bonuses, playoff bonuses). True = performance bonuses are included in the contract terms.',
    `performance_bonus_max` DECIMAL(18,2) COMMENT 'The maximum total amount the athlete can earn in performance-based incentive bonuses over the life of the contract. Used for salary cap likely/unlikely incentive classification per CBA rules.',
    `physical_date` DATE COMMENT 'The date on which the athlete underwent the pre-contract medical examination. Used for compliance tracking and contract contingency resolution.',
    `physical_passed` BOOLEAN COMMENT 'Indicates whether the athlete successfully passed the teams pre-contract medical examination. Contracts are typically contingent on passing the physical; failure may result in contract voiding or restructuring.',
    `qualifying_offer_amount` DECIMAL(18,2) COMMENT 'The one-year salary amount tendered to a Restricted Free Agent (RFA) as a qualifying offer, which preserves the teams right of first refusal. Calculated per CBA formula based on prior year salary.',
    `right_of_first_refusal` BOOLEAN COMMENT 'Indicates whether the team retains the Right of First Refusal (ROFR) to match any offer sheet signed by the athlete with another team. Applicable to Restricted Free Agents (RFA). True = ROFR applies.',
    `roster_status` STRING COMMENT 'The athletes current roster designation under this contract, which affects salary cap treatment and payroll processing. [ENUM-REF-CANDIDATE: active_roster|practice_squad|injured_reserve|suspended|exempt|waived|non_football_injury|physically_unable_to_perform|reserve — promote to reference product]. Valid values are `active_roster|practice_squad|injured_reserve|suspended|exempt|waived`',
    `sap_contract_doc_number` STRING COMMENT 'The document number assigned to this contract in SAP S/4HANA SD module for financial obligation tracking, payroll integration with SAP SuccessFactors, and accounts payable processing. Serves as the cross-system integration key.',
    `signing_bonus` DECIMAL(18,2) COMMENT 'One-time bonus paid to the athlete upon contract execution. For salary cap purposes, signing bonuses are typically prorated across the contract years. Processed via SAP SuccessFactors Payroll and recorded in SAP S/4HANA FI.',
    `signing_date` DATE COMMENT 'The calendar date on which the athlete and team executed (signed) the contract. This is the principal business event timestamp for the contract lifecycle, distinct from the effective start date.',
    `signing_deadline` DATE COMMENT 'The deadline by which the athlete must sign a new contract or tender to remain with the team or enter free agency. Defined by CBA and league calendar (e.g., franchise tag signing deadline).',
    `start_date` DATE COMMENT 'The date on which the contract becomes effective and binding. Corresponds to the first day of the contract term per CBA rules. Maps to SAP S/4HANA SD contract validity start date.',
    `total_value` DECIMAL(18,2) COMMENT 'The gross total compensation value of the contract across all years, including base salary, signing bonus, and performance incentives as stated in the contract. Expressed in the contract currency. Used for salary cap accounting and financial obligation reporting in SAP S/4HANA FI/CO.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Tracks restructures, amendments, and status changes for audit and compliance purposes.',
    `wada_compliant` BOOLEAN COMMENT 'Indicates whether the contract includes WADA anti-doping compliance clauses and the athlete has acknowledged their obligations under the World Anti-Doping Agency (WADA) code. True = WADA compliance clause present and acknowledged.',
    `years` STRING COMMENT 'Total number of years covered by the contract term, including option years if exercised. Used for AAV calculation, salary cap projection, and roster planning.',
    CONSTRAINT pk_athlete_contract PRIMARY KEY(`athlete_contract_id`)
) COMMENT 'Athlete employment and service contracts governing the full lifecycle from initial signing through free agency. Tracks contract terms (compensation, duration, performance bonuses, trade clauses, option years, CBA-mandated terms), contract type (rookie, veteran, max, minimum, two-way), total value, guaranteed money, signing bonus, annual average value (AAV), and contract status (active, expired, voided, restructured). Includes free agency lifecycle: classification (UFA, RFA, ERFA, franchise tag, transition tag), qualifying offer amounts, tender amounts, right-of-first-refusal flags, free agency open date, signing deadline, and negotiation status. Integrates with SAP S/4HANA SD module for financial obligations and payroll processing via SAP SuccessFactors. Serves as the SSOT for an athletes complete employment relationship from signing through free agency periods and re-signing.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` (
    `performance_stat_id` BIGINT COMMENT 'Unique surrogate identifier for each performance statistic record in the Silver layer lakehouse. Represents one statistical line for one athlete in one game or aggregated period.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete whose performance statistics are captured in this record. Links to the athlete master data product in the talent management domain.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete whose performance statistics are captured in this record. Links to the athlete master data product in the talent management domain.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to venue.facility. Business justification: Venue-specific athlete performance analytics — surface type, altitude, crowd density, and facility dimensions directly affect stats. Scouts and coaching staff routinely run facility-level performance ',
    `fixture_id` BIGINT COMMENT 'Reference to the specific game or match event for which these statistics are recorded. Links to the event or fixture product. Null for season-level or career-level aggregated stat records.',
    `franchise_id` BIGINT COMMENT 'Reference to the team the athlete represented during this statistical period. Captures the team context at the time of the stat, which may differ from current roster assignment due to trades or transfers.',
    `game_result_id` BIGINT COMMENT 'Reference to the specific game or match event for which these statistics are recorded. Links to the event or fixture product. Null for season-level or career-level aggregated stat records.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to the KPI definition that this performance stat record contributes to',
    `opponent_team_franchise_id` BIGINT COMMENT 'Reference to the opposing team faced during this game. Enables head-to-head performance analysis, matchup-based scouting reports, and broadcast narrative generation. Null for season or career aggregate records.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Stat certification data lineage: league compliance and data governance teams must trace which pipeline run loaded or certified each performance stat record for official league audit and regulatory rep',
    `primary_performance_franchise_id` BIGINT COMMENT 'Reference to the team the athlete represented during this statistical period. Captures the team context at the time of the stat, which may differ from current roster assignment due to trades or transfers.',
    `season_id` BIGINT COMMENT 'Reference to the league season or competition year to which this statistical record belongs. Enables season-over-season performance trending and standings calculations.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: Sports organizations procure official stats data from vendors (e.g., Sportradar, Stats Perform). Linking each stat record to its supplying vendor enables data quality audits, vendor contract complianc',
    `aggregation_method_override` STRING COMMENT 'An optional override to the KPI definitions default aggregation method, applied specifically when this stat record contributes to this KPI. Allows governance teams to specify non-standard aggregation for edge-case stat-KPI combinations without altering the master KPI definition.',
    `assists` STRING COMMENT 'Number of assists credited to the athlete — passes or actions directly leading to a goal or score. Applicable across soccer, hockey, basketball, and other team sports. Key metric for broadcast overlays and fantasy sports scoring.',
    `batting_average` DECIMAL(18,2) COMMENT 'Baseball-specific metric representing the ratio of hits to official at-bats (H/AB), expressed as a three-decimal fraction (e.g., 0.315). Null for non-baseball records. Foundational hitting metric for broadcast overlays, fantasy sports, and contract evaluation.',
    `blocks` STRING COMMENT 'Number of blocked shots or blocked passes credited to the athlete. Applicable to basketball (NBA shot blocks) and soccer/hockey (blocked shots). Null for non-applicable sport/position combinations.',
    `certification_timestamp` TIMESTAMP COMMENT 'The date and time at which the statistical record was officially certified by the league or governing body. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Null for provisional or pending records. Required for official standings calculations and regulatory reporting.',
    `contribution_weight` DECIMAL(18,2) COMMENT 'The numeric weight (e.g., 0.0 to 1.0 or a raw multiplier) applied to this performance stat record when computing the target KPI value. Belongs to the relationship because the same stat may carry different weights for different KPIs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this performance statistic record was first ingested into the Silver layer lakehouse. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports data lineage, audit trails, and SLA monitoring for the SportsCode/Hudl ingestion pipeline.',
    `era` DECIMAL(18,2) COMMENT 'Earned Run Average (ERA) — baseball-specific pitching metric representing the average number of earned runs allowed per nine innings pitched. Null for non-baseball records. Primary pitching performance indicator for broadcast overlays, fantasy sports, and contract evaluation.',
    `field_goal_percentage` DECIMAL(18,2) COMMENT 'Ratio of successful field goals made to field goals attempted. Applicable to basketball (NBA) and American football (NFL kickers). Null for non-applicable sport/position combinations. Key shooting efficiency metric for broadcast overlays.',
    `fouls_committed` STRING COMMENT 'Total number of fouls committed by the athlete in this statistical period. Applicable to basketball (NBA personal fouls), soccer (FIFA/MLS), and hockey (NHL penalties). Tracks disciplinary and gameplay conduct for compliance and broadcast context.',
    `games_played` STRING COMMENT 'Number of games in which the athlete appeared and was credited with participation. For game-level records this is always 1; for season or career records this represents the cumulative count. Used in rate-stat calculations and eligibility determinations.',
    `games_started` STRING COMMENT 'Number of games in which the athlete was in the starting lineup. Distinguishes starter versus substitute contributions for roster management, contract incentive tracking, and broadcast narrative context.',
    `goals` STRING COMMENT 'Number of goals scored by the athlete in this statistical period. Applicable to soccer (MLS/FIFA), ice hockey (NHL), and other goal-scoring sports. Null for sports where goals are not a primary scoring unit.',
    `hudl_stat_record_reference` STRING COMMENT 'The native record identifier assigned by the SportsCode/Hudl performance analytics platform for this statistical entry. Used for source system traceability and reconciliation against the operational system of record.',
    `innings_pitched` DECIMAL(18,2) COMMENT 'Total innings pitched by a baseball pitcher in this statistical period, expressed in thirds of an inning (e.g., 6.2 = 6 innings and 2 outs). Null for non-pitcher or non-baseball records. Denominator for ERA and other rate-based pitching metrics.',
    `is_home_game` BOOLEAN COMMENT 'Indicates whether the athletes team was the home team during this game. True = home team; False = away team. Null for season or career aggregate records. Enables home/away performance split analysis for broadcast storytelling and scouting.',
    `is_primary_input` BOOLEAN COMMENT 'Indicates whether this performance stat record is the primary driver of the KPI value (true) or a secondary/supplementary input (false). Used by reporting systems to prioritise which stat to surface in broadcast overlays and governance dashboards.',
    `minutes_played` DECIMAL(18,2) COMMENT 'Total minutes of active participation recorded for the athlete in this statistical period. Used for per-minute rate statistics, workload management, and injury risk analytics. Applicable to basketball, soccer, hockey, and other timed sports.',
    `on_base_percentage` DECIMAL(18,2) COMMENT 'Baseball-specific metric measuring how frequently a batter reaches base per plate appearance, including hits, walks, and hit-by-pitch. Null for non-baseball records. Advanced hitting metric used alongside batting average for comprehensive offensive evaluation.',
    `passing_yards` STRING COMMENT 'Total passing yards accumulated by the athlete in this statistical period. NFL-specific metric for quarterbacks and passing plays. Null for non-football records or non-passing positions. Key broadcast overlay and fantasy sports metric.',
    `plus_minus` STRING COMMENT 'The plus/minus differential representing the net score differential when the athlete was on the ice or court. Applicable to ice hockey (NHL) and basketball (NBA). Positive values indicate the team outscored opponents during the athletes time on the field. Key advanced analytics input.',
    `points_scored` STRING COMMENT 'Total points scored by the athlete in this statistical period. Applicable to basketball (NBA), American football (NFL touchdowns/field goals), and other point-based sports. Null for sports where points are not individually attributed.',
    `position_played` STRING COMMENT 'The on-field position the athlete occupied during this game or statistical period (e.g., Quarterback, Pitcher, Point Guard, Center Forward, Goalkeeper). Position context is critical for sport-specific metric interpretation and broadcast overlays.',
    `qbr` DECIMAL(18,2) COMMENT 'Quarterback Rating (QBR) — NFL-specific composite passing efficiency metric scaled 0–100 measuring a quarterbacks overall performance including passing, rushing, and situational adjustments. Null for non-quarterback or non-football records. Used for broadcast overlays and fantasy sports feeds.',
    `rebounds` STRING COMMENT 'Total number of rebounds (offensive plus defensive) credited to the athlete. Basketball-specific metric (NBA). Null for non-basketball records. Used in broadcast overlays, fantasy sports feeds, and player valuation models.',
    `receiving_yards` STRING COMMENT 'Total receiving yards accumulated by the athlete in this statistical period. NFL-specific metric for wide receivers, tight ends, and running backs. Null for non-football records. Key fantasy sports and broadcast overlay metric.',
    `red_cards` STRING COMMENT 'Number of red cards (ejections) received by the athlete in this statistical period. Soccer-specific (FIFA/MLS) disciplinary metric. Null for non-soccer records. Triggers automatic suspension and is tracked for league compliance and CBA reporting.',
    `rushing_yards` STRING COMMENT 'Total rushing yards accumulated by the athlete in this statistical period. NFL-specific metric for running backs, quarterbacks, and other ball carriers. Null for non-football records. Used in broadcast overlays and fantasy sports scoring.',
    `saves` STRING COMMENT 'Number of saves recorded by the athlete. Applicable to goalkeepers in soccer and hockey, and to relief pitchers in baseball (MLB save rule). Null for non-applicable sport/position combinations.',
    `slugging_percentage` DECIMAL(18,2) COMMENT 'Baseball-specific advanced hitting metric measuring total bases per at-bat, reflecting extra-base hit power. Null for non-baseball records. Combined with on-base percentage to produce OPS (On-Base Plus Slugging) for comprehensive offensive evaluation.',
    `sport_discipline` STRING COMMENT 'The specific sport or discipline for which these statistics apply (e.g., American Football, Baseball, Basketball, Ice Hockey, Soccer, Tennis). Determines which sport-specific metric fields are populated and which are null. [ENUM-REF-CANDIDATE: american_football|baseball|basketball|ice_hockey|soccer|tennis|golf|mma|rugby|cricket — promote to reference product]',
    `stat_date` DATE COMMENT 'The calendar date on which the game was played or the date representing the end of the aggregation period for season/career records. Formatted as yyyy-MM-dd per enterprise data standards.',
    `stat_period_end_date` DATE COMMENT 'The end date of the window over which this performance stat record is considered a valid input to the KPI calculation. Together with stat_period_start_date, defines the contribution scope for this specific mapping.',
    `stat_period_start_date` DATE COMMENT 'The start date of the window over which this performance stat record is considered a valid input to the KPI calculation. Scopes the contribution temporally without altering the stat record or the KPI definition.',
    `stat_status` STRING COMMENT 'Current lifecycle status of the statistical record. Official records are certified by the league; provisional records are pending official certification; revised records have been corrected post-certification; voided records are invalidated due to forfeit, protest, or data error; pending_review records are under investigation.. Valid values are `official|provisional|revised|voided|pending_review`',
    `stat_type` STRING COMMENT 'Classifies whether this record represents a single-game statistical line, a season-level aggregate, a career-level aggregate, a playoff period, or a tournament-specific accumulation. Drives how the record is consumed by broadcast overlays, fantasy feeds, and standings engines.. Valid values are `game|season|career|playoff|tournament`',
    `steals` STRING COMMENT 'Number of steals credited to the athlete. Primarily a basketball (NBA) defensive metric. Also applicable to baseball (stolen bases). Null for non-applicable sport/position combinations.',
    `strikeouts` STRING COMMENT 'Number of strikeouts recorded. For pitchers (MLB), this is the count of batters struck out. For batters, this is the count of times struck out. Null for non-baseball records. Key pitching and batting evaluation metric.',
    `tackles` STRING COMMENT 'Number of tackles made by the athlete. Applicable to American football (NFL) defensive players and soccer (FIFA/MLS) players. Null for sports or positions where tackles are not a tracked metric.',
    `touchdowns` STRING COMMENT 'Total touchdowns scored or thrown by the athlete in this statistical period. NFL-specific metric covering passing touchdowns, rushing touchdowns, and receiving touchdowns. Null for non-football records.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this performance statistic record was last modified in the Silver layer lakehouse. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Tracks revisions, corrections, and re-certifications. Required for change data capture and audit compliance.',
    `war` DECIMAL(18,2) COMMENT 'Wins Above Replacement (WAR) — a composite advanced metric estimating the total number of additional wins the athlete contributed to their team compared to a replacement-level player. Sourced from SportsCode/Hudl analytics engine. Used for contract valuation, trade analysis, and broadcast storytelling.',
    `yellow_cards` STRING COMMENT 'Number of yellow cards (cautions) received by the athlete in this statistical period. Soccer-specific (FIFA/MLS) disciplinary metric. Null for non-soccer records. Relevant for suspension tracking and league compliance reporting.',
    CONSTRAINT pk_performance_stat PRIMARY KEY(`performance_stat_id`)
) COMMENT 'Game-level and season-level performance statistics for athletes across all sports disciplines. Captures sport-specific metrics including WAR (Wins Above Replacement), ERA (Earned Run Average), QBR (Quarterback Rating), goals, assists, rebounds, tackles, saves, batting average, on-base percentage, and advanced analytics inputs. Sourced from SportsCode/Hudl performance analytics platform. Each record represents a statistical line for one athlete in one game or aggregated period, enabling broadcast overlays, fantasy sports feeds, and league standings calculations.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` (
    `injury_record_id` BIGINT COMMENT 'Unique surrogate identifier for each athlete injury or medical event record in the system. Primary key for the injury_record data product.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who sustained the injury or medical event. Links to the athlete master record in the talent management domain.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who sustained the injury or medical event. Links to the athlete master record in the talent management domain.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Injury records carry insurance_reserve_amount and workers_comp_claim_number. Medical costs and insurance reserves must be allocated to a cost center for financial reporting, workers comp accounting, ',
    `employee_id` BIGINT COMMENT 'Reference to the licensed medical professional (team physician, orthopedic surgeon, or specialist) who diagnosed and is managing the athletes treatment protocol.',
    `event_fixture_id` BIGINT COMMENT 'Reference to the game, match, or competition event during which the injury occurred, if applicable. Null for practice or non-event injuries.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to venue.facility. Business justification: OSHA venue-level injury reporting and insurance liability tracking require linking athlete injuries to the specific facility where they occurred. Sports operations teams run facility safety scorecards',
    `fixture_id` BIGINT COMMENT 'Reference to the game, match, or competition event during which the injury occurred, if applicable. Null for practice or non-event injuries.',
    `franchise_id` BIGINT COMMENT 'Reference to the team roster the athlete was assigned to at the time of injury. Used for roster eligibility impact analysis and league reporting.',
    `game_result_id` BIGINT COMMENT 'Foreign key linking to league.game_result. Business justification: Injuries sustained during a specific game must be linked to the official game result for broadcast disclosure workflows, OSHA in-game injury reporting, and insurance claim documentation. The game_resu',
    `insurance_claim_id` BIGINT COMMENT 'Foreign key linking to legal.insurance_claim. Business justification: Athlete injuries trigger insurance claims (workers compensation, disability, liability). The injury_record has workers_comp_claim_number as a denormalized string and insurance_reserve_amount but no FK',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: IR designations, OSHA recordable counts, and salary cap injured-reserve credits are all tracked per season. Season context is required for cap compliance snapshots and CBA-mandated injury reporting ag',
    `prior_injury_record_id` BIGINT COMMENT 'Self-referencing identifier linking this recurrent injury to the original injury record for the same body part. Populated only when is_recurrence is True. Enables injury recurrence chain analysis and longitudinal athlete health tracking.',
    `security_incident_id` BIGINT COMMENT 'Foreign key linking to security.security_incident. Business justification: When an athlete injury is caused by or concurrent with a security incident (on-field assault, crowd intrusion, altercation), medical and security teams must cross-reference records for insurance claim',
    `team_franchise_id` BIGINT COMMENT 'Reference to the team roster the athlete was assigned to at the time of injury. Used for roster eligibility impact analysis and league reporting.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Major injury rehabilitation programs (surgery, extended rehab) are tracked as project expenditures via WBS elements in SAP. Finance teams create WBS elements for significant injury cases to track actu',
    `actual_rtp_date` DATE COMMENT 'Actual date on which the athlete was medically cleared and returned to full competitive play. Distinct from expected_rtp_date; the variance between these dates is a key metric for medical staff performance and recovery protocol effectiveness.',
    `body_part` STRING COMMENT 'Standardized anatomical body part or region affected by the injury (e.g., left_knee, right_shoulder, lumbar_spine, hamstring_right). Used for injury pattern analytics, performance risk modeling, and broadcast injury reporting. [ENUM-REF-CANDIDATE: promote to reference product with full anatomical taxonomy]',
    `body_side` STRING COMMENT 'Laterality of the injured body part indicating which side of the body is affected. bilateral applies when both sides are involved; central for midline structures (spine, head); not_applicable for systemic conditions or illnesses.. Valid values are `left|right|bilateral|central|not_applicable`',
    `broadcast_disclosure_approved` BOOLEAN COMMENT 'Indicates whether the athlete and team have approved disclosure of this injury for broadcast and media communications. When True, injury status and expected RTP may be shared with broadcast partners and media. Supports DTC fan engagement and broadcast content production.',
    `broadcast_injury_note` STRING COMMENT 'Approved public-facing injury description for use in broadcast, media, and fan communications. Sanitized version of the clinical description that omits protected health information. Populated only when broadcast_disclosure_approved is True. Used by Dalet Galaxy broadcast workflow for on-air injury reporting.',
    `case_number` STRING COMMENT 'Externally-known alphanumeric case reference assigned by the team medical staff system at the time of injury intake. Used for cross-referencing with insurance claims, OSHA logs, and league medical reporting. Format: INJ-YYYY-NNNNNN.. Valid values are `^INJ-[0-9]{4}-[0-9]{6}$`',
    `concussion_protocol_triggered` BOOLEAN COMMENT 'Indicates whether the leagues mandatory concussion evaluation and graduated return-to-play protocol was triggered for this injury. Drives specific compliance tracking requirements distinct from standard injury management. Required for league concussion protocol reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this injury record was first created in the medical management system. Supports audit trail, data lineage, and OSHA recordkeeping compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the insurance_reserve_amount (e.g., USD, EUR, GBP). Required for multi-market operations across global leagues.. Valid values are `^[A-Z]{3}$`',
    `days_lost_actual` STRING COMMENT 'Actual number of calendar days the athlete was unavailable for competition, calculated upon return to play or case closure. Used for OSHA recordkeeping (days away from work), insurance settlement, and injury analytics benchmarking.',
    `days_lost_estimated` STRING COMMENT 'Physician-estimated number of calendar days the athlete is expected to be unavailable for competition due to the injury. Used for roster planning, insurance claim valuation, and broadcast availability reporting. Distinct from actual days lost which is calculated from actual RTP date.',
    `expected_rtp_date` DATE COMMENT 'Physician-projected date on which the athlete is expected to return to full competitive play (Return-to-Play / RTP). Used for roster management, broadcast scheduling, and fan communications. May be updated as recovery progresses.',
    `icd10_code` STRING COMMENT 'International Classification of Diseases, 10th Revision (ICD-10-CM) diagnosis code assigned by the treating physician. Standardizes injury classification for insurance claims, OSHA reporting, league medical databases, and cross-team analytics. Required for workers compensation and insurance claim processing.. Valid values are `^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$`',
    `injury_date` DATE COMMENT 'Calendar date on which the injury or medical event was first sustained or identified. Principal business event date for the injury lifecycle. Used for OSHA recordkeeping, insurance claim filing windows, and roster eligibility calculations.',
    `injury_description` STRING COMMENT 'Free-text clinical narrative describing the nature, mechanism, and circumstances of the injury or medical event as documented by the treating physician or athletic trainer. Supports detailed medical review and insurance claim documentation.',
    `injury_location` STRING COMMENT 'Setting or context in which the injury occurred. Distinguishes game-time injuries from practice, training facility, or travel-related incidents. Affects OSHA recordability determination, workers compensation eligibility, and league reporting obligations.. Valid values are `game|practice|training_facility|travel|other`',
    `injury_mechanism` STRING COMMENT 'Mechanism by which the injury was sustained. contact indicates collision with another player or object; non_contact indicates injury without external contact (e.g., ACL tear during cutting); overexertion indicates fatigue or training load-related; environmental indicates field/court surface or weather-related cause. Critical for OSHA incident classification and injury prevention analytics.. Valid values are `contact|non_contact|overexertion|environmental|unknown`',
    `injury_status` STRING COMMENT 'Current roster and medical status of the injury record reflecting the athletes availability. day_to_day indicates probable return within 1-2 days; injured_reserve (IR) indicates formal IR designation per league CBA rules; returned indicates the athlete has cleared return-to-play protocol; closed indicates the case is administratively closed.. Valid values are `active|day_to_day|injured_reserve|out|returned|closed`',
    `injury_type` STRING COMMENT 'High-level clinical classification of the injury or medical event. acute refers to sudden-onset traumatic injuries; chronic refers to long-standing conditions; overuse refers to repetitive stress injuries; concussion is tracked separately per league concussion protocol requirements. [ENUM-REF-CANDIDATE: acute|chronic|overuse|illness|concussion|fracture|laceration|dislocation|sprain|strain — promote to reference product]. Valid values are `acute|chronic|overuse|illness|concussion|fracture`',
    `insurance_reserve_amount` DECIMAL(18,2) COMMENT 'Financial reserve amount (in USD) set aside by the teams insurance carrier for this injury claim. Represents the estimated total cost of the claim including medical treatment, salary continuation, and rehabilitation. Used for financial planning and SAP S/4HANA FI/CO reserve posting.',
    `ir_designation` STRING COMMENT 'Formal league roster designation for the injured athlete per Collective Bargaining Agreement (CBA) rules. ir_standard = standard Injured Reserve placement; ir_return_designated = IR with designation to return (allows one return per season); ir_non_football = injury unrelated to sport; pup_list = Physically Unable to Perform list (pre-season). Drives roster count compliance and salary cap implications.. Valid values are `none|ir_standard|ir_return_designated|ir_non_football|pup_list`',
    `is_osha_recordable` BOOLEAN COMMENT 'Indicates whether this injury meets OSHA recordability criteria under 29 CFR 1904 (i.e., results in days away from work, restricted duty, medical treatment beyond first aid, loss of consciousness, or diagnosis of a significant condition). Required for OSHA 300 Log annual reporting.',
    `is_recurrence` BOOLEAN COMMENT 'Indicates whether this injury is a recurrence of a previously documented injury to the same body part. Recurrent injuries are tracked separately for medical analytics, contract risk assessment, and insurance underwriting purposes.',
    `is_wada_reportable` BOOLEAN COMMENT 'Indicates whether this medical event requires reporting to the World Anti-Doping Agency (WADA), typically when treatment involves substances on the WADA Prohibited List requiring a Therapeutic Use Exemption (TUE). Critical for anti-doping compliance.',
    `is_workers_comp_claim` BOOLEAN COMMENT 'Indicates whether a workers compensation insurance claim has been filed for this injury. Triggers coordination with the insurance and finance teams for claim processing and reserve setting.',
    `medical_staff_notes` STRING COMMENT 'Confidential clinical notes from the teams medical staff including athletic trainers, physical therapists, and team physicians documenting daily progress, treatment adjustments, and rehabilitation milestones. Restricted to authorized medical personnel per HIPAA and CBA medical privacy provisions.',
    `reported_date` DATE COMMENT 'Date on which the injury was formally reported to team medical staff or league operations. May differ from injury_date for delayed-onset conditions or injuries initially unreported. Critical for OSHA recordkeeping compliance windows.',
    `rtp_clearance_stage` STRING COMMENT 'Current stage in the graduated Return-to-Play (RTP) protocol as defined by league medical standards and CBA. Tracks progression from initial rest through limited activity, non-contact practice, full practice, and final medical clearance. Critical for concussion protocol compliance.. Valid values are `not_started|limited_activity|non_contact_practice|full_practice|cleared|cleared_with_restrictions`',
    `severity_grade` STRING COMMENT 'Clinical severity classification of the injury based on expected time loss and functional impact. minor = <7 days; moderate = 7-28 days; severe = >28 days; career_threatening = potential permanent impact on playing career. Used for insurance valuation, roster planning, and broadcast communications.. Valid values are `minor|moderate|severe|career_threatening`',
    `source_system` STRING COMMENT 'Operational system of record from which this injury record was ingested or originated. Supports data lineage tracking in the Databricks Silver Layer. Typical sources include SAP SuccessFactors HCM, SportsCode/Hudl performance analytics, or team-specific medical management systems.. Valid values are `sap_successfactors|hudl|manual_entry|team_medical_system|other`',
    `surgery_date` DATE COMMENT 'Date on which surgical procedure was performed, if applicable. Null when surgery_required is False. Used as a key milestone in recovery timeline planning and insurance claim documentation.',
    `surgery_required` BOOLEAN COMMENT 'Indicates whether surgical intervention is required or has been performed as part of the treatment protocol. Surgical cases typically have significantly longer recovery timelines and higher insurance claim values.',
    `treating_physician_reference` BIGINT COMMENT 'Reference to the licensed medical professional (team physician, orthopedic surgeon, or specialist) who diagnosed and is managing the athletes treatment protocol.',
    `treatment_protocol` STRING COMMENT 'Structured description of the prescribed medical treatment plan including surgical intervention, physical therapy regimen, medication management, and rehabilitation milestones as documented by the treating physician. Supports medical staff coordination and insurance documentation.',
    `tue_reference` STRING COMMENT 'Reference number for the WADA Therapeutic Use Exemption (TUE) application or approval associated with this injurys treatment protocol. Populated when is_wada_reportable is True and treatment involves a prohibited substance. Required for anti-doping compliance documentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this injury record, including status changes, RTP date updates, or treatment protocol revisions. Supports audit trail and data freshness monitoring.',
    CONSTRAINT pk_injury_record PRIMARY KEY(`injury_record_id`)
) COMMENT 'Clinical and operational record of athlete injuries, illnesses, and medical events throughout their career. Tracks injury type, body part affected, diagnosis code (ICD-10), injury date, expected return-to-play (RTP) date, actual RTP date, treatment protocol, treating physician, and impact on roster eligibility (IR designation, day-to-day, out). Supports OSHA compliance reporting, insurance claims, and broadcast injury updates. Managed in coordination with team medical staff systems.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` (
    `draft_selection_id` BIGINT COMMENT 'Unique surrogate identifier for each draft selection record in the lakehouse silver layer. Primary key for the draft_selection data product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Draft pick broadcast announcement: each draft selection generates an official broadcast asset (commissioner announcement clip, pick card video). draft_selection.broadcast_pick_announced_by is a denorm',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete record for the player selected in this draft pick. Links to the athlete master record capturing identity, eligibility, and career lifecycle.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete record for the player selected in this draft pick. Links to the athlete master record capturing identity, eligibility, and career lifecycle.',
    `cba_agreement_id` BIGINT COMMENT 'Foreign key linking to league.cba_agreement. Business justification: Draft signing slot values, bonus pools, and rookie contract terms are governed by the CBA in effect at draft time. Linking to the governing CBA enables slot value validation, signing deadline enforcem',
    `combine_result_id` BIGINT COMMENT 'Foreign key linking to athlete.combine_result. Business justification: Draft selections reference combine performance as a key input to the selection decision. The draft_selection table currently stores denormalized combine data (combine_score, combine_forty_time, combin',
    `contract_template_id` BIGINT COMMENT 'Foreign key linking to legal.contract_template. Business justification: Draft selections trigger standard rookie contracts drafted from CBA-mandated legal templates with slot values. Legal compliance requires tracking which template version governed each draft signing for',
    `draft_class_draft_id` BIGINT COMMENT 'Reference to the draft class cohort record grouping all athletes eligible for a specific draft year and league. Supports draft class analytics and historical comparisons.',
    `draft_id` BIGINT COMMENT 'Reference to the draft class cohort record grouping all athletes eligible for a specific draft year and league. Supports draft class analytics and historical comparisons.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to venue.facility. Business justification: Draft events are hosted at specific facilities requiring venue booking, capacity configuration, and broadcast infrastructure. draft_selection has a denormalized draft_event_location text field; a faci',
    `franchise_id` BIGINT COMMENT 'Reference to the franchise or club that exercised this draft pick and holds the rights to the selected athlete. May differ from original_team_id if the pick was traded.',
    `league_id` BIGINT COMMENT 'Reference to the league governing this draft (e.g., NFL, NBA, MLB, MLS). Determines applicable CBA rules, salary slot values, and eligibility criteria.',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: Draft selections are tied to a specific league season for salary cap slot calculations, rookie wage scale application, and CBA draft eligibility compliance. Season FK enables draft class cap reporting',
    `original_team_franchise_id` BIGINT COMMENT 'Reference to the team that originally owned this draft pick before any trade. Null if the pick was never traded. Critical for trade history and compensatory pick tracking.',
    `primary_draft_franchise_id` BIGINT COMMENT 'Reference to the franchise or club that exercised this draft pick and holds the rights to the selected athlete. May differ from original_team_id if the pick was traded.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Draft signing bonuses (actual_signing_bonus, signing_slot_value on draft_selection) are capitalized and tracked via WBS elements in SAP for capital expenditure reporting. Finance teams assign each dra',
    `actual_signing_bonus` DECIMAL(18,2) COMMENT 'The actual signing bonus amount in USD agreed upon in the athletes rookie contract. May differ from signing_slot_value due to negotiations within CBA-permitted ranges. Used for salary cap accounting and financial reporting.',
    `athlete_college` STRING COMMENT 'Name of the college, university, or prior professional club from which the athlete was drafted. Used for draft class analytics, alumni tracking, and broadcast storytelling content.',
    `athlete_nationality` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the athletes nationality at the time of the draft. Relevant for international player rules, visa requirements, and global broadcast analytics.. Valid values are `^[A-Z]{3}$`',
    `athlete_position` STRING COMMENT 'The primary playing position of the athlete at the time of the draft (e.g., QB, WR, PG, SP, ST). Position is sport-specific and drives positional scarcity analytics and roster construction. [ENUM-REF-CANDIDATE: QB|WR|RB|TE|OL|DL|LB|DB|K|P|PG|SG|SF|PF|C|SP|RP|SS|GK|DEF|MID|FWD — promote to reference product]',
    `conditional_pick_terms` STRING COMMENT 'Free-text description of the conditions governing a conditional pick (e.g., Becomes 1st round if team makes playoffs; otherwise 2nd round). Populated only when is_conditional_pick is True.',
    `contract_option_years` STRING COMMENT 'Number of team option years available beyond the base rookie contract term (e.g., 5th-year option in NFL for 1st-round picks). Null if no option applies under the CBA.',
    `contract_years` STRING COMMENT 'Number of years in the standard rookie contract associated with this draft selection as defined by the applicable CBA (e.g., 4-year rookie deal in NFL, 2+2 in NBA). Drives roster planning and cap projection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this draft selection record was first created in the lakehouse silver layer. Used for data lineage, audit trail, and ETL pipeline monitoring.',
    `draft_date` DATE COMMENT 'Calendar date on which this specific pick was made during the draft event. Multi-day drafts (e.g., NFL Draft spans 3 days) require day-level precision for scheduling and broadcast.',
    `draft_year` STRING COMMENT 'Calendar year in which the draft event took place (e.g., 2024). Used for cohort analysis, salary cap slot assignment per CBA, and historical draft analytics.',
    `eligibility_year` STRING COMMENT 'The year in which the athlete first became eligible for the draft under league rules (e.g., 3 years post-high school for NFL, 1 year post-high school for NBA). Used for eligibility compliance and age-based analytics.',
    `is_compensatory_pick` BOOLEAN COMMENT 'Indicates whether this pick was awarded as a compensatory selection by the league office, typically for losing qualifying free agents. Compensatory picks have specific CBA rules on tradability.',
    `is_conditional_pick` BOOLEAN COMMENT 'Indicates whether this pick was subject to conditions (e.g., round changes based on player performance or team standings) at the time of the trade agreement.',
    `is_traded_pick` BOOLEAN COMMENT 'Indicates whether this draft pick was acquired through a trade from another team. True when selecting_team_id differs from original_team_id. Critical for trade value analytics and salary cap management.',
    `medical_clearance_status` STRING COMMENT 'Medical clearance status resulting from the teams pre-draft physical examination. cleared = fully fit; conditional = cleared with noted conditions; not_cleared = failed physical; pending = exam not yet completed. Impacts signing decision and contract terms.. Valid values are `cleared|conditional|not_cleared|pending`',
    `notes` STRING COMMENT 'Free-text field for additional context about this draft selection, such as trade details, conditional pick resolution notes, or special circumstances noted by league operations staff.',
    `overall_pick_number` STRING COMMENT 'The absolute sequential pick number across all rounds of the draft (e.g., pick 33 is the first pick of round 2 in a 32-team league). Primary ranking metric for draft analytics and historical comparisons.',
    `pick_number_in_round` STRING COMMENT 'The sequential pick number within the specific round (e.g., pick 3 in round 2). Combined with round_number to identify the pick within its round context.',
    `pick_type` STRING COMMENT 'Classification of the draft pick by its origin. standard = regular draft order pick; compensatory = awarded by league for losing free agents; supplemental = special draft outside normal cycle; conditional = pick contingent on performance conditions; traded = pick acquired via trade.. Valid values are `standard|compensatory|supplemental|conditional|traded`',
    `pre_draft_grade` DECIMAL(18,2) COMMENT 'Numerical scouting grade assigned to the athlete prior to the draft on a standardized scale (e.g., 0.00–100.00 or 1.00–8.00 per NFL scouting convention). Reflects overall prospect evaluation by the teams scouting department.',
    `pre_draft_ranking` STRING COMMENT 'The consensus pre-draft ranking of the athlete among all eligible prospects, as published by the league or a recognized scouting service prior to the draft. Used to measure draft value (reach vs. value picks) and scouting accuracy analytics.',
    `round_number` STRING COMMENT 'The round within the draft in which this selection was made (e.g., 1 for first round, 7 for seventh round in NFL Draft). Determines salary slot value per CBA and signing bonus expectations.',
    `selection_code` STRING COMMENT 'Externally-known business identifier for this draft pick in the format LEAGUE-YEAR-ROUND-PICK (e.g., NFL-2024-R1-P01). Used in league communications, broadcast graphics, and official records.. Valid values are `^[A-Z]{2,5}-[0-9]{4}-R[0-9]{1,2}-P[0-9]{1,3}$`',
    `selection_status` STRING COMMENT 'Current lifecycle status of the draft selection. announced = pick made but contract not yet signed; signed = athlete under contract; unsigned = deadline passed without signing; voided = selection invalidated; traded_rights = negotiating rights traded post-draft; forfeited = pick forfeited due to league penalty.. Valid values are `announced|signed|unsigned|voided|traded_rights|forfeited`',
    `selection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the pick was officially announced and recorded during the draft event. Used for broadcast sequencing, official league records, and audit trail.',
    `signed_date` DATE COMMENT 'The date on which the athlete officially signed the rookie contract with the selecting team. Null if unsigned. Triggers salary cap activation and roster registration.',
    `signing_deadline` DATE COMMENT 'The CBA-mandated deadline by which the selected athlete must sign a rookie contract or forfeit draft rights for the current year. Critical for roster and contract management workflows.',
    `signing_slot_value` DECIMAL(18,2) COMMENT 'The CBA-mandated signing bonus slot value in USD assigned to this pick based on its round and overall pick number. Governs the maximum signing bonus a team may offer without penalty. Critical for salary cap management and EBITDA reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this draft selection record was last modified in the lakehouse silver layer. Tracks status changes (e.g., unsigned to signed), contract updates, and data corrections.',
    `wada_clearance_status` STRING COMMENT 'Anti-doping clearance status of the athlete at the time of the draft per World Anti-Doping Agency (WADA) and league anti-doping program requirements. cleared = no violations; pending = under review; suspended = serving ban; ineligible = permanently ineligible.. Valid values are `cleared|pending|suspended|ineligible`',
    CONSTRAINT pk_draft_selection PRIMARY KEY(`draft_selection_id`)
) COMMENT 'Record of athlete selections made during league drafts (NFL Draft, NBA Draft, MLB Draft, MLS SuperDraft, etc.). Captures draft year, round number, overall pick number, selecting team, original team (if traded), draft class, pre-draft ranking, combine performance scores, and signing slot value per CBA. Tracks compensatory picks, traded picks, and conditional picks. Essential for league governance, salary cap management, and historical analytics.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` (
    `eligibility_status_id` BIGINT COMMENT 'Unique surrogate identifier for each eligibility status record in the athlete domain. Primary key for the eligibility_status data product.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete whose eligibility is being tracked. Links to the athlete master record.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete whose eligibility is being tracked. Links to the athlete master record.',
    `exemption_id` BIGINT COMMENT 'Foreign key linking to compliance.exemption. Business justification: Therapeutic Use Exemptions (TUEs) directly determine athlete eligibility for competition. eligibility_status must reference compliance.exemption to confirm an active TUE permits otherwise-prohibited s',
    `governing_body_id` BIGINT COMMENT 'Reference to the specific governing or regulatory body that issued or enforces this eligibility determination (e.g., WADA, CAS, FIFA, NFL League Office, USADA).',
    `incident_report_id` BIGINT COMMENT 'Chain-of-custody reference to the originating doping test, conduct violation, or disciplinary incident that triggered this eligibility event. Null for non-disciplinary eligibility types.',
    `league_id` BIGINT COMMENT 'Reference to the league or competition body under whose jurisdiction this eligibility record applies (e.g., NFL, NBA, FIFA, NHL, MLS).',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: Eligibility windows, games_remaining counts, and game-day eligibility flags are season-specific. Season FK is required for game-day eligibility reports, CBA compliance audits, and suspension games-rem',
    `litigation_case_id` BIGINT COMMENT 'Foreign key linking to legal.litigation_case. Business justification: Eligibility rulings (doping bans, transfer denials, age disputes) are frequently challenged in litigation or arbitration. Linking eligibility_status to litigation_case enables legal teams to track act',
    `nil_agreement_id` BIGINT COMMENT 'Reference to the active NIL agreement associated with this eligibility record, applicable for student-athletes or athletes in NIL-eligible competitions. Used to verify NIL compliance does not affect amateur status.',
    `regulatory_license_id` BIGINT COMMENT 'Foreign key linking to legal.regulatory_license. Business justification: Athlete eligibility is directly governed by regulatory licenses (federation registration, work permits, wagering exclusion clearances). eligibility_status has visa_permit_number and registration_numbe',
    `sanction_id` BIGINT COMMENT 'Foreign key linking to compliance.sanction. Business justification: Game-day eligibility determinations are directly affected by active compliance sanctions (fines, bans, conditional eligibility). eligibility_status must reference the authoritative compliance.sanction',
    `suspension_record_id` BIGINT COMMENT 'Foreign key linking to athlete.suspension_record. Business justification: An eligibility status change is frequently triggered by a disciplinary suspension. The eligibility_status table currently stores denormalized suspension data (suspension_type, suspension_length, viola',
    `age_eligibility_verified` BOOLEAN COMMENT 'Indicates whether the athletes age has been formally verified against the minimum or maximum age requirements of the applicable competition or governing body (e.g., FIFA U-17 age verification, NBA draft age rule).',
    `amateur_professional_status` STRING COMMENT 'Indicates whether the athlete holds amateur, professional, student-athlete, or Name Image and Likeness (NIL) eligible status under the applicable governing body rules. Drives eligibility for specific competitions and NIL agreement compliance.. Valid values are `amateur|professional|student_athlete|nil_eligible`',
    `appeal_filed_date` DATE COMMENT 'Date on which the athlete or governing body formally filed an appeal against this eligibility determination. Null if no appeal has been filed.',
    `appeal_outcome_date` DATE COMMENT 'Date on which the appellate body (CAS, league arbitration panel) issued its final ruling on the appeal. Null if appeal is still pending or no appeal was filed.',
    `appeal_outcome_notes` STRING COMMENT 'Summary of the appellate bodys ruling, including any modification to the original sanction (e.g., reduction in suspension length, fine adjustment, full exoneration). Null if no appeal or outcome not yet determined.',
    `appeal_status` STRING COMMENT 'Current status of any appeal filed against this eligibility determination. Tracks the appeal lifecycle from filing through final outcome at CAS or relevant appellate body.. Valid values are `not_appealed|appeal_filed|appeal_pending|appeal_upheld|appeal_dismissed|appeal_reduced`',
    `broadcast_clearance_flag` BOOLEAN COMMENT 'Indicates whether this athletes eligibility status has been cleared for broadcast rights purposes. Ineligible or suspended athletes may require content redaction or rights clearance review for broadcast and OTT distribution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility status record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `decision_date` DATE COMMENT 'Date on which the governing body or issuing authority formally rendered the eligibility determination or disciplinary decision. Distinct from effective_date, which is when the restriction begins.',
    `effective_date` DATE COMMENT 'The date on which this eligibility status becomes binding and enforceable. For suspensions, this is the first day the athlete is prohibited from competing.',
    `eligibility_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned by the governing body or league office to uniquely identify this eligibility determination. Used for cross-system reconciliation and official correspondence.',
    `eligibility_status` STRING COMMENT 'Current lifecycle state of this eligibility record indicating whether the athlete is permitted to compete under the associated governing body and league. Drives real-time game-day eligibility verification and broadcast rights clearances.. Valid values are `eligible|ineligible|suspended|pending_review|conditionally_eligible|reinstated`',
    `eligibility_type` STRING COMMENT 'Classification of the eligibility event. Covers all participation-granting and participation-restricting categories including registration, amateur/professional status, visa and work permit, age eligibility, and all disciplinary actions. [ENUM-REF-CANDIDATE: registration|amateur_status|professional_status|visa_work_permit|age_eligibility|disciplinary_suspension|doping_suspension|conduct_violation|game_misconduct_ban|cba_disciplinary|transfer_clearance|reinstatement — promote to reference product]',
    `expiry_date` DATE COMMENT 'The date on which this eligibility status expires or the restriction is lifted. Null for indefinite suspensions or open-ended eligibility grants. Critical for automated reinstatement workflows.',
    `financial_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary fine levied against the athlete as part of the disciplinary action, expressed in the currency defined by penalty_currency_code. Zero or null for eligibility events with no financial penalty.',
    `game_day_eligible` BOOLEAN COMMENT 'Real-time flag indicating whether the athlete is eligible to participate in the next scheduled game or event as of the current date. Derived from effective_date, expiry_date, and eligibility_status for operational game-day roster verification.',
    `games_remaining` STRING COMMENT 'Number of games still to be served in a game-based suspension as of the last update. Decremented each time the athlete sits out a qualifying game. Null for day-based or indefinite suspensions.',
    `issuing_authority` STRING COMMENT 'Name of the specific authority, panel, or office that issued the eligibility determination or disciplinary decision (e.g., NFL Commissioner Office, WADA Independent Tribunal, FIFA Disciplinary Committee, CAS Panel).',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, or administrative notes related to this eligibility record. Used by league compliance officers and athlete management staff.',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the financial penalty amount (e.g., USD, EUR, GBP). Null when no financial penalty applies.. Valid values are `^[A-Z]{3}$`',
    `penalty_paid` BOOLEAN COMMENT 'Indicates whether the athlete has satisfied the financial penalty associated with this disciplinary eligibility event. True when payment is confirmed; False when outstanding. Null when no financial penalty applies.',
    `registration_date` DATE COMMENT 'Date on which the athlete was formally registered with the league or governing body under this eligibility record.',
    `registration_number` STRING COMMENT 'Official registration number assigned by the league or governing body confirming the athletes registration as a professional or amateur competitor. Required for roster submission and game-day eligibility verification.',
    `reinstatement_conditions` STRING COMMENT 'Free-text description of the specific conditions the athlete must satisfy to be reinstated to eligibility (e.g., completion of drug treatment program, payment of fine, community service hours, counselling). Null when no conditions are required.',
    `reinstatement_date` DATE COMMENT 'Actual date on which the athlete was formally reinstated to eligible status following completion of a suspension or satisfaction of reinstatement conditions. Null if not yet reinstated.',
    `restriction_scope` STRING COMMENT 'Defines the competitive scope of an eligibility restriction — whether the athlete is banned from all competitions globally, only league competitions, only international fixtures, a specific event, or is subject to a training ban.. Valid values are `all_competitions|league_only|international_only|specific_event|training_ban`',
    `sample_collection_date` DATE COMMENT 'Date on which the biological sample (urine, blood) was collected from the athlete as part of the anti-doping testing process. Establishes chain of custody for WADA adjudication. Null for non-doping eligibility events.',
    `transfer_clearance_status` STRING COMMENT 'Status of the international transfer certificate (ITC) or transfer clearance required for athletes moving between clubs or leagues across national associations. Applicable for FIFA-governed sports and international transfers.. Valid values are `not_required|pending|cleared|rejected|expired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this eligibility status record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Tracks changes to suspension length, appeal outcomes, reinstatement dates, and other mutable fields.',
    `visa_expiry_date` DATE COMMENT 'Expiry date of the athletes visa or work permit. Triggers compliance alerts when approaching expiry to prevent inadvertent ineligibility due to lapsed immigration documentation.',
    `visa_issuing_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the nation that issued the visa or work permit. Used for international transfer compliance and immigration tracking.. Valid values are `^[A-Z]{3}$`',
    `visa_permit_number` STRING COMMENT 'Official visa or work permit document number issued by the relevant immigration authority, applicable when eligibility_type is visa_work_permit. Required for international athlete transfers and cross-border competition clearance.',
    `whereabouts_compliant` BOOLEAN COMMENT 'Indicates whether the athlete is currently compliant with WADA whereabouts filing requirements under the Registered Testing Pool (RTP). False triggers a whereabouts failure flag that may lead to a doping violation.',
    `whereabouts_failure_count` STRING COMMENT 'Cumulative count of whereabouts filing failures or missed tests within the rolling 12-month window. Three failures within 12 months constitutes an anti-doping rule violation under WADA Code Article 2.4.',
    CONSTRAINT pk_eligibility_status PRIMARY KEY(`eligibility_status_id`)
) COMMENT 'Authoritative single source of truth for an athletes current and historical eligibility to compete, encompassing all factors that grant or restrict participation rights. Covers: amateur/professional status, league registration, visa and work permit status, age eligibility, and all disciplinary actions including PED suspensions, conduct violations, game misconduct bans, and CBA disciplinary procedures. Tracks eligibility type, governing body (FIFA, NFL, NBA, WADA, CAS), effective/expiry dates, restriction details, suspension type and length (games, days, indefinite), financial penalties, issuing authority, reinstatement conditions, appeal status and outcomes, and chain of custody to originating doping test or incident. Critical for CBA compliance, international transfer regulations, WADA anti-doping enforcement, broadcast rights clearances, and real-time game-day eligibility verification. Replaces any separate suspension tracking — all disciplinary restrictions are eligibility events.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` (
    `nil_agreement_id` BIGINT COMMENT 'Unique system-generated identifier for the NIL or professional endorsement agreement record. Primary key for the nil_agreement data product.',
    `agent_id` BIGINT COMMENT 'Reference to the licensed sports agent or representative who negotiated or manages this agreement on behalf of the athlete.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who is the subject of this NIL or endorsement agreement.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who is the subject of this NIL or endorsement agreement.',
    `brand_partner_sponsor_id` BIGINT COMMENT 'Reference to the brand, company, or sponsor entity entering into the NIL or endorsement agreement with the athlete.',
    `cba_agreement_id` BIGINT COMMENT 'Foreign key linking to league.cba_agreement. Business justification: NIL rights provisions, disclosure requirements, and league-sponsor conflict rules are defined in the CBA. Linking nil_agreement to the governing CBA enables automated compliance audits, conflict detec',
    `contract_template_id` BIGINT COMMENT 'Foreign key linking to legal.contract_template. Business justification: NIL agreements are drafted from league-approved legal contract templates. Legal compliance requires tracking which template version was used for each NIL deal to ensure CBA compliance, audit readiness',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to legal.corporate_entity. Business justification: NIL agreements are executed with corporate entities (brand holding companies, sponsor subsidiaries). The nil_agreement has sponsor_id (FK to sponsorship domain) but the legal contracting counterparty ',
    `deal_id` BIGINT COMMENT 'Foreign key linking to sponsorship.deal. Business justification: NIL compliance and conflict management: NIL agreements must be cross-referenced against the sponsors master league/team deal to enforce league_sponsor_conflict_flag and category exclusivity. Complian',
    `facility_id` BIGINT COMMENT 'Foreign key linking to venue.facility. Business justification: NIL agreements with in_venue_usage_rights require tracking which specific facilities are covered for athlete signage, display, and activation rights. Venue operations and commercial rights teams must ',
    `governing_body_id` BIGINT COMMENT 'Foreign key linking to compliance.governing_body. Business justification: NIL agreements store governing_body_code as denormalized text. The governing body (NCAA, league, federation) that regulates the NIL agreement is authoritative in compliance.governing_body. Compliance ',
    `ip_portfolio_id` BIGINT COMMENT 'Foreign key linking to legal.ip_portfolio. Business justification: NIL agreements grant commercial usage rights over athlete IP (name, image, likeness) registered in the IP portfolio. Legal teams must link NIL deals to the specific IP portfolio entry to enforce usage',
    `nda_id` BIGINT COMMENT 'Foreign key linking to legal.nda. Business justification: NIL agreements require NDAs to protect confidential deal terms, compensation structures, and brand strategies shared between athletes and sponsors. Legal teams execute and track NDAs as prerequisites ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: NIL agreements must be reviewed against applicable compliance policies (CBA provisions, league sponsor conflict rules, NCAA regulations). Compliance teams perform policy-based NIL agreement reviews; t',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: NIL agreement revenue must be classified into a revenue stream for financial reporting and ASC 606 revenue recognition. Finance teams categorize NIL deals by revenue stream (endorsement, licensing, ap',
    `sku_catalog_id` BIGINT COMMENT 'Foreign key linking to the specific merchandise SKU authorized under this NIL agreement',
    `sponsor_id` BIGINT COMMENT 'Reference to the brand, company, or sponsor entity entering into the NIL or endorsement agreement with the athlete.',
    `tax_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to finance.tax_jurisdiction. Business justification: NIL income is taxable; tax_jurisdiction has nil_income_taxable_flag explicitly. Finance and tax teams must track the governing tax jurisdiction for each NIL agreement for withholding, 1099 reporting, ',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the agreement, used in correspondence with athletes, agents, brand partners, and compliance bodies. Follows the format NIL-{YEAR}-{SEQUENCE}.. Valid values are `^NIL-[0-9]{4}-[0-9]{6}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the NIL or endorsement agreement. Drives compliance reporting, broadcast rights clearance, and commercial valuation workflows.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `annual_value_amount` DECIMAL(18,2) COMMENT 'Annualized value of the agreement used for ARR (Annual Recurring Revenue) reporting, athlete commercial valuation, and financial planning in Workday Adaptive Planning.',
    `appearance_count` STRING COMMENT 'Number of personal appearances (events, activations, media days) the athlete is contractually obligated to make for the brand partner over the agreement term.',
    `approval_status` STRING COMMENT 'Current approval state of this specific SKU under the NIL agreement. Tracks the per-SKU approval workflow independently of the master agreement status — a single agreement may have some SKUs approved and others pending review.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement contains an automatic renewal clause that extends the term unless either party provides notice of non-renewal before the expiration date.',
    `broadcast_usage_rights` BOOLEAN COMMENT 'Indicates whether the brand partner has rights to use the athletes name, image, or likeness in broadcast advertising (TV, OTT, RSN). Critical for broadcast rights clearance workflows in Dalet Galaxy.',
    `cba_compliance_status` STRING COMMENT 'Status of the agreements compliance with the applicable CBA (Collective Bargaining Agreement) endorsement and sponsor conflict provisions. Not applicable for amateur/collegiate NIL deals.. Valid values are `not_applicable|compliant|under_review|non_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NIL agreement record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this agreement (e.g., USD, EUR, GBP). Supports multi-market global operations.. Valid values are `^[A-Z]{3}$`',
    `deal_category` STRING COMMENT 'Classification of the agreement type. NIL-amateur and NIL-collegiate are subject to NCAA/conference NIL policies; professional endorsement and licensing deals are governed by CBA and league sponsor conflict rules.. Valid values are `nil_amateur|nil_collegiate|professional_endorsement|appearance|social_media|licensing`',
    `deal_value_amount` DECIMAL(18,2) COMMENT 'Total gross contractual value of the NIL or endorsement agreement in the agreed currency. Represents the full deal value over the contract term before any performance incentives.',
    `digital_usage_rights` BOOLEAN COMMENT 'Indicates whether the brand partner has rights to use the athletes name, image, or likeness in digital advertising (web, OTT streaming, DTC platforms, IPTV).',
    `disclosure_date` DATE COMMENT 'The date on which the NIL agreement was formally disclosed to the applicable governing body (NCAA, conference office, or league). Required for compliance reporting.',
    `disclosure_status` STRING COMMENT 'Compliance disclosure status of the agreement with applicable governing bodies (NCAA, conference, league). Tracks whether the required disclosure has been filed, is pending, or is overdue.. Valid values are `not_required|pending|disclosed|overdue`',
    `dispute_resolution_mechanism` STRING COMMENT 'Contractually agreed mechanism for resolving disputes arising from the agreement. CAS arbitration applies to international sports disputes.. Valid values are `arbitration|litigation|mediation|cas_arbitration`',
    `effective_date` DATE COMMENT 'The date on which the NIL or endorsement agreement becomes legally binding and commercially active.',
    `exclusivity_scope` STRING COMMENT 'Defines the exclusivity terms of the agreement. Category-exclusive prevents the athlete from endorsing competing brands in the same product category. League-exclusive restricts endorsements conflicting with official league sponsors.. Valid values are `none|category_exclusive|league_exclusive|global_exclusive|regional_exclusive`',
    `exclusivity_territory` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes defining the geographic territory in which exclusivity applies. Supports global multi-market rights management.. Valid values are `^[A-Z]{3}(,[A-Z]{3})*$`',
    `execution_date` DATE COMMENT 'The date on which all parties formally signed and executed the agreement. May differ from the effective date if the agreement is backdated or post-dated.',
    `expiration_date` DATE COMMENT 'The date on which the NIL or endorsement agreement expires. Null for open-ended agreements. Used for renewal tracking and compliance monitoring.',
    `governing_law_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern the agreement. Determines applicable privacy regulations (GDPR, CCPA) and dispute resolution forums.. Valid values are `^[A-Z]{3}$`',
    `in_venue_usage_rights` BOOLEAN COMMENT 'Indicates whether the brand partner has rights to use the athletes name, image, or likeness in venue signage, jumbotron displays, or in-venue activations.',
    `incentive_value_amount` DECIMAL(18,2) COMMENT 'Total potential value of performance-based incentives included in the agreement (e.g., bonuses tied to statistical milestones, award wins, or social media engagement thresholds).',
    `internal_notes` STRING COMMENT 'Free-text field for internal legal, compliance, or commercial team notes regarding the agreement. Not shared externally. Supports deal management and audit workflows.',
    `league_sponsor_conflict_flag` BOOLEAN COMMENT 'Indicates whether this agreement has been flagged as potentially conflicting with an official league or team sponsor in the same product category. Triggers a sponsorship conflict-of-interest review.',
    `merchandise_usage_rights` BOOLEAN COMMENT 'Indicates whether the brand partner has rights to use the athletes name, image, or likeness on licensed merchandise and retail products (SKU-level). Relevant for Shopify Plus merchandise operations.',
    `morality_clause_included` BOOLEAN COMMENT 'Indicates whether the agreement contains a morality clause allowing the brand partner to terminate the deal if the athlete engages in conduct deemed harmful to the brands reputation.',
    `morality_clause_terms` STRING COMMENT 'Textual description of the specific morality clause terms and triggering conditions included in the agreement. Populated only when morality_clause_included is True.',
    `payment_structure` STRING COMMENT 'Defines how the deal value is paid to the athlete: as a single lump sum, periodic installments, milestone-triggered payments, royalty-based (percentage of sales), or a hybrid combination.. Valid values are `lump_sum|installment|milestone|royalty|hybrid`',
    `product_category` STRING COMMENT 'The product or service category of the brand partners offering covered by this agreement (e.g., athletic footwear, sports nutrition, financial services, automotive, apparel). Used for league sponsor conflict-of-interest checks. [ENUM-REF-CANDIDATE: athletic_footwear|apparel|sports_nutrition|financial_services|automotive|technology|beverage|healthcare|gaming|media — promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days prior to expiration by which either party must provide written notice of non-renewal. Relevant when auto_renewal_flag is True.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Royalty percentage rate applied to brand partner net sales for royalty-based or hybrid payment structures. Expressed as a decimal (e.g., 0.0500 = 5%). Null for non-royalty payment structures.',
    `royalty_rate_override` DECIMAL(18,2) COMMENT 'Per-SKU royalty rate expressed as a decimal fraction that overrides the master agreements deal value terms for this specific SKU. Enables differentiated royalty structures within a single NIL deal (e.g., higher rate for autographed memorabilia vs. standard apparel).',
    `social_media_post_count` STRING COMMENT 'Number of sponsored social media posts the athlete is contractually obligated to publish for the brand partner over the agreement term. Relevant for NCAA NIL social media deal tracking.',
    `social_media_usage_rights` BOOLEAN COMMENT 'Indicates whether the brand partner has rights to use the athletes name, image, or likeness in social media campaigns. Relevant for NCAA NIL social media deal compliance.',
    `termination_date` DATE COMMENT 'The date on which the agreement was early-terminated by either party. Null if the agreement ran to its natural expiration. Distinct from expiration_date which represents the scheduled end.',
    `termination_reason` STRING COMMENT 'Reason code for early termination of the agreement. Populated only when termination_date is set. Supports compliance reporting and legal dispute tracking. [ENUM-REF-CANDIDATE: mutual_agreement|morality_clause|breach_of_contract|athlete_retirement|league_suspension|brand_withdrawal|regulatory_violation — 7 candidates stripped; promote to reference product]',
    `territory_restriction` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes defining the geographic scope for this specific SKU authorization. May be narrower than the master agreements exclusivity_territory — for example, a jersey SKU may only be authorized for US and CAN markets even if the master deal covers global rights.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this NIL agreement record was last modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver Layer.',
    `usage_rights_scope` STRING COMMENT 'Defines which specific usage rights (broadcast, digital, social, in-venue, merchandise) apply to this SKU under this NIL agreement. May be a subset of the master agreements usage rights flags, allowing per-SKU restriction of rights.',
    `wada_compliance_flag` BOOLEAN COMMENT 'Indicates whether the brand partners product category has been reviewed for WADA compliance (e.g., sports nutrition or supplement brands must not promote PED-adjacent products). Relevant for anti-doping regulatory adherence.',
    CONSTRAINT pk_nil_agreement PRIMARY KEY(`nil_agreement_id`)
) COMMENT 'Unified commercial agreement record for all athlete brand partnerships, endorsements, and Name/Image/Likeness (NIL) deals. Covers both amateur/collegiate NIL agreements (subject to NCAA/conference NIL policies) and professional endorsement contracts (subject to CBA and league sponsor conflict rules). Tracks deal category (NIL-amateur, NIL-collegiate, professional endorsement, appearance, social media, licensing), brand partner, product category, deal value, contract duration, exclusivity scope, usage rights (broadcast, digital, social, in-venue), performance incentives, morality clause terms, disclosure status, and compliance with applicable regulations. Supports athlete commercial valuation, sponsorship conflict-of-interest checks, NIL compliance reporting, and broadcast rights clearances for athlete-branded content.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` (
    `agent_relationship_id` BIGINT COMMENT 'Unique surrogate identifier for the agent-athlete relationship record in the lakehouse silver layer. Primary key for this association entity.',
    `agency_id` BIGINT COMMENT 'Reference to the sports agency or firm through which the agent operates. An agent may be affiliated with a larger agency entity.',
    `agent_id` BIGINT COMMENT 'Reference to the certified agent who represents the athlete. Links to the agent master record.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who is represented under this agent relationship. Links to the athlete master record.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who is represented under this agent relationship. Links to the athlete master record.',
    `governing_body_id` BIGINT COMMENT 'Foreign key linking to compliance.governing_body. Business justification: Agent relationships store certifying_association as denormalized text. The governing body that certifies and regulates agents (NFLPA, FIFA, etc.) is authoritative in compliance.governing_body. Agent c',
    `league_id` BIGINT COMMENT 'Foreign key linking to league.league. Business justification: Agent certifications, filing statuses, and approval dates are league-specific (league_filing_status, league_filing_date, league_approval_date on agent_relationship). A league FK enables league-level a',
    `matter_id` BIGINT COMMENT 'Foreign key linking to legal.legal_matter. Business justification: Agent disputes (unauthorized representation, commission conflicts, certification violations) generate legal matters. agent_relationship tracks compliance_review_outcome but has no FK to legal_matter. ',
    `nda_id` BIGINT COMMENT 'Foreign key linking to legal.nda. Business justification: Agent representation agreements require NDAs covering athlete personal data, contract negotiation strategies, and salary information. The agent_relationship already tracks agreement_document_ref as a ',
    `agent_license_jurisdiction` STRING COMMENT 'The country or state/province jurisdiction in which the agent holds a valid sports agent license or registration, where required by law (e.g., US state athlete agent acts, EU member state regulations). Stored as ISO 3166-1 alpha-2 or alpha-3 country code.. Valid values are `^[A-Z]{2,3}$`',
    `agreement_document_ref` STRING COMMENT 'Reference identifier or URL pointing to the executed representation agreement document stored in the digital asset management (DAM) or document management system. Enables retrieval of the signed contract for compliance audits.',
    `certification_expiry_date` DATE COMMENT 'The date on which the agents players association certification expires and must be renewed. Used to trigger compliance alerts and prevent unauthorized representation activity.',
    `certification_number` STRING COMMENT 'Official certification or license number issued by the relevant players association (e.g., NFLPA, NBPA, MLBPA, NHLPA) confirming the agent is authorized to represent athletes in contract negotiations. Required for league compliance validation.',
    `commission_basis` STRING COMMENT 'Defines the income base upon which the agents commission rate is applied. Determines whether commission is calculated on gross salary, net salary, signing bonus, endorsement income, NIL (Name Image and Likeness) income, or all income streams.. Valid values are `gross_salary|net_salary|signing_bonus|endorsements|nil_income|all_income`',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'The contractually agreed commission rate (expressed as a decimal fraction, e.g., 0.0300 = 3%) that the agent earns on the athletes compensation under this representation agreement. Subject to CBA (Collective Bargaining Agreement) maximum commission caps per league.',
    `compliance_review_date` DATE COMMENT 'The date of the most recent compliance review of this agent-athlete relationship, verifying that the agents certification is current, commission rates comply with CBA caps, and no conflicts of interest exist.',
    `compliance_review_outcome` STRING COMMENT 'Result of the most recent compliance review of this agent-athlete relationship. Passed indicates all requirements met; failed indicates one or more violations identified; pending indicates review in progress; waived indicates review exempted by league authority.. Valid values are `passed|failed|pending|waived`',
    `conflict_of_interest_flag` BOOLEAN COMMENT 'Indicates whether a potential or confirmed conflict of interest has been identified for this agent-athlete relationship (e.g., agent also represents opposing team management, or represents multiple athletes competing for the same roster position). Triggers compliance review workflow.',
    `conflict_of_interest_notes` STRING COMMENT 'Free-text description of the nature of any identified conflict of interest associated with this agent-athlete relationship. Populated only when conflict_of_interest_flag is True. Used by compliance and legal teams.',
    `contract_negotiation_authority` BOOLEAN COMMENT 'Indicates whether this agent is authorized to negotiate the athletes playing contract (salary, bonuses, incentives) with team management on the athletes behalf. Core authority granted under standard player representation agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this agent-athlete relationship record was first created in the system, in ISO 8601 format with timezone offset. Supports audit trail and data lineage requirements.',
    `crm_record_reference` STRING COMMENT 'The unique identifier of the corresponding agent-athlete relationship record in Salesforce CRM, used for system-of-record traceability and bi-directional synchronization between the lakehouse and the CRM platform.',
    `effective_date` DATE COMMENT 'The date on which the agent-athlete representation relationship becomes legally binding and operative. Aligns with the signed representation agreement commencement date.',
    `endorsement_representation` BOOLEAN COMMENT 'Indicates whether this agent relationship includes authority to negotiate commercial endorsement deals on behalf of the athlete, separate from the athletes playing contract.',
    `is_primary_agent` BOOLEAN COMMENT 'Indicates whether this agent is the athletes primary (lead) representative when the athlete has multiple agents covering different representation scopes. Only one agent relationship per athlete should be flagged as primary at any given time.',
    `league_approval_date` DATE COMMENT 'The date on which the relevant league office or players association formally approved the agent-athlete representation agreement, authorizing the agent to act on the athletes behalf.',
    `league_filing_date` DATE COMMENT 'The date on which the agent-athlete representation agreement was formally filed with the relevant league office or players association for approval and registration.',
    `league_filing_status` STRING COMMENT 'Status of the agent relationship filing with the relevant league office or players association. Leagues require formal notification and approval of agent-athlete representation agreements before the agent may negotiate on the athletes behalf.. Valid values are `not_filed|filed|approved|rejected|under_review`',
    `legal_representation` BOOLEAN COMMENT 'Indicates whether this relationship includes legal representation authority (e.g., grievance filings, arbitration proceedings, disciplinary hearings). May require the agent to also be a licensed attorney depending on jurisdiction.',
    `nil_representation` BOOLEAN COMMENT 'Indicates whether this agent relationship includes authority to negotiate NIL (Name Image and Likeness) deals on behalf of the athlete. NIL representation may be scoped separately from contract negotiation authority.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special terms, or operational notes related to this agent-athlete representation relationship that are not captured in structured fields. Used by talent management and legal teams.',
    `power_of_attorney` BOOLEAN COMMENT 'Indicates whether the athlete has granted the agent a formal power of attorney, authorizing the agent to execute contracts and legal documents on the athletes behalf without requiring the athletes direct signature.',
    `power_of_attorney_scope` STRING COMMENT 'Describes the specific scope and limitations of the power of attorney granted to the agent, if applicable. May specify which transaction types, dollar thresholds, or legal actions are covered. Null if power_of_attorney is False. [ENUM-REF-CANDIDATE: full|contract_only|endorsement_only|financial_only|limited — promote to reference product]',
    `primary_contact_email` STRING COMMENT 'Primary email address used to contact the agent for contract negotiation communications, league notifications, and official correspondence related to this athlete representation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for reaching the agent regarding this athlete representation relationship. Stored in E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `relationship_number` STRING COMMENT 'Externally-known business identifier for this agent-athlete relationship, used in correspondence, contract filings, and league submissions. Format: AR-YYYYNNNN.. Valid values are `^AR-[0-9]{8}$`',
    `relationship_status` STRING COMMENT 'Current lifecycle state of the agent-athlete representation relationship. Active indicates a current, binding representation agreement; pending indicates awaiting league certification approval; suspended indicates temporarily inactive due to compliance hold; terminated indicates ended by either party; expired indicates the agreement term lapsed without renewal.. Valid values are `active|pending|suspended|terminated|expired`',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days prior to the termination_date by which either party must provide written notice of intent not to renew the representation agreement. Null if renewal_option is False.',
    `renewal_option` BOOLEAN COMMENT 'Indicates whether the representation agreement contains an automatic renewal clause or a mutual option to extend the relationship beyond the initial term without executing a new agreement.',
    `representation_agreement_date` DATE COMMENT 'The date on which the formal representation agreement between the athlete and agent was executed (signed by both parties). May differ from the effective_date if there is a delayed commencement clause.',
    `representation_scope` STRING COMMENT 'Defines the scope of authority granted to the agent under this relationship. Typical values include contract_negotiation, endorsements, nil_agreements, legal, media, financial_advisory, full_service. [ENUM-REF-CANDIDATE: contract_negotiation|endorsements|nil_agreements|legal|media|financial_advisory|full_service — promote to reference product]',
    `sport_discipline` STRING COMMENT 'The specific sport or athletic discipline covered by this agent-athlete representation relationship (e.g., American Football, Basketball, Baseball, Ice Hockey, Soccer, Tennis, Mixed Martial Arts). Supports multi-sport athlete scenarios. [ENUM-REF-CANDIDATE: american_football|basketball|baseball|ice_hockey|soccer|tennis|mma|golf|track_and_field|other — promote to reference product]',
    `termination_date` DATE COMMENT 'The date on which the agent-athlete representation relationship was formally terminated or is scheduled to expire. Null if the relationship is currently active or open-ended.',
    `termination_reason` STRING COMMENT 'Reason code explaining why the agent-athlete representation relationship was terminated. Used for compliance reporting and league audit trails. Null if relationship is still active. [ENUM-REF-CANDIDATE: athlete_request|agent_request|mutual_agreement|certification_revoked|cba_violation|contract_expiry|other — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this agent-athlete relationship record was most recently modified, in ISO 8601 format with timezone offset. Used for change tracking, incremental data loads, and audit compliance.',
    CONSTRAINT pk_agent_relationship PRIMARY KEY(`agent_relationship_id`)
) COMMENT 'Association record linking athletes to their certified agents, agencies, and legal representatives. Tracks agent name, agency name, agent certification number (NFLPA, NBPA, MLBPA certified), representation scope (contract negotiation, endorsements, NIL, legal), relationship start date, termination date, commission rate, and power of attorney status. Supports contract negotiation workflows, communication routing, and compliance with league agent certification requirements.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` (
    `suspension_record_id` BIGINT COMMENT 'Unique system-generated identifier for each disciplinary suspension or ban record. Primary key for the suspension_record data product.',
    `agent_id` BIGINT COMMENT 'Reference to the athletes registered agent or representative who is managing the disciplinary case and any appeal proceedings on behalf of the athlete.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who is subject to this disciplinary suspension or ban.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who is subject to this disciplinary suspension or ban.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Suspension records carry salary_withheld_amount that must be posted to a cost center for financial accounting. Finance teams allocate withheld salary to the relevant franchise cost center for budget r',
    `doping_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.doping_violation. Business justification: Doping-triggered suspensions must reference the underlying compliance.doping_violation for CAS appeals, results disqualification processing, and WADA reporting. Legal and compliance teams require this',
    `franchise_id` BIGINT COMMENT 'Reference to the team or franchise the athlete was rostered on at the time the suspension was issued.',
    `governing_body_id` BIGINT COMMENT 'Foreign key linking to compliance.governing_body. Business justification: Suspension records track issuing_authority as plain text. Linking to compliance.governing_body enables regulatory reporting, appeal routing, and jurisdiction-specific enforcement tracking — all named ',
    `league_id` BIGINT COMMENT 'Reference to the league or governing body under whose jurisdiction this suspension was issued (e.g., NFL, NBA, MLB, NHL, MLS, FIFA).',
    `season_id` BIGINT COMMENT 'Foreign key linking to league.season. Business justification: Suspension games remaining, salary withholding calculations, and competitive integrity reports are all season-scoped. Season FK enables CBA-mandated suspension tracking, cap impact calculations for wi',
    `litigation_case_id` BIGINT COMMENT 'Foreign key linking to legal.litigation_case. Business justification: Athlete suspensions are routinely challenged via arbitration or litigation (union grievances, CBA appeals). Legal teams must link the suspension record to the active litigation case to track exposure,',
    `matter_id` BIGINT COMMENT 'Foreign key linking to legal.legal_matter. Business justification: Suspension proceedings generate legal matters for union grievances, arbitration filings, and appeal management. The suspension_record has union_grievance_number as a denormalized string but no FK to l',
    `sanction_id` BIGINT COMMENT 'Foreign key linking to compliance.sanction. Business justification: Athlete suspension records are operationally triggered by compliance sanctions issued by governing bodies (WADA, league). Compliance and roster management teams must trace each suspension_record to th',
    `team_franchise_id` BIGINT COMMENT 'Reference to the team or franchise the athlete was rostered on at the time the suspension was issued.',
    `announcement_date` DATE COMMENT 'Date on which the suspension was publicly announced by the league or issuing authority. Null if the suspension has not been publicly announced or is confidential.',
    `appeal_body` STRING COMMENT 'The body or tribunal that is hearing or heard the appeal (e.g., CAS (Court of Arbitration for Sport), WADA, League Appeals Panel, Arbitration, Federal Court). Null or None if no appeal was filed.. Valid values are `cas|wada|league_appeals_panel|arbitration|federal_court|none`',
    `appeal_filed_date` DATE COMMENT 'Date on which the athlete or their representative formally filed an appeal against the suspension ruling. Null if no appeal was filed.',
    `appeal_resolution_date` DATE COMMENT 'Date on which the appeal was formally resolved by the appellate body (e.g., CAS, league appeals panel). Null if the appeal is still pending or no appeal was filed.',
    `appeal_status` STRING COMMENT 'Current status of any appeal filed by the athlete or their representative against the suspension ruling. Not Appealed means no appeal was filed; Appeal Filed means an appeal has been submitted; Appeal Pending means the appeal is under review; Appeal Upheld means the suspension was overturned or reduced; Appeal Denied means the original ruling was confirmed; Appeal Withdrawn means the athlete withdrew the appeal.. Valid values are `not_appealed|appeal_filed|appeal_pending|appeal_upheld|appeal_denied|appeal_withdrawn`',
    `broadcast_restriction_flag` BOOLEAN COMMENT 'Indicates whether the suspension includes restrictions on the athletes appearance in broadcast content, media, or promotional materials during the suspension period. Relevant for broadcast rights compliance and content production scheduling.',
    `case_reference_number` STRING COMMENT 'Externally-known disciplinary case number or docket identifier assigned by the issuing authority (e.g., league office, WADA, CAS). Used for cross-referencing with legal and compliance systems.',
    `competition_scope` STRING COMMENT 'Defines the scope of competitions from which the athlete is suspended. Some suspensions apply to all competitions (including international), while others are limited to specific competition types (e.g., league games only, international fixtures only).. Valid values are `all_competitions|league_only|international_only|domestic_cup|preseason_excluded`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this suspension record was first created in the system. Aligns with the TRANSACTION_HEADER RECORD_AUDIT_CREATED category. Used for data lineage and audit trail.',
    `effective_end_date` DATE COMMENT 'The date on which the suspension is scheduled to end and the athlete becomes eligible for reinstatement. Null for indefinite suspensions. Aligns with the TRANSACTION_HEADER EFFECTIVE_UNTIL category.',
    `effective_start_date` DATE COMMENT 'The date on which the suspension officially begins and the athlete is prohibited from participating in league activities. Aligns with the TRANSACTION_HEADER EFFECTIVE_FROM category.',
    `financial_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary fine or financial penalty imposed on the athlete as part of the disciplinary action, expressed in the applicable currency. Null if no financial penalty was assessed. Tracked for compliance and payroll deduction purposes.',
    `hearing_date` DATE COMMENT 'Date on which the formal disciplinary hearing was conducted before the suspension was issued. Null if no formal hearing was held (e.g., automatic suspensions for certain violations).',
    `hearing_officer` STRING COMMENT 'Name or title of the independent arbitrator, hearing officer, or disciplinary panel chair who presided over the disciplinary hearing. Null if no formal hearing was held.',
    `incident_description` STRING COMMENT 'Narrative description of the incident or conduct that led to the suspension. Contains factual summary of the violation as documented by the issuing authority. Classified confidential due to sensitive legal and disciplinary nature.',
    `is_indefinite` BOOLEAN COMMENT 'Indicates whether the suspension is indefinite with no fixed end date. True when the athlete is banned until further review or reinstatement conditions are met. When True, effective_end_date will be null.',
    `is_lifetime_ban` BOOLEAN COMMENT 'Indicates whether the suspension constitutes a permanent lifetime ban from the sport or league. Typically applied for second PED (Performance Enhancing Drug) violations under WADA or severe integrity violations such as match fixing.',
    `is_public_announcement` BOOLEAN COMMENT 'Indicates whether the suspension has been publicly announced by the league or issuing authority. Some suspensions (particularly early-stage PED violations) may be kept confidential until the appeals process is exhausted.',
    `is_suspension_stayed` BOOLEAN COMMENT 'Indicates whether the suspension has been temporarily stayed (paused) pending the outcome of an appeal. When True, the athlete may continue to participate while the appeal is resolved.',
    `issued_date` DATE COMMENT 'The date on which the suspension decision was formally issued or announced by the issuing authority. Represents the principal real-world business event timestamp (BUSINESS_EVENT_TIMESTAMP category).',
    `issuing_authority` STRING COMMENT 'The body or authority that issued the suspension (e.g., League Office, WADA, CAS (Court of Arbitration for Sport), Team, Referee Committee, Integrity Unit, Arbitration Panel). Determines the legal and procedural framework governing the suspension. [ENUM-REF-CANDIDATE: league_office|wada|cas|team|referee_committee|integrity_unit|arbitration_panel — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this suspension record was most recently modified. Aligns with the TRANSACTION_HEADER RECORD_AUDIT_UPDATED category. Tracks changes to appeal status, reinstatement, or penalty modifications.',
    `nil_agreement_impact` STRING COMMENT 'Status of the athletes NIL (Name, Image, and Likeness) agreements during the suspension period. Indicates whether NIL deals are suspended, terminated by sponsors, unaffected, or under review. Critical for commercial and sponsorship compliance tracking.. Valid values are `suspended|terminated|unaffected|under_review`',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the financial penalty amount (e.g., USD, EUR, GBP). Required when financial_penalty_amount is populated.. Valid values are `^[A-Z]{3}$`',
    `prior_violation_count` STRING COMMENT 'Number of prior disciplinary violations of the same type on the athletes record at the time this suspension was issued. Used to determine escalating penalty tiers under WADA and league policies (e.g., first offense vs. second offense).',
    `prohibited_substance_code` STRING COMMENT 'WADA-assigned code or name of the prohibited substance detected in the anti-doping violation (e.g., S1.1 — Testosterone, S6.A — Stimulants). Null for non-PED (Performance Enhancing Drug) suspensions. Classified confidential due to sensitive health-adjacent nature.',
    `reinstatement_conditions` STRING COMMENT 'Narrative description of any conditions the athlete must satisfy before being reinstated to active roster eligibility (e.g., completion of a treatment program, payment of fines, passing a drug test, counseling completion). Null if no conditions beyond serving the suspension period apply.',
    `reinstatement_date` DATE COMMENT 'The actual date on which the athlete was formally reinstated to active eligibility following completion of the suspension and any required reinstatement conditions. Null if the athlete has not yet been reinstated.',
    `salary_withheld_amount` DECIMAL(18,2) COMMENT 'Total salary amount withheld from the athlete during the suspension period as a consequence of the disciplinary action, expressed in the applicable currency. Distinct from financial_penalty_amount which is a separate fine. Tracked for payroll and CBA compliance.',
    `sample_collection_date` DATE COMMENT 'Date on which the biological sample (urine, blood) was collected for anti-doping testing that led to the adverse analytical finding. Null for non-PED suspensions. Classified confidential due to health-adjacent nature.',
    `source_system_reference` STRING COMMENT 'Identifier or reference code from the originating operational system of record where this suspension was first captured (e.g., SAP SuccessFactors case ID, Salesforce CRM case number). Enables traceability back to the source system for reconciliation.',
    `suspension_length_days` STRING COMMENT 'Number of calendar days the athlete is suspended, as specified in the suspension ruling. Null if the suspension is measured in games or is indefinite. Common in WADA anti-doping cases and FIFA disciplinary proceedings.',
    `suspension_length_games` STRING COMMENT 'Number of games the athlete is suspended from participating in, as specified in the suspension ruling. Null if the suspension is measured in days or is indefinite. Used for game-based suspensions common in NFL, NBA, MLB, NHL.',
    `suspension_status` STRING COMMENT 'Current lifecycle state of the suspension record. Active means the athlete is currently serving the suspension; Served means the suspension period has been completed; Appealed means the athlete has filed an appeal and the suspension may be stayed; Overturned means the suspension was reversed on appeal; Reduced means the original penalty was reduced; Pending means the suspension has been issued but not yet commenced.. Valid values are `active|served|appealed|overturned|reduced|pending`',
    `suspension_type` STRING COMMENT 'Classification of the disciplinary action by the nature of the violation. PED (Performance Enhancing Drug) violations are governed by WADA; conduct violations relate to personal conduct policies; game misconduct covers in-game rule infractions; league discipline covers CBA-governed actions; match fixing and financial breach are integrity-related. [ENUM-REF-CANDIDATE: ped_violation|conduct_violation|game_misconduct|league_discipline|match_fixing|financial_breach|eligibility_violation|anti-doping — promote to reference product]. Valid values are `ped_violation|conduct_violation|game_misconduct|league_discipline|match_fixing|financial_breach`',
    `testing_authority` STRING COMMENT 'Name of the anti-doping organization (ADO) or testing authority that conducted the drug test resulting in the violation (e.g., USADA, UKAD, WADA, NADO). Null for non-PED suspensions.',
    `union_grievance_number` STRING COMMENT 'The formal grievance or arbitration case number filed by the players union (e.g., NFLPA, NBPA, MLBPA) on behalf of the athlete under the CBA (Collective Bargaining Agreement) grievance procedures. Null if no union grievance was filed.',
    `violation_category` STRING COMMENT 'Specific sub-category or rule code of the violation that triggered the suspension (e.g., Prohibited Substance — S1 Anabolic Agents, Domestic Violence, Gambling, Unsportsmanlike Conduct). Provides granular classification beyond suspension_type for compliance reporting. [ENUM-REF-CANDIDATE: promote to reference product given large enumeration across leagues]',
    CONSTRAINT pk_suspension_record PRIMARY KEY(`suspension_record_id`)
) COMMENT 'Disciplinary suspension and ban records for athletes resulting from rule violations, anti-doping infractions, conduct violations, or CBA disciplinary procedures. Tracks suspension type (PED, conduct, game misconduct, league discipline), issuing authority, suspension length (games, days, indefinite), effective start and end dates, appeal status, reinstatement conditions, and financial penalties. Distinct from injury-related roster designations — suspensions are disciplinary actions with legal and compliance implications.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` (
    `combine_result_id` BIGINT COMMENT 'Unique surrogate identifier for each combine evaluation result record in the athlete domain. Primary key for the combine_result data product.',
    `asset_id` BIGINT COMMENT 'Identifier for the video recording session in SportsCode/Hudl capturing the prospects combine drills and measurements. Enables retrieval of drill footage for review by scouts, coaches, and front office personnel.',
    `doping_test_id` BIGINT COMMENT 'Foreign key linking to compliance.doping_test. Business justification: Pre-draft combine drug testing results must be traceable to the authoritative compliance.doping_test record. combine_result stores drug_test_status as denormalized text. Role prefix combine_ disting',
    `combine_event_id` BIGINT COMMENT 'Reference to the combine event (e.g., NFL Scouting Combine, NBA Draft Combine, MLB Draft Combine) at which this evaluation was conducted.',
    `draft_id` BIGINT COMMENT 'Foreign key linking to league.draft. Business justification: Combine results are produced specifically for a draft class and directly inform draft board rankings, pick valuations, and salary slot assignments. Linking to league.draft enables draft-day analytics,',
    `employee_id` BIGINT COMMENT 'Reference to the scout or evaluator who conducted or oversaw this combine evaluation session.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to venue.facility. Business justification: NFL/NBA combines and pro days are hosted at specific facilities. combine_result has a denormalized combine_event_location text field; a proper facility_id FK normalizes this for venue booking, capacit',
    `fixture_id` BIGINT COMMENT 'Reference to the combine event (e.g., NFL Scouting Combine, NBA Draft Combine, MLB Draft Combine) at which this evaluation was conducted.',
    `league_id` BIGINT COMMENT 'Foreign key linking to league.league. Business justification: Combine events are league-specific (NFL Combine, NBA Draft Combine). League FK enables league-level combine analytics, eligibility rule application, and prospect pool management scoped to the correct ',
    `prospect_id` BIGINT COMMENT 'Reference to the prospective athlete (draft-eligible player) who participated in the combine evaluation. Links to the athlete/prospect master record.',
    `scout_employee_id` BIGINT COMMENT 'Reference to the scout or evaluator who conducted or oversaw this combine evaluation session.',
    `arm_length_inches` DECIMAL(18,2) COMMENT 'Measured arm length of the prospect in inches from the shoulder to the tip of the middle finger. Used in NFL combine evaluations for offensive and defensive linemen, cornerbacks, and wide receivers.',
    `athleticism_grade` STRING COMMENT 'Qualitative athleticism grade assigned by the evaluating scout based on the overall combine performance. Provides a standardized categorical assessment used in draft board discussions and scouting reports.. Valid values are `elite|above_average|average|below_average|poor`',
    `bench_press_reps` STRING COMMENT 'Number of repetitions the prospect completed on the bench press at the standard combine weight (225 lbs for NFL). Measures upper-body strength and muscular endurance.',
    `body_fat_pct` DECIMAL(18,2) COMMENT 'Measured body fat percentage of the prospect at the time of the combine. Used in conditioning assessments and positional fit analysis. Classified as confidential due to sensitivity of health-related physical data.',
    `broad_jump_inches` DECIMAL(18,2) COMMENT 'Measured distance of the prospects standing broad jump in inches. Evaluates lower-body power and explosiveness in a horizontal plane, complementing the vertical jump measurement.',
    `composite_score` DECIMAL(18,2) COMMENT 'Weighted composite score (0–100 scale) aggregating all physical measurements and athletic test results for the prospect at this combine event. Calculated per league-specific weighting methodology in SportsCode/Hudl. Feeds draft board rankings and contract slot value calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this combine result record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `draft_year` STRING COMMENT 'The calendar year of the draft class for which this combine evaluation was conducted. Used to group prospects by draft cohort for comparative analysis and contract slot value calculations.',
    `drills_completed_flag` BOOLEAN COMMENT 'Indicates whether the prospect completed all required drills and measurements for their position group at this combine event. True = all required drills completed; False = one or more drills were skipped or not completed.',
    `eligibility_confirmed` BOOLEAN COMMENT 'Indicates whether the prospects draft eligibility has been formally confirmed by the league governing body at the time of this combine evaluation. True = eligibility confirmed; False = eligibility pending or under review.',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the combine result record. pending = scheduled but not yet conducted; in_progress = partially completed; completed = all measurements and drills finalized; voided = invalidated due to injury, protest, or administrative error; incomplete = prospect withdrew or was unable to finish.. Valid values are `pending|in_progress|completed|voided|incomplete`',
    `forty_yard_dash_sec` DECIMAL(18,2) COMMENT 'Electronically timed result of the prospects 40-yard dash in seconds. The primary speed and acceleration metric at the NFL Scouting Combine; also used in other league combines. Lower values indicate greater speed.',
    `hand_size_inches` DECIMAL(18,2) COMMENT 'Measured hand size of the prospect in inches (tip of thumb to tip of pinky with hand spread). Particularly relevant for NFL quarterbacks and NBA players; influences ball-handling and grip assessments.',
    `height_inches` DECIMAL(18,2) COMMENT 'Measured height of the prospect in inches at the time of the combine, recorded without shoes per standard combine protocol. Critical physical measurement used in position eligibility assessments and draft grade calculations.',
    `hudl_evaluation_reference` STRING COMMENT 'External identifier assigned by the SportsCode/Hudl performance analytics platform to this combine evaluation session. Used for cross-referencing video analysis, drill footage, and evaluation reports in the source system.',
    `injury_description` STRING COMMENT 'Brief description of any injury or physical limitation the prospect was managing at the time of the combine. Populated only when injury_flag is True. Classified as confidential due to health-related sensitivity.',
    `injury_flag` BOOLEAN COMMENT 'Indicates whether the prospect was performing under a known injury or physical limitation at the time of the combine evaluation. True = prospect had a documented injury or limitation; False = no known injury. Affects interpretation of test results and draft risk assessment.',
    `lane_agility_sec` DECIMAL(18,2) COMMENT 'Timed result of the lane agility drill in seconds, administered at the NBA Draft Combine. Measures lateral quickness, defensive footwork, and change-of-direction speed specific to basketball.',
    `max_vertical_jump_inches` DECIMAL(18,2) COMMENT 'Measured height of the prospects maximum vertical jump with a running approach (max vertical) in inches, as administered at the NBA Draft Combine. Distinct from the standing vertical jump.',
    `measurement_date` DATE COMMENT 'The calendar date on which the physical measurements and athletic tests were administered to the prospect at the combine event.',
    `position_drill_notes` STRING COMMENT 'Free-text evaluator notes describing the prospects performance in position-specific drills. Captures qualitative observations not reflected in numeric scores, such as technique, football IQ, and coachability.',
    `position_drill_score` DECIMAL(18,2) COMMENT 'Normalized score (0–100 scale) derived from position-specific drills administered during the combine (e.g., route running for WR, ball-handling for PG, fielding for SS). Scored by evaluators using SportsCode/Hudl platform rubrics.',
    `prospect_position` STRING COMMENT 'The primary playing position of the prospect at the time of the combine evaluation (e.g., QB, WR, PG, SF, SP, C, LW). Determines which position-specific drills are administered and which composite scoring weights apply. [ENUM-REF-CANDIDATE: QB|RB|WR|TE|OL|DL|LB|DB|K|P|PG|SG|SF|PF|C|SP|RP|C|1B|2B|3B|SS|OF|LW|RW|D|G — promote to reference product]',
    `scout_overall_grade` STRING COMMENT 'Overall draft round grade assigned by the evaluating scout based on the combine performance and physical profile. Represents the scouts projection of where the prospect should be selected in the draft. Feeds draft board rankings and contract slot value calculations.. Valid values are `1st_round|2nd_round|3rd_round|4th_round|undrafted|priority_fa`',
    `shuttle_drill_sec` DECIMAL(18,2) COMMENT 'Timed result of the 5-10-5 short shuttle drill (also known as the pro agility shuttle) in seconds. Measures lateral quickness, change of direction, and body control.',
    `sixty_yard_dash_sec` DECIMAL(18,2) COMMENT 'Timed result of the 60-yard dash in seconds, the primary speed metric used at the MLB Draft Combine for position players. Measures straight-line speed relevant to baserunning and outfield range.',
    `skipped_drills` STRING COMMENT 'Comma-separated list of drill names that the prospect did not complete during the combine (e.g., 40_yard_dash, bench_press). Populated only when drills_completed_flag is False. Used to flag incomplete records in draft analysis.',
    `standing_reach_inches` DECIMAL(18,2) COMMENT 'Measured standing reach of the prospect in inches (highest point reachable with one arm fully extended while standing flat-footed). Key measurement for NBA Draft Combine positional evaluation.',
    `ten_yard_split_sec` DECIMAL(18,2) COMMENT 'Electronically timed split at the 10-yard mark during the 40-yard dash, measured in seconds. Indicates initial burst and explosion off the line, a key metric for evaluating first-step quickness.',
    `three_cone_drill_sec` DECIMAL(18,2) COMMENT 'Timed result of the L-shaped 3-cone drill in seconds. Evaluates a prospects ability to change direction at speed, hip flexibility, and body control. Key metric for skill position players.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this combine result record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Tracks data currency and supports change detection in the Databricks Silver Layer pipeline.',
    `vertical_jump_inches` DECIMAL(18,2) COMMENT 'Measured height of the prospects vertical jump in inches (standing vertical leap). Assesses lower-body explosiveness and athleticism. Used across NFL, NBA, and MLB combines.',
    `video_session_reference` STRING COMMENT 'Identifier for the video recording session in SportsCode/Hudl capturing the prospects combine drills and measurements. Enables retrieval of drill footage for review by scouts, coaches, and front office personnel.',
    `weight_lbs` DECIMAL(18,2) COMMENT 'Measured body weight of the prospect in pounds at the time of the combine. Used in position fit analysis, injury risk modeling, and contract slot value calculations.',
    `wingspan_inches` DECIMAL(18,2) COMMENT 'Measured wingspan (fingertip to fingertip with arms fully extended) of the prospect in inches. Key physical attribute for basketball and football positional evaluation, particularly for defensive backs, wide receivers, and forwards.',
    CONSTRAINT pk_combine_result PRIMARY KEY(`combine_result_id`)
) COMMENT 'Pre-draft combine and scouting evaluation results for prospective athletes. Captures combine event (NFL Scouting Combine, NBA Draft Combine, MLB Draft), measurement date, physical measurements (height, weight, wingspan, hand size), athletic test results (40-yard dash, vertical jump, bench press reps, shuttle drill, 3-cone drill, 60-yard dash, lane agility), position-specific drills, and composite score. Sourced from SportsCode/Hudl evaluation platform. Feeds draft selection decisions and contract slot value calculations.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` (
    `scouting_report_id` BIGINT COMMENT 'Unique surrogate identifier for the scouting report record in the athlete domain Silver layer. Primary key for this data product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Draft evaluation workflow: scouts attach video assets to scouting reports for draft review boards and front-office decisions. scouting_report.video_clip_reference is a denormalized string reference to',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the prospective athlete (prospect) being evaluated in this scouting report. Links to the athlete master record.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the prospective athlete (prospect) being evaluated in this scouting report. Links to the athlete master record.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to broadcast.media_asset. Business justification: Scouting evaluations are based on broadcast game film and combine footage stored as broadcast media assets. The video_clip_reference field is a denormalized text pointer to this asset. Proper FK enabl',
    `combine_result_id` BIGINT COMMENT 'Foreign key linking to athlete.combine_result. Business justification: A scouting report is typically authored in conjunction with combine evaluation results. The scouting_report table currently duplicates all combine measurables (forty_yard_dash_seconds, vertical_jump_i',
    `draft_id` BIGINT COMMENT 'Foreign key linking to league.draft. Business justification: Scouting reports are produced for specific draft classes and directly drive draft board management, pick strategy, and draft_recommendation decisions. Linking to league.draft enables draft-class-level',
    `draft_pick_id` BIGINT COMMENT 'Foreign key linking to the draft pick being evaluated',
    `employee_id` BIGINT COMMENT 'Reference to the scout or evaluator who authored this report. Links to the workforce/staff master record.',
    `evaluator_employee_id` BIGINT COMMENT 'Reference to the scout or evaluator who authored this report. Links to the workforce/staff master record.',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Scouting reports are produced by franchise scouts for franchise-specific draft boards and roster decisions. Franchise FK enables franchise-level scouting analytics, draft pick strategy reports, and co',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to sponsorship.prospect. Business justification: Pre-draft NIL pipeline process: sponsorship business development teams use scouting evaluations (OVR grade, projection tier, draft recommendation) to assess NIL commercial potential of prospects befor',
    `approved_by` STRING COMMENT 'Name or identifier of the senior scout, director of player personnel, or general manager who approved this scouting report for inclusion in the official draft board. Required for reports with approved status.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this scouting report was formally approved and promoted to the official draft board. Lifecycle event timestamp supporting audit trail and draft governance compliance.',
    `character_grade` STRING COMMENT 'Scouts letter-grade assessment of the prospects character, coachability, work ethic, and off-field conduct. Confidential evaluation used in draft risk management and CBA compliance screening. Influences draft recommendation and contract structure.. Valid values are `A|B|C|D|F`',
    `combine_event_location` STRING COMMENT 'City and venue where the combine or pro day event was held (e.g., Indianapolis, IN - Lucas Oil Stadium for NFL Combine). Used for event logistics and historical benchmarking.',
    `combine_event_name` STRING COMMENT 'Name of the official combine or evaluation event at which measurables were recorded (e.g., NFL Scouting Combine, NBA Draft Combine, MLB Draft, Pro Day - University of Alabama). Null for video analysis or scout assessment evaluations.',
    `comparable_player` STRING COMMENT 'Scout-assigned comparable professional player whose career trajectory and skill set most closely mirrors the prospects projected development. Used in broadcast content, fan engagement narratives, and internal draft communication.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scouting report record was first captured in the system. Audit trail field aligned with data governance and SOX financial controls for public entities.',
    `doping_concern_flag` BOOLEAN COMMENT 'Indicates whether the prospect has any documented or suspected Performance Enhancing Drug (PED) use or anti-doping violations flagged during the evaluation process. Confidential field subject to WADA and league anti-doping compliance protocols.',
    `draft_eligibility_status` STRING COMMENT 'Current eligibility determination for the prospect to participate in the draft. Reflects CBA rules, age requirements, amateur status, and any hardship waiver or international player designations.. Valid values are `eligible|ineligible|pending|hardship_waiver|international`',
    `draft_recommendation` STRING COMMENT 'Evaluators recommended draft round or action for this prospect. Feeds the organizations draft board and informs contract slot value calculations under the CBA. Do Not Draft flags prospects with disqualifying concerns.. Valid values are `first_round|second_round|third_round|day_three|undrafted_priority|do_not_draft`',
    `draft_year` STRING COMMENT 'The calendar year of the draft class for which this prospect is being evaluated. Used to group prospects into draft cohorts for comparative analysis and draft board construction.',
    `evaluation_date` DATE COMMENT 'The calendar date on which the evaluation event (combine, pro day, scout visit, video session) took place. Principal real-world event date for this transaction record.',
    `evaluation_type` STRING COMMENT 'Classification of the evaluation methodology used to produce this report. Distinguishes combine measurables (NFL Scouting Combine, NBA Draft Combine, MLB Draft), scout assessment, video analysis via SportsCode/Hudl, pro day, or medical evaluation.. Valid values are `combine_measurables|scout_assessment|video_analysis|pro_day|medical_evaluation`',
    `injury_history_flag` BOOLEAN COMMENT 'Indicates whether the prospect has a documented injury history that was reviewed as part of this evaluation. True triggers mandatory medical evaluation review before draft selection. Supports WADA and league medical compliance processes.',
    `nil_agreement_flag` BOOLEAN COMMENT 'Indicates whether the prospect has active Name, Image, and Likeness (NIL) agreements that may affect draft eligibility, amateur status determination, or contract negotiation. Relevant for NCAA prospects entering professional drafts.',
    `ovr_grade` DECIMAL(18,2) COMMENT 'Overall (OVR) scout grade assigned to the prospect on the standard scouting scale (e.g., 40-80 NFL scale, 1-10 NBA scale). Represents the evaluators holistic assessment of the prospects projected professional value. Principal quantitative fact for this evaluation record.',
    `projection_tier` STRING COMMENT 'Scouts qualitative projection of the prospects ceiling as a professional player. Drives draft round targeting, contract slot value calculations, and roster construction strategy. Franchise player represents top-tier franchise-altering talent.. Valid values are `franchise_player|starter|rotation_player|backup|practice_squad|undrafted`',
    `prospect_position` STRING COMMENT 'Primary playing position of the prospect at the time of evaluation (e.g., QB, WR, PG, SG, SP, C, LW, RW, ST, MF). Position drives which position-specific drill scores and benchmarks are applicable. [ENUM-REF-CANDIDATE: QB|WR|RB|TE|OL|DL|LB|DB|K|P|PG|SG|SF|PF|C|SP|RP|C_MLB|1B|2B|3B|SS|OF|LW|RW|D|G|ST|MF|GK — promote to reference product]',
    `prospect_position_secondary` STRING COMMENT 'Secondary or versatility position the prospect can play, used for positional flexibility analysis in draft targeting and roster construction. Follows same position code taxonomy as prospect_position.',
    `report_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the scouting report, used in draft boards, trade evaluation workflows, and SportsCode/Hudl platform references. Format: SCT-{SPORT}-{YEAR}-{SEQUENCE}.. Valid values are `^SCT-[A-Z]{2,6}-[0-9]{4}-[0-9]{6}$`',
    `report_status` STRING COMMENT 'Current lifecycle state of the scouting report within the evaluation workflow. Draft reports are in progress; submitted reports await review; approved reports feed draft boards and contract slot calculations; superseded reports have been replaced by a newer evaluation.. Valid values are `draft|submitted|under_review|approved|archived|superseded`',
    `sport_code` STRING COMMENT 'Governing league or sport organization code under which this evaluation was conducted. Determines applicable combine standards, measurable benchmarks, and CBA compliance rules. Values align with recognized governing bodies. [ENUM-REF-CANDIDATE: NFL|NBA|MLB|NHL|MLS|UFC|ATP|FIFA — 8 candidates stripped; promote to reference product]',
    `strengths_narrative` STRING COMMENT 'Scouts qualitative narrative describing the prospects key strengths, standout skills, and competitive advantages. Confidential proprietary evaluation content sourced from SportsCode/Hudl platform. Critical for draft board presentations and trade evaluation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this scouting report record. Used for change tracking, audit trails, and incremental data pipeline processing.',
    `weaknesses_narrative` STRING COMMENT 'Scouts qualitative narrative describing the prospects developmental areas, limitations, and risk factors. Confidential proprietary evaluation content. Used in draft risk assessment and contract negotiation strategy.',
    CONSTRAINT pk_scouting_report PRIMARY KEY(`scouting_report_id`)
) COMMENT 'Comprehensive pre-draft evaluation record combining quantitative combine measurables and qualitative scout assessments for prospective athletes. Captures combine event participation (NFL Scouting Combine, NBA Draft Combine, MLB Draft, pro days), physical measurements (height, weight, wingspan, hand size), athletic test results (40-yard dash, vertical jump, bench press reps, shuttle drill, 3-cone drill, 60-yard dash, lane agility), position-specific drill scores, composite scores, and overall grade (OVR). Includes scout narrative evaluations (strengths, weaknesses, projection tier, comparable player), evaluation type (combine measurables, scout assessment, video analysis, pro day), evaluator identity, and draft recommendation. Sourced from SportsCode/Hudl evaluation platform. Feeds draft boards, free agency targeting, trade evaluation, and contract slot value calculations.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` (
    `award_honor_id` BIGINT COMMENT 'Unique surrogate identifier for each award, honor, milestone, or recognition record in the athlete achievement registry.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who received this award, honor, or recognition. Core party reference linking achievement to the athlete master record.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who received this award, honor, or recognition. Core party reference linking achievement to the athlete master record.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to broadcast.media_asset. Business justification: Award highlight broadcasts are a named production process in sports entertainment — award ceremonies, career milestone segments, and Hall of Fame inductions are produced as broadcast media assets. Thi',
    `asset_id` BIGINT COMMENT 'Reference to the broadcast highlight, video clip, or digital asset in the Digital Asset Management (DAM) system associated with this achievement moment. Supports broadcast storytelling and content production workflows in Dalet Galaxy.',
    `franchise_id` BIGINT COMMENT 'Reference to the team the athlete was affiliated with at the time of the award or achievement. Preserves historical team context for roster and broadcast storytelling.',
    `game_result_id` BIGINT COMMENT 'Foreign key linking to league.game_result. Business justification: Game-level awards (Player of the Game, weekly honors tied to a specific game) require linking to the official game result. This enables broadcast highlight workflows, statistical context validation, a',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Award eligibility and statistical governance: analytics governance teams validate that award-qualifying statistics align with official KPI definitions and calculation methodologies. Formalizes the sta',
    `league_id` BIGINT COMMENT 'Reference to the league or governing competition body under whose jurisdiction this award was conferred (e.g., NFL, NBA, FIFA, NHL, MLB, MLS).',
    `nil_agreement_id` BIGINT COMMENT 'Reference to the NIL agreement that was triggered, amended, or commercially activated as a result of this award or achievement. Links achievement to commercial contract lifecycle.',
    `sanction_id` BIGINT COMMENT 'Foreign key linking to compliance.sanction. Business justification: Awards are revoked when athletes receive doping or conduct sanctions. award_honor stores wada_compliance_status and revocation_reason as plain fields. Linking to compliance.sanction enables the award ',
    `season_id` BIGINT COMMENT 'Reference to the competitive season during which the award was earned or the milestone was achieved. Enables season-over-season achievement analytics.',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to sponsorship.sponsor. Business justification: Award sponsorship commercial process: in sports entertainment, awards are routinely presented by named sponsors (e.g., MVP presented by Brand X). Tracking the presenting sponsor on award_honor enabl',
    `team_franchise_id` BIGINT COMMENT 'Reference to the team the athlete was affiliated with at the time of the award or achievement. Preserves historical team context for roster and broadcast storytelling.',
    `achievement_type` STRING COMMENT 'High-level classification of the achievement: award (formal recognition voted or selected), milestone (career statistical threshold), record (all-time or league record), induction (Hall of Fame or equivalent), career_event (debut, retirement, trade milestone, contract extension).. Valid values are `award|milestone|record|induction|career_event`',
    `award_category` STRING COMMENT 'Functional category grouping the award for analytics and reporting (e.g., individual performance, team achievement, sportsmanship, fan vote, media recognition, career milestone, all-star selection, defensive, offensive). [ENUM-REF-CANDIDATE: individual_performance|team_achievement|sportsmanship|fan_vote|media_recognition|career_milestone|all_star|defensive|offensive|special_teams — promote to reference product]',
    `award_date` DATE COMMENT 'The official date on which the award was conferred, the milestone was achieved, or the career event occurred. Principal business event date for timeline analytics and broadcast storytelling.',
    `award_name` STRING COMMENT 'Official name of the award, honor, or recognition as designated by the awarding body (e.g., Most Valuable Player (MVP), Cy Young Award, Ballon dOr, All-Star, All-Pro, Rookie of the Year, Hall of Fame Induction, Wins Above Replacement (WAR) Record).',
    `award_rank` STRING COMMENT 'Ordinal rank or placement of the athlete in the award selection (e.g., 1 for winner, 2 for runner-up, 3 for third place). Null for binary win/no-win awards. Supports finalist and runner-up tracking.',
    `award_season_year` STRING COMMENT 'The four-digit calendar or competition year associated with the award (e.g., 2024 for the 2023-24 season). Supports year-over-year reporting independent of season ID.',
    `award_status` STRING COMMENT 'Current lifecycle status of the award record: active (confirmed and standing), revoked (stripped due to doping, eligibility, or conduct violation), under_review (under investigation), reinstated (restored after appeal), pending (nomination or selection in progress).. Valid values are `active|revoked|under_review|reinstated|pending`',
    `awarding_body_name` STRING COMMENT 'Name of the organization, league office, governing body, media outlet, or fan platform that conferred or certified this award or recognition (e.g., NFL League Office, FIFA, WADA, Basketball Writers Association, fan vote platform).',
    `awarding_body_type` STRING COMMENT 'Classification of the entity that conferred the award: league_office (official league body), governing_body (FIFA, IOC, WADA), media (press association, broadcaster), fan_vote (fan-selected), peer_vote (player-selected), independent (third-party organization).. Valid values are `league_office|governing_body|media|fan_vote|peer_vote|independent`',
    `career_lifecycle_stage` STRING COMMENT 'Stage of the athletes professional career at the time of the achievement: debut (first season), active (mid-career), peak (prime performance years), veteran (late career), retirement (final season), post_career (after retirement, e.g., Hall of Fame induction).. Valid values are `debut|active|peak|veteran|retirement|post_career`',
    `cba_eligibility_confirmed` BOOLEAN COMMENT 'Indicates whether the athletes eligibility for this award was confirmed as compliant with the applicable Collective Bargaining Agreement (CBA) at the time of conferral. Critical for league governance and dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this award or honor record was first created in the system. Audit trail field supporting data lineage, compliance, and Silver Layer lakehouse governance.',
    `external_reference_code` STRING COMMENT 'Externally-known identifier or code assigned by the awarding body, league office, or governing organization (e.g., FIFA award registry ID, NFL league office reference number). Enables cross-system reconciliation.',
    `hall_of_fame_class_year` STRING COMMENT 'The induction class year for Hall of Fame achievements (e.g., 2024). Null for non-induction achievement types. Supports historical archive and broadcast storytelling for induction ceremonies.',
    `hall_of_fame_institution` STRING COMMENT 'Name of the Hall of Fame or equivalent institution into which the athlete was inducted (e.g., Pro Football Hall of Fame, Naismith Memorial Basketball Hall of Fame, Baseball Hall of Fame, Hockey Hall of Fame, FIFA World Football Museum). Null for non-induction records.',
    `is_broadcast_featured` BOOLEAN COMMENT 'Indicates whether this achievement has been featured or scheduled for broadcast storytelling segments, highlight reels, or OTT content packages (True). Supports content production scheduling in Dalet Galaxy.',
    `is_career_first` BOOLEAN COMMENT 'Indicates whether this achievement represents the athletes first occurrence of this award or milestone in their career (True). Critical for debut and first-achievement storytelling in broadcast and fan engagement platforms.',
    `is_nominee` BOOLEAN COMMENT 'Indicates whether this record represents a nomination rather than a final award. True when the athlete was nominated but the award outcome is pending or was not won. Supports nomination tracking for commercial valuation and fan engagement.',
    `is_winner` BOOLEAN COMMENT 'Indicates whether the athlete was the primary winner/recipient of the award (True) or a finalist, nominee, or runner-up (False). Enables filtering of winners vs. nominees in reporting.',
    `jersey_number_at_time` STRING COMMENT 'The athletes jersey number worn at the time of the award or milestone. Supports merchandise licensing, broadcast graphics, and historical archive accuracy.',
    `nil_commercial_value_usd` DECIMAL(18,2) COMMENT 'Estimated commercial valuation uplift in USD attributed to this award or achievement for Name Image and Likeness (NIL) agreement pricing, athlete endorsement negotiations, and merchandise licensing. Supports athlete commercial valuation in Salesforce CRM.',
    `notes` STRING COMMENT 'Free-text field for additional context, historical annotations, or editorial notes about the award or achievement (e.g., shared award, special circumstances, tie-breaking criteria, historical significance). Supports archive and content production teams.',
    `occurrence_number` STRING COMMENT 'Sequential count of how many times this athlete has received this specific award or achieved this milestone (e.g., 3 for a three-time MVP winner, 100 for 100th international cap). Supports multi-winner tracking and career narrative.',
    `position_at_time` TIMESTAMP COMMENT 'The athletes playing position at the time the award was received (e.g., Quarterback, Forward, Pitcher, Center, Midfielder). Preserves historical positional context for analytics and broadcast content.',
    `previous_record_value` DECIMAL(18,2) COMMENT 'The prior record or threshold value that was surpassed when this record-breaking achievement was set. Null for non-record achievements. Enables broadcast storytelling of record-breaking moments.',
    `revocation_reason` STRING COMMENT 'Reason for award revocation or suspension if award_status is revoked or under_review (e.g., Performance Enhancing Drug (PED) violation, eligibility breach, conduct violation, statistical correction). Null for active awards.',
    `selection_method` STRING COMMENT 'Method by which the award recipient was determined: media_vote (sports writers/journalists), player_vote (peer selection), fan_vote (public voting), committee (selection panel), statistical (objective metric threshold), automatic (rule-based, e.g., consecutive games streak).. Valid values are `media_vote|player_vote|fan_vote|committee|statistical|automatic`',
    `sport_code` STRING COMMENT 'Standardized code identifying the sport associated with this achievement (e.g., FOOTBALL, BASKETBALL, SOCCER, BASEBALL, HOCKEY, TENNIS, MMA). Enables cross-sport analytics and content tagging. [ENUM-REF-CANDIDATE: FOOTBALL|BASKETBALL|SOCCER|BASEBALL|HOCKEY|TENNIS|MMA|GOLF|TRACK|CYCLING — promote to reference product]',
    `stat_metric_value` DECIMAL(18,2) COMMENT 'Numeric value of the primary statistical metric at the time of the achievement (e.g., WAR = 8.2, ERA = 1.74, QBR = 94.5, consecutive games = 2,632). Supports record-tracking and historical analytics.',
    `statistical_context` STRING COMMENT 'Free-text or structured description of the key performance statistics that supported or defined this achievement (e.g., 45 TDs, 4,800 passing yards, QBR 92.3, 0.342 BA, 52 HR, 1.2 WAR, 38 goals, 12 assists, Ballon dOr). Supports broadcast storytelling and content production.',
    `total_votes_cast` STRING COMMENT 'Total number of votes cast in the award selection process. Used to calculate vote share percentage for analytics and broadcast storytelling. Null for non-voting selection methods.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this award or honor record was last modified. Supports change tracking, audit trails, and incremental data pipeline processing in the Databricks Silver Layer.',
    `vote_count_received` STRING COMMENT 'Number of votes received by the athlete in the award selection process where voting applies (media vote, player vote, fan vote). Null for non-voting selection methods. Supports voting analytics and fan engagement reporting.',
    `wada_compliance_status` STRING COMMENT 'Anti-doping compliance status of the athlete at the time of the award as verified against World Anti-Doping Agency (WADA) records. Disqualified status triggers award revocation workflows. Critical for league governance and regulatory reporting.. Valid values are `compliant|under_review|suspended|cleared|disqualified`',
    CONSTRAINT pk_award_honor PRIMARY KEY(`award_honor_id`)
) COMMENT 'Unified record of all athlete achievements, awards, honors, career milestones, and recognitions across their professional lifecycle. Covers: league awards (MVP, Cy Young, Ballon dOr, All-Star, All-Pro, Rookie of the Year), career records (all-time scoring leader, consecutive games streak), career lifecycle events (debut, first goal/touchdown/hit, 100th cap, retirement, Hall of Fame induction, contract extension, trade milestone), and fan/media recognitions. Tracks achievement type (award, milestone, record, induction, career_event), awarding/certifying body, date, sport, league, team at time of achievement, statistical context, voting details where applicable, and broadcast highlight reference. Supports content production, broadcast storytelling, merchandise licensing, athlete commercial valuation, fan engagement platforms, and historical archives.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` (
    `salary_cap_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each athlete-level salary cap accounting record within the Silver Layer lakehouse. Primary key for this product.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete whose contract generates this cap entry. Links to the athlete master record in the talent management domain.',
    `athlete_contract_id` BIGINT COMMENT 'Reference to the underlying athlete contract master record from which this annual cap entry is derived. Distinct from the cap entry — the contract master holds multi-year terms; this record is the annual cap accounting view.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete whose contract generates this cap entry. Links to the athlete master record in the talent management domain.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Salary cap hits are posted to cost centers in SAP for budget-vs-actual cap accounting and financial reporting. Sports finance teams require cost center assignment on every cap entry for P&L allocation',
    `franchise_id` BIGINT COMMENT 'Reference to the team (franchise) against whose salary cap this entry is charged. Determines which teams cap space is consumed.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Cap hit amounts are posted to specific GL accounts for financial statement reporting and SAP integration. Every salary cap entry requires a GL account for proper accounting classification. sap_gl_acco',
    `league_id` BIGINT COMMENT 'Reference to the league governing the salary cap rules applicable to this entry (e.g., NFL, NBA, NHL, MLB, MLS). Determines which CBA framework and cap ceiling apply.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Salary cap entries must be reported to the league governing body as regulatory filings. Linking salary_cap_entry to compliance.regulatory_filing enables cap compliance reporting, audit trail maintenan',
    `roster_id` BIGINT COMMENT 'Foreign key linking to athlete.roster. Business justification: A salary cap entry is the financial accounting representation of a specific roster slot. The salary_cap_entry table already links to contract and athlete_profile, but the direct link to the roster rec',
    `salary_cap_id` BIGINT COMMENT 'Foreign key linking to league.salary_cap. Business justification: Each salary_cap_entry (individual player cap hit) must be validated against the franchises total salary_cap record for the season. Linking enables cap space remaining calculations, luxury tax liabili',
    `team_franchise_id` BIGINT COMMENT 'Reference to the team (franchise) against whose salary cap this entry is charged. Determines which teams cap space is consumed.',
    `base_salary` DECIMAL(18,2) COMMENT 'The athletes annual base salary for this cap year as defined in the contract. This is the cash compensation component before bonuses or restructuring. Feeds directly into SAP S/4HANA FI/CO payroll cost centers.',
    `cap_acceleration_date` DATE COMMENT 'The date on which remaining prorated bonuses were accelerated into the current cap year due to a release or trade. Triggers the dead cap charge. Null if no acceleration has occurred.',
    `cap_entry_reference` STRING COMMENT 'Externally-known business identifier for this salary cap entry record, used in cross-system reconciliation with SAP S/4HANA FI/CO and Workday Adaptive Planning. Format typically includes league code, team code, cap year, and sequence (e.g., NFL-DAL-2024-0042).',
    `cap_hit` DECIMAL(18,2) COMMENT 'Total amount this athletes contract counts against the teams league-mandated salary cap for this cap year. Equals base salary plus prorated signing bonus plus any other prorated bonuses. This is the primary cap accounting figure used in league reporting.',
    `cap_hold_amount` DECIMAL(18,2) COMMENT 'The cap space reserved for a restricted free agent (RFA) or unsigned draft pick while the team retains their rights. Prevents teams from circumventing the cap by leaving players unsigned. Amount is set by league rules based on prior salary or draft position.',
    `cap_relief` DECIMAL(18,2) COMMENT 'The reduction in cap hit achieved through a contract restructure, typically by converting base salary into a signing bonus that is then prorated. Represents the net cap space freed in the current year as a result of the restructure.',
    `cap_year` STRING COMMENT 'The league-defined fiscal/competitive year (e.g., 2024) to which this salary cap entry applies. Cap years may not align with calendar years depending on the leagues CBA definition.',
    `cap_year_end_date` DATE COMMENT 'The last date of the league-defined cap year period during which this entry is active. Marks the boundary for cap accounting obligations in this record.',
    `cap_year_start_date` DATE COMMENT 'The first date of the league-defined cap year period during which this entry is active. Used for proration calculations and cap forecasting in Workday Adaptive Planning.',
    `contract_total_years` STRING COMMENT 'Total number of years in the underlying contract. Used as the denominator for signing bonus proration calculations across cap years.',
    `contract_year_number` STRING COMMENT 'The sequential year number within the multi-year contract that this cap entry represents (e.g., Year 1, Year 2, Year 3 of a 5-year deal). Used to track proration schedules and contract progression.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this salary cap entry record was first created in the system. Audit trail field supporting SOX financial controls and data lineage in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this cap entry record (e.g., USD for NFL/NBA/MLB/NHL, EUR for UEFA clubs, GBP for Premier League). Supports multi-league and international operations.. Valid values are `^[A-Z]{3}$`',
    `dead_cap_value` DECIMAL(18,2) COMMENT 'The remaining prorated bonus and other accelerated cap charges that count against the teams cap after an athlete is released, traded, or their contract is terminated. Represents the cap penalty for parting ways with the athlete before contract expiry.',
    `entry_status` STRING COMMENT 'Current lifecycle state of this salary cap entry. active = currently counting against cap; restructured = contract has been restructured, new entry supersedes; voided = contract voided/nullified; dead_cap = player released but cap charge remains; cap_hold = restricted free agent tender hold; historical = prior year closed record.. Valid values are `active|restructured|voided|dead_cap|cap_hold|historical`',
    `entry_type` STRING COMMENT 'Classification of the cap entry by contract category per CBA rules. Determines applicable cap calculation methodology. [ENUM-REF-CANDIDATE: standard|rookie_scale|veteran_minimum|franchise_tag|transition_tag|cap_hold|two_way|10_day|rest_of_season — promote to reference product]',
    `incentive_earned_prior_year` BOOLEAN COMMENT 'Indicates whether the athlete earned incentives in the prior cap year that were classified as unlikely at the time, triggering a cap charge carryover into this cap year. True = prior year unlikely incentive was earned and creates a charge in this year.',
    `is_cap_hold` BOOLEAN COMMENT 'Indicates whether this entry is a cap hold for a restricted free agent or unsigned draft pick rather than an active contract. True = cap hold; False = active contract cap entry.',
    `is_dead_cap` BOOLEAN COMMENT 'Indicates whether this entry represents a dead cap charge (athlete has been released or traded but remaining prorated bonuses still count against the teams cap). True = athlete is no longer on roster but cap charge persists.',
    `is_restructured` BOOLEAN COMMENT 'Indicates whether this cap entry reflects a contract restructure that converted base salary to prorated bonus, generating cap relief in the current year. True = restructure has been applied to this entry.',
    `league_reported_date` DATE COMMENT 'The date on which this cap entry was officially reported to and acknowledged by the league office. Required for compliance with league transaction reporting deadlines under CBA rules.',
    `likely_incentive_amount` DECIMAL(18,2) COMMENT 'Total value of performance incentives classified as likely to be earned per CBA rules based on the athletes prior year performance. Likely incentives count against the current cap year. Per CBA definition, an incentive is likely if the athlete achieved the same threshold in the prior season.',
    `notes` STRING COMMENT 'Free-text field for cap accountants and team finance staff to record contextual information about this entry, such as restructure rationale, league clarification notes, or special CBA provisions applied.',
    `option_bonus_prorated` DECIMAL(18,2) COMMENT 'The prorated portion of any option bonus (e.g., option year exercise bonus, void year bonus) allocated to this cap year. Option bonuses are prorated over remaining contract years when exercised.',
    `per_game_roster_bonus` DECIMAL(18,2) COMMENT 'Bonus amount earned on a per-game-active basis for each game the athlete is on the active roster. Common in NFL contracts. Total potential value for the cap year is tracked here for cap forecasting purposes.',
    `prior_year_incentive_carryover` DECIMAL(18,2) COMMENT 'The dollar amount of incentives earned in the prior cap year (classified as unlikely) that carry over as an additional cap charge in this cap year per CBA rules. Distinct from current-year incentive amounts.',
    `restructure_date` DATE COMMENT 'The date on which the contract restructure was executed, converting base salary to prorated signing bonus and generating cap relief. Null if no restructure has occurred for this entry.',
    `roster_bonus` DECIMAL(18,2) COMMENT 'Bonus amount payable to the athlete for being on the active roster on a specified date in this cap year. Counts fully against the cap in the year it is earned per CBA rules.',
    `signing_bonus_prorated` DECIMAL(18,2) COMMENT 'The portion of the total signing bonus allocated to this specific cap year after proration across the contract length per CBA rules. This amount is included in the cap hit calculation.',
    `signing_bonus_total` DECIMAL(18,2) COMMENT 'Total signing bonus paid to the athlete at contract execution. This amount is prorated across the contract years for cap purposes per CBA rules. Stored as the full contract-level total for reference.',
    `unlikely_incentive_amount` DECIMAL(18,2) COMMENT 'Total value of performance incentives classified as unlikely to be earned per CBA rules. Unlikely incentives do NOT count against the current cap year but create a cap charge in the following year if earned. Per CBA definition, an incentive is unlikely if the athlete did NOT achieve the threshold in the prior season.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this salary cap entry record was last modified. Tracks restructures, corrections, and status changes for audit trail and data lineage purposes in the Databricks Silver Layer.',
    `void_year_flag` BOOLEAN COMMENT 'Indicates whether this cap year is a void year — a contract year that automatically voids, causing all remaining prorated bonuses to accelerate into the final non-void year. Common NFL cap management technique. True = this is a void year.',
    `workday_plan_reference` STRING COMMENT 'Reference identifier linking this cap entry to the corresponding cap forecast scenario in Workday Adaptive Planning. Enables reconciliation between actual cap accounting records and forward-looking cap projections.',
    `workout_bonus` DECIMAL(18,2) COMMENT 'Bonus amount payable to the athlete for attending and completing mandatory off-season workout programs. Cap treatment varies by league CBA — may be fully or partially counted.',
    CONSTRAINT pk_salary_cap_entry PRIMARY KEY(`salary_cap_entry_id`)
) COMMENT 'Athlete-level salary cap accounting records tracking how each contract contributes to a teams league-mandated salary cap. Captures cap year, base salary cap hit, signing bonus proration, dead cap value, incentive escalators (likely/unlikely per CBA), cap relief from restructures, and cap hold for restricted free agents. Integrates with SAP S/4HANA FI/CO for financial reporting and Workday Adaptive Planning for cap forecasting. Distinct from the contract master — this is the annual cap accounting view.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` (
    `free_agency_status_id` BIGINT COMMENT 'Unique surrogate identifier for the free agency status record. Primary key for the athlete.free_agency_status data product in the Databricks Silver Layer.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete whose free agency status is being tracked. Links to the athlete master record.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete whose free agency status is being tracked. Links to the athlete master record.',
    `cba_agreement_id` BIGINT COMMENT 'Foreign key linking to league.cba_agreement. Business justification: Free agency eligibility rules — accrued seasons, restricted vs. unrestricted thresholds, arbitration eligibility, qualifying offer amounts — are all CBA-defined. CBA FK enables version-specific eligib',
    `franchise_id` BIGINT COMMENT 'Reference to the team that last held the athletes rights prior to free agency. Used to determine right of first refusal and tender obligations.',
    `league_id` BIGINT COMMENT 'Reference to the professional league governing this free agency period (e.g., NFL, NBA, MLB, NHL, MLS). Determines applicable Collective Bargaining Agreement (CBA) rules.',
    `matter_id` BIGINT COMMENT 'Foreign key linking to legal.legal_matter. Business justification: Free agency disputes (ROFR exercise challenges, franchise tag litigation, arbitration filings) generate legal matters. free_agency_status tracks arbitration_eligible_flag and arbitration_filing_deadli',
    `athlete_contract_id` BIGINT COMMENT 'Reference to the athletes most recently expired or expiring contract that triggered this free agency status record.',
    `primary_free_franchise_id` BIGINT COMMENT 'Reference to the team that last held the athletes rights prior to free agency. Used to determine right of first refusal and tender obligations.',
    `season_id` BIGINT COMMENT 'Reference to the league season associated with this free agency period. Determines the applicable salary cap year and CBA cycle.',
    `signing_team_franchise_id` BIGINT COMMENT 'Reference to the team that ultimately signed the athlete upon conclusion of free agency. Null until negotiation_status reaches signed. Used for transaction reporting and broadcast ticker updates.',
    `transaction_window_id` BIGINT COMMENT 'Foreign key linking to league.transaction_window. Business justification: Free agency signings must occur within valid transaction windows. Linking free_agency_status to the applicable transaction_window enables signing deadline enforcement, window compliance validation, an',
    `accrued_seasons` STRING COMMENT 'The number of CBA-qualifying seasons the athlete has accrued with the league. Determines free agency eligibility tier (e.g., UFA vs RFA vs ERFA) and vesting rights. Calculated per CBA accrued season definition.',
    `arbitration_eligible_flag` BOOLEAN COMMENT 'Indicates whether the athlete is eligible for salary arbitration in lieu of free agency, based on years of service and CBA thresholds. Particularly relevant in MLB where Super Two eligibility applies.',
    `arbitration_filing_deadline` DATE COMMENT 'The deadline by which the athlete or team must file for salary arbitration. Null when arbitration_eligible_flag is False. Governed by the applicable CBA calendar.',
    `cap_hold_amount` DECIMAL(18,2) COMMENT 'The salary cap charge held against the original teams cap space while the athlete remains unsigned as a free agent. Calculated per CBA formula based on qualifying offer or prior contract value. Expressed in USD. Relevant for roster and cap planning.',
    `cap_hold_released_flag` BOOLEAN COMMENT 'Indicates whether the original team has formally renounced the athletes rights, releasing the associated salary cap hold. Once renounced, the athlete becomes an unrestricted free agent and the team loses all rights.',
    `compensation_tier` STRING COMMENT 'The draft pick compensation tier assigned to this free agent based on prior contract value and performance metrics. Determines the round and value of compensatory draft picks owed. None: no compensation required; Tier 1-3: graduated compensation levels; Qualifying: qualifying offer compensation applies.. Valid values are `none|tier_1|tier_2|tier_3|qualifying`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary amounts on this record (qualifying offer, tender, franchise tag, transition tag amounts). Defaults to USD for North American leagues.. Valid values are `^[A-Z]{3}$`',
    `draft_pick_compensation_flag` BOOLEAN COMMENT 'Indicates whether the signing team is required to provide draft pick compensation to the original team upon signing this athlete. Applicable in leagues with compensatory pick systems (e.g., NFL compensatory picks, MLB Type A/B free agents).',
    `fa_open_date` DATE COMMENT 'The calendar date on which the athletes free agency period officially opens and the athlete becomes eligible to negotiate with other teams. Governed by the applicable CBA calendar.',
    `fa_reference_number` STRING COMMENT 'Externally-known business identifier for this free agency transaction, formatted as FA-{LEAGUE}-{YEAR}-{SEQUENCE}. Used in league transaction reporting, broadcast transaction tickers, and CBA compliance filings.. Valid values are `^FA-[A-Z]{2,5}-[0-9]{4}-[0-9]{6}$`',
    `fa_type` STRING COMMENT 'Classification of the athletes free agency designation under the applicable CBA. Unrestricted Free Agent (UFA) may sign with any team; Restricted Free Agent (RFA) allows original team right of first refusal; Exclusive Rights Free Agent (ERFA) may only negotiate with original team; Franchise Tag and Transition Tag are one-year designations applied by the original team; Waiver indicates release via waiver wire. [ENUM-REF-CANDIDATE: unrestricted|restricted|exclusive_rights|franchise_tag|transition_tag|waiver — promote to reference product]. Valid values are `unrestricted|restricted|exclusive_rights|franchise_tag|transition_tag|waiver`',
    `franchise_tag_amount` DECIMAL(18,2) COMMENT 'The one-year salary value assigned to the athlete under a franchise tag designation. Calculated as the average of the top-N salaries at the athletes position or a percentage of the salary cap, per CBA formula. Expressed in USD.',
    `injury_reserve_flag` BOOLEAN COMMENT 'Indicates whether the athlete was on the injured reserve list at the time of contract expiration. May affect free agency timeline, qualifying offer calculations, and salary cap treatment under CBA provisions.',
    `league_filing_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the free agency transaction was officially filed with the league office. Used for compliance verification, transaction ordering, and broadcast reporting. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `negotiation_status` STRING COMMENT 'Current lifecycle state of the athletes free agency negotiation process. Eligible: athlete is available for negotiation; Negotiating: active discussions underway; Offer Received: formal offer tendered; Signed: new contract executed; Withdrawn: athlete withdrew from market; Voided: status invalidated by league ruling; Deadline Passed: signing window closed without agreement. [ENUM-REF-CANDIDATE: eligible|negotiating|offer_received|signed|withdrawn|voided|deadline_passed — promote to reference product]',
    `nil_agreement_flag` BOOLEAN COMMENT 'Indicates whether the athlete has active Name, Image, and Likeness (NIL) agreements that may affect contract negotiations, endorsement clauses, or league eligibility during the free agency period.',
    `notes` STRING COMMENT 'Free-text field for capturing supplementary information about the athletes free agency status, including league rulings, CBA exceptions, grievance filings, or special circumstances not captured by structured fields.',
    `offer_sheet_received_flag` BOOLEAN COMMENT 'Indicates whether the athlete has received and signed an offer sheet from a team other than the original team. Triggers the original teams right of first refusal window when right_of_first_refusal_flag is True.',
    `opt_out_deadline` DATE COMMENT 'The deadline by which the athlete must formally notify the team of their decision to exercise or decline their player option. Null when player_option_flag is False.',
    `player_option_flag` BOOLEAN COMMENT 'Indicates whether the athlete holds a player option on their contract for the upcoming season. If the athlete opts out, they enter free agency; if they exercise the option, they remain under contract.',
    `prior_team_option_flag` BOOLEAN COMMENT 'Indicates whether the original team holds a club option or team option on the athletes services for the upcoming season, which if exercised would prevent free agency. Distinct from franchise and transition tag designations.',
    `qualifying_offer_amount` DECIMAL(18,2) COMMENT 'The one-year salary amount tendered by the original team as a qualifying offer to retain restricted free agency rights. Expressed in USD. Calculated per CBA formula based on prior contract value or league minimum thresholds.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this free agency status record was first created in the system. Used for audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this free agency status record was most recently modified. Tracks status transitions, amount updates, and deadline changes throughout the free agency lifecycle. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `renouncement_date` DATE COMMENT 'The date on which the original team formally renounced the athletes rights, releasing the cap hold and converting the athlete to an unrestricted free agent. Null when cap_hold_released_flag is False.',
    `right_of_first_refusal_flag` BOOLEAN COMMENT 'Indicates whether the original team retains the right of first refusal to match any offer sheet signed by the athlete with another team. True for restricted free agents where the original team has tendered a qualifying offer. Governed by CBA provisions.',
    `rofr_exercised_flag` BOOLEAN COMMENT 'Indicates whether the original team formally exercised its right of first refusal to match the offer sheet and retain the athlete. Null or False when no offer sheet was received or ROFR was waived.',
    `rofr_response_deadline` DATE COMMENT 'The date by which the original team must exercise or waive its right of first refusal after receiving a signed offer sheet from the athlete. Null when offer_sheet_received_flag is False.',
    `signing_date` DATE COMMENT 'The date on which the athlete formally signed a new contract, concluding the free agency period. Null until negotiation_status reaches signed. Used for broadcast transaction reporting and league filing.',
    `signing_deadline` DATE COMMENT 'The final date by which the athlete must sign a new contract or return to the original team under applicable CBA provisions. Applies primarily to RFA and franchise/transition tag designations.',
    `tag_designation_deadline` DATE COMMENT 'The deadline by which the original team must formally apply a franchise tag or transition tag designation to the athlete. Applicable only when fa_type is franchise_tag or transition_tag.',
    `tender_amount` DECIMAL(18,2) COMMENT 'The one-year salary amount tendered by the original team for an exclusive rights or restricted free agent. Distinct from the qualifying offer amount; represents the minimum the team must offer to retain rights. Expressed in USD.',
    `tender_deadline` DATE COMMENT 'The date by which the original team must submit a qualifying offer or tender to retain restricted free agency rights over the athlete. Failure to tender by this date converts the athlete to an unrestricted free agent.',
    `transition_tag_amount` DECIMAL(18,2) COMMENT 'The one-year salary value assigned to the athlete under a transition tag designation. Typically lower than the franchise tag amount and calculated as the average of the top-N salaries at the athletes position per CBA formula. Expressed in USD.',
    `wada_clearance_status` STRING COMMENT 'The athletes current anti-doping clearance status as required by WADA and applicable league anti-doping programs. Cleared: no active violations; Pending Review: under investigation; Suspended: serving a doping suspension; Ineligible: permanently ineligible. Impacts free agency signing eligibility.. Valid values are `cleared|pending_review|suspended|ineligible`',
    `years_of_service` DECIMAL(18,2) COMMENT 'Total years of professional service credited to the athlete across all teams in the league. Used alongside accrued seasons for salary arbitration eligibility and pension vesting. Expressed as a decimal (e.g., 3.17 years).',
    CONSTRAINT pk_free_agency_status PRIMARY KEY(`free_agency_status_id`)
) COMMENT 'Tracks an athletes free agency eligibility, classification, and market activity during free agency periods. Captures free agency type (unrestricted/UFA, restricted/RFA, exclusive rights/ERFA, franchise tag, transition tag), qualifying offer amount, tender amount, original team right of first refusal flag, free agency open date, signing deadline, and current negotiation status. Supports roster planning, salary cap management, and broadcast transaction reporting.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` (
    `international_cap_id` BIGINT COMMENT 'Unique surrogate identifier for each international cap appearance record in the athlete talent management system. Primary key for the international_cap data product.',
    `athlete_athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who earned this international cap. Links to the athlete master record in the talent management domain.',
    `athlete_profile_id` BIGINT COMMENT 'Reference to the athlete who earned this international cap. Links to the athlete master record in the talent management domain.',
    `broadcast_rights_window_id` BIGINT COMMENT 'Foreign key linking to broadcast.broadcast_rights_window. Business justification: International matches are governed by territory-specific broadcast rights windows. The international_cap has broadcast_rights_territory (denormalized text). Linking to broadcast_rights_window enables ',
    `competition_tournament_id` BIGINT COMMENT 'Reference to the sanctioned international competition in which this cap was earned (e.g., FIFA World Cup Qualifier, Olympic Games, Six Nations, FIBA World Cup).',
    `fixture_id` BIGINT COMMENT 'Reference to the specific match or fixture record in the event domain for which this international cap was awarded.',
    `franchise_id` BIGINT COMMENT 'Reference to the national team or international representative squad the athlete appeared for during this cap.',
    `international_federation_id` BIGINT COMMENT 'Foreign key linking to league.international_federation. Business justification: International caps are governed by the relevant international federation (FIFA, FIBA, World Rugby). Federation FK enables release window management, eligibility verification under federation rules, an',
    `match_fixture_id` BIGINT COMMENT 'Reference to the specific match or fixture record in the event domain for which this international cap was awarded.',
    `national_team_franchise_id` BIGINT COMMENT 'Reference to the national team or international representative squad the athlete appeared for during this cap.',
    `tax_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to finance.tax_jurisdiction. Business justification: International appearances generate jock tax obligations in the jurisdiction where the match is played. Finance teams calculate withholding tax per international cap appearance. venue_country_code is a',
    `tournament_id` BIGINT COMMENT 'Reference to the sanctioned international competition in which this cap was earned (e.g., FIFA World Cup Qualifier, Olympic Games, Six Nations, FIBA World Cup).',
    `whereabouts_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.whereabouts_filing. Business justification: WADA whereabouts compliance requires that competition locations in whereabouts filings match actual international cap records. This FK enables reconciliation between reported competition locations and',
    `age_at_cap` STRING COMMENT 'Age of the athlete in whole years at the time of this international cap appearance. Derived at ingestion from athlete date of birth and match date; stored for analytics efficiency and age-eligibility compliance checks (e.g., U21, U23 tournament eligibility).',
    `assists_recorded` STRING COMMENT 'Number of goal assists or scoring assists credited to the athlete in this international match. Sport-specific definition applies (e.g., final pass before goal in football, assist in basketball). Used for performance analytics and broadcast content.',
    `cap_number` STRING COMMENT 'Sequential cap number representing the athletes cumulative count of international appearances for this national team at the time of this match. Cap number 1 denotes debut. Used for milestone tracking and broadcast content.',
    `cap_status` STRING COMMENT 'Current lifecycle status of this international cap record. confirmed indicates the governing body has officially ratified the appearance; provisional indicates the match result is pending official confirmation; disputed indicates an eligibility challenge is under review; withdrawn indicates the cap was rescinded (e.g., due to doping violation or eligibility fraud); pending_ratification indicates awaiting governing body sign-off.. Valid values are `confirmed|provisional|disputed|withdrawn|pending_ratification`',
    `competition_name` STRING COMMENT 'Full official name of the international competition or tournament in which this cap was earned (e.g., FIFA World Cup 2026 Qualifier, Paris 2024 Olympic Games, Six Nations Championship 2024, International Friendly).',
    `competition_type` STRING COMMENT 'Classification of the international competition category. Determines cap eligibility weight and official recognition by governing bodies. [ENUM-REF-CANDIDATE: world_cup_qualifier|world_cup|olympic_games|continental_championship|regional_qualifier|friendly|invitational — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this international cap record was first created in the data platform (Silver Layer ingestion). Used for audit trail, data lineage, and SLA compliance monitoring.',
    `eligibility_confirmed` BOOLEAN COMMENT 'Indicates whether the athletes eligibility to represent this national team for this specific cap has been formally confirmed by the relevant governing body (True = confirmed eligible). False or null indicates eligibility is under review or not yet ratified.',
    `goals_scored` STRING COMMENT 'Number of goals scored by the athlete in this international match. Applicable to football (FIFA), hockey, and other goal-based sports. Zero if no goals scored. Used for career statistics and broadcast content.',
    `home_away_indicator` STRING COMMENT 'Indicates whether the athletes national team played as the home side, away side, or at a neutral venue for this international match. Relevant for performance analytics and scheduling.. Valid values are `home|away|neutral`',
    `is_captain` BOOLEAN COMMENT 'Indicates whether the athlete served as captain of the national team during this match (True = captained the side). Used for leadership tracking, broadcast content, and career milestone reporting.',
    `is_debut` BOOLEAN COMMENT 'Indicates whether this cap represents the athletes first-ever international appearance for this national team (True = debut cap). Used for milestone tracking, broadcast content, and historical records.',
    `match_date` DATE COMMENT 'Calendar date on which the international match was played. Used for eligibility age calculations, career timeline analysis, and historical reporting.',
    `match_notes` STRING COMMENT 'Free-text field for recording notable events, context, or annotations related to this international cap appearance (e.g., Scored winning penalty in shootout, Played despite injury, Match abandoned due to weather — cap ratified by FIFA). Used by talent management staff and broadcast content teams.',
    `match_result` STRING COMMENT 'Outcome of the international match from the perspective of the athletes national team (win, loss, draw, or no_result for abandoned/voided matches). Used for win/loss record tracking and performance analytics.. Valid values are `win|loss|draw|no_result`',
    `minutes_played` STRING COMMENT 'Total number of minutes the athlete was on the field of play during this international match. Used for workload management, performance analytics (SportsCode/Hudl), and injury risk modelling.',
    `nationality_basis` STRING COMMENT 'The legal or regulatory basis under which the athlete was eligible to represent this national team (e.g., birth nationality, parentage, naturalisation, residency qualification, or governing body association eligibility rule). Critical for eligibility compliance and dispute resolution.. Valid values are `birth|parentage|naturalisation|residency|association_eligibility`',
    `nil_agreement_active` BOOLEAN COMMENT 'Indicates whether the athlete had an active Name, Image and Likeness (NIL) commercial agreement at the time of this international cap. Relevant for broadcast rights, sponsorship activation, and governing body commercial regulations during international windows.',
    `opponent_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the opposing national team (e.g., BRA, DEU, NZL). Enables standardised geographic analysis and cross-sport reporting.. Valid values are `^[A-Z]{3}$`',
    `opponent_score` STRING COMMENT 'Final score (goals, points, or runs as applicable to the sport) achieved by the opposing national team in this match. Used for match result analysis and historical records.',
    `opponent_team_name` STRING COMMENT 'Official name of the opposing national team or international representative side in this match (e.g., Brazil, Germany, New Zealand All Blacks). Used for historical match records and broadcast content.',
    `points_scored` STRING COMMENT 'Total points scored by the athlete in this international match. Applicable to points-based sports such as rugby (tries, conversions, penalties), basketball (FIBA), American football (NFL/international), and athletics. Null for sports where goals_scored is the primary metric.',
    `position_played` STRING COMMENT 'The playing position the athlete occupied during this international match (e.g., Goalkeeper, Centre-Back, Quarterback, Point Guard, Fly-Half). Position naming is sport-specific. Used for performance analytics via SportsCode/Hudl and broadcast content.',
    `red_cards` STRING COMMENT 'Number of red cards or dismissals received by the athlete during this international match. A red card typically results in suspension for subsequent matches. Used for disciplinary tracking and CBA/governing body compliance.',
    `shirt_number` STRING COMMENT 'Jersey or shirt number worn by the athlete during this international match. Used for broadcast graphics, historical records, and fan engagement content.',
    `source_system_reference` STRING COMMENT 'The identifier or record reference from the originating operational system of record (e.g., SportsCode/Hudl performance record ID, SAP SuccessFactors talent record reference, or governing body official match report reference number). Used for data lineage and reconciliation in the Databricks Silver Layer.',
    `sport_code` STRING COMMENT 'Standardised code identifying the sport for which this international cap was awarded (e.g., FOOTBALL, RUGBY_UNION, BASKETBALL, ATHLETICS, HOCKEY). Enables cross-sport reporting and governing body alignment.. Valid values are `^[A-Z]{2,10}$`',
    `substitution_minute` STRING COMMENT 'The match minute at which the athlete was substituted on or off the field. Null if the athlete was a starter who played the full match or did not participate. Used for precise minutes-played calculation and performance analytics.',
    `substitution_type` STRING COMMENT 'Indicates the athletes participation role in the match: whether they started, came on as a substitute, were substituted off, were named but unused, or did not participate. Affects minutes played calculation and cap eligibility rules in some governing bodies.. Valid values are `starter|substitute_on|substitute_off|unused_substitute|did_not_play`',
    `team_score` STRING COMMENT 'Final score (goals, points, or runs as applicable to the sport) achieved by the athletes national team in this match. Used for match result analysis and historical records.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this international cap record was most recently modified in the data platform. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver Layer.',
    `venue_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the country where the match venue is located. Used for travel compliance, tax jurisdiction, and geographic reporting.. Valid values are `^[A-Z]{3}$`',
    `venue_name` STRING COMMENT 'Name of the stadium or arena where this international match was played (e.g., Wembley Stadium, Maracanã, Madison Square Garden). Used for venue operations reporting and broadcast content.',
    `wada_test_conducted` BOOLEAN COMMENT 'Indicates whether the athlete was subject to a WADA-compliant anti-doping test in connection with this international match (True = test conducted). Used for anti-doping compliance tracking and regulatory reporting to WADA and governing bodies.',
    `yellow_cards` STRING COMMENT 'Number of yellow cards or cautions received by the athlete during this international match. Used for disciplinary tracking, suspension management, and compliance with governing body regulations.',
    CONSTRAINT pk_international_cap PRIMARY KEY(`international_cap_id`)
) COMMENT 'Record of an athletes appearances representing a national team or international governing body in sanctioned international competitions (FIFA World Cup qualifiers, Olympic Games, international friendlies, Six Nations, etc.). Captures cap number, competition name, opponent, match date, result, goals/points scored, minutes played, captain flag, and governing body (FIFA, World Rugby, FIBA, IOC). Distinct from club/franchise performance_stat — international caps have separate eligibility and nationality rules.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`agent` (
    `agent_id` BIGINT COMMENT 'Primary key for agent',
    `agency_id` BIGINT COMMENT 'FK to athlete.agency',
    `supervising_agent_id` BIGINT COMMENT 'Self-referencing FK on agent (supervising_agent_id)',
    `active_client_count` STRING COMMENT 'The current number of active athletes represented by this agent.',
    `agent_type` STRING COMMENT 'The classification of agent services provided: player contract negotiation, marketing and endorsements, financial planning, legal services, or full-service representation.',
    `background_check_date` DATE COMMENT 'The date when the most recent background check was completed as part of certification requirements.',
    `background_check_status` STRING COMMENT 'The result status of the most recent background check required for agent certification.',
    `bar_admission_state` STRING COMMENT 'The state(s) where the agent is admitted to practice law, if applicable for legal representation services.',
    `bar_number` STRING COMMENT 'The attorney license number issued by the state bar association, if the agent is a licensed attorney.',
    `certification_date` DATE COMMENT 'The date when the agent was first certified by the league or players association to represent athletes.',
    `certification_expiration_date` DATE COMMENT 'The date when the agents current certification expires and requires renewal.',
    `certification_number` STRING COMMENT 'The unique certification or license number issued by the league or players association authorizing the agent to represent athletes.',
    `certification_status` STRING COMMENT 'Current status of the agents certification with the league or players association governing body.',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'The standard commission percentage the agent charges on athlete contracts and endorsement deals, typically regulated by collective bargaining agreements.',
    `compliance_training_date` DATE COMMENT 'The date when the agent last completed mandatory compliance and ethics training required by the governing body.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this agent record was first created in the system.',
    `disciplinary_action_flag` BOOLEAN COMMENT 'Indicates whether the agent has any active or historical disciplinary actions on record with governing bodies.',
    `disciplinary_action_summary` STRING COMMENT 'A summary description of any disciplinary actions, sanctions, or violations recorded against the agent.',
    `full_name` STRING COMMENT 'The complete legal name of the agent or agency representative as registered with governing sports bodies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this agent record was most recently updated in the system.',
    `last_renewal_date` DATE COMMENT 'The most recent date when the agent renewed their certification with the governing body.',
    `linkedin_profile_url` STRING COMMENT 'The LinkedIn profile URL for the agents professional networking presence.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special considerations, or internal comments about the agent.',
    `office_address_line1` STRING COMMENT 'The first line of the agents primary business office street address.',
    `office_address_line2` STRING COMMENT 'The second line of the agents primary business office street address (suite, floor, building).',
    `office_city` STRING COMMENT 'The city where the agents primary business office is located.',
    `office_country_code` STRING COMMENT 'The three-letter ISO country code for the agents primary business office location.',
    `office_postal_code` STRING COMMENT 'The postal or ZIP code for the agents primary business office location.',
    `office_state_province` STRING COMMENT 'The state or province where the agents primary business office is located.',
    `preferred_contact_method` STRING COMMENT 'The agents preferred method of communication for business matters and athlete representation discussions.',
    `primary_email` STRING COMMENT 'The primary business email address for official agent communications and contract negotiations.',
    `primary_phone` STRING COMMENT 'The primary business phone number for contacting the agent regarding athlete representation matters.',
    `professional_liability_coverage_amount` DECIMAL(18,2) COMMENT 'The total coverage amount in USD for the agents professional liability insurance policy.',
    `professional_liability_expiration_date` DATE COMMENT 'The expiration date of the agents current professional liability insurance policy.',
    `professional_liability_insurance_carrier` STRING COMMENT 'The name of the insurance company providing professional liability (errors and omissions) coverage for the agent.',
    `professional_liability_policy_number` STRING COMMENT 'The policy number for the agents professional liability insurance coverage.',
    `specialization_sports` STRING COMMENT 'Comma-separated list of sports or leagues in which the agent specializes (e.g., NFL, NBA, MLB, NHL, MLS, international soccer).',
    `tax_identification_number` STRING COMMENT 'The federal tax identification number (EIN or SSN) for the agent or agency used for IRS reporting and contract payments.',
    `time_zone` STRING COMMENT 'The time zone of the agents primary business office location using IANA time zone database format.',
    `website_url` STRING COMMENT 'The official website URL for the agents agency or personal representation business.',
    `years_of_experience` STRING COMMENT 'The total number of years the agent has been actively representing athletes in professional sports.',
    CONSTRAINT pk_agent PRIMARY KEY(`agent_id`)
) COMMENT 'Master reference table for agent. Referenced by agent_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`agency` (
    `agency_id` BIGINT COMMENT 'Primary key for agency',
    `parent_agency_id` BIGINT COMMENT 'Self-referencing FK on agency (parent_agency_id)',
    `accreditation_body` STRING COMMENT 'Name of the primary accreditation or regulatory body that oversees the agencys operations.',
    `agency_code` STRING COMMENT 'Unique business identifier or registration code assigned to the agency by league or governing body.',
    `agency_name` STRING COMMENT 'Full legal name of the sports agency or talent representation firm.',
    `agency_type` STRING COMMENT 'Classification of the agency based on the scope of services provided to athletes.',
    `annual_revenue_usd` DECIMAL(18,2) COMMENT 'Total annual revenue generated by the agency in USD from all representation and service activities.',
    `audit_outcome` STRING COMMENT 'Result of the most recent compliance audit or regulatory review.',
    `business_registration_number` STRING COMMENT 'Official business registration or incorporation number issued by government authority.',
    `certification_expiration_date` DATE COMMENT 'Date when the agencys primary certification or license expires and requires renewal.',
    `certification_status` STRING COMMENT 'Current certification or licensing status of the agency with relevant sports governing bodies and players associations.',
    `certified_agent_count` STRING COMMENT 'Number of certified sports agents employed by the agency.',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Standard commission rate percentage charged by the agency for contract negotiations and representation services.',
    `compliance_officer_email` STRING COMMENT 'Email address of the compliance officer for regulatory inquiries and reporting.',
    `compliance_officer_name` STRING COMMENT 'Full name of the designated compliance officer responsible for regulatory adherence and ethical standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agency record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Primary method used by the agency for resolving disputes with clients or third parties.',
    `employee_count` STRING COMMENT 'Total number of full-time employees working for the agency.',
    `ethics_code_version` STRING COMMENT 'Version identifier of the ethics code or professional standards document the agency adheres to.',
    `founding_date` DATE COMMENT 'Date when the agency was established or incorporated.',
    `headquarters_address_line1` STRING COMMENT 'First line of the agency headquarters street address.',
    `headquarters_address_line2` STRING COMMENT 'Second line of the agency headquarters street address (suite, floor, building).',
    `headquarters_city` STRING COMMENT 'City where the agency headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the agency headquarters location.',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the agency headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State or province where the agency headquarters is located.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total coverage amount in USD for the agencys professional liability insurance policy.',
    `insurance_policy_number` STRING COMMENT 'Professional liability insurance policy number covering the agencys representation activities.',
    `international_operations_flag` BOOLEAN COMMENT 'Indicates whether the agency operates internationally and represents athletes in multiple countries.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit or regulatory review conducted on the agency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the agency record was last updated in the system.',
    `league_certifications` STRING COMMENT 'Comma-separated list of professional league certifications held by the agency (e.g., NFLPA, NBPA, MLBPA, NHLPA, MLS).',
    `nil_services_offered_flag` BOOLEAN COMMENT 'Indicates whether the agency offers NIL representation and deal negotiation services for college athletes.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special considerations related to the agency.',
    `parent_company_name` STRING COMMENT 'Name of the parent company or holding entity if the agency is part of a larger corporate structure.',
    `primary_contact_email` STRING COMMENT 'Primary email address for official agency communications and contract negotiations.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the agency for business matters.',
    `specialization_sports` STRING COMMENT 'Comma-separated list of sports in which the agency specializes (e.g., football, basketball, baseball, soccer, hockey).',
    `agency_status` STRING COMMENT 'Current operational status of the agency.',
    `status_effective_date` DATE COMMENT 'Date when the current agency status became effective.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or employer identification number (EIN) for the agency.',
    `total_active_clients` STRING COMMENT 'Current count of active athlete clients represented by the agency.',
    `website_url` STRING COMMENT 'Official website URL for the agency.',
    CONSTRAINT pk_agency PRIMARY KEY(`agency_id`)
) COMMENT 'Master reference table for agency. Referenced by agency_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` (
    `combine_event_id` BIGINT COMMENT 'Primary key for combine_event',
    `venue_id` BIGINT COMMENT 'Reference to the venue where the combine event is held.',
    `parent_combine_event_id` BIGINT COMMENT 'Self-referencing FK on combine_event (parent_combine_event_id)',
    `attended_count` STRING COMMENT 'Number of athletes who actually attended and participated in the combine event.',
    `broadcast_partner` STRING COMMENT 'Name of the broadcasting network or streaming platform covering the combine event.',
    `city` STRING COMMENT 'City where the combine event is held.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the combine event location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the combine event record was first created in the system.',
    `drills_conducted` STRING COMMENT 'Comma-separated list of performance drills and tests conducted at the combine event (e.g., 40-yard dash, vertical jump, bench press, shuttle run).',
    `drug_testing_required` BOOLEAN COMMENT 'Indicates whether drug testing is conducted during the combine event in compliance with anti-doping regulations.',
    `eligibility_criteria` STRING COMMENT 'Description of the eligibility requirements for athletes to participate in the combine event (e.g., draft-eligible, college seniors, international players).',
    `end_date` DATE COMMENT 'The date when the combine event concludes.',
    `event_code` STRING COMMENT 'Unique business identifier code for the combine event used across league systems and broadcast platforms.',
    `event_coordinator_email` STRING COMMENT 'Email address of the event coordinator for official communications.',
    `event_coordinator_name` STRING COMMENT 'Name of the individual or team responsible for coordinating the combine event.',
    `event_coordinator_phone` STRING COMMENT 'Phone number of the event coordinator for official communications.',
    `event_name` STRING COMMENT 'Official name of the combine event (e.g., NFL Scouting Combine, NBA Draft Combine, Regional Pro Day).',
    `event_status` STRING COMMENT 'Current lifecycle status of the combine event.',
    `event_type` STRING COMMENT 'Classification of the combine event based on scope and purpose.',
    `invited_count` STRING COMMENT 'Number of athletes officially invited to the combine event.',
    `is_public` BOOLEAN COMMENT 'Indicates whether the combine event is open to the public or restricted to scouts and team personnel.',
    `is_televised` BOOLEAN COMMENT 'Indicates whether the combine event is broadcast on television or streaming platforms.',
    `medical_screening_required` BOOLEAN COMMENT 'Indicates whether athletes must undergo medical screening as part of the combine event.',
    `notes` STRING COMMENT 'Additional notes or comments about the combine event, including special circumstances, weather conditions, or logistical details.',
    `organizing_body` STRING COMMENT 'Name of the league, federation, or organization conducting the combine event.',
    `participant_count` STRING COMMENT 'Total number of athletes invited or registered to participate in the combine event.',
    `position_groups_tested` STRING COMMENT 'Comma-separated list of position groups or categories tested at the combine event (e.g., quarterbacks, linebackers, forwards, pitchers).',
    `registration_deadline` DATE COMMENT 'Last date by which athletes must register to participate in the combine event.',
    `season_year` STRING COMMENT 'The season year for which the combine event is held (e.g., 2024 for the 2024 draft class).',
    `sport_code` STRING COMMENT 'Sport or league for which the combine event is conducted.',
    `start_date` DATE COMMENT 'The date when the combine event begins.',
    `state_province` STRING COMMENT 'State or province where the combine event is held.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the combine event record was last updated in the system.',
    CONSTRAINT pk_combine_event PRIMARY KEY(`combine_event_id`)
) COMMENT 'Master reference table for combine_event. Referenced by combine_event_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agent`(`agent_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_eligibility_status_id` FOREIGN KEY (`eligibility_status_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`eligibility_status`(`eligibility_status_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ADD CONSTRAINT `fk_athlete_roster_injury_record_id` FOREIGN KEY (`injury_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`injury_record`(`injury_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ADD CONSTRAINT `fk_athlete_athlete_profile_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agent`(`agent_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agent`(`agent_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ADD CONSTRAINT `fk_athlete_athlete_contract_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ADD CONSTRAINT `fk_athlete_performance_stat_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ADD CONSTRAINT `fk_athlete_injury_record_prior_injury_record_id` FOREIGN KEY (`prior_injury_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`injury_record`(`injury_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ADD CONSTRAINT `fk_athlete_draft_selection_combine_result_id` FOREIGN KEY (`combine_result_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`combine_result`(`combine_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ADD CONSTRAINT `fk_athlete_eligibility_status_suspension_record_id` FOREIGN KEY (`suspension_record_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`suspension_record`(`suspension_record_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agent`(`agent_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ADD CONSTRAINT `fk_athlete_nil_agreement_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ADD CONSTRAINT `fk_athlete_agent_relationship_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agency`(`agency_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ADD CONSTRAINT `fk_athlete_agent_relationship_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agent`(`agent_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ADD CONSTRAINT `fk_athlete_agent_relationship_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ADD CONSTRAINT `fk_athlete_agent_relationship_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agent`(`agent_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ADD CONSTRAINT `fk_athlete_suspension_record_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ADD CONSTRAINT `fk_athlete_combine_result_combine_event_id` FOREIGN KEY (`combine_event_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`combine_event`(`combine_event_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ADD CONSTRAINT `fk_athlete_scouting_report_combine_result_id` FOREIGN KEY (`combine_result_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`combine_result`(`combine_result_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ADD CONSTRAINT `fk_athlete_award_honor_nil_agreement_id` FOREIGN KEY (`nil_agreement_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`nil_agreement`(`nil_agreement_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ADD CONSTRAINT `fk_athlete_salary_cap_entry_roster_id` FOREIGN KEY (`roster_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`roster`(`roster_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ADD CONSTRAINT `fk_athlete_free_agency_status_athlete_contract_id` FOREIGN KEY (`athlete_contract_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_contract`(`athlete_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_athlete_athlete_profile_id` FOREIGN KEY (`athlete_athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ADD CONSTRAINT `fk_athlete_international_cap_athlete_profile_id` FOREIGN KEY (`athlete_profile_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`athlete_profile`(`athlete_profile_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ADD CONSTRAINT `fk_athlete_agent_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agency`(`agency_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ADD CONSTRAINT `fk_athlete_agent_supervising_agent_id` FOREIGN KEY (`supervising_agent_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agent`(`agent_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ADD CONSTRAINT `fk_athlete_agency_parent_agency_id` FOREIGN KEY (`parent_agency_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`agency`(`agency_id`);
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` ADD CONSTRAINT `fk_athlete_combine_event_parent_combine_event_id` FOREIGN KEY (`parent_combine_event_id`) REFERENCES `sports_entertainment_ecm`.`athlete`.`combine_event`(`combine_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `sports_entertainment_ecm`.`athlete` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `sports_entertainment_ecm`.`athlete` SET TAGS ('dbx_domain' = 'athlete');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `athlete_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `athlete_contract_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `cba_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Agreement Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `eligibility_status_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `injury_record_id` SET TAGS ('dbx_business_glossary_term' = 'Injury Record Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `loaned_from_team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Loaned From Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `primary_roster_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `roster_loaned_from_team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Loaned From Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `transaction_window_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Window Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Activation Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `cap_hit_currency` SET TAGS ('dbx_business_glossary_term' = 'Cap Hit Currency');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `cap_hit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Deactivation Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `depth_chart_rank` SET TAGS ('dbx_business_glossary_term' = 'Depth Chart Rank');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `draft_pick_number` SET TAGS ('dbx_business_glossary_term' = 'Draft Pick Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `draft_round` SET TAGS ('dbx_business_glossary_term' = 'Draft Round');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `draft_year` SET TAGS ('dbx_business_glossary_term' = 'Draft Year');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `international_slot_flag` SET TAGS ('dbx_business_glossary_term' = 'International Roster Slot Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `is_captain` SET TAGS ('dbx_business_glossary_term' = 'Team Captain Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `jersey_number` SET TAGS ('dbx_business_glossary_term' = 'Jersey Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `nationality_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `nil_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'NIL (Name, Image, and Likeness) Agreement Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Roster Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `position_name` SET TAGS ('dbx_business_glossary_term' = 'Position Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `practice_squad_elevation_flag` SET TAGS ('dbx_business_glossary_term' = 'Practice Squad Elevation Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `roster_number` SET TAGS ('dbx_business_glossary_term' = 'Roster Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `roster_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_value_regex' = 'active|inactive|injured_reserve|practice_squad|waived');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `salary_cap_hit` SET TAGS ('dbx_business_glossary_term' = 'Salary Cap Hit');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `salary_cap_hit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `service_years` SET TAGS ('dbx_business_glossary_term' = 'Service Years');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Roster Slot Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `slot_type` SET TAGS ('dbx_value_regex' = 'active_roster|practice_squad|injured_reserve|reserve|taxi_squad');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_SF|ARCHTICS|TICKETMASTER|MANUAL|LEAGUE_API');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Transaction Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Roster Transaction Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `visa_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Visa Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `visa_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `visa_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `wada_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'WADA (World Anti-Doping Agency) Clearance Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `wada_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|suspended|exempted');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`roster` ALTER COLUMN `wada_last_test_date` SET TAGS ('dbx_business_glossary_term' = 'WADA Last Test Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete Profile ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `agent_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `league_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `team_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `athlete_type` SET TAGS ('dbx_business_glossary_term' = 'Athlete Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `athlete_type` SET TAGS ('dbx_value_regex' = 'player|coach|official|support_staff|prospect');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `bio` SET TAGS ('dbx_business_glossary_term' = 'Profile Biography');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `career_status` SET TAGS ('dbx_business_glossary_term' = 'Career Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `career_status` SET TAGS ('dbx_value_regex' = 'active|retired|suspended|injured_reserve|deceased|inactive');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `country_of_birth_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Birth Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `country_of_birth_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `country_of_birth_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `country_of_birth_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'successfactors|league_registration|manual|transfer_system');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `dominant_foot` SET TAGS ('dbx_business_glossary_term' = 'Dominant Foot');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `dominant_foot` SET TAGS ('dbx_value_regex' = 'left|right|both');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `dominant_hand` SET TAGS ('dbx_business_glossary_term' = 'Dominant Hand');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `dominant_hand` SET TAGS ('dbx_value_regex' = 'left|right|ambidextrous');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `draft_pick_number` SET TAGS ('dbx_business_glossary_term' = 'Draft Pick Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `draft_round` SET TAGS ('dbx_business_glossary_term' = 'Draft Round');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `draft_year` SET TAGS ('dbx_business_glossary_term' = 'Draft Year');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending_review|suspended|banned');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `headshot_image_url` SET TAGS ('dbx_business_glossary_term' = 'Headshot Image URL');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `headshot_image_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (Centimetres)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `injury_status` SET TAGS ('dbx_business_glossary_term' = 'Injury Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `injury_status` SET TAGS ('dbx_value_regex' = 'healthy|day_to_day|injured_reserve|physically_unable|out_for_season');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `jersey_number` SET TAGS ('dbx_business_glossary_term' = 'Jersey Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `league_registration_number` SET TAGS ('dbx_business_glossary_term' = 'League Registration Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `nationality_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `nil_agreement_active` SET TAGS ('dbx_business_glossary_term' = 'NIL Agreement Active Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `primary_position` SET TAGS ('dbx_business_glossary_term' = 'Primary Position');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `pro_debut_date` SET TAGS ('dbx_business_glossary_term' = 'Professional Debut Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `secondary_position` SET TAGS ('dbx_business_glossary_term' = 'Secondary Position');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `social_media_handle_instagram` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle — Instagram');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `social_media_handle_instagram` SET TAGS ('dbx_value_regex' = '^@[A-Za-z0-9_.]{1,50}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `social_media_handle_twitter` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle — X/Twitter');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `social_media_handle_twitter` SET TAGS ('dbx_value_regex' = '^@[A-Za-z0-9_]{1,50}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `source_system_athlete_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `sport_code` SET TAGS ('dbx_business_glossary_term' = 'Sport Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `wada_registered_testing_pool` SET TAGS ('dbx_business_glossary_term' = 'WADA Registered Testing Pool Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_profile` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `athlete_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `cba_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Agreement Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `insurance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'SAP SuccessFactors Position ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `tax_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `aav` SET TAGS ('dbx_business_glossary_term' = 'Annual Average Value (AAV)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `aav` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `base_salary_year1` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Year 1');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `base_salary_year1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `cap_hit` SET TAGS ('dbx_business_glossary_term' = 'Salary Cap Hit');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `cap_hit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|expired|voided|restructured|suspended');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'rookie|veteran|max|minimum|two_way');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `dead_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Dead Cap Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `dead_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `free_agency_class` SET TAGS ('dbx_business_glossary_term' = 'Free Agency Classification');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `free_agency_class` SET TAGS ('dbx_value_regex' = 'UFA|RFA|ERFA|franchise_tag|transition_tag|none');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `free_agency_class` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `free_agency_open_date` SET TAGS ('dbx_business_glossary_term' = 'Free Agency Open Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `free_agency_open_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `guaranteed_amount` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Money Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `guaranteed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `negotiation_status` SET TAGS ('dbx_business_glossary_term' = 'Free Agency Negotiation Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `negotiation_status` SET TAGS ('dbx_value_regex' = 'open|offer_extended|offer_accepted|offer_rejected|signed|expired');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `negotiation_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `nil_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Name, Image and Likeness (NIL) Agreement Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `nil_agreement_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `no_cut_clause` SET TAGS ('dbx_business_glossary_term' = 'No-Cut Clause Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `no_cut_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `no_trade_clause` SET TAGS ('dbx_business_glossary_term' = 'No-Trade Clause Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `no_trade_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `option_deadline` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Deadline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `option_deadline` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `option_type` SET TAGS ('dbx_business_glossary_term' = 'Option Year Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `option_type` SET TAGS ('dbx_value_regex' = 'team|player|mutual|vesting|none');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `option_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `option_years` SET TAGS ('dbx_business_glossary_term' = 'Option Years Count');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `option_years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `performance_bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Performance Bonus Eligibility Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `performance_bonus_eligible` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `performance_bonus_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Performance Bonus Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `performance_bonus_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `physical_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Contract Physical Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `physical_passed` SET TAGS ('dbx_business_glossary_term' = 'Pre-Contract Physical Passed Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `qualifying_offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Offer Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `qualifying_offer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `right_of_first_refusal` SET TAGS ('dbx_business_glossary_term' = 'Right of First Refusal (ROFR) Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `right_of_first_refusal` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `roster_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `roster_status` SET TAGS ('dbx_value_regex' = 'active_roster|practice_squad|injured_reserve|suspended|exempt|waived');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `sap_contract_doc_number` SET TAGS ('dbx_business_glossary_term' = 'SAP S/4HANA Contract Document Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `sap_contract_doc_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `signing_bonus` SET TAGS ('dbx_business_glossary_term' = 'Signing Bonus Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `signing_bonus` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signing Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `signing_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `signing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Free Agency Signing Deadline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `signing_deadline` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `wada_compliant` SET TAGS ('dbx_business_glossary_term' = 'World Anti-Doping Agency (WADA) Compliance Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `years` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration (Years)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`athlete_contract` ALTER COLUMN `years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `performance_stat_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Statistic ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Game ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `game_result_id` SET TAGS ('dbx_business_glossary_term' = 'Game ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Stat Input - Kpi Definition Id');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `opponent_team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Opponent Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `primary_performance_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `aggregation_method_override` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Method Override');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `assists` SET TAGS ('dbx_business_glossary_term' = 'Assists');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `batting_average` SET TAGS ('dbx_business_glossary_term' = 'Batting Average');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `blocks` SET TAGS ('dbx_business_glossary_term' = 'Blocks');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'League Certification Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `contribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Contribution Weight');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `era` SET TAGS ('dbx_business_glossary_term' = 'Earned Run Average (ERA)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `field_goal_percentage` SET TAGS ('dbx_business_glossary_term' = 'Field Goal Percentage');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `fouls_committed` SET TAGS ('dbx_business_glossary_term' = 'Fouls Committed');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `games_played` SET TAGS ('dbx_business_glossary_term' = 'Games Played');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `games_started` SET TAGS ('dbx_business_glossary_term' = 'Games Started');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `goals` SET TAGS ('dbx_business_glossary_term' = 'Goals Scored');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `hudl_stat_record_reference` SET TAGS ('dbx_business_glossary_term' = 'SportsCode/Hudl Statistical Record ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `innings_pitched` SET TAGS ('dbx_business_glossary_term' = 'Innings Pitched');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `is_home_game` SET TAGS ('dbx_business_glossary_term' = 'Home Game Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `is_primary_input` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Input');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `minutes_played` SET TAGS ('dbx_business_glossary_term' = 'Minutes Played');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `on_base_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Base Percentage (OBP)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `passing_yards` SET TAGS ('dbx_business_glossary_term' = 'Passing Yards');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `plus_minus` SET TAGS ('dbx_business_glossary_term' = 'Plus/Minus Rating');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `points_scored` SET TAGS ('dbx_business_glossary_term' = 'Points Scored');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `position_played` SET TAGS ('dbx_business_glossary_term' = 'Position Played');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `qbr` SET TAGS ('dbx_business_glossary_term' = 'Quarterback Rating (QBR)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `rebounds` SET TAGS ('dbx_business_glossary_term' = 'Rebounds');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `receiving_yards` SET TAGS ('dbx_business_glossary_term' = 'Receiving Yards');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `red_cards` SET TAGS ('dbx_business_glossary_term' = 'Red Cards');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `rushing_yards` SET TAGS ('dbx_business_glossary_term' = 'Rushing Yards');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `saves` SET TAGS ('dbx_business_glossary_term' = 'Saves');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `slugging_percentage` SET TAGS ('dbx_business_glossary_term' = 'Slugging Percentage');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `sport_discipline` SET TAGS ('dbx_business_glossary_term' = 'Sport Discipline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `stat_date` SET TAGS ('dbx_business_glossary_term' = 'Statistical Record Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `stat_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Stat Period End Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `stat_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Stat Period Start Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `stat_status` SET TAGS ('dbx_business_glossary_term' = 'Statistical Record Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `stat_status` SET TAGS ('dbx_value_regex' = 'official|provisional|revised|voided|pending_review');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `stat_type` SET TAGS ('dbx_business_glossary_term' = 'Statistical Record Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `stat_type` SET TAGS ('dbx_value_regex' = 'game|season|career|playoff|tournament');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `steals` SET TAGS ('dbx_business_glossary_term' = 'Steals');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `strikeouts` SET TAGS ('dbx_business_glossary_term' = 'Strikeouts');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `tackles` SET TAGS ('dbx_business_glossary_term' = 'Tackles');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `touchdowns` SET TAGS ('dbx_business_glossary_term' = 'Touchdowns');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `war` SET TAGS ('dbx_business_glossary_term' = 'Wins Above Replacement (WAR)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`performance_stat` ALTER COLUMN `yellow_cards` SET TAGS ('dbx_business_glossary_term' = 'Yellow Cards');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_record_id` SET TAGS ('dbx_business_glossary_term' = 'Injury Record ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Treating Physician ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `event_fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `game_result_id` SET TAGS ('dbx_business_glossary_term' = 'Game Result Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `insurance_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `prior_injury_record_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Injury Record ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `actual_rtp_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return-to-Play (RTP) Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `actual_rtp_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `actual_rtp_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `body_part` SET TAGS ('dbx_business_glossary_term' = 'Injured Body Part');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `body_part` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `body_part` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `body_side` SET TAGS ('dbx_business_glossary_term' = 'Injured Body Side (Laterality)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `body_side` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|central|not_applicable');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `body_side` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `body_side` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `broadcast_disclosure_approved` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Disclosure Approved Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `broadcast_injury_note` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Injury Note');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Injury Case Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^INJ-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `concussion_protocol_triggered` SET TAGS ('dbx_business_glossary_term' = 'Concussion Protocol Triggered Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `concussion_protocol_triggered` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `concussion_protocol_triggered` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `days_lost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Days Lost');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `days_lost_actual` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `days_lost_actual` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `days_lost_estimated` SET TAGS ('dbx_business_glossary_term' = 'Estimated Days Lost');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `days_lost_estimated` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `days_lost_estimated` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `expected_rtp_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return-to-Play (RTP) Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `expected_rtp_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `expected_rtp_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `icd10_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Diagnosis Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `icd10_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `icd10_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `icd10_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_date` SET TAGS ('dbx_business_glossary_term' = 'Injury Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_description` SET TAGS ('dbx_business_glossary_term' = 'Injury Description');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_location` SET TAGS ('dbx_business_glossary_term' = 'Injury Occurrence Location');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_location` SET TAGS ('dbx_value_regex' = 'game|practice|training_facility|travel|other');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Injury Mechanism');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_mechanism` SET TAGS ('dbx_value_regex' = 'contact|non_contact|overexertion|environmental|unknown');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_mechanism` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_mechanism` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_status` SET TAGS ('dbx_business_glossary_term' = 'Injury Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_status` SET TAGS ('dbx_value_regex' = 'active|day_to_day|injured_reserve|out|returned|closed');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_type` SET TAGS ('dbx_value_regex' = 'acute|chronic|overuse|illness|concussion|fracture');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `injury_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `insurance_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Reserve Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `insurance_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `ir_designation` SET TAGS ('dbx_business_glossary_term' = 'Injured Reserve (IR) Designation');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `ir_designation` SET TAGS ('dbx_value_regex' = 'none|ir_standard|ir_return_designated|ir_non_football|pup_list');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `is_osha_recordable` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Injury Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `is_recurrence` SET TAGS ('dbx_business_glossary_term' = 'Injury Recurrence Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `is_recurrence` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `is_recurrence` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `is_wada_reportable` SET TAGS ('dbx_business_glossary_term' = 'WADA Reportable Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `is_wada_reportable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `is_wada_reportable` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `is_workers_comp_claim` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `medical_staff_notes` SET TAGS ('dbx_business_glossary_term' = 'Medical Staff Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `medical_staff_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `medical_staff_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Injury Reported Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `reported_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `reported_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `rtp_clearance_stage` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Play (RTP) Clearance Stage');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `rtp_clearance_stage` SET TAGS ('dbx_value_regex' = 'not_started|limited_activity|non_contact_practice|full_practice|cleared|cleared_with_restrictions');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `rtp_clearance_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `rtp_clearance_stage` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `severity_grade` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity Grade');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `severity_grade` SET TAGS ('dbx_value_regex' = 'minor|moderate|severe|career_threatening');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `severity_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `severity_grade` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_successfactors|hudl|manual_entry|team_medical_system|other');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `surgery_date` SET TAGS ('dbx_business_glossary_term' = 'Surgery Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `surgery_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `surgery_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `surgery_required` SET TAGS ('dbx_business_glossary_term' = 'Surgery Required Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `surgery_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `surgery_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `treating_physician_reference` SET TAGS ('dbx_business_glossary_term' = 'Treating Physician ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `treatment_protocol` SET TAGS ('dbx_business_glossary_term' = 'Treatment Protocol');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `treatment_protocol` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `treatment_protocol` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `tue_reference` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Use Exemption (TUE) Reference');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `tue_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `tue_reference` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`injury_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `draft_selection_id` SET TAGS ('dbx_business_glossary_term' = 'Draft Selection ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Announcement Asset Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `cba_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Agreement Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `combine_result_id` SET TAGS ('dbx_business_glossary_term' = 'Combine Result Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `draft_class_draft_id` SET TAGS ('dbx_business_glossary_term' = 'Draft Class ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `draft_id` SET TAGS ('dbx_business_glossary_term' = 'Draft Class ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Selecting Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `original_team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Original Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `primary_draft_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Selecting Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `actual_signing_bonus` SET TAGS ('dbx_business_glossary_term' = 'Actual Signing Bonus (USD)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `actual_signing_bonus` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `athlete_college` SET TAGS ('dbx_business_glossary_term' = 'Athlete College or Prior Club');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `athlete_nationality` SET TAGS ('dbx_business_glossary_term' = 'Athlete Nationality (ISO 3166-1 Alpha-3)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `athlete_nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `athlete_nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `athlete_nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `athlete_position` SET TAGS ('dbx_business_glossary_term' = 'Athlete Draft Position');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `conditional_pick_terms` SET TAGS ('dbx_business_glossary_term' = 'Conditional Pick Terms');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `contract_option_years` SET TAGS ('dbx_business_glossary_term' = 'Rookie Contract Option Years');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `contract_years` SET TAGS ('dbx_business_glossary_term' = 'Rookie Contract Years');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `draft_date` SET TAGS ('dbx_business_glossary_term' = 'Draft Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `draft_year` SET TAGS ('dbx_business_glossary_term' = 'Draft Year');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `eligibility_year` SET TAGS ('dbx_business_glossary_term' = 'Draft Eligibility Year');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `is_compensatory_pick` SET TAGS ('dbx_business_glossary_term' = 'Is Compensatory Pick');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `is_conditional_pick` SET TAGS ('dbx_business_glossary_term' = 'Is Conditional Pick');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `is_traded_pick` SET TAGS ('dbx_business_glossary_term' = 'Is Traded Pick');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Draft Medical Clearance Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|conditional|not_cleared|pending');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Draft Selection Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `overall_pick_number` SET TAGS ('dbx_business_glossary_term' = 'Overall Pick Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `pick_number_in_round` SET TAGS ('dbx_business_glossary_term' = 'Pick Number in Round');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `pick_type` SET TAGS ('dbx_business_glossary_term' = 'Pick Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `pick_type` SET TAGS ('dbx_value_regex' = 'standard|compensatory|supplemental|conditional|traded');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `pre_draft_grade` SET TAGS ('dbx_business_glossary_term' = 'Pre-Draft Scout Grade');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `pre_draft_ranking` SET TAGS ('dbx_business_glossary_term' = 'Pre-Draft Ranking');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `round_number` SET TAGS ('dbx_business_glossary_term' = 'Round Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `selection_code` SET TAGS ('dbx_business_glossary_term' = 'Draft Selection Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `selection_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}-[0-9]{4}-R[0-9]{1,2}-P[0-9]{1,3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `selection_status` SET TAGS ('dbx_business_glossary_term' = 'Draft Selection Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `selection_status` SET TAGS ('dbx_value_regex' = 'announced|signed|unsigned|voided|traded_rights|forfeited');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `selection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Selection Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `signing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Signing Deadline Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `signing_slot_value` SET TAGS ('dbx_business_glossary_term' = 'Signing Slot Value (USD)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `signing_slot_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `wada_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'WADA Anti-Doping Clearance Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`draft_selection` ALTER COLUMN `wada_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|suspended|ineligible');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `eligibility_status_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `exemption_id` SET TAGS ('dbx_business_glossary_term' = 'Exemption Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `governing_body_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Body ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `incident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Incident ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `litigation_case_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Case Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `nil_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Name Image and Likeness (NIL) Agreement ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `regulatory_license_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory License Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `sanction_id` SET TAGS ('dbx_business_glossary_term' = 'Sanction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `suspension_record_id` SET TAGS ('dbx_business_glossary_term' = 'Suspension Record Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `age_eligibility_verified` SET TAGS ('dbx_business_glossary_term' = 'Age Eligibility Verified Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `amateur_professional_status` SET TAGS ('dbx_business_glossary_term' = 'Amateur / Professional Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `amateur_professional_status` SET TAGS ('dbx_value_regex' = 'amateur|professional|student_athlete|nil_eligible');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `appeal_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `appeal_outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_filed|appeal_pending|appeal_upheld|appeal_dismissed|appeal_reduced');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `broadcast_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Rights Clearance Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `eligibility_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Reference Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|suspended|pending_review|conditionally_eligible|reinstated');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `eligibility_type` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `game_day_eligible` SET TAGS ('dbx_business_glossary_term' = 'Game Day Eligibility Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `games_remaining` SET TAGS ('dbx_business_glossary_term' = 'Games Remaining in Suspension');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `penalty_paid` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Paid Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'League Registration Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'League Registration Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `reinstatement_conditions` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Conditions');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_business_glossary_term' = 'Restriction Scope');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_value_regex' = 'all_competitions|league_only|international_only|specific_event|training_ban');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Doping Sample Collection Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `transfer_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'International Transfer Clearance Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `transfer_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|rejected|expired');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `visa_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Visa / Work Permit Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `visa_issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Visa Issuing Country Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `visa_issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `visa_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Visa / Work Permit Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `visa_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `visa_permit_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `whereabouts_compliant` SET TAGS ('dbx_business_glossary_term' = 'WADA Whereabouts Compliance Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`eligibility_status` ALTER COLUMN `whereabouts_failure_count` SET TAGS ('dbx_business_glossary_term' = 'WADA Whereabouts Failure Count');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `nil_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Name Image and Likeness (NIL) Agreement ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `brand_partner_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Partner ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `cba_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Agreement Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `contract_template_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Template Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `governing_body_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `ip_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Portfolio Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `nda_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `sku_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Nil Sku Authorization - Sku Catalog Id');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Partner ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `tax_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'NIL Agreement Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^NIL-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'NIL Agreement Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `annual_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Recurring Revenue (ARR) Deal Value Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `annual_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `appearance_count` SET TAGS ('dbx_business_glossary_term' = 'Contracted Appearance Count');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'SKU Authorization Approval Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `broadcast_usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Usage Rights Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `cba_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Compliance Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `cba_compliance_status` SET TAGS ('dbx_value_regex' = 'not_applicable|compliant|under_review|non_compliant');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `deal_category` SET TAGS ('dbx_business_glossary_term' = 'NIL Deal Category');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `deal_category` SET TAGS ('dbx_value_regex' = 'nil_amateur|nil_collegiate|professional_endorsement|appearance|social_media|licensing');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'NIL Deal Total Value Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `digital_usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Digital Usage Rights Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'NIL Disclosure Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'NIL Disclosure Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|disclosed|overdue');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|litigation|mediation|cas_arbitration');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_value_regex' = 'none|category_exclusive|league_exclusive|global_exclusive|regional_exclusive');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `exclusivity_territory` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Territory');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `exclusivity_territory` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}(,[A-Z]{3})*$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country (ISO 3166-1 Alpha-3)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `in_venue_usage_rights` SET TAGS ('dbx_business_glossary_term' = 'In-Venue Usage Rights Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `incentive_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Incentive Value Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `incentive_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Agreement Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `league_sponsor_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'League Sponsor Conflict Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `merchandise_usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Licensing Usage Rights Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `morality_clause_included` SET TAGS ('dbx_business_glossary_term' = 'Morality Clause Included Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `morality_clause_terms` SET TAGS ('dbx_business_glossary_term' = 'Morality Clause Terms Description');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `morality_clause_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `payment_structure` SET TAGS ('dbx_business_glossary_term' = 'Payment Structure');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `payment_structure` SET TAGS ('dbx_value_regex' = 'lump_sum|installment|milestone|royalty|hybrid');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Product Category');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `royalty_rate_override` SET TAGS ('dbx_business_glossary_term' = 'SKU Royalty Rate Override');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `royalty_rate_override` SET TAGS ('dbx_financial_sensitive' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `social_media_post_count` SET TAGS ('dbx_business_glossary_term' = 'Contracted Social Media Post Count');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `social_media_usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Social Media Usage Rights Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Reason');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `territory_restriction` SET TAGS ('dbx_business_glossary_term' = 'SKU Territory Restriction');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `territory_restriction` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Scope');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `usage_rights_scope` SET TAGS ('dbx_licensing' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`nil_agreement` ALTER COLUMN `wada_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'World Anti-Doping Agency (WADA) Compliance Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `agent_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Relationship ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `governing_body_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `nda_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `agent_license_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Agent License Jurisdiction');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `agent_license_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `agreement_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Document Reference');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `agreement_document_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agent Certification Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Agent Certification Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `commission_basis` SET TAGS ('dbx_business_glossary_term' = 'Commission Basis');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `commission_basis` SET TAGS ('dbx_value_regex' = 'gross_salary|net_salary|signing_bonus|endorsements|nil_income|all_income');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `compliance_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Outcome');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `compliance_review_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|waived');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `conflict_of_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `conflict_of_interest_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `conflict_of_interest_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `contract_negotiation_authority` SET TAGS ('dbx_business_glossary_term' = 'Contract Negotiation Authority Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `crm_record_reference` SET TAGS ('dbx_business_glossary_term' = 'CRM Record ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `endorsement_representation` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Representation Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `is_primary_agent` SET TAGS ('dbx_business_glossary_term' = 'Primary Agent Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `league_approval_date` SET TAGS ('dbx_business_glossary_term' = 'League Approval Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `league_filing_date` SET TAGS ('dbx_business_glossary_term' = 'League Filing Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `league_filing_status` SET TAGS ('dbx_business_glossary_term' = 'League Filing Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `league_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|approved|rejected|under_review');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `legal_representation` SET TAGS ('dbx_business_glossary_term' = 'Legal Representation Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `nil_representation` SET TAGS ('dbx_business_glossary_term' = 'NIL Representation Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agent Relationship Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `power_of_attorney` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `power_of_attorney` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `power_of_attorney_scope` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney Scope');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `power_of_attorney_scope` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agent Primary Contact Email');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agent Primary Contact Phone');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `relationship_number` SET TAGS ('dbx_business_glossary_term' = 'Agent Relationship Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `relationship_number` SET TAGS ('dbx_value_regex' = '^AR-[0-9]{8}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Agent Relationship Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|expired');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `representation_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Representation Agreement Signed Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `representation_agreement_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `representation_scope` SET TAGS ('dbx_business_glossary_term' = 'Representation Scope');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `sport_discipline` SET TAGS ('dbx_business_glossary_term' = 'Sport Discipline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Termination Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Relationship Termination Reason');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `suspension_record_id` SET TAGS ('dbx_business_glossary_term' = 'Suspension Record ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `doping_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Doping Violation Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `governing_body_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'League Season Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `litigation_case_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Case Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `sanction_id` SET TAGS ('dbx_business_glossary_term' = 'Sanction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Public Announcement Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `appeal_body` SET TAGS ('dbx_business_glossary_term' = 'Appeal Body');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `appeal_body` SET TAGS ('dbx_value_regex' = 'cas|wada|league_appeals_panel|arbitration|federal_court|none');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_filed|appeal_pending|appeal_upheld|appeal_denied|appeal_withdrawn');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `broadcast_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Restriction Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `case_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Case Reference Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `case_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `competition_scope` SET TAGS ('dbx_business_glossary_term' = 'Competition Scope');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `competition_scope` SET TAGS ('dbx_value_regex' = 'all_competitions|league_only|international_only|domestic_cup|preseason_excluded');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Effective End Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Effective Start Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Hearing Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `hearing_officer` SET TAGS ('dbx_business_glossary_term' = 'Hearing Officer');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `is_indefinite` SET TAGS ('dbx_business_glossary_term' = 'Indefinite Suspension Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `is_lifetime_ban` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Ban Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `is_public_announcement` SET TAGS ('dbx_business_glossary_term' = 'Public Announcement Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `is_suspension_stayed` SET TAGS ('dbx_business_glossary_term' = 'Suspension Stayed Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Issued Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `nil_agreement_impact` SET TAGS ('dbx_business_glossary_term' = 'NIL Agreement Impact');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `nil_agreement_impact` SET TAGS ('dbx_value_regex' = 'suspended|terminated|unaffected|under_review');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `nil_agreement_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `prior_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Violation Count');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `prior_violation_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `prohibited_substance_code` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Substance Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `prohibited_substance_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `reinstatement_conditions` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Conditions');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `salary_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Withheld Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `salary_withheld_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `suspension_length_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Length in Days');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `suspension_length_games` SET TAGS ('dbx_business_glossary_term' = 'Suspension Length in Games');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `suspension_status` SET TAGS ('dbx_business_glossary_term' = 'Suspension Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `suspension_status` SET TAGS ('dbx_value_regex' = 'active|served|appealed|overturned|reduced|pending');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `suspension_type` SET TAGS ('dbx_business_glossary_term' = 'Suspension Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `suspension_type` SET TAGS ('dbx_value_regex' = 'ped_violation|conduct_violation|game_misconduct|league_discipline|match_fixing|financial_breach');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `testing_authority` SET TAGS ('dbx_business_glossary_term' = 'Testing Authority');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `union_grievance_number` SET TAGS ('dbx_business_glossary_term' = 'Union Grievance Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `union_grievance_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`suspension_record` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `combine_result_id` SET TAGS ('dbx_business_glossary_term' = 'Combine Result ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Video Session ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `doping_test_id` SET TAGS ('dbx_business_glossary_term' = 'Combine Compliance Doping Test Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `combine_event_id` SET TAGS ('dbx_business_glossary_term' = 'Combine Event ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `draft_id` SET TAGS ('dbx_business_glossary_term' = 'Draft Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scout / Evaluator ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Combine Event ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `scout_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scout / Evaluator ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `arm_length_inches` SET TAGS ('dbx_business_glossary_term' = 'Arm Length (Inches)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `athleticism_grade` SET TAGS ('dbx_business_glossary_term' = 'Athleticism Grade');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `athleticism_grade` SET TAGS ('dbx_value_regex' = 'elite|above_average|average|below_average|poor');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `bench_press_reps` SET TAGS ('dbx_business_glossary_term' = 'Bench Press Repetitions');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `body_fat_pct` SET TAGS ('dbx_business_glossary_term' = 'Body Fat Percentage');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `body_fat_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `broad_jump_inches` SET TAGS ('dbx_business_glossary_term' = 'Broad Jump (Inches)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Combine Score');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `draft_year` SET TAGS ('dbx_business_glossary_term' = 'Draft Year');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `drills_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'All Drills Completed Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `eligibility_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Draft Eligibility Confirmed');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|voided|incomplete');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `forty_yard_dash_sec` SET TAGS ('dbx_business_glossary_term' = '40-Yard Dash Time (Seconds)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `hand_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Hand Size (Inches)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Height (Inches)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `hudl_evaluation_reference` SET TAGS ('dbx_business_glossary_term' = 'SportsCode / Hudl Evaluation ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `injury_description` SET TAGS ('dbx_business_glossary_term' = 'Injury Description');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `injury_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `injury_flag` SET TAGS ('dbx_business_glossary_term' = 'Injury Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `lane_agility_sec` SET TAGS ('dbx_business_glossary_term' = 'Lane Agility Drill Time (Seconds)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `max_vertical_jump_inches` SET TAGS ('dbx_business_glossary_term' = 'Max Vertical Jump (Inches)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `position_drill_notes` SET TAGS ('dbx_business_glossary_term' = 'Position-Specific Drill Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `position_drill_score` SET TAGS ('dbx_business_glossary_term' = 'Position-Specific Drill Score');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `prospect_position` SET TAGS ('dbx_business_glossary_term' = 'Prospect Position');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `scout_overall_grade` SET TAGS ('dbx_business_glossary_term' = 'Scout Overall Draft Grade');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `scout_overall_grade` SET TAGS ('dbx_value_regex' = '1st_round|2nd_round|3rd_round|4th_round|undrafted|priority_fa');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `shuttle_drill_sec` SET TAGS ('dbx_business_glossary_term' = 'Short Shuttle Drill Time (Seconds)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `sixty_yard_dash_sec` SET TAGS ('dbx_business_glossary_term' = '60-Yard Dash Time (Seconds)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `skipped_drills` SET TAGS ('dbx_business_glossary_term' = 'Skipped Drills');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `standing_reach_inches` SET TAGS ('dbx_business_glossary_term' = 'Standing Reach (Inches)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `ten_yard_split_sec` SET TAGS ('dbx_business_glossary_term' = '10-Yard Split Time (Seconds)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `three_cone_drill_sec` SET TAGS ('dbx_business_glossary_term' = '3-Cone Drill Time (Seconds)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `vertical_jump_inches` SET TAGS ('dbx_business_glossary_term' = 'Vertical Jump (Inches)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `video_session_reference` SET TAGS ('dbx_business_glossary_term' = 'Video Session ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight (Pounds)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_result` ALTER COLUMN `wingspan_inches` SET TAGS ('dbx_business_glossary_term' = 'Wingspan (Inches)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `scouting_report_id` SET TAGS ('dbx_business_glossary_term' = 'Scouting Report ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Media Asset Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `combine_result_id` SET TAGS ('dbx_business_glossary_term' = 'Combine Result Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `draft_id` SET TAGS ('dbx_business_glossary_term' = 'Draft Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `draft_pick_id` SET TAGS ('dbx_business_glossary_term' = 'Draft Evaluation - Draft Pick Id');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `evaluator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `character_grade` SET TAGS ('dbx_business_glossary_term' = 'Character Grade');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `character_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `character_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `combine_event_location` SET TAGS ('dbx_business_glossary_term' = 'Combine Event Location');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `combine_event_name` SET TAGS ('dbx_business_glossary_term' = 'Combine Event Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `comparable_player` SET TAGS ('dbx_business_glossary_term' = 'Comparable Player');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `doping_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Doping Concern Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `doping_concern_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `draft_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Draft Eligibility Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `draft_eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending|hardship_waiver|international');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `draft_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Draft Recommendation');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `draft_recommendation` SET TAGS ('dbx_value_regex' = 'first_round|second_round|third_round|day_three|undrafted_priority|do_not_draft');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `draft_year` SET TAGS ('dbx_business_glossary_term' = 'Draft Year');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'combine_measurables|scout_assessment|video_analysis|pro_day|medical_evaluation');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `injury_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Injury History Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `nil_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Name Image Likeness (NIL) Agreement Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `ovr_grade` SET TAGS ('dbx_business_glossary_term' = 'Overall Grade (OVR)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `projection_tier` SET TAGS ('dbx_business_glossary_term' = 'Projection Tier');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `projection_tier` SET TAGS ('dbx_value_regex' = 'franchise_player|starter|rotation_player|backup|practice_squad|undrafted');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `prospect_position` SET TAGS ('dbx_business_glossary_term' = 'Prospect Position');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `prospect_position_secondary` SET TAGS ('dbx_business_glossary_term' = 'Prospect Secondary Position');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `report_code` SET TAGS ('dbx_business_glossary_term' = 'Scouting Report Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `report_code` SET TAGS ('dbx_value_regex' = '^SCT-[A-Z]{2,6}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Scouting Report Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|archived|superseded');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `sport_code` SET TAGS ('dbx_business_glossary_term' = 'Sport Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `strengths_narrative` SET TAGS ('dbx_business_glossary_term' = 'Strengths Narrative');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `strengths_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `weaknesses_narrative` SET TAGS ('dbx_business_glossary_term' = 'Weaknesses Narrative');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`scouting_report` ALTER COLUMN `weaknesses_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `award_honor_id` SET TAGS ('dbx_business_glossary_term' = 'Award and Honor ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Media Asset Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `game_result_id` SET TAGS ('dbx_business_glossary_term' = 'Game Result Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `nil_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Name Image and Likeness (NIL) Agreement ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `sanction_id` SET TAGS ('dbx_business_glossary_term' = 'Sanction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `achievement_type` SET TAGS ('dbx_business_glossary_term' = 'Achievement Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `achievement_type` SET TAGS ('dbx_value_regex' = 'award|milestone|record|induction|career_event');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `award_category` SET TAGS ('dbx_business_glossary_term' = 'Award Category');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `award_name` SET TAGS ('dbx_business_glossary_term' = 'Award Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `award_rank` SET TAGS ('dbx_business_glossary_term' = 'Award Rank');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `award_season_year` SET TAGS ('dbx_business_glossary_term' = 'Award Season Year');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'active|revoked|under_review|reinstated|pending');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `awarding_body_name` SET TAGS ('dbx_business_glossary_term' = 'Awarding Body Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `awarding_body_type` SET TAGS ('dbx_business_glossary_term' = 'Awarding Body Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `awarding_body_type` SET TAGS ('dbx_value_regex' = 'league_office|governing_body|media|fan_vote|peer_vote|independent');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `career_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Career Lifecycle Stage');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `career_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'debut|active|peak|veteran|retirement|post_career');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `cba_eligibility_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Eligibility Confirmed Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `hall_of_fame_class_year` SET TAGS ('dbx_business_glossary_term' = 'Hall of Fame Class Year');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `hall_of_fame_institution` SET TAGS ('dbx_business_glossary_term' = 'Hall of Fame Institution Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `is_broadcast_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Broadcast Featured Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `is_career_first` SET TAGS ('dbx_business_glossary_term' = 'Is Career First Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `is_nominee` SET TAGS ('dbx_business_glossary_term' = 'Is Nominee Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `is_winner` SET TAGS ('dbx_business_glossary_term' = 'Is Winner Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `jersey_number_at_time` SET TAGS ('dbx_business_glossary_term' = 'Jersey Number at Time of Award');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `nil_commercial_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Name Image and Likeness (NIL) Commercial Value (USD)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `nil_commercial_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Award Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `occurrence_number` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `position_at_time` SET TAGS ('dbx_business_glossary_term' = 'Position at Time of Award');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `previous_record_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Record Value');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Award Revocation Reason');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `selection_method` SET TAGS ('dbx_business_glossary_term' = 'Selection Method');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `selection_method` SET TAGS ('dbx_value_regex' = 'media_vote|player_vote|fan_vote|committee|statistical|automatic');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `sport_code` SET TAGS ('dbx_business_glossary_term' = 'Sport Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `stat_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Statistical Metric Value');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `statistical_context` SET TAGS ('dbx_business_glossary_term' = 'Statistical Context');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `total_votes_cast` SET TAGS ('dbx_business_glossary_term' = 'Total Votes Cast');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `vote_count_received` SET TAGS ('dbx_business_glossary_term' = 'Vote Count Received');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `wada_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'World Anti-Doping Agency (WADA) Compliance Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`award_honor` ALTER COLUMN `wada_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|under_review|suspended|cleared|disqualified');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `salary_cap_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Salary Cap Entry ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `salary_cap_entry_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `salary_cap_entry_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `athlete_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `salary_cap_id` SET TAGS ('dbx_business_glossary_term' = 'Salary Cap Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `salary_cap_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `salary_cap_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_acceleration_date` SET TAGS ('dbx_business_glossary_term' = 'Cap Acceleration Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Cap Entry Reference Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_hit` SET TAGS ('dbx_business_glossary_term' = 'Salary Cap Hit');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_hit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Cap Hold Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_hold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_relief` SET TAGS ('dbx_business_glossary_term' = 'Cap Relief Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_relief` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_year` SET TAGS ('dbx_business_glossary_term' = 'Cap Year');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cap Year End Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `cap_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cap Year Start Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `contract_total_years` SET TAGS ('dbx_business_glossary_term' = 'Contract Total Years');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `contract_year_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Year Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `dead_cap_value` SET TAGS ('dbx_business_glossary_term' = 'Dead Cap Value');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `dead_cap_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Cap Entry Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'active|restructured|voided|dead_cap|cap_hold|historical');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Cap Entry Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `incentive_earned_prior_year` SET TAGS ('dbx_business_glossary_term' = 'Incentive Earned in Prior Year Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `is_cap_hold` SET TAGS ('dbx_business_glossary_term' = 'Is Cap Hold Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `is_dead_cap` SET TAGS ('dbx_business_glossary_term' = 'Is Dead Cap Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `is_restructured` SET TAGS ('dbx_business_glossary_term' = 'Is Restructured Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `league_reported_date` SET TAGS ('dbx_business_glossary_term' = 'League Reported Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `likely_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Likely Incentive Amount (CBA)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `likely_incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cap Entry Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `option_bonus_prorated` SET TAGS ('dbx_business_glossary_term' = 'Prorated Option Bonus');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `option_bonus_prorated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `per_game_roster_bonus` SET TAGS ('dbx_business_glossary_term' = 'Per-Game Roster Bonus');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `per_game_roster_bonus` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `prior_year_incentive_carryover` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Incentive Carryover Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `prior_year_incentive_carryover` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `restructure_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Restructure Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `roster_bonus` SET TAGS ('dbx_business_glossary_term' = 'Roster Bonus');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `roster_bonus` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `signing_bonus_prorated` SET TAGS ('dbx_business_glossary_term' = 'Prorated Signing Bonus');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `signing_bonus_prorated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `signing_bonus_total` SET TAGS ('dbx_business_glossary_term' = 'Signing Bonus Total');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `signing_bonus_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `unlikely_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Unlikely Incentive Amount (CBA)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `unlikely_incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `void_year_flag` SET TAGS ('dbx_business_glossary_term' = 'Void Year Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `workday_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Adaptive Planning Plan ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `workout_bonus` SET TAGS ('dbx_business_glossary_term' = 'Workout Bonus');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`salary_cap_entry` ALTER COLUMN `workout_bonus` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `free_agency_status_id` SET TAGS ('dbx_business_glossary_term' = 'Free Agency Status ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `cba_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Cba Agreement Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Original Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `athlete_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Expiring Contract ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `primary_free_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Original Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `signing_team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Signing Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `transaction_window_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Window Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `accrued_seasons` SET TAGS ('dbx_business_glossary_term' = 'Accrued Seasons');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `arbitration_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Salary Arbitration Eligible Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `arbitration_filing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Salary Arbitration Filing Deadline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `cap_hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Cap Hold Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `cap_hold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `cap_hold_released_flag` SET TAGS ('dbx_business_glossary_term' = 'Salary Cap Hold Released Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `compensation_tier` SET TAGS ('dbx_business_glossary_term' = 'Compensation Tier');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `compensation_tier` SET TAGS ('dbx_value_regex' = 'none|tier_1|tier_2|tier_3|qualifying');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `compensation_tier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `compensation_tier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `draft_pick_compensation_flag` SET TAGS ('dbx_business_glossary_term' = 'Draft Pick Compensation Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `draft_pick_compensation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `draft_pick_compensation_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `fa_open_date` SET TAGS ('dbx_business_glossary_term' = 'Free Agency Open Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `fa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Free Agency (FA) Reference Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `fa_reference_number` SET TAGS ('dbx_value_regex' = '^FA-[A-Z]{2,5}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `fa_type` SET TAGS ('dbx_business_glossary_term' = 'Free Agency (FA) Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `fa_type` SET TAGS ('dbx_value_regex' = 'unrestricted|restricted|exclusive_rights|franchise_tag|transition_tag|waiver');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `franchise_tag_amount` SET TAGS ('dbx_business_glossary_term' = 'Franchise Tag Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `franchise_tag_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `injury_reserve_flag` SET TAGS ('dbx_business_glossary_term' = 'Injured Reserve (IR) Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `league_filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'League Filing Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `negotiation_status` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `nil_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Name Image and Likeness (NIL) Agreement Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Free Agency Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `offer_sheet_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Sheet Received Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `opt_out_deadline` SET TAGS ('dbx_business_glossary_term' = 'Player Option Opt-Out Deadline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `player_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Player Option Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `prior_team_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Team Option Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `qualifying_offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Offer Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `qualifying_offer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `renouncement_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Renouncement Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `right_of_first_refusal_flag` SET TAGS ('dbx_business_glossary_term' = 'Right of First Refusal (ROFR) Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `rofr_exercised_flag` SET TAGS ('dbx_business_glossary_term' = 'Right of First Refusal (ROFR) Exercised Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `rofr_response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Right of First Refusal (ROFR) Response Deadline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Signing Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `signing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Signing Deadline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `tag_designation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Franchise/Transition Tag Designation Deadline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `tender_amount` SET TAGS ('dbx_business_glossary_term' = 'Tender Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `tender_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `tender_deadline` SET TAGS ('dbx_business_glossary_term' = 'Tender Deadline');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `transition_tag_amount` SET TAGS ('dbx_business_glossary_term' = 'Transition Tag Amount');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `transition_tag_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `wada_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'World Anti-Doping Agency (WADA) Clearance Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `wada_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending_review|suspended|ineligible');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`free_agency_status` ALTER COLUMN `years_of_service` SET TAGS ('dbx_business_glossary_term' = 'Years of Service');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `international_cap_id` SET TAGS ('dbx_business_glossary_term' = 'International Cap ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `athlete_athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `athlete_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `broadcast_rights_window_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Rights Window Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `competition_tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Competition ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Match ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'National Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `international_federation_id` SET TAGS ('dbx_business_glossary_term' = 'International Federation Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `match_fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Match ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `national_team_franchise_id` SET TAGS ('dbx_business_glossary_term' = 'National Team ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `tax_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Competition ID');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `whereabouts_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Whereabouts Filing Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `age_at_cap` SET TAGS ('dbx_business_glossary_term' = 'Athlete Age at Cap');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `assists_recorded` SET TAGS ('dbx_business_glossary_term' = 'Assists Recorded');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `cap_number` SET TAGS ('dbx_business_glossary_term' = 'International Cap Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `cap_status` SET TAGS ('dbx_business_glossary_term' = 'International Cap Status');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `cap_status` SET TAGS ('dbx_value_regex' = 'confirmed|provisional|disputed|withdrawn|pending_ratification');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `competition_name` SET TAGS ('dbx_business_glossary_term' = 'Competition Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `competition_type` SET TAGS ('dbx_business_glossary_term' = 'Competition Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `eligibility_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Confirmed Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `goals_scored` SET TAGS ('dbx_business_glossary_term' = 'Goals Scored');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `home_away_indicator` SET TAGS ('dbx_business_glossary_term' = 'Home/Away Indicator');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `home_away_indicator` SET TAGS ('dbx_value_regex' = 'home|away|neutral');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `is_captain` SET TAGS ('dbx_business_glossary_term' = 'Captain Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `is_debut` SET TAGS ('dbx_business_glossary_term' = 'International Debut Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `match_date` SET TAGS ('dbx_business_glossary_term' = 'Match Date');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `match_notes` SET TAGS ('dbx_business_glossary_term' = 'Match Notes');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `match_result` SET TAGS ('dbx_business_glossary_term' = 'Match Result');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `match_result` SET TAGS ('dbx_value_regex' = 'win|loss|draw|no_result');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `minutes_played` SET TAGS ('dbx_business_glossary_term' = 'Minutes Played');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `nationality_basis` SET TAGS ('dbx_business_glossary_term' = 'Nationality Eligibility Basis');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `nationality_basis` SET TAGS ('dbx_value_regex' = 'birth|parentage|naturalisation|residency|association_eligibility');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `nationality_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `nationality_basis` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `nil_agreement_active` SET TAGS ('dbx_business_glossary_term' = 'Name Image and Likeness (NIL) Agreement Active Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `opponent_country_code` SET TAGS ('dbx_business_glossary_term' = 'Opponent Country Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `opponent_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `opponent_score` SET TAGS ('dbx_business_glossary_term' = 'Opponent Score');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `opponent_team_name` SET TAGS ('dbx_business_glossary_term' = 'Opponent National Team Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `points_scored` SET TAGS ('dbx_business_glossary_term' = 'Points Scored');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `position_played` SET TAGS ('dbx_business_glossary_term' = 'Position Played');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `red_cards` SET TAGS ('dbx_business_glossary_term' = 'Red Cards Received');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `shirt_number` SET TAGS ('dbx_business_glossary_term' = 'Shirt Number');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `sport_code` SET TAGS ('dbx_business_glossary_term' = 'Sport Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `sport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `substitution_minute` SET TAGS ('dbx_business_glossary_term' = 'Substitution Minute');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Type');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'starter|substitute_on|substitute_off|unused_substitute|did_not_play');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `team_score` SET TAGS ('dbx_business_glossary_term' = 'National Team Score');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Country Code');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `wada_test_conducted` SET TAGS ('dbx_business_glossary_term' = 'World Anti-Doping Agency (WADA) Test Conducted Flag');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`international_cap` ALTER COLUMN `yellow_cards` SET TAGS ('dbx_business_glossary_term' = 'Yellow Cards Received');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `supervising_agent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `disciplinary_action_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `office_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `professional_liability_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `professional_liability_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agent` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `parent_agency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `annual_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`agency` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` ALTER COLUMN `combine_event_id` SET TAGS ('dbx_business_glossary_term' = 'Combine Event Identifier');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` ALTER COLUMN `parent_combine_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` ALTER COLUMN `event_coordinator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` ALTER COLUMN `event_coordinator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` ALTER COLUMN `event_coordinator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`athlete`.`combine_event` ALTER COLUMN `event_coordinator_phone` SET TAGS ('dbx_pii_phone' = 'true');
