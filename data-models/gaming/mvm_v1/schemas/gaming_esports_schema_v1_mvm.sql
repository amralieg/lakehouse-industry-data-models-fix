-- Schema for Domain: esports | Business: Gaming | Version: v1_mvm
-- Generated on: 2026-05-08 09:46:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`esports` COMMENT 'Owns all esports league, tournament, and competitive event data including team rosters, player contracts, bracket structures, match results, prize pool management, broadcast rights, and sponsorship agreements. Tracks CCU/PCU for live events, league standings, and esports revenue streams. Supports both first-party operated leagues and third-party tournament organizer relationships.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`league` (
    `league_id` BIGINT COMMENT 'Unique identifier for the esports league. Primary key.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: League age restrictions and broadcast eligibility rules are governed by the applicable age rating certificate for the game/jurisdiction. age_restriction is a denormalized value from age_rating_cert; l',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Leagues operate as financial entities collecting broadcast rights fees, sponsorship revenue, and entry fees. A billing account link enables league-level revenue reconciliation, revenue share distribut',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Competitive seasons align with major content releases for balance patches, new maps, and competitive-specific content. Live ops teams coordinate league schedules with content roadmaps. Critical for co',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Leagues are operated under a publisher/developers platform account. Revenue share, SDK entitlements, and platform compliance for league operations are tracked against the developer account. Publisher',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to title.franchise. Business justification: Esports leagues are organized around a game franchise (e.g., Call of Duty League, Overwatch League). Franchise-level esports operations, brand licensing compliance, cross-title league management, and ',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this league is organized for (e.g., League of Legends, Valorant, Fortnite).',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Esports leagues require master IP licensing agreements with game publishers/studios to operate competitive circuits, defining usage rights, revenue share, and prize pool terms. Essential for league op',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Leagues operate under specific regulatory jurisdictions governing licensing, age rating enforcement, data protection, and prize pool regulations. Essential for regulatory filings, compliance audits, a',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Leagues operate within a specific network region for latency SLA enforcement, data residency compliance, and broadcast infrastructure routing. League already has server_fleet_id but lacks a direct net',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Leagues require persistent infrastructure allocation across entire seasons (months/years). Operations teams provision dedicated server fleets for league play to ensure consistent performance, isolated',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Professional leagues operate on specific storefronts (PlayStation Network, Xbox Live, Steam) for game distribution, player eligibility verification, and platform-specific competitive rules. Essential ',
    `broadcast_language` STRING COMMENT 'Primary language(s) for league broadcasts, using ISO 639 language codes (e.g., en, es, ko, zh). Multiple languages separated by commas.. Valid values are `^[a-z]{2,3}(,[a-z]{2,3})*$`',
    `broadcast_rights_holder` STRING COMMENT 'Name of the media company or platform holding exclusive or primary broadcast rights for the league (e.g., Twitch, YouTube Gaming, ESPN).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the league record was first created in the system.',
    `format` STRING COMMENT 'Competitive format structure of the league (round robin, single elimination, double elimination, Swiss, group stage, hybrid).. Valid values are `round_robin|single_elimination|double_elimination|swiss|group_stage|hybrid`',
    `league_code` STRING COMMENT 'Short alphanumeric code or abbreviation for the league (e.g., LCS, VCT, RLCS).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `league_name` STRING COMMENT 'Official name of the esports league (e.g., League Championship Series, Valorant Champions Tour).',
    `league_status` STRING COMMENT 'Current operational status of the league (active, inactive, suspended, planned, archived).. Valid values are `active|inactive|suspended|planned|archived`',
    `league_tier` STRING COMMENT 'Competitive tier classification of the league (T1 for top-tier professional, T2 for secondary professional, T3 for semi-professional, amateur, grassroots).. Valid values are `T1|T2|T3|amateur|grassroots`',
    `match_count` STRING COMMENT 'Total number of matches scheduled or played in the current or most recent season.',
    `organizer_name` STRING COMMENT 'Name of the organization or entity responsible for operating the league.',
    `organizer_type` STRING COMMENT 'Type of organizer operating the league (first-party operated by Gaming, third-party external organizer, licensed partner, co-organized).. Valid values are `first_party|third_party|licensed|co_organized`',
    `patch_version_end` STRING COMMENT 'Game patch version at the end of the season (e.g., 13.8, 7.12). Tracks game evolution during the competitive season.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `patch_version_start` STRING COMMENT 'Game patch version at the start of the season (e.g., 13.1, 7.04). Defines the game balance and feature set for competitive play.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `prize_pool_ceiling_usd` DECIMAL(18,2) COMMENT 'Maximum total prize pool amount allocated for the league across all seasons, in United States Dollars (USD).',
    `qualification_slots` STRING COMMENT 'Number of team slots that qualify from this season to the next tier or championship tournament.',
    `relegation_slots` STRING COMMENT 'Number of team slots that are relegated from this season to a lower tier.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of league revenue shared with teams or organizers. Business-confidential financial term.',
    `season_end_date` DATE COMMENT 'Official end date of the season when competitive play concludes.',
    `season_name` STRING COMMENT 'Name or label for the current or most recent season of the league (e.g., 2024 Spring Split, Season 5).',
    `season_ordinal` STRING COMMENT 'Sequential number of the season within the league (1 for first season, 2 for second, etc.).',
    `season_prize_pool_usd` DECIMAL(18,2) COMMENT 'Total prize pool allocated for this specific season, in United States Dollars (USD).',
    `season_split` STRING COMMENT 'Seasonal split or period designation for the season (spring, summer, fall, winter, annual for year-long, none if not applicable).. Valid values are `spring|summer|fall|winter|annual|none`',
    `season_start_date` DATE COMMENT 'Official start date of the season when competitive play begins.',
    `season_status` STRING COMMENT 'Current status of the season (scheduled, in progress, completed, cancelled, postponed).. Valid values are `scheduled|in_progress|completed|cancelled|postponed`',
    `sponsorship_tier` STRING COMMENT 'Highest tier of sponsorship secured for the league (platinum, gold, silver, bronze, none).. Valid values are `platinum|gold|silver|bronze|none`',
    `target_ccu` STRING COMMENT 'Target number of concurrent viewers/users for live league events. CCU (Concurrent Users) represents the number of users simultaneously watching or participating at any given moment.',
    `target_pcu` STRING COMMENT 'Target peak concurrent viewers/users for live league events. PCU (Peak Concurrent Users) represents the maximum number of users simultaneously watching or participating during the highest traffic moment.',
    `team_count` STRING COMMENT 'Number of teams participating in the current or most recent season.',
    `updated_by` STRING COMMENT 'User or system identifier that last modified the league record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the league record was last modified in the system.',
    `created_by` STRING COMMENT 'User or system identifier that created the league record.',
    CONSTRAINT pk_league PRIMARY KEY(`league_id`)
) COMMENT 'Master record for an esports league operated by Gaming or a licensed third-party organizer, encompassing both league identity and season-level scheduling. At league level: name, game title reference, format, tier (T1/T2/T3), region, prize pool ceiling, broadcast rights holder, sponsorship tier, CCU/PCU targets, and operational status. At season detail level: season name, ordinal number, split (Spring/Summer/Fall/Winter), start/end dates, patch version range, prize pool allocation, qualification slots to next tier, relegation slots, and season status. Single source of truth for all league identity, configuration, and seasonal competitive scheduling. Seasons are the primary container for standings and match scheduling within league play.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`tournament` (
    `tournament_id` BIGINT COMMENT 'Unique identifier for the esports tournament or competitive event. Primary key.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Tournament participation and broadcast eligibility are governed by the applicable age rating certificate (PEGI/ESRB). Compliance teams enforce age-gating rules per tournament; certification_body and c',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Tournaments collect entry fees and manage prize disbursements through a dedicated billing account. Finance teams track tournament-level cash flow, entry fee collection, and prize fund escrow — requiri',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Tournaments must track the exact game build/patch used for competitive integrity, ruleset enforcement, dispute resolution, and post-event analysis. Essential for esports operations where build version',
    `cert_submission_id` BIGINT COMMENT 'Foreign key linking to platform.platform_cert_submission. Business justification: Esports tournaments must run on a platform-certified game build for competitive integrity and platform compliance. Tournament operators reference the cert submission to confirm the approved build vers',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Tournament registration collects player personal data (name, contact, performance telemetry) governed by a specific consent policy under GDPR/CCPA. Compliance officers must track which consent policy ',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Tournament operations require knowing which content release was live during the event for competitive integrity audits, replay validity, and rules enforcement. Esports ops teams track content release ',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Tournaments are organized under a developer/publishers platform account for SDK access, revenue share, and platform compliance verification. Platform operators need to identify which developer accoun',
    `esports_season_id` BIGINT COMMENT 'Foreign key linking to esports.esports_season. Business justification: A tournament belongs to a specific competitive season within a league. While tournament.league_id exists, there is no direct FK to esports_season, requiring a 2-hop derivation (tournament -> league <-',
    `event_id` BIGINT COMMENT 'Foreign key linking to community.community_event. Business justification: Tournaments are paired with community events (fan watch parties, viewer participation, in-game tie-ins). Community managers create community_event records anchored to specific tournaments for fan enga',
    `forum_id` BIGINT COMMENT 'Foreign key linking to community.forum. Business justification: Tournaments maintain dedicated forums for participant communication, rule clarifications, and fan discussion. Essential for tournament operations and community engagement tracking.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this tournament is organized (e.g., specific competitive game).',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Tournaments require IP licensing agreements for game usage rights, prize pool approval, broadcast permissions, and revenue sharing with IP holders. Critical for tournament authorization and compliance',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Tournaments must comply with local gambling laws for prize pools, age restrictions, participant eligibility, and data protection. Required for regulatory approval processes, tax compliance, and legal ',
    `league_id` BIGINT COMMENT 'Reference to the parent esports league if this tournament is part of a league season structure. Null for standalone tournaments.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Tournaments are hosted in specific network regions for latency optimization, data residency compliance, and player accessibility. Region determines available infrastructure, CDN topology, and legal ju',
    `patch_id` BIGINT COMMENT 'Foreign key linking to content.patch. Business justification: Tournaments are run on a specific content patch governing balance and bug state. Esports operations track the content-layer patch (DLC, content drops) separately from platform patch for dispute resolu',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Tournaments are subject to specific regulatory obligations: anti-match-fixing regulations, prize pool disclosure rules, age verification mandates. Tournament operators must reference the governing reg',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Tournaments require dedicated server fleet capacity planning and allocation. Operations teams must reserve infrastructure resources for tournament duration, track costs, and ensure SLA compliance. Ess',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Tournaments require storefront context for game version control, DLC/content requirements, and player account verification. Critical for platform-exclusive tournaments and ensuring all competitors hav',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the tournament concluded. Null if not yet completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the tournament competition commenced. Null if not yet started.',
    `broadcast_flag` BOOLEAN COMMENT 'Indicates whether the tournament is scheduled for live broadcast or streaming (true) or not (false).',
    `broadcast_platform` STRING COMMENT 'Primary streaming or broadcast platform(s) where the tournament will be aired (e.g., Twitch, YouTube Gaming, proprietary platform). Null if not broadcast.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tournament record was first created in the system.',
    `entry_fee_amount` DECIMAL(18,2) COMMENT 'Entry fee amount required for teams/players to register for the tournament. Zero for free-to-enter tournaments.',
    `entry_fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the entry fee (e.g., USD, EUR, GBP). Null if entry is free.. Valid values are `^[A-Z]{3}$`',
    `format` STRING COMMENT 'Competitive format structure of the tournament defining how teams/players advance (single-elimination, double-elimination, Swiss system, round-robin, group stage, bracket, or hybrid). [ENUM-REF-CANDIDATE: single_elimination|double_elimination|swiss|round_robin|group_stage|bracket|hybrid — 7 candidates stripped; promote to reference product]',
    `max_team_capacity` STRING COMMENT 'Maximum number of teams or individual players allowed to participate in the tournament.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the tournament record was last modified or updated.',
    `organizer_type` STRING COMMENT 'Classification of the tournament organizer: first-party (operated by game publisher/studio), third-party (external tournament organizer), or community (grassroots/player-organized).. Valid values are `first_party|third_party|community`',
    `peak_ccu` STRING COMMENT 'Peak concurrent users (viewers and participants) recorded during the tournament broadcast or live event. Null if not yet started or not tracked.',
    `prize_pool_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the prize pool (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `prize_pool_total` DECIMAL(18,2) COMMENT 'Total monetary prize pool amount available for distribution to tournament winners and top performers.',
    `registered_team_count` STRING COMMENT 'Current number of teams or players registered for the tournament.',
    `registration_close_date` DATE COMMENT 'Date when team/player registration closes for the tournament.',
    `registration_open_date` DATE COMMENT 'Date when team/player registration opens for the tournament.',
    `rules_document_url` STRING COMMENT 'URL link to the official tournament rules and regulations document hosted on internal or external platform.',
    `scheduled_end_date` DATE COMMENT 'Planned date when the tournament is scheduled to conclude, including finals and award ceremonies.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the tournament is scheduled to begin competition.',
    `sponsorship_tier` STRING COMMENT 'Highest sponsorship tier secured for the tournament, indicating level of external brand partnership and funding.. Valid values are `none|bronze|silver|gold|platinum|title`',
    `total_viewership` BIGINT COMMENT 'Total cumulative viewership count across all broadcast platforms for the tournament duration. Null if not yet completed or not tracked.',
    `tournament_code` STRING COMMENT 'Short alphanumeric code used for internal tracking and external identification of the tournament (e.g., SPRING24, GLOBAL_INV_2024).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `tournament_description` STRING COMMENT 'Detailed description of the tournament including objectives, special rules, and promotional messaging for players and spectators.',
    `tournament_name` STRING COMMENT 'Official name of the tournament as displayed to players and spectators (e.g., Spring Championship 2024, Global Invitational).',
    `tournament_status` STRING COMMENT 'Current lifecycle status of the tournament indicating its operational state. [ENUM-REF-CANDIDATE: draft|scheduled|registration_open|registration_closed|in_progress|completed|cancelled|postponed — 8 candidates stripped; promote to reference product]',
    `venue_location` STRING COMMENT 'Physical location or city where the LAN or hybrid tournament is hosted. Null for online-only tournaments.',
    `venue_type` STRING COMMENT 'Physical or virtual venue type where the tournament is conducted: online (remote play), LAN (Local Area Network in-person event), or hybrid (combination).. Valid values are `online|lan|hybrid`',
    CONSTRAINT pk_tournament PRIMARY KEY(`tournament_id`)
) COMMENT 'Master record for a discrete esports tournament or competitive event, which may be standalone or nested within a league season. Tracks tournament name, format (single-elimination, double-elimination, Swiss, round-robin), game title, venue type (online/LAN), scheduled start/end dates, registration open/close dates, max team capacity, prize pool total, entry fee, organizer type (first-party/third-party), certification status, and broadcast flag.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`team` (
    `team_id` BIGINT COMMENT 'Unique identifier for the esports team. Primary key for the esports_team product. Serves as the identity anchor for all team-level relationships including rosters, contracts, standings, sponsorships, transfers, and tournament registrations.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Esports teams have billing accounts for receiving prize money, paying entry fees, and managing sponsorship transactions. Finance teams require this link for team-level financial reporting, payment pro',
    `forum_id` BIGINT COMMENT 'Foreign key linking to community.forum. Business justification: Professional teams maintain official forums for fan interaction, roster announcements, and merchandise. Standard practice for team community management.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Teams operate under home jurisdiction regulations governing employment law, tax withholding for player salaries, and data protection for player personal data. Essential for contract compliance, regula',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Teams as organizations must comply with internal policies (franchise code of conduct, anti-doping policy, social media policy). Linking teams to the governing policy version enables compliance teams t',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the primary game title that this team competes in (e.g., League of Legends, Counter-Strike, Valorant). Teams may compete in multiple titles, but this identifies their flagship game.',
    `contact_email` STRING COMMENT 'Primary business contact email address for the team organization. Used for official league communications, contract negotiations, and tournament coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary business contact phone number for the team organization. Used for urgent communications and operational coordination.',
    `contract_expiry_date` DATE COMMENT 'The date when the teams current league participation contract or franchise agreement expires. Used for contract renewal planning and partnership lifecycle management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this team record was first created in the Gaming esports system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `current_world_ranking` STRING COMMENT 'The teams current global ranking position within their primary game title. Lower numbers indicate higher ranking (1 is best). Used for seeding, tournament invitations, and performance tracking.',
    `discord_server_code` STRING COMMENT 'Official Discord server identifier for the teams community. Used for fan engagement, community management, and player-fan interaction tracking.',
    `founding_date` DATE COMMENT 'The date when the esports team or organization was officially founded or established. Used for historical tracking and legacy analysis.',
    `franchise_fee_paid` DECIMAL(18,2) COMMENT 'The total franchise fee paid by the organization to secure a permanent league slot. Tracked in USD. Highly confidential financial data used for revenue recognition and partnership valuation.',
    `general_manager_name` STRING COMMENT 'Full name of the teams general manager or director of esports operations. Responsible for roster decisions, contracts, and organizational strategy.',
    `head_coach_name` STRING COMMENT 'Full name of the teams current head coach or manager. Key personnel information for broadcasts, media, and organizational tracking.',
    `headquarters_address` STRING COMMENT 'Physical address of the teams headquarters, training facility, or primary business location. Used for legal correspondence, contract execution, and facility management.',
    `headquarters_city` STRING COMMENT 'City where the teams headquarters or primary facility is located. Used for geographic analysis and regional market segmentation.',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the teams headquarters location. Used for shipping, logistics, and geographic analysis.',
    `is_franchise_team` BOOLEAN COMMENT 'Boolean flag indicating whether this team holds a franchise slot in a Gaming-operated franchised league. Franchise teams have permanent league positions and revenue sharing agreements.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the team has been officially verified by Gaming as a legitimate competitive organization. Verified teams have completed compliance checks and meet league standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this team record was last updated or modified. Used for change tracking, data freshness monitoring, and audit trails.',
    `league_championships` STRING COMMENT 'Total number of league championships won by the team in Gaming-operated leagues. Distinct from tournament wins, represents seasonal league titles.',
    `organization_legal_name` STRING COMMENT 'The legal registered name of the organization or entity that owns and operates the esports team. Used for contracts, prize pool disbursements, and regulatory compliance.',
    `regional_ranking` STRING COMMENT 'The teams current ranking position within their home region. Used for regional tournament seeding and qualification tracking.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of league revenue that this team is entitled to receive as part of their franchise or partnership agreement. Confidential financial term used for revenue distribution calculations.',
    `roster_lock_date` DATE COMMENT 'The date when the current roster lock period began. Used to enforce roster change restrictions during tournament phases and calculate lock duration.',
    `roster_lock_status` BOOLEAN COMMENT 'Boolean flag indicating whether the teams roster is currently locked for tournament play. True means no roster changes are allowed during the lock period (typically during active tournament phases), False means roster changes are permitted.',
    `roster_size` STRING COMMENT 'The current number of active players on the teams roster. Used for roster compliance checks against league minimum and maximum roster size rules.',
    `sponsorship_tier` STRING COMMENT 'Classification of the teams sponsorship level or tier within Gaming-operated leagues. Higher tiers indicate more valuable sponsorship packages and revenue sharing agreements. Used for revenue allocation and partnership management.. Valid values are `platinum|gold|silver|bronze|unsponsored`',
    `tag` STRING COMMENT 'Short alphanumeric abbreviation or tag for the team (e.g., C9, TL, FNC). Used in scoreboards, brackets, and compact displays. Typically 2-5 uppercase characters.. Valid values are `^[A-Z0-9]{2,5}$`',
    `team_name` STRING COMMENT 'The full display name of the esports team or organization (e.g., Cloud9, Team Liquid, FaZe Clan). This is the primary human-readable identifier used in broadcasts, standings, and marketing materials.',
    `team_status` STRING COMMENT 'Current operational status of the esports team. Active teams are competing, inactive teams are not currently competing but still exist, disbanded teams have permanently ceased operations, suspended teams are temporarily barred from competition, on_hiatus teams are taking a break.. Valid values are `active|inactive|disbanded|suspended|on_hiatus`',
    `tier_classification` STRING COMMENT 'Classification of the teams competitive tier or level (Tier 1 for top-level professional teams, Tier 2/3 for semi-professional, Academy for development teams, Amateur for grassroots). Determines tournament eligibility and prize pool access.. Valid values are `tier_1|tier_2|tier_3|academy|amateur|professional`',
    `total_prize_money_won` DECIMAL(18,2) COMMENT 'Cumulative total prize money won by the team across all Gaming-operated tournaments and leagues. Tracked in USD. Used for performance analytics, team valuation, and historical achievement tracking.',
    `tournament_wins` STRING COMMENT 'Total number of tournament championships won by the team in Gaming-operated competitions. Key performance indicator for team success and legacy.',
    `twitch_channel` STRING COMMENT 'Official Twitch channel name for the team. Used for live streaming, broadcast rights tracking, and viewership analytics.',
    `twitter_handle` STRING COMMENT 'Official Twitter/X handle for the team (e.g., @Cloud9). Used for social media tracking, engagement analytics, and community management.. Valid values are `^@[A-Za-z0-9_]{1,15}$`',
    `verification_date` DATE COMMENT 'The date when the team was officially verified by Gaming. Used for compliance tracking and audit trails.',
    `website_url` STRING COMMENT 'Official website URL for the esports team or organization. Primary digital presence for fans, sponsors, and media.',
    `youtube_channel` STRING COMMENT 'Official YouTube channel name or handle for the team. Used for content distribution, VOD hosting, and video engagement tracking.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Master record for a competitive esports team or organization participating in Gaming-operated leagues and tournaments. Stores team name, tag/abbreviation, organization legal name, region, home country, founding date, tier classification, active game titles, social media handles, logo asset reference, sponsorship tier, and current roster lock status. Identity anchor for all team-level relationships including rosters, contracts, standings, sponsorships, transfers, and tournament registrations.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`roster` (
    `roster_id` BIGINT COMMENT 'Unique identifier for the esports team roster entry. Primary key for the roster product.',
    `esports_season_id` BIGINT COMMENT 'Reference to the specific league season or tournament edition for which this roster is active. Links to the season master data.',
    `league_id` BIGINT COMMENT 'Reference to the esports league or competitive circuit for which this roster is registered. Links to the league master data.',
    `player_account_id` BIGINT COMMENT 'Reference to the professional esports player assigned to this roster position. Links to the player master data.',
    `player_contract_id` BIGINT COMMENT 'Reference to the player contract that governs the terms of this roster assignment. Links to the contract master data for salary, duration, and performance clauses.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Roster eligibility is governed by specific regulatory obligations: work permit requirements, minor player protections, residency rules. Compliance teams run roster eligibility checks against the appli',
    `team_id` BIGINT COMMENT 'Reference to the team the player was rostered with immediately before joining this team. Nullable for players entering professional competition for the first time. Links to the team master data.',
    `roster_team_id` BIGINT COMMENT 'Reference to the esports team that this roster entry belongs to. Links to the team master data.',
    `age_at_roster_lock` STRING COMMENT 'The players age in years at the time of roster lock. Used for age eligibility validation and compliance with league minimum/maximum age requirements.',
    `announcement_date` DATE COMMENT 'The date when the roster change or player signing was officially announced to the public. Used for tracking announcement timing and media coordination.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this roster entry was officially approved by the league or team management. Used for audit trail and compliance verification.',
    `approved_by` STRING COMMENT 'The name or identifier of the league official or team manager who approved this roster entry. Used for accountability and compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this roster record was first created in the system. Used for data lineage and audit purposes.',
    `departure_date` DATE COMMENT 'The date when the player officially left the team roster. Nullable for active roster members. Marks the end of the players tenure with the team for this roster period.',
    `eligibility_status` STRING COMMENT 'The current eligibility status of the player for competitive play in this league or tournament. Eligible players can compete, ineligible players cannot, suspended players are temporarily barred, pending_review indicates ongoing investigation, restricted indicates conditional eligibility, and retired indicates the player has withdrawn from competition.. Valid values are `eligible|ineligible|suspended|pending_review|restricted|retired`',
    `in_game_name` STRING COMMENT 'The players official in-game alias or gamertag used during competitive matches and broadcasts. This is the name displayed to viewers and used for player identification in match statistics.',
    `is_academy_promotion` BOOLEAN COMMENT 'Boolean flag indicating whether the player was promoted from the organizations academy or development team (true) or acquired externally (false). Used for tracking talent development pipeline effectiveness.',
    `is_captain` BOOLEAN COMMENT 'Boolean flag indicating whether the player is designated as the team captain (true) or not (false). The captain typically has leadership responsibilities and represents the team in official matters.',
    `is_starter` BOOLEAN COMMENT 'Boolean flag indicating whether the player is designated as a starting lineup member (true) or a substitute/reserve (false). Determines default match participation.',
    `jersey_number` STRING COMMENT 'The official jersey or uniform number assigned to the player for identification during broadcasts and live events. Used for merchandising and fan engagement.',
    `join_date` DATE COMMENT 'The date when the player officially joined the team roster. Marks the start of the players tenure with the team for this roster period.',
    `lock_date` DATE COMMENT 'The date when the roster was locked for the league or tournament, after which no changes are permitted without league approval. Critical for competitive integrity and compliance with league rules.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this roster record was last modified in the system. Used for tracking changes and data freshness.',
    `nationality` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code representing the players nationality. Used for regional eligibility validation, import slot tracking, and compliance with league residency rules.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional context about the roster entry, such as special conditions, trial periods, or administrative notes. Used by team management and league officials.',
    `residency_status` STRING COMMENT 'The residency classification of the player for league import slot rules. Resident players count as local talent, import players occupy limited foreign slots, exempt players have special status, and pending indicates residency determination is in progress.. Valid values are `resident|import|exempt|pending`',
    `roster_role` STRING COMMENT 'The competitive role or position assigned to the player within the team structure. IGL (In-Game Leader) directs strategy, support provides utility, carry focuses on damage output, flex adapts to multiple roles, substitute is a backup player, and coach provides strategic guidance.. Valid values are `IGL|support|carry|flex|substitute|coach`',
    `roster_status` STRING COMMENT 'The current operational status of this roster entry. Active indicates the player is available for competition, inactive indicates temporary unavailability, on_loan indicates the player is temporarily assigned to another team, injured_reserve indicates medical leave, and suspended indicates disciplinary action.. Valid values are `active|inactive|on_loan|injured_reserve|suspended`',
    `transfer_fee_amount` DECIMAL(18,2) COMMENT 'The monetary amount paid to acquire the player from their previous team, if applicable. Nullable for free agent signings or internal promotions. Expressed in the organizations reporting currency.',
    `transfer_fee_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the transfer fee amount. Nullable if no transfer fee was paid.. Valid values are `^[A-Z]{3}$`',
    `version` STRING COMMENT 'Sequential version number for tracking roster changes within a season. Increments with each roster modification to maintain historical audit trail.',
    CONSTRAINT pk_roster PRIMARY KEY(`roster_id`)
) COMMENT 'Tracks the active and historical roster composition of an esports team for a specific league season or tournament. Records player reference, team reference, role (IGL, support, carry, flex, substitute), jersey number, join date, departure date, roster lock date, eligibility status, and nationality for regional compliance. Captures the M:N relationship between teams and players over time, enabling roster lock enforcement and regional eligibility validation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`player_contract` (
    `player_contract_id` BIGINT COMMENT 'Unique identifier for the esports player contract record. Primary key.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Player contracts involve processing personal data (performance metrics, biometrics, image rights) under GDPR/CCPA. The consent policy governing data processing must be referenced on the contract to en',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Player contracts are game-title-specific (a player is contracted to compete in a named title). Contract management, transfer window eligibility, and regulatory compliance (e.g., player age restriction',
    `parent_contract_player_contract_id` BIGINT COMMENT 'Reference to the original contract if this is a loan or amendment contract, establishing the contract hierarchy.',
    `player_account_id` BIGINT COMMENT 'Reference to the esports player who is party to this contract.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Player contracts must comply with internal policies (anti-doping, code of conduct, streaming restrictions). Linking to the specific policy version enables compliance audits to verify which policy gove',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Contracts must comply with specific regulatory obligations including employment law, minor protection rules, data retention requirements, and contract disclosure obligations. Required for contract tem',
    `team_id` BIGINT COMMENT 'Reference to the esports team or organization that employs the player under this contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews for an additional term upon expiration if not explicitly terminated by either party.',
    `buyout_clause_amount` DECIMAL(18,2) COMMENT 'The monetary amount required for another team to acquire the player before contract expiration, releasing the player from current obligations.',
    `buyout_clause_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the buyout clause amount.. Valid values are `^[A-Z]{3}$`',
    `confidentiality_terms` STRING COMMENT 'Non-disclosure obligations protecting team strategies, roster changes, financial information, and other proprietary business information.',
    `contract_language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language in which the contract is written and legally binding.. Valid values are `^[A-Z]{3}$`',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the player contract, used for legal and operational reference.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the player contract. Draft indicates unsigned or pending approval; active indicates in force; suspended indicates temporarily paused; terminated indicates ended before expiration; expired indicates naturally ended; completed indicates fulfilled all terms.. Valid values are `draft|active|suspended|terminated|expired|completed`',
    `contract_type` STRING COMMENT 'Classification of the contract governing the player-team relationship. Standard contracts are full-time competitive agreements; loan contracts are temporary assignments from another team; trial contracts are probationary periods; academy contracts are for developmental rosters; substitute contracts are for backup players; free agent contracts are short-term engagements.. Valid values are `standard|loan|trial|academy|substitute|free_agent`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'The agreed-upon mechanism for resolving contractual disputes between player and team, including arbitration, mediation, litigation, or league-administered tribunal.. Valid values are `arbitration|mediation|litigation|league_tribunal`',
    `end_date` DATE COMMENT 'The date on which the contract expires or is scheduled to terminate. Nullable for indefinite contracts.',
    `equipment_provided_flag` BOOLEAN COMMENT 'Indicates whether the team provides gaming equipment (PC, peripherals, etc.) to the player as part of the contract.',
    `exclusivity_clause` STRING COMMENT 'Terms requiring the player to compete exclusively for this team and prohibiting simultaneous contracts with other esports organizations.',
    `health_insurance_provided_flag` BOOLEAN COMMENT 'Indicates whether the team provides health insurance coverage for the player as part of the contract benefits.',
    `housing_provided_flag` BOOLEAN COMMENT 'Indicates whether the team provides housing accommodations for the player as part of the contract terms.',
    `image_rights_terms` STRING COMMENT 'Terms governing the use of the players name, likeness, and image in marketing, merchandise, and promotional materials, including revenue sharing and approval rights.',
    `non_compete_terms` STRING COMMENT 'Textual description of restrictions on the player competing for rival teams or in competing leagues during and after the contract period.',
    `notes` STRING COMMENT 'Free-text field for additional contract details, special clauses, or internal annotations not captured in structured fields.',
    `notice_period_days` STRING COMMENT 'The number of days advance notice required by either party to terminate the contract without penalty.',
    `performance_bonus_structure` STRING COMMENT 'Textual description of the performance-based bonus terms, including tournament placement bonuses, MVP awards, and other achievement-based incentives.',
    `relocation_assistance_amount` DECIMAL(18,2) COMMENT 'Monetary amount provided to the player to cover relocation expenses when joining the team, if applicable.',
    `renewal_term_months` STRING COMMENT 'The duration in months for which the contract will automatically renew if auto-renewal is enabled.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of team revenue (e.g., prize winnings, sponsorship, merchandise) that the player is entitled to receive under this contract. Expressed as a decimal (e.g., 5.00 for 5%).',
    `salary_amount` DECIMAL(18,2) COMMENT 'The base annual salary paid to the player under this contract, excluding bonuses and revenue share.',
    `salary_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `signing_date` DATE COMMENT 'The date on which the contract was signed by all parties, establishing legal commitment.',
    `start_date` DATE COMMENT 'The date on which the contract becomes effective and the player is officially bound to the team.',
    `streaming_rights_restrictions` STRING COMMENT 'Contractual limitations on the players ability to stream gameplay, including platform exclusivity, content restrictions, and revenue sharing for streaming income.',
    `termination_date` DATE COMMENT 'The actual date on which the contract was terminated early, if applicable. Null if contract was not terminated early.',
    `termination_reason` STRING COMMENT 'Explanation for early contract termination, including mutual agreement, breach of contract, performance issues, or organizational restructuring.',
    `tournament_participation_requirements` STRING COMMENT 'Contractual obligations regarding minimum tournament participation, practice schedules, and competitive availability requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was last modified in the system.',
    CONSTRAINT pk_player_contract PRIMARY KEY(`player_contract_id`)
) COMMENT 'Esports player contract record governing the competitive relationship between a player and an esports team or organization. Captures contract type (standard, loan, trial), start date, end date, salary, performance bonus structure, revenue share percentage, buyout clause amount, non-compete terms, streaming rights restrictions, image rights, governing jurisdiction, contract status, and signing date. Owned by esports domain as competitive contracts are distinct from general workforce contracts.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`esports_season` (
    `esports_season_id` BIGINT COMMENT 'Unique identifier for the esports season. Primary key for the season entity.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Competitive seasons coordinate with content releases for seasonal themes, balance patches, and new competitive content. Live ops teams align season schedules with content roadmaps for player engagemen',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this season is played on. Identifies which game this competitive season is for.',
    `league_id` BIGINT COMMENT 'Reference to the parent esports league that this season belongs to. Links season to its competitive league structure.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Seasons are region-scoped; the network region governs data residency compliance, player eligibility, broadcast routing, and latency SLA commitments for the entire season. Compliance and operations tea',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Seasons are provisioned against a designated server fleet configuration. Season-level capacity planning, fleet provisioning decisions, and post-season infrastructure cost reviews require this link. Op',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Competitive seasons define which storefront version is the official competitive standard, managing platform-specific patches, DLC requirements, and ensuring competitive parity. Essential for cross-pla',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Esports seasons are synchronized with in-game title seasons for patch version alignment, ranked season resets, and battle pass windows. Competitive operations teams explicitly map esports seasons to t',
    `broadcast_language` STRING COMMENT 'The primary language for official season broadcasts. Used for localization planning and audience targeting.',
    `broadcast_rights_holder` STRING COMMENT 'The primary media partner or platform holding exclusive broadcast rights for the season (e.g., Twitch, YouTube, ESPN). Critical for revenue and viewership tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the season record was first created in the system. Used for audit trails and data lineage tracking.',
    `crowdfunded_amount` DECIMAL(18,2) COMMENT 'The portion of the prize pool contributed by the player community through in-game purchases or battle passes. Tracks community contribution to prize pool.',
    `end_date` DATE COMMENT 'The official end date of the competitive season. Marks when the season concludes including playoffs and finals.',
    `format_type` STRING COMMENT 'The competitive format structure used for the season. Defines how teams compete and advance through the season. [ENUM-REF-CANDIDATE: Round Robin|Single Elimination|Double Elimination|Swiss|Group Stage|Ladder|Hybrid — 7 candidates stripped; promote to reference product]',
    `is_lan_event` BOOLEAN COMMENT 'Indicates whether the season includes in-person LAN events or is entirely online. Impacts logistics, costs, and competitive integrity.',
    `max_teams` STRING COMMENT 'The maximum number of teams allowed to participate in the season. Defines the competitive field size and bracket structure.',
    `min_teams` STRING COMMENT 'The minimum number of teams required for the season to proceed. Used for viability assessment and cancellation decisions.',
    `ordinal` STRING COMMENT 'Sequential number of this season within the league (e.g., 1 for first season, 5 for fifth season). Used for historical ordering and analytics.',
    `peak_ccu` STRING COMMENT 'The highest number of concurrent viewers across all broadcast channels during the season. Key performance indicator for viewership success.',
    `prize_pool_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the prize pool (e.g., USD, EUR, GBP). Used for financial reporting and payout processing.. Valid values are `^[A-Z]{3}$`',
    `qualification_slots` STRING COMMENT 'Number of top-performing teams that qualify for the next tier or championship event. Defines advancement opportunities from this season.',
    `region` STRING COMMENT 'The geographic region this season serves. Defines player eligibility, time zones for scheduling, and regional rankings. [ENUM-REF-CANDIDATE: North America|Europe|Asia|South America|Oceania|Middle East|Africa|Global — 8 candidates stripped; promote to reference product]',
    `registered_teams_count` STRING COMMENT 'The current number of teams registered for the season. Updated in real-time during registration period for capacity planning.',
    `registration_end_date` DATE COMMENT 'The deadline for team and player registration for the season. After this date, rosters are typically locked for the season start.',
    `registration_start_date` DATE COMMENT 'The date when team and player registration opens for the season. Critical for operational planning and team onboarding.',
    `relegation_slots` STRING COMMENT 'Number of bottom-performing teams that are relegated to a lower tier. Defines demotion risk and competitive stakes.',
    `ruleset_version` STRING COMMENT 'The version identifier of the official competitive ruleset governing the season. Tracks rule changes and ensures competitive integrity.',
    `season_code` STRING COMMENT 'Short alphanumeric code used for internal identification and system integration (e.g., S5_2024, SPR24).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `season_description` STRING COMMENT 'Detailed narrative description of the season including format details, special rules, and promotional messaging. Used for marketing and player communication.',
    `season_name` STRING COMMENT 'The official marketing and display name of the esports season (e.g., Spring Championship 2024, World Series Season 5).',
    `season_status` STRING COMMENT 'Current lifecycle status of the season. Tracks the season from planning through completion and supports operational workflows. [ENUM-REF-CANDIDATE: Draft|Announced|Registration Open|Registration Closed|Active|Playoffs|Completed|Cancelled|Suspended — 9 candidates stripped; promote to reference product]',
    `split` STRING COMMENT 'The calendar or competitive split designation for the season. Indicates which portion of the competitive year this season represents. [ENUM-REF-CANDIDATE: Spring|Summer|Fall|Winter|Annual|Mid-Season|Playoffs — 7 candidates stripped; promote to reference product]',
    `sponsor_primary` STRING COMMENT 'The name of the primary title sponsor for the season. Critical for branding, revenue attribution, and sponsorship fulfillment tracking.',
    `start_date` DATE COMMENT 'The official start date of the competitive season. Marks when matches and tournaments begin.',
    `tier_level` STRING COMMENT 'The competitive tier or prestige level of the season within the league hierarchy. Determines prize pool scale and qualification pathways. [ENUM-REF-CANDIDATE: Premier|Major|Minor|Challenger|Amateur|Regional|International — 7 candidates stripped; promote to reference product]',
    `total_prize_pool_amount` DECIMAL(18,2) COMMENT 'The total monetary prize pool allocated for the season across all placements and awards. Includes base pool and any crowdfunded additions.',
    `total_viewership_hours` BIGINT COMMENT 'Cumulative hours watched across all matches and broadcasts during the season. Primary metric for sponsor value and broadcast success.',
    `updated_by` STRING COMMENT 'The user or system account that last modified the season record. Tracks change ownership for governance and audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the season record was last modified. Tracks the most recent change for audit and synchronization purposes.',
    `venue_location` STRING COMMENT 'The primary physical venue or city hosting LAN events for the season. Null for online-only seasons. Used for event operations and marketing.',
    `year` STRING COMMENT 'The calendar year in which the season primarily takes place. Used for year-over-year analytics and historical reporting.',
    `created_by` STRING COMMENT 'The user or system account that created the season record. Supports accountability and audit requirements.',
    CONSTRAINT pk_esports_season PRIMARY KEY(`esports_season_id`)
) COMMENT 'Defines a competitive season within a league, including season name, ordinal number, split (Spring/Summer/Fall/Winter), start date, end date, patch version range, prize pool allocation, qualification slots to next tier, relegation slots, and season status. A season is the primary scheduling and standings container for league play.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`bracket` (
    `bracket_id` BIGINT COMMENT 'Unique identifier for the bracket or group stage within a tournament. Primary key.',
    `esports_season_id` BIGINT COMMENT 'Foreign key linking to esports.esports_season. Business justification: A bracket (playoff/group stage structure) is conducted within a specific season of a league. bracket already has tournament_id and league_id, but no direct esports_season_id. Adding this FK enables di',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Brackets specify which game mode is played (e.g., tournament draft, ranked 5v5) for ruleset definition, player preparation, and spectator clarity. Essential for competitive format specification and en',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title or intellectual property (IP) that this bracket competition is for. Links bracket to the game being played competitively.',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Brackets are structural components of league competitive formats. While brackets are nested within tournaments, they also belong to a league context for organizational and reporting purposes. The busi',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Brackets are region-scoped competitive stages; the network region governs player eligibility rules, latency SLA enforcement, data residency compliance, and broadcast routing decisions. A domain expert',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Bracket stages in competitive esports are assigned dedicated server fleets for capacity isolation and SLA guarantees. Operations teams use this link for fleet-level capacity planning, incident respons',
    `tournament_id` BIGINT COMMENT 'Reference to the parent tournament or qualifier event that this bracket belongs to. Links bracket to the overarching competitive event.',
    `venue_id` BIGINT COMMENT 'Reference to the physical or virtual venue where this bracket stage is being held. Null for fully online brackets. Used for logistics, ticketing, and broadcast production planning.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the final match of this bracket stage actually concluded. Used for operational tracking, broadcast analytics, and schedule variance analysis.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the first match of this bracket stage actually began. Used for operational tracking, broadcast analytics, and schedule variance analysis.',
    `advancement_rule` STRING COMMENT 'Business rule defining how teams progress to the next stage or round. Examples: Top 2 teams advance, Winner advances to upper bracket, loser to lower bracket, Top 4 by points qualify for playoffs. Free-text field capturing the specific progression logic for this bracket.',
    `average_minute_audience` STRING COMMENT 'The average number of viewers watching at any given minute during this bracket stage. Standard broadcast metric used for advertising rate calculations and sponsorship deliverables.',
    `best_of_format` STRING COMMENT 'The match series length format for matches within this bracket. BO1 is single game; BO3 is best of three games; BO5 is best of five; BO7 is best of seven; variable indicates different rounds may have different formats (specified at match level).. Valid values are `bo1|bo3|bo5|bo7|variable`',
    `bracket_name` STRING COMMENT 'Human-readable name or label for the bracket stage, such as Upper Bracket, Lower Bracket, Group A, Playoffs, Qualifier Round 1. Used for display and reporting purposes.',
    `bracket_status` STRING COMMENT 'Current lifecycle state of the bracket. Draft indicates planning phase; scheduled means bracket is finalized and awaiting start; in_progress indicates active matches; completed means all matches finished; cancelled means bracket was terminated; suspended indicates temporary halt.. Valid values are `draft|scheduled|in_progress|completed|cancelled|suspended`',
    `bracket_type` STRING COMMENT 'The competitive format structure of the bracket. Single elimination removes teams after one loss; double elimination allows one loss before elimination; round robin has all teams play each other; Swiss pairs teams with similar records; GSL group is a dual-tournament group stage; page playoff is a four-team format; gauntlet is a sequential challenge format. [ENUM-REF-CANDIDATE: single_elimination|double_elimination|round_robin|swiss|gsl_group|page_playoff|gauntlet — 7 candidates stripped; promote to reference product]',
    `broadcast_language_codes` STRING COMMENT 'Comma-separated list of ISO 639-1 two-letter language codes for broadcast coverage of this bracket. Example: en,es,pt,zh,ko,ja. Used for localization planning and international audience tracking.',
    `broadcast_priority` STRING COMMENT 'The broadcast coverage priority level for matches within this bracket. Primary indicates main stream coverage; secondary indicates alternate stream; tertiary indicates limited or VOD-only coverage; none indicates no broadcast planned.. Valid values are `primary|secondary|tertiary|none`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bracket record was first created in the system. Used for audit trail and data lineage tracking.',
    `end_date` DATE COMMENT 'The scheduled or actual date when the final match of this bracket stage is planned to complete or did complete. Used for tournament duration tracking and venue booking.',
    `game_version` STRING COMMENT 'The specific patch, build, or version number of the game title used for this bracket stage. Critical for competitive integrity as balance changes between versions can affect gameplay. Example: 13.4, Season 7 Patch 2, Build 2023.11.15.',
    `grand_final_reset_flag` BOOLEAN COMMENT 'For double elimination brackets, indicates whether the grand final requires a bracket reset if the upper bracket finalist loses. True means the lower bracket winner must win two series; false means single series determines champion regardless of bracket path.',
    `match_scheduling_buffer_minutes` STRING COMMENT 'The standard time buffer in minutes allocated between consecutive matches in this bracket for player breaks, technical setup, and broadcast transitions. Used for automated scheduling and production planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bracket record was last updated. Used for change tracking and data synchronization across systems.',
    `notes` STRING COMMENT 'Free-text field for tournament organizers to capture operational notes, special circumstances, rule exceptions, or other contextual information about this bracket stage. Used for internal communication and historical reference.',
    `peak_ccu` STRING COMMENT 'The maximum number of concurrent viewers across all broadcast channels during this bracket stage. Key performance indicator for broadcast success and sponsorship value. Measured across Twitch, YouTube, in-game spectator, and other platforms.',
    `prize_pool_allocation_pct` DECIMAL(18,2) COMMENT 'The percentage of the total tournament prize pool allocated to this specific bracket stage. For example, if the main event bracket receives 80% of the total prize pool, this value would be 80.00. Used for prize distribution calculations and financial reporting.',
    `region` STRING COMMENT 'The geographic region this bracket represents or is restricted to. NAM is North America; EUR is Europe; ASA is Asia-Pacific; CHN is China; KOR is South Korea; JPN is Japan; LAT is Latin America; OCE is Oceania; MEA is Middle East and Africa; GLOBAL indicates multi-region or international bracket. [ENUM-REF-CANDIDATE: NAM|EUR|ASA|CHN|KOR|JPN|LAT|OCE|MEA|GLOBAL — 10 candidates stripped; promote to reference product]',
    `replay_review_enabled_flag` BOOLEAN COMMENT 'Indicates whether match officials can review replays for disputed calls or rule violations during matches in this bracket. True means replay review is available; false means real-time officiating only.',
    `round_count` STRING COMMENT 'Total number of competitive rounds within this bracket stage. For single elimination with 8 teams this would be 3 (quarterfinals, semifinals, finals). For round robin this represents the number of match days or cycles.',
    `ruleset_version` STRING COMMENT 'The version identifier of the competitive ruleset document governing this bracket. Tracks which set of tournament rules, map pools, character restrictions, and competitive settings apply. Example: LCS 2024 Spring v1.2, TI12 Official Rules v3.0.',
    `seeding_method` STRING COMMENT 'The methodology used to determine initial team placement and matchup order within the bracket. Manual indicates tournament organizer assignment; performance-based uses historical stats; random draw is lottery-based; regional ranking uses geographic league standings; points-based uses accumulated tournament points; previous stage uses results from prior bracket.. Valid values are `manual|performance_based|random_draw|regional_ranking|points_based|previous_stage`',
    `spectator_mode` STRING COMMENT 'The audience access model for this bracket stage. Live audience indicates in-person attendance allowed; online only means digital viewing only; hybrid allows both in-person and online; closed means no public viewing (internal/qualifier matches).. Valid values are `live_audience|online_only|hybrid|closed`',
    `sponsor_tier` STRING COMMENT 'The highest sponsorship tier associated with this bracket stage. Title sponsor has naming rights; presenting sponsor has secondary branding; official sponsor has category exclusivity; supporting sponsor has standard placement; none indicates no dedicated bracket sponsorship.. Valid values are `title|presenting|official|supporting|none`',
    `start_date` DATE COMMENT 'The scheduled date when the first match of this bracket stage is planned to begin. Used for tournament scheduling, broadcast planning, and player availability coordination.',
    `team_count` STRING COMMENT 'Number of teams or competitors participating in this bracket stage. Used for bracket structure validation and seeding calculations.',
    `technical_pause_allowed_flag` BOOLEAN COMMENT 'Indicates whether teams are permitted to request technical pauses during matches in this bracket. True means pauses are allowed per ruleset; false means no pauses permitted (typically for lower-tier or online qualifiers).',
    `third_place_match_flag` BOOLEAN COMMENT 'Indicates whether this bracket includes a third-place playoff match between the two semifinal losers. True means a bronze medal match is scheduled; false means no third-place match.',
    `tiebreaker_rule` STRING COMMENT 'Business rule defining how ties in standings or match results are resolved. Examples: Head-to-head record, Map differential, Total kills, Sudden death overtime, Coin flip. Free-text field capturing the specific tiebreaker logic for this bracket.',
    `total_viewership` BIGINT COMMENT 'The cumulative number of unique viewers who watched any portion of this bracket stage across all broadcast channels. Used for sponsorship reporting and media rights valuation.',
    CONSTRAINT pk_bracket PRIMARY KEY(`bracket_id`)
) COMMENT 'Defines the bracket or group stage structure within a tournament playoff or qualifier. Stores bracket type (single-elim, double-elim, GSL group, Swiss), round count, seeding method (manual, performance-based, random draw), advancement rules, tiebreaker rules, bracket status, and the ordered list of rounds. Enables reconstruction of the full competitive tree and drives match scheduling within the tournament. Parent entity for all matches within a given stage.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`match` (
    `match_id` BIGINT COMMENT 'Unique identifier for the competitive match. Primary key for the match entity.',
    `bracket_id` BIGINT COMMENT 'Foreign key linking to esports.bracket. Business justification: Matches occur within bracket structures (single elimination, double elimination, round robin groups). The existing bracket_round attribute (STRING) suggests bracket context but lacks referential integ',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Matches require precise build tracking for competitive integrity, replay validation, and dispute resolution. Replaces denormalized patch_version string with proper FK to build_artifact for authoritati',
    `esports_season_id` BIGINT COMMENT 'Foreign key linking to esports.esports_season. Business justification: Matches are the core transactional records of competitive play and are always conducted within a specific season. While match has league_id, tournament_id, and bracket_id, there is no direct esports_s',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Matches must specify game mode for competitive rules enforcement, statistical categorization, and spectator experience. Replaces denormalized game_mode string with FK to authoritative mode definition ',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Esports matches are played on dedicated game servers. Tracking which server hosted a competitive match is critical for replay systems, competitive integrity verification, and post-match analysis. This',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being played in this match (e.g., League of Legends, Counter-Strike, Valorant).',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Matches are core competitive events within league operations. While matches are nested within tournaments, they also need direct league association for league-wide match analytics, ruleset enforcement',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to content.level_map. Business justification: Competitive matches are played on specific maps. Essential for match analytics, map pick/ban tracking, balance analysis, broadcast production, and competitive meta reporting. Standard requirement in a',
    `team_id` BIGINT COMMENT 'Reference to the second competing team in the match.',
    `match_team_id` BIGINT COMMENT 'Reference to the first competing team in the match.',
    `match_winning_team_id` BIGINT COMMENT 'Reference to the team that won the match. Null if match is not yet completed or was cancelled.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Matches are hosted in specific network regions to minimize player latency and comply with data residency rules. Region determines available game servers, CDN nodes, and legal jurisdiction. Essential f',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Competitive matches must lock to specific patch releases for fairness and competitive integrity. Enables tracking patch metadata (certification status, known issues, rollback availability) beyond vers',
    `tournament_id` BIGINT COMMENT 'Reference to the tournament or league in which this match is being played.',
    `venue_id` BIGINT COMMENT 'Foreign key linking to esports.venue. Business justification: match currently stores venue_location (STRING) and venue_type (STRING) as denormalized text fields. The esports domain has a dedicated venue master table with full venue details (venue_name, venue_typ',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the match concluded. Used to calculate match duration and broadcast time.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the match began. May differ from scheduled time due to delays or technical issues.',
    `average_ccu` STRING COMMENT 'Average number of concurrent viewers throughout the match duration. Used for broadcast performance analysis.',
    `best_of_format` STRING COMMENT 'Match series format indicating how many games must be won to win the match. BO1 = single game, BO3 = best of three games, BO5 = best of five games.. Valid values are `BO1|BO3|BO5|BO7`',
    `broadcast_delay_seconds` STRING COMMENT 'Number of seconds the broadcast is delayed behind live gameplay to prevent competitive advantage from stream viewing. Typically 0-180 seconds.',
    `broadcast_url` STRING COMMENT 'Primary streaming or broadcast URL where the match is being televised or streamed (e.g., Twitch, YouTube, platform-specific channels).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this match record was first created in the system. Used for audit trail and data lineage.',
    `data_source_system` STRING COMMENT 'Name of the operational system or platform from which this match data originated (e.g., Tournament Management System, Broadcast Analytics Platform).',
    `disqualification_flag` BOOLEAN COMMENT 'Indicates whether any team was disqualified during the match due to rule violations, cheating, or technical issues. True if disqualification occurred.',
    `disqualification_reason` STRING COMMENT 'Detailed explanation of why a team was disqualified, if applicable. Null if no disqualification occurred.',
    `duration_seconds` STRING COMMENT 'Total elapsed time of the match from actual start to actual end, measured in seconds. Includes all games in the series and breaks between games.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this match record was last updated. Used for audit trail and change tracking.',
    `match_number` STRING COMMENT 'Business-facing match identifier or code used for external communication, broadcasting, and scheduling (e.g., QF-1, GF-2023-001).',
    `match_status` STRING COMMENT 'Current lifecycle status of the match. Tracks progression from scheduling through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|live|completed|cancelled|postponed|forfeited|under_review — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for administrative notes, special circumstances, or commentary about the match (e.g., Player substitution in game 2, Network issues caused delay).',
    `peak_ccu` STRING COMMENT 'Maximum number of concurrent viewers watching the match broadcast at any single moment. Key metric for broadcast success and sponsorship value.',
    `prize_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the prize pool amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `prize_pool_amount` DECIMAL(18,2) COMMENT 'Total prize money allocated to this specific match. Typically applies to finals or special showcase matches. Null for regular season matches without direct prize allocation.',
    `replay_available_flag` BOOLEAN COMMENT 'Indicates whether a full replay or video-on-demand recording of the match is available for viewing. True if replay exists.',
    `replay_url` STRING COMMENT 'URL link to the match replay or video-on-demand content. Null if replay is not available.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the match is scheduled to begin. Used for broadcast scheduling and player coordination.',
    `spectator_mode` STRING COMMENT 'Broadcast delay mode used for the match. Live = no delay, Delayed = broadcast delay to prevent stream sniping, None = no spectator broadcast.. Valid values are `live|delayed|none`',
    `sponsor_tier` STRING COMMENT 'Sponsorship tier or package level associated with this match (e.g., Title Sponsor, Presenting Sponsor, Official Partner). Used for revenue attribution.',
    `team_a_score` STRING COMMENT 'Number of games won by Team A in the match series. For BO3, values range 0-2; for BO5, values range 0-3.',
    `team_b_score` STRING COMMENT 'Number of games won by Team B in the match series. For BO3, values range 0-2; for BO5, values range 0-3.',
    `technical_pause_count` STRING COMMENT 'Number of technical pauses called during the match due to equipment failure, network issues, or other technical problems.',
    `technical_pause_duration_seconds` STRING COMMENT 'Total cumulative time spent in technical pauses during the match, measured in seconds.',
    `total_views` BIGINT COMMENT 'Total number of unique views or impressions for the match broadcast across all platforms and channels.',
    CONSTRAINT pk_match PRIMARY KEY(`match_id`)
) COMMENT 'Core transactional record for competitive matches encompassing the full match lifecycle from scheduling through post-match analytics. At match header level: date/time, tournament/bracket round, best-of format (BO1/BO3/BO5), venue type (online/LAN), patch version, referee/admin assignment, CCU metrics, match status, and winner determination. At game/map detail level: game number within the series, map/mode played, per-game scores, winning team, duration in seconds, game start/end timestamps, server region, and disqualification flags. At player performance detail level: per-player-per-game KDA (kills/deaths/assists), damage dealt, healing done, objective score, economy score, MVP flag, role-specific KPIs (CS/min for MOBA, headshot rate for FPS, APM for RTS), and game-title-specific stat fields. This is the single source of truth for all competitive match data from header through game results through player statistics.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`game_result` (
    `game_result_id` BIGINT COMMENT 'Unique identifier for the game result record. Primary key for this transactional entity representing a single game (map/round) within a competitive match.',
    `bracket_id` BIGINT COMMENT 'Foreign key linking to esports.bracket. Business justification: Game results occur within the context of a bracket structure. The existing round_id attribute suggests bracket context, but there is no FK to bracket. Individual games are played as part of bracket pr',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Individual game results need build-level granularity for replay analysis, balance retrospectives, and competitive ruling validation. Replaces denormalized patch_version with FK to authoritative build ',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Game results are played in a specific game mode (e.g., 5v5 competitive, battle royale). Competitive analytics, balance reporting, and esports ruleset enforcement require knowing which game_mode a resu',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Post-match integrity audits, anti-cheat investigations, and replay file retrieval all require knowing which specific game server instance hosted the game. Competitive integrity teams routinely query g',
    `game_title_id` BIGINT COMMENT 'Reference to the game title (e.g., League of Legends, Counter-Strike, Valorant) this game was played in. Essential for cross-title analytics and esports portfolio management.',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to content.level_map. Business justification: Individual games within matches occur on specific maps. Critical for player performance analysis by map, team map preferences, win rate analytics, and competitive balance tuning. Map_name is denormali',
    `match_id` BIGINT COMMENT 'Reference to the parent match that contains this game. A Best-of-3 (BO3) match produces up to 3 game_result records.',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Individual game results record exact patch release for historical competitive analysis, balance retrospectives, and result validation. Enables joining to patch certification status, known bugs, and ba',
    `player_account_id` BIGINT COMMENT 'Reference to the player awarded MVP (Most Valuable Player) for this game based on performance metrics (kills, assists, objectives, damage). Nullable if MVP is not awarded.',
    `team_id` BIGINT COMMENT 'Reference to the team that won this game. Nullable if the game ended in a draw or was not completed.',
    `server_session_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_session. Business justification: Each game result maps 1:1 to a server session. Fairness audits correlate competitive outcomes with session-level telemetry (latency, FPS, packet loss, anti-cheat flags). This link is essential for mat',
    `tertiary_game_team_b_esports_team_id` BIGINT COMMENT 'Reference to the second competing team in this game. Typically the away team or lower-seeded team in bracket play.',
    `tournament_id` BIGINT COMMENT 'Reference to the tournament or league this game is part of. Nullable for non-tournament games (scrims, practice matches).',
    `broadcast_flag` BOOLEAN COMMENT 'Indicates whether this game was broadcast live on streaming platforms (Twitch, YouTube, etc.). True if broadcast, False otherwise. Used for rights management and viewership correlation.',
    `competitive_tier` STRING COMMENT 'Classification of the competitive level of this game (e.g., professional, semi-professional, amateur, collegiate). Used for prize pool allocation, broadcast rights, and player eligibility.. Valid values are `professional|semi_professional|amateur|collegiate|regional|international`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this game result record was first created in the system. Used for data lineage, audit trails, and ETL (Extract Transform Load) tracking.',
    `data_source` STRING COMMENT 'Origin system or method by which this game result was captured (e.g., game server API, tournament platform, manual entry by officials, third-party data provider). Used for data quality assessment and source system reconciliation.. Valid values are `game_server|tournament_platform|manual_entry|third_party_api`',
    `disqualification_flag` BOOLEAN COMMENT 'Indicates whether this game result was disqualified due to rule violations, cheating, or technical issues. True if disqualified, False otherwise.',
    `disqualification_reason` STRING COMMENT 'Detailed explanation of why the game was disqualified, if applicable. Includes rule violations, cheating incidents, technical failures, or administrative decisions.',
    `duration_seconds` STRING COMMENT 'Total elapsed time of the game in seconds from start to completion. Used for pacing analysis, broadcast scheduling, and competitive balance tuning.',
    `game_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the game officially ended (victory condition met or forfeit declared). Used for duration calculation and event sequencing.',
    `game_number` STRING COMMENT 'Sequential number of this game within the match (e.g., 1, 2, 3 for a BO3). Determines ordering and progression through the match series.',
    `game_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the game officially started (first frame rendered or countdown completed). Used for live operations, broadcast synchronization, and CCU (Concurrent Users) tracking.',
    `game_status` STRING COMMENT 'Current lifecycle status of the game. Indicates whether the game was completed normally, forfeited by a team, disqualified due to rule violations, or cancelled by tournament officials.. Valid values are `completed|forfeited|disqualified|cancelled|in_progress|paused`',
    `notes` STRING COMMENT 'Free-text field for additional context, referee observations, or special circumstances related to this game. Used for historical record-keeping and dispute resolution documentation.',
    `pause_count` STRING COMMENT 'Number of times the game was paused during play due to technical issues, player requests, or referee intervention. Used for match quality assessment and technical operations review.',
    `prize_pool_contribution_flag` BOOLEAN COMMENT 'Indicates whether this game result contributes to prize pool distribution calculations. True if it counts toward prize money, False for exhibition or practice games.',
    `replay_file_url` STRING COMMENT 'URL or storage path to the game replay file for post-match analysis, content creation, and dispute resolution. Stored in CDN (Content Delivery Network) for player and analyst access.',
    `server_region` STRING COMMENT 'Geographic region of the game server hosting this match. Impacts latency, player experience, and competitive fairness. Critical for esports integrity and regional league operations. [ENUM-REF-CANDIDATE: NA_EAST|NA_WEST|EU_WEST|EU_CENTRAL|ASIA_PACIFIC|LATAM|OCE|MIDDLE_EAST — 8 candidates stripped; promote to reference product]',
    `side_selection` STRING COMMENT 'Method used to determine which team selected their starting side (e.g., attacking/defending, blue/red side). Important for competitive balance analysis in asymmetric games.. Valid values are `team_a_first|team_b_first|random|coin_flip`',
    `spectator_count` STRING COMMENT 'Number of live spectators watching this game through in-game spectator mode or tournament observer slots. Excludes broadcast viewers.',
    `team_a_score` STRING COMMENT 'Final score achieved by Team A in this game. Scoring semantics vary by game title (kills, rounds won, points, objectives captured).',
    `team_a_side` STRING COMMENT 'The starting side or faction assigned to Team A (e.g., CT, Radiant, Blue Side, Attackers). Used for win-rate analysis by side and competitive balance tuning.',
    `team_b_score` STRING COMMENT 'Final score achieved by Team B in this game. Scoring semantics vary by game title (kills, rounds won, points, objectives captured).',
    `team_b_side` STRING COMMENT 'The starting side or faction assigned to Team B (e.g., T, Dire, Red Side, Defenders). Used for win-rate analysis by side and competitive balance tuning.',
    `technical_issue_description` STRING COMMENT 'Detailed description of any technical issues that occurred during the game, including server problems, client crashes, or game-breaking bugs. Used for post-match review and infrastructure improvement.',
    `technical_issue_flag` BOOLEAN COMMENT 'Indicates whether technical issues (server lag, disconnects, bugs) occurred during this game that may have impacted competitive integrity. True if issues occurred, False otherwise.',
    `total_pause_duration_seconds` STRING COMMENT 'Cumulative time in seconds that the game was paused. Excludes active gameplay time. Used for broadcast scheduling and match quality metrics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this game result record was last modified. Used for change tracking, data quality monitoring, and incremental data pipeline processing.',
    `verification_status` STRING COMMENT 'Status of official verification for this game result by tournament administrators. Verified results are final and used for standings; disputed results are under review.. Valid values are `verified|pending|disputed|rejected`',
    CONSTRAINT pk_game_result PRIMARY KEY(`game_result_id`)
) COMMENT 'Transactional record for an individual game (map/round) within a match. A BO3 match produces up to 3 game_result records. Captures game number, map/mode played, winning team, score, duration in seconds, game start/end timestamps, server region, patch version, and any game-level disqualification flags. Provides granular competitive data below the match level.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`standing` (
    `standing_id` BIGINT COMMENT 'Unique identifier for the league standing record. Primary key.',
    `esports_season_id` BIGINT COMMENT 'Reference to the competitive season for this standing.',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Standings are scoped to a specific game title. Cross-title competitive reporting, ranking systems, and esports analytics dashboards require direct game_title attribution on standings. No existing FK c',
    `league_id` BIGINT COMMENT 'Reference to the esports league this standing belongs to.',
    `team_id` BIGINT COMMENT 'Reference to the esports team this standing record represents.',
    `clinched_playoff` BOOLEAN COMMENT 'Indicates whether the team has mathematically clinched a playoff berth.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this standing record was first created in the system.',
    `current_streak` STRING COMMENT 'Current winning or losing streak (e.g., W5 = 5 wins in a row, L3 = 3 losses in a row, D1 = 1 draw).. Valid values are `^[WLD][0-9]+$`',
    `effective_date` DATE COMMENT 'Date from which this standing record is effective. Used for historical standing snapshots.',
    `eliminated` BOOLEAN COMMENT 'Indicates whether the team has been mathematically eliminated from playoff contention.',
    `last_match_date` DATE COMMENT 'Date of the most recent match played by the team that affected this standing.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this standing record was last updated after a match result.',
    `longest_loss_streak` STRING COMMENT 'Longest consecutive losing streak experienced by the team during the season.',
    `longest_win_streak` STRING COMMENT 'Longest consecutive winning streak achieved by the team during the season.',
    `map_differential` STRING COMMENT 'Net difference between maps won and maps lost (maps_won - maps_lost). Used for tiebreaker calculations.',
    `maps_lost` STRING COMMENT 'Total number of individual maps or games lost across all matches.',
    `maps_won` STRING COMMENT 'Total number of individual maps or games won across all matches.',
    `matches_drawn` STRING COMMENT 'Total number of matches that ended in a draw or tie.',
    `matches_lost` STRING COMMENT 'Total number of matches lost by the team.',
    `matches_played` STRING COMMENT 'Total number of matches the team has played in the season.',
    `matches_won` STRING COMMENT 'Total number of matches won by the team.',
    `next_match_date` DATE COMMENT 'Date of the next scheduled match for the team.',
    `playoff_eligible` BOOLEAN COMMENT 'Indicates whether the team is currently eligible for playoff qualification based on their standing.',
    `rank_position` STRING COMMENT 'Current rank position of the team in the league standings (1 = first place).',
    `relegation_zone` BOOLEAN COMMENT 'Indicates whether the team is currently in the relegation zone and at risk of demotion.',
    `round_differential` STRING COMMENT 'Net difference between rounds won and rounds lost (rounds_won - rounds_lost). Used for tiebreaker calculations.',
    `rounds_lost` STRING COMMENT 'Total number of rounds lost across all maps and matches.',
    `rounds_won` STRING COMMENT 'Total number of rounds won across all maps and matches.',
    `standing_status` STRING COMMENT 'Current status of the standing record. Active = season in progress, Provisional = pending match result verification, Final = season completed, Archived = historical record.. Valid values are `active|provisional|final|archived`',
    `tiebreaker_rank` STRING COMMENT 'Rank position after applying tiebreaker rules (map differential, round differential, head-to-head). Used when teams have equal points.',
    `total_points` STRING COMMENT 'Total league points accumulated by the team based on match results (e.g., 3 points per win, 1 per draw).',
    `win_rate` DECIMAL(18,2) COMMENT 'Percentage of matches won (matches_won / matches_played). Expressed as decimal (e.g., 0.6500 = 65%).',
    CONSTRAINT pk_standing PRIMARY KEY(`standing_id`)
) COMMENT 'Tracks the current and historical league standings for each team within a season. Records wins, losses, draws, map differential, round differential, points, win rate, current streak, last updated timestamp, and tiebreaker rank. Updated after each match. Serves as the authoritative standings record for league tables, playoff seeding, and relegation decisions.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`prize_pool` (
    `prize_pool_id` BIGINT COMMENT 'Unique identifier for the prize pool. Primary key for the prize pool entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Prize pools are funded from an organizer or publisher billing account. Treasury teams track which billing account funds each prize pool for financial controls, escrow management, and audit compliance ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_campaign. Business justification: Crowdfunded prize pools (e.g., battle pass → prize pool model) are driven by specific marketing campaigns. prize_pool has crowdfund_amount indicating crowdfunding exists; linking to the marketing camp',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Prize pools often funded by content sales (battle pass, compendium, in-game items). Direct revenue attribution required for financial reporting, content ROI analysis, and crowdfunding transparency. St',
    `esports_season_id` BIGINT COMMENT 'Foreign key linking to esports.esports_season. Business justification: A prize pool is defined for a specific tournament or league season. prize_pool already has league_id and tournament_id, but no direct esports_season_id. Adding this FK enables season-level prize pool ',
    `game_studio_id` BIGINT COMMENT 'Reference to the organization responsible for managing the tournament and prize pool (first-party or third-party tournament organizer).',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this prize pool is established. Links to the game title master entity.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Prize pools subject to jurisdiction-specific tax withholding rates, gambling regulations, payment processing rules, and prize distribution laws. Essential for tax compliance calculations, regulatory f',
    `league_id` BIGINT COMMENT 'Reference to the esports league or competitive circuit associated with this prize pool. Null for standalone tournaments.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Prize pools are subject to regulatory obligations governing crowdfunding rules, prize pool funding source disclosure, and tax treatment. Compliance officers must reference the specific obligation (e.g',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Prize pools are crowdfunded through seasonal events (battle pass contributions — a well-known pattern in Dota 2, Fortnite). prize_pool.crowdfund_amount implies this relationship exists. Finance and es',
    `tournament_id` BIGINT COMMENT 'Reference to the tournament or league season for which this prize pool is defined. Links to the tournament entity.',
    `broadcast_rights_linked` BOOLEAN COMMENT 'Indicates whether this prize pool is tied to broadcast rights agreements or revenue-sharing arrangements with streaming platforms or media partners.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prize pool record was first created in the system.',
    `crowdfund_amount` DECIMAL(18,2) COMMENT 'Portion of the total prize pool contributed through crowdfunding mechanisms (e.g., battle pass sales, in-game purchases). Null if not applicable.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the prize pool (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `default_tax_rate` DECIMAL(18,2) COMMENT 'Default tax withholding rate (as percentage) applied to prize payments unless overridden by jurisdiction-specific rules or tax treaty provisions.',
    `distribution_completion_date` DATE COMMENT 'Date when all prize payments from this pool were fully processed and disbursed.',
    `distribution_method` STRING COMMENT 'Method used to allocate prize pool funds: placement_based (by tournament rank), point_based (by accumulated league points), hybrid (combination), or custom (unique distribution logic).. Valid values are `placement_based|point_based|hybrid|custom`',
    `distribution_start_date` DATE COMMENT 'Date when prize disbursement processing began for this pool.',
    `first_place_amount` DECIMAL(18,2) COMMENT 'Prize amount allocated to the first-place finisher or team. Null if distribution is not placement-based.',
    `funding_source` STRING COMMENT 'Primary source of prize pool funding: first_party (publisher/developer funded), crowdfunded (community contributions), sponsor_contributed (external sponsor), or mixed (combination of sources).. Valid values are `first_party|crowdfunded|sponsor_contributed|mixed`',
    `minimum_guaranteed_amount` DECIMAL(18,2) COMMENT 'Minimum prize pool amount guaranteed regardless of crowdfunding or sponsorship performance. Represents the baseline commitment.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or administrative notes related to the prize pool structure or distribution.',
    `number_of_paid_placements` STRING COMMENT 'Total number of tournament placements that receive prize money from this pool (e.g., top 8, top 16).',
    `payee_type_default` STRING COMMENT 'Default recipient type for prize payments: team_organization (paid to team entity), individual_player (paid directly to players), or mixed (varies by placement or agreement).. Valid values are `team_organization|individual_player|mixed`',
    `payment_processor` STRING COMMENT 'Name or identifier of the payment processing system or third-party service used to disburse prize payments (e.g., PayPal, wire transfer, check).',
    `pool_announcement_date` DATE COMMENT 'Date when the prize pool was publicly announced to the esports community and participants.',
    `pool_lock_date` DATE COMMENT 'Date when the prize pool was locked and finalized, preventing further changes to the total amount or distribution structure.',
    `pool_name` STRING COMMENT 'Business-friendly name or identifier for the prize pool (e.g., World Championship 2024 Prize Pool, Spring Split Finals Prize Pool).',
    `pool_status` STRING COMMENT 'Current lifecycle status of the prize pool: draft (being defined), active (tournament ongoing), locked (finalized, awaiting distribution), distributed (payments processed), closed (fully reconciled).. Valid values are `draft|active|locked|distributed|closed`',
    `second_place_amount` DECIMAL(18,2) COMMENT 'Prize amount allocated to the second-place finisher or team. Null if distribution is not placement-based.',
    `sponsor_amount` DECIMAL(18,2) COMMENT 'Portion of the total prize pool contributed by external sponsors. Null if not applicable.',
    `tax_withholding_rule` STRING COMMENT 'Description or reference to the tax withholding rules applied to prize disbursements, which may vary by jurisdiction and payee residency status.',
    `third_place_amount` DECIMAL(18,2) COMMENT 'Prize amount allocated to the third-place finisher or team. Null if distribution is not placement-based.',
    `total_pool_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the prize pool available for distribution across all placements and participants.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this prize pool record was last modified.',
    CONSTRAINT pk_prize_pool PRIMARY KEY(`prize_pool_id`)
) COMMENT 'Master and detail record defining the complete prize structure and individual allocation tracking for a tournament or league season. At pool level: total prize pool amount, currency, funding source (first-party, crowdfunded, sponsor-contributed), distribution method (placement-based, point-based), minimum guaranteed amount, tax withholding rules by jurisdiction, and prize pool status. At allocation detail level: placement rank, allocated amount, currency, payment status (pending/approved/paid/withheld), payment date, payee type (team organization vs individual player), payee reference, tax withholding amount, and net payout. Single source of truth for both prize pool definition and per-placement disbursement tracking. Feeds into billing domain for actual payment processing.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`prize_allocation` (
    `prize_allocation_id` BIGINT COMMENT 'Unique identifier for the prize allocation record. Primary key for this transactional entity capturing prize money awarded to teams or individual players upon tournament completion.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Prize payouts to players and teams require invoices for tax documentation (1099/W-8 forms), accounts payable processing, and regulatory compliance. Linking prize_allocation to invoice enables prize pa',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Individual prize payments must comply with payees local tax laws, withholding requirements, payment method regulations, and reporting obligations. Required for accurate tax withholding calculation, r',
    `parent_allocation_prize_allocation_id` BIGINT COMMENT 'Reference to the parent prize allocation when this record represents a split or sub-allocation. Used to track hierarchical prize distribution from team to individual players.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Prize disbursements must link to payment records for tax reporting (1099-MISC forms), audit compliance, and reconciliation. Real esports operations (Riot, Valve) track payment_id for each prize alloca',
    `player_account_id` BIGINT COMMENT 'Reference to the individual player receiving this prize allocation. Nullable when prize is awarded to a team organization rather than directly to a player.',
    `prize_pool_id` BIGINT COMMENT 'Reference to the prize pool from which this allocation is drawn. Links to the prize pool entity that defines total available prize money and distribution structure.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Prize allocations involve tax withholding, prize reporting, and anti-money-laundering regulatory obligations. Compliance teams must link each allocation to the specific regulatory obligation governing',
    `team_id` BIGINT COMMENT 'Reference to the esports team receiving this prize allocation. Nullable when prize is awarded directly to an individual player rather than a team organization.',
    `tournament_id` BIGINT COMMENT 'Reference to the esports tournament in which this prize was awarded. Links to the tournament master entity.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Gross prize money amount allocated to the payee before any deductions. Represents the full prize value as defined by the prize pool distribution rules.',
    `allocation_notes` STRING COMMENT 'Free-text notes regarding special circumstances, adjustments, or conditions related to this prize allocation. Used for documentation and audit purposes.',
    `allocation_number` STRING COMMENT 'Externally-visible unique business identifier for this prize allocation. Used for tracking, reconciliation, and communication with payees. Format: PA-YYYYMMDD-NNNN.. Valid values are `^PA-[0-9]{8}-[0-9]{4}$`',
    `allocation_timestamp` TIMESTAMP COMMENT 'Date and time when this prize allocation record was created in the system. Represents the business event time when the prize was officially allocated following tournament completion.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this prize allocation was approved for payment. Null until approval occurs. Critical for audit trail and payment processing workflow.',
    `bonus_prize_category` STRING COMMENT 'Category or type of bonus prize when is_bonus_prize is true. Examples: MVP, Best Play, Most Kills, Fan Favorite, Sportsmanship Award. Null for standard placement prizes.',
    `contract_reference_number` STRING COMMENT 'Reference to the player or team contract governing prize payment terms. Used when contractual obligations affect prize distribution or payment timing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this record was first inserted into the data platform. System audit field for data lineage and troubleshooting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated prize amount. Examples: USD, EUR, GBP, JPY, KRW.. Valid values are `^[A-Z]{3}$`',
    `is_bonus_prize` BOOLEAN COMMENT 'Indicates whether this allocation represents a bonus prize awarded in addition to standard placement prizes. Examples: MVP award, best play award, fan favorite award.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this record was last updated in the data platform. System audit field for tracking changes and data quality monitoring.',
    `net_payout_amount` DECIMAL(18,2) COMMENT 'Final net amount to be paid to the payee after all deductions. Calculated as allocated_amount minus tax_withholding_amount, platform_fee_amount, and other_deductions_amount.',
    `payee_bank_account_number` BIGINT COMMENT 'Reference to the bank account or payment destination used for disbursement. Links to the payee financial account entity containing routing and account details.',
    `payee_type` STRING COMMENT 'Indicates whether the prize is paid to a team organization, directly to an individual player, or split between both. Determines payment routing and tax treatment.. Valid values are `team_organization|individual_player|mixed`',
    `payment_date` DATE COMMENT 'Date on which the prize payment was successfully disbursed to the payee. Null until payment status reaches Paid.',
    `payment_method` STRING COMMENT 'Method used to disburse the prize payment. Wire Transfer = international bank wire, ACH = domestic electronic transfer, PayPal = PayPal account, Check = physical check, Crypto = cryptocurrency, Platform Wallet = in-platform digital wallet.. Valid values are `wire_transfer|ach|paypal|check|crypto|platform_wallet`',
    `payment_status` STRING COMMENT 'Current status of the prize payment in the disbursement workflow. Pending = awaiting approval, Approved = ready for payment, Processing = payment in progress, Paid = funds disbursed, Withheld = payment blocked, Cancelled = allocation voided.. Valid values are `pending|approved|processing|paid|withheld|cancelled`',
    `placement_description` STRING COMMENT 'Human-readable description of the placement achievement. Examples: Champion, Runner-Up, Semi-Finalist, Top 8, Participation Prize.',
    `placement_rank` STRING COMMENT 'Final placement rank achieved in the tournament that determines prize eligibility. 1 = first place, 2 = second place, etc. Used to map to prize pool distribution rules.',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Fee deducted by the tournament platform or organizer for hosting and administration services. Typically a percentage of the gross prize amount.',
    `scheduled_payment_date` DATE COMMENT 'Target date for prize disbursement as defined by tournament rules or contractual agreements. May differ from actual payment_date due to processing delays or holds.',
    `split_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total prize allocated to this specific payee when prize is split among multiple recipients. Example: 0.6000 represents 60% of the total prize. Null for non-split allocations.',
    `tax_form_issued_date` DATE COMMENT 'Date on which the tax form was generated and issued to the payee. Required for regulatory compliance and audit trails.',
    `tax_form_type` STRING COMMENT 'Type of tax form issued for this prize payment. Examples: W-2G (US gambling winnings), 1099-MISC (US miscellaneous income), W-8BEN (foreign person certification). Null if no form required.',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Amount withheld for tax purposes based on jurisdiction and payee tax status. Calculated according to applicable tax treaties and local regulations.',
    `tax_withholding_rate` DECIMAL(18,2) COMMENT 'Tax withholding rate applied as a decimal. Example: 0.3000 represents 30% withholding. Determined by payee residency, tax treaty status, and local regulations.',
    `withholding_reason` STRING COMMENT 'Explanation for why payment is withheld when payment_status is Withheld. Examples: pending tax documentation, contract dispute, eligibility verification, regulatory hold, fraud investigation.',
    CONSTRAINT pk_prize_allocation PRIMARY KEY(`prize_allocation_id`)
) COMMENT 'Transactional record capturing the prize money awarded to a team or individual player upon tournament completion. Records placement rank, allocated amount, currency, payment status (pending/approved/paid/withheld), payment date, payee type (team org vs individual player), tax withholding amount, net payout, and reference to the prize_pool. Feeds into billing domain for actual disbursement processing.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`broadcast_rights` (
    `broadcast_rights_id` BIGINT COMMENT 'Unique identifier for the broadcast rights agreement. Primary key.',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Broadcast rights are granted by the IP holder, who operates under a developer account on the platform. The developer account is the rights grantor in broadcast licensing agreements. Legal and commerci',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Broadcast rights agreements are IP licensing contracts granting media distribution rights for esports content. Links broadcast rights management to master IP licensing framework for royalty calculatio',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Broadcasting rights governed by territory-specific media regulations, content restrictions, age rating display requirements, and advertising rules. Essential for content compliance verification, regul',
    `league_id` BIGINT COMMENT 'Reference to the esports league associated with this broadcast rights agreement.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Broadcast rights agreements are directly governed by specific regulatory obligations (content watershed rules, advertising standards, data retention for broadcast records). compliance_requirements is ',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Broadcast rights agreements specify which platform storefront distributes the content (e.g., streaming rights sold via a specific platform). The platform_type plain attribute is insufficient — a direc',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to monetization.subscription_plan. Business justification: Broadcast rights agreements are often bundled with subscription plans (e.g., a league pass subscription includes live broadcast access). Linking broadcast_rights to subscription_plan enables rights en',
    `tournament_id` BIGINT COMMENT 'Reference to the specific tournament associated with this broadcast rights agreement. Nullable if the agreement covers an entire league rather than a specific tournament.',
    `advertising_rights` STRING COMMENT 'Extent of advertising rights granted to the rights holder. Full means complete control over ad inventory; limited means restricted ad slots or types; none means no advertising permitted; shared means coordinated advertising with the league.. Valid values are `full|limited|none|shared`',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier or contract number for the broadcast rights agreement. Used for legal and business reference.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the broadcast rights agreement. Tracks the agreement from initial draft through execution, active operation, and eventual termination or renewal. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `content_scope` STRING COMMENT 'Scope of content covered by the broadcast rights. May include live matches, replays, highlights, pre-game and post-game shows, player interviews, behind-the-scenes content, and other ancillary programming.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this broadcast rights record was first created in the system. Used for audit trail and data lineage.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the broadcast rights are exclusive to the rights holder within the specified territory and platform type. True means no other broadcaster can stream in that territory/platform; False means non-exclusive rights.',
    `exclusivity_scope` STRING COMMENT 'Detailed description of the exclusivity terms, including any carve-outs, co-exclusive arrangements, or platform-specific restrictions (e.g., exclusive for streaming but non-exclusive for linear TV).',
    `highlights_rights_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes rights to create and distribute highlight clips and short-form content. True if highlights rights are granted; False otherwise.',
    `language_requirements` STRING COMMENT 'Languages in which the broadcast must be available, including commentary, subtitles, and localization requirements. May specify primary and secondary languages (e.g., English primary, Spanish and Portuguese secondary).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this broadcast rights record was last updated. Used for audit trail and change tracking.',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'Total license fee paid by the rights holder for the broadcast rights over the term of the agreement. Represents the guaranteed minimum payment.',
    `license_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the license fee amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `live_broadcast_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes rights to broadcast live matches and events. True if live broadcasting is permitted; False if only delayed or on-demand content is allowed.',
    `localization_requirements` STRING COMMENT 'Detailed localization requirements beyond language, including cultural adaptations, regional commentary talent, local sponsorship integration, and territory-specific content adjustments.',
    `minimum_guaranteed_viewership` BIGINT COMMENT 'Minimum number of concurrent or cumulative viewers that the rights holder guarantees to deliver as part of the Service Level Agreement (SLA). Nullable if no viewership guarantee exists.',
    `notes` STRING COMMENT 'Free-form notes and additional context about the broadcast rights agreement, including special provisions, historical context, or operational considerations not captured in structured fields.',
    `performance_bonus_structure` STRING COMMENT 'Structure of performance-based bonuses payable to the league or tournament organizer based on viewership milestones, engagement metrics, or other KPIs. Nullable if no performance bonuses exist.',
    `platform_type` STRING COMMENT 'Type of broadcast platform covered by the agreement. Streaming includes OTT and digital platforms; linear TV includes traditional broadcast and cable; in-game spectator refers to native game client viewing.. Valid values are `streaming|linear_tv|in_game_spectator|hybrid|other`',
    `production_quality_standards` STRING COMMENT 'Minimum production quality standards required by the agreement, including resolution (e.g., 1080p, 4K), frame rate (e.g., 60 FPS), audio quality, and technical specifications.',
    `production_responsibility` STRING COMMENT 'Party responsible for producing the broadcast, including camera work, commentary, graphics, and technical production. May be the rights holder, the league/tournament organizer, a shared arrangement, or a contracted third party.. Valid values are `rights_holder|league|shared|third_party`',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an option for the rights holder to renew the broadcast rights for an additional term. True if renewal option exists; False otherwise.',
    `renewal_terms` STRING COMMENT 'Terms and conditions governing the renewal option, including renewal period duration, pricing adjustments, notice period required, and any changes to rights scope or exclusivity.',
    `revenue_share_basis` STRING COMMENT 'Defines the basis on which revenue share is calculated: gross revenue, net revenue after costs, advertising revenue only, subscription revenue only, or not applicable if no revenue share exists.. Valid values are `gross_revenue|net_revenue|advertising_only|subscription_only|not_applicable`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of advertising, subscription, or other broadcast-related revenue that the rights holder must share with the league or tournament organizer. Nullable if the agreement is a flat-fee arrangement with no revenue share.',
    `rights_end_date` DATE COMMENT 'Date when the broadcast rights agreement expires. Nullable for open-ended or perpetual agreements subject to termination clauses.',
    `rights_holder_name` STRING COMMENT 'Name of the organization or entity that holds the broadcast rights (e.g., Twitch, YouTube Gaming, ESPN, NBC Sports).',
    `rights_holder_type` STRING COMMENT 'Classification of the rights holder by platform type. Distinguishes between streaming platforms, traditional television, in-game spectator modes, and other distribution channels. [ENUM-REF-CANDIDATE: streaming_platform|linear_tv|cable_network|digital_network|in_game_spectator|social_media|other — 7 candidates stripped; promote to reference product]',
    `rights_start_date` DATE COMMENT 'Date when the broadcast rights agreement becomes effective and the rights holder may begin broadcasting.',
    `signed_date` DATE COMMENT 'Date when the broadcast rights agreement was signed by all parties. Represents the legal execution date of the contract.',
    `sponsorship_integration_rights` STRING COMMENT 'Rights and restrictions regarding integration of the rights holders own sponsors into the broadcast, including on-screen branding, sponsored segments, and product placement. May include conflict-of-interest clauses with league sponsors.',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the rights holder is permitted to sublicense the broadcast rights to third parties. True if sublicensing is allowed; False if the rights are non-transferable.',
    `sublicensing_terms` STRING COMMENT 'Detailed terms and conditions governing sublicensing, including approval requirements, revenue share on sublicensed deals, and restrictions on sublicensee types or territories.',
    `termination_clause` STRING COMMENT 'Summary of termination conditions and notice requirements, including breach conditions, force majeure provisions, and early termination penalties or buyout terms.',
    `viewership_metric_type` STRING COMMENT 'Type of viewership metric used for the minimum guaranteed viewership SLA. CCU (Concurrent Users), PCU (Peak Concurrent Users), total views, unique viewers, or watch hours.. Valid values are `ccu|pcu|total_views|unique_viewers|watch_hours`',
    `vod_rights_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes rights to offer video-on-demand replays and archived content. True if VOD rights are granted; False if only live or time-limited content is permitted.',
    CONSTRAINT pk_broadcast_rights PRIMARY KEY(`broadcast_rights_id`)
) COMMENT 'Master record for broadcast rights agreements associated with a league or tournament. Captures rights holder name, platform type (streaming, linear TV, in-game spectator), territory/region, exclusivity flag, rights start/end date, license fee, revenue share percentage, minimum guaranteed viewership SLA, language/localization requirements, and agreement status. Distinct from licensing domain — this is esports-specific broadcast rights tied to competitive events.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`sponsorship` (
    `sponsorship_id` BIGINT COMMENT 'Unique identifier for the sponsorship agreement. Primary key for the sponsorship entity.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Sponsorship activations deploy branded asset bundles (in-game banners, loading screens, branded cosmetics). The sponsorship record must reference the deployed bundle for deliverables verification and ',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Sponsor branding assets (logos, banners, in-game overlays) used in broadcasts and venues. Asset tracking required for sponsor deliverable fulfillment, rights compliance, and brand guideline enforcemen',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_campaign. Business justification: Sponsorship activations are executed through specific marketing campaigns; the sponsorship contract references the campaign that delivers sponsor visibility. Esports partnership managers need to link ',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Esports sponsorships involving licensed IP (brand collaborations, co-branded activations) must reference the governing IP agreement for brand usage rights and royalty obligations. Licensing teams requ',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Sponsorship deals subject to jurisdiction-specific advertising regulations, disclosure requirements, and restricted product category rules (alcohol, gambling, tobacco). Required for advertising compli',
    `league_id` BIGINT COMMENT 'Reference to the esports league associated with this sponsorship agreement.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Esports sponsorships are subject to internal advertising and marketing policies (gambling sponsor restrictions, alcohol brand rules, FTC disclosure requirements). Compliance teams must track which pol',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Esports sponsorships are subject to advertising regulatory obligations (ASA rules, FTC disclosure requirements, gambling advertising restrictions). Compliance teams must track which regulatory obligat',
    `storefront_listing_id` BIGINT COMMENT 'Foreign key linking to platform.storefront_listing. Business justification: Esports sponsorship deals include storefront placement deliverables (co-branded featured listings, sponsored content pages). Linking sponsorship to the specific storefront_listing enables tracking of ',
    `team_id` BIGINT COMMENT 'Reference to the esports team associated with this sponsorship agreement, if applicable.',
    `tournament_id` BIGINT COMMENT 'Reference to the specific tournament associated with this sponsorship agreement, if applicable.',
    `activation_type` STRING COMMENT 'Primary method of sponsor brand activation and visibility (jersey patch, stream overlay, naming rights, in-game branding, arena signage, etc.). May contain multiple comma-separated values.',
    `broadcast_rights_included` BOOLEAN COMMENT 'Indicates whether the sponsorship includes rights to sponsor branding in broadcast and streaming content.',
    `contract_number` STRING COMMENT 'Unique business identifier for the sponsorship contract as referenced in legal and finance systems.',
    `contract_signed_date` DATE COMMENT 'Date when the sponsorship contract was executed and signed by all parties.',
    `contracted_value` DECIMAL(18,2) COMMENT 'Total monetary value of the sponsorship agreement in the contract currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sponsorship record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contracted and in-kind values.. Valid values are `^[A-Z]{3}$`',
    `deliverables_list` STRING COMMENT 'Detailed list or summary of contractual deliverables and sponsor benefits to be provided (logo placements, social media posts, hospitality packages, etc.).',
    `digital_rights_included` BOOLEAN COMMENT 'Indicates whether the sponsorship includes rights to sponsor branding in digital channels (social media, websites, mobile apps).',
    `end_date` DATE COMMENT 'Date when the sponsorship agreement expires or terminates.',
    `exclusivity_category` STRING COMMENT 'Product or service category for which the sponsor has exclusive rights within the league, tournament, or team (e.g., energy drinks, gaming peripherals, automotive).',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the sponsorship includes category exclusivity rights preventing competing brands from sponsoring the same property.',
    `hospitality_package_included` BOOLEAN COMMENT 'Indicates whether the sponsorship includes VIP hospitality benefits for sponsor representatives at live events.',
    `in_game_branding_included` BOOLEAN COMMENT 'Indicates whether the sponsorship includes rights to place sponsor branding within the game title itself (virtual billboards, branded items, etc.).',
    `in_kind_value` DECIMAL(18,2) COMMENT 'Estimated monetary value of non-cash contributions provided by the sponsor (products, services, equipment).',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to the sponsorship agreement.',
    `payment_terms` STRING COMMENT 'Description of payment schedule and terms (upfront, installments, milestone-based, etc.).',
    `performance_metrics` STRING COMMENT 'Key performance indicators or metrics used to measure sponsorship effectiveness and ROI (impressions, reach, engagement, brand lift, etc.).',
    `renewal_deadline_date` DATE COMMENT 'Date by which the sponsor must exercise their renewal option, if applicable.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the contract includes an option for the sponsor to renew the agreement for an additional term.',
    `sponsor_contact_email` STRING COMMENT 'Email address of the primary contact person at the sponsoring organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sponsor_contact_name` STRING COMMENT 'Name of the primary contact person at the sponsoring organization for this agreement.',
    `sponsor_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the sponsoring organization.',
    `sponsorship_status` STRING COMMENT 'Current lifecycle status of the sponsorship agreement. [ENUM-REF-CANDIDATE: draft|negotiation|active|suspended|completed|terminated|cancelled — 7 candidates stripped; promote to reference product]',
    `sponsorship_tier` STRING COMMENT 'Classification of sponsorship level indicating prominence and benefits package (title sponsor, presenting sponsor, or tiered levels).. Valid values are `title|presenting|platinum|gold|silver|bronze`',
    `start_date` DATE COMMENT 'Date when the sponsorship agreement becomes effective and sponsor benefits commence.',
    `termination_clause` STRING COMMENT 'Summary of conditions under which either party may terminate the sponsorship agreement early.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sponsorship record was last modified in the system.',
    CONSTRAINT pk_sponsorship PRIMARY KEY(`sponsorship_id`)
) COMMENT 'Master record for sponsorship agreements tied to esports leagues, tournaments, or teams. Captures sponsor name, sponsorship tier (title/presenting/gold/silver), contracted value, in-kind value, activation type (jersey patch, stream overlay, naming rights, in-game branding), start/end date, deliverables list, exclusivity category, renewal option flag, and sponsorship status. Tracks esports-specific commercial partnerships distinct from general marketing campaigns.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`venue` (
    `venue_id` BIGINT COMMENT 'Primary key for venue',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Venues operate under jurisdiction-specific compliance requirements (local gambling laws, safety regulations, tax obligations). country_code is a coarse denormalization of jurisdiction; a proper jurisd',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Physical esports venues connect to a specific network region for LAN event infrastructure provisioning, broadcast uplink routing, and latency guarantees. Event operations teams use this link to pre-pr',
    `parent_venue_id` BIGINT COMMENT 'Self-referencing FK on venue (parent_venue_id)',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Venues hosting esports events must comply with specific regulatory obligations: fire safety codes, accessibility requirements (ADA/DDA), gambling regulations if betting is present on-site. Venue compl',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the venue meets accessibility standards for individuals with disabilities.',
    `address_line_1` STRING COMMENT 'Primary street address of the venue location.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number.',
    `broadcast_infrastructure_tier` STRING COMMENT 'Classification of the venues broadcast and streaming infrastructure capabilities for esports events.',
    `city` STRING COMMENT 'City where the venue is located.',
    `concession_available` BOOLEAN COMMENT 'Indicates whether food and beverage concessions are available at the venue.',
    `contract_expiration_date` DATE COMMENT 'Date when the current venue partnership or rental contract expires.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the venue record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial transactions related to the venue.',
    `email_address` STRING COMMENT 'Primary contact email address for venue booking and event coordination.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent major renovation or upgrade to the venue facilities.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the venue location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the venue location in decimal degrees.',
    `merchandise_store_available` BOOLEAN COMMENT 'Indicates whether an official merchandise store or booth is available at the venue.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the venue record was last modified or updated.',
    `network_bandwidth_gbps` DECIMAL(18,2) COMMENT 'Available network bandwidth in gigabits per second for online tournament connectivity and streaming.',
    `notes` STRING COMMENT 'Additional notes or comments about the venue including special requirements, restrictions, or operational details.',
    `opened_date` DATE COMMENT 'Date when the venue first opened for esports events and operations.',
    `operator_organization` STRING COMMENT 'Name of the organization responsible for day-to-day venue operations and event management.',
    `owner_organization` STRING COMMENT 'Name of the organization or entity that owns the venue.',
    `parking_capacity` STRING COMMENT 'Number of parking spaces available at or near the venue for event attendees.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the venue operations team.',
    `player_station_count` STRING COMMENT 'Number of dedicated gaming stations or player setups available in the venue for competitive play.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the venue address.',
    `practice_room_count` STRING COMMENT 'Number of separate practice or warm-up rooms available for teams at the venue.',
    `preferred_vendor` BOOLEAN COMMENT 'Indicates whether the venue is a preferred or priority partner for esports events.',
    `rental_rate_per_day_usd` DECIMAL(18,2) COMMENT 'Standard daily rental rate for booking the venue for esports events in US dollars.',
    `seating_capacity` STRING COMMENT 'Maximum number of spectators that can be accommodated in the venue for esports events.',
    `standing_capacity` STRING COMMENT 'Maximum number of standing spectators allowed in the venue during esports events.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the venue is located.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the venue location used for event scheduling and broadcast timing.',
    `total_capacity` STRING COMMENT 'Combined maximum capacity including seated and standing spectators for esports events.',
    `venue_code` STRING COMMENT 'Short alphanumeric code used to uniquely identify the venue in tournament systems and broadcasts.',
    `venue_name` STRING COMMENT 'Official name of the esports venue or arena.',
    `venue_status` STRING COMMENT 'Current operational status of the venue in the esports ecosystem.',
    `venue_type` STRING COMMENT 'Classification of the venue based on its primary use and structure for esports events.',
    `vip_suite_count` STRING COMMENT 'Number of VIP suites or premium viewing areas available for sponsors and special guests.',
    `website_url` STRING COMMENT 'Official website URL for the venue providing information and booking details.',
    CONSTRAINT pk_venue PRIMARY KEY(`venue_id`)
) COMMENT 'Master reference table for venue. Referenced by venue_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_player_contract_id` FOREIGN KEY (`player_contract_id`) REFERENCES `gaming_ecm`.`esports`.`player_contract`(`player_contract_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_roster_team_id` FOREIGN KEY (`roster_team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_parent_contract_player_contract_id` FOREIGN KEY (`parent_contract_player_contract_id`) REFERENCES `gaming_ecm`.`esports`.`player_contract`(`player_contract_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `gaming_ecm`.`esports`.`venue`(`venue_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_bracket_id` FOREIGN KEY (`bracket_id`) REFERENCES `gaming_ecm`.`esports`.`bracket`(`bracket_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_match_team_id` FOREIGN KEY (`match_team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_match_winning_team_id` FOREIGN KEY (`match_winning_team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `gaming_ecm`.`esports`.`venue`(`venue_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_bracket_id` FOREIGN KEY (`bracket_id`) REFERENCES `gaming_ecm`.`esports`.`bracket`(`bracket_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_tertiary_game_team_b_esports_team_id` FOREIGN KEY (`tertiary_game_team_b_esports_team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`standing` ADD CONSTRAINT `fk_esports_standing_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`standing` ADD CONSTRAINT `fk_esports_standing_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`standing` ADD CONSTRAINT `fk_esports_standing_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ADD CONSTRAINT `fk_esports_prize_pool_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_parent_allocation_prize_allocation_id` FOREIGN KEY (`parent_allocation_prize_allocation_id`) REFERENCES `gaming_ecm`.`esports`.`prize_allocation`(`prize_allocation_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_prize_pool_id` FOREIGN KEY (`prize_pool_id`) REFERENCES `gaming_ecm`.`esports`.`prize_pool`(`prize_pool_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ADD CONSTRAINT `fk_esports_prize_allocation_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ADD CONSTRAINT `fk_esports_broadcast_rights_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ADD CONSTRAINT `fk_esports_sponsorship_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`venue` ADD CONSTRAINT `fk_esports_venue_parent_venue_id` FOREIGN KEY (`parent_venue_id`) REFERENCES `gaming_ecm`.`esports`.`venue`(`venue_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`esports` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`esports` SET TAGS ('dbx_domain' = 'esports');
ALTER TABLE `gaming_ecm`.`esports`.`league` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`league` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `broadcast_language` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Language');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `broadcast_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(,[a-z]{2,3})*$');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `broadcast_rights_holder` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Rights Holder');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'League Format');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'round_robin|single_elimination|double_elimination|swiss|group_stage|hybrid');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `league_code` SET TAGS ('dbx_business_glossary_term' = 'League Code');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `league_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `league_name` SET TAGS ('dbx_business_glossary_term' = 'League Name');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `league_status` SET TAGS ('dbx_business_glossary_term' = 'League Status');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `league_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|archived');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `league_tier` SET TAGS ('dbx_business_glossary_term' = 'League Tier');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `league_tier` SET TAGS ('dbx_value_regex' = 'T1|T2|T3|amateur|grassroots');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `match_count` SET TAGS ('dbx_business_glossary_term' = 'Match Count');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `organizer_name` SET TAGS ('dbx_business_glossary_term' = 'Organizer Name');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `organizer_type` SET TAGS ('dbx_business_glossary_term' = 'Organizer Type');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `organizer_type` SET TAGS ('dbx_value_regex' = 'first_party|third_party|licensed|co_organized');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `patch_version_end` SET TAGS ('dbx_business_glossary_term' = 'Patch Version End');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `patch_version_end` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `patch_version_start` SET TAGS ('dbx_business_glossary_term' = 'Patch Version Start');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `patch_version_start` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `prize_pool_ceiling_usd` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Ceiling (USD)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `qualification_slots` SET TAGS ('dbx_business_glossary_term' = 'Qualification Slots');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `relegation_slots` SET TAGS ('dbx_business_glossary_term' = 'Relegation Slots');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `season_end_date` SET TAGS ('dbx_business_glossary_term' = 'Season End Date');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `season_name` SET TAGS ('dbx_business_glossary_term' = 'Season Name');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `season_ordinal` SET TAGS ('dbx_business_glossary_term' = 'Season Ordinal Number');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `season_prize_pool_usd` SET TAGS ('dbx_business_glossary_term' = 'Season Prize Pool (USD)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `season_split` SET TAGS ('dbx_business_glossary_term' = 'Season Split');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `season_split` SET TAGS ('dbx_value_regex' = 'spring|summer|fall|winter|annual|none');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `season_start_date` SET TAGS ('dbx_business_glossary_term' = 'Season Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `season_status` SET TAGS ('dbx_business_glossary_term' = 'Season Status');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `season_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Tier');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|none');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `target_ccu` SET TAGS ('dbx_business_glossary_term' = 'Target Concurrent Users (CCU)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `target_pcu` SET TAGS ('dbx_business_glossary_term' = 'Target Peak Concurrent Users (PCU)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `team_count` SET TAGS ('dbx_business_glossary_term' = 'Team Count');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `cert_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Cert Submission Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Community Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `patch_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `broadcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Flag');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `broadcast_platform` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Platform');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `entry_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Entry Fee Amount');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `entry_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Entry Fee Currency Code');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `entry_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Tournament Format');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `max_team_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Team Capacity');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `organizer_type` SET TAGS ('dbx_business_glossary_term' = 'Organizer Type');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `organizer_type` SET TAGS ('dbx_value_regex' = 'first_party|third_party|community');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `peak_ccu` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (CCU)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `prize_pool_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Currency Code');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `prize_pool_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `prize_pool_total` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Total');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `registered_team_count` SET TAGS ('dbx_business_glossary_term' = 'Registered Team Count');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `registration_close_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Date');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `registration_open_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Date');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `rules_document_url` SET TAGS ('dbx_business_glossary_term' = 'Rules Document URL');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Tier');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_value_regex' = 'none|bronze|silver|gold|platinum|title');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `total_viewership` SET TAGS ('dbx_business_glossary_term' = 'Total Viewership');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `tournament_code` SET TAGS ('dbx_business_glossary_term' = 'Tournament Code');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `tournament_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `tournament_description` SET TAGS ('dbx_business_glossary_term' = 'Tournament Description');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `tournament_name` SET TAGS ('dbx_business_glossary_term' = 'Tournament Name');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `tournament_status` SET TAGS ('dbx_business_glossary_term' = 'Tournament Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `venue_location` SET TAGS ('dbx_business_glossary_term' = 'Venue Location');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `venue_type` SET TAGS ('dbx_business_glossary_term' = 'Venue Type');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `venue_type` SET TAGS ('dbx_value_regex' = 'online|lan|hybrid');
ALTER TABLE `gaming_ecm`.`esports`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`team` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Game Title ID');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Team Contact Email Address');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Team Contact Phone Number');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'League Contract Expiry Date');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `current_world_ranking` SET TAGS ('dbx_business_glossary_term' = 'Current World Ranking');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `discord_server_code` SET TAGS ('dbx_business_glossary_term' = 'Discord Server ID');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `founding_date` SET TAGS ('dbx_business_glossary_term' = 'Team Founding Date');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `franchise_fee_paid` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Paid');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `franchise_fee_paid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `franchise_fee_paid` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `general_manager_name` SET TAGS ('dbx_business_glossary_term' = 'General Manager Name');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `head_coach_name` SET TAGS ('dbx_business_glossary_term' = 'Head Coach Name');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Team Headquarters Address');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `is_franchise_team` SET TAGS ('dbx_business_glossary_term' = 'Franchise Team Flag');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Team Verification Status');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `league_championships` SET TAGS ('dbx_business_glossary_term' = 'League Championships Won');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `organization_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Legal Name');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `organization_legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `regional_ranking` SET TAGS ('dbx_business_glossary_term' = 'Regional Ranking');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `roster_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Lock Date');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `roster_lock_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Lock Status');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `roster_size` SET TAGS ('dbx_business_glossary_term' = 'Current Roster Size');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Tier Level');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|unsponsored');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `tag` SET TAGS ('dbx_business_glossary_term' = 'Team Tag Abbreviation');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,5}$');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Team Status');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|disbanded|suspended|on_hiatus');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Team Tier Classification');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|academy|amateur|professional');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `total_prize_money_won` SET TAGS ('dbx_business_glossary_term' = 'Total Prize Money Won');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `total_prize_money_won` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `tournament_wins` SET TAGS ('dbx_business_glossary_term' = 'Total Tournament Wins');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `twitch_channel` SET TAGS ('dbx_business_glossary_term' = 'Twitch Channel Name');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `twitter_handle` SET TAGS ('dbx_business_glossary_term' = 'Twitter Social Media Handle');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `twitter_handle` SET TAGS ('dbx_value_regex' = '^@[A-Za-z0-9_]{1,15}$');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Team Verification Date');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Team Website URL');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `youtube_channel` SET TAGS ('dbx_business_glossary_term' = 'YouTube Channel Name');
ALTER TABLE `gaming_ecm`.`esports`.`roster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`roster` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster ID');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `player_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Player Contract ID');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `roster_team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `age_at_roster_lock` SET TAGS ('dbx_business_glossary_term' = 'Player Age at Roster Lock');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Announcement Date');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roster Approval Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Roster Approved By');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Departure Date');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Player Eligibility Status');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|suspended|pending_review|restricted|retired');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `in_game_name` SET TAGS ('dbx_business_glossary_term' = 'In-Game Name (IGN)');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `is_academy_promotion` SET TAGS ('dbx_business_glossary_term' = 'Is Academy Promotion Flag');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `is_captain` SET TAGS ('dbx_business_glossary_term' = 'Is Team Captain Flag');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `is_starter` SET TAGS ('dbx_business_glossary_term' = 'Is Starter Flag');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `jersey_number` SET TAGS ('dbx_business_glossary_term' = 'Jersey Number');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Join Date');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Lock Date');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Player Nationality');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Roster Notes');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `residency_status` SET TAGS ('dbx_business_glossary_term' = 'Player Residency Status');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `residency_status` SET TAGS ('dbx_value_regex' = 'resident|import|exempt|pending');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `roster_role` SET TAGS ('dbx_business_glossary_term' = 'Roster Role');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `roster_role` SET TAGS ('dbx_value_regex' = 'IGL|support|carry|flex|substitute|coach');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Status');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_loan|injured_reserve|suspended');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `transfer_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Amount');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `transfer_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `transfer_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Currency');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `transfer_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`roster` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Roster Version Number');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `player_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Player Contract ID');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `parent_contract_player_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Contract ID');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `buyout_clause_amount` SET TAGS ('dbx_business_glossary_term' = 'Buyout Clause Amount');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `buyout_clause_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `buyout_clause_currency` SET TAGS ('dbx_business_glossary_term' = 'Buyout Clause Currency Code');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `buyout_clause_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `confidentiality_terms` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Terms');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `confidentiality_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `contract_language` SET TAGS ('dbx_business_glossary_term' = 'Contract Language Code');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `contract_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|completed');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'standard|loan|trial|academy|substitute|free_agent');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|league_tribunal');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `equipment_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Provided Flag');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `exclusivity_clause` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `exclusivity_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `health_insurance_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Provided Flag');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `health_insurance_provided_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `health_insurance_provided_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `housing_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Housing Provided Flag');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `image_rights_terms` SET TAGS ('dbx_business_glossary_term' = 'Image Rights Terms');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `image_rights_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `non_compete_terms` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Terms');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `non_compete_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `performance_bonus_structure` SET TAGS ('dbx_business_glossary_term' = 'Performance Bonus Structure');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `performance_bonus_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `relocation_assistance_amount` SET TAGS ('dbx_business_glossary_term' = 'Relocation Assistance Amount');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `relocation_assistance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Duration (Months)');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Salary Amount');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signing Date');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `streaming_rights_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Streaming Rights Restrictions');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `streaming_rights_restrictions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `tournament_participation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Tournament Participation Requirements');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `broadcast_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Broadcast Language');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `broadcast_rights_holder` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Rights Holder');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `broadcast_rights_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `crowdfunded_amount` SET TAGS ('dbx_business_glossary_term' = 'Crowdfunded Prize Pool Amount');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Season End Date');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Season Format Type');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `is_lan_event` SET TAGS ('dbx_business_glossary_term' = 'Is LAN (Local Area Network) Event');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `max_teams` SET TAGS ('dbx_business_glossary_term' = 'Maximum Teams');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `min_teams` SET TAGS ('dbx_business_glossary_term' = 'Minimum Teams');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `ordinal` SET TAGS ('dbx_business_glossary_term' = 'Season Ordinal Number');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `peak_ccu` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (CCU)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `prize_pool_currency` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Currency');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `prize_pool_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `qualification_slots` SET TAGS ('dbx_business_glossary_term' = 'Qualification Slots');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Competitive Region');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `registered_teams_count` SET TAGS ('dbx_business_glossary_term' = 'Registered Teams Count');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `registration_end_date` SET TAGS ('dbx_business_glossary_term' = 'Registration End Date');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `registration_start_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `relegation_slots` SET TAGS ('dbx_business_glossary_term' = 'Relegation Slots');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `ruleset_version` SET TAGS ('dbx_business_glossary_term' = 'Ruleset Version');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `season_description` SET TAGS ('dbx_business_glossary_term' = 'Season Description');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `season_name` SET TAGS ('dbx_business_glossary_term' = 'Season Name');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `season_status` SET TAGS ('dbx_business_glossary_term' = 'Season Status');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `split` SET TAGS ('dbx_business_glossary_term' = 'Season Split');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `sponsor_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Sponsor');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `sponsor_primary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Season Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Competitive Tier Level');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `total_prize_pool_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Prize Pool Amount');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `total_viewership_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Viewership Hours');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `venue_location` SET TAGS ('dbx_business_glossary_term' = 'Venue Location');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Season Year');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `bracket_id` SET TAGS ('dbx_business_glossary_term' = 'Bracket Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `advancement_rule` SET TAGS ('dbx_business_glossary_term' = 'Advancement Rule');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `average_minute_audience` SET TAGS ('dbx_business_glossary_term' = 'Average Minute Audience (AMA)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `best_of_format` SET TAGS ('dbx_business_glossary_term' = 'Best Of (BO) Format');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `best_of_format` SET TAGS ('dbx_value_regex' = 'bo1|bo3|bo5|bo7|variable');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `bracket_name` SET TAGS ('dbx_business_glossary_term' = 'Bracket Name');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `bracket_status` SET TAGS ('dbx_business_glossary_term' = 'Bracket Status');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `bracket_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|completed|cancelled|suspended');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `bracket_type` SET TAGS ('dbx_business_glossary_term' = 'Bracket Type');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `broadcast_language_codes` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Language Codes');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `broadcast_priority` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Priority');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `broadcast_priority` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|none');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Bracket End Date');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `game_version` SET TAGS ('dbx_business_glossary_term' = 'Game Version');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `grand_final_reset_flag` SET TAGS ('dbx_business_glossary_term' = 'Grand Final Reset Flag');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `match_scheduling_buffer_minutes` SET TAGS ('dbx_business_glossary_term' = 'Match Scheduling Buffer Minutes');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Bracket Notes');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `peak_ccu` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (CCU)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `prize_pool_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Allocation Percentage (PCT)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `replay_review_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Replay Review Enabled Flag');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `round_count` SET TAGS ('dbx_business_glossary_term' = 'Round Count');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `ruleset_version` SET TAGS ('dbx_business_glossary_term' = 'Ruleset Version');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `seeding_method` SET TAGS ('dbx_business_glossary_term' = 'Seeding Method');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `seeding_method` SET TAGS ('dbx_value_regex' = 'manual|performance_based|random_draw|regional_ranking|points_based|previous_stage');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `spectator_mode` SET TAGS ('dbx_business_glossary_term' = 'Spectator Mode');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `spectator_mode` SET TAGS ('dbx_value_regex' = 'live_audience|online_only|hybrid|closed');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `sponsor_tier` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Tier');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `sponsor_tier` SET TAGS ('dbx_value_regex' = 'title|presenting|official|supporting|none');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Bracket Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `team_count` SET TAGS ('dbx_business_glossary_term' = 'Team Count');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `technical_pause_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Pause Allowed Flag');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `third_place_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Place Match Flag');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `tiebreaker_rule` SET TAGS ('dbx_business_glossary_term' = 'Tiebreaker Rule');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `total_viewership` SET TAGS ('dbx_business_glossary_term' = 'Total Viewership');
ALTER TABLE `gaming_ecm`.`esports`.`match` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`match` SET TAGS ('dbx_subdomain' = 'event_operations');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `bracket_id` SET TAGS ('dbx_business_glossary_term' = 'Bracket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Server Instance Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Level Map Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team B Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `match_team_id` SET TAGS ('dbx_business_glossary_term' = 'Team A Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `match_winning_team_id` SET TAGS ('dbx_business_glossary_term' = 'Winning Team Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `average_ccu` SET TAGS ('dbx_business_glossary_term' = 'Average Concurrent Users (CCU)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `best_of_format` SET TAGS ('dbx_business_glossary_term' = 'Best Of (BO) Format');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `best_of_format` SET TAGS ('dbx_value_regex' = 'BO1|BO3|BO5|BO7');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `broadcast_delay_seconds` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Delay in Seconds');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `broadcast_url` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `disqualification_flag` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Flag');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Match Duration in Seconds');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `match_number` SET TAGS ('dbx_business_glossary_term' = 'Match Number');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Match Notes');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `peak_ccu` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (CCU)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `prize_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Prize Currency Code');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `prize_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `prize_pool_amount` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Amount');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `replay_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Replay Available Flag');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `replay_url` SET TAGS ('dbx_business_glossary_term' = 'Replay Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `spectator_mode` SET TAGS ('dbx_business_glossary_term' = 'Spectator Mode');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `spectator_mode` SET TAGS ('dbx_value_regex' = 'live|delayed|none');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `sponsor_tier` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Tier');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `team_a_score` SET TAGS ('dbx_business_glossary_term' = 'Team A Score');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `team_b_score` SET TAGS ('dbx_business_glossary_term' = 'Team B Score');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `technical_pause_count` SET TAGS ('dbx_business_glossary_term' = 'Technical Pause Count');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `technical_pause_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Technical Pause Duration in Seconds');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `total_views` SET TAGS ('dbx_business_glossary_term' = 'Total Views');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` SET TAGS ('dbx_subdomain' = 'event_operations');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_result_id` SET TAGS ('dbx_business_glossary_term' = 'Game Result ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `bracket_id` SET TAGS ('dbx_business_glossary_term' = 'Bracket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Level Map Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Most Valuable Player (MVP) Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Winning Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `server_session_id` SET TAGS ('dbx_business_glossary_term' = 'Server Session Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `tertiary_game_team_b_esports_team_id` SET TAGS ('dbx_business_glossary_term' = 'Team B ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `broadcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Flag');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `competitive_tier` SET TAGS ('dbx_business_glossary_term' = 'Competitive Tier');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `competitive_tier` SET TAGS ('dbx_value_regex' = 'professional|semi_professional|amateur|collegiate|regional|international');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'game_server|tournament_platform|manual_entry|third_party_api');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `disqualification_flag` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Flag');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Game End Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_number` SET TAGS ('dbx_business_glossary_term' = 'Game Number');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Game Start Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_status` SET TAGS ('dbx_business_glossary_term' = 'Game Status');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_status` SET TAGS ('dbx_value_regex' = 'completed|forfeited|disqualified|cancelled|in_progress|paused');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Game Notes');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `pause_count` SET TAGS ('dbx_business_glossary_term' = 'Pause Count');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `prize_pool_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Contribution Flag');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `replay_file_url` SET TAGS ('dbx_business_glossary_term' = 'Replay File URL');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `server_region` SET TAGS ('dbx_business_glossary_term' = 'Server Region');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `side_selection` SET TAGS ('dbx_business_glossary_term' = 'Side Selection Method');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `side_selection` SET TAGS ('dbx_value_regex' = 'team_a_first|team_b_first|random|coin_flip');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `spectator_count` SET TAGS ('dbx_business_glossary_term' = 'Spectator Count');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `team_a_score` SET TAGS ('dbx_business_glossary_term' = 'Team A Score');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `team_a_side` SET TAGS ('dbx_business_glossary_term' = 'Team A Starting Side');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `team_b_score` SET TAGS ('dbx_business_glossary_term' = 'Team B Score');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `team_b_side` SET TAGS ('dbx_business_glossary_term' = 'Team B Starting Side');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `technical_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Technical Issue Description');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `technical_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Issue Flag');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `total_pause_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Pause Duration in Seconds');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|disputed|rejected');
ALTER TABLE `gaming_ecm`.`esports`.`standing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`standing` SET TAGS ('dbx_subdomain' = 'event_operations');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `standing_id` SET TAGS ('dbx_business_glossary_term' = 'Standing ID');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `clinched_playoff` SET TAGS ('dbx_business_glossary_term' = 'Clinched Playoff');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `current_streak` SET TAGS ('dbx_business_glossary_term' = 'Current Streak');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `current_streak` SET TAGS ('dbx_value_regex' = '^[WLD][0-9]+$');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `eliminated` SET TAGS ('dbx_business_glossary_term' = 'Eliminated');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `last_match_date` SET TAGS ('dbx_business_glossary_term' = 'Last Match Date');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `longest_loss_streak` SET TAGS ('dbx_business_glossary_term' = 'Longest Loss Streak');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `longest_win_streak` SET TAGS ('dbx_business_glossary_term' = 'Longest Win Streak');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `map_differential` SET TAGS ('dbx_business_glossary_term' = 'Map Differential');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `maps_lost` SET TAGS ('dbx_business_glossary_term' = 'Maps Lost');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `maps_won` SET TAGS ('dbx_business_glossary_term' = 'Maps Won');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `matches_drawn` SET TAGS ('dbx_business_glossary_term' = 'Matches Drawn');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `matches_lost` SET TAGS ('dbx_business_glossary_term' = 'Matches Lost');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `matches_played` SET TAGS ('dbx_business_glossary_term' = 'Matches Played');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `matches_won` SET TAGS ('dbx_business_glossary_term' = 'Matches Won');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `next_match_date` SET TAGS ('dbx_business_glossary_term' = 'Next Match Date');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `playoff_eligible` SET TAGS ('dbx_business_glossary_term' = 'Playoff Eligible');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `rank_position` SET TAGS ('dbx_business_glossary_term' = 'Rank Position');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `relegation_zone` SET TAGS ('dbx_business_glossary_term' = 'Relegation Zone');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `round_differential` SET TAGS ('dbx_business_glossary_term' = 'Round Differential');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `rounds_lost` SET TAGS ('dbx_business_glossary_term' = 'Rounds Lost');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `rounds_won` SET TAGS ('dbx_business_glossary_term' = 'Rounds Won');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `standing_status` SET TAGS ('dbx_business_glossary_term' = 'Standing Status');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `standing_status` SET TAGS ('dbx_value_regex' = 'active|provisional|final|archived');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `tiebreaker_rank` SET TAGS ('dbx_business_glossary_term' = 'Tiebreaker Rank');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `total_points` SET TAGS ('dbx_business_glossary_term' = 'Total Points');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `win_rate` SET TAGS ('dbx_business_glossary_term' = 'Win Rate');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` SET TAGS ('dbx_subdomain' = 'financial_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `prize_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Esports Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Organizer ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `broadcast_rights_linked` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Rights Linked');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `crowdfund_amount` SET TAGS ('dbx_business_glossary_term' = 'Crowdfunded Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `default_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Tax Withholding Rate');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `distribution_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Completion Date');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'placement_based|point_based|hybrid|custom');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `distribution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `first_place_amount` SET TAGS ('dbx_business_glossary_term' = 'First Place Prize Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'first_party|crowdfunded|sponsor_contributed|mixed');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `minimum_guaranteed_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guaranteed Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Notes');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `number_of_paid_placements` SET TAGS ('dbx_business_glossary_term' = 'Number of Paid Placements');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `payee_type_default` SET TAGS ('dbx_business_glossary_term' = 'Default Payee Type');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `payee_type_default` SET TAGS ('dbx_value_regex' = 'team_organization|individual_player|mixed');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `pool_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Announcement Date');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `pool_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Lock Date');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `pool_name` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Name');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `pool_status` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool Status');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `pool_status` SET TAGS ('dbx_value_regex' = 'draft|active|locked|distributed|closed');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `second_place_amount` SET TAGS ('dbx_business_glossary_term' = 'Second Place Prize Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `sponsor_amount` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contributed Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `tax_withholding_rule` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Rule');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `third_place_amount` SET TAGS ('dbx_business_glossary_term' = 'Third Place Prize Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `total_pool_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Prize Pool Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` SET TAGS ('dbx_subdomain' = 'financial_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `prize_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Prize Allocation ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `parent_allocation_prize_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Allocation ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `prize_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Prize Allocation Number');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^PA-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `bonus_prize_category` SET TAGS ('dbx_business_glossary_term' = 'Bonus Prize Category');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `is_bonus_prize` SET TAGS ('dbx_business_glossary_term' = 'Is Bonus Prize');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `net_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payout Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payee_bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Account ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payee_bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payee_bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Payee Type');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payee_type` SET TAGS ('dbx_value_regex' = 'team_organization|individual_player|mixed');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|paypal|check|crypto|platform_wallet');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|processing|paid|withheld|cancelled');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `placement_description` SET TAGS ('dbx_business_glossary_term' = 'Placement Description');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `placement_rank` SET TAGS ('dbx_business_glossary_term' = 'Placement Rank');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `scheduled_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Date');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Split Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `tax_form_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Issued Date');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `tax_form_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Type');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Rate');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `withholding_reason` SET TAGS ('dbx_business_glossary_term' = 'Withholding Reason');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` SET TAGS ('dbx_subdomain' = 'financial_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `broadcast_rights_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Rights ID');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament ID');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `advertising_rights` SET TAGS ('dbx_business_glossary_term' = 'Advertising Rights');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `advertising_rights` SET TAGS ('dbx_value_regex' = 'full|limited|none|shared');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `content_scope` SET TAGS ('dbx_business_glossary_term' = 'Content Scope');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `highlights_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Highlights Rights Flag');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'License Fee Currency');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `live_broadcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Live Broadcast Flag');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `localization_requirements` SET TAGS ('dbx_business_glossary_term' = 'Localization Requirements');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `minimum_guaranteed_viewership` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guaranteed Viewership');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `performance_bonus_structure` SET TAGS ('dbx_business_glossary_term' = 'Performance Bonus Structure');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `performance_bonus_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'streaming|linear_tv|in_game_spectator|hybrid|other');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `production_quality_standards` SET TAGS ('dbx_business_glossary_term' = 'Production Quality Standards');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `production_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Production Responsibility');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `production_responsibility` SET TAGS ('dbx_value_regex' = 'rights_holder|league|shared|third_party');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `revenue_share_basis` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Basis');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `revenue_share_basis` SET TAGS ('dbx_value_regex' = 'gross_revenue|net_revenue|advertising_only|subscription_only|not_applicable');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `rights_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rights End Date');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Name');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `rights_holder_type` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Type');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `rights_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `sponsorship_integration_rights` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Integration Rights');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `sublicensing_terms` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Terms');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `viewership_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Viewership Metric Type');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `viewership_metric_type` SET TAGS ('dbx_value_regex' = 'ccu|pcu|total_views|unique_viewers|watch_hours');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `vod_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Video on Demand (VOD) Rights Flag');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` SET TAGS ('dbx_subdomain' = 'financial_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Activation Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Branding Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `storefront_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Listing Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `activation_type` SET TAGS ('dbx_business_glossary_term' = 'Activation Type');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `broadcast_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Rights Included');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Contracted Value');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `contracted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `deliverables_list` SET TAGS ('dbx_business_glossary_term' = 'Deliverables List');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `digital_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Included');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship End Date');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `exclusivity_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Category');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `exclusivity_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `hospitality_package_included` SET TAGS ('dbx_business_glossary_term' = 'Hospitality Package Included');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `in_game_branding_included` SET TAGS ('dbx_business_glossary_term' = 'In-Game Branding Included');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `in_kind_value` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Value');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `in_kind_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Notes');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `performance_metrics` SET TAGS ('dbx_business_glossary_term' = 'Performance Metrics');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `renewal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Deadline Date');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Email');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Name');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Phone');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsorship_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Status');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Tier');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_value_regex' = 'title|presenting|platinum|gold|silver|bronze');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `termination_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`venue` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`venue` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue Identifier');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `parent_venue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `rental_rate_per_day_usd` SET TAGS ('dbx_confidential' = 'true');
