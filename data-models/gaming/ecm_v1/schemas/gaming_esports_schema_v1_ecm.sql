-- Schema for Domain: esports | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`esports` COMMENT 'Owns all esports league, tournament, and competitive event data including team rosters, player contracts, bracket structures, match results, prize pool management, broadcast rights, and sponsorship agreements. Tracks CCU/PCU for live events, league standings, and esports revenue streams. Supports both first-party operated leagues and third-party tournament organizer relationships.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`league` (
    `league_id` BIGINT COMMENT 'Unique identifier for the esports league. Primary key.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: League infrastructure (permanent studios, broadcast facilities, technology platforms, esports arenas) is capitalized as projects. Required for asset tracking, capitalization accounting, depreciation, ',
    `certification_checklist_id` BIGINT COMMENT 'Foreign key linking to platform.certification_checklist. Business justification: Professional leagues require game builds meeting specific platform certification standards for competitive integrity. Links league competitive requirements to platform holder technical requirements, e',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Competitive seasons align with major content releases for balance patches, new maps, and competitive-specific content. Live ops teams coordinate league schedules with content roadmaps. Critical for co',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: League overhead costs are allocated to participating teams or titles using allocation methods. Required for accurate cost center reporting and shared service cost allocation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Leagues are cost centers in gaming finance operations. League operational expenses (staff, production, infrastructure) are tracked against dedicated cost centers for budgeting, variance analysis, and ',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Leagues have annual budgets for financial planning and control. Linking enables league-level budget vs actual variance analysis, budget approval workflows, and financial planning.',
    `forum_id` BIGINT COMMENT 'Foreign key linking to community.forum. Business justification: Leagues operate official forums for announcements, rule discussions, and community feedback. Critical for league administration and stakeholder communication.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this league is organized for (e.g., League of Legends, Valorant, Fortnite).',
    `intercompany_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.intercompany_transaction. Business justification: Multi-region leagues involve intercompany revenue allocation and cost sharing between legal entities. Required for intercompany reconciliation, transfer pricing compliance, and consolidation eliminati',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Esports leagues require master IP licensing agreements with game publishers/studios to operate competitive circuits, defining usage rights, revenue share, and prize pool terms. Essential for league op',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Leagues operate under specific regulatory jurisdictions governing licensing, age rating enforcement, data protection, and prize pool regulations. Essential for regulatory filings, compliance audits, a',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Leagues are operated by specific legal entities. Required for financial consolidation, regulatory reporting, legal compliance, and segment reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Leagues require internal operational owners for scheduling coordination, rulebook enforcement, team compliance monitoring, and broadcast logistics. Gaming studios assign dedicated league operations ma',
    `period_close_id` BIGINT COMMENT 'Foreign key linking to finance.period_close. Business justification: League financial results are reconciled during period close for accurate financial reporting. Required for revenue recognition, expense accrual, and financial statement preparation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Leagues generate revenue (sponsorship, media rights, ticket sales) and are tracked as profit centers for financial performance measurement, segment reporting, and EBITDA analysis. Critical for league ',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Leagues require persistent infrastructure allocation across entire seasons (months/years). Operations teams provision dedicated server fleets for league play to ensure consistent performance, isolated',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Professional leagues operate on specific storefronts (PlayStation Network, Xbox Live, Steam) for game distribution, player eligibility verification, and platform-specific competitive rules. Essential ',
    `title_pl_id` BIGINT COMMENT 'Foreign key linking to finance.title_pl. Business justification: League operations contribute revenue and costs to title P&L for game financial performance measurement. Required for title profitability analysis and financial reporting.',
    `age_restriction` STRING COMMENT 'Minimum age requirement for players to participate in the league (none, 13+, 16+, 18+).. Valid values are `none|13+|16+|18+`',
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
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Tournaments must track the exact game build/patch used for competitive integrity, ruleset enforcement, dispute resolution, and post-event analysis. Essential for esports operations where build version',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Major tournaments (especially LAN events) with infrastructure build-out (studios, broadcast facilities, technology platforms) are capitalized as projects. Required for asset tracking, capitalization a',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Tournament costs are allocated across multiple cost centers (production, marketing, operations) using allocation keys. Required for accurate cost center reporting and overhead allocation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tournaments incur direct costs (venue rental, production crew, broadcast equipment, staff travel) tracked against cost centers for event P&L, budget vs actual variance analysis, and cost control. Stan',
    `employee_id` BIGINT COMMENT 'Reference to the organization or entity responsible for organizing and running the tournament (first-party studio or third-party tournament organizer).',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Tournaments have approved budgets for financial planning and control. Linking enables tournament-level budget vs actual tracking, budget approval workflows, and variance analysis for event financial m',
    `forum_id` BIGINT COMMENT 'Foreign key linking to community.forum. Business justification: Tournaments maintain dedicated forums for participant communication, rule clarifications, and fan discussion. Essential for tournament operations and community engagement tracking.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this tournament is organized (e.g., specific competitive game).',
    `intercompany_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.intercompany_transaction. Business justification: Cross-border tournaments involve intercompany charges (e.g., US entity charges EU entity for production services, revenue allocation). Required for intercompany reconciliation, transfer pricing, and c',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Tournaments require IP licensing agreements for game usage rights, prize pool approval, broadcast permissions, and revenue sharing with IP holders. Critical for tournament authorization and compliance',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Tournaments must comply with local gambling laws for prize pools, age restrictions, participant eligibility, and data protection. Required for regulatory approval processes, tax compliance, and legal ',
    `league_id` BIGINT COMMENT 'Reference to the parent esports league if this tournament is part of a league season structure. Null for standalone tournaments.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Tournaments are organized by specific legal entities. Required for liability management, tax reporting, regulatory compliance (gaming licenses, permits), and financial consolidation.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Tournaments are hosted in specific network regions for latency optimization, data residency compliance, and player accessibility. Region determines available infrastructure, CDN topology, and legal ju',
    `period_close_id` BIGINT COMMENT 'Foreign key linking to finance.period_close. Business justification: Tournament financial results must be closed and reconciled during period close processes. Required for accurate financial reporting, revenue recognition, and expense accrual.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tournaments are revenue-generating events (sponsorship, ticket sales, broadcast rights) tracked as profit centers for ROI analysis, financial reporting, and event profitability measurement. Essential ',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Tournaments require dedicated server fleet capacity planning and allocation. Operations teams must reserve infrastructure resources for tournament duration, track costs, and ensure SLA compliance. Ess',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Tournaments require storefront context for game version control, DLC/content requirements, and player account verification. Critical for platform-exclusive tournaments and ensuring all competitors hav',
    `title_pl_id` BIGINT COMMENT 'Foreign key linking to finance.title_pl. Business justification: Tournament revenue and costs flow into title P&L for game-level financial performance tracking. Required for title profitability analysis, ROI measurement, and financial reporting.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the tournament concluded. Null if not yet completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the tournament competition commenced. Null if not yet started.',
    `age_restriction` STRING COMMENT 'Minimum age requirement for participants to register and compete in the tournament, aligned with game rating and legal requirements.. Valid values are `none|13+|16+|18+|21+`',
    `broadcast_flag` BOOLEAN COMMENT 'Indicates whether the tournament is scheduled for live broadcast or streaming (true) or not (false).',
    `broadcast_platform` STRING COMMENT 'Primary streaming or broadcast platform(s) where the tournament will be aired (e.g., Twitch, YouTube Gaming, proprietary platform). Null if not broadcast.',
    `certification_body` STRING COMMENT 'Name of the esports governing body or league authority that certified the tournament (e.g., IGDA, game publisher league authority). Null if not certified.',
    `certification_status` STRING COMMENT 'Certification or approval status for official league/governing body recognition. Not all tournaments require certification.. Valid values are `not_required|pending|certified|rejected`',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Publisher-owned or franchise teams are cost centers for player salaries, coaching staff, facilities, and operational expenses. Required for team budget management, headcount cost tracking, and financi',
    `forum_id` BIGINT COMMENT 'Foreign key linking to community.forum. Business justification: Professional teams maintain official forums for fan interaction, roster announcements, and merchandise. Standard practice for team community management.',
    `guild_id` BIGINT COMMENT 'Foreign key linking to community.guild. Business justification: Professional teams often operate official in-game guilds for fan engagement, recruitment, and brand presence. Standard practice in competitive gaming ecosystem.',
    `intercompany_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.intercompany_transaction. Business justification: Teams owned by different subsidiaries generate intercompany transactions for player transfers, shared services, and cost allocations. Required for intercompany reconciliation and consolidation.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Teams operate under home jurisdiction regulations governing employment law, tax withholding for player salaries, and data protection for player personal data. Essential for contract compliance, regula',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Publisher-owned teams are subsidiaries or divisions of legal entities. Required for financial consolidation, intercompany transactions, and segment reporting in franchise league models.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the primary game title that this team competes in (e.g., League of Legends, Counter-Strike, Valorant). Teams may compete in multiple titles, but this identifies their flagship game.',
    `studio_pl_id` BIGINT COMMENT 'Foreign key linking to finance.studio_pl. Business justification: Publisher-owned teams operated by studios contribute costs to studio P&L. Required for studio cost tracking and financial reporting in franchise league models.',
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
    `secondary_game_title_ids` STRING COMMENT 'Comma-separated list of additional game title IDs that this team competes in beyond their primary title. Supports multi-game organizations.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Player salaries and contract costs are allocated to cost centers for workforce cost tracking, budget management, and P&L reporting. Essential for player cost accounting and financial planning in espor',
    `employee_id` BIGINT COMMENT 'Reference to the player agent or representative who negotiated this contract on behalf of the player, if applicable.',
    `finance_tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.finance_tax_record. Business justification: Player contracts trigger tax withholding obligations (income tax, social security) in multiple jurisdictions. Required for tax compliance, regulatory reporting (1099/W-2), and audit trail.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Player contracts are signed by specific legal entities (publisher subsidiaries, team legal entities). Required for contract liability tracking, legal compliance, tax withholding, and financial consoli',
    `parent_contract_player_contract_id` BIGINT COMMENT 'Reference to the original contract if this is a loan or amendment contract, establishing the contract hierarchy.',
    `player_account_id` BIGINT COMMENT 'Reference to the esports player who is party to this contract.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Season operations have dedicated cost centers for tracking all season-related expenses (production, staff, infrastructure). Required for season budget management and cost control.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Seasons have approved budgets for planning and financial control. Linking enables season-level budget vs actual variance reporting, budget approval workflows, and financial planning.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this season is played on. Identifies which game this competitive season is for.',
    `league_id` BIGINT COMMENT 'Reference to the parent esports league that this season belongs to. Links season to its competitive league structure.',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Competitive seasons define official patch release window for competitive play. FK enables joining to patch certification metadata, release notes, and known issues beyond version strings. Critical for ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Seasons are revenue units (sponsorship, media rights, ticket sales) tracked as profit centers for financial performance measurement and segment reporting. Essential for season P&L and ROI analysis.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Competitive seasons define which storefront version is the official competitive standard, managing platform-specific patches, DLC requirements, and ensuring competitive parity. Essential for cross-pla',
    `title_pl_id` BIGINT COMMENT 'Foreign key linking to finance.title_pl. Business justification: Season financial performance (revenue, costs, EBITDA) rolls up into title P&L for game-level financial reporting. Required for title profitability tracking and financial analysis.',
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
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that created this bracket record. Used for audit trail and accountability in tournament operations.',
    `bracket_employee_id` BIGINT COMMENT 'Reference to the tournament organizer entity responsible for operating this bracket. May be first-party (game publisher) or third-party (external tournament operator). Used for contract management and revenue sharing calculations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Bracket stage production costs (specific to playoff/finals stages) are tracked to cost centers for detailed event cost accounting and stage-level budget tracking.',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Brackets specify which game mode is played (e.g., tournament draft, ranked 5v5) for ruleset definition, player preparation, and spectator clarity. Essential for competitive format specification and en',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title or intellectual property (IP) that this bracket competition is for. Links bracket to the game being played competitively.',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Brackets are structural components of league competitive formats. While brackets are nested within tournaments, they also belong to a league context for organizational and reporting purposes. The busi',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Tournament brackets lock to specific patch releases at bracket start to ensure competitive fairness throughout elimination rounds. Prevents mid-tournament patch changes and enables verification that a',
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
    `compatibility_profile_id` BIGINT COMMENT 'Foreign key linking to platform.compatibility_profile. Business justification: Competitive matches require verified hardware/performance profiles to ensure competitive fairness (frame rate parity, input lag standards, resolution requirements). Essential for LAN tournaments and p',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Match production costs (broadcast crew, server hosting, referee fees, technical staff) are allocated to cost centers for detailed event cost accounting and budget tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the official referee or match administrator assigned to oversee the match and enforce rules.',
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
    `player_feedback_id` BIGINT COMMENT 'Foreign key linking to community.player_feedback. Business justification: Competitive matches generate player feedback on balance, server performance, and competitive integrity. Essential for esports quality assurance and game design iteration.',
    `tournament_id` BIGINT COMMENT 'Reference to the tournament or league in which this match is being played.',
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
    `venue_location` STRING COMMENT 'Physical location or facility name where the match is held for LAN events. Null for online matches.',
    `venue_type` STRING COMMENT 'Physical or virtual venue type where the match is played. Online = remote play, LAN = local area network in-person event, Hybrid = mixed format.. Valid values are `online|lan|hybrid`',
    CONSTRAINT pk_match PRIMARY KEY(`match_id`)
) COMMENT 'Core transactional record for competitive matches encompassing the full match lifecycle from scheduling through post-match analytics. At match header level: date/time, tournament/bracket round, best-of format (BO1/BO3/BO5), venue type (online/LAN), patch version, referee/admin assignment, CCU metrics, match status, and winner determination. At game/map detail level: game number within the series, map/mode played, per-game scores, winning team, duration in seconds, game start/end timestamps, server region, and disqualification flags. At player performance detail level: per-player-per-game KDA (kills/deaths/assists), damage dealt, healing done, objective score, economy score, MVP flag, role-specific KPIs (CS/min for MOBA, headshot rate for FPS, APM for RTS), and game-title-specific stat fields. This is the single source of truth for all competitive match data from header through game results through player statistics.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`game_result` (
    `game_result_id` BIGINT COMMENT 'Unique identifier for the game result record. Primary key for this transactional entity representing a single game (map/round) within a competitive match.',
    `bracket_id` BIGINT COMMENT 'Foreign key linking to esports.bracket. Business justification: Game results occur within the context of a bracket structure. The existing round_id attribute suggests bracket context, but there is no FK to bracket. Individual games are played as part of bracket pr',
    `build_artifact_id` BIGINT COMMENT 'Foreign key linking to title.build_artifact. Business justification: Individual game results need build-level granularity for replay analysis, balance retrospectives, and competitive ruling validation. Replaces denormalized patch_version with FK to authoritative build ',
    `employee_id` BIGINT COMMENT 'Reference to the tournament official or referee who oversaw this game. Used for accountability, dispute resolution, and referee performance tracking.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title (e.g., League of Legends, Counter-Strike, Valorant) this game was played in. Essential for cross-title analytics and esports portfolio management.',
    `level_map_id` BIGINT COMMENT 'Foreign key linking to content.level_map. Business justification: Individual games within matches occur on specific maps. Critical for player performance analysis by map, team map preferences, win rate analytics, and competitive balance tuning. Map_name is denormali',
    `match_id` BIGINT COMMENT 'Reference to the parent match that contains this game. A Best-of-3 (BO3) match produces up to 3 game_result records.',
    `patch_release_id` BIGINT COMMENT 'Foreign key linking to platform.patch_release. Business justification: Individual game results record exact patch release for historical competitive analysis, balance retrospectives, and result validation. Enables joining to patch certification status, known bugs, and ba',
    `player_account_id` BIGINT COMMENT 'Reference to the player awarded MVP (Most Valuable Player) for this game based on performance metrics (kills, assists, objectives, damage). Nullable if MVP is not awarded.',
    `team_id` BIGINT COMMENT 'Reference to the team that won this game. Nullable if the game ended in a draw or was not completed.',
    `round_id` BIGINT COMMENT 'Reference to the tournament round or stage this game belongs to (e.g., Group Stage, Quarterfinals, Grand Finals). Used for bracket progression and standings calculation.',
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
    `game_mode` STRING COMMENT 'The competitive mode or ruleset used for this game (e.g., standard, ranked, tournament, draft). Determines scoring rules and competitive validity. [ENUM-REF-CANDIDATE: standard|ranked|tournament|custom|draft|blind_pick|capture_the_flag|deathmatch — 8 candidates stripped; promote to reference product]',
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
    `division_id` BIGINT COMMENT 'Reference to the division or conference within the league, if applicable.',
    `esports_season_id` BIGINT COMMENT 'Reference to the competitive season for this standing.',
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
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Prize pools often funded by content sales (battle pass, compendium, in-game items). Direct revenue attribution required for financial reporting, content ROI analysis, and crowdfunding transparency. St',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Prize pool expenses are charged to cost centers for tournament cost accounting, budget tracking, and financial reporting. Required for tracking prize pool liabilities and expense recognition in esport',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Prize pools are budgeted line items in tournament financial planning. Linking enables budget vs actual variance analysis, budget approval workflows, and financial control over prize pool commitments. ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Prize pools require internal fund administrators for crowdfunding oversight, sponsor contribution tracking, tax withholding compliance, payment processor coordination, and distribution audit trails. S',
    `game_studio_id` BIGINT COMMENT 'Reference to the organization responsible for managing the tournament and prize pool (first-party or third-party tournament organizer).',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this prize pool is established. Links to the game title master entity.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Prize pools subject to jurisdiction-specific tax withholding rates, gambling regulations, payment processing rules, and prize distribution laws. Essential for tax compliance calculations, regulatory f',
    `league_id` BIGINT COMMENT 'Reference to the esports league or competitive circuit associated with this prize pool. Null for standalone tournaments.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Prize pools are funded and paid by specific legal entities. Required for liability tracking, tax compliance, payment processing, and financial consolidation.',
    `period_close_id` BIGINT COMMENT 'Foreign key linking to finance.period_close. Business justification: Prize pool accruals and payments are reconciled during period close. Required for accurate liability tracking, expense recognition, and financial statement preparation.',
    `royalty_report_id` BIGINT COMMENT 'Foreign key linking to licensing.royalty_report. Business justification: Publisher-funded prize pools often require royalty reporting for revenue share calculations and IP holder financial reconciliation. Links prize pool funding to licensing financial reporting for audit ',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual prize payouts are charged to cost centers for expense tracking, financial reporting, and cost center budget consumption. Required for detailed prize expense accounting and financial control',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this prize allocation for payment. Links to the user/employee entity. Required for audit trail and compliance.',
    `finance_tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.finance_tax_record. Business justification: Prize payments trigger tax withholding and reporting obligations in multiple jurisdictions. Required for tax compliance, regulatory reporting (1099 in US), and audit trail.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Individual prize payments must comply with payees local tax laws, withholding requirements, payment method regulations, and reporting obligations. Required for accurate tax withholding calculation, r',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Prize payments are made by specific legal entities. Required for tax withholding compliance, regulatory reporting (1099/W-2 in US), payment processing, and financial consolidation.',
    `parent_allocation_prize_allocation_id` BIGINT COMMENT 'Reference to the parent prize allocation when this record represents a split or sub-allocation. Used to track hierarchical prize distribution from team to individual players.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Prize disbursements must link to payment records for tax reporting (1099-MISC forms), audit compliance, and reconciliation. Real esports operations (Riot, Valve) track payment_id for each prize alloca',
    `player_account_id` BIGINT COMMENT 'Reference to the individual player receiving this prize allocation. Nullable when prize is awarded to a team organization rather than directly to a player.',
    `prize_pool_id` BIGINT COMMENT 'Reference to the prize pool from which this allocation is drawn. Links to the prize pool entity that defines total available prize money and distribution structure.',
    `royalty_accrual_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_accrual. Business justification: Prize payments to players under revenue-share contracts (common in esports) may be structured as royalties. Linking enables accrual tracking, payment reconciliation, and financial reporting.',
    `support_ticket_id` BIGINT COMMENT 'Foreign key linking to community.support_ticket. Business justification: Prize payment issues (delays, tax questions, banking errors) generate support tickets. Critical for prize operations and player satisfaction tracking.',
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
    `other_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of any additional deductions not captured in tax withholding or platform fees. May include penalties, chargebacks, or contractual adjustments.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Broadcast rights agreements require internal contract owners for negotiation, compliance monitoring, revenue reconciliation, and renewal management. Gaming studios assign media rights managers to over',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Broadcast rights agreements incur production costs, revenue share expenses, and fulfillment costs tracked against cost centers. Required for broadcast rights cost accounting and profitability analysis',
    `deferred_revenue_id` BIGINT COMMENT 'Foreign key linking to finance.deferred_revenue. Business justification: Upfront broadcast rights payments create deferred revenue liabilities recognized over the contract term. Required for revenue recognition compliance (ASC 606), financial reporting, and liability track',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Broadcast rights agreements are IP licensing contracts granting media distribution rights for esports content. Links broadcast rights management to master IP licensing framework for royalty calculatio',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Broadcasting rights governed by territory-specific media regulations, content restrictions, age rating display requirements, and advertising rules. Essential for content compliance verification, regul',
    `league_id` BIGINT COMMENT 'Reference to the esports league associated with this broadcast rights agreement.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Broadcast rights agreements are signed by specific legal entities. Required for revenue recognition, contract management, legal compliance, and financial consolidation.',
    `period_close_id` BIGINT COMMENT 'Foreign key linking to finance.period_close. Business justification: Broadcast rights revenue recognition is reviewed during period close. Required for accurate revenue recognition, deferred revenue reconciliation, and financial statement preparation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Broadcast rights generate licensing revenue tracked to profit centers for media rights P&L analysis, revenue recognition, and segment reporting. Essential for broadcast rights financial performance me',
    `tournament_id` BIGINT COMMENT 'Reference to the specific tournament associated with this broadcast rights agreement. Nullable if the agreement covers an entire league rather than a specific tournament.',
    `advertising_rights` STRING COMMENT 'Extent of advertising rights granted to the rights holder. Full means complete control over ad inventory; limited means restricted ad slots or types; none means no advertising permitted; shared means coordinated advertising with the league.. Valid values are `full|limited|none|shared`',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier or contract number for the broadcast rights agreement. Used for legal and business reference.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the broadcast rights agreement. Tracks the agreement from initial draft through execution, active operation, and eventual termination or renewal. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `compliance_requirements` STRING COMMENT 'Regulatory and industry compliance requirements applicable to the broadcast, including content rating disclosures (ESRB, PEGI), advertising standards (FTC), data protection (GDPR, COPPA), and platform-specific policies.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sponsorship contracts require internal account managers to coordinate deliverables tracking, activation campaigns, renewal negotiations, and sponsor satisfaction reporting. The internal_owner_name fie',
    `brand_partnership_id` BIGINT COMMENT 'Foreign key linking to licensing.brand_partnership. Business justification: Esports sponsorships involving licensed brand integrations (in-game branding, co-marketing) require formal brand partnership agreements defining usage rights, approval workflows, and compliance terms.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Sponsor branding assets (logos, banners, in-game overlays) used in broadcasts and venues. Asset tracking required for sponsor deliverable fulfillment, rights compliance, and brand guideline enforcemen',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sponsorship activation costs (fulfillment, hospitality, production, branding) are charged to cost centers. Required for sponsorship profitability analysis (revenue minus activation costs) and cost tra',
    `deferred_revenue_id` BIGINT COMMENT 'Foreign key linking to finance.deferred_revenue. Business justification: Upfront sponsorship payments create deferred revenue liabilities recognized over the sponsorship period as deliverables are fulfilled. Required for revenue recognition compliance and financial reporti',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Sponsorship deals subject to jurisdiction-specific advertising regulations, disclosure requirements, and restricted product category rules (alcohol, gambling, tobacco). Required for advertising compli',
    `league_id` BIGINT COMMENT 'Reference to the esports league associated with this sponsorship agreement.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Sponsorship contracts are signed by specific legal entities. Required for revenue recognition, contract management, legal compliance, and financial consolidation.',
    `period_close_id` BIGINT COMMENT 'Foreign key linking to finance.period_close. Business justification: Sponsorship revenue recognition is reviewed during period close. Required for accurate revenue recognition, deferred revenue reconciliation, and financial statement preparation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sponsorship revenue is tracked to profit centers for revenue recognition, segment reporting, and sponsorship ROI analysis. Essential for sponsorship financial performance measurement.',
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

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`broadcast_viewership` (
    `broadcast_viewership_id` BIGINT COMMENT 'Primary key for broadcast_viewership',
    `session_id` BIGINT COMMENT 'The unique session identifier assigned by the broadcast platform for this specific live stream. Used for platform-level reconciliation and SLA validation.',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: Broadcast streams are delivered via specific CDN nodes. Operations teams track which CDN nodes serve viewership for performance monitoring, cost allocation, capacity planning, and troubleshooting buff',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Viewership data collection subject to jurisdiction-specific privacy laws (GDPR consent requirements, COPPA restrictions, data localization rules). Required for data protection compliance assessment, c',
    `match_id` BIGINT COMMENT 'Reference to the specific esports match being broadcast. Links this viewership telemetry to the competitive event.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Broadcasts feature promotional assets (sponsor overlays, team logos, event graphics). Tracking asset usage is required for sponsor deliverable verification, rights management compliance, and broadcast',
    `ad_break_active` BOOLEAN COMMENT 'Indicates whether a commercial ad break was active at the time of this measurement. Used for monetization analysis and viewer retention impact assessment.',
    `average_watch_time_minutes` DECIMAL(18,2) COMMENT 'The average duration in minutes that viewers have watched the broadcast, calculated across all viewers at this measurement interval.',
    `bitrate_kbps` STRING COMMENT 'The average streaming bitrate in kilobits per second at this measurement interval. Technical metric for stream quality and CDN performance.',
    `broadcast_language` STRING COMMENT 'The primary language of the broadcast stream, represented as ISO 639-1 two-letter code. Supports multi-language broadcast strategy and regional targeting.',
    `broadcast_platform` STRING COMMENT 'The streaming platform where the esports event was broadcast (e.g., Twitch, YouTube Gaming, Facebook Gaming).. Valid values are `twitch|youtube|facebook_gaming|kick|tiktok_live|trovo`',
    `broadcast_start_timestamp` TIMESTAMP COMMENT 'The timestamp when the live broadcast session began. Establishes the baseline for session duration and lifecycle analysis.',
    `broadcast_status` STRING COMMENT 'The operational status of the broadcast at the time of this measurement. Tracks stream health and continuity for SLA compliance.. Valid values are `live|paused|ended|interrupted|technical_difficulty`',
    `buffering_ratio` DECIMAL(18,2) COMMENT 'The ratio of time spent buffering to total watch time, measured at this interval. Quality of Service (QoS) metric for viewer experience.',
    `ccu` BIGINT COMMENT 'The number of concurrent users watching the broadcast at the time of this measurement interval. Key metric for real-time audience engagement.',
    `chat_message_volume` BIGINT COMMENT 'The cumulative number of chat messages posted by viewers during the broadcast session up to this measurement timestamp. Indicates audience engagement level.',
    `co_stream_count` STRING COMMENT 'The number of authorized co-streams or watch parties running simultaneously for this event at this measurement interval. Amplification and reach metric.',
    `console_viewer_percentage` DECIMAL(18,2) COMMENT 'The percentage of viewers watching via gaming console devices at this measurement interval. Platform distribution metric for audience segmentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this viewership measurement record was created in the data system. Audit trail for data lineage and ETL processing.',
    `desktop_viewer_percentage` DECIMAL(18,2) COMMENT 'The percentage of viewers watching via desktop/PC devices at this measurement interval. Platform distribution metric for audience segmentation.',
    `follower_viewer_count` BIGINT COMMENT 'The number of channel followers watching at this measurement interval. Community engagement and retention metric.',
    `geographic_distribution_snapshot` STRING COMMENT 'A snapshot representation of viewer geographic distribution at this measurement interval, typically stored as JSON or delimited country codes with viewer counts. Supports regional audience analysis.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The exact timestamp when this viewership measurement was captured during the live broadcast. Represents the real-world event time of the telemetry snapshot.',
    `mobile_viewer_percentage` DECIMAL(18,2) COMMENT 'The percentage of viewers watching via mobile devices at this measurement interval. Platform distribution metric for audience segmentation.',
    `new_viewer_count` BIGINT COMMENT 'The number of new viewers who joined the broadcast since the previous measurement interval. Tracks audience growth and discovery during the event.',
    `pcu` BIGINT COMMENT 'The peak concurrent users recorded during this broadcast session up to the measurement timestamp. Represents the maximum simultaneous viewership achieved.',
    `peak_timestamp` TIMESTAMP COMMENT 'The timestamp when the peak concurrent users (PCU) was recorded during this broadcast session. Identifies the moment of maximum audience engagement.',
    `raid_incoming_viewers` BIGINT COMMENT 'The number of viewers who joined via a raid or host from another channel at this measurement interval. Cross-promotion and discovery metric.',
    `sponsorship_overlay_active` BOOLEAN COMMENT 'Indicates whether sponsor branding or overlay graphics were displayed at the time of this measurement. Sponsorship fulfillment and impression tracking.',
    `stream_quality_tier` STRING COMMENT 'The predominant stream quality tier being consumed by viewers at this measurement interval. Indicates technical delivery performance and viewer experience quality. [ENUM-REF-CANDIDATE: source|1080p60|1080p|720p60|720p|480p|360p|audio_only — 8 candidates stripped; promote to reference product]',
    `subscriber_viewer_count` BIGINT COMMENT 'The number of platform subscribers (e.g., Twitch subscribers, YouTube members) watching at this measurement interval. Monetization and loyalty metric.',
    `unique_viewers` BIGINT COMMENT 'The cumulative count of unique individual viewers who have watched any portion of the broadcast session up to this measurement point.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this viewership measurement record was last updated in the data system. Audit trail for data corrections and reprocessing.',
    `viewer_drop_count` BIGINT COMMENT 'The number of viewers who disconnected or stopped watching since the previous measurement interval. Indicates audience retention and engagement fluctuations.',
    `vod_availability` BOOLEAN COMMENT 'Indicates whether a video-on-demand recording will be available after the live broadcast ends. Content strategy and rights management indicator.',
    CONSTRAINT pk_broadcast_viewership PRIMARY KEY(`broadcast_viewership_id`)
) COMMENT 'Transactional record capturing real-time and peak viewership telemetry for live esports broadcast events. Records match reference, broadcast platform, CCU (Concurrent Users) at each measurement interval, PCU (Peak Concurrent Users) for the session, total unique viewers, average watch time in minutes, chat message volume, peak timestamp, geographic distribution snapshot, and stream quality tier. Supports GaaS live operations monitoring, broadcast rights SLA validation, and post-event audience reporting.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`tournament_registration` (
    `tournament_registration_id` BIGINT COMMENT 'Unique identifier for the tournament registration record. Primary key.',
    `age_verification_event_id` BIGINT COMMENT 'Foreign key linking to compliance.age_verification_event. Business justification: Tournament registration triggers age verification for age-restricted tournaments and games requiring parental consent. Essential for eligibility verification, COPPA compliance, and regulatory audit tr',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Tournament entry fees generate invoices for payment processing, refund eligibility tracking, and financial reconciliation. Real esports platforms (ESL, FACEIT) link registrations to billing records fo',
    `player_account_id` BIGINT COMMENT 'Reference to the individual player if registrant_type is individual. Null for team-based registrations.',
    `support_ticket_id` BIGINT COMMENT 'Foreign key linking to community.support_ticket. Business justification: Registration issues (payment failures, eligibility disputes, technical problems) commonly generate support tickets. Critical for tournament operations and player support tracking.',
    `team_id` BIGINT COMMENT 'Reference to the team entity if registrant_type is team, duo, or squad. Null for individual registrations.',
    `tournament_id` BIGINT COMMENT 'Reference to the tournament or qualifier event for which this registration was submitted.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the registration was approved by tournament organizers. Null if not yet approved or if rejected/withdrawn.',
    `check_in_status` STRING COMMENT 'Status of pre-event check-in requirement: not_required (no check-in needed), pending (awaiting check-in), checked_in (confirmed attendance), no_show (failed to check in).. Valid values are `not_required|pending|checked_in|no_show`',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the registrant completed check-in. Null if not yet checked in or check-in not required.',
    `contact_discord` STRING COMMENT 'Discord username or handle for tournament organizer communication. Null if not provided.',
    `contact_email` STRING COMMENT 'Primary email address for tournament communications and notifications to the registrant.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this registration record was first created in the system. Audit trail field.',
    `disqualification_reason` STRING COMMENT 'Reason for registration rejection or disqualification (e.g., ineligible player, incomplete roster, rule violation, payment failure). Null if not disqualified.',
    `eligibility_status` STRING COMMENT 'Status of eligibility verification process: verified (meets all requirements), pending (under review), failed (does not meet requirements), not_checked (verification not yet performed).. Valid values are `verified|pending|failed|not_checked`',
    `eligibility_verified_timestamp` TIMESTAMP COMMENT 'Date and time when eligibility verification was completed. Null if not yet verified.',
    `entry_fee_amount` DECIMAL(18,2) COMMENT 'Entry fee amount charged for tournament registration in USD. Zero for free-to-enter tournaments.',
    `entry_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the entry fee (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text notes or comments from the registrant or tournament organizer regarding this registration (e.g., special accommodations, roster changes, administrative notes).',
    `payment_reference` STRING COMMENT 'External payment transaction reference or receipt number from payment processor. Null if no payment required or not yet paid.',
    `payment_status` STRING COMMENT 'Status of entry fee payment: not_required (free entry), pending (awaiting payment), completed (paid), failed (payment declined), refunded (payment returned).. Valid values are `not_required|pending|completed|failed|refunded`',
    `platform` STRING COMMENT 'Gaming platform the registrant will compete on (PC, PlayStation, Xbox, Nintendo, Mobile, Cross-Platform).. Valid values are `PC|PlayStation|Xbox|Nintendo|Mobile|Cross-Platform`',
    `previous_tournament_wins` STRING COMMENT 'Count of previous tournament wins by this registrant in the same game title or league. Used for seeding and eligibility.',
    `region` STRING COMMENT 'Three-letter geographic region code for the registrant (e.g., NAM for North America, EUR for Europe, ASI for Asia). Used for region-locked tournaments.. Valid values are `^[A-Z]{3}$`',
    `registrant_type` STRING COMMENT 'Type of registrant submitting the entry: team (full roster), individual (solo player), duo (two-player team), or squad (small group).. Valid values are `team|individual|duo|squad`',
    `registration_number` STRING COMMENT 'Externally-visible unique registration confirmation number or code issued to the registrant upon submission.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registration: pending (under review), approved (accepted into tournament), waitlisted (on standby), rejected (denied entry), withdrawn (registrant cancelled), cancelled (tournament organizer cancelled).. Valid values are `pending|approved|waitlisted|rejected|withdrawn|cancelled`',
    `registration_timestamp` TIMESTAMP COMMENT 'Date and time when the registration was submitted by the registrant. Principal business event timestamp.',
    `roster_lock_status` STRING COMMENT 'Status of roster changes: unlocked (changes allowed), locked (no further changes permitted), frozen (administratively locked by organizer).. Valid values are `unlocked|locked|frozen`',
    `roster_lock_timestamp` TIMESTAMP COMMENT 'Date and time when the roster was locked and no further changes are permitted. Null if roster not yet locked.',
    `seed_assignment` STRING COMMENT 'Seeding position assigned to the registrant for bracket placement. Lower numbers indicate higher seeds. Null if seeding not yet assigned or not applicable.',
    `skill_tier` STRING COMMENT 'Skill tier or rank of the registrant at time of registration (e.g., Bronze, Silver, Gold, Platinum, Diamond, Master, Grandmaster). Used for tier-restricted tournaments.',
    `substitution_allowed` BOOLEAN COMMENT 'Indicates whether player substitutions are permitted for this registration per tournament rules. True if allowed, False if not.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this registration record. Audit trail field.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this registration record was last modified. Audit trail field.',
    `waiver_signed` BOOLEAN COMMENT 'Indicates whether the registrant has signed the tournament liability waiver and terms of participation. True if signed, False if not.',
    `waiver_signed_timestamp` TIMESTAMP COMMENT 'Date and time when the waiver was signed. Null if not yet signed.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this registration record. Audit trail field.',
    CONSTRAINT pk_tournament_registration PRIMARY KEY(`tournament_registration_id`)
) COMMENT 'Transactional record capturing a teams or players registration for a tournament or qualifier. Records registrant type (team/individual), registration date, registration status (pending/approved/waitlisted/rejected/withdrawn), seed assignment, check-in status, entry fee payment reference, eligibility verification status, and any disqualification reason. Manages the intake workflow from open registration through roster lock.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`match_incident` (
    `match_incident_id` BIGINT COMMENT 'Unique identifier for the competitive integrity incident or rule violation record.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Serious match incidents (cheating, match-fixing, player misconduct, data breaches during events) may escalate to compliance incidents requiring regulatory notification, player data breach reporting, o',
    `employee_id` BIGINT COMMENT 'Reference to the league official or tournament administrator assigned to investigate and rule on the incident.',
    `league_id` BIGINT COMMENT 'Reference to the esports league under whose rules the incident is being adjudicated.',
    `match_id` BIGINT COMMENT 'Reference to the esports match during which the incident occurred.',
    `player_account_id` BIGINT COMMENT 'Reference to the individual player who reported the incident, if applicable.',
    `team_id` BIGINT COMMENT 'Reference to the team that filed the protest or report, if applicable.',
    `appeal_deadline` TIMESTAMP COMMENT 'The deadline by which an appeal must be filed per league rules.',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether an appeal has been filed against the ruling.',
    `appeal_filed_timestamp` TIMESTAMP COMMENT 'Date and time when the appeal was officially submitted.',
    `appeal_outcome` STRING COMMENT 'The final decision on the appeal, if one was filed.. Valid values are `pending|upheld|overturned|modified|dismissed|withdrawn`',
    `appeal_ruling_timestamp` TIMESTAMP COMMENT 'Date and time when the appeal decision was issued.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was assigned to an administrator for review.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the incident record was first created in the system.',
    `disclosure_timestamp` TIMESTAMP COMMENT 'Date and time when the incident details were publicly disclosed.',
    `evidence_references` STRING COMMENT 'Comma-separated list of evidence artifact identifiers (video clips, screenshots, logs, replay files) supporting the incident report.',
    `game_number` STRING COMMENT 'The specific game number within the match series where the incident occurred (e.g., game 2 of a best-of-5).',
    `in_game_time` TIMESTAMP COMMENT 'The in-game timestamp or match clock time when the incident occurred (e.g., 23:45 game time).',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident, including context, actions, and circumstances.',
    `incident_number` STRING COMMENT 'Human-readable unique incident reference number for tracking and appeals (e.g., INC-2024-0001).',
    `incident_status` STRING COMMENT 'Current lifecycle state of the incident investigation and resolution process. [ENUM-REF-CANDIDATE: reported|under_review|evidence_gathering|pending_ruling|resolved|dismissed|appealed|appeal_upheld|appeal_denied — 9 candidates stripped; promote to reference product]',
    `incident_timestamp` TIMESTAMP COMMENT 'Exact date and time when the incident occurred during the match (in-game or real-world time).',
    `incident_type` STRING COMMENT 'Classification of the competitive integrity incident or rule violation. [ENUM-REF-CANDIDATE: disconnect|cheating_allegation|unsportsmanlike_conduct|technical_failure|rule_protest|equipment_malfunction|player_absence|unauthorized_substitution|communication_violation|other — 10 candidates stripped; promote to reference product]',
    `match_result_affected` BOOLEAN COMMENT 'Indicates whether the incident ruling resulted in a change to the official match result.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the incident record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the incident record was last updated.',
    `notes` STRING COMMENT 'Additional administrative notes, context, or follow-up actions related to the incident.',
    `penalty_amount_usd` DECIMAL(18,2) COMMENT 'Monetary fine amount assessed in United States Dollars, if applicable.',
    `penalty_type` STRING COMMENT 'The type of disciplinary penalty applied as a result of the incident ruling. [ENUM-REF-CANDIDATE: none|warning|fine|match_forfeit|game_forfeit|point_deduction|suspension|disqualification|prize_forfeiture|probation|other — 11 candidates stripped; promote to reference product]',
    `public_disclosure` BOOLEAN COMMENT 'Indicates whether the incident and ruling have been publicly disclosed or remain confidential.',
    `reporting_party_type` STRING COMMENT 'The type of entity that initially reported or flagged the incident. [ENUM-REF-CANDIDATE: team|player|referee|broadcast_observer|league_official|tournament_admin|automated_system|spectator|other — 9 candidates stripped; promote to reference product]',
    `review_start_timestamp` TIMESTAMP COMMENT 'Date and time when the formal review or investigation of the incident began.',
    `ruling_outcome` STRING COMMENT 'The final decision or verdict rendered by the league official on the incident. [ENUM-REF-CANDIDATE: upheld|dismissed|partial_upheld|no_fault_found|technical_issue_confirmed|rematch_ordered|forfeit_declared|warning_issued|inconclusive — 9 candidates stripped; promote to reference product]',
    `ruling_rationale` STRING COMMENT 'Detailed explanation of the reasoning and evidence basis for the ruling outcome.',
    `ruling_timestamp` TIMESTAMP COMMENT 'Date and time when the final ruling or decision on the incident was issued.',
    `severity_level` STRING COMMENT 'The assessed severity or impact level of the incident on competitive integrity.. Valid values are `low|medium|high|critical`',
    `suspension_duration_days` STRING COMMENT 'Number of days the player or team is suspended from competition, if applicable.',
    `suspension_end_date` DATE COMMENT 'The date when the suspension period ends and eligibility is restored.',
    `suspension_start_date` DATE COMMENT 'The date when the suspension period begins.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the incident record.',
    CONSTRAINT pk_match_incident PRIMARY KEY(`match_incident_id`)
) COMMENT 'Operational record for a competitive integrity incident, protest, or rule violation raised during or after a match. Captures incident type (disconnect, cheating allegation, unsportsmanlike conduct, technical failure, rule protest), reporting party, match reference, game number, incident timestamp, description, evidence references, assigned admin, resolution status, ruling outcome, and penalty applied. Supports competitive integrity enforcement and appeals processes.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`match_stat` (
    `match_stat_id` BIGINT COMMENT 'Primary key for match_stat',
    `playable_character_id` BIGINT COMMENT 'Identifier for the specific champion, hero, or character the player selected for this match. Enables meta-analysis and pick/ban trends.',
    `game_result_id` BIGINT COMMENT 'Reference to the parent game result record that this player performance belongs to. Links individual player statistics to the overall match outcome.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title for which these statistics were recorded. Enables cross-title analytics and genre-specific reporting.',
    `player_account_id` BIGINT COMMENT 'Reference to the esports player who achieved these performance statistics. Enables player-level competitive analytics and scouting.',
    `team_id` BIGINT COMMENT 'Reference to the team the player represented during this match. Supports team-level aggregation and roster analysis.',
    `accuracy_percentage` DECIMAL(18,2) COMMENT 'Overall shooting or ability accuracy expressed as a percentage. Measures mechanical precision across applicable game genres.',
    `apm` STRING COMMENT 'RTS-specific metric measuring the number of game actions executed per minute. Indicator of mechanical skill and multitasking ability.',
    `assists` STRING COMMENT 'Total number of assists credited to the player for contributing to enemy eliminations. Core component of KDA ratio.',
    `clutch_rounds_won` STRING COMMENT 'Number of rounds won by the player in outnumbered situations. Indicator of high-pressure performance and decision-making.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this performance record was first created in the system. Audit trail for data lineage and compliance.',
    `crowd_control_duration_seconds` DECIMAL(18,2) COMMENT 'Total duration in seconds that the player applied crowd control effects to enemies. Relevant for support and tank role evaluation.',
    `cs_per_min` DECIMAL(18,2) COMMENT 'MOBA-specific metric tracking the rate of minion/creep kills per minute. Key farming efficiency indicator for carry and mid roles.',
    `damage_dealt` DECIMAL(18,2) COMMENT 'Total damage output inflicted by the player during the match. Key offensive performance metric across multiple game genres.',
    `damage_taken` DECIMAL(18,2) COMMENT 'Total damage absorbed by the player during the match. Relevant for tank and frontline role evaluation.',
    `deaths` STRING COMMENT 'Total number of times the player was eliminated during the match. Core component of KDA ratio and survival analysis.',
    `economy_score` STRING COMMENT 'Measure of the players in-game economic performance including gold earned, resources gathered, or economy management efficiency.',
    `first_blood_flag` BOOLEAN COMMENT 'Boolean indicator of whether the player achieved the first kill of the match. High-value early-game performance marker.',
    `headshot_rate` DECIMAL(18,2) COMMENT 'FPS-specific metric representing the percentage of shots that resulted in headshots. Precision and accuracy indicator.',
    `healing_done` DECIMAL(18,2) COMMENT 'Total healing or health restoration provided by the player to teammates. Critical metric for support role performance.',
    `in_game_name` STRING COMMENT 'The players display name or gamertag used during this specific match. May differ from official roster name for branding or sponsorship reasons.',
    `items_purchased` STRING COMMENT 'Comma-separated list or JSON array of in-game items purchased by the player during the match. Supports build path and itemization analysis.',
    `kills` STRING COMMENT 'Total number of enemy eliminations achieved by the player during the match. Core component of KDA (Kills/Deaths/Assists) ratio.',
    `match_format` STRING COMMENT 'The competitive format of the match in which this performance occurred. Context for interpreting performance under different tournament structures.. Valid values are `best_of_1|best_of_3|best_of_5|single_elimination|round_robin|swiss`',
    `match_timestamp` TIMESTAMP COMMENT 'The date and time when this match performance occurred. Principal business event timestamp for temporal analysis and trend tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this performance record was last updated. Supports change tracking and audit requirements.',
    `multikill_count` STRING COMMENT 'Total number of multikill events (double kills, triple kills, etc.) achieved by the player during the match.',
    `mvp_flag` BOOLEAN COMMENT 'Boolean indicator of whether the player was awarded MVP status for this match based on overall performance metrics.',
    `objective_score` STRING COMMENT 'Aggregate score representing the players contribution to match objectives such as capturing points, securing objectives, or completing mission goals.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Composite performance score calculated from multiple in-game metrics. Standardized rating for cross-player and cross-match comparison.',
    `player_role` STRING COMMENT 'The competitive role or position the player fulfilled during this match. Role-specific KPIs are evaluated based on this classification. [ENUM-REF-CANDIDATE: carry|support|mid|jungle|top|tank|dps|healer|flex|entry_fragger|awper|igl|rifler — 13 candidates stripped; promote to reference product]',
    `side_played` STRING COMMENT 'The map side or faction the player competed on during this match. Relevant for side-balance analysis and map-specific performance. [ENUM-REF-CANDIDATE: blue|red|ct|t|radiant|dire|attacker|defender — 8 candidates stripped; promote to reference product]',
    `stat_source_system` STRING COMMENT 'The system or method by which these performance statistics were captured. Supports data quality assessment and lineage tracking.. Valid values are `game_engine|third_party_api|manual_entry|broadcast_overlay`',
    `time_played_seconds` STRING COMMENT 'Total duration in seconds that the player was active in the match. Used for per-minute stat normalization.',
    `ultimate_ability_uses` STRING COMMENT 'Number of times the player activated their ultimate or signature ability during the match. Tracks high-impact ability usage.',
    `verification_status` STRING COMMENT 'Current verification state of the performance statistics. Ensures data integrity for official league standings and prize distribution.. Valid values are `verified|pending|disputed|corrected`',
    `vision_score` STRING COMMENT 'MOBA-specific metric quantifying the players contribution to map vision through ward placement and enemy ward denial.',
    CONSTRAINT pk_match_stat PRIMARY KEY(`match_stat_id`)
) COMMENT 'Transactional record capturing in-game performance statistics for an individual player within a specific game_result. Stores KDA (kills/deaths/assists), damage dealt, healing done, objective score, economy score, MVP flag, role-specific KPIs (e.g., CS/min for MOBA, headshot rate for FPS, APM for RTS), and game title-specific stat fields. Enables player-level competitive analytics and scouting data.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`transfer` (
    `transfer_id` BIGINT COMMENT 'Unique identifier for the esports player transfer transaction.',
    `team_id` BIGINT COMMENT 'Identifier of the team to which the player is transferring.',
    `employee_id` BIGINT COMMENT 'Identifier of the players agent or representative who negotiated the transfer terms.',
    `league_id` BIGINT COMMENT 'Identifier of the esports league within which this transfer occurs, governing transfer window rules and roster lock compliance.',
    `origin_team_id` BIGINT COMMENT 'Identifier of the team from which the player is transferring. Null for free agent signings.',
    `player_account_id` BIGINT COMMENT 'Identifier of the esports player being transferred between teams.',
    `transfer_window_id` BIGINT COMMENT 'Identifier of the official transfer window period during which this transfer was executed, ensuring compliance with league roster lock rules.',
    `agent_commission_amount` DECIMAL(18,2) COMMENT 'Commission paid to the players agent as part of the transfer transaction. Null if undisclosed or not applicable.',
    `announcement_date` DATE COMMENT 'The date on which the transfer was publicly announced by the teams or league.',
    `announcement_timestamp` TIMESTAMP COMMENT 'Precise timestamp of the public transfer announcement, used for media tracking and fan engagement analytics.',
    `buyout_clause_amount` DECIMAL(18,2) COMMENT 'The contractual buyout amount specified in the players contract that was triggered. Null if no buyout clause was activated.',
    `buyout_clause_triggered` BOOLEAN COMMENT 'Indicates whether this transfer was executed via a pre-existing buyout clause in the players contract, bypassing negotiation.',
    `contract_expiry_date` DATE COMMENT 'The expiry date of the players contract with the origin team at the time of transfer. Null for free agent signings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which the player officially joins the destination team roster and becomes eligible to compete.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary value paid by the destination team to the origin team for the player transfer rights. Zero for free agent signings. Null if undisclosed.',
    `fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the transfer fee (e.g., USD, EUR, KRW).. Valid values are `^[A-Z]{3}$`',
    `league_approval_date` DATE COMMENT 'The date on which the league officially approved the transfer. Null if approval is not required or still pending.',
    `league_approval_required` BOOLEAN COMMENT 'Indicates whether this transfer requires explicit approval from the league governing body before completion.',
    `league_approval_status` STRING COMMENT 'Current status of league approval process for this transfer.. Valid values are `pending|approved|rejected|not_required`',
    `loan_duration_months` STRING COMMENT 'Duration in months for loan-type transfers. Null for permanent transfers and free agent signings.',
    `loan_fee_amount` DECIMAL(18,2) COMMENT 'Fee paid by the destination team to the origin team for the loan period. Null for non-loan transfers.',
    `loan_option_to_buy` BOOLEAN COMMENT 'Indicates whether the loan agreement includes an option for the destination team to purchase the player permanently at the end of the loan period.',
    `medical_clearance_date` DATE COMMENT 'The date on which the player received medical clearance for the transfer. Null if not required or not yet completed.',
    `medical_clearance_required` BOOLEAN COMMENT 'Indicates whether the transfer is contingent upon the player passing a medical or health assessment.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this transfer record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer record was last modified in the system.',
    `notes` STRING COMMENT 'Additional internal notes or comments regarding special circumstances, conditions, or context for this transfer.',
    `option_to_buy_amount` DECIMAL(18,2) COMMENT 'Pre-agreed purchase price if the destination team exercises the option to buy at the end of the loan. Null if no option exists.',
    `performance_bonus_clause` STRING COMMENT 'Description of any performance-based bonus payments owed to the origin team based on the players achievements with the destination team (e.g., tournament wins, MVP awards).',
    `public_announcement_url` STRING COMMENT 'URL link to the official public announcement or press release for this transfer.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the league or parties for why the transfer was rejected or cancelled. Null if transfer was not rejected.',
    `salary_responsibility_percentage` DECIMAL(18,2) COMMENT 'Percentage of the players salary that the origin team continues to pay during a loan transfer. Null for permanent transfers.',
    `sell_on_clause_percentage` DECIMAL(18,2) COMMENT 'Percentage of any future transfer fee that the origin team is entitled to receive if the destination team sells the player to another team. Null if no sell-on clause exists.',
    `social_media_engagement_count` STRING COMMENT 'Aggregate count of social media engagements (likes, shares, comments) on the transfer announcement, used for marketing and fan sentiment analysis.',
    `transfer_number` STRING COMMENT 'Externally-known unique business identifier for this transfer transaction, used in public announcements and league filings.',
    `transfer_status` STRING COMMENT 'Current lifecycle state of the transfer: pending league approval, publicly announced, completed and roster-locked, cancelled by parties, or rejected by league.. Valid values are `pending|announced|completed|cancelled|rejected`',
    `transfer_type` STRING COMMENT 'Classification of the transfer mechanism: permanent transfer, loan, free agent signing, buyout clause activation, or player trade.. Valid values are `permanent|loan|free_agent_signing|buyout|trade`',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this transfer record.',
    CONSTRAINT pk_transfer PRIMARY KEY(`transfer_id`)
) COMMENT 'Transactional record for a player transfer between esports teams, including free agent signings, loans, and buyouts. Captures transfer type, origin team, destination team, transfer fee amount, loan duration, buyout clause triggered flag, transfer window reference, effective date, announcement date, and transfer status. Tracks the competitive roster movement market distinct from the player_contract which governs the ongoing employment terms.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`team_asset_license` (
    `team_asset_license_id` BIGINT COMMENT 'Unique identifier for this team-asset licensing relationship. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the digital asset being licensed to the team',
    `employee_id` BIGINT COMMENT 'Reference to the user (legal, brand manager, or esports operations) who approved this license. Required for audit trail and IP rights management.',
    `team_id` BIGINT COMMENT 'Foreign key linking to the esports team that holds usage rights for the asset',
    `approval_date` DATE COMMENT 'Date when the license was approved for team use. Used for compliance reporting and audit trails.',
    `approval_status` STRING COMMENT 'Current approval status of the license agreement. Pending licenses cannot be used in official competition. Sourced from detection phase relationship data.',
    `asset_type` STRING COMMENT 'Classification of the asset being licensed (logo, jersey, promotional material, in-game skin, sponsor asset). Determines usage restrictions and approval workflows. Sourced from detection phase relationship data.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this license record was created in the system.',
    `exclusivity_flag` BOOLEAN COMMENT 'Boolean indicating whether this team has exclusive rights to this asset (true) or if the asset may be licensed to other teams (false). Critical for sponsor asset management.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this license record was last updated. Used for change tracking and audit.',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'Fee paid by the team (or sponsor) for usage rights to this asset. May be zero for team-owned assets or sponsor-provided assets.',
    `license_terms` STRING COMMENT 'Legal terms and conditions governing the teams usage of this asset, including permitted contexts (competitive play, broadcast, social media), geographic restrictions, and exclusivity clauses. Sourced from detection phase relationship data.',
    `logo_asset_url` STRING COMMENT 'URL or reference path to the teams official logo asset stored in the content delivery network (CDN) or digital asset management system. Used for broadcasts, websites, and marketing materials. [Moved from esports_team: This attribute (logo_asset_url) in esports_team represents a specific team-asset relationship and should be modeled as a license record in the association. A team may have multiple logo variants (primary, alternate, sponsor co-branded) with different usage rights and approval dates. Moving this to the association allows tracking of multiple logo licenses with proper versioning and rights management.]',
    `usage_context` STRING COMMENT 'Specific contexts where the team is permitted to use this asset (competitive play, broadcast, social media, merchandise, marketing). Enforces licensing restrictions.',
    `usage_rights_end_date` DATE COMMENT 'The date when the teams usage rights for this asset expire. Used to enforce license renewal workflows and prevent unauthorized usage. Sourced from detection phase relationship data.',
    `usage_rights_start_date` DATE COMMENT 'The date when the teams usage rights for this asset become active. Critical for tournament eligibility and brand compliance. Sourced from detection phase relationship data.',
    `version_number` STRING COMMENT 'Specific version of the asset that this license covers. Teams must use the licensed version to maintain brand consistency and compliance. Sourced from detection phase relationship data.',
    CONSTRAINT pk_team_asset_license PRIMARY KEY(`team_asset_license_id`)
) COMMENT 'This association product represents the licensing agreement between an esports team and a digital asset. It captures the legal rights, usage terms, and approval workflow for teams to use specific assets (logos, jerseys, promotional materials, in-game skins, sponsor assets) in competitive play, broadcasts, and marketing. Each record links one esports team to one asset with licensing terms, usage rights periods, approval status, and asset version tracking that exist only in the context of this IP rights relationship.. Existence Justification: In esports operations, teams actively manage licensing relationships for multiple digital assets (team logos, jersey designs, promotional graphics, in-game skins, sponsor-provided assets) with specific usage rights, approval workflows, and time-bound terms. Simultaneously, individual assets (particularly sponsor logos and shared promotional materials) are licensed to multiple teams under different terms. The business recognizes these as Team Asset Licenses that require active management for IP compliance, tournament eligibility, and brand governance.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`tournament_promotion` (
    `tournament_promotion_id` BIGINT COMMENT 'Unique identifier for this specific promotion-tournament activation record. Primary key.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to the promotional pricing event activated for this tournament',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to the esports tournament during which this promotion is active',
    `activation_status` STRING COMMENT 'Current status of this promotion activation for this tournament: scheduled (not yet started), active (currently running), paused (temporarily disabled), completed (ended normally), cancelled (terminated early).',
    `conversion_count` BIGINT COMMENT 'Number of times players redeemed this promotion during this specific tournament. Tournament-specific conversion metric.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotion expired for this specific tournament. May differ from the promotions global end_timestamp if the promotion is deactivated at different times for different tournaments.',
    `impression_count` BIGINT COMMENT 'Number of times this promotion was displayed to players during this specific tournament. Tournament-specific metric for ROI analysis.',
    `priority` STRING COMMENT 'Display priority ranking for this promotion within the context of this specific tournament. Determines ordering when multiple promotions are active during the same tournament event.',
    `revenue_generated` DECIMAL(18,2) COMMENT 'Total gross revenue generated from this promotion during this specific tournament. Tournament-specific revenue attribution for promotional ROI analysis.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when this promotion became active for this specific tournament. May differ from the promotions global start_timestamp if the promotion is activated at different times for different tournaments.',
    CONSTRAINT pk_tournament_promotion PRIMARY KEY(`tournament_promotion_id`)
) COMMENT 'This association product represents the Event between promotion and tournament. It captures the activation of a specific promotional pricing event within the context of a specific esports tournament, tracking performance metrics and timing for each promotion-tournament pairing. Each record links one promotion to one tournament with attributes that exist only in the context of this relationship.. Existence Justification: In gaming monetization operations, promotional pricing events are strategically activated across multiple esports tournaments to drive in-game purchase conversions during high-engagement competitive events. A single promotion (e.g., 20% off battle pass) can run concurrently across multiple tournaments (Spring Championship, Regional Qualifiers, Community Cup), and each tournament features multiple concurrent promotions targeting different player segments or product categories. The business actively manages these promotion-tournament activations as discrete marketing events, tracking performance metrics (impressions, conversions, revenue) per tournament to optimize promotional calendars and calculate tournament-specific ROI.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` (
    `tournament_asset_usage_id` BIGINT COMMENT 'Unique identifier for this tournament asset usage record. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the digital asset being used in the tournament',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to the tournament where the asset is used',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage record was created in the system.',
    `display_duration_seconds` STRING COMMENT 'Duration in seconds that the asset is displayed or used during the tournament broadcast or event. Null for static assets without time constraints. Identified in detection phase.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage record was last modified.',
    `placement_location` STRING COMMENT 'Physical or virtual location where the asset is placed (e.g., top-right overlay, center stage screen, pre-match intro, post-match recap). Identified in detection phase.',
    `rights_clearance_status` STRING COMMENT 'Status of rights clearance for using this asset in this specific tournament context. Critical for legal compliance and sponsor contract fulfillment. Identified in detection phase.',
    `sponsor_attribution` STRING COMMENT 'Sponsor or brand associated with this asset usage, used for sponsor deliverable tracking and reporting. Null if not sponsor-related. Identified in detection phase.',
    `usage_context` STRING COMMENT 'The specific context or purpose for which the asset is used in the tournament (e.g., broadcast overlay, sponsor logo placement, promotional video, stream graphic). Identified in detection phase.',
    `usage_status` STRING COMMENT 'Current status of this asset usage in the tournament lifecycle (planned, active during event, completed, cancelled, replaced by another asset).',
    `usage_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset was deployed or first used in the tournament. Used for audit trail and sponsor reporting. Identified in detection phase.',
    `created_by` STRING COMMENT 'User or system that created this tournament asset usage record.',
    CONSTRAINT pk_tournament_asset_usage PRIMARY KEY(`tournament_asset_usage_id`)
) COMMENT 'This association product represents the usage relationship between tournaments and digital assets. It captures the operational tracking of which assets (logos, overlays, sponsor graphics, promotional videos) are deployed in which tournaments, including usage context, placement, duration, and rights compliance. Each record links one tournament to one asset with attributes that exist only in the context of this specific usage instance.. Existence Justification: In esports tournament operations, tournaments use multiple digital assets (logos, overlays, sponsor graphics, promotional videos) across different contexts (broadcast, venue, social media), and assets are reused across multiple tournaments. Tournament organizers actively manage asset usage as part of sponsor deliverable fulfillment, broadcast production, and rights compliance. This is an operational relationship with specific usage data (context, placement, duration, rights status) that belongs to neither the tournament nor the asset alone.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`team_event_participation` (
    `team_event_participation_id` BIGINT COMMENT 'Unique identifier for this team-event participation record. Primary key.',
    `community_event_id` BIGINT COMMENT 'Foreign key linking to the community event in which the team is participating',
    `team_id` BIGINT COMMENT 'Foreign key linking to the esports team participating in the community event',
    `appearance_fee` DECIMAL(18,2) COMMENT 'The monetary compensation paid to the team for participating in this specific community event. Varies by event, team popularity, and participation type. Identified in detection phase as compensation.',
    `attendance_count` STRING COMMENT 'The number of team members (players, coaches, staff) who attended this specific community event on behalf of the team. Identified in detection phase as engagement metric.',
    `confirmation_date` DATE COMMENT 'The date when the team confirmed their participation in this community event.',
    `confirmation_status` STRING COMMENT 'Current status of the teams participation commitment for this event. Tracks the lifecycle from invitation through completion.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this participation record was created in the system.',
    `engagement_score` DECIMAL(18,2) COMMENT 'Calculated metric representing the teams engagement quality at this event based on attendance, social media activity, fan interactions, and post-event metrics.',
    `event_role` STRING COMMENT 'The specific role or function the team fulfilled at this community event (e.g., Headliner, Opening Act, Panelist, Demo Team). Identified in detection phase.',
    `invitation_date` DATE COMMENT 'The date when the team was invited to participate in this community event.',
    `participation_type` STRING COMMENT 'Classification of how the team is participating in the community event. Drives expectations, compensation structure, and engagement requirements. Identified in detection phase.',
    `social_media_reach` BIGINT COMMENT 'Total social media impressions generated by the teams participation in this specific community event across all platforms.',
    `sponsorship_tier` STRING COMMENT 'The sponsorship level at which the team is supporting this specific community event. Different from the teams general sponsorship_tier attribute. Identified in detection phase.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this participation record was last modified.',
    CONSTRAINT pk_team_event_participation PRIMARY KEY(`team_event_participation_id`)
) COMMENT 'This association product represents the participation relationship between esports teams and community events. It captures the business arrangement when an esports team participates in, sponsors, or appears at a community-organized event. Each record links one esports team to one community event with attributes that describe the nature and terms of that specific participation.. Existence Justification: In gaming and esports operations, teams participate in multiple community events throughout the year (meet-and-greets, charity streams, fan tournaments, AMAs, signing events), and each community event typically features multiple teams to drive engagement and attendance. The business actively manages these participation arrangements as operational records with specific terms (appearance fees, participation type, roles) and tracks engagement outcomes (attendance count, social media reach, engagement scores) for each team-event combination.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` (
    `league_influencer_partnership_id` BIGINT COMMENT 'Primary key for league_influencer_partnership',
    `influencer_id` BIGINT COMMENT 'Foreign key linking to the influencer partner engaged for league promotion',
    `league_id` BIGINT COMMENT 'Foreign key linking to the esports league that is the subject of the influencer partnership',
    `brand_safety_guidelines` STRING COMMENT 'Specific brand safety and content guidelines the influencer must follow when creating content for this league.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The total compensation amount paid to the influencer for this specific league partnership. Explicitly identified in detection phase relationship data.',
    `compensation_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the compensation amount (e.g., USD, EUR, GBP).',
    `content_approval_required` BOOLEAN COMMENT 'Indicates whether the league/company requires pre-approval of influencer content before publication for this partnership.',
    `content_deliverables` STRING COMMENT 'Description of the specific content obligations the influencer must deliver for this league (e.g., 2 livestreams per week during season, 5 social posts per month, opening ceremony coverage). Explicitly identified in detection phase relationship data.',
    `exclusivity_scope` STRING COMMENT 'Defines the exclusivity restrictions for this partnership (e.g., no competing FPS league coverage, exclusive for this game title, non-exclusive). Explicitly identified in detection phase relationship data.',
    `partnership_end_date` DATE COMMENT 'The date when this league-influencer partnership agreement expires or terminates. Explicitly identified in detection phase relationship data.',
    `partnership_start_date` DATE COMMENT 'The date when this league-influencer partnership agreement becomes effective. Explicitly identified in detection phase relationship data.',
    `partnership_status` STRING COMMENT 'Current operational status of this league-influencer partnership (draft, active, completed, terminated, suspended).',
    `performance_metrics_target` STRING COMMENT 'Specific performance targets or KPIs agreed for this partnership (e.g., minimum 50K views per stream, engagement rate >5%, drive 1000 installs).',
    CONSTRAINT pk_league_influencer_partnership PRIMARY KEY(`league_influencer_partnership_id`)
) COMMENT 'This association product represents the contractual partnership between an esports league and an influencer/content creator. It captures the business agreement governing content creation, promotional activities, and compensation for influencer coverage of league events. Each record links one league to one influencer with partnership-specific terms, deliverables, exclusivity scope, and financial arrangements that exist only in the context of this marketing relationship.. Existence Justification: In the gaming industry, esports leagues routinely engage multiple influencers to create content, drive viewership, and promote events across different platforms and audience segments. Simultaneously, successful influencers partner with multiple leagues (e.g., covering both League of Legends LCS and Valorant Champions Tour) to diversify their content portfolio and revenue streams. Each league-influencer partnership is a distinct contractual relationship with its own terms, deliverables, compensation, and exclusivity scope.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`venue` (
    `venue_id` BIGINT COMMENT 'Primary key for venue',
    `parent_venue_id` BIGINT COMMENT 'Self-referencing FK on venue (parent_venue_id)',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the venue meets accessibility standards for individuals with disabilities.',
    `address_line_1` STRING COMMENT 'Primary street address of the venue location.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number.',
    `broadcast_infrastructure_tier` STRING COMMENT 'Classification of the venues broadcast and streaming infrastructure capabilities for esports events.',
    `city` STRING COMMENT 'City where the venue is located.',
    `concession_available` BOOLEAN COMMENT 'Indicates whether food and beverage concessions are available at the venue.',
    `contract_expiration_date` DATE COMMENT 'Date when the current venue partnership or rental contract expires.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the venue is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the venue record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial transactions related to the venue.',
    `email_address` STRING COMMENT 'Primary contact email address for venue booking and event coordination.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent major renovation or upgrade to the venue facilities.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the venue location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the venue location in decimal degrees.',
    `merchandise_store_available` BOOLEAN COMMENT 'Indicates whether an official merchandise store or booth is available at the venue.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the venue record was last modified or updated.',
    `venue_name` STRING COMMENT 'Official name of the esports venue or arena.',
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
    `venue_status` STRING COMMENT 'Current operational status of the venue in the esports ecosystem.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the venue location used for event scheduling and broadcast timing.',
    `total_capacity` STRING COMMENT 'Combined maximum capacity including seated and standing spectators for esports events.',
    `venue_code` STRING COMMENT 'Short alphanumeric code used to uniquely identify the venue in tournament systems and broadcasts.',
    `venue_type` STRING COMMENT 'Classification of the venue based on its primary use and structure for esports events.',
    `vip_suite_count` STRING COMMENT 'Number of VIP suites or premium viewing areas available for sponsors and special guests.',
    `website_url` STRING COMMENT 'Official website URL for the venue providing information and booking details.',
    CONSTRAINT pk_venue PRIMARY KEY(`venue_id`)
) COMMENT 'Master reference table for venue. Referenced by venue_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`round` (
    `round_id` BIGINT COMMENT 'Primary key for round',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title being played in this round.',
    `tournament_id` BIGINT COMMENT 'Reference to the parent tournament or league that this round belongs to.',
    `venue_id` BIGINT COMMENT 'Reference to the physical or virtual venue where this round is hosted.',
    `previous_round_id` BIGINT COMMENT 'Self-referencing FK on round (previous_round_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the round concluded.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the round commenced, capturing the real-world event time.',
    `advancement_count` STRING COMMENT 'Number of teams or players that advance from this round to the next stage.',
    `average_concurrent_users` BIGINT COMMENT 'Average number of concurrent viewers/users throughout the duration of this round.',
    `best_of_format` STRING COMMENT 'Number of games in the best-of series for matches in this round (e.g., 1 for Bo1, 3 for Bo3, 5 for Bo5).',
    `bracket_type` STRING COMMENT 'Indicates which bracket this round belongs to in double-elimination or multi-bracket tournament structures.',
    `broadcast_language` STRING COMMENT 'Primary language(s) for broadcast coverage of this round (e.g., English, Spanish, Multi-language).',
    `broadcast_rights_holder` STRING COMMENT 'Name of the organization or platform holding exclusive or primary broadcast rights for this round.',
    `completed_matches` STRING COMMENT 'Number of matches that have been completed in this round.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this round record was first created in the system.',
    `elimination_count` STRING COMMENT 'Number of teams or players that are eliminated from the tournament after this round.',
    `game_version` STRING COMMENT 'Specific version or patch of the game being used for this round (e.g., 12.4.1, Season 3 Patch 2).',
    `is_online` BOOLEAN COMMENT 'Flag indicating whether this round is conducted online (true) or at a physical venue (false).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this round record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this round.',
    `peak_concurrent_users` BIGINT COMMENT 'Maximum number of concurrent viewers/users watching or participating during this round across all platforms.',
    `primary_sponsor_name` STRING COMMENT 'Name of the primary or title sponsor for this round.',
    `prize_pool_amount` DECIMAL(18,2) COMMENT 'Total prize money allocated specifically for this round, if applicable.',
    `prize_pool_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the prize pool amount (e.g., USD, EUR, GBP).',
    `region` STRING COMMENT 'Geographic region or territory where this round is conducted (e.g., North America, Europe, Asia-Pacific, Global).',
    `round_code` STRING COMMENT 'Short alphanumeric code used for external identification and reporting (e.g., GS, QF, SF, GF).',
    `round_name` STRING COMMENT 'Human-readable name or label for the round (e.g., Group Stage, Quarterfinals, Grand Finals, Upper Bracket Round 1).',
    `round_number` STRING COMMENT 'Sequential number indicating the position of this round within the tournament bracket structure (e.g., 1 for first round, 2 for quarterfinals).',
    `round_status` STRING COMMENT 'Current lifecycle state of the round indicating its operational status.',
    `round_type` STRING COMMENT 'Classification of the round format indicating the bracket structure and elimination rules.',
    `ruleset_version` STRING COMMENT 'Version identifier of the tournament ruleset governing this round.',
    `scheduled_end_date` DATE COMMENT 'Planned date when the round is scheduled to conclude.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the round is scheduled to begin.',
    `seeding_method` STRING COMMENT 'Method used to seed teams or players into this round (e.g., based on ranking, regional performance, or random draw).',
    `sponsor_tier` STRING COMMENT 'Classification of the primary sponsorship level for this round.',
    `total_matches` STRING COMMENT 'Total number of matches scheduled to be played in this round.',
    `total_viewership` BIGINT COMMENT 'Total unique viewers who watched any portion of this round across all broadcast channels and platforms.',
    CONSTRAINT pk_round PRIMARY KEY(`round_id`)
) COMMENT 'Master reference table for round. Referenced by round_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`division` (
    `division_id` BIGINT COMMENT 'Primary key for division',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this division is organized (e.g., League of Legends, Counter-Strike, Valorant).',
    `league_id` BIGINT COMMENT 'Reference to the parent esports league to which this division belongs.',
    `organizer_id` BIGINT COMMENT 'Reference to the tournament organizer or entity responsible for operating this division (first-party or third-party).',
    `esports_season_id` BIGINT COMMENT 'Reference to the current or most recent competitive season associated with this division.',
    `parent_division_id` BIGINT COMMENT 'Self-referencing FK on division (parent_division_id)',
    `average_ccu` STRING COMMENT 'Average number of concurrent viewers across all broadcast channels during division matches.',
    `broadcast_rights_holder` STRING COMMENT 'Name of the organization or entity holding exclusive broadcast rights for this division.',
    `division_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the division for operational and reporting purposes (e.g., PREM, CHAL, REG_NA).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this division record was first created in the system.',
    `current_team_count` STRING COMMENT 'Current number of teams actively registered and participating in this division.',
    `division_description` STRING COMMENT 'Detailed textual description of the division, including its purpose, competitive structure, and unique characteristics.',
    `end_date` DATE COMMENT 'Official end date when the division concludes or is scheduled to conclude. Null for ongoing divisions.',
    `format` STRING COMMENT 'Tournament or competition format used within this division (e.g., round robin, single elimination, Swiss system).',
    `is_franchised` BOOLEAN COMMENT 'Indicates whether this division operates under a franchised model with permanent team slots (true) or an open promotion/relegation system (false).',
    `match_schedule_type` STRING COMMENT 'Frequency and pattern of scheduled matches within this division.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age in years required for players to participate in this division.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this division record was last modified.',
    `division_name` STRING COMMENT 'Official name of the esports division (e.g., Premier League, Challenger Division, Regional Championship).',
    `peak_ccu` STRING COMMENT 'Peak number of concurrent viewers recorded during any single division match or event.',
    `prize_pool_amount` DECIMAL(18,2) COMMENT 'Total monetary prize pool allocated for this division, in the base currency.',
    `prize_pool_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the prize pool amount (e.g., USD, EUR, GBP).',
    `promotion_slots` STRING COMMENT 'Number of teams that can be promoted from this division to a higher tier at the end of the season.',
    `region_code` STRING COMMENT 'Three-letter ISO code representing the geographic region this division serves (e.g., USA, EUR, KOR, CHN).',
    `registration_close_date` DATE COMMENT 'Date when team registration for this division closes.',
    `registration_open_date` DATE COMMENT 'Date when team registration for this division opens.',
    `relegation_slots` STRING COMMENT 'Number of teams that will be relegated from this division to a lower tier at the end of the season.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of division revenue shared with participating teams, if applicable.',
    `ruleset_version` STRING COMMENT 'Version identifier of the official ruleset governing competition in this division.',
    `sponsorship_tier` STRING COMMENT 'Classification of the primary sponsorship level secured for this division.',
    `start_date` DATE COMMENT 'Official start date when the division becomes active and competition begins.',
    `division_status` STRING COMMENT 'Current operational status of the division in its lifecycle.',
    `team_capacity` STRING COMMENT 'Maximum number of teams that can participate in this division.',
    `tier` STRING COMMENT 'Competitive tier or level of the division indicating skill level and prestige (e.g., tier 1 for top-level professional, tier 2 for semi-professional, amateur for grassroots).',
    CONSTRAINT pk_division PRIMARY KEY(`division_id`)
) COMMENT 'Master reference table for division. Referenced by division_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`transfer_window` (
    `transfer_window_id` BIGINT COMMENT 'Primary key for transfer_window',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title this transfer window applies to (e.g., specific MOBA, FPS, or battle royale title).',
    `league_id` BIGINT COMMENT 'Reference to the esports league this transfer window applies to.',
    `esports_season_id` BIGINT COMMENT 'Reference to the competitive season during which this transfer window occurs.',
    `previous_transfer_window_id` BIGINT COMMENT 'Self-referencing FK on transfer_window (previous_transfer_window_id)',
    `allows_free_agents` BOOLEAN COMMENT 'Indicates whether teams are permitted to sign free agent players (not currently under contract) during this window.',
    `allows_loans` BOOLEAN COMMENT 'Indicates whether teams are permitted to loan players to other teams temporarily during this window.',
    `allows_releases` BOOLEAN COMMENT 'Indicates whether teams are permitted to release players from their contracts during this window.',
    `allows_trades` BOOLEAN COMMENT 'Indicates whether teams are permitted to trade players with other teams during this window.',
    `announcement_date` DATE COMMENT 'Date when the transfer window schedule and rules were officially announced to teams and the public.',
    `approval_deadline_hours` STRING COMMENT 'Number of hours before window close by which transfer requests must be submitted for league approval consideration.',
    `close_date` DATE COMMENT 'Date when the transfer window officially closes and no further roster changes are permitted.',
    `close_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the transfer window closes, including time zone information for global coordination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer window record was first created in the system.',
    `transfer_window_description` STRING COMMENT 'Detailed description of the transfer window purpose, special rules, and any unique conditions or restrictions.',
    `emergency_extension_allowed` BOOLEAN COMMENT 'Indicates whether the league commissioner can grant emergency extensions to the window close time under exceptional circumstances.',
    `max_roster_size` STRING COMMENT 'Maximum number of players each team is allowed to have on their roster after transfers are completed.',
    `max_transfers_per_team` STRING COMMENT 'Maximum number of player transfers a single team is permitted to execute during this window.',
    `min_roster_size` STRING COMMENT 'Minimum number of players each team must maintain on their roster after transfers are completed.',
    `modified_by` STRING COMMENT 'Username or identifier of the league administrator who last modified this transfer window record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer window record was last modified or updated.',
    `notes` STRING COMMENT 'Internal administrative notes and comments regarding this transfer window, including special circumstances or historical context.',
    `open_date` DATE COMMENT 'Date when the transfer window officially opens and teams can begin submitting roster change requests.',
    `open_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the transfer window opens, including time zone information for global coordination.',
    `region` STRING COMMENT 'Three-letter geographic region code where this transfer window applies (e.g., NAM for North America, EUR for Europe, KOR for Korea).',
    `requires_league_approval` BOOLEAN COMMENT 'Indicates whether all transfers during this window must be reviewed and approved by league officials before becoming effective.',
    `ruleset_version` STRING COMMENT 'Version identifier of the transfer rules and regulations governing this window (e.g., 2.1, 3.0.1).',
    `salary_cap_applies` BOOLEAN COMMENT 'Indicates whether salary cap restrictions are enforced for transfers executed during this window.',
    `transfer_window_status` STRING COMMENT 'Current lifecycle status of the transfer window indicating whether teams can execute roster changes.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the transfer window schedule (e.g., America/Los_Angeles, Europe/London).',
    `total_teams_participating` STRING COMMENT 'Number of teams that executed at least one roster change during this transfer window.',
    `total_transfers_executed` STRING COMMENT 'Total number of player transfers successfully completed across all teams during this window.',
    `transfer_fee_required` BOOLEAN COMMENT 'Indicates whether teams must pay transfer fees to acquire players from other teams during this window.',
    `window_code` STRING COMMENT 'Unique business identifier code for the transfer window, used for external references and display purposes.',
    `window_name` STRING COMMENT 'Human-readable name of the transfer window (e.g., Summer 2024 Transfer Window, Mid-Season Roster Changes Q1 2024).',
    `window_type` STRING COMMENT 'Classification of the transfer window based on timing and purpose within the competitive calendar.',
    `created_by` STRING COMMENT 'Username or identifier of the league administrator who created this transfer window record.',
    CONSTRAINT pk_transfer_window PRIMARY KEY(`transfer_window_id`)
) COMMENT 'Master reference table for transfer_window. Referenced by window_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`esports`.`organizer` (
    `organizer_id` BIGINT COMMENT 'Primary key for organizer',
    `parent_organizer_id` BIGINT COMMENT 'Self-referencing FK on organizer (parent_organizer_id)',
    `average_annual_events` STRING COMMENT 'Average number of esports events or tournaments organized per year, used for capacity and performance assessment.',
    `broadcast_rights_holder` BOOLEAN COMMENT 'Indicates whether the organizer holds broadcast rights for the events they organize (true) or if broadcast rights are managed separately (false).',
    `compliance_certification_status` STRING COMMENT 'Status of the organizers compliance with industry standards, regulatory requirements, or internal certification programs.',
    `contract_reference_number` STRING COMMENT 'Reference number or identifier for the master contract or agreement governing the relationship with this organizer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizer record was first created in the system.',
    `founded_date` DATE COMMENT 'Date when the organizer entity was founded or established.',
    `geographic_coverage` STRING COMMENT 'Geographic scope of the organizers tournament and event operations.',
    `headquarters_city` STRING COMMENT 'City where the organizers headquarters or primary office is located.',
    `headquarters_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the organizer is headquartered.',
    `insurance_coverage_amount_usd` DECIMAL(18,2) COMMENT 'Total insurance coverage amount in USD that the organizer maintains for event liability, cancellation, and other risks.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the organizers current insurance policy coverage.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance, financial, or operational audit conducted on the organizer.',
    `legal_entity_name` STRING COMMENT 'Full registered legal name of the organizer entity as it appears in official business registration documents.',
    `organizer_name` STRING COMMENT 'Full legal or business name of the tournament organizer entity.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next compliance, financial, or operational audit of the organizer.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about the organizer that do not fit structured fields.',
    `organizer_code` STRING COMMENT 'Unique business identifier or code assigned to the organizer for external reference and integration purposes.',
    `organizer_type` STRING COMMENT 'Classification of the organizer based on their relationship to the business: first-party (operated internally), third-party (external professional organizer), partner (strategic partnership), independent (unaffiliated), or community (grassroots/amateur).',
    `partnership_end_date` DATE COMMENT 'Date when the business relationship or partnership with this organizer ended or is scheduled to end. Null for ongoing partnerships.',
    `partnership_start_date` DATE COMMENT 'Date when the business relationship or partnership with this organizer began.',
    `payment_terms_days` STRING COMMENT 'Number of days within which payments are due to the organizer per contractual agreement (e.g., Net 30, Net 60).',
    `preferred_payment_method` STRING COMMENT 'Preferred method for disbursing payments to the organizer.',
    `primary_contact_email` STRING COMMENT 'Primary email address for business communication with the organizer.',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for direct communication with the organizer.',
    `reputation_score` DECIMAL(18,2) COMMENT 'Quantitative reputation or quality score for the organizer based on past performance, community feedback, and operational excellence, typically on a scale of 0.00 to 5.00.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the organizer from tournaments, events, or sponsorships they manage, expressed as a decimal (e.g., 15.50 for 15.5%).',
    `short_name` STRING COMMENT 'Abbreviated or commonly used short name for the organizer, used in displays and branding.',
    `social_media_followers_count` STRING COMMENT 'Total number of followers across the organizers primary social media platforms, used as a measure of reach and influence.',
    `social_media_twitter_handle` STRING COMMENT 'Official Twitter/X handle of the organizer for social media engagement and communication.',
    `specialization` STRING COMMENT 'Primary game titles, genres, or esports categories that the organizer specializes in (e.g., FPS, MOBA, Battle Royale, specific game franchises).',
    `sponsorship_management` BOOLEAN COMMENT 'Indicates whether the organizer manages sponsorship agreements and activations for their events (true) or if sponsorships are managed by the business (false).',
    `organizer_status` STRING COMMENT 'Current operational status of the organizer in the system lifecycle.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or equivalent business registration number for the organizer entity, used for financial and regulatory compliance.',
    `tier` STRING COMMENT 'Tier classification indicating the scale and prestige level of the organizer: tier 1 (major international), tier 2 (established regional), tier 3 (emerging), regional, or local.',
    `total_prize_pool_distributed_usd` DECIMAL(18,2) COMMENT 'Cumulative total prize pool amount in USD that the organizer has distributed across all tournaments and events to date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizer record was last modified in the system.',
    `website_url` STRING COMMENT 'Official website URL of the organizer for public information and branding.',
    CONSTRAINT pk_organizer PRIMARY KEY(`organizer_id`)
) COMMENT 'Master reference table for organizer. Referenced by organizer_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ADD CONSTRAINT `fk_esports_tournament_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_player_contract_id` FOREIGN KEY (`player_contract_id`) REFERENCES `gaming_ecm`.`esports`.`player_contract`(`player_contract_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`roster` ADD CONSTRAINT `fk_esports_roster_roster_team_id` FOREIGN KEY (`roster_team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_parent_contract_player_contract_id` FOREIGN KEY (`parent_contract_player_contract_id`) REFERENCES `gaming_ecm`.`esports`.`player_contract`(`player_contract_id`);
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ADD CONSTRAINT `fk_esports_player_contract_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ADD CONSTRAINT `fk_esports_esports_season_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ADD CONSTRAINT `fk_esports_bracket_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `gaming_ecm`.`esports`.`venue`(`venue_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_bracket_id` FOREIGN KEY (`bracket_id`) REFERENCES `gaming_ecm`.`esports`.`bracket`(`bracket_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_match_team_id` FOREIGN KEY (`match_team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_match_winning_team_id` FOREIGN KEY (`match_winning_team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match` ADD CONSTRAINT `fk_esports_match_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_bracket_id` FOREIGN KEY (`bracket_id`) REFERENCES `gaming_ecm`.`esports`.`bracket`(`bracket_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_round_id` FOREIGN KEY (`round_id`) REFERENCES `gaming_ecm`.`esports`.`round`(`round_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_tertiary_game_team_b_esports_team_id` FOREIGN KEY (`tertiary_game_team_b_esports_team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ADD CONSTRAINT `fk_esports_game_result_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`standing` ADD CONSTRAINT `fk_esports_standing_division_id` FOREIGN KEY (`division_id`) REFERENCES `gaming_ecm`.`esports`.`division`(`division_id`);
ALTER TABLE `gaming_ecm`.`esports`.`standing` ADD CONSTRAINT `fk_esports_standing_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`standing` ADD CONSTRAINT `fk_esports_standing_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`standing` ADD CONSTRAINT `fk_esports_standing_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
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
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ADD CONSTRAINT `fk_esports_broadcast_viewership_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ADD CONSTRAINT `fk_esports_tournament_registration_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ADD CONSTRAINT `fk_esports_tournament_registration_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ADD CONSTRAINT `fk_esports_match_incident_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ADD CONSTRAINT `fk_esports_match_incident_match_id` FOREIGN KEY (`match_id`) REFERENCES `gaming_ecm`.`esports`.`match`(`match_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ADD CONSTRAINT `fk_esports_match_incident_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ADD CONSTRAINT `fk_esports_match_stat_game_result_id` FOREIGN KEY (`game_result_id`) REFERENCES `gaming_ecm`.`esports`.`game_result`(`game_result_id`);
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ADD CONSTRAINT `fk_esports_match_stat_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ADD CONSTRAINT `fk_esports_transfer_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ADD CONSTRAINT `fk_esports_transfer_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ADD CONSTRAINT `fk_esports_transfer_origin_team_id` FOREIGN KEY (`origin_team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ADD CONSTRAINT `fk_esports_transfer_transfer_window_id` FOREIGN KEY (`transfer_window_id`) REFERENCES `gaming_ecm`.`esports`.`transfer_window`(`transfer_window_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ADD CONSTRAINT `fk_esports_team_asset_license_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ADD CONSTRAINT `fk_esports_tournament_promotion_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ADD CONSTRAINT `fk_esports_tournament_asset_usage_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ADD CONSTRAINT `fk_esports_team_event_participation_team_id` FOREIGN KEY (`team_id`) REFERENCES `gaming_ecm`.`esports`.`team`(`team_id`);
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ADD CONSTRAINT `fk_esports_league_influencer_partnership_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`venue` ADD CONSTRAINT `fk_esports_venue_parent_venue_id` FOREIGN KEY (`parent_venue_id`) REFERENCES `gaming_ecm`.`esports`.`venue`(`venue_id`);
ALTER TABLE `gaming_ecm`.`esports`.`round` ADD CONSTRAINT `fk_esports_round_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `gaming_ecm`.`esports`.`tournament`(`tournament_id`);
ALTER TABLE `gaming_ecm`.`esports`.`round` ADD CONSTRAINT `fk_esports_round_venue_id` FOREIGN KEY (`venue_id`) REFERENCES `gaming_ecm`.`esports`.`venue`(`venue_id`);
ALTER TABLE `gaming_ecm`.`esports`.`round` ADD CONSTRAINT `fk_esports_round_previous_round_id` FOREIGN KEY (`previous_round_id`) REFERENCES `gaming_ecm`.`esports`.`round`(`round_id`);
ALTER TABLE `gaming_ecm`.`esports`.`division` ADD CONSTRAINT `fk_esports_division_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`division` ADD CONSTRAINT `fk_esports_division_organizer_id` FOREIGN KEY (`organizer_id`) REFERENCES `gaming_ecm`.`esports`.`organizer`(`organizer_id`);
ALTER TABLE `gaming_ecm`.`esports`.`division` ADD CONSTRAINT `fk_esports_division_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`division` ADD CONSTRAINT `fk_esports_division_parent_division_id` FOREIGN KEY (`parent_division_id`) REFERENCES `gaming_ecm`.`esports`.`division`(`division_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer_window` ADD CONSTRAINT `fk_esports_transfer_window_league_id` FOREIGN KEY (`league_id`) REFERENCES `gaming_ecm`.`esports`.`league`(`league_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer_window` ADD CONSTRAINT `fk_esports_transfer_window_esports_season_id` FOREIGN KEY (`esports_season_id`) REFERENCES `gaming_ecm`.`esports`.`esports_season`(`esports_season_id`);
ALTER TABLE `gaming_ecm`.`esports`.`transfer_window` ADD CONSTRAINT `fk_esports_transfer_window_previous_transfer_window_id` FOREIGN KEY (`previous_transfer_window_id`) REFERENCES `gaming_ecm`.`esports`.`transfer_window`(`transfer_window_id`);
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ADD CONSTRAINT `fk_esports_organizer_parent_organizer_id` FOREIGN KEY (`parent_organizer_id`) REFERENCES `gaming_ecm`.`esports`.`organizer`(`organizer_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`esports` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`esports` SET TAGS ('dbx_domain' = 'esports');
ALTER TABLE `gaming_ecm`.`esports`.`league` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`league` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `certification_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Checklist Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'League Operations Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `title_pl_id` SET TAGS ('dbx_business_glossary_term' = 'Title Pl Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `gaming_ecm`.`esports`.`league` ALTER COLUMN `age_restriction` SET TAGS ('dbx_value_regex' = 'none|13+|16+|18+');
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
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Organizer ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `title_pl_id` SET TAGS ('dbx_business_glossary_term' = 'Title Pl Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `age_restriction` SET TAGS ('dbx_value_regex' = 'none|13+|16+|18+|21+');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `broadcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Flag');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `broadcast_platform` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Platform');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|certified|rejected');
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
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `forum_id` SET TAGS ('dbx_business_glossary_term' = 'Forum Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Game Title ID');
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `studio_pl_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Pl Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`esports`.`team` ALTER COLUMN `secondary_game_title_ids` SET TAGS ('dbx_business_glossary_term' = 'Secondary Game Title IDs');
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
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `finance_tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Tax Record Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `parent_contract_player_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Contract ID');
ALTER TABLE `gaming_ecm`.`esports`.`player_contract` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
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
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`esports_season` ALTER COLUMN `title_pl_id` SET TAGS ('dbx_business_glossary_term' = 'Title Pl Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `bracket_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Organizer Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `bracket_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `bracket_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`bracket` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`esports`.`match` SET TAGS ('dbx_subdomain' = 'event_performance');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `bracket_id` SET TAGS ('dbx_business_glossary_term' = 'Bracket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `compatibility_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Profile Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referee Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `player_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Player Feedback Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Identifier (ID)');
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
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `venue_location` SET TAGS ('dbx_business_glossary_term' = 'Venue Location');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `venue_type` SET TAGS ('dbx_business_glossary_term' = 'Venue Type');
ALTER TABLE `gaming_ecm`.`esports`.`match` ALTER COLUMN `venue_type` SET TAGS ('dbx_value_regex' = 'online|lan|hybrid');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` SET TAGS ('dbx_subdomain' = 'event_performance');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_result_id` SET TAGS ('dbx_business_glossary_term' = 'Game Result ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `bracket_id` SET TAGS ('dbx_business_glossary_term' = 'Bracket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `build_artifact_id` SET TAGS ('dbx_business_glossary_term' = 'Build Artifact Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referee ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `level_map_id` SET TAGS ('dbx_business_glossary_term' = 'Level Map Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `patch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Most Valuable Player (MVP) Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Winning Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `round_id` SET TAGS ('dbx_business_glossary_term' = 'Round ID');
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
ALTER TABLE `gaming_ecm`.`esports`.`game_result` ALTER COLUMN `game_mode` SET TAGS ('dbx_business_glossary_term' = 'Game Mode');
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
ALTER TABLE `gaming_ecm`.`esports`.`standing` SET TAGS ('dbx_subdomain' = 'event_performance');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `standing_id` SET TAGS ('dbx_business_glossary_term' = 'Standing ID');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `division_id` SET TAGS ('dbx_business_glossary_term' = 'Division ID');
ALTER TABLE `gaming_ecm`.`esports`.`standing` ALTER COLUMN `esports_season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
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
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `prize_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Administrator Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Organizer ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_pool` ALTER COLUMN `royalty_report_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Report Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `prize_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Prize Allocation ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `finance_tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Tax Record Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `parent_allocation_prize_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Allocation ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `prize_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Prize Pool ID');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `royalty_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`esports`.`prize_allocation` ALTER COLUMN `other_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Amount');
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
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `broadcast_rights_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Rights ID');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament ID');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `advertising_rights` SET TAGS ('dbx_business_glossary_term' = 'Advertising Rights');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `advertising_rights` SET TAGS ('dbx_value_regex' = 'full|limited|none|shared');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_rights` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
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
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `brand_partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Partnership Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Branding Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Identifier (ID)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`sponsorship` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `broadcast_viewership_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Viewership Identifier');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Session ID');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match ID');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `ad_break_active` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Active');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `average_watch_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Watch Time (Minutes)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `broadcast_language` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Language');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `broadcast_platform` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Platform');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `broadcast_platform` SET TAGS ('dbx_value_regex' = 'twitch|youtube|facebook_gaming|kick|tiktok_live|trovo');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `broadcast_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Start Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `broadcast_status` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Status');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `broadcast_status` SET TAGS ('dbx_value_regex' = 'live|paused|ended|interrupted|technical_difficulty');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `buffering_ratio` SET TAGS ('dbx_business_glossary_term' = 'Buffering Ratio');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `ccu` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Users (CCU)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `chat_message_volume` SET TAGS ('dbx_business_glossary_term' = 'Chat Message Volume');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `co_stream_count` SET TAGS ('dbx_business_glossary_term' = 'Co-Stream Count');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `console_viewer_percentage` SET TAGS ('dbx_business_glossary_term' = 'Console Viewer Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `desktop_viewer_percentage` SET TAGS ('dbx_business_glossary_term' = 'Desktop Viewer Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `follower_viewer_count` SET TAGS ('dbx_business_glossary_term' = 'Follower Viewer Count');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `geographic_distribution_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Geographic Distribution Snapshot');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `mobile_viewer_percentage` SET TAGS ('dbx_business_glossary_term' = 'Mobile Viewer Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `mobile_viewer_percentage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `mobile_viewer_percentage` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `new_viewer_count` SET TAGS ('dbx_business_glossary_term' = 'New Viewer Count');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `pcu` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (PCU)');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `peak_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Peak Viewership Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `raid_incoming_viewers` SET TAGS ('dbx_business_glossary_term' = 'Raid Incoming Viewers');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `sponsorship_overlay_active` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Overlay Active');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `stream_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Stream Quality Tier');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `subscriber_viewer_count` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Viewer Count');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `unique_viewers` SET TAGS ('dbx_business_glossary_term' = 'Total Unique Viewers');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `viewer_drop_count` SET TAGS ('dbx_business_glossary_term' = 'Viewer Drop Count');
ALTER TABLE `gaming_ecm`.`esports`.`broadcast_viewership` ALTER COLUMN `vod_availability` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Availability');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` SET TAGS ('dbx_subdomain' = 'event_performance');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `tournament_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Registration ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `age_verification_event_id` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `check_in_status` SET TAGS ('dbx_business_glossary_term' = 'Check-In Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `check_in_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|checked_in|no_show');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `contact_discord` SET TAGS ('dbx_business_glossary_term' = 'Contact Discord Handle');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `contact_discord` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `contact_discord` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_checked');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `eligibility_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `entry_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Entry Fee Amount');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `entry_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Entry Fee Currency');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `entry_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|failed|refunded');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'PC|PlayStation|Xbox|Nintendo|Mobile|Cross-Platform');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `previous_tournament_wins` SET TAGS ('dbx_business_glossary_term' = 'Previous Tournament Wins');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `registrant_type` SET TAGS ('dbx_business_glossary_term' = 'Registrant Type');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `registrant_type` SET TAGS ('dbx_value_regex' = 'team|individual|duo|squad');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'pending|approved|waitlisted|rejected|withdrawn|cancelled');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `roster_lock_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Lock Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `roster_lock_status` SET TAGS ('dbx_value_regex' = 'unlocked|locked|frozen');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `roster_lock_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roster Lock Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `seed_assignment` SET TAGS ('dbx_business_glossary_term' = 'Seed Assignment');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `skill_tier` SET TAGS ('dbx_business_glossary_term' = 'Skill Tier');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `waiver_signed` SET TAGS ('dbx_business_glossary_term' = 'Waiver Signed');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `waiver_signed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waiver Signed Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_registration` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` SET TAGS ('dbx_subdomain' = 'event_performance');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `match_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Match Incident ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Admin ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `appeal_filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'pending|upheld|overturned|modified|dismissed|withdrawn');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `appeal_ruling_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Ruling Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `disclosure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `evidence_references` SET TAGS ('dbx_business_glossary_term' = 'Evidence References');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `game_number` SET TAGS ('dbx_business_glossary_term' = 'Game Number');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `in_game_time` SET TAGS ('dbx_business_glossary_term' = 'In-Game Time');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `match_result_affected` SET TAGS ('dbx_business_glossary_term' = 'Match Result Affected');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (USD)');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `public_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `reporting_party_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Party Type');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Start Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `ruling_outcome` SET TAGS ('dbx_business_glossary_term' = 'Ruling Outcome');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `ruling_rationale` SET TAGS ('dbx_business_glossary_term' = 'Ruling Rationale');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `ruling_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ruling Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `suspension_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Duration (Days)');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`match_incident` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` SET TAGS ('dbx_subdomain' = 'event_performance');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `match_stat_id` SET TAGS ('dbx_business_glossary_term' = 'Match Stat Identifier');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `playable_character_id` SET TAGS ('dbx_business_glossary_term' = 'Champion or Character ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `game_result_id` SET TAGS ('dbx_business_glossary_term' = 'Game Result ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `apm` SET TAGS ('dbx_business_glossary_term' = 'Actions Per Minute (APM)');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `assists` SET TAGS ('dbx_business_glossary_term' = 'Assists');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `clutch_rounds_won` SET TAGS ('dbx_business_glossary_term' = 'Clutch Rounds Won');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `crowd_control_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Crowd Control (CC) Duration in Seconds');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `cs_per_min` SET TAGS ('dbx_business_glossary_term' = 'Creep Score (CS) Per Minute');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `damage_dealt` SET TAGS ('dbx_business_glossary_term' = 'Damage Dealt');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `damage_taken` SET TAGS ('dbx_business_glossary_term' = 'Damage Taken');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `deaths` SET TAGS ('dbx_business_glossary_term' = 'Deaths');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `economy_score` SET TAGS ('dbx_business_glossary_term' = 'Economy Score');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `first_blood_flag` SET TAGS ('dbx_business_glossary_term' = 'First Blood Flag');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `headshot_rate` SET TAGS ('dbx_business_glossary_term' = 'Headshot Rate Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `healing_done` SET TAGS ('dbx_business_glossary_term' = 'Healing Done');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `in_game_name` SET TAGS ('dbx_business_glossary_term' = 'In-Game Name (IGN)');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `items_purchased` SET TAGS ('dbx_business_glossary_term' = 'Items Purchased');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `kills` SET TAGS ('dbx_business_glossary_term' = 'Kills');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `match_format` SET TAGS ('dbx_business_glossary_term' = 'Match Format');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `match_format` SET TAGS ('dbx_value_regex' = 'best_of_1|best_of_3|best_of_5|single_elimination|round_robin|swiss');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `match_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Match Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `multikill_count` SET TAGS ('dbx_business_glossary_term' = 'Multikill Count');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `mvp_flag` SET TAGS ('dbx_business_glossary_term' = 'Most Valuable Player (MVP) Flag');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `objective_score` SET TAGS ('dbx_business_glossary_term' = 'Objective Score');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `player_role` SET TAGS ('dbx_business_glossary_term' = 'Player Role');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `side_played` SET TAGS ('dbx_business_glossary_term' = 'Side Played');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `stat_source_system` SET TAGS ('dbx_business_glossary_term' = 'Statistic Source System');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `stat_source_system` SET TAGS ('dbx_value_regex' = 'game_engine|third_party_api|manual_entry|broadcast_overlay');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `time_played_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time Played in Seconds');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `ultimate_ability_uses` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Ability Uses');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|disputed|corrected');
ALTER TABLE `gaming_ecm`.`esports`.`match_stat` ALTER COLUMN `vision_score` SET TAGS ('dbx_business_glossary_term' = 'Vision Score');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` SET TAGS ('dbx_subdomain' = 'event_performance');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer ID');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Player Agent ID');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League ID');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `origin_team_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Team ID');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `transfer_window_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Window ID');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Amount');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `agent_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Announcement Date');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `announcement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Announcement Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `buyout_clause_amount` SET TAGS ('dbx_business_glossary_term' = 'Buyout Clause Amount');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `buyout_clause_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `buyout_clause_triggered` SET TAGS ('dbx_business_glossary_term' = 'Buyout Clause Triggered Flag');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Origin Contract Expiry Date');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Effective Date');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Amount');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Currency');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `league_approval_date` SET TAGS ('dbx_business_glossary_term' = 'League Approval Date');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `league_approval_required` SET TAGS ('dbx_business_glossary_term' = 'League Approval Required Flag');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `league_approval_status` SET TAGS ('dbx_business_glossary_term' = 'League Approval Status');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `league_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `loan_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Loan Duration Months');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `loan_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Fee Amount');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `loan_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `loan_option_to_buy` SET TAGS ('dbx_business_glossary_term' = 'Loan Option to Buy Flag');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Date');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `medical_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Required Flag');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `medical_clearance_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `medical_clearance_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `option_to_buy_amount` SET TAGS ('dbx_business_glossary_term' = 'Option to Buy Amount');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `option_to_buy_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `performance_bonus_clause` SET TAGS ('dbx_business_glossary_term' = 'Performance Bonus Clause');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `performance_bonus_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `public_announcement_url` SET TAGS ('dbx_business_glossary_term' = 'Public Announcement URL');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Rejection Reason');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `salary_responsibility_percentage` SET TAGS ('dbx_business_glossary_term' = 'Salary Responsibility Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `salary_responsibility_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `sell_on_clause_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sell-On Clause Percentage');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `sell_on_clause_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `social_media_engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Social Media Engagement Count');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Number');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'pending|announced|completed|cancelled|rejected');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'permanent|loan|free_agent_signing|buyout|trade');
ALTER TABLE `gaming_ecm`.`esports`.`transfer` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` SET TAGS ('dbx_association_edges' = 'esports.esports_team,content.asset');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `team_asset_license_id` SET TAGS ('dbx_business_glossary_term' = 'Team Asset License ID');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Team Asset License - Asset Id');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving User ID');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Asset License - Esports Team Id');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'License Approval Date');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'License Approval Status');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Licensed Asset Type');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'License Creation Date');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive License Flag');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'License Last Modified Date');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `license_terms` SET TAGS ('dbx_business_glossary_term' = 'License Terms');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `license_terms` SET TAGS ('dbx_pii_legal' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `logo_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Team Logo Asset URL');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Permitted Usage Context');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `usage_rights_end_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights End Date');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `usage_rights_start_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`team_asset_license` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Licensed Asset Version');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` SET TAGS ('dbx_association_edges' = 'monetization.promotion,esports.tournament');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `tournament_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Promotion ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Promotion - Promotion Id');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Promotion - Tournament Id');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Conversion Count');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Promotion Priority');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `revenue_generated` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generated');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_promotion` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` SET TAGS ('dbx_association_edges' = 'esports.tournament,content.asset');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `tournament_asset_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Asset Usage ID');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Asset Usage - Asset Id');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Asset Usage - Tournament Id');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `display_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Display Duration');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `placement_location` SET TAGS ('dbx_business_glossary_term' = 'Placement Location');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `sponsor_attribution` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Attribution');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `usage_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Status');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `usage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`tournament_asset_usage` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` SET TAGS ('dbx_association_edges' = 'esports.esports_team,community.community_event');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `team_event_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Team Event Participation ID');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `community_event_id` SET TAGS ('dbx_business_glossary_term' = 'Team Event Participation - Community Event Id');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Event Participation - Esports Team Id');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `appearance_fee` SET TAGS ('dbx_business_glossary_term' = 'Appearance Fee');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Team Attendance Count');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Confirmation Status');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `event_role` SET TAGS ('dbx_business_glossary_term' = 'Event Role');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `invitation_date` SET TAGS ('dbx_business_glossary_term' = 'Invitation Date');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `social_media_reach` SET TAGS ('dbx_business_glossary_term' = 'Social Media Reach');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `sponsorship_tier` SET TAGS ('dbx_business_glossary_term' = 'Event Sponsorship Tier');
ALTER TABLE `gaming_ecm`.`esports`.`team_event_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` SET TAGS ('dbx_subdomain' = 'revenue_partnerships');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` SET TAGS ('dbx_association_edges' = 'esports.league,marketing.influencer');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `league_influencer_partnership_id` SET TAGS ('dbx_business_glossary_term' = 'league_influencer_partnership Identifier');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'League Influencer Partnership - Influencer Id');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Influencer Partnership - League Id');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `brand_safety_guidelines` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Guidelines');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `content_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Content Approval Required');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `content_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Content Deliverables');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `partnership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership End Date');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `partnership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Start Date');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status');
ALTER TABLE `gaming_ecm`.`esports`.`league_influencer_partnership` ALTER COLUMN `performance_metrics_target` SET TAGS ('dbx_business_glossary_term' = 'Performance Metrics Target');
ALTER TABLE `gaming_ecm`.`esports`.`venue` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`venue` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue Identifier');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `parent_venue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`venue` ALTER COLUMN `rental_rate_per_day_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`round` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`round` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`round` ALTER COLUMN `round_id` SET TAGS ('dbx_business_glossary_term' = 'Round Identifier');
ALTER TABLE `gaming_ecm`.`esports`.`round` ALTER COLUMN `previous_round_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`round` ALTER COLUMN `broadcast_rights_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`round` ALTER COLUMN `primary_sponsor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`division` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`division` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`division` ALTER COLUMN `division_id` SET TAGS ('dbx_business_glossary_term' = 'Division Identifier');
ALTER TABLE `gaming_ecm`.`esports`.`division` ALTER COLUMN `parent_division_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`division` ALTER COLUMN `broadcast_rights_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`division` ALTER COLUMN `prize_pool_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`division` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`transfer_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`transfer_window` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`transfer_window` ALTER COLUMN `transfer_window_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Window Identifier');
ALTER TABLE `gaming_ecm`.`esports`.`transfer_window` ALTER COLUMN `previous_transfer_window_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` SET TAGS ('dbx_subdomain' = 'competition_structure');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `organizer_id` SET TAGS ('dbx_business_glossary_term' = 'Organizer Identifier');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `parent_organizer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `insurance_coverage_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`esports`.`organizer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
