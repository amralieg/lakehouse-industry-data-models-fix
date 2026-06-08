-- Schema for Domain: infrastructure | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`infrastructure` COMMENT 'Manages live game server infrastructure, CDN topology, matchmaking services, cloud compute capacity, network performance monitoring (FPS, latency, uptime SLAs), server fleet provisioning, CCU/PCU capacity planning, incident management, and DevOps CI/CD pipeline health. The operational backbone enabling GaaS live service delivery and online multiplayer (PvP/PvE/MMO) at scale.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`game_server` (
    `game_server_id` BIGINT COMMENT 'Unique identifier for the game server instance. Primary key for the game server entity. This is the atomic unit of the server fleet and the single source of truth (SSOT) for all server-level operational data supporting Game-as-a-Service (GaaS) multiplayer (Player versus Player (PvP), Player versus Environment (PvE), Massively Multiplayer Online (MMO)) delivery.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Server hosting costs are allocated to cost centers for financial reporting and chargeback to game titles/studios. Essential for monthly infrastructure cost allocation and P&L reporting in gaming opera',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that this server instance is hosting. Links the server to the specific game product being served to players.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Game servers must comply with data residency laws (GDPR Article 44, China Cybersecurity Law). Compliance teams audit which jurisdictions regulations apply to each server for data localization and con',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: game_server serves a matchmaking_pool. Many servers can serve one pool (N:1). game_server.matchmaking_pool is STRING, but matchmaking_pool table exists with pool_code as business key. Adding matchmaki',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: game_server is deployed in a network_region. Many servers in one region (N:1). game_server.cloud_region (STRING) is a semantic match for network_region.region_code. Adding network_region_id FK and rem',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: game_server is part of a server_fleet. Fleet is the logical grouping of servers by title, region, and game mode. Many servers belong to one fleet (N:1). Removing fleet-level configuration attributes (',
    `anti_cheat_version` STRING COMMENT 'Version identifier of the anti-cheat software or service integrated with this server instance. Critical for maintaining competitive integrity in PvP and esports environments.',
    `auto_scaling_group` STRING COMMENT 'Identifier for the auto-scaling group or fleet management pool this server belongs to. Supports dynamic capacity provisioning based on CCU/PCU demand patterns.',
    `availability_zone` STRING COMMENT 'Specific availability zone within the cloud region for high-availability and fault-tolerance deployment. Supports disaster recovery and uptime SLA targets.',
    `average_fps` DECIMAL(18,2) COMMENT 'Average server-side frames per second performance metric. Critical quality indicator for player experience; low FPS indicates performance degradation requiring intervention.',
    `average_latency_ms` DECIMAL(18,2) COMMENT 'Average network latency in milliseconds between server and connected players. Key performance indicator for player experience quality and regional CDN topology optimization.',
    `capacity_tier` STRING COMMENT 'Business classification of server capacity tier based on expected player load and performance requirements. Used for CCU/PCU capacity planning and fleet provisioning decisions.. Valid values are `small|medium|large|xlarge|dedicated`',
    `cost_per_hour` DECIMAL(18,2) COMMENT 'Hourly infrastructure cost for running this server instance based on cloud provider pricing and instance type. Used for cost allocation, budgeting, and Return on Investment (ROI) analysis.',
    `cpu_utilization_pct` DECIMAL(18,2) COMMENT 'Current CPU utilization percentage for the server instance. Monitoring metric for capacity planning, auto-scaling decisions, and performance optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this server record was first created in the data system. Audit trail for data lineage and compliance with General Data Protection Regulation (GDPR) and SOC 2 requirements.',
    `current_player_count` STRING COMMENT 'Current number of active players connected to this server instance. Real-time metric for load monitoring, matchmaking decisions, and capacity utilization analytics.',
    `drm_enabled` BOOLEAN COMMENT 'Indicates whether Digital Rights Management protections are enabled on this server instance for anti-cheat and content protection purposes.',
    `game_build_version` STRING COMMENT 'Version identifier of the game server build deployed on this instance. Tracks which game code version is running for compatibility, Quality Assurance (QA), and rollback purposes.',
    `game_mode` STRING COMMENT 'Specific game mode or match type this server instance is configured to host (e.g., deathmatch, battle_royale, cooperative_campaign). Supports mode-specific capacity planning and player experience optimization.',
    `health_check_status` STRING COMMENT 'Result of the most recent health check. Healthy indicates all systems operational; degraded indicates partial functionality; unhealthy indicates failure requiring intervention; unknown indicates monitoring gap.. Valid values are `healthy|degraded|unhealthy|unknown`',
    `incident_count` STRING COMMENT 'Cumulative count of incidents or failures recorded for this server instance since provisioning. Tracks reliability and identifies problematic instances for replacement.',
    `ip_address` STRING COMMENT 'Public or private IP address assigned to the game server instance for network connectivity. Used by matchmaking services and player clients to establish connections.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent health check performed on this server instance. Used for monitoring service alerting and incident detection.',
    `max_player_capacity` STRING COMMENT 'Maximum number of concurrent players this server instance can support based on its capacity tier and instance type. Critical for matchmaking service load balancing and CCU/PCU monitoring.',
    `memory_utilization_pct` DECIMAL(18,2) COMMENT 'Current memory utilization percentage for the server instance. Critical for identifying memory leaks, capacity constraints, and optimization opportunities.',
    `network_bandwidth_mbps` DECIMAL(18,2) COMMENT 'Current network bandwidth utilization in megabits per second. Monitors network capacity consumption for CDN topology optimization and cost management.',
    `os_image_version` STRING COMMENT 'Version identifier of the operating system image deployed on this server instance. Critical for patch management, security compliance, and DevOps CI/CD pipeline tracking.',
    `port_number` STRING COMMENT 'Network port number on which the game server instance listens for player connections. Part of the server endpoint configuration for matchmaking and connectivity.',
    `provisioned_timestamp` TIMESTAMP COMMENT 'Timestamp when the server instance was initially provisioned and deployed to the fleet. Tracks server age for lifecycle management and cost allocation.',
    `server_code` STRING COMMENT 'Externally-known unique code or identifier for the game server instance used in operational systems, monitoring dashboards, and DevOps Continuous Integration/Continuous Deployment (CI/CD) pipelines.',
    `server_name` STRING COMMENT 'Human-readable name or label assigned to the game server instance for operational identification and monitoring purposes.',
    `server_status` STRING COMMENT 'Current operational state of the game server instance in its lifecycle. Running indicates active service; draining indicates graceful shutdown in progress; terminated indicates decommissioned; provisioning indicates startup in progress; maintenance indicates scheduled downtime; failed indicates error state requiring intervention.. Valid values are `running|draining|terminated|provisioning|maintenance|failed`',
    `server_type` STRING COMMENT 'Classification of server architecture type. Dedicated servers are fully managed by the platform; listen servers are player-hosted with platform oversight; peer-to-peer supports direct player connections; hybrid combines approaches.. Valid values are `dedicated|listen|peer_to_peer|hybrid`',
    `started_timestamp` TIMESTAMP COMMENT 'Timestamp when the server instance last transitioned to running status and began accepting player connections. Distinct from provisioning for restart scenarios.',
    `tags_metadata` STRING COMMENT 'Free-form metadata tags applied to the server instance for operational categorization, cost allocation, and DevOps automation (e.g., environment=production, team=live_ops, project=season_5).',
    `terminated_timestamp` TIMESTAMP COMMENT 'Timestamp when the server instance was terminated or decommissioned from the fleet. Null for active servers; populated for historical fleet analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this server record was last modified in the data system. Audit trail for change tracking and data governance compliance.',
    `uptime_percentage` DECIMAL(18,2) COMMENT 'Server uptime percentage over a defined measurement period. Critical SLA metric for GaaS live service delivery and operational excellence tracking.',
    CONSTRAINT pk_game_server PRIMARY KEY(`game_server_id`)
) COMMENT 'Master record for individual game server instances deployed across the live service fleet. Captures server identity, region, game title assignment, instance type, cloud provider zone, operating state (running, draining, terminated), IP/port bindings, OS image version, and capacity tier. This is the atomic unit of the server fleet and the SSOT for all server-level operational data supporting GaaS multiplayer (PvP/PvE/MMO) delivery.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`server_fleet` (
    `server_fleet_id` BIGINT COMMENT 'Unique identifier for the server fleet. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fleet operating costs must be tracked by cost center for title/studio P&L reporting. Critical for infrastructure cost allocation and budget variance analysis in live service games.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Fleet capacity targets drive infrastructure budget line items for server hosting costs. Critical for infrastructure budget planning and monthly variance analysis.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this fleet serves. Links to the game title master data.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Fleet deployment decisions are constrained by data localization requirements. Compliance teams audit fleet topology against jurisdictional mandates for GDPR, CCPA, and regional content regulations. Fo',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: server_fleet is deployed in a network_region. Many fleets in one region (N:1). server_fleet.region_code (STRING) matches network_region.region_code. Adding network_region_id FK and removing region_cod',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to infrastructure.sla_policy. Business justification: server_fleet operates under an sla_policy. Many fleets under one SLA policy (N:1). server_fleet has sla_target_uptime_percentage which is defined in sla_policy. Adding sla_policy_id FK and removing sl',
    `autoscaling_policy_reference` STRING COMMENT 'Reference identifier or name of the autoscaling policy governing when and how this fleet scales up or down based on load metrics.',
    `average_fps` DECIMAL(18,2) COMMENT 'Average server-side frames per second maintained by instances in this fleet, indicating server performance and game simulation quality.',
    `average_latency_ms` DECIMAL(18,2) COMMENT 'Average network latency in milliseconds for player connections to this fleet, critical for player experience in real-time multiplayer games.',
    `build_version` STRING COMMENT 'Game server build version or software version currently deployed to this fleet, used for version control and rollback management.',
    `cdn_topology_reference` STRING COMMENT 'Reference to the CDN topology configuration used for content delivery to players connecting to this fleet.',
    `cloud_provider` STRING COMMENT 'Cloud infrastructure provider hosting this fleet (Amazon Web Services, Microsoft Azure, Google Cloud Platform, Alibaba Cloud, on-premise data center, or hybrid).. Valid values are `AWS|Azure|GCP|Alibaba Cloud|On-Premise|Hybrid`',
    `contact_email` STRING COMMENT 'Primary email address for the team or individual responsible for this fleet, used for incident escalation and operational communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost reporting (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_per_hour` DECIMAL(18,2) COMMENT 'Estimated hourly operational cost for running this fleet, including compute, network, and storage costs. Used for budget tracking and cost optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fleet record was first created in the system.',
    `current_ccu` STRING COMMENT 'Current number of concurrent users actively connected to servers in this fleet at the time of measurement.',
    `current_instance_count` STRING COMMENT 'Actual number of server instances currently running in the fleet at the time of measurement.',
    `decommissioned_timestamp` TIMESTAMP COMMENT 'Date and time when this fleet was decommissioned or retired from service. Null if the fleet is still active.',
    `deployment_tier` STRING COMMENT 'Deployment environment tier indicating the fleets operational stage (production, staging, canary for gradual rollout, development, or QA).. Valid values are `production|staging|canary|development|qa`',
    `deployment_timestamp` TIMESTAMP COMMENT 'Date and time when the current build version was deployed to this fleet.',
    `fleet_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the fleet across systems and monitoring tools.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `fleet_name` STRING COMMENT 'Human-readable name for the server fleet, typically including game title, region, and deployment tier (e.g., Apex-NA-Prod-PvP).',
    `fleet_status` STRING COMMENT 'Current operational status of the server fleet. Active indicates normal operation, maintenance indicates scheduled downtime, degraded indicates partial capacity, failed indicates critical issues.. Valid values are `active|inactive|maintenance|scaling|degraded|failed`',
    `game_mode` STRING COMMENT 'The game mode this fleet supports (Player versus Player, Player versus Environment, Massively Multiplayer Online, etc.). [ENUM-REF-CANDIDATE: PvP|PvE|MMO|Battle Royale|Co-op|Ranked|Casual — 7 candidates stripped; promote to reference product]',
    `health_check_status` STRING COMMENT 'Result of the most recent automated health check for the fleet. Healthy indicates all systems operational, degraded indicates partial issues, unhealthy indicates critical failures.. Valid values are `healthy|unhealthy|degraded|unknown`',
    `incident_count` STRING COMMENT 'Number of operational incidents (outages, performance degradations, security events) recorded for this fleet over the measurement period.',
    `instance_type` STRING COMMENT 'Cloud compute instance type or server specification (e.g., c5.xlarge for AWS, Standard_D4s_v3 for Azure). Defines CPU, memory, and network capacity.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this fleet is currently active and operational (True) or has been decommissioned (False).',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent health check execution for this fleet.',
    `last_incident_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent operational incident affecting this fleet.',
    `matchmaking_service_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_service. Business justification: server_fleet currently has matchmaking_service_endpoint (STRING) but no FK to matchmaking_service. Server fleets host game sessions that are populated by matchmaking services. Adding matchmaking_servi',
    `max_instance_count` STRING COMMENT 'Maximum number of server instances allowed for this fleet, serving as a cost control and capacity ceiling.',
    `min_instance_count` STRING COMMENT 'Minimum number of server instances that must always be running to maintain service availability, even during low-traffic periods.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fleet record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special configurations, known issues, or maintenance schedules related to this fleet.',
    `owner_team` STRING COMMENT 'Name of the engineering or operations team responsible for managing and maintaining this fleet.',
    `pcu_watermark` STRING COMMENT 'Highest number of concurrent users this fleet has served simultaneously, used for capacity planning and performance benchmarking.',
    `pcu_watermark_timestamp` TIMESTAMP COMMENT 'Date and time when the PCU watermark was recorded.',
    `tags_metadata` STRING COMMENT 'Comma-separated key-value tags for fleet categorization, cost allocation, and resource management (e.g., environment=prod,cost-center=gaming-ops,project=apex-legends).',
    `target_capacity` STRING COMMENT 'Desired number of server instances the fleet should maintain under normal load conditions.',
    `uptime_percentage` DECIMAL(18,2) COMMENT 'Percentage of time the fleet has been operational and available over the measurement period, used for SLA compliance tracking.',
    CONSTRAINT pk_server_fleet PRIMARY KEY(`server_fleet_id`)
) COMMENT 'Master record for logical groupings of game servers organized by title, region, game mode, and deployment tier (production, staging, canary). Tracks fleet name, target capacity, minimum/maximum instance counts, auto-scaling policy reference, current CCU load, PCU watermark, and fleet health status. Enables capacity planning and fleet-level operational governance for live service titles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`cdn_node` (
    `cdn_node_id` BIGINT COMMENT 'Unique identifier for the CDN edge node or Point of Presence (PoP). Primary key for the cdn_node product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CDN costs are significant opex items that must be allocated to cost centers for title P&L. Essential for content delivery cost tracking and chargeback to game titles.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: CDN capacity and bandwidth costs are budgeted items for content delivery infrastructure. Essential for content delivery budget planning and cost variance tracking.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: CDN nodes cache player data and must comply with local data protection laws. Real-world compliance mapping for GDPR Article 44 international transfer assessments and data residency audits.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: cdn_node is located in a network_region. Many CDN nodes in one region (N:1). cdn_node has geographic_region, country_code, city. Adding network_region_id FK and removing geographic_region STRING as it',
    `activated_date` DATE COMMENT 'Date when the CDN node was activated and began serving production traffic. Marks the start of operational service delivery.',
    `average_latency_ms` DECIMAL(18,2) COMMENT 'Average network latency from the CDN node to end users measured in milliseconds. Critical KPI for player experience in online multiplayer games (PvP/PvE/MMO).',
    `bandwidth_capacity_gbps` DECIMAL(18,2) COMMENT 'Maximum network bandwidth capacity of the CDN node measured in gigabits per second. Critical for CCU/PCU capacity planning and ensuring sufficient throughput for game patches, DLC downloads, and live event streaming.',
    `cache_hit_ratio_percentage` DECIMAL(18,2) COMMENT 'Percentage of content requests served from cache versus fetched from origin. Higher ratios indicate better CDN efficiency and lower origin server load.',
    `cache_storage_quota_tb` DECIMAL(18,2) COMMENT 'Total cache storage capacity allocated to the CDN node measured in terabytes. Determines how much game content, patches, and assets can be cached locally for fast delivery.',
    `cache_storage_used_tb` DECIMAL(18,2) COMMENT 'Current cache storage utilization measured in terabytes. Monitored to prevent cache exhaustion and optimize content eviction policies.',
    `cdn_node_status` STRING COMMENT 'Current operational status of the CDN node. Active nodes serve traffic, maintenance nodes are temporarily offline, degraded nodes operate at reduced capacity.. Valid values are `active|inactive|maintenance|degraded|provisioning|decommissioned`',
    `city` STRING COMMENT 'City where the CDN node data center or Point of Presence is physically located. Used for granular latency analysis and player proximity routing.',
    `compression_enabled` BOOLEAN COMMENT 'Indicates whether the CDN node performs content compression (gzip, brotli) to reduce bandwidth consumption and improve download speeds.',
    `contact_email` STRING COMMENT 'Primary email address for operational contact regarding the CDN node. Used for incident escalation and vendor communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cost_per_gb_usd` DECIMAL(18,2) COMMENT 'Cost per gigabyte of bandwidth for this CDN node in USD. Confidential pricing information used for financial planning and vendor negotiations.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the CDN node location. Essential for GDPR compliance, data sovereignty, and regional performance analytics.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CDN node record was first created in the system. Audit trail for data lineage and compliance.',
    `current_concurrent_connections` BIGINT COMMENT 'Current number of active concurrent connections to the CDN node. Real-time metric for load balancing and capacity monitoring.',
    `data_center_facility` STRING COMMENT 'Name or identifier of the physical data center facility hosting the CDN node. Confidential operational information for infrastructure security and capacity planning.',
    `decommissioned_date` DATE COMMENT 'Date when the CDN node was decommissioned and removed from service. Nullable for active nodes. Used for infrastructure lifecycle management.',
    `drm_enabled` BOOLEAN COMMENT 'Indicates whether the CDN node supports DRM-protected content delivery. Essential for secure distribution of premium game content and preventing piracy.',
    `hostname` STRING COMMENT 'Fully qualified domain name (FQDN) or hostname for the CDN node. Used for DNS routing, SSL certificate management, and operational monitoring.',
    `ipv4_address` STRING COMMENT 'Primary IPv4 address assigned to the CDN node. Confidential infrastructure information used for network routing and monitoring.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `ipv6_address` STRING COMMENT 'Primary IPv6 address assigned to the CDN node. Supports modern network infrastructure and future-proofs content delivery as IPv6 adoption increases.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance performed on the CDN node. Used for maintenance scheduling and compliance with operational procedures.',
    `monitoring_endpoint_url` STRING COMMENT 'URL endpoint for health checks and monitoring of the CDN node. Confidential operational information used by DevOps and incident management systems.',
    `monthly_bandwidth_quota_tb` DECIMAL(18,2) COMMENT 'Monthly bandwidth transfer quota allocated to the CDN node measured in terabytes. Used for cost management and overage prevention.',
    `monthly_bandwidth_used_tb` DECIMAL(18,2) COMMENT 'Bandwidth consumed by the CDN node in the current billing month measured in terabytes. Tracked for cost allocation and capacity forecasting.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next planned maintenance window. Critical for coordinating maintenance with game launch schedules and live operations.',
    `node_code` STRING COMMENT 'Business identifier or code assigned to the CDN node by the provider or internal operations team. Used for operational reference and monitoring dashboards.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `node_name` STRING COMMENT 'Human-readable name or label for the CDN node, typically including geographic or facility identifiers for operational clarity.',
    `node_type` STRING COMMENT 'Classification of the CDN node role in the content delivery topology. Edge nodes serve end users, origin shields protect origin servers, regional caches aggregate traffic.. Valid values are `edge|origin_shield|regional_cache|pop`',
    `notes` STRING COMMENT 'Free-text field for operational notes, special configurations, or known issues related to the CDN node. Used by DevOps and infrastructure teams for knowledge sharing.',
    `peak_concurrent_connections` BIGINT COMMENT 'Maximum number of concurrent player connections the CDN node can support. Used for capacity planning during game launches, DLC releases, and live events.',
    `peering_configuration` STRING COMMENT 'Network peering strategy for the CDN node. Private peering and direct connect reduce latency and improve reliability for high-traffic game distribution.. Valid values are `public_internet|private_peering|direct_connect|hybrid`',
    `provider_name` STRING COMMENT 'Name of the CDN service provider operating this node. Critical for vendor management, SLA tracking, and cost allocation. [ENUM-REF-CANDIDATE: akamai|cloudflare|fastly|amazon_cloudfront|azure_cdn|google_cloud_cdn|internal — 7 candidates stripped; promote to reference product]',
    `provisioned_date` DATE COMMENT 'Date when the CDN node was initially provisioned and configured. Used for infrastructure lifecycle tracking and depreciation planning.',
    `ssl_certificate_expiry_date` DATE COMMENT 'Expiration date of the SSL/TLS certificate installed on the CDN node. Monitored to prevent service disruptions from expired certificates.',
    `supports_http2` BOOLEAN COMMENT 'Indicates whether the CDN node supports HTTP/2 protocol for improved performance and multiplexing. Important for modern game client downloads and streaming.',
    `supports_http3` BOOLEAN COMMENT 'Indicates whether the CDN node supports HTTP/3 protocol (QUIC) for reduced latency and improved connection reliability. Emerging standard for high-performance content delivery.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CDN node record was last modified. Audit trail for change tracking and data governance.',
    `uptime_sla_percentage` DECIMAL(18,2) COMMENT 'Contractual uptime SLA target for the CDN node expressed as a percentage. Typically 99.9% or higher for production game distribution infrastructure.',
    CONSTRAINT pk_cdn_node PRIMARY KEY(`cdn_node_id`)
) COMMENT 'Master record for CDN edge nodes and Points of Presence (PoPs) used to deliver game patches, DLC, streaming assets, and live event content to players globally. Captures node identifier, CDN provider, geographic region, data center facility, bandwidth capacity (Gbps), cache storage quota, active status, and peering configuration. SSOT for CDN topology supporting game distribution and live ops content delivery.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` (
    `matchmaking_pool_id` BIGINT COMMENT 'Unique identifier for the matchmaking pool configuration. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Matchmaking service costs are allocated to game title cost centers for online service cost tracking. Essential for live service cost allocation and title P&L reporting.',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Matchmaking pools are configured for specific game modes with mode-specific rules (team composition, match size, skill brackets). Live ops teams manage pool parameters per mode, analyze queue health b',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this matchmaking pool serves.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Matchmaking pools enforce region-locking for compliance (China-only pools, GDPR-compliant EU pools, age-restricted pools). Real-world implementation of data residency rules and content regulations in ',
    `matchmaking_service_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_service. Business justification: matchmaking_pool currently has matchmaking_service_endpoint (STRING) but no FK to the matchmaking_service product. Pools are served by matchmaking services and should reference the service definition.',
    `acceptable_latency_threshold_ms` STRING COMMENT 'Maximum acceptable network latency in milliseconds for players to be matched into this pool. Critical for player experience in real-time multiplayer.',
    `active_from_timestamp` TIMESTAMP COMMENT 'Timestamp when this matchmaking pool configuration became active and available for player queuing.',
    `active_until_timestamp` TIMESTAMP COMMENT 'Timestamp when this matchmaking pool configuration is scheduled to be deactivated or deprecated. Null if indefinitely active.',
    `anti_cheat_enforcement_level` STRING COMMENT 'Level of anti-cheat enforcement applied to this pool: standard, strict (for ranked/competitive), tournament-grade, or disabled (for testing).. Valid values are `standard|strict|tournament|disabled`',
    `backfill_enabled_flag` BOOLEAN COMMENT 'Indicates whether this pool supports backfilling players into in-progress matches when players leave.',
    `ccu_capacity_target` STRING COMMENT 'Target concurrent user capacity this pool is provisioned to support. Used for infrastructure capacity planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this matchmaking pool record was first created in the system.',
    `crossplay_policy` STRING COMMENT 'Defines whether and how crossplay is supported: fully enabled, disabled, player opt-in, or restricted to specific platform combinations.. Valid values are `enabled|disabled|opt_in|platform_restricted`',
    `input_method_restriction` STRING COMMENT 'Restriction or matching rule based on player input device: any input allowed, controller-only, keyboard/mouse-only, or input-based matching pools.. Valid values are `any|controller_only|keyboard_mouse_only|input_based_matching`',
    `match_timeout_seconds` STRING COMMENT 'Maximum duration in seconds for a match instance before automatic termination or forfeit rules apply.',
    `matchmaking_algorithm_type` STRING COMMENT 'The primary algorithm used for player matching: skill-based matchmaking (SBMM), latency-based, hybrid (skill + latency), input-based (controller vs keyboard/mouse), or random.. Valid values are `skill_based|latency_based|hybrid|input_based|random`',
    `max_match_size` STRING COMMENT 'The maximum number of players allowed in a single match instance for this pool.',
    `max_queue_wait_time_seconds` STRING COMMENT 'Maximum time in seconds a player can wait in queue before matchmaking relaxes constraints or times out.',
    `min_match_size` STRING COMMENT 'The minimum number of players required to start a match if target size cannot be met within timeout.',
    `mmr_range_max` STRING COMMENT 'Maximum matchmaking rating (MMR) or Elo score allowed. Null if no upper MMR bound.',
    `mmr_range_min` STRING COMMENT 'Minimum matchmaking rating (MMR) or Elo score required for entry. Null if no MMR constraint.',
    `modified_by_user` STRING COMMENT 'Identifier of the user or system process that last modified this pool configuration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this matchmaking pool record was last modified.',
    `notes` STRING COMMENT 'Additional operational notes, configuration details, or special instructions for this matchmaking pool.',
    `party_size_max` STRING COMMENT 'Maximum number of players in a party/group allowed to queue together. Null if no maximum.',
    `party_size_min` STRING COMMENT 'Minimum number of players in a party/group allowed to queue together. Null if no minimum.',
    `pcu_historical_peak` STRING COMMENT 'Historical peak concurrent users observed in this pool. Used for capacity planning and SLA monitoring.',
    `platform_restriction` STRING COMMENT 'Comma-separated list of platform codes this pool is restricted to (e.g., PS5,XBOX_SERIES_X,PC). Null if available on all platforms.',
    `pool_code` STRING COMMENT 'Unique business identifier code for the pool used in system integrations and APIs.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `pool_description` STRING COMMENT 'Detailed business description of the matchmaking pool purpose, rules, and player experience expectations.',
    `pool_name` STRING COMMENT 'Human-readable name of the matchmaking pool (e.g., Ranked Solo Queue, Casual 5v5, Competitive Doubles).',
    `pool_status` STRING COMMENT 'Current operational status of the matchmaking pool in its lifecycle.. Valid values are `active|inactive|maintenance|deprecated|testing`',
    `queue_priority_tier` STRING COMMENT 'Priority ranking of this pool relative to others (1=highest priority). Used when players qualify for multiple pools.',
    `rank_tier_max` STRING COMMENT 'Maximum rank or tier allowed for players in this pool. Used to segment competitive tiers. Null if no upper bound.',
    `rank_tier_min` STRING COMMENT 'Minimum rank or tier required for players to enter this pool (e.g., Bronze, Silver, Gold). Null if no rank restriction.',
    `region_restriction` STRING COMMENT 'Geographic region or data center locality constraint for this pool (e.g., NA-EAST, EU-WEST, APAC). Null if globally available.',
    `seasonal_event_flag` BOOLEAN COMMENT 'Indicates whether this pool is associated with a limited-time seasonal or special event.',
    `skill_variance_tolerance` DECIMAL(18,2) COMMENT 'Acceptable variance in skill rating (MMR/Elo) between matched players, expressed as a percentage or absolute value. Used to balance match quality vs. queue time.',
    `sla_target_match_time_seconds` STRING COMMENT 'Target time in seconds to form a match under normal conditions, as defined by the service level agreement.',
    `target_match_size` STRING COMMENT 'The target number of players required for a complete match in this pool (e.g., 2 for 1v1, 10 for 5v5).',
    `team_composition_rule` STRING COMMENT 'Business rules defining how teams are formed (e.g., balanced_skill, party_priority, role_based, free_for_all). Free-text to accommodate complex rule descriptions.',
    `version_number` STRING COMMENT 'Version number of this pool configuration. Incremented with each modification to support change tracking and rollback.',
    CONSTRAINT pk_matchmaking_pool PRIMARY KEY(`matchmaking_pool_id`)
) COMMENT 'Master record for matchmaking queue configurations and player pools used in PvP, co-op, and ranked competitive game modes. Captures pool name, associated game title and mode, matchmaking algorithm type (skill-based/SBMM, latency-based, hybrid, input-based), target match size, team composition rules, acceptable latency threshold (ms), queue priority tier, rank/MMR range constraints, crossplay policy, backfill enabled flag, and active/inactive status. Defines the operational parameters governing how players are grouped into game sessions across all live service titles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`network_region` (
    `network_region_id` BIGINT COMMENT 'Unique identifier for the network region. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Regional infrastructure costs are tracked by cost center for geographic P&L reporting. Essential for regional cost allocation and profitability analysis by market.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Network regions map to regulatory jurisdictions for data residency compliance. Foundation for infrastructure compliance audits, GDPR Article 44 transfer impact assessments, and regional content censor',
    `activation_date` DATE COMMENT 'Date when this network region was first activated and made available for live service traffic.',
    `availability_zone_count` STRING COMMENT 'Number of distinct availability zones within this region. Higher counts provide better fault tolerance and disaster recovery capabilities.',
    `average_latency_to_peers_ms` DECIMAL(18,2) COMMENT 'Average network latency in milliseconds from this region to all other active peer regions. Used for matchmaking routing and cross-region replication planning.',
    `ccu_capacity` STRING COMMENT 'Maximum number of concurrent users this region is provisioned to support under normal operating conditions. Used for capacity governance and scaling decisions.',
    `cdn_provider` STRING COMMENT 'CDN provider integrated with this region for game asset delivery and patch distribution (e.g., Akamai, Cloudflare, Fastly).',
    `cicd_pipeline_endpoint` STRING COMMENT 'API endpoint URL for the CI/CD pipeline serving this region. Used for automated deployment and rollback operations.',
    `cloud_provider` STRING COMMENT 'Cloud infrastructure provider hosting this network region. Determines platform-specific capabilities and pricing models.. Valid values are `AWS|Azure|GCP|Alibaba|Private`',
    `compliance_certifications` STRING COMMENT 'Comma-separated list of compliance certifications held by this region (e.g., ISO 27001, SOC 2, PCI DSS). Used for regulatory reporting and vendor audits.',
    `continent_code` STRING COMMENT 'Two-letter continent code for geographic classification (NA=North America, SA=South America, EU=Europe, AF=Africa, AS=Asia, OC=Oceania, AN=Antarctica). [ENUM-REF-CANDIDATE: NA|SA|EU|AF|AS|OC|AN — 7 candidates stripped; promote to reference product]',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the primary country where this region is physically located (e.g., USA, GBR, JPN, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network region record was first created in the system.',
    `data_residency_jurisdiction` STRING COMMENT 'Legal jurisdiction governing data residency and sovereignty requirements for player data stored in this region (e.g., EU GDPR, China Cybersecurity Law).',
    `deactivation_date` DATE COMMENT 'Date when this network region was deactivated or scheduled for decommissioning. Null if region is still active.',
    `display_name` STRING COMMENT 'Human-readable name for the network region used in dashboards and operational interfaces (e.g., US East Virginia, Europe West London).',
    `failover_datacenter_location` STRING COMMENT 'Physical city or metro area where the failover/backup datacenter for this region is located. Null if no failover is configured.',
    `incident_escalation_contact` STRING COMMENT 'Primary email address or contact identifier for incident escalation in this region. Used by DevOps and on-call teams.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this network region record was last updated. Used for change tracking and audit trails.',
    `matchmaking_priority` STRING COMMENT 'Priority ranking for matchmaking routing decisions. Lower values indicate higher priority. Used to prefer low-latency regions for player assignment.',
    `max_latency_threshold_ms` STRING COMMENT 'Maximum acceptable player latency in milliseconds for this region. Players exceeding this threshold may be routed to alternate regions or flagged for quality monitoring.',
    `monitoring_dashboard_url` STRING COMMENT 'URL to the real-time monitoring dashboard for this regions infrastructure health, CCU, latency, and incident status.',
    `monthly_operating_cost_usd` DECIMAL(18,2) COMMENT 'Estimated monthly operating cost in USD for running this network region, including compute, storage, bandwidth, and support costs. Used for ROI analysis and budget planning.',
    `network_backbone_provider` STRING COMMENT 'Primary network backbone or transit provider serving this region (e.g., Level3, Cogent, Telia, Akamai). Critical for latency and routing optimization.',
    `network_region_status` STRING COMMENT 'Current operational status of the network region. Active regions accept new player connections; inactive regions are offline; maintenance regions are temporarily unavailable; deprecated regions are scheduled for decommissioning.. Valid values are `active|inactive|maintenance|deprecated`',
    `notes` STRING COMMENT 'Free-text notes for operational context, special configurations, known issues, or region-specific considerations.',
    `pcu_record` STRING COMMENT 'Historical peak concurrent users observed in this region. Used for capacity planning and infrastructure investment decisions.',
    `pcu_record_timestamp` TIMESTAMP COMMENT 'Timestamp when the PCU record was achieved. Helps identify seasonal patterns and event-driven spikes.',
    `player_population_density_tier` STRING COMMENT 'Classification of expected player population density for capacity planning. Tier 1 = highest density (major markets), Tier 4 = lowest density (emerging markets).. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `primary_datacenter_location` STRING COMMENT 'Physical city or metro area where the primary datacenter for this region is located. Used for capacity planning and disaster recovery.',
    `region_code` STRING COMMENT 'Cloud provider region code identifier (e.g., us-east-1, eu-west-2, ap-southeast-1). Standard format following cloud provider naming conventions.. Valid values are `^[a-z]{2}-[a-z]+-[0-9]{1,2}$`',
    `supports_mmo` BOOLEAN COMMENT 'Indicates whether this region has the infrastructure capacity and configuration to support MMO game instances with large concurrent player counts.',
    `supports_pve` BOOLEAN COMMENT 'Indicates whether this region is configured to host PvE game modes.',
    `supports_pvp` BOOLEAN COMMENT 'Indicates whether this region is configured to host PvP game modes. False if region is dedicated to PvE or other workloads.',
    `target_fps` STRING COMMENT 'Target server-side FPS for game simulation in this region. Typically 60 or 120 for competitive games. Impacts compute resource allocation.',
    `uptime_sla_percentage` DECIMAL(18,2) COMMENT 'Contractual uptime SLA percentage for this region (e.g., 99.95). Used for vendor management and incident escalation thresholds.',
    CONSTRAINT pk_network_region PRIMARY KEY(`network_region_id`)
) COMMENT 'Reference master for geographic network regions and availability zones used to organize server fleet deployments, CDN topology, matchmaking routing, and latency-based player assignment. Captures region code (e.g., us-east-1, eu-west-2), display name, cloud provider mapping, continent, country cluster, primary and failover data centers, network backbone provider, average inter-region latency to peer regions, player population density tier, and active/inactive status for live service. Provides the geographic backbone for all infrastructure topology decisions and regional capacity governance.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Unique identifier for the capacity plan record. Primary key for this operational planning document capturing CCU/PCU forecasts, scaling decisions, and maintenance windows.',
    `budget_version_id` BIGINT COMMENT 'Foreign key linking to finance.budget_version. Business justification: Capacity plans are inputs to budget version scenarios for infrastructure spend forecasting. Critical for budget planning cycles and scenario modeling for game launches and events.',
    `employee_id` BIGINT COMMENT 'Reference to the analyst or engineer who authored and submitted this capacity plan. Links to workforce/employee master data.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Capacity plans drive infrastructure budget requests and are used for budget variance analysis. Critical for annual budgeting process and quarterly forecast adjustments in gaming infrastructure.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this capacity plan is created. Links to the game title master data.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: capacity_plan is for a specific network_region. Many plans for one region (N:1). capacity_plan.region_code (STRING) matches network_region.region_code. Adding network_region_id FK and removing region_',
    `primary_capacity_employee_id` BIGINT COMMENT 'Reference to the engineer or technical lead who approved this capacity plan for execution. Links to workforce/employee master data.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Capacity planning for live-service games must account for COPPA/GDPR consent flows, age-gate infrastructure, and data retention systems. Compliance requirements (e.g., COPPA parental consent latency) ',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: capacity_plan plans capacity for a server_fleet. Many plans for one fleet (N:1). This links capacity planning to the specific fleet being scaled. No visible columns to remove as plan-level attributes ',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to infrastructure.sla_policy. Business justification: capacity_plan targets SLA metrics defined in sla_policy. Many plans reference one SLA policy (N:1). capacity_plan has target_latency_ms and target_uptime_percentage which are defined in sla_policy. Ad',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Capacity plans target specific KPIs (peak CCU, average latency, uptime percentage) defined in analytics. Infrastructure teams plan capacity to meet KPI thresholds for business commitments and player e',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual total cost in USD incurred for executing this capacity plan. Used for cost variance analysis and financial reconciliation.',
    `actual_maintenance_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance execution completed. Used to track variance from scheduled maintenance window and measure operational precision.',
    `actual_maintenance_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance execution began. Used to track variance from scheduled maintenance window and measure operational precision.',
    `approval_status` STRING COMMENT 'Governance approval status for this capacity plan: pending (awaiting review), approved (authorized for execution), rejected (not authorized), conditional (approved with modifications).. Valid values are `pending|approved|rejected|conditional`',
    `autoscaling_cooldown_seconds` STRING COMMENT 'Number of seconds to wait after a scaling action before triggering another scaling event. Prevents rapid oscillation in server fleet size.',
    `autoscaling_trigger_threshold_percentage` DECIMAL(18,2) COMMENT 'CPU or memory utilization percentage threshold that triggers automatic scaling of server instances. Used to configure auto-scaling policies in cloud infrastructure.',
    `capacity_plan_status` STRING COMMENT 'Current lifecycle status of the capacity plan: draft (under development), approved (ready for execution), active (currently in effect), completed (execution finished), cancelled (plan abandoned).. Valid values are `draft|approved|active|completed|cancelled`',
    `cdn_topology_version` STRING COMMENT 'Version identifier for the CDN topology configuration associated with this capacity plan. Tracks CDN edge node distribution and routing policies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity plan record was first created in the system. Audit trail for record lifecycle tracking.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in USD for executing this capacity plan, including cloud compute, CDN bandwidth, and operational overhead. Used for budget planning and cost governance.',
    `forecasted_peak_ccu` BIGINT COMMENT 'Predicted maximum number of concurrent users expected during the planning horizon. Key input for server fleet sizing and auto-scaling policy configuration.',
    `forecasted_peak_pcu` BIGINT COMMENT 'Predicted absolute peak concurrent users (historical maximum) expected during the planning horizon. Used for worst-case capacity planning and SLA assurance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity plan record was last modified. Audit trail for record lifecycle tracking and change management.',
    `maintenance_type` STRING COMMENT 'Classification of the planned maintenance activity: patch (security or bug fixes), upgrade (version updates), migration (infrastructure changes), emergency (unplanned critical fixes), configuration (settings adjustments).. Valid values are `patch|upgrade|migration|emergency|configuration`',
    `maintenance_window_end_timestamp` TIMESTAMP COMMENT 'Scheduled end date and time for planned maintenance activities. Defines the conclusion of the maintenance window.',
    `maintenance_window_start_timestamp` TIMESTAMP COMMENT 'Scheduled start date and time for planned maintenance activities (patching, upgrades, migrations). Defines the beginning of the maintenance window.',
    `matchmaking_service_version` STRING COMMENT 'Version identifier for the matchmaking service configuration associated with this capacity plan. Tracks matchmaking algorithm and server allocation logic.',
    `notes` STRING COMMENT 'Free-text notes and comments about this capacity plan, including assumptions, risks, dependencies, and special considerations for execution.',
    `notification_status` STRING COMMENT 'Status of player communication for this maintenance window: not_required (transparent maintenance), pending (notification scheduled), sent (players notified), acknowledged (confirmation received).. Valid values are `not_required|pending|sent|acknowledged`',
    `on_demand_instance_count` STRING COMMENT 'Number of on-demand (pay-as-you-go) cloud compute instances allocated for this capacity plan. Provides elastic scaling capacity for peak demand.',
    `plan_name` STRING COMMENT 'Human-readable name or identifier for this capacity plan (e.g., Q4 2024 Holiday Peak Plan, Season 3 Launch Scaling).',
    `plan_type` STRING COMMENT 'Classification of the capacity plan: baseline (steady-state), seasonal (recurring peak), event (esports tournament, content drop), launch (new title or DLC), emergency (unplanned surge), maintenance (scheduled downtime).. Valid values are `baseline|seasonal|event|launch|emergency|maintenance`',
    `planned_server_instance_count` STRING COMMENT 'Total number of server instances (virtual machines or containers) planned to be provisioned to meet the forecasted CCU/PCU demand.',
    `planning_horizon_end_date` DATE COMMENT 'End date of the time period covered by this capacity plan. Defines the conclusion of the forecast and scaling window.',
    `planning_horizon_start_date` DATE COMMENT 'Start date of the time period covered by this capacity plan. Defines the beginning of the forecast and scaling window.',
    `player_impact_level` STRING COMMENT 'Severity of player-facing impact during maintenance: none (transparent), low (minor latency), medium (degraded performance), high (partial outage), critical (full downtime). Drives player communication strategy.. Valid values are `none|low|medium|high|critical`',
    `reserved_instance_count` STRING COMMENT 'Number of reserved (pre-purchased) cloud compute instances allocated for this capacity plan. Provides cost-optimized baseline capacity.',
    `scaling_headroom_percentage` DECIMAL(18,2) COMMENT 'Percentage of additional capacity provisioned above forecasted peak CCU to handle unexpected surges and ensure SLA compliance. Typically 10-30%.',
    `sla_exclusion_window_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this maintenance window is excluded from SLA uptime calculations. True if downtime during this window does not count against SLA commitments.',
    CONSTRAINT pk_capacity_plan PRIMARY KEY(`capacity_plan_id`)
) COMMENT 'Operational record capturing CCU/PCU capacity planning decisions, scaling governance, and planned maintenance windows for server fleets by title, region, and time horizon. Stores forecasted peak CCU, planned server instance count, reserved vs. on-demand split, scaling headroom percentage, auto-scaling trigger thresholds, planned maintenance schedules (patching, upgrades, migrations), maintenance window start/end timestamps, actual execution timestamps, maintenance type (patch, upgrade, migration, emergency), player-facing impact level, notification status, SLA exclusion windows, approval status, approving engineer, and the analyst who authored the plan. Drives cloud compute procurement, auto-scaling policy configuration, proactive downtime coordination, and player communication for GaaS live operations. Unified SSOT for all planned infrastructure changes — both capacity scaling and scheduled maintenance.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`sla_policy` (
    `sla_policy_id` BIGINT COMMENT 'Unique identifier for the SLA policy record. Primary key.',
    `applicable_regions` STRING COMMENT 'Geographic regions or data center locations where this SLA policy applies (e.g., North America, Europe, Asia-Pacific, Global).',
    `approval_date` DATE COMMENT 'Date when this SLA policy was formally approved.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether executive or stakeholder approval is required before this SLA policy can be activated or modified.',
    `approved_by` STRING COMMENT 'Name or role of the person who approved this SLA policy for use.',
    `breach_escalation_path` STRING COMMENT 'Defined escalation procedure and contact chain when SLA thresholds are breached (e.g., DevOps team → Infrastructure Manager → VP Engineering).',
    `breach_notification_required` BOOLEAN COMMENT 'Indicates whether automatic notification is required when SLA thresholds are breached.',
    `cdn_coverage_required` BOOLEAN COMMENT 'Indicates whether CDN topology and performance are included in this SLA policy for content delivery and patch distribution.',
    `ci_cd_pipeline_sla_included` BOOLEAN COMMENT 'Indicates whether DevOps CI/CD pipeline health and deployment success rates are covered under this SLA policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA policy record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this SLA policy expires or is superseded. Null for open-ended policies.',
    `effective_start_date` DATE COMMENT 'Date when this SLA policy becomes active and enforceable.',
    `last_review_date` DATE COMMENT 'Date when this SLA policy was last reviewed and validated by stakeholders.',
    `matchmaking_sla_included` BOOLEAN COMMENT 'Indicates whether matchmaking service performance and availability are covered under this SLA policy.',
    `max_ccu_capacity` BIGINT COMMENT 'Maximum number of concurrent users the infrastructure must support under this SLA policy. Critical for capacity planning and GaaS live service delivery.',
    `max_latency_ms` STRING COMMENT 'Maximum allowable network latency in milliseconds for the service to meet SLA commitments. Critical for real-time multiplayer gaming (PvP/PvE/MMO) and player experience.',
    `max_pcu_capacity` BIGINT COMMENT 'Maximum peak concurrent users the infrastructure must handle during surge periods (e.g., game launches, events, tournaments).',
    `measurement_period` STRING COMMENT 'Time period over which SLA performance is measured and reported (e.g., monthly uptime calculation).. Valid values are `hourly|daily|weekly|monthly|quarterly`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA policy record was last modified.',
    `monitoring_interval_seconds` STRING COMMENT 'Frequency in seconds at which infrastructure performance metrics (uptime, latency, FPS) are monitored and measured against SLA targets.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this SLA policy.',
    `notes` STRING COMMENT 'Additional notes, exceptions, or special conditions related to this SLA policy.',
    `owner_role` STRING COMMENT 'Role or department responsible for maintaining and enforcing this SLA policy (e.g., Infrastructure Manager, DevOps Lead, VP Engineering).',
    `penalty_clause` STRING COMMENT 'Description of financial or service credit penalties applied when SLA commitments are not met.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the SLA policy used in operational systems and reporting.',
    `policy_name` STRING COMMENT 'Human-readable name of the SLA policy tier (e.g., Gold, Silver, Bronze, Premium, Standard).',
    `reporting_frequency` STRING COMMENT 'Frequency at which SLA performance reports are generated and distributed to stakeholders.. Valid values are `real_time|daily|weekly|monthly`',
    `review_frequency_days` STRING COMMENT 'Number of days between scheduled reviews of this SLA policy to ensure it remains aligned with business needs and technical capabilities.',
    `rpo_minutes` STRING COMMENT 'Recovery Point Objective in minutes - the maximum acceptable amount of data loss measured in time (e.g., data must be recoverable to within 5 minutes of failure).',
    `rto_minutes` STRING COMMENT 'Recovery Time Objective in minutes - the maximum acceptable time to restore service after an incident or outage.',
    `service_scope` STRING COMMENT 'Description of the infrastructure components and services covered by this SLA policy (e.g., server fleet, CDN, matchmaking, game servers, PvP/PvE/MMO services).',
    `sla_policy_description` STRING COMMENT 'Detailed description of the SLA policy including its purpose, scope, and key commitments.',
    `sla_policy_status` STRING COMMENT 'Current lifecycle status of the SLA policy indicating whether it is in use, being drafted, or retired.. Valid values are `active|inactive|draft|deprecated|suspended`',
    `target_fps` STRING COMMENT 'Target frames per second performance metric for game server infrastructure to ensure smooth gameplay experience.',
    `target_uptime_percentage` DECIMAL(18,2) COMMENT 'Committed uptime availability percentage for the service (e.g., 99.99%, 99.95%, 99.9%). Represents the percentage of time the service must be operational.',
    `tier_level` STRING COMMENT 'Classification tier of the SLA policy indicating service priority and commitment level.. Valid values are `platinum|gold|silver|bronze|standard|basic`',
    `version_number` STRING COMMENT 'Version identifier for this SLA policy to track revisions and changes over time.',
    CONSTRAINT pk_sla_policy PRIMARY KEY(`sla_policy_id`)
) COMMENT 'Reference record defining uptime, latency, and availability SLA targets for live service infrastructure components. Captures SLA tier name, target uptime percentage, maximum allowable latency (ms), RTO (Recovery Time Objective), RPO (Recovery Point Objective), breach escalation path, and applicable service scope (server fleet, CDN, matchmaking). Governs operational commitments for GaaS live service delivery.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` (
    `infrastructure_incident_id` BIGINT COMMENT 'Unique identifier for the infrastructure incident record. Primary key for incident tracking and post-mortem analysis.',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: infrastructure_incident can affect a cdn_node. Many incidents for one CDN node (N:1). This links incidents to the specific CDN node impacted. No visible columns to remove.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Infrastructure incidents that expose player data or violate service terms spawn compliance incidents requiring regulatory notification. Standard incident response workflow links technical and complian',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Incident response costs and downtime impact must be tracked against cost centers for financial reporting. Essential for incident cost accounting and P&L impact assessment.',
    `employee_id` BIGINT COMMENT 'Identifier of the DevOps engineer or SRE assigned as incident commander for this incident.',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: infrastructure_incident can affect a specific game_server. Many incidents for one server (N:1). This links incidents to the specific server impacted. No visible columns to remove.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title affected by the incident. Null for platform-wide infrastructure incidents affecting multiple titles.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: infrastructure_incident impacts a network_region. Many incidents in one region (N:1). infrastructure_incident.impacted_region (STRING) matches network_region.region_code. Adding network_region_id FK a',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Infrastructure incidents (data breaches, service outages) trigger regulatory reporting obligations under GDPR Article 33, CCPA breach notification, and service availability regulations. Compliance tea',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: infrastructure_incident can affect a server_fleet. Many incidents for one fleet (N:1). This links incidents to the specific fleet impacted. No visible columns to remove as incident-specific attributes',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to infrastructure.sla_policy. Business justification: infrastructure_incident is evaluated against sla_policy. Many incidents under one SLA policy (N:1). infrastructure_incident has sla_breach_flag and sla_target_resolution_minutes which are defined in s',
    `storefront_id` BIGINT COMMENT 'Identifier of the gaming platform affected (console, PC, mobile). Null for cross-platform infrastructure incidents.',
    `title_pl_id` BIGINT COMMENT 'Foreign key linking to finance.title_pl. Business justification: Major incidents impact title P&L through revenue loss and recovery costs. Essential for incident financial impact assessment and monthly P&L variance explanations.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident was acknowledged by the on-call engineer or incident response team. Measures time-to-acknowledge SLA.',
    `actual_resolution_minutes` STRING COMMENT 'Actual time in minutes from detection to resolution. Compared against SLA target for performance measurement.',
    `affected_service_component` STRING COMMENT 'Primary infrastructure component or service experiencing the incident (e.g., matchmaking service, game server fleet, CDN edge nodes, authentication API, player data store).',
    `ccu_affected_count` BIGINT COMMENT 'Estimated number of concurrent users impacted by the incident at peak. Critical metric for SLA breach assessment and business impact quantification.',
    `change_request_id` BIGINT COMMENT 'Identifier of the change request or deployment that preceded the incident, if applicable. Used to correlate incidents with recent changes.',
    `closure_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was formally closed after post-mortem review and documentation completion.',
    `communication_channel` STRING COMMENT 'Primary communication channel used for incident coordination (e.g., Slack war room, PagerDuty, Zoom bridge, Jira ticket).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the incident management system. Audit trail for record lifecycle.',
    `detected_by_source` STRING COMMENT 'Origin of the incident detection. Tracks effectiveness of monitoring systems versus reactive player reports.. Valid values are `automated_monitoring|player_report|internal_team|third_party_alert`',
    `detection_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident was first detected by monitoring systems or reported by players. Start of incident timeline for SLA measurement.',
    `escalation_level` STRING COMMENT 'Current escalation tier of the incident. L1 = on-call engineer; L2 = senior SRE; L3 = engineering leadership; executive = C-level notification.. Valid values are `L1|L2|L3|executive`',
    `estimated_revenue_impact_usd` DECIMAL(18,2) COMMENT 'Estimated revenue loss in USD due to the incident, calculated from CCU affected, average ARPU, and outage duration. Used for business impact assessment.',
    `external_communication_flag` BOOLEAN COMMENT 'Indicates whether the incident required public status page updates or player-facing communication. True if external communication was issued.',
    `incident_number` STRING COMMENT 'Externally-visible unique incident identifier used for communication, ticketing, and cross-team coordination. Format: INC-YYYYMMDD sequence.. Valid values are `^INC-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current lifecycle state of the incident. Tracks progression from detection through resolution and closure.. Valid values are `detected|acknowledged|investigating|mitigating|resolved|closed`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the incident record. Tracks ongoing investigation and resolution progress.',
    `mitigation_action_summary` STRING COMMENT 'Brief summary of the immediate actions taken to mitigate the incident (e.g., failover to backup region, service restart, traffic throttling).',
    `monitoring_alert_id` BIGINT COMMENT 'Identifier of the monitoring system alert that triggered incident detection. Links to observability platform for detailed metrics.',
    `player_facing_impact_description` STRING COMMENT 'Business-friendly description of how the incident affects player experience (e.g., unable to join matches, login failures, high latency, store unavailable). Used for status page communication.',
    `post_mortem_reference` STRING COMMENT 'URL or document identifier linking to the full post-mortem report with detailed timeline, root cause analysis, and action items.',
    `preventive_action_items` STRING COMMENT 'List of follow-up action items identified to prevent recurrence (e.g., add monitoring, update runbook, increase capacity, patch software).',
    `related_incident_ids` STRING COMMENT 'Comma-separated list of related or duplicate incident IDs that share the same root cause or are part of a cascading failure.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident was fully resolved and service restored to normal operation. End of incident timeline for SLA measurement.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying cause of the incident. Used for trend analysis and preventive action planning. [ENUM-REF-CANDIDATE: infrastructure_failure|software_bug|configuration_error|capacity_overload|network_issue|third_party_dependency|human_error|security_incident|unknown — 9 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed technical explanation of the root cause identified during post-incident analysis. Supports knowledge base and runbook updates.',
    `severity_level` STRING COMMENT 'Priority classification of the incident impact. P0 = critical outage affecting all players; P1 = major service degradation; P2 = moderate impact; P3 = minor issue; P4 = low priority.. Valid values are `P0|P1|P2|P3|P4`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the incident violated contractual or internal SLA thresholds for uptime, latency, or response time. True if breach occurred.',
    `title` STRING COMMENT 'Brief human-readable summary of the infrastructure incident for dashboards, alerts, and status pages.',
    CONSTRAINT pk_infrastructure_incident PRIMARY KEY(`infrastructure_incident_id`)
) COMMENT 'Transactional record for live service infrastructure incidents including server outages, CDN failures, matchmaking degradation, and network disruptions. Captures incident title, severity level (P0–P4), affected service components, impacted regions, player-facing impact description, CCU affected count, detection timestamp, acknowledgment timestamp, resolution timestamp, root cause category, and post-mortem reference. SSOT for all infrastructure incident management and SLA breach tracking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`server_session` (
    `server_session_id` BIGINT COMMENT 'Unique identifier for the multiplayer game server session. Primary key for the server_session product.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Server sessions for age-restricted content must validate player age against the games rating certificate. Enforcement mechanism for ESRB/PEGI compliance; sessions log which rating certificate governe',
    `deferred_revenue_id` BIGINT COMMENT 'Foreign key linking to finance.deferred_revenue. Business justification: Server sessions deliver performance obligations for pre-purchased content, season passes, and subscriptions. Essential for revenue recognition in live service games under ASC 606.',
    `game_mode_id` BIGINT COMMENT 'Foreign key linking to title.game_mode. Business justification: Server sessions are instances of specific game modes. Operations teams analyze session performance, stability, and player experience by mode to tune mode-specific configurations, balance gameplay, and',
    `game_server_id` BIGINT COMMENT 'Reference to the physical or virtual game server instance hosting this session.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being played in this session.',
    `guild_id` BIGINT COMMENT 'Foreign key linking to community.guild. Business justification: Server sessions host guild-specific events, raids, and private matches. Operations teams track guild activity patterns for capacity planning, and guilds monitor their server performance for competitiv',
    `match_id` BIGINT COMMENT 'Foreign key linking to esports.match. Business justification: Server sessions hosting esports matches should reference the match for competitive integrity, replay systems, and match verification. This enables linking server performance metrics to competitive mat',
    `matchmaking_pool_id` BIGINT COMMENT 'Reference to the matchmaking pool or queue from which players were assigned to this session.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: server_session occurs in a network_region. Many sessions in one region (N:1). server_session.region_code (STRING) matches network_region.region_code. Adding network_region_id FK and removing region_co',
    `session_event_summary_id` BIGINT COMMENT 'Foreign key linking to analytics.session_event_summary. Business justification: Server sessions generate aggregated analytics summaries used for performance reporting, player behavior analysis, and infrastructure capacity planning. Operations teams correlate session performance m',
    `anti_cheat_flags` STRING COMMENT 'Comma-separated list of anti-cheat system flags or alerts triggered during the session.',
    `average_fps` DECIMAL(18,2) COMMENT 'Mean server-side frames per second reported during the session, indicating server performance and rendering capability.',
    `average_latency_ms` DECIMAL(18,2) COMMENT 'Mean network latency in milliseconds experienced by players during the session, critical for player experience quality.',
    `average_player_count` DECIMAL(18,2) COMMENT 'Mean number of players connected throughout the session duration.',
    `cpu_utilization_percent` DECIMAL(18,2) COMMENT 'Average CPU utilization percentage on the server instance during the session.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this server session record was first created in the data platform.',
    `incident_count` STRING COMMENT 'Number of operational incidents or errors logged during the session.',
    `is_private` BOOLEAN COMMENT 'Indicates whether this session was a private match created by players rather than public matchmaking.',
    `is_ranked` BOOLEAN COMMENT 'Indicates whether this session was a ranked competitive match affecting player rankings and leaderboards.',
    `map_name` STRING COMMENT 'The name or identifier of the game map or level played during this session.',
    `match_result` STRING COMMENT 'Outcome of the match if applicable (e.g., team_a_win, team_b_win, draw, incomplete).',
    `max_player_capacity` STRING COMMENT 'Maximum number of players the session was configured to support.',
    `memory_utilization_percent` DECIMAL(18,2) COMMENT 'Average memory utilization percentage on the server instance during the session.',
    `minimum_fps` DECIMAL(18,2) COMMENT 'Lowest server-side frames per second recorded during the session, indicating performance bottlenecks.',
    `packet_loss_percent` DECIMAL(18,2) COMMENT 'Average network packet loss percentage experienced during the session, critical for diagnosing connectivity issues.',
    `peak_latency_ms` DECIMAL(18,2) COMMENT 'Maximum network latency in milliseconds observed during the session.',
    `peak_player_count` STRING COMMENT 'Maximum number of concurrent players connected to this session at any point during its lifecycle.',
    `server_tick_rate` STRING COMMENT 'Server simulation update frequency in ticks per second, affecting gameplay responsiveness and accuracy.',
    `server_version` STRING COMMENT 'Version of the game server software running this session, used for compatibility tracking and rollback analysis.',
    `session_duration_seconds` STRING COMMENT 'Total duration of the session in seconds, calculated from start to end timestamp.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the server session ended, either normally or abnormally.',
    `session_identifier` STRING COMMENT 'Externally-visible unique session code or GUID used by clients and matchmaking services to reference this session.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the server session was initiated and became available for player connections.',
    `session_status` STRING COMMENT 'Current lifecycle status of the server session.. Valid values are `initializing|waiting_for_players|in_progress|completed|terminated|crashed`',
    `termination_reason` STRING COMMENT 'The reason why the session ended, used for operational monitoring and incident analysis.. Valid values are `normal_completion|server_crash|timeout|admin_shutdown|insufficient_players|network_failure`',
    `total_bandwidth_mb` DECIMAL(18,2) COMMENT 'Total network bandwidth consumed by the session in megabytes, used for CDN cost analysis and capacity planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this server session record was last updated in the data platform.',
    CONSTRAINT pk_server_session PRIMARY KEY(`server_session_id`)
) COMMENT 'Transactional record for individual multiplayer game sessions hosted on a game server instance. Captures session identifier, hosting server reference, game title and mode, matchmaking pool reference, session start and end timestamps, peak player count, average latency (ms), average FPS reported, session termination reason (normal, crash, timeout), and region. The atomic unit of live multiplayer session telemetry for GaaS operational monitoring.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` (
    `network_performance_event_id` BIGINT COMMENT 'Unique identifier for the network performance event record. Primary key for this transactional event log.',
    `cdn_node_id` BIGINT COMMENT 'Reference to the CDN node being monitored. Links to the CDN topology resource that generated this performance measurement.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.defect. Business justification: Performance degradation events (latency spikes, packet loss, FPS drops) may be caused by defects. Performance monitoring alerts trigger defect creation for investigation, fix tracking, and SLA breach ',
    `game_server_id` BIGINT COMMENT 'Reference to the game server instance being monitored. Links to the server fleet resource that generated this performance measurement.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being served by this infrastructure component. Links performance data to specific game products for title-specific SLA tracking.',
    `infrastructure_incident_id` BIGINT COMMENT 'Reference to the incident record if this performance event triggered or is associated with an operational incident. Links observability data to incident management workflow.',
    `matchmaking_service_id` BIGINT COMMENT 'Reference to the matchmaking service instance being monitored. Links to the matchmaking resource that generated this performance measurement.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: network_performance_event is measured in a network_region. Many events in one region (N:1). network_performance_event.region_code (STRING) matches network_region.region_code. Adding network_region_id ',
    `sla_policy_id` BIGINT COMMENT 'Reference to the SLA policy governing this component. Links to the policy defining uptime targets, latency thresholds, and performance commitments for GaaS delivery.',
    `telemetry_pipeline_id` BIGINT COMMENT 'Foreign key linking to analytics.telemetry_pipeline. Business justification: Network performance events are ingested through specific telemetry pipelines for real-time monitoring and alerting. Operations teams track which pipeline processed each event for data quality and SLA ',
    `alert_triggered_flag` BOOLEAN COMMENT 'Boolean indicator whether this measurement triggered an automated alert in the monitoring system. True indicates threshold breach requiring operational attention.',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Calculated availability percentage for the measurement period. Expressed as a percentage (0.00 to 100.00). Used for SLA compliance tracking and uptime reporting.',
    `breach_severity` STRING COMMENT 'Severity classification of the SLA breach if one occurred. Critical breaches require immediate escalation and incident management response.. Valid values are `critical|major|minor|warning`',
    `ccu_count` BIGINT COMMENT 'Number of concurrent users connected to this component at the time of measurement. Used for capacity planning and correlating performance degradation with load.',
    `component_type` STRING COMMENT 'Type of infrastructure component being monitored. Discriminator field indicating which resource reference is populated and what kind of performance data is being captured.. Valid values are `game_server|cdn_node|matchmaking_service|load_balancer|database_cluster|api_gateway`',
    `cpu_utilization_percentage` DECIMAL(18,2) COMMENT 'CPU utilization percentage for the monitored component during the measurement period. Expressed as a percentage (0.00 to 100.00). Used for capacity planning and performance correlation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance event record was first created in the data platform. Audit trail for data lineage and ETL processing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score for this measurement record. Expressed as a decimal (0.00 to 1.00). Indicates completeness, accuracy, and reliability of the captured performance metrics.',
    `downtime_seconds` BIGINT COMMENT 'Total seconds the component was unavailable or non-operational during the measurement period. Used to calculate availability percentage and track service disruptions.',
    `error_count` BIGINT COMMENT 'Number of errors or exceptions encountered during the measurement period. Used to correlate performance degradation with application-level errors and stability issues.',
    `fps_impact_flag` BOOLEAN COMMENT 'Boolean indicator whether this performance measurement had a measurable negative impact on client-side FPS. True indicates degraded rendering performance due to network issues.',
    `http_status_code` STRING COMMENT 'HTTP response status code for API gateway and web service measurements. Standard HTTP status codes (200, 404, 500, etc.) indicating request success or failure type.',
    `jitter_ms` DECIMAL(18,2) COMMENT 'Variation in packet arrival times measured in milliseconds. High jitter causes inconsistent gameplay experience and affects real-time multiplayer synchronization.',
    `latency_ms` DECIMAL(18,2) COMMENT 'Round-trip network latency measured in milliseconds. Critical metric for real-time multiplayer game quality (PvP/PvE/MMO). Lower values indicate better player experience.',
    `measurement_method` STRING COMMENT 'Method used to capture this performance measurement. Distinguishes between continuous real-time monitoring, scheduled periodic checks, and event-driven measurements.. Valid values are `real_time|periodic_aggregation|on_demand|threshold_triggered`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Point-in-time when this performance measurement was captured. The principal business event timestamp for this observability event. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `measurement_window_end` TIMESTAMP COMMENT 'End of the time window for aggregated performance metrics. Used when the event represents a periodic summary rather than a point-in-time snapshot. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `measurement_window_start` TIMESTAMP COMMENT 'Start of the time window for aggregated performance metrics. Used when the event represents a periodic summary rather than a point-in-time snapshot. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `memory_utilization_percentage` DECIMAL(18,2) COMMENT 'Memory utilization percentage for the monitored component during the measurement period. Expressed as a percentage (0.00 to 100.00). Used for capacity planning and performance correlation.',
    `monitoring_source` STRING COMMENT 'Type of monitoring tool or method that captured this performance measurement. Indicates the observability instrumentation source and data collection methodology.. Valid values are `synthetic_probe|agent_based|network_tap|log_aggregation|apm_tool`',
    `notes` STRING COMMENT 'Free-text notes or annotations about this performance measurement. Used by operations teams to document context, root cause analysis, or remediation actions.',
    `packet_loss_percentage` DECIMAL(18,2) COMMENT 'Percentage of network packets lost during transmission. Expressed as a percentage (0.00 to 100.00). High packet loss degrades gameplay quality and player experience.',
    `platform_code` STRING COMMENT 'Platform being served by this infrastructure component. Used to analyze platform-specific performance characteristics and optimize infrastructure per platform requirements. [ENUM-REF-CANDIDATE: PC|PS5|PS4|XBOX_SERIES|XBOX_ONE|SWITCH|MOBILE_IOS|MOBILE_ANDROID — 8 candidates stripped; promote to reference product]',
    `response_time_ms` DECIMAL(18,2) COMMENT 'API or service response time measured in milliseconds. Distinct from network latency; measures application-layer processing time for request-response cycles.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator whether this measurement constitutes an SLA breach. True indicates performance fell below contractual thresholds defined in the SLA policy.',
    `throughput_mbps` DECIMAL(18,2) COMMENT 'Data transfer rate measured in megabits per second (Mbps). Indicates bandwidth capacity and utilization for game data, asset streaming, and CDN delivery.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance event record was last modified in the data platform. Audit trail for data lineage and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `uptime_seconds` BIGINT COMMENT 'Total seconds the component was operational and available during the measurement period. Used to calculate availability percentage and track service reliability.',
    CONSTRAINT pk_network_performance_event PRIMARY KEY(`network_performance_event_id`)
) COMMENT 'Transactional record capturing point-in-time and periodic infrastructure health measurements for live service components including servers, CDN nodes, and matchmaking services. Each row records the monitored component type and reference, measurement timestamp or window, latency (ms), packet loss percentage, jitter (ms), throughput (Mbps), calculated availability percentage, uptime/downtime seconds for the measurement period, FPS impact flag, SLA policy reference, and whether the measurement constitutes an SLA breach. Serves as the unified SSOT for all infrastructure observability data feeding real-time operational dashboards, SLA compliance reporting, and availability tracking for GaaS delivery.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` (
    `infrastructure_deployment_id` BIGINT COMMENT 'Unique identifier for the infrastructure deployment record. Primary key for the infrastructure deployment entity.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Audit findings (inadequate logging, missing encryption, insecure configurations) trigger infrastructure deployments to remediate. Standard compliance remediation workflow tracks which deployment addre',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Major infrastructure deployments often represent capitalized development costs for game platforms and engines. Critical for tracking capitalization of internally developed technology assets.',
    `change_request_id` BIGINT COMMENT 'Foreign key linking to infrastructure.change_request. Business justification: infrastructure_deployment currently has change_ticket_reference (STRING) but no proper FK to change_request. Deployments must be authorized through change management processes. Adding change_request_i',
    `cicd_pipeline_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cicd_pipeline. Business justification: infrastructure_deployment is executed via a cicd_pipeline. Many deployments via one pipeline (N:1). infrastructure_deployment.pipeline_execution_id (STRING) references a pipeline run. Adding cicd_pipe',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being deployed. Links this deployment to the specific game product.',
    `intangible_asset_id` BIGINT COMMENT 'Foreign key linking to finance.intangible_asset. Business justification: Game engine and platform deployments create or enhance intangible assets. Essential for capitalization of internally developed technology and amortization tracking.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: infrastructure_deployment targets a network_region. Many deployments to one region (N:1). infrastructure_deployment.target_region (STRING) matches network_region.region_code. Adding network_region_id ',
    `employee_id` BIGINT COMMENT 'Reference to the engineer or automated system that triggered this deployment. Used for accountability and audit trail.',
    `remediation_action_id` BIGINT COMMENT 'Foreign key linking to compliance.remediation_action. Business justification: Remediation actions from compliance incidents or audits are implemented via infrastructure deployments. Tracks compliance fix delivery; deployment references the remediation action it fulfills for aud',
    `server_fleet_id` BIGINT COMMENT 'Reference to the target server fleet or server group receiving this deployment.',
    `actual_downtime_minutes` STRING COMMENT 'Actual duration in minutes that game services were unavailable during deployment. Zero for zero-downtime deployments. Used for SLA tracking and player impact analysis.',
    `affected_player_count` STRING COMMENT 'Estimated number of active players impacted by this deployment. Based on CCU at deployment time. Used for player communication and impact assessment.',
    `approval_status` STRING COMMENT 'Change approval board status for this deployment. Pending approval awaiting review; approved cleared for deployment; rejected denied by approvers; auto-approved met automated criteria; emergency override deployed without standard approval due to critical incident.. Valid values are `pending_approval|approved|rejected|auto_approved|emergency_override`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the deployment was approved. Null if not yet approved or auto-approved.',
    `artifact_repository_url` STRING COMMENT 'URL to the deployment artifact in the artifact repository (e.g., Docker registry, S3 bucket, Artifactory). Used for traceability and rollback operations.. Valid values are `^https?://[a-zA-Z0-9.-]+/.*$`',
    `automated_deployment_flag` BOOLEAN COMMENT 'Indicates whether this deployment was fully automated or required manual intervention. True for fully automated; false for manual or semi-automated deployments.',
    `build_version` STRING COMMENT 'Semantic version number of the game build being deployed. Follows semantic versioning convention (major.minor.patch.build).. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `canary_percentage` DECIMAL(18,2) COMMENT 'Percentage of traffic or server instances receiving the canary deployment. Null for non-canary deployments. Range 0.00 to 100.00.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the deployment execution completed (successfully or with failure). Null if deployment is still in progress or paused.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deployment record was first created in the system. Audit trail for record creation.',
    `deployment_number` STRING COMMENT 'Externally-known unique identifier for this deployment. Human-readable deployment tracking number used across teams and systems.. Valid values are `^[A-Z]{3}-[0-9]{8}-[0-9]{4}$`',
    `deployment_status` STRING COMMENT 'Current lifecycle state of the deployment. Pending indicates queued for execution; in-progress is actively deploying; succeeded completed successfully; failed encountered errors; rolled-back reverted to previous version; cancelled stopped by operator; paused temporarily halted. [ENUM-REF-CANDIDATE: pending|in_progress|succeeded|failed|rolled_back|cancelled|paused — 7 candidates stripped; promote to reference product]',
    `deployment_type` STRING COMMENT 'Classification of the deployment based on scope and urgency. Hotfix addresses critical production issues; patch includes bug fixes and minor updates; full release is a major version; rollback reverts to previous version; canary is limited test deployment; emergency is unscheduled critical fix.. Valid values are `hotfix|patch|full_release|rollback|canary|emergency`',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether this deployment requires taking game servers offline. True if downtime is necessary; false for zero-downtime deployments.',
    `duration_minutes` STRING COMMENT 'Total elapsed time in minutes from deployment start to completion. Used for performance tracking and capacity planning.',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the deployment failed. Null for successful deployments. Used for root cause analysis and process improvement.',
    `health_check_status` STRING COMMENT 'Result of post-deployment health checks and smoke tests. Passed indicates all checks successful; failed indicates critical issues; warning indicates non-critical issues; not run if checks were skipped; in progress if checks are still executing.. Valid values are `passed|failed|warning|not_run|in_progress`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this deployment record was last updated. Audit trail for record modifications.',
    `monitoring_dashboard_url` STRING COMMENT 'URL to the real-time monitoring dashboard for this deployment. Links to observability tools (e.g., Grafana, Datadog) showing deployment health metrics.. Valid values are `^https?://[a-zA-Z0-9.-]+/.*$`',
    `notes` STRING COMMENT 'Free-text operational notes and comments about the deployment. Includes special instructions, known issues, rollback procedures, and post-deployment observations.',
    `previous_build_version` STRING COMMENT 'Version number of the build that was running before this deployment. Used for rollback operations and version history tracking.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `priority` STRING COMMENT 'Business priority level of this deployment. Critical for emergency fixes; high for important features or fixes; normal for standard releases; low for non-urgent updates.. Valid values are `critical|high|normal|low`',
    `rollback_eligible_flag` BOOLEAN COMMENT 'Indicates whether this deployment can be automatically rolled back to the previous version. True if rollback is supported; false if manual intervention is required.',
    `server_count` STRING COMMENT 'Number of server instances included in this deployment. Used for capacity tracking and deployment scope analysis.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the deployment execution began. Marks the beginning of the deployment window.',
    `strategy` STRING COMMENT 'Technical strategy used to roll out the deployment. Blue-green switches traffic between two identical environments; canary gradually increases traffic to new version; rolling updates instances incrementally; recreate terminates old version before starting new; all-at-once updates all instances simultaneously.. Valid values are `blue_green|canary|rolling|recreate|all_at_once`',
    `target_environment` STRING COMMENT 'Deployment environment tier. Development for active development; staging for pre-production testing; UAT for user acceptance testing; production for live player-facing services; disaster recovery for backup failover environment.. Valid values are `development|staging|uat|production|disaster_recovery`',
    `window_end` TIMESTAMP COMMENT 'Scheduled end time of the approved deployment window. Deployment must complete before this time to avoid SLA violations.',
    `window_start` TIMESTAMP COMMENT 'Scheduled start time of the approved deployment window. Used for maintenance window planning and player communication.',
    CONSTRAINT pk_infrastructure_deployment PRIMARY KEY(`infrastructure_deployment_id`)
) COMMENT 'Transactional record for game server software deployments and live service patch rollouts executed via the CI/CD pipeline. Captures deployment identifier, target fleet or server group, game title and build version, deployment type (hotfix, patch, full release, rollback), deployment strategy (blue-green, canary, rolling), initiated-by engineer, start and completion timestamps, deployment status (pending, in-progress, succeeded, failed, rolled-back), and change ticket reference. SSOT for live ops deployment history.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` (
    `cicd_pipeline_id` BIGINT COMMENT 'Unique identifier for the CI/CD pipeline definition and execution record. Primary key.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: External auditors review CI/CD pipelines for SOC 2, ISO 27001, and age rating compliance (build integrity, content control, deployment controls). Pipelines are audit subjects; engagement tracks which ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CI/CD infrastructure costs are allocated to studio/title cost centers for development cost tracking. Essential for development tooling cost allocation and studio P&L reporting.',
    `game_studio_id` BIGINT COMMENT 'Reference to the studio or development team that owns and maintains this pipeline.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this pipeline builds, tests, or deploys.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: CI/CD pipelines require individual technical owners for on-call rotation, approval workflows, troubleshooting escalation, and maintenance accountability. Gaming studios track pipeline ownership for De',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: cicd_pipeline deploys to a server_fleet. Many pipeline runs for one fleet (N:1). cicd_pipeline.deployment_target (STRING) references the target fleet. Adding server_fleet_id FK and removing deployment',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this pipeline is currently active and available for execution (true) or has been disabled/archived (false).',
    `approval_gate_required` BOOLEAN COMMENT 'Indicates whether this pipeline requires manual approval before proceeding to deployment stages.',
    `artifact_version` STRING COMMENT 'Version identifier of the build artifact produced by this pipeline run (e.g., 1.2.3-build.456, v2024.01.15).',
    `branch_name` STRING COMMENT 'Source control branch from which this pipeline run was triggered (e.g., main, develop, feature/new-weapon).',
    `build_agent` STRING COMMENT 'Identifier of the CI/CD build agent or runner that executed this pipeline (e.g., jenkins-agent-03, github-runner-linux-01).',
    `commit_sha` STRING COMMENT 'Git commit SHA (40-character hexadecimal hash) that this pipeline run built and tested.. Valid values are `^[a-f0-9]{40}$`',
    `container_image_tag` STRING COMMENT 'Docker or container image tag produced by this pipeline run (e.g., game-server:v1.2.3, unity-client:latest).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipeline definition was first created in the CI/CD system.',
    `deployment_approval_status` STRING COMMENT 'Status of manual deployment approval gate for this pipeline run (pending, approved, rejected, not_required).. Valid values are `pending|approved|rejected|not_required`',
    `duration_seconds` STRING COMMENT 'Total execution time of the pipeline run in seconds, from start to completion.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the pipeline run execution completed (success, failure, or cancellation).',
    `failure_reason` STRING COMMENT 'High-level reason for pipeline failure if run_status is failed (e.g., unit tests failed, build compilation error, deployment timeout).',
    `last_successful_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful pipeline execution (run_status = passed).',
    `max_execution_time_minutes` STRING COMMENT 'Maximum allowed execution time for this pipeline in minutes before automatic timeout and cancellation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipeline definition or execution record was last modified.',
    `notification_recipients` STRING COMMENT 'Comma-separated list of email addresses or Slack channels that receive notifications for this pipelines execution results.',
    `parallel_execution_enabled` BOOLEAN COMMENT 'Indicates whether this pipeline is configured to execute stages in parallel for faster build times.',
    `pipeline_config_version` STRING COMMENT 'Version or commit SHA of the pipeline configuration file used for this run (e.g., Jenkinsfile, .gitlab-ci.yml version).',
    `pipeline_description` STRING COMMENT 'Detailed description of the pipelines purpose, stages, and deployment responsibilities.',
    `pipeline_name` STRING COMMENT 'Human-readable name of the CI/CD pipeline (e.g., game-server-build-prod, unity-client-staging).',
    `pipeline_priority` STRING COMMENT 'Execution priority level for this pipeline when multiple pipelines are queued (critical, high, normal, low).. Valid values are `critical|high|normal|low`',
    `pipeline_tool` STRING COMMENT 'CI/CD platform or tool used to execute this pipeline (Jenkins, GitHub Actions, GitLab CI, TeamCity, Azure DevOps, CircleCI).. Valid values are `Jenkins|GitHub Actions|GitLab CI|TeamCity|Azure DevOps|CircleCI`',
    `quality_gate_passed` BOOLEAN COMMENT 'Indicates whether all quality gates (code coverage, security scans, performance thresholds) were passed in this run.',
    `repository_url` STRING COMMENT 'Source control repository URL that this pipeline monitors and builds from (e.g., GitHub, GitLab, Perforce Helix Core repository path).',
    `retry_count` STRING COMMENT 'Number of times this pipeline run was automatically retried after transient failures.',
    `run_number` BIGINT COMMENT 'Sequential execution number for this pipeline run, incremented with each execution.',
    `run_status` STRING COMMENT 'Current execution status of the pipeline run: queued, running, passed, failed, cancelled, or aborted.. Valid values are `queued|running|passed|failed|cancelled|aborted`',
    `security_scan_status` STRING COMMENT 'Result of security vulnerability scanning during this pipeline run (passed, failed, skipped, warning).. Valid values are `passed|failed|skipped|warning`',
    `stages_failed` STRING COMMENT 'Number of pipeline stages that failed during this run.',
    `stages_passed` STRING COMMENT 'Number of pipeline stages that completed successfully in this run.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the pipeline run execution started.',
    `tag_name` STRING COMMENT 'Source control tag associated with this pipeline run, if triggered by a tag (e.g., v1.2.3, release-2024-01).',
    `target_environment` STRING COMMENT 'Deployment environment this pipeline targets (dev, staging, production, QA, UAT).. Valid values are `dev|staging|production|QA|UAT`',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Code test coverage percentage achieved during this pipeline run (0.00 to 100.00).',
    `trigger_source` STRING COMMENT 'Specific source that triggered this run (e.g., commit SHA, schedule name, user ID, webhook event ID).',
    `trigger_type` STRING COMMENT 'Mechanism that initiates pipeline execution: commit push, scheduled cron, manual invocation, pull request merge, tag creation, or external webhook.. Valid values are `commit|scheduled|manual|PR merge|tag|webhook`',
    `triggering_actor` STRING COMMENT 'Username or service account that initiated this pipeline run (human user, automated service, or webhook source).',
    `webhook_url` STRING COMMENT 'Webhook endpoint URL that external systems can call to trigger this pipeline execution.',
    CONSTRAINT pk_cicd_pipeline PRIMARY KEY(`cicd_pipeline_id`)
) COMMENT 'Combined master and execution record for CI/CD pipeline definitions and their run history used to build, test, and deploy game server software and live service components. Master attributes: pipeline name, owning studio or team, associated game title, pipeline tool (Jenkins, GitHub Actions, GitLab CI, TeamCity), trigger type (commit, scheduled, manual, PR merge), target environment (dev, staging, production), and approval gates. Run attributes: run number, trigger source, branch/tag, commit SHA, run status (queued, running, passed, failed, cancelled), start/end timestamps, duration, stages passed/failed, test coverage delta, artifact version produced, container image tag, and triggering actor. Note: combines master definition and execution history in a single product due to domain sizing constraints; separation into pipeline_definition and pipeline_run recommended if cap is raised. Provides the operational catalog of all DevOps delivery pipelines and their complete execution history for release velocity tracking, build health monitoring, and deployment readiness assessment.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` (
    `cloud_resource_id` BIGINT COMMENT 'Unique identifier for the cloud compute resource. Primary key for cloud asset inventory tracking.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Reserved instances and long-term infrastructure investments tie to capex projects for capitalization. Critical for tracking infrastructure capitalization and amortization schedules.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cloud resources are the primary infrastructure cost driver and must be allocated to cost centers. Critical for cloud cost management, chargeback, and title/studio P&L reporting.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: cloud_resource is provisioned in a network_region. Many cloud resources in one region (N:1). cloud_resource.region (STRING) matches network_region.region_code. Adding network_region_id FK and removing',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cloud resource governance in gaming requires individual employee accountability for provisioning approval, cost chargeback, lifecycle management, and compliance audits. FinOps and infrastructure teams',
    `server_fleet_id` BIGINT COMMENT 'Identifier of the game server fleet or service cluster this resource belongs to. Links cloud resources to specific game titles or multiplayer services for capacity planning and cost allocation.',
    `auto_scaling_enabled` BOOLEAN COMMENT 'Indicates whether auto-scaling is enabled for this resource to handle dynamic CCU/PCU load. Critical for GaaS live service elasticity and cost optimization.',
    `availability_zone` STRING COMMENT 'Specific availability zone within the region for high-availability and fault-tolerance architecture. Supports multi-AZ deployment strategies for live service uptime SLAs.',
    `backup_enabled` BOOLEAN COMMENT 'Indicates whether automated backups are configured for this resource. Supports disaster recovery planning and data protection compliance.',
    `cloud_provider` STRING COMMENT 'Cloud service provider hosting the resource. Supports multi-cloud infrastructure strategy and vendor cost analysis.. Valid values are `AWS|Azure|GCP|Alibaba Cloud|Oracle Cloud|IBM Cloud`',
    `compliance_scope` STRING COMMENT 'Comma-separated list of compliance frameworks this resource must adhere to (e.g., GDPR, PCI DSS, SOC 2, ISO 27001, COPPA). Drives security controls and audit requirements. [ENUM-REF-CANDIDATE: GDPR|PCI DSS|SOC 2|ISO 27001|COPPA|CCPA|HIPAA|FedRAMP — promote to reference product]',
    `cost_center` STRING COMMENT 'Financial cost center code for chargeback and budget allocation. Links cloud spend to organizational units (studios, game titles, departments).',
    `cpu_cores` STRING COMMENT 'Number of virtual CPU cores allocated to the resource. Key metric for compute capacity planning and CCU/PCU scaling analysis.',
    `cumulative_spend` DECIMAL(18,2) COMMENT 'Total accumulated cost for this resource since provisioning. Supports lifetime cost analysis and ROI calculations for infrastructure investments.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts. Supports multi-currency financial reporting for global operations.. Valid values are `^[A-Z]{3}$`',
    `environment` STRING COMMENT 'Deployment environment classification. Supports environment-based cost tracking and CI/CD pipeline resource segregation.. Valid values are `Production|Staging|Development|QA|UAT|Disaster Recovery`',
    `gpu_count` STRING COMMENT 'Number of GPU units allocated for game streaming, rendering, or AI/ML workloads. Nullable for non-GPU instances.',
    `gpu_model` STRING COMMENT 'GPU hardware model (e.g., NVIDIA T4, V100, A100). Relevant for game streaming services and AI-powered game features. Nullable for non-GPU instances.',
    `instance_family` STRING COMMENT 'Cloud provider instance family classification (e.g., AWS t3, m5, c5, r5, g4; Azure D-series, F-series; GCP n1, n2, c2). Indicates compute, memory, or GPU optimization profile.',
    `instance_size` STRING COMMENT 'Specific size or tier within the instance family (e.g., large, xlarge, 2xlarge). Determines compute capacity and cost rate.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent configuration change or state update. Tracks resource change history for audit and incident investigation.',
    `lifecycle_state` STRING COMMENT 'Business lifecycle state indicating whether the resource is actively used, reserved for future use, or scheduled for decommissioning. Supports asset retirement planning and cost optimization.. Valid values are `Active|Decommissioned|Reserved|Scheduled for Termination`',
    `memory_gb` DECIMAL(18,2) COMMENT 'Amount of RAM allocated to the resource in gigabytes. Critical for game server performance tuning and memory-intensive workload planning.',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates whether performance and health monitoring is active for this resource. Supports proactive incident management and SLA compliance tracking.',
    `monthly_cost_rate` DECIMAL(18,2) COMMENT 'Projected monthly cost for this resource based on provisioning tier and instance size. Used for budget forecasting and FinOps cost governance.',
    `network_bandwidth_gbps` DECIMAL(18,2) COMMENT 'Network throughput capacity in gigabits per second. Critical for CDN performance, multiplayer latency optimization, and live streaming quality.',
    `notes` STRING COMMENT 'Free-text notes for operational context, special configurations, or incident history. Supports knowledge transfer and troubleshooting.',
    `operating_system` STRING COMMENT 'Operating system running on the resource (e.g., Windows Server, Ubuntu, Amazon Linux). Impacts licensing costs and compatibility with game server builds.',
    `project_code` STRING COMMENT 'Project or game title code for cost allocation and ROI tracking. Enables project-level infrastructure cost analysis.',
    `provisioned_timestamp` TIMESTAMP COMMENT 'Date and time when the resource was initially provisioned. Supports resource age analysis and lifecycle tracking.',
    `provisioning_status` STRING COMMENT 'Current operational state of the cloud resource in its provisioning lifecycle. Tracks resource availability for capacity planning and incident management.. Valid values are `Provisioning|Running|Stopped|Terminated|Failed|Pending`',
    `provisioning_tier` STRING COMMENT 'Pricing and commitment model for the resource (on-demand, reserved instance, spot/preemptible for cost optimization). Critical for FinOps cost governance and budget forecasting.. Valid values are `On-Demand|Reserved|Spot|Preemptible|Savings Plan`',
    `reserved_until_date` DATE COMMENT 'Expiration date of reserved instance commitment. Nullable for on-demand and spot instances. Supports reservation renewal planning and cost optimization.',
    `resource_identifier` STRING COMMENT 'Cloud provider-assigned unique identifier for the resource (e.g., AWS instance ID, Azure resource ID, GCP resource name). Used for cross-platform reconciliation and API operations.',
    `resource_name` STRING COMMENT 'Human-readable name assigned to the cloud resource for identification and operational management.',
    `resource_type` STRING COMMENT 'Category of cloud resource provisioned (virtual machine, container cluster, managed database, load balancer, GPU instance for game streaming, etc.). Enables resource type-based capacity planning and cost allocation. [ENUM-REF-CANDIDATE: VM|Container Cluster|Managed Database|Load Balancer|GPU Instance|Storage|CDN|Network|Serverless — 9 candidates stripped; promote to reference product]',
    `service_name` STRING COMMENT 'Name of the live service, game title, or platform component this resource supports (e.g., matchmaking service, game server, CDN edge, analytics pipeline). Enables service-level cost attribution.',
    `storage_gb` DECIMAL(18,2) COMMENT 'Allocated storage capacity in gigabytes. Tracks disk space for game assets, player data, logs, and backups.',
    `tags_json` STRING COMMENT 'JSON-encoded key-value pairs of cloud provider tags applied to the resource for cost allocation, automation, and governance (e.g., {"game_title":"title_a","environment":"prod","team":"backend"}). Supports flexible tagging strategies and custom metadata.',
    `termination_timestamp` TIMESTAMP COMMENT 'Date and time when the resource was terminated or decommissioned. Nullable for active resources. Supports cost analysis and resource churn tracking.',
    `uptime_sla_percent` DECIMAL(18,2) COMMENT 'Target uptime service level agreement percentage for this resource (e.g., 99.9, 99.99). Critical for live service reliability commitments and player experience quality.',
    CONSTRAINT pk_cloud_resource PRIMARY KEY(`cloud_resource_id`)
) COMMENT 'Master record for cloud compute resources provisioned for live service infrastructure including virtual machines, container clusters (EKS/AKS/GKE), managed databases, load balancers, and GPU instances for game streaming. Captures resource identifier, cloud provider (AWS, Azure, GCP), resource type, instance family/size, provisioning tier (on-demand, reserved, spot/preemptible), region, associated fleet or service, monthly cost rate, cumulative spend, provisioning status, lifecycle state, and tags for cost allocation. SSOT for cloud asset inventory supporting FinOps cost governance, capacity planning, and multi-cloud infrastructure management.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` (
    `matchmaking_ticket_id` BIGINT COMMENT 'Unique identifier for the matchmaking ticket. Primary key for this transactional record representing a single players matchmaking request.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which matchmaking is requested. Identifies the specific game product (e.g., FPS, MMO, battle royale) that the player wants to join.',
    `matchmaking_pool_id` BIGINT COMMENT 'Reference to the matchmaking pool or queue that this ticket was submitted to. Pools segment players by game mode, skill bracket, region, or other criteria.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: matchmaking_ticket has a preferred_region. Many tickets for one region (N:1). matchmaking_ticket.preferred_region (STRING) matches network_region.region_code. Adding network_region_id FK and removing ',
    `player_account_id` BIGINT COMMENT 'Reference to the player account that submitted this matchmaking request. Links to the player domain for player identity and profile information.',
    `server_session_id` BIGINT COMMENT 'Reference to the game server session that this ticket was matched to. Null if the ticket has not yet been matched, expired, or was cancelled.',
    `acceptable_latency_ms` STRING COMMENT 'Maximum acceptable network latency (in milliseconds) that the player is willing to tolerate for this match. Matchmaking will only assign servers within this latency threshold. Typical values: 50-150ms.',
    `backfill_eligible_flag` BOOLEAN COMMENT 'Indicates whether this ticket is eligible to backfill an in-progress match (True) or should only be matched to new sessions (False). Backfill reduces wait time but may place players into ongoing games.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason why the ticket was cancelled (e.g., player_initiated, connection_lost, client_crash, system_maintenance, duplicate_ticket). Null if ticket was not cancelled. Used for operational diagnostics and player support.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The exact date and time when the player or system cancelled the matchmaking request. Null if ticket was matched or expired. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `client_version` STRING COMMENT 'Version number of the game client software that submitted this matchmaking request (e.g., 1.2.3, 2024.03.15). Ensures version compatibility for matchmaking and prevents mismatched client versions in the same session.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this matchmaking ticket record was first created in the system. Used for audit trail and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crossplay_enabled_flag` BOOLEAN COMMENT 'Indicates whether the player has opted into cross-platform play (True) or prefers platform-exclusive matchmaking (False). Affects matchmaking pool segmentation and server assignment.',
    `estimated_wait_time_seconds` STRING COMMENT 'System-calculated estimated wait time (in seconds) provided to the player at ticket submission. Based on current queue depth, historical match times, and available server capacity. Used for player expectation management.',
    `expired_timestamp` TIMESTAMP COMMENT 'The exact date and time when the ticket expired due to exceeding maximum wait time threshold. Null if ticket was matched or cancelled before expiration. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `failure_reason` STRING COMMENT 'Free-text or coded reason why matchmaking failed for this ticket (e.g., no_available_servers, insufficient_players, skill_mismatch, region_unavailable, system_error). Null if ticket did not fail. Critical for incident management and capacity planning.',
    `game_mode` STRING COMMENT 'The specific game mode requested by the player (e.g., ranked, casual, deathmatch, capture-the-flag, battle royale, PvP, PvE, co-op). Determines matchmaking rules and player pool segmentation.',
    `input_method` STRING COMMENT 'The primary input method used by the player (keyboard_mouse, gamepad, touch, motion). Some games segregate matchmaking pools by input method to ensure competitive fairness (e.g., FPS games).. Valid values are `keyboard_mouse|gamepad|touch|motion`',
    `match_quality_score` DECIMAL(18,2) COMMENT 'Algorithmic score (0-100) representing the quality of the match assignment based on skill balance, latency, party composition, and other factors. Higher scores indicate better matches. Null if ticket was not matched. Used for matchmaking algorithm tuning.',
    `matched_timestamp` TIMESTAMP COMMENT 'The exact date and time when the ticket was successfully matched to a server session. Null if not yet matched, expired, or cancelled. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `matchmaking_algorithm_version` STRING COMMENT 'Version identifier of the matchmaking algorithm or ruleset that processed this ticket (e.g., v2.1, skill_based_v3). Used for A/B testing, algorithm performance analysis, and rollback capability.',
    `matchmaking_priority` STRING COMMENT 'Priority tier for this matchmaking request. Standard: normal queue; Premium: subscriber/paid priority; VIP: high-value player fast-track; Developer: internal testing priority. Affects queue position and wait time.. Valid values are `standard|premium|vip|developer`',
    `party_leader_flag` BOOLEAN COMMENT 'Indicates whether the player who submitted this ticket is the party leader (True) or a party member (False). Only the party leaders ticket represents the entire partys matchmaking request.',
    `party_size` STRING COMMENT 'Number of players in the party or group that submitted this matchmaking request together. 1 indicates solo queue; values >1 indicate group/party matchmaking. Affects matchmaking pool and balancing logic.',
    `platform` STRING COMMENT 'The gaming platform from which the matchmaking request was submitted (e.g., PC, PlayStation, Xbox, Switch, Mobile). Used for cross-platform matchmaking rules and platform-specific server allocation. [ENUM-REF-CANDIDATE: PC|PlayStation|Xbox|Switch|Mobile|Stadia|Luna — 7 candidates stripped; promote to reference product]',
    `queue_position` STRING COMMENT 'The players position in the matchmaking queue at the time of ticket submission or last update. Lower numbers indicate higher priority. Null if position tracking is not enabled or ticket is no longer queued.',
    `retry_count` STRING COMMENT 'Number of times this ticket has been resubmitted or retried due to matchmaking failures, timeouts, or player rejections. High retry counts indicate matchmaking quality issues or player behavior problems.',
    `skill_range_max` DECIMAL(18,2) COMMENT 'Maximum skill rating threshold for acceptable match opponents. Matchmaking will expand this range over time if no suitable match is found. Used to balance match quality vs. wait time.',
    `skill_range_min` DECIMAL(18,2) COMMENT 'Minimum skill rating threshold for acceptable match opponents. Matchmaking will expand this range over time if no suitable match is found. Used to balance match quality vs. wait time.',
    `skill_rating` DECIMAL(18,2) COMMENT 'The players skill rating (MMR, ELO, or similar ranking metric) at the time of ticket submission. Used by matchmaking algorithm to find balanced matches. Captured as snapshot to ensure consistent matching even if player rating changes during queue.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The exact date and time when the player submitted the matchmaking request. Used to calculate wait time and queue performance metrics. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ticket_number` STRING COMMENT 'Human-readable business identifier for the matchmaking ticket. Used for player support, debugging, and operational tracking. Format: MMT-<alphanumeric>.. Valid values are `^MMT-[A-Z0-9]{8,16}$`',
    `ticket_status` STRING COMMENT 'Current lifecycle status of the matchmaking ticket. Queued: waiting for match; Matched: successfully assigned to server session; Expired: exceeded max wait time; Cancelled: player or system cancelled; Failed: matchmaking error; Timeout: system timeout.. Valid values are `queued|matched|expired|cancelled|failed|timeout`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this matchmaking ticket record was last modified (e.g., status change, match assignment). Used for audit trail and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `voice_chat_enabled_flag` BOOLEAN COMMENT 'Indicates whether the player has voice chat enabled (True) or disabled (False) for this matchmaking session. May influence team composition in team-based games.',
    `wait_duration_seconds` STRING COMMENT 'Total time (in seconds) that the player waited in the matchmaking queue from submission to match, expiration, or cancellation. Key metric for matchmaking quality and player experience (FTUE). Null if ticket is still queued.',
    CONSTRAINT pk_matchmaking_ticket PRIMARY KEY(`matchmaking_ticket_id`)
) COMMENT 'Transactional record for individual player matchmaking requests submitted to a matchmaking pool. Captures ticket identifier, requesting player reference, game title and mode, matchmaking pool reference, submitted timestamp, skill rating at submission, preferred region, acceptable latency threshold, ticket status (queued, matched, expired, cancelled), wait duration (seconds), and the resulting server session reference upon successful match. Enables matchmaking quality monitoring and queue health analysis.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` (
    `maintenance_window_id` BIGINT COMMENT 'Unique identifier for the planned maintenance window record. Primary key.',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: maintenance_window can affect a cdn_node. Many maintenance windows for one CDN node (N:1). maintenance_window.affected_component_reference (STRING) can reference a CDN node. Adding cdn_node_id FK to l',
    `change_request_id` BIGINT COMMENT 'Reference to the formal change request or ticket in the change management system (e.g., Jira change ticket) that authorized this maintenance.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Maintenance windows that exceed SLA commitments or violate player notification requirements (GDPR transparency, consumer protection laws) become compliance incidents. Standard escalation path in gamin',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: maintenance_window can affect a specific game_server. Many maintenance windows for one server (N:1). maintenance_window.affected_component_reference (STRING) can reference a server. Adding game_server',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: maintenance_window affects a network_region. Many maintenance windows for one region (N:1). maintenance_window.affected_region_codes (STRING) contains region codes. Adding network_region_id FK and rem',
    `employee_id` BIGINT COMMENT 'Identifier of the DevOps or infrastructure engineer who approved and authorized the maintenance window.',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: maintenance_window can affect a server_fleet. Many maintenance windows for one fleet (N:1). maintenance_window.affected_component_reference (STRING) can reference a fleet. Adding server_fleet_id FK to',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to infrastructure.sla_policy. Business justification: maintenance_window has sla_exclusion_flag (BOOLEAN) but no reference to which SLA policy governs the exclusion rules. Adding sla_policy_id FK allows maintenance windows to reference the authoritative ',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Planned maintenance windows must avoid active tournament schedules to prevent player-facing disruptions. Operations teams coordinate maintenance timing with tournament calendars, require tournament or',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance execution completed. Used to calculate actual downtime duration and SLA impact. Null if not yet completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance execution began. May differ from scheduled start due to operational delays or early starts. Null if not yet started.',
    `affected_component_reference` STRING COMMENT 'Identifier or name of the specific infrastructure component(s) being maintained (e.g., server pool ID, CDN region code, database cluster name). May reference multiple components as comma-separated list.',
    `affected_component_type` STRING COMMENT 'Type of infrastructure component being maintained: game_server (live game instances), matchmaking_service (player pairing systems), cdn_node (content delivery network edge), database_cluster (data persistence layer), api_gateway (API routing layer), authentication_service (player login systems).. Valid values are `game_server|matchmaking_service|cdn_node|database_cluster|api_gateway|authentication_service`',
    `affected_game_title_ids` STRING COMMENT 'Comma-separated list of game title identifiers impacted by this maintenance window. Used to target player notifications to affected game communities.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance window was formally approved by the responsible engineer or change advisory board.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance window record was first created in the system.',
    `downtime_duration_minutes` STRING COMMENT 'Actual duration of service downtime in minutes, calculated from actual start and end timestamps. Used for SLA reporting and capacity planning.',
    `estimated_ccu_impact` STRING COMMENT 'Estimated number of concurrent users (CCU) who will be affected during the maintenance window. Used for capacity planning and player communication prioritization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance window record was last updated. Used for audit trail and change tracking.',
    `maintenance_description` STRING COMMENT 'Detailed technical description of the maintenance activities being performed, including specific patches, upgrades, or configuration changes.',
    `maintenance_type` STRING COMMENT 'Category of maintenance activity being performed: patch (routine fixes), upgrade (version updates), migration (infrastructure moves), emergency (unplanned critical fixes), capacity_expansion (scaling operations), security_fix (vulnerability remediation).. Valid values are `patch|upgrade|migration|emergency|capacity_expansion|security_fix`',
    `maintenance_window_status` STRING COMMENT 'Current lifecycle state of the maintenance window: scheduled (approved and planned), in_progress (actively executing), completed (successfully finished), cancelled (aborted before start), failed (execution encountered errors), rolled_back (changes reverted).. Valid values are `scheduled|in_progress|completed|cancelled|failed|rolled_back`',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when player notification about the maintenance window was sent. Null if notification not yet sent.',
    `notification_status` STRING COMMENT 'Status of player-facing communication about the maintenance window: not_sent (no notification issued), scheduled (notification queued), sent (notification delivered), acknowledged (players confirmed awareness).. Valid values are `not_sent|scheduled|sent|acknowledged`',
    `player_facing_message` STRING COMMENT 'Non-technical message communicated to players about the maintenance window, explaining impact and expected duration in player-friendly language.',
    `player_impact_level` STRING COMMENT 'Severity of player-facing service degradation during the maintenance window: none (no player impact), low (minor latency), medium (feature unavailable), high (game unplayable), critical (complete service outage).. Valid values are `none|low|medium|high|critical`',
    `post_maintenance_validation_status` STRING COMMENT 'Status of post-maintenance testing and validation: not_started (validation pending), in_progress (tests running), passed (all checks successful), failed (issues detected), skipped (validation not performed).. Valid values are `not_started|in_progress|passed|failed|skipped`',
    `rollback_plan_available` BOOLEAN COMMENT 'Indicates whether a tested rollback plan exists (True) to revert changes if maintenance fails. Required for high-impact maintenance windows.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when the maintenance window is scheduled to conclude. Used for SLA exclusion calculations and player communication.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the maintenance window is scheduled to begin. Used for player notifications and capacity planning.',
    `sla_exclusion_flag` BOOLEAN COMMENT 'Indicates whether this maintenance window should be excluded from uptime SLA calculations (True) or counted as downtime (False). Planned maintenance is typically excluded.',
    `window_code` STRING COMMENT 'Externally-known unique code for the maintenance window, used in player communications and SLA tracking (e.g., MW-20240315001).. Valid values are `^MW-[0-9]{6,10}$`',
    `window_name` STRING COMMENT 'Human-readable name or title for the maintenance window (e.g., Q1 2024 Platform Upgrade, Emergency CDN Patch).',
    CONSTRAINT pk_maintenance_window PRIMARY KEY(`maintenance_window_id`)
) COMMENT 'Master record for planned maintenance windows during which live service infrastructure components are taken offline or degraded for patching, upgrades, or capacity changes. Captures window name, affected component type and references, scheduled start and end timestamps, actual start and end timestamps, maintenance type (patch, upgrade, migration, emergency), player-facing impact level, notification status, and approving engineer. Enables proactive player communication and SLA exclusion tracking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`security_event` (
    `security_event_id` BIGINT COMMENT 'Unique identifier for the infrastructure security event record. Primary key.',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: security_event can target a cdn_node. Many security events for one CDN node (N:1). security_event.target_service_component (STRING) can reference a CDN node. Adding cdn_node_id FK to link security eve',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Security events (DDoS, unauthorized access, data exfiltration) that affect player data or violate regulations become compliance incidents. Gaming companies track the compliance dimension of security e',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Security incident response and mitigation costs are tracked by cost center for financial reporting. Essential for security cost accounting and budget variance analysis.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.defect. Business justification: Security vulnerabilities are tracked as defects in JIRA. Security incident response includes defect creation for vulnerability remediation tracking, compliance reporting (GDPR, PCI-DSS), and certifica',
    `employee_id` BIGINT COMMENT 'Reference to the security engineer or DevOps engineer assigned to investigate and respond to this security event.',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: security_event can target a specific game_server. Many security events for one server (N:1). security_event.target_service_component (STRING) can reference a server. Adding game_server_id FK to link s',
    `game_title_id` BIGINT COMMENT 'Reference to the game title affected by this security event.',
    `infrastructure_incident_id` BIGINT COMMENT 'Reference to the escalated infrastructure incident if this security event triggered formal incident management response.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: security_event affects a network_region. Many security events in one region (N:1). security_event.affected_region_code (STRING) matches network_region.region_code. Adding network_region_id FK and remo',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: security_event can target a server_fleet. Many security events for one fleet (N:1). security_event.target_service_component (STRING) can reference a fleet. Adding server_fleet_id FK to link security e',
    `telemetry_pipeline_id` BIGINT COMMENT 'Foreign key linking to analytics.telemetry_pipeline. Business justification: Security events (DDoS attacks, exploit attempts) are ingested through dedicated telemetry pipelines for real-time threat detection and compliance reporting. Security teams track pipeline health for in',
    `title_pl_id` BIGINT COMMENT 'Foreign key linking to finance.title_pl. Business justification: Security events impact title P&L through mitigation costs and potential revenue loss. Essential for security incident financial impact assessment and P&L variance explanations.',
    `correlated_security_event_id` BIGINT COMMENT 'Self-referencing FK on security_event (correlated_security_event_id)',
    `attack_vector` STRING COMMENT 'Technical description of the method or pathway used to execute the security threat (e.g., volumetric flood, application layer exploit, authentication bypass).',
    `automated_response_enabled` BOOLEAN COMMENT 'Indicates whether automated mitigation actions were enabled and executed without manual intervention.',
    `ccu_affected` BIGINT COMMENT 'Estimated number of concurrent users impacted by the security event through service degradation or unavailability.',
    `communication_sent_flag` BOOLEAN COMMENT 'Indicates whether player-facing or stakeholder communication was sent regarding the security event and its impact.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this security event record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `detection_source` STRING COMMENT 'Origin of the security event detection indicating whether it was identified by automated monitoring, manual observation, external security service, or player report.. Valid values are `automated|manual|third_party|player_report`',
    `detection_system` STRING COMMENT 'Name or identifier of the monitoring system, tool, or service that detected the security event (e.g., CloudFlare, AWS Shield, internal SIEM, WAF).',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the security event was first detected by automated monitoring or manual observation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `escalated_flag` BOOLEAN COMMENT 'Indicates whether the security event was escalated to formal infrastructure incident management due to severity or impact.',
    `estimated_revenue_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact in US dollars due to service downtime, player churn, or lost monetization opportunities caused by the security event.',
    `event_number` STRING COMMENT 'Human-readable unique identifier for the security event, used for tracking and communication. Format: SE-YYYYMMDD-XXXXXX.. Valid values are `^SE-[0-9]{8}-[A-Z0-9]{6}$`',
    `event_status` STRING COMMENT 'Current lifecycle state of the security event in the response workflow.. Valid values are `detected|analyzing|mitigating|mitigated|resolved|closed`',
    `event_type` STRING COMMENT 'Classification of the security threat or attack vector detected. [ENUM-REF-CANDIDATE: ddos_attack|brute_force|credential_stuffing|waf_trigger|rate_limit_breach|bot_detection|exploit_attempt|sql_injection|xss_attack|unauthorized_access|data_exfiltration|malware_detection — promote to reference product]. Valid values are `ddos_attack|brute_force|credential_stuffing|waf_trigger|rate_limit_breach|bot_detection`',
    `false_positive_flag` BOOLEAN COMMENT 'Indicates whether the security event was later determined to be a false positive after investigation.',
    `latency_spike_ms` DECIMAL(18,2) COMMENT 'Maximum increase in network latency in milliseconds observed during the security event, indicating player experience degradation.',
    `mitigation_action` STRING COMMENT 'Primary defensive action taken to mitigate the security threat.. Valid values are `blackhole|rate_limit|cdn_shield|geo_block|waf_rule|ip_block`',
    `mitigation_description` STRING COMMENT 'Detailed narrative of the mitigation steps taken, including configuration changes, rules applied, and response actions executed.',
    `mitigation_end_timestamp` TIMESTAMP COMMENT 'Date and time when mitigation actions were completed and the threat was neutralized. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mitigation_start_timestamp` TIMESTAMP COMMENT 'Date and time when mitigation actions were initiated to counter the security threat. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this security event record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-form text field for additional context, observations, or operational notes related to the security event.',
    `peak_attack_volume_gbps` DECIMAL(18,2) COMMENT 'Maximum network traffic volume in gigabits per second observed during the attack, applicable to volumetric DDoS events.',
    `peak_attack_volume_mpps` DECIMAL(18,2) COMMENT 'Maximum packet rate in millions of packets per second observed during the attack, applicable to protocol-based DDoS events.',
    `player_impact_assessment` STRING COMMENT 'Qualitative assessment of the impact on player experience and game service availability.. Valid values are `none|minimal|moderate|significant|severe`',
    `post_mortem_reference` STRING COMMENT 'Reference identifier or URL to the detailed post-mortem analysis document or report for this security event.',
    `remediation_action_items` STRING COMMENT 'List of follow-up actions, patches, or configuration changes required to prevent recurrence of similar security events.',
    `request_count` BIGINT COMMENT 'Total number of malicious or suspicious requests detected during the security event (e.g., login attempts, API calls, bot requests).',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the security event was fully resolved and services restored to normal operation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying cause or vulnerability exploited in the security event (e.g., configuration weakness, unpatched vulnerability, credential compromise).',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings and contributing factors to the security event.',
    `service_downtime_minutes` DECIMAL(18,2) COMMENT 'Total duration in minutes that affected services were unavailable or degraded due to the security event.',
    `severity_level` STRING COMMENT 'Business impact severity classification of the security event based on threat level and player impact.. Valid values are `critical|high|medium|low|informational`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the security event caused a breach of uptime, latency, or availability SLA commitments.',
    `source_country_code` STRING COMMENT 'Three-letter ISO country code of the geographic origin of the attack based on IP geolocation.. Valid values are `^[A-Z]{3}$`',
    `source_ip_address` STRING COMMENT 'Originating IP address or CIDR block from which the security threat originated. May be single IP or range.',
    `tags_metadata` STRING COMMENT 'Flexible JSON or comma-separated key-value pairs for additional categorization, labeling, or operational metadata (e.g., campaign tags, environment labels).',
    `target_service_component` STRING COMMENT 'Specific infrastructure service component or endpoint that was targeted by the security event (e.g., matchmaking API, game server cluster, CDN edge, authentication service).',
    CONSTRAINT pk_security_event PRIMARY KEY(`security_event_id`)
) COMMENT 'Transactional record for infrastructure security incidents and threat events affecting live game services. Captures event identifier, event type (DDoS attack, brute force, credential stuffing, WAF trigger, rate limit breach, bot detection, exploit attempt), source IP/CIDR, target service component, affected region, attack vector, peak attack volume (Gbps/Mpps), mitigation action taken (blackhole, rate limit, CDN shield, geo-block), mitigation start and end timestamps, player impact assessment (CCU affected, latency spike), associated incident reference if escalated, and detection source (automated/manual). SSOT for all infrastructure security threat tracking, enabling DDoS response playbooks, attack pattern analysis, and security posture reporting for GaaS live services.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` (
    `infrastructure_test_execution_id` BIGINT COMMENT 'Primary key for infrastructure_test_execution',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to the game server instance on which this test case was executed',
    `test_case_id` BIGINT COMMENT 'Foreign key linking to the test case that was executed in this test run',
    `quality_test_execution_id` BIGINT COMMENT 'Unique identifier for this test execution record. Primary key.',
    `build_version` STRING COMMENT 'The specific game build version that was under test during this execution. Explicitly identified in detection phase relationship data.',
    `executed_by` STRING COMMENT 'Name or identifier of the QA engineer or automated system that initiated this test execution.',
    `execution_duration_seconds` STRING COMMENT 'Duration in seconds that this test execution took to complete. Explicitly identified in detection phase relationship data.',
    `execution_status` STRING COMMENT 'Result status of this test execution. Explicitly identified in detection phase relationship data. Values: PASSED, FAILED, BLOCKED, SKIPPED, IN_PROGRESS.',
    `execution_timestamp` TIMESTAMP COMMENT 'Timestamp when this test case execution was initiated on the game server. Explicitly identified in detection phase relationship data.',
    `failure_reason` STRING COMMENT 'Detailed description of why the test failed, if execution_status is FAILED. Null for passed tests.',
    `jira_test_run_key` STRING COMMENT 'Reference to the Jira test run or test execution ticket that tracks this execution in the external system.',
    `test_environment` STRING COMMENT 'The environment context in which this test was executed (e.g., Dev, QA, Staging, Production-like). Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_infrastructure_test_execution PRIMARY KEY(`infrastructure_test_execution_id`)
) COMMENT 'This association product represents the execution event between game_server and test_case. It captures the operational record of running a specific test case against a specific game server instance. Each record links one game_server to one test_case with execution-specific attributes that exist only in the context of this test run.. Existence Justification: In gaming QA operations, test cases are executed against multiple game server instances (different regions, configurations, OS versions, build versions) to validate functionality across the fleet. Each game server hosts executions of multiple test cases as part of regression, performance, and certification testing. The business actively manages test execution records as operational QA artifacts.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`monitoring_alert` (
    `monitoring_alert_id` BIGINT COMMENT 'Primary key for monitoring_alert',
    `infrastructure_incident_id` BIGINT COMMENT 'The external incident management system ticket identifier (e.g., Jira, ServiceNow) created for this alert if it required formal incident tracking.',
    `alert_suppression_rule_id` BIGINT COMMENT 'The identifier of the alert suppression or maintenance window rule that muted this alert, if applicable. Used during planned maintenance or known issue periods.',
    `parent_monitoring_alert_id` BIGINT COMMENT 'Self-referencing FK on monitoring_alert (parent_monitoring_alert_id)',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'The date and time when the alert was acknowledged by an on-call engineer or automated system, indicating response has begun.',
    `affected_player_count` STRING COMMENT 'The estimated number of concurrent players or user sessions impacted by the alert condition at the time of trigger. Critical for assessing business impact and prioritization.',
    `alert_code` STRING COMMENT 'Externally-known unique code identifying the alert type and category. Format: three-letter category prefix followed by four-digit sequence number (e.g., SRV-0001, NET-0042).',
    `alert_description` STRING COMMENT 'Detailed description of the alert condition, including business impact, affected services, and recommended actions for responders.',
    `alert_message` STRING COMMENT 'The specific alert message generated at trigger time, including dynamic values and context (e.g., CPU utilization 95% on server game-srv-042 exceeds threshold 80%).',
    `alert_name` STRING COMMENT 'Human-readable name of the monitoring alert, describing the condition being monitored.',
    `alert_type` STRING COMMENT 'Classification of the alert based on the monitoring condition: threshold (metric exceeds limit), anomaly (unusual pattern detected), availability (service up/down), performance (latency/throughput degradation), security (threat detected), capacity (resource exhaustion).',
    `assigned_engineer` STRING COMMENT 'The name or identifier of the specific engineer or responder currently assigned to investigate and resolve the alert.',
    `assigned_team` STRING COMMENT 'The name of the engineering or operations team assigned to respond to the alert (e.g., game-server-ops, network-engineering, platform-reliability, security-response).',
    `auto_resolved_flag` BOOLEAN COMMENT 'Boolean indicator of whether the alert was automatically resolved by the monitoring system (true) or required manual intervention (false). Used to measure self-healing infrastructure effectiveness.',
    `availability_zone` STRING COMMENT 'The cloud provider availability zone or data center identifier where the resource is deployed. Used for fault domain analysis and capacity planning.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when the alert incident was formally closed after verification and post-incident review.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this monitoring alert record was first created in the data platform. Audit trail for data lineage.',
    `environment` STRING COMMENT 'The deployment environment where the monitored resource is running: production (live player-facing), staging (pre-production testing), development (active development), qa (quality assurance), disaster_recovery (failover standby).',
    `escalation_level` STRING COMMENT 'The current escalation tier for the alert (0 = initial on-call team, 1 = senior engineer, 2 = engineering manager, 3 = director/VP, 4 = executive). Increments based on time-to-acknowledge and severity.',
    `evaluation_window_seconds` STRING COMMENT 'The time window in seconds over which the metric is evaluated before triggering the alert. Prevents false positives from transient spikes.',
    `game_title` STRING COMMENT 'The specific game title or franchise affected by the alert. Critical for prioritizing alerts based on player base and revenue impact.',
    `metric_name` STRING COMMENT 'The name of the performance or health metric being monitored (e.g., cpu_utilization_percent, network_latency_ms, active_player_count, server_response_time_ms).',
    `metric_unit` STRING COMMENT 'The unit of measurement for the metric value (e.g., percent, milliseconds, requests_per_second, concurrent_users, gigabytes).',
    `metric_value` DECIMAL(18,2) COMMENT 'The observed value of the monitored metric at the time the alert was triggered. This is the principal quantitative fact that caused the alert condition.',
    `notification_channels` STRING COMMENT 'Comma-separated list of notification channels used to alert responders (e.g., pagerduty, slack, email, sms, webhook). Tracks how the alert was communicated.',
    `platform` STRING COMMENT 'The gaming platform affected by the alert: pc (Windows/Mac/Linux), console (PlayStation/Xbox/Nintendo), mobile (iOS/Android), cross_platform (multi-platform service).',
    `priority` STRING COMMENT 'Operational priority for alert response: P1 (immediate response required), P2 (urgent), P3 (normal), P4 (low), P5 (planning). Derived from severity and business impact.',
    `region` STRING COMMENT 'Three-letter geographic region code where the monitored resource is deployed (e.g., USE for US East, EUW for EU West, APS for Asia Pacific South). Critical for regional SLA tracking and player experience monitoring.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the investigation process, root cause findings, remediation actions taken, and any follow-up tasks. Populated after alert resolution for knowledge management.',
    `resolved_timestamp` TIMESTAMP COMMENT 'The date and time when the underlying condition was resolved and the alert was cleared.',
    `resource_identifier` STRING COMMENT 'The unique identifier of the specific resource instance being monitored (e.g., server hostname, instance ID, service endpoint, IP address).',
    `resource_type` STRING COMMENT 'The type of infrastructure resource being monitored: game_server (dedicated or cloud game server instance), matchmaking_service (player matchmaking backend), cdn_node (content delivery network edge node), database (persistent data store), load_balancer (traffic distribution), network_device (router/switch), storage_volume (disk/SAN).',
    `root_cause_category` STRING COMMENT 'The high-level category of the identified root cause after investigation (e.g., hardware_failure, software_bug, capacity_limit, network_issue, configuration_error, third_party_dependency, ddos_attack). Populated after resolution for trend analysis. [ENUM-REF-CANDIDATE: hardware_failure|software_bug|capacity_limit|network_issue|configuration_error|third_party_dependency|ddos_attack|player_surge|deployment_issue|database_contention — promote to reference product]',
    `service_name` STRING COMMENT 'The name of the game service or application component affected by the alert (e.g., player-authentication, game-session-manager, leaderboard-api, voice-chat-service).',
    `severity` STRING COMMENT 'Business impact severity of the alert: critical (service outage, immediate action required), high (major degradation), medium (minor impact), low (potential issue), informational (FYI only).',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether this alert represents a breach of defined service level agreement thresholds (e.g., uptime SLA, latency SLA, availability SLA). True indicates SLA breach.',
    `source_system` STRING COMMENT 'The monitoring or observability system that generated the alert (e.g., Prometheus, Datadog, New Relic, CloudWatch, Grafana).',
    `monitoring_alert_status` STRING COMMENT 'Current lifecycle state of the alert: active (triggered, awaiting acknowledgment), acknowledged (team notified), investigating (root cause analysis in progress), resolved (condition cleared), closed (incident closed), suppressed (muted by rule).',
    `threshold_operator` STRING COMMENT 'The comparison operator used to evaluate the metric against the threshold (e.g., greater_than for high-water marks, less_than for low-water marks).',
    `threshold_value` DECIMAL(18,2) COMMENT 'The configured threshold value that, when exceeded or breached, triggers the alert. Used for threshold-type alerts.',
    `triggered_timestamp` TIMESTAMP COMMENT 'The exact date and time when the monitoring condition was first detected and the alert was triggered. This is the principal business event timestamp for the alert lifecycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this monitoring alert record was last modified. Tracks changes to alert status, assignments, and resolution details.',
    CONSTRAINT pk_monitoring_alert PRIMARY KEY(`monitoring_alert_id`)
) COMMENT 'Master reference table for monitoring_alert. Referenced by monitoring_alert_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`change_request` (
    `change_request_id` BIGINT COMMENT 'Primary key for change_request',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or authority who approved the change request for implementation.',
    `assigned_to_user_employee_id` BIGINT COMMENT 'Identifier of the user or team member responsible for implementing the change request.',
    `configuration_item_id` BIGINT COMMENT 'Identifier of the primary configuration item or infrastructure component being modified by this change.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or team member who initiated the change request.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the technical team responsible for executing the change request.',
    `infrastructure_incident_id` BIGINT COMMENT 'Identifier of the incident that triggered this change request, if the change is remedial in nature.',
    `problem_id` BIGINT COMMENT 'Identifier of the problem record that this change request addresses as a permanent fix.',
    `rollback_change_request_id` BIGINT COMMENT 'Self-referencing FK on change_request (rollback_change_request_id)',
    `actual_downtime_minutes` STRING COMMENT 'Actual duration of service downtime or degradation that occurred during change implementation, measured in minutes.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when change implementation was completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when change implementation began.',
    `affected_regions` STRING COMMENT 'Geographic regions or data center locations where the change will be deployed, relevant for global game infrastructure.',
    `affected_services` STRING COMMENT 'List of game services, platforms, or infrastructure components that will be impacted by the change implementation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the change request received formal approval for implementation.',
    `cab_approval_required` BOOLEAN COMMENT 'Indicates whether the change requires formal review and approval by the Change Advisory Board based on risk and impact.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the change request was cancelled before implementation.',
    `change_category` STRING COMMENT 'Functional area or domain affected by the change request, used for routing to appropriate technical teams and impact analysis.',
    `change_type` STRING COMMENT 'Classification of the change request based on urgency, risk, and approval requirements. Standard changes are pre-approved low-risk changes; normal changes require CAB approval; emergency changes address critical incidents; expedited changes are fast-tracked for business-critical needs.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the change request was formally closed and marked as completed, including post-implementation review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this change request record was first created in the system.',
    `change_request_description` STRING COMMENT 'Detailed description of the change request including technical details, business justification, and expected outcomes.',
    `estimated_downtime_minutes` STRING COMMENT 'Expected duration of service downtime or degradation during change implementation, measured in minutes.',
    `impact_assessment` STRING COMMENT 'Analysis of potential impact on game services, infrastructure components, player experience, and business operations if the change is implemented.',
    `implementation_notes` STRING COMMENT 'Technical notes and observations recorded during change implementation, including any deviations from the plan.',
    `implementation_successful` BOOLEAN COMMENT 'Indicates whether the change implementation met success criteria without requiring rollback.',
    `justification` STRING COMMENT 'Business rationale and expected benefits for implementing the change, including impact on player experience, operational efficiency, or revenue.',
    `maintenance_window_required` BOOLEAN COMMENT 'Indicates whether the change requires a scheduled maintenance window with player notification and service downtime.',
    `player_notification_required` BOOLEAN COMMENT 'Indicates whether advance notification to players is required due to expected service impact or downtime.',
    `post_implementation_review` STRING COMMENT 'Assessment of change success, lessons learned, and recommendations for future similar changes.',
    `priority` STRING COMMENT 'Business priority level assigned to the change request, determining scheduling and resource allocation.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the change request, typically following a standardized format for external communication and tracking.',
    `requested_date` DATE COMMENT 'Date when the change request was initially submitted.',
    `requested_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the change request was submitted, representing the principal business event time for this transaction.',
    `risk_level` STRING COMMENT 'Assessed risk level of implementing the change, considering potential impact on service availability, player experience, and business operations.',
    `rollback_executed` BOOLEAN COMMENT 'Indicates whether the rollback plan was executed due to implementation failure or unexpected issues.',
    `rollback_plan` STRING COMMENT 'Documented procedure for reverting the change if implementation fails or causes unexpected issues, ensuring service continuity.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned timestamp for completing the change implementation.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned timestamp for beginning the change implementation.',
    `change_request_status` STRING COMMENT 'Current lifecycle state of the change request in the approval and implementation workflow.',
    `success_criteria` STRING COMMENT 'Measurable criteria that define successful completion of the change, used for post-implementation validation.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the purpose and scope of the change request.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this change request record was last modified.',
    CONSTRAINT pk_change_request PRIMARY KEY(`change_request_id`)
) COMMENT 'Master reference table for change_request. Referenced by change_request_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`matchmaking_service` (
    `matchmaking_service_id` BIGINT COMMENT 'Primary key for matchmaking_service',
    `server_fleet_id` BIGINT COMMENT 'Reference to the server pool or fleet that hosts matches created by this matchmaking service.',
    `fallback_matchmaking_service_id` BIGINT COMMENT 'Self-referencing FK on matchmaking_service (fallback_matchmaking_service_id)',
    `algorithm_type` STRING COMMENT 'The matchmaking algorithm used to pair players (skill-based matchmaking, connection-based, hybrid, Elo rating, Glicko, TrueSkill, etc.).',
    `api_endpoint_url` STRING COMMENT 'URL of the API endpoint that clients use to interact with this matchmaking service.',
    `auto_scaling_enabled` BOOLEAN COMMENT 'Indicates whether this matchmaking service has auto-scaling enabled to dynamically adjust capacity based on demand.',
    `avg_match_time_seconds` STRING COMMENT 'Average time in seconds for a typical match session facilitated by this matchmaking service.',
    `avg_queue_time_seconds` STRING COMMENT 'Average time in seconds players spend waiting in the matchmaking queue before being matched.',
    `backfill_enabled` BOOLEAN COMMENT 'Indicates whether this matchmaking service supports backfilling players into in-progress matches when slots become available.',
    `ccu_capacity` STRING COMMENT 'Maximum number of concurrent users this matchmaking service is provisioned to handle simultaneously.',
    `cdn_endpoint_url` STRING COMMENT 'URL of the CDN endpoint used to serve matchmaking service configuration and assets to clients.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this matchmaking service record was first created in the system.',
    `cross_platform_enabled` BOOLEAN COMMENT 'Indicates whether this matchmaking service allows players from different platforms (console, PC, mobile) to be matched together.',
    `deployment_environment` STRING COMMENT 'The deployment environment where this matchmaking service instance is running.',
    `deprecation_reason` STRING COMMENT 'Business justification or technical reason for deprecating this matchmaking service, if applicable.',
    `matchmaking_service_description` STRING COMMENT 'Detailed description of the matchmaking service purpose, features, and operational characteristics.',
    `effective_end_date` DATE COMMENT 'Date when this matchmaking service was or will be deactivated or deprecated. Null for currently active services.',
    `effective_start_date` DATE COMMENT 'Date when this matchmaking service became active and available to players.',
    `game_mode` STRING COMMENT 'The primary game mode supported by this matchmaking service (Player vs Player, Player vs Environment, Massively Multiplayer Online, etc.).',
    `health_check_interval_seconds` STRING COMMENT 'Frequency in seconds at which the matchmaking service health status is monitored and reported.',
    `incident_count_last_30_days` STRING COMMENT 'Number of incidents reported for this matchmaking service in the last 30 days.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether this matchmaking service has been deprecated and is scheduled for retirement.',
    `last_deployment_timestamp` TIMESTAMP COMMENT 'Timestamp when this matchmaking service version was last deployed to the environment.',
    `latency_threshold_ms` STRING COMMENT 'Maximum acceptable network latency in milliseconds for players matched through this service to ensure quality gameplay experience.',
    `max_party_size` STRING COMMENT 'Maximum number of players allowed in a single party when entering this matchmaking service queue.',
    `max_players` STRING COMMENT 'Maximum number of players allowed in a match created by this service.',
    `max_queue_time_seconds` STRING COMMENT 'Maximum allowed queue time in seconds before the matchmaking service relaxes matching criteria or times out.',
    `min_players` STRING COMMENT 'Minimum number of players required to start a match through this service.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this matchmaking service record was last modified or updated.',
    `owner_team` STRING COMMENT 'Name of the engineering or operations team responsible for maintaining and supporting this matchmaking service.',
    `party_support_enabled` BOOLEAN COMMENT 'Indicates whether this matchmaking service supports pre-formed player parties or groups entering the queue together.',
    `pcu_peak_capacity` STRING COMMENT 'Peak concurrent user capacity this matchmaking service can scale to during high-demand periods.',
    `priority_weight` DECIMAL(18,2) COMMENT 'Weighting factor used to prioritize this matchmaking service in resource allocation and queue processing (higher values = higher priority).',
    `rank_tier_max` STRING COMMENT 'Maximum player rank or tier allowed in this matchmaking service to maintain competitive balance.',
    `rank_tier_min` STRING COMMENT 'Minimum player rank or tier required to access this matchmaking service (e.g., Bronze, Silver, Gold).',
    `region` STRING COMMENT 'Three-letter ISO region code where this matchmaking service operates (e.g., USA, EUR, APC for Asia-Pacific).',
    `service_code` STRING COMMENT 'Unique business identifier code for the matchmaking service used in operational systems and APIs.',
    `service_name` STRING COMMENT 'Human-readable name of the matchmaking service (e.g., Ranked PvP Matchmaker, Casual MMO Queue, Battle Royale Lobby Service).',
    `service_type` STRING COMMENT 'Classification of the matchmaking service by gameplay mode and competitive structure.',
    `skill_range_tolerance` DECIMAL(18,2) COMMENT 'Percentage tolerance for skill rating variance allowed when matching players (e.g., 10.00 means +/- 10% skill rating).',
    `matchmaking_service_status` STRING COMMENT 'Current operational lifecycle status of the matchmaking service.',
    `uptime_sla_percentage` DECIMAL(18,2) COMMENT 'Target uptime percentage defined in the service level agreement for this matchmaking service (e.g., 99.95).',
    `version` STRING COMMENT 'Semantic version number of the matchmaking service software (e.g., 2.5.1).',
    CONSTRAINT pk_matchmaking_service PRIMARY KEY(`matchmaking_service_id`)
) COMMENT 'Master reference table for matchmaking_service. Referenced by matchmaking_service_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`problem` (
    `problem_id` BIGINT COMMENT 'Primary key for problem',
    `affected_platform` STRING COMMENT 'Gaming platform affected by the problem. Indicates whether issue is platform-specific or cross-platform.',
    `affected_region` STRING COMMENT 'Geographic region or data center location affected by the problem. Uses 3-letter region codes (e.g., USE, EUW, APS).',
    `affected_service` STRING COMMENT 'Name of the game service or infrastructure component affected by this problem. Examples: matchmaking, authentication, CDN, game servers.',
    `assigned_engineer` STRING COMMENT 'Name or identifier of the engineer currently assigned to investigate and resolve the problem.',
    `assigned_team` STRING COMMENT 'Engineering team or group responsible for investigating and resolving the problem. Examples: DevOps, Network Engineering, Platform Engineering.',
    `change_request_id` STRING COMMENT 'Identifier of the change request created to implement the permanent solution for this problem. Links problem to change management process.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the problem record was formally closed after verification. Final lifecycle timestamp for the problem.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this problem record was created in the system. Audit field for record lifecycle tracking.',
    `problem_description` STRING COMMENT 'Detailed description of the problem including symptoms, impact, and context. Provides comprehensive information for root cause analysis.',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the problem was first detected or identified. Used for timeline analysis and response time measurement.',
    `detection_method` STRING COMMENT 'Method by which the problem was detected. Used to measure effectiveness of monitoring and proactive problem management.',
    `downtime_minutes` STRING COMMENT 'Total service downtime in minutes caused by this problem. Used for SLA tracking and availability reporting.',
    `incident_count` STRING COMMENT 'Number of incidents linked to this problem. Used to measure problem impact and prioritize resolution efforts.',
    `investigation_started_timestamp` TIMESTAMP COMMENT 'Date and time when formal investigation of the problem began. Used to track time-to-investigation metrics.',
    `is_known_error` BOOLEAN COMMENT 'Flag indicating whether this problem has been classified as a known error with documented workaround. True when root cause is identified but permanent fix is pending.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this is a recurring problem that has occurred multiple times. Used to identify systemic issues requiring architectural changes.',
    `permanent_solution` STRING COMMENT 'Description of the permanent fix or solution implemented to resolve the problem. Documents the final resolution approach.',
    `player_impact_count` BIGINT COMMENT 'Estimated number of players affected by this problem. Critical metric for prioritization and business impact assessment.',
    `priority` STRING COMMENT 'Priority level for problem resolution based on severity and business impact. P1 is highest priority requiring immediate action.',
    `problem_number` STRING COMMENT 'Human-readable unique problem ticket number used for external reference and tracking. Format: PRB-YYYYMMDD.',
    `problem_type` STRING COMMENT 'Classification of the problem by technical domain. Used for routing to appropriate engineering teams and trend analysis.',
    `related_problem_id` BIGINT COMMENT 'Reference to another problem record that is related or linked to this problem. Enables tracking of problem dependencies and patterns.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the problem was resolved with a permanent solution. Used for resolution time tracking and SLA compliance.',
    `root_cause` STRING COMMENT 'Identified root cause of the problem after investigation. Documents the underlying technical or process issue causing incidents.',
    `root_cause_identified_timestamp` TIMESTAMP COMMENT 'Date and time when the root cause was successfully identified. Used to measure investigation effectiveness and time-to-diagnosis.',
    `severity` STRING COMMENT 'Severity level indicating the business impact and urgency of the problem. Critical problems affect core game services and require immediate attention.',
    `problem_status` STRING COMMENT 'Current lifecycle status of the problem record. Tracks progression from identification through resolution and closure.',
    `title` STRING COMMENT 'Short descriptive title summarizing the problem for quick identification and reporting.',
    `updated_by` STRING COMMENT 'Username or identifier of the user who last updated this problem record. Audit field for change accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this problem record was last modified. Audit field for change tracking and data freshness.',
    `workaround` STRING COMMENT 'Temporary workaround or mitigation steps to reduce impact while permanent fix is developed. Used for known error management.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this problem record. Audit field for accountability and traceability.',
    CONSTRAINT pk_problem PRIMARY KEY(`problem_id`)
) COMMENT 'Master reference table for problem. Referenced by related_problem_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`configuration_item` (
    `configuration_item_id` BIGINT COMMENT 'Primary key for configuration_item',
    `parent_configuration_item_id` BIGINT COMMENT 'Self-referencing FK on configuration_item (parent_configuration_item_id)',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration item was activated and entered operational service.',
    `auto_scaling_enabled` BOOLEAN COMMENT 'Indicates whether automatic scaling is enabled for this configuration item to dynamically adjust capacity based on demand.',
    `availability_zone` STRING COMMENT 'Specific availability zone or fault domain within the region where the configuration item is deployed.',
    `backup_enabled` BOOLEAN COMMENT 'Indicates whether automated backup is enabled for this configuration item to ensure data recovery capability.',
    `bandwidth_mbps` DECIMAL(18,2) COMMENT 'Network bandwidth capacity allocated to the configuration item, measured in megabits per second.',
    `capacity_ccu` STRING COMMENT 'Maximum number of concurrent users (CCU) that the configuration item can support simultaneously.',
    `capacity_pcu` STRING COMMENT 'Peak concurrent users (PCU) capacity threshold for the configuration item, representing maximum load handling capability.',
    `ci_category` STRING COMMENT 'High-level category grouping for the configuration item (hardware, software, network, service, virtual, cloud).',
    `ci_code` STRING COMMENT 'Externally-known unique code or identifier for the configuration item, used for cross-system reference and asset tracking.',
    `ci_name` STRING COMMENT 'Human-readable name or label for the configuration item, used for identification and display purposes.',
    `ci_status` STRING COMMENT 'Current lifecycle status of the configuration item indicating its operational state (active, inactive, maintenance, decommissioned, provisioning, failed).',
    `ci_type` STRING COMMENT 'Classification of the configuration item by its functional role in the infrastructure (e.g., game server, matchmaking service, CDN node, load balancer, database instance, cache cluster, message queue). [ENUM-REF-CANDIDATE: game_server|matchmaking_service|cdn_node|load_balancer|database_instance|cache_cluster|message_queue|api_gateway|authentication_service|storage_service|monitoring_agent|backup_service|firewall|network_switch|container_orchestrator — promote to reference product]',
    `compliance_required` BOOLEAN COMMENT 'Indicates whether this configuration item is subject to regulatory compliance requirements and auditing.',
    `cost_per_hour_usd` DECIMAL(18,2) COMMENT 'Hourly operational cost for running this configuration item, measured in US dollars.',
    `cpu_cores` STRING COMMENT 'Number of CPU cores allocated to the configuration item for compute processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration item record was first created in the system.',
    `decommissioned_date` DATE COMMENT 'Date when the configuration item was decommissioned and removed from active service.',
    `deployment_method` STRING COMMENT 'Method used to deploy the configuration item (manual, automated, CI/CD pipeline, container orchestration, serverless).',
    `configuration_item_description` STRING COMMENT 'Detailed textual description of the configuration item, its purpose, and its role in the infrastructure.',
    `environment` STRING COMMENT 'Deployment environment where the configuration item operates (production, staging, development, testing, disaster recovery, sandbox).',
    `high_availability_enabled` BOOLEAN COMMENT 'Indicates whether high availability configuration is enabled for this configuration item to ensure redundancy and failover capability.',
    `hostname` STRING COMMENT 'Network hostname or fully qualified domain name (FQDN) assigned to the configuration item.',
    `instance_type` STRING COMMENT 'Cloud provider instance type or hardware specification model for the configuration item (e.g., m5.xlarge, c5.2xlarge).',
    `ip_address` STRING COMMENT 'Primary IP address assigned to the configuration item for network communication.',
    `last_maintenance_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent maintenance activity performed on the configuration item.',
    `memory_gb` DECIMAL(18,2) COMMENT 'Amount of memory (RAM) allocated to the configuration item, measured in gigabytes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration item record was last modified or updated.',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates whether active monitoring is enabled for this configuration item to track performance and health metrics.',
    `next_maintenance_date` DATE COMMENT 'Date when the next scheduled maintenance activity is planned for the configuration item.',
    `operating_system` STRING COMMENT 'Operating system running on the configuration item (e.g., Linux Ubuntu 22.04, Windows Server 2022).',
    `owner_team` STRING COMMENT 'Name of the team or organizational unit responsible for managing and maintaining this configuration item.',
    `patch_level` STRING COMMENT 'Current patch level or update version applied to the configuration item for security and maintenance.',
    `port_number` STRING COMMENT 'Primary network port number on which the configuration item listens for connections.',
    `provisioned_date` DATE COMMENT 'Date when the configuration item was initially provisioned and made available for use.',
    `region` STRING COMMENT 'Geographic region or data center location where the configuration item is deployed (e.g., us-east-1, eu-west-2, ap-southeast-1).',
    `sla_fps_target` STRING COMMENT 'Target frames per second (FPS) performance metric defined in the service level agreement for game server configuration items.',
    `sla_latency_target_ms` STRING COMMENT 'Target maximum latency in milliseconds defined in the service level agreement for this configuration item.',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'Target uptime percentage defined in the service level agreement for this configuration item (e.g., 99.95%).',
    `software_version` STRING COMMENT 'Version number of the primary software or application running on the configuration item.',
    `storage_gb` DECIMAL(18,2) COMMENT 'Amount of persistent storage allocated to the configuration item, measured in gigabytes.',
    `support_tier` STRING COMMENT 'Support tier level assigned to the configuration item indicating priority and escalation path (tier 1, tier 2, tier 3, critical, standard).',
    `vendor_name` STRING COMMENT 'Name of the vendor or cloud provider supplying the configuration item (e.g., AWS, Azure, GCP, on-premise).',
    CONSTRAINT pk_configuration_item PRIMARY KEY(`configuration_item_id`)
) COMMENT 'Master reference table for configuration_item. Referenced by configuration_item_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`infrastructure`.`alert_suppression_rule` (
    `alert_suppression_rule_id` BIGINT COMMENT 'Primary key for alert_suppression_rule',
    `superseded_alert_suppression_rule_id` BIGINT COMMENT 'Self-referencing FK on alert_suppression_rule (superseded_alert_suppression_rule_id)',
    `activation_count` STRING COMMENT 'Number of times this suppression rule has been triggered and activated since creation.',
    `alert_category` STRING COMMENT 'Category of alerts targeted by this suppression rule, such as performance, availability, security, or capacity alerts.',
    `alert_severity_filter` STRING COMMENT 'Minimum severity level of alerts that this suppression rule will affect. Alerts below this severity are not suppressed.',
    `approved_by_user_id` STRING COMMENT 'Identifier of the user who approved this suppression rule for activation, if approval workflow is required.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this suppression rule was approved for activation.',
    `audit_trail_flag` BOOLEAN COMMENT 'Indicates whether suppressed alerts are logged for audit and compliance purposes even when not displayed.',
    `auto_expire_flag` BOOLEAN COMMENT 'Indicates whether the suppression rule automatically expires after its effective end timestamp or requires manual deactivation.',
    `business_justification` STRING COMMENT 'Business rationale and approval context for creating this suppression rule, including incident or change request references.',
    `condition_expression` STRING COMMENT 'Logical expression or criteria that must be met for the suppression rule to activate and suppress matching alerts.',
    `created_by_user_id` STRING COMMENT 'Identifier of the user or system account that created this suppression rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this suppression rule record was first created in the system.',
    `alert_suppression_rule_description` STRING COMMENT 'Detailed description of the suppression rule purpose, business justification, and operational context.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Date and time when this suppression rule expires and stops suppressing alerts. Null indicates indefinite duration.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Date and time when this suppression rule becomes active and begins suppressing alerts.',
    `escalation_bypass_flag` BOOLEAN COMMENT 'Indicates whether suppressed alerts bypass normal escalation workflows and incident management processes.',
    `incident_reference_id` STRING COMMENT 'Reference identifier to the incident or change request that prompted the creation of this suppression rule.',
    `last_activation_timestamp` TIMESTAMP COMMENT 'Date and time when this suppression rule was most recently triggered and activated.',
    `maintenance_window_id` BIGINT COMMENT 'Reference to the planned maintenance window associated with this suppression rule, if applicable.',
    `modified_by_user_id` STRING COMMENT 'Identifier of the user or system account that last modified this suppression rule.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this suppression rule record was last modified.',
    `notification_override_flag` BOOLEAN COMMENT 'Indicates whether this suppression rule also prevents notification delivery or only suppresses alert visibility.',
    `priority_level` STRING COMMENT 'Priority classification of the suppression rule determining its precedence when multiple rules apply to the same alert.',
    `recurrence_pattern` STRING COMMENT 'Cron expression or schedule pattern defining recurring time windows when the suppression rule is active.',
    `rule_code` STRING COMMENT 'Unique business identifier code for the suppression rule, used for external references and integrations.',
    `rule_name` STRING COMMENT 'Human-readable name of the alert suppression rule for identification and management purposes.',
    `rule_type` STRING COMMENT 'Classification of the suppression rule based on its triggering mechanism and operational purpose.',
    `scope` STRING COMMENT 'Defines the infrastructure scope to which this suppression rule applies, from global to individual server level.',
    `alert_suppression_rule_status` STRING COMMENT 'Current lifecycle status of the alert suppression rule indicating whether it is operational and enforced.',
    `suppressed_alert_count` STRING COMMENT 'Total number of alerts that have been suppressed by this rule since creation.',
    `suppression_duration_minutes` STRING COMMENT 'Duration in minutes for which alerts will be suppressed once the rule is triggered.',
    `tags` STRING COMMENT 'Comma-separated list of tags or labels for categorizing and filtering suppression rules.',
    `target_environment` STRING COMMENT 'Infrastructure environment where the suppression rule is enforced, such as production or staging.',
    `target_region_code` STRING COMMENT 'Geographic region or datacenter location code where the suppression rule applies.',
    `target_service_name` STRING COMMENT 'Name of the specific game service or infrastructure component to which this suppression rule applies.',
    `threshold_unit` STRING COMMENT 'Unit of measurement for the threshold value, such as percentage, count, milliseconds, or concurrent users.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value used in condition evaluation for threshold-based suppression rules.',
    `timezone` STRING COMMENT 'Timezone identifier for interpreting time-based suppression windows, following IANA timezone database format.',
    `version_number` STRING COMMENT 'Version number of this suppression rule configuration, incremented with each modification for change tracking.',
    CONSTRAINT pk_alert_suppression_rule PRIMARY KEY(`alert_suppression_rule_id`)
) COMMENT 'Master reference table for alert_suppression_rule. Referenced by suppression_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ADD CONSTRAINT `fk_infrastructure_game_server_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ADD CONSTRAINT `fk_infrastructure_server_fleet_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ADD CONSTRAINT `fk_infrastructure_server_fleet_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `gaming_ecm`.`infrastructure`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ADD CONSTRAINT `fk_infrastructure_cdn_node_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ADD CONSTRAINT `fk_infrastructure_matchmaking_pool_matchmaking_service_id` FOREIGN KEY (`matchmaking_service_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_service`(`matchmaking_service_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ADD CONSTRAINT `fk_infrastructure_capacity_plan_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `gaming_ecm`.`infrastructure`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ADD CONSTRAINT `fk_infrastructure_infrastructure_incident_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `gaming_ecm`.`infrastructure`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ADD CONSTRAINT `fk_infrastructure_server_session_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_matchmaking_service_id` FOREIGN KEY (`matchmaking_service_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_service`(`matchmaking_service_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ADD CONSTRAINT `fk_infrastructure_network_performance_event_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `gaming_ecm`.`infrastructure`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `gaming_ecm`.`infrastructure`.`change_request`(`change_request_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_cicd_pipeline_id` FOREIGN KEY (`cicd_pipeline_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cicd_pipeline`(`cicd_pipeline_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ADD CONSTRAINT `fk_infrastructure_infrastructure_deployment_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ADD CONSTRAINT `fk_infrastructure_cicd_pipeline_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ADD CONSTRAINT `fk_infrastructure_cloud_resource_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ADD CONSTRAINT `fk_infrastructure_cloud_resource_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ADD CONSTRAINT `fk_infrastructure_matchmaking_ticket_matchmaking_pool_id` FOREIGN KEY (`matchmaking_pool_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_pool`(`matchmaking_pool_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ADD CONSTRAINT `fk_infrastructure_matchmaking_ticket_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ADD CONSTRAINT `fk_infrastructure_matchmaking_ticket_server_session_id` FOREIGN KEY (`server_session_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_session`(`server_session_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `gaming_ecm`.`infrastructure`.`change_request`(`change_request_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ADD CONSTRAINT `fk_infrastructure_maintenance_window_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `gaming_ecm`.`infrastructure`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_cdn_node_id` FOREIGN KEY (`cdn_node_id`) REFERENCES `gaming_ecm`.`infrastructure`.`cdn_node`(`cdn_node_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_network_region_id` FOREIGN KEY (`network_region_id`) REFERENCES `gaming_ecm`.`infrastructure`.`network_region`(`network_region_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ADD CONSTRAINT `fk_infrastructure_security_event_correlated_security_event_id` FOREIGN KEY (`correlated_security_event_id`) REFERENCES `gaming_ecm`.`infrastructure`.`security_event`(`security_event_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ADD CONSTRAINT `fk_infrastructure_infrastructure_test_execution_game_server_id` FOREIGN KEY (`game_server_id`) REFERENCES `gaming_ecm`.`infrastructure`.`game_server`(`game_server_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`monitoring_alert` ADD CONSTRAINT `fk_infrastructure_monitoring_alert_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`monitoring_alert` ADD CONSTRAINT `fk_infrastructure_monitoring_alert_alert_suppression_rule_id` FOREIGN KEY (`alert_suppression_rule_id`) REFERENCES `gaming_ecm`.`infrastructure`.`alert_suppression_rule`(`alert_suppression_rule_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`monitoring_alert` ADD CONSTRAINT `fk_infrastructure_monitoring_alert_parent_monitoring_alert_id` FOREIGN KEY (`parent_monitoring_alert_id`) REFERENCES `gaming_ecm`.`infrastructure`.`monitoring_alert`(`monitoring_alert_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ADD CONSTRAINT `fk_infrastructure_change_request_configuration_item_id` FOREIGN KEY (`configuration_item_id`) REFERENCES `gaming_ecm`.`infrastructure`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ADD CONSTRAINT `fk_infrastructure_change_request_infrastructure_incident_id` FOREIGN KEY (`infrastructure_incident_id`) REFERENCES `gaming_ecm`.`infrastructure`.`infrastructure_incident`(`infrastructure_incident_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ADD CONSTRAINT `fk_infrastructure_change_request_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `gaming_ecm`.`infrastructure`.`problem`(`problem_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ADD CONSTRAINT `fk_infrastructure_change_request_rollback_change_request_id` FOREIGN KEY (`rollback_change_request_id`) REFERENCES `gaming_ecm`.`infrastructure`.`change_request`(`change_request_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_service` ADD CONSTRAINT `fk_infrastructure_matchmaking_service_server_fleet_id` FOREIGN KEY (`server_fleet_id`) REFERENCES `gaming_ecm`.`infrastructure`.`server_fleet`(`server_fleet_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_service` ADD CONSTRAINT `fk_infrastructure_matchmaking_service_fallback_matchmaking_service_id` FOREIGN KEY (`fallback_matchmaking_service_id`) REFERENCES `gaming_ecm`.`infrastructure`.`matchmaking_service`(`matchmaking_service_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`configuration_item` ADD CONSTRAINT `fk_infrastructure_configuration_item_parent_configuration_item_id` FOREIGN KEY (`parent_configuration_item_id`) REFERENCES `gaming_ecm`.`infrastructure`.`configuration_item`(`configuration_item_id`);
ALTER TABLE `gaming_ecm`.`infrastructure`.`alert_suppression_rule` ADD CONSTRAINT `fk_infrastructure_alert_suppression_rule_superseded_alert_suppression_rule_id` FOREIGN KEY (`superseded_alert_suppression_rule_id`) REFERENCES `gaming_ecm`.`infrastructure`.`alert_suppression_rule`(`alert_suppression_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`infrastructure` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `gaming_ecm`.`infrastructure` SET TAGS ('dbx_domain' = 'infrastructure');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` SET TAGS ('dbx_subdomain' = 'server_operations');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `anti_cheat_version` SET TAGS ('dbx_business_glossary_term' = 'Anti-Cheat Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `auto_scaling_group` SET TAGS ('dbx_business_glossary_term' = 'Auto-Scaling Group');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `availability_zone` SET TAGS ('dbx_business_glossary_term' = 'Availability Zone');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `average_fps` SET TAGS ('dbx_business_glossary_term' = 'Average Frames Per Second (FPS)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `average_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Latency (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `capacity_tier` SET TAGS ('dbx_business_glossary_term' = 'Capacity Tier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `capacity_tier` SET TAGS ('dbx_value_regex' = 'small|medium|large|xlarge|dedicated');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Hour');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `cpu_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Central Processing Unit (CPU) Utilization Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `current_player_count` SET TAGS ('dbx_business_glossary_term' = 'Current Player Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `drm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Enabled');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `game_build_version` SET TAGS ('dbx_business_glossary_term' = 'Game Build Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `game_mode` SET TAGS ('dbx_business_glossary_term' = 'Game Mode');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `health_check_status` SET TAGS ('dbx_business_glossary_term' = 'Health Check Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `health_check_status` SET TAGS ('dbx_value_regex' = 'healthy|degraded|unhealthy|unknown');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `health_check_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `health_check_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `max_player_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Player Capacity');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `memory_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Memory Utilization Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `network_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Network Bandwidth (Megabits Per Second)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `os_image_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Image Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `port_number` SET TAGS ('dbx_business_glossary_term' = 'Port Number');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `provisioned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `server_code` SET TAGS ('dbx_business_glossary_term' = 'Server Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `server_name` SET TAGS ('dbx_business_glossary_term' = 'Server Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `server_status` SET TAGS ('dbx_business_glossary_term' = 'Server Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `server_status` SET TAGS ('dbx_value_regex' = 'running|draining|terminated|provisioning|maintenance|failed');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `server_type` SET TAGS ('dbx_business_glossary_term' = 'Server Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `server_type` SET TAGS ('dbx_value_regex' = 'dedicated|listen|peer_to_peer|hybrid');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Started Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `tags_metadata` SET TAGS ('dbx_business_glossary_term' = 'Tags Metadata');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `terminated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Terminated Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`game_server` ALTER COLUMN `uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` SET TAGS ('dbx_subdomain' = 'server_operations');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `autoscaling_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Autoscaling Policy Reference');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `average_fps` SET TAGS ('dbx_business_glossary_term' = 'Average Frames Per Second (FPS)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `average_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Latency (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `build_version` SET TAGS ('dbx_business_glossary_term' = 'Build Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `cdn_topology_reference` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Topology Reference');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `cloud_provider` SET TAGS ('dbx_business_glossary_term' = 'Cloud Provider');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `cloud_provider` SET TAGS ('dbx_value_regex' = 'AWS|Azure|GCP|Alibaba Cloud|On-Premise|Hybrid');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Hour');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `current_ccu` SET TAGS ('dbx_business_glossary_term' = 'Current Concurrent Users (CCU)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `current_instance_count` SET TAGS ('dbx_business_glossary_term' = 'Current Instance Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `decommissioned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decommissioned Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `deployment_tier` SET TAGS ('dbx_business_glossary_term' = 'Deployment Tier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `deployment_tier` SET TAGS ('dbx_value_regex' = 'production|staging|canary|development|qa');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `fleet_code` SET TAGS ('dbx_business_glossary_term' = 'Fleet Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `fleet_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `fleet_name` SET TAGS ('dbx_business_glossary_term' = 'Fleet Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `fleet_status` SET TAGS ('dbx_business_glossary_term' = 'Fleet Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `fleet_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|scaling|degraded|failed');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `game_mode` SET TAGS ('dbx_business_glossary_term' = 'Game Mode');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `health_check_status` SET TAGS ('dbx_business_glossary_term' = 'Health Check Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `health_check_status` SET TAGS ('dbx_value_regex' = 'healthy|unhealthy|degraded|unknown');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `health_check_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `health_check_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `instance_type` SET TAGS ('dbx_business_glossary_term' = 'Instance Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `last_incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Incident Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `matchmaking_service_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Service Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `max_instance_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Instance Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `min_instance_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Instance Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `pcu_watermark` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (PCU) Watermark');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `pcu_watermark_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (PCU) Watermark Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `tags_metadata` SET TAGS ('dbx_business_glossary_term' = 'Tags Metadata');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `target_capacity` SET TAGS ('dbx_business_glossary_term' = 'Target Capacity');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_fleet` ALTER COLUMN `uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` SET TAGS ('dbx_subdomain' = 'server_operations');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node Identifier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `activated_date` SET TAGS ('dbx_business_glossary_term' = 'Activated Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `average_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Latency (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `bandwidth_capacity_gbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Capacity (Gigabits per Second)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `cache_hit_ratio_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cache Hit Ratio Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `cache_storage_quota_tb` SET TAGS ('dbx_business_glossary_term' = 'Cache Storage Quota (Terabytes)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `cache_storage_used_tb` SET TAGS ('dbx_business_glossary_term' = 'Cache Storage Used (Terabytes)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `cdn_node_status` SET TAGS ('dbx_business_glossary_term' = 'CDN Node Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `cdn_node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|degraded|provisioning|decommissioned');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `compression_enabled` SET TAGS ('dbx_business_glossary_term' = 'Compression Enabled');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `cost_per_gb_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Gigabyte (United States Dollars)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `cost_per_gb_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `current_concurrent_connections` SET TAGS ('dbx_business_glossary_term' = 'Current Concurrent Connections (CCU)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `data_center_facility` SET TAGS ('dbx_business_glossary_term' = 'Data Center Facility Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `data_center_facility` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `decommissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioned Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `drm_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Enabled');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `hostname` SET TAGS ('dbx_business_glossary_term' = 'Hostname');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `hostname` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `ipv4_address` SET TAGS ('dbx_business_glossary_term' = 'IPv4 Address');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `ipv4_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `ipv4_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `ipv6_address` SET TAGS ('dbx_business_glossary_term' = 'IPv6 Address');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `ipv6_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `monitoring_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `monitoring_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `monthly_bandwidth_quota_tb` SET TAGS ('dbx_business_glossary_term' = 'Monthly Bandwidth Quota (Terabytes)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `monthly_bandwidth_used_tb` SET TAGS ('dbx_business_glossary_term' = 'Monthly Bandwidth Used (Terabytes)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'CDN Node Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'CDN Node Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'CDN Node Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'edge|origin_shield|regional_cache|pop');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `peak_concurrent_connections` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Connections (PCU)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `peering_configuration` SET TAGS ('dbx_business_glossary_term' = 'Peering Configuration');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `peering_configuration` SET TAGS ('dbx_value_regex' = 'public_internet|private_peering|direct_connect|hybrid');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'CDN Provider Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `ssl_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'SSL Certificate Expiry Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `supports_http2` SET TAGS ('dbx_business_glossary_term' = 'Supports HTTP/2 Protocol');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `supports_http3` SET TAGS ('dbx_business_glossary_term' = 'Supports HTTP/3 Protocol');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cdn_node` ALTER COLUMN `uptime_sla_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Service Level Agreement (SLA) Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` SET TAGS ('dbx_subdomain' = 'server_operations');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `matchmaking_service_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Service Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `acceptable_latency_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Latency Threshold (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `active_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Active From Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `active_until_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Active Until Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `anti_cheat_enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Anti-Cheat Enforcement Level');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `anti_cheat_enforcement_level` SET TAGS ('dbx_value_regex' = 'standard|strict|tournament|disabled');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `backfill_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Backfill Enabled Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `ccu_capacity_target` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Users (CCU) Capacity Target');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `crossplay_policy` SET TAGS ('dbx_business_glossary_term' = 'Crossplay Policy');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `crossplay_policy` SET TAGS ('dbx_value_regex' = 'enabled|disabled|opt_in|platform_restricted');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `input_method_restriction` SET TAGS ('dbx_business_glossary_term' = 'Input Method Restriction');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `input_method_restriction` SET TAGS ('dbx_value_regex' = 'any|controller_only|keyboard_mouse_only|input_based_matching');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `match_timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Match Timeout (Seconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `matchmaking_algorithm_type` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Algorithm Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `matchmaking_algorithm_type` SET TAGS ('dbx_value_regex' = 'skill_based|latency_based|hybrid|input_based|random');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `max_match_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Match Size');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `max_queue_wait_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Maximum Queue Wait Time (Seconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `min_match_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Match Size');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `mmr_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Matchmaking Rating (MMR) Range');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `mmr_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Matchmaking Rating (MMR) Range');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `party_size_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Party Size');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `party_size_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Party Size');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `pcu_historical_peak` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (PCU) Historical Peak');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `platform_restriction` SET TAGS ('dbx_business_glossary_term' = 'Platform Restriction');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `pool_code` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `pool_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `pool_description` SET TAGS ('dbx_business_glossary_term' = 'Pool Description');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `pool_name` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `pool_status` SET TAGS ('dbx_business_glossary_term' = 'Pool Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `pool_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|deprecated|testing');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `queue_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Queue Priority Tier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `rank_tier_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rank Tier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `rank_tier_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rank Tier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `region_restriction` SET TAGS ('dbx_business_glossary_term' = 'Region Restriction');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `seasonal_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `skill_variance_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Skill Variance Tolerance');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `sla_target_match_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Match Time (Seconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `target_match_size` SET TAGS ('dbx_business_glossary_term' = 'Target Match Size');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `team_composition_rule` SET TAGS ('dbx_business_glossary_term' = 'Team Composition Rule');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_pool` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` SET TAGS ('dbx_subdomain' = 'server_operations');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `availability_zone_count` SET TAGS ('dbx_business_glossary_term' = 'Availability Zone Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `average_latency_to_peers_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Latency to Peer Regions (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `ccu_capacity` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Users (CCU) Capacity');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `cdn_provider` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Provider');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `cicd_pipeline_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Continuous Integration/Continuous Deployment (CI/CD) Pipeline Endpoint');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `cicd_pipeline_endpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `cloud_provider` SET TAGS ('dbx_business_glossary_term' = 'Cloud Provider');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `cloud_provider` SET TAGS ('dbx_value_regex' = 'AWS|Azure|GCP|Alibaba|Private');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `continent_code` SET TAGS ('dbx_business_glossary_term' = 'Continent Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `data_residency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Jurisdiction');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Display Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `failover_datacenter_location` SET TAGS ('dbx_business_glossary_term' = 'Failover Datacenter Location');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `failover_datacenter_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `incident_escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Incident Escalation Contact');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `incident_escalation_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `incident_escalation_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `incident_escalation_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `matchmaking_priority` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Priority');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `max_latency_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Maximum Latency Threshold (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `monitoring_dashboard_url` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Dashboard Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `monitoring_dashboard_url` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `monthly_operating_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Monthly Operating Cost (United States Dollars)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `monthly_operating_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `network_backbone_provider` SET TAGS ('dbx_business_glossary_term' = 'Network Backbone Provider');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `network_region_status` SET TAGS ('dbx_business_glossary_term' = 'Region Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `network_region_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|deprecated');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `pcu_record` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (PCU) Record');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `pcu_record_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Peak Concurrent Users (PCU) Record Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `player_population_density_tier` SET TAGS ('dbx_business_glossary_term' = 'Player Population Density Tier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `player_population_density_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `primary_datacenter_location` SET TAGS ('dbx_business_glossary_term' = 'Primary Datacenter Location');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `primary_datacenter_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}-[a-z]+-[0-9]{1,2}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `supports_mmo` SET TAGS ('dbx_business_glossary_term' = 'Supports Massively Multiplayer Online (MMO)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `supports_pve` SET TAGS ('dbx_business_glossary_term' = 'Supports Player versus Environment (PvE)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `supports_pvp` SET TAGS ('dbx_business_glossary_term' = 'Supports Player versus Player (PvP)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `target_fps` SET TAGS ('dbx_business_glossary_term' = 'Target Frames Per Second (FPS)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_region` ALTER COLUMN `uptime_sla_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Service Level Agreement (SLA) Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'server_operations');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `budget_version_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Author ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `primary_capacity_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Engineer ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `primary_capacity_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `primary_capacity_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Target Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost United States Dollars (USD)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `actual_maintenance_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Maintenance End Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `actual_maintenance_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Maintenance Start Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `autoscaling_cooldown_seconds` SET TAGS ('dbx_business_glossary_term' = 'Auto-Scaling Cooldown Seconds');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `autoscaling_trigger_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Auto-Scaling Trigger Threshold Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `capacity_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `capacity_plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|completed|cancelled');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `cdn_topology_version` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Topology Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost United States Dollars (USD)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `forecasted_peak_ccu` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Peak Concurrent Users (CCU)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `forecasted_peak_pcu` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Peak Concurrent Users (PCU)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'patch|upgrade|migration|emergency|configuration');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `maintenance_window_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `maintenance_window_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `matchmaking_service_version` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Service Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|sent|acknowledged');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `on_demand_instance_count` SET TAGS ('dbx_business_glossary_term' = 'On-Demand Instance Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'baseline|seasonal|event|launch|emergency|maintenance');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `planned_server_instance_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Server Instance Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `player_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Player Impact Level');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `player_impact_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `reserved_instance_count` SET TAGS ('dbx_business_glossary_term' = 'Reserved Instance Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `scaling_headroom_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scaling Headroom Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`capacity_plan` ALTER COLUMN `sla_exclusion_window_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Exclusion Window Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` SET TAGS ('dbx_subdomain' = 'server_operations');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Policy ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `applicable_regions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Geographic Regions');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `breach_escalation_path` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Escalation Path');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `breach_notification_required` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Notification Required');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `cdn_coverage_required` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Coverage Required');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `ci_cd_pipeline_sla_included` SET TAGS ('dbx_business_glossary_term' = 'Continuous Integration/Continuous Deployment (CI/CD) Pipeline SLA Included');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `matchmaking_sla_included` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking SLA Included');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `max_ccu_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Users (CCU) Capacity');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `max_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Maximum Latency Milliseconds (ms)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `max_pcu_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Peak Concurrent Users (PCU) Capacity');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'SLA Measurement Period');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `measurement_period` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|quarterly');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `monitoring_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Interval Seconds');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Owner Role');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'SLA Penalty Clause');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'SLA Reporting Frequency');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `rpo_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Point Objective (RPO) Minutes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `rto_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Time Objective (RTO) Minutes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `sla_policy_description` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Description');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `sla_policy_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `sla_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|suspended');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `target_fps` SET TAGS ('dbx_business_glossary_term' = 'Target Frames Per Second (FPS)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `target_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Uptime Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier Level');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `tier_level` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard|basic');
ALTER TABLE `gaming_ecm`.`infrastructure`.`sla_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `infrastructure_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Incident ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Engineer ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `title_pl_id` SET TAGS ('dbx_business_glossary_term' = 'Title Pl Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `actual_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Minutes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `affected_service_component` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Component');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `ccu_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Users (CCU) Affected Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closure Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `detected_by_source` SET TAGS ('dbx_business_glossary_term' = 'Detected By Source');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `detected_by_source` SET TAGS ('dbx_value_regex' = 'automated_monitoring|player_report|internal_team|third_party_alert');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3|executive');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact United States Dollar (USD)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `external_communication_flag` SET TAGS ('dbx_business_glossary_term' = 'External Communication Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'detected|acknowledged|investigating|mitigating|resolved|closed');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `mitigation_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action Summary');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `monitoring_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Alert ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `player_facing_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Player-Facing Impact Description');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `post_mortem_reference` SET TAGS ('dbx_business_glossary_term' = 'Post-Mortem Reference');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `preventive_action_items` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Items');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `related_incident_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Incident IDs');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'P0|P1|P2|P3|P4');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_incident` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Incident Title');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` SET TAGS ('dbx_subdomain' = 'session_management');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `server_session_id` SET TAGS ('dbx_business_glossary_term' = 'Server Session Identifier (ID)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `game_mode_id` SET TAGS ('dbx_business_glossary_term' = 'Game Mode Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Identifier (ID)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `guild_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `match_id` SET TAGS ('dbx_business_glossary_term' = 'Match Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Identifier (ID)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `session_event_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Session Event Summary Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `anti_cheat_flags` SET TAGS ('dbx_business_glossary_term' = 'Anti-Cheat Flags');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `average_fps` SET TAGS ('dbx_business_glossary_term' = 'Average Frames Per Second (FPS)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `average_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Latency in Milliseconds (ms)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `average_player_count` SET TAGS ('dbx_business_glossary_term' = 'Average Player Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `cpu_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'CPU Utilization Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `is_private` SET TAGS ('dbx_business_glossary_term' = 'Is Private Session');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `is_ranked` SET TAGS ('dbx_business_glossary_term' = 'Is Ranked Match');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `map_name` SET TAGS ('dbx_business_glossary_term' = 'Game Map Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `match_result` SET TAGS ('dbx_business_glossary_term' = 'Match Result');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `max_player_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Player Capacity');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `memory_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Memory Utilization Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `minimum_fps` SET TAGS ('dbx_business_glossary_term' = 'Minimum Frames Per Second (FPS)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `packet_loss_percent` SET TAGS ('dbx_business_glossary_term' = 'Packet Loss Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `peak_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Peak Latency in Milliseconds (ms)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `peak_player_count` SET TAGS ('dbx_business_glossary_term' = 'Peak Player Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `server_tick_rate` SET TAGS ('dbx_business_glossary_term' = 'Server Tick Rate');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `server_version` SET TAGS ('dbx_business_glossary_term' = 'Server Software Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `session_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration in Seconds');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `session_identifier` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'initializing|waiting_for_players|in_progress|completed|terminated|crashed');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Session Termination Reason');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'normal_completion|server_crash|timeout|admin_shutdown|insufficient_players|network_failure');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `total_bandwidth_mb` SET TAGS ('dbx_business_glossary_term' = 'Total Bandwidth in Megabytes (MB)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`server_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `network_performance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Network Performance Event ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Server ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `infrastructure_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `matchmaking_service_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Service ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Policy ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `telemetry_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Pipeline Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `alert_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Triggered Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Severity Level');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `ccu_count` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Users (CCU) Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Component Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'game_server|cdn_node|matchmaking_service|load_balancer|database_cluster|api_gateway');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `cpu_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'CPU Utilization Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `downtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `fps_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Frames Per Second (FPS) Impact Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `http_status_code` SET TAGS ('dbx_business_glossary_term' = 'HTTP Status Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `jitter_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Jitter (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement Method');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'real_time|periodic_aggregation|on_demand|threshold_triggered');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `measurement_window_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window End Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `measurement_window_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Start Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `memory_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Memory Utilization Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `monitoring_source` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Data Source Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `monitoring_source` SET TAGS ('dbx_value_regex' = 'synthetic_probe|agent_based|network_tap|log_aggregation|apm_tool');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Event Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `packet_loss_percentage` SET TAGS ('dbx_business_glossary_term' = 'Packet Loss Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Gaming Platform Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'API Response Time (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `throughput_mbps` SET TAGS ('dbx_business_glossary_term' = 'Network Throughput (Megabits Per Second)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`network_performance_event` ALTER COLUMN `uptime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Uptime Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` SET TAGS ('dbx_subdomain' = 'deployment_automation');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `infrastructure_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Deployment ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `cicd_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Cicd Pipeline Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `intangible_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intangible Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Engineer ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `remediation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `actual_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Downtime Minutes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `affected_player_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Player Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|auto_approved|emergency_override');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `artifact_repository_url` SET TAGS ('dbx_business_glossary_term' = 'Artifact Repository URL');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `artifact_repository_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+/.*$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `automated_deployment_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Deployment Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `build_version` SET TAGS ('dbx_business_glossary_term' = 'Build Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `build_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `canary_percentage` SET TAGS ('dbx_business_glossary_term' = 'Canary Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Completion Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_business_glossary_term' = 'Deployment Number');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `deployment_type` SET TAGS ('dbx_business_glossary_term' = 'Deployment Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `deployment_type` SET TAGS ('dbx_value_regex' = 'hotfix|patch|full_release|rollback|canary|emergency');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Duration Minutes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `health_check_status` SET TAGS ('dbx_business_glossary_term' = 'Health Check Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `health_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_run|in_progress');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `health_check_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `health_check_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `monitoring_dashboard_url` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Dashboard URL');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `monitoring_dashboard_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+/.*$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `previous_build_version` SET TAGS ('dbx_business_glossary_term' = 'Previous Build Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `previous_build_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Deployment Priority');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `rollback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Eligible Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `server_count` SET TAGS ('dbx_business_glossary_term' = 'Server Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Start Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `strategy` SET TAGS ('dbx_business_glossary_term' = 'Deployment Strategy');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `strategy` SET TAGS ('dbx_value_regex' = 'blue_green|canary|rolling|recreate|all_at_once');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `target_environment` SET TAGS ('dbx_business_glossary_term' = 'Target Environment');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `target_environment` SET TAGS ('dbx_value_regex' = 'development|staging|uat|production|disaster_recovery');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `window_end` SET TAGS ('dbx_business_glossary_term' = 'Deployment Window End');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_deployment` ALTER COLUMN `window_start` SET TAGS ('dbx_business_glossary_term' = 'Deployment Window Start');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` SET TAGS ('dbx_subdomain' = 'deployment_automation');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `cicd_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Continuous Integration/Continuous Deployment (CI/CD) Pipeline ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Studio ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `approval_gate_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Gate Required');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `artifact_version` SET TAGS ('dbx_business_glossary_term' = 'Artifact Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Branch Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `build_agent` SET TAGS ('dbx_business_glossary_term' = 'Build Agent');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `commit_sha` SET TAGS ('dbx_business_glossary_term' = 'Commit Secure Hash Algorithm (SHA)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `commit_sha` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{40}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `container_image_tag` SET TAGS ('dbx_business_glossary_term' = 'Container Image Tag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `deployment_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Approval Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `deployment_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `last_successful_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Run Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `max_execution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Execution Time Minutes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipients');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `parallel_execution_enabled` SET TAGS ('dbx_business_glossary_term' = 'Parallel Execution Enabled');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `pipeline_config_version` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Configuration Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `pipeline_description` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Description');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `pipeline_name` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `pipeline_priority` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Priority');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `pipeline_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `pipeline_tool` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Tool');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `pipeline_tool` SET TAGS ('dbx_value_regex' = 'Jenkins|GitHub Actions|GitLab CI|TeamCity|Azure DevOps|CircleCI');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `quality_gate_passed` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Passed');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `repository_url` SET TAGS ('dbx_business_glossary_term' = 'Repository Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `repository_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'queued|running|passed|failed|cancelled|aborted');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `security_scan_status` SET TAGS ('dbx_business_glossary_term' = 'Security Scan Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `security_scan_status` SET TAGS ('dbx_value_regex' = 'passed|failed|skipped|warning');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `stages_failed` SET TAGS ('dbx_business_glossary_term' = 'Stages Failed');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `stages_passed` SET TAGS ('dbx_business_glossary_term' = 'Stages Passed');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `tag_name` SET TAGS ('dbx_business_glossary_term' = 'Tag Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `target_environment` SET TAGS ('dbx_business_glossary_term' = 'Target Environment');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `target_environment` SET TAGS ('dbx_value_regex' = 'dev|staging|production|QA|UAT');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percent');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Trigger Source');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Trigger Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'commit|scheduled|manual|PR merge|tag|webhook');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `triggering_actor` SET TAGS ('dbx_business_glossary_term' = 'Triggering Actor');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `triggering_actor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `webhook_url` SET TAGS ('dbx_business_glossary_term' = 'Webhook Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cicd_pipeline` ALTER COLUMN `webhook_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` SET TAGS ('dbx_subdomain' = 'server_operations');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `cloud_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Cloud Resource ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `auto_scaling_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Scaling Enabled');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `availability_zone` SET TAGS ('dbx_business_glossary_term' = 'Availability Zone');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `backup_enabled` SET TAGS ('dbx_business_glossary_term' = 'Backup Enabled');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `cloud_provider` SET TAGS ('dbx_business_glossary_term' = 'Cloud Provider');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `cloud_provider` SET TAGS ('dbx_value_regex' = 'AWS|Azure|GCP|Alibaba Cloud|Oracle Cloud|IBM Cloud');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Compliance Scope');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `cpu_cores` SET TAGS ('dbx_business_glossary_term' = 'CPU Cores');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `cumulative_spend` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Spend');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `cumulative_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'Production|Staging|Development|QA|UAT|Disaster Recovery');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `gpu_count` SET TAGS ('dbx_business_glossary_term' = 'GPU Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `gpu_model` SET TAGS ('dbx_business_glossary_term' = 'GPU Model');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `instance_family` SET TAGS ('dbx_business_glossary_term' = 'Instance Family');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `instance_size` SET TAGS ('dbx_business_glossary_term' = 'Instance Size');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle State');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_value_regex' = 'Active|Decommissioned|Reserved|Scheduled for Termination');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `memory_gb` SET TAGS ('dbx_business_glossary_term' = 'Memory Gigabytes (GB)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Enabled');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `monthly_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Monthly Cost Rate');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `monthly_cost_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `network_bandwidth_gbps` SET TAGS ('dbx_business_glossary_term' = 'Network Bandwidth Gigabits Per Second (Gbps)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Resource Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `provisioned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_value_regex' = 'Provisioning|Running|Stopped|Terminated|Failed|Pending');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `provisioning_tier` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Tier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `provisioning_tier` SET TAGS ('dbx_value_regex' = 'On-Demand|Reserved|Spot|Preemptible|Savings Plan');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `reserved_until_date` SET TAGS ('dbx_business_glossary_term' = 'Reserved Until Date');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'Cloud Resource Identifier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Cloud Resource Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Cloud Resource Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `storage_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Gigabytes (GB)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `tags_json` SET TAGS ('dbx_business_glossary_term' = 'Resource Tags JSON');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `termination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Termination Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`cloud_resource` ALTER COLUMN `uptime_sla_percent` SET TAGS ('dbx_business_glossary_term' = 'Uptime SLA Percentage');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` SET TAGS ('dbx_subdomain' = 'session_management');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `matchmaking_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Ticket Identifier (ID)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Identifier (ID)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Account Identifier (ID)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `server_session_id` SET TAGS ('dbx_business_glossary_term' = 'Server Session Identifier (ID)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `acceptable_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Latency Threshold (Milliseconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `backfill_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Backfill Eligible Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Ticket Cancellation Reason');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Cancelled Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `client_version` SET TAGS ('dbx_business_glossary_term' = 'Game Client Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `crossplay_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Crossplay Enabled Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `estimated_wait_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Estimated Wait Time (Seconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `expired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Expired Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Failure Reason');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `game_mode` SET TAGS ('dbx_business_glossary_term' = 'Game Mode');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `input_method` SET TAGS ('dbx_business_glossary_term' = 'Player Input Method');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `input_method` SET TAGS ('dbx_value_regex' = 'keyboard_mouse|gamepad|touch|motion');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `match_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Match Quality Score');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `matched_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Matched Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `matchmaking_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Algorithm Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `matchmaking_priority` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Priority Level');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `matchmaking_priority` SET TAGS ('dbx_value_regex' = 'standard|premium|vip|developer');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `party_leader_flag` SET TAGS ('dbx_business_glossary_term' = 'Party Leader Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `party_size` SET TAGS ('dbx_business_glossary_term' = 'Party Size');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Gaming Platform');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `queue_position` SET TAGS ('dbx_business_glossary_term' = 'Queue Position');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Retry Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `skill_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Acceptable Skill Rating Range');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `skill_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Acceptable Skill Rating Range');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `skill_rating` SET TAGS ('dbx_business_glossary_term' = 'Player Skill Rating at Submission');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Submitted Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Ticket Number');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^MMT-[A-Z0-9]{8,16}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Ticket Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_value_regex' = 'queued|matched|expired|cancelled|failed|timeout');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `voice_chat_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Voice Chat Enabled Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_ticket` ALTER COLUMN `wait_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Wait Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` SET TAGS ('dbx_subdomain' = 'server_operations');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `maintenance_window_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Engineer ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `affected_component_reference` SET TAGS ('dbx_business_glossary_term' = 'Affected Component Reference');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `affected_component_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Component Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `affected_component_type` SET TAGS ('dbx_value_regex' = 'game_server|matchmaking_service|cdn_node|database_cluster|api_gateway|authentication_service');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `affected_game_title_ids` SET TAGS ('dbx_business_glossary_term' = 'Affected Game Title IDs');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration Minutes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `estimated_ccu_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Concurrent Users (CCU) Impact');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `maintenance_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Description');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'patch|upgrade|migration|emergency|capacity_expansion|security_fix');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `maintenance_window_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `maintenance_window_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed|rolled_back');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Player Notification Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'not_sent|scheduled|sent|acknowledged');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `player_facing_message` SET TAGS ('dbx_business_glossary_term' = 'Player-Facing Message');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `player_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Player Impact Level');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `player_impact_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `post_maintenance_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Maintenance Validation Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `post_maintenance_validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|skipped');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `rollback_plan_available` SET TAGS ('dbx_business_glossary_term' = 'Rollback Plan Available');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `sla_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Exclusion Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `window_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `window_code` SET TAGS ('dbx_value_regex' = '^MW-[0-9]{6,10}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`maintenance_window` ALTER COLUMN `window_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Name');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `security_event_id` SET TAGS ('dbx_business_glossary_term' = 'Security Event ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Engineer ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `infrastructure_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Incident ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `telemetry_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Pipeline Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `title_pl_id` SET TAGS ('dbx_business_glossary_term' = 'Title Pl Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `correlated_security_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `attack_vector` SET TAGS ('dbx_business_glossary_term' = 'Attack Vector');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `automated_response_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automated Response Enabled Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `ccu_affected` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Users (CCU) Affected');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `communication_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'automated|manual|third_party|player_report');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `detection_system` SET TAGS ('dbx_business_glossary_term' = 'Detection System');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact (USD)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Security Event Number');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^SE-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Security Event Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'detected|analyzing|mitigating|mitigated|resolved|closed');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Security Event Type');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'ddos_attack|brute_force|credential_stuffing|waf_trigger|rate_limit_breach|bot_detection');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `false_positive_flag` SET TAGS ('dbx_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `latency_spike_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency Spike (ms)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `mitigation_action` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `mitigation_action` SET TAGS ('dbx_value_regex' = 'blackhole|rate_limit|cdn_shield|geo_block|waf_rule|ip_block');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `mitigation_description` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Description');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `mitigation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mitigation End Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `mitigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Start Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `peak_attack_volume_gbps` SET TAGS ('dbx_business_glossary_term' = 'Peak Attack Volume (Gbps)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `peak_attack_volume_mpps` SET TAGS ('dbx_business_glossary_term' = 'Peak Attack Volume (Mpps)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `player_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Player Impact Assessment');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `player_impact_assessment` SET TAGS ('dbx_value_regex' = 'none|minimal|moderate|significant|severe');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `post_mortem_reference` SET TAGS ('dbx_business_glossary_term' = 'Post-Mortem Reference');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `remediation_action_items` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Items');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `request_count` SET TAGS ('dbx_business_glossary_term' = 'Request Count');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `service_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Downtime (minutes)');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Security Event Severity Level');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `source_country_code` SET TAGS ('dbx_business_glossary_term' = 'Source Country Code');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `source_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `tags_metadata` SET TAGS ('dbx_business_glossary_term' = 'Tags Metadata');
ALTER TABLE `gaming_ecm`.`infrastructure`.`security_event` ALTER COLUMN `target_service_component` SET TAGS ('dbx_business_glossary_term' = 'Target Service Component');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` SET TAGS ('dbx_subdomain' = 'deployment_automation');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` SET TAGS ('dbx_association_edges' = 'infrastructure.game_server,quality.test_case');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `infrastructure_test_execution_id` SET TAGS ('dbx_business_glossary_term' = 'infrastructure_test_execution Identifier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Test Execution - Game Server Id');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Execution - Test Case Id');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `quality_test_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Test Execution ID');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `build_version` SET TAGS ('dbx_business_glossary_term' = 'Build Version');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `executed_by` SET TAGS ('dbx_business_glossary_term' = 'Executed By');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `execution_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Execution Duration');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `jira_test_run_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Test Run Key');
ALTER TABLE `gaming_ecm`.`infrastructure`.`infrastructure_test_execution` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `gaming_ecm`.`infrastructure`.`monitoring_alert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`monitoring_alert` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `gaming_ecm`.`infrastructure`.`monitoring_alert` ALTER COLUMN `monitoring_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Alert Identifier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`monitoring_alert` ALTER COLUMN `parent_monitoring_alert_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` SET TAGS ('dbx_subdomain' = 'deployment_automation');
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Identifier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`change_request` ALTER COLUMN `rollback_change_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_service` SET TAGS ('dbx_subdomain' = 'session_management');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_service` ALTER COLUMN `matchmaking_service_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Service Identifier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_service` ALTER COLUMN `fallback_matchmaking_service_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_service` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`matchmaking_service` ALTER COLUMN `cdn_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`problem` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`problem` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `gaming_ecm`.`infrastructure`.`problem` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Identifier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`configuration_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`configuration_item` SET TAGS ('dbx_subdomain' = 'deployment_automation');
ALTER TABLE `gaming_ecm`.`infrastructure`.`configuration_item` ALTER COLUMN `configuration_item_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item Identifier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`configuration_item` ALTER COLUMN `parent_configuration_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`configuration_item` ALTER COLUMN `cost_per_hour_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`configuration_item` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`infrastructure`.`alert_suppression_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`infrastructure`.`alert_suppression_rule` SET TAGS ('dbx_subdomain' = 'deployment_automation');
ALTER TABLE `gaming_ecm`.`infrastructure`.`alert_suppression_rule` ALTER COLUMN `alert_suppression_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Suppression Rule Identifier');
ALTER TABLE `gaming_ecm`.`infrastructure`.`alert_suppression_rule` ALTER COLUMN `superseded_alert_suppression_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
