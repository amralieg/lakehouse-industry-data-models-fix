-- Metric views for domain: infrastructure | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_cdn_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CDN node performance, capacity utilization, and cost efficiency metrics for content delivery infrastructure"
  source: "`gaming_ecm`.`infrastructure`.`cdn_node`"
  dimensions:
    - name: "cdn_node_status"
      expr: cdn_node_status
      comment: "Current operational status of the CDN node (active, maintenance, decommissioned)"
    - name: "node_type"
      expr: node_type
      comment: "Type classification of the CDN node (edge, origin, regional)"
    - name: "provider_name"
      expr: provider_name
      comment: "CDN infrastructure provider name"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code where the CDN node is located"
    - name: "city"
      expr: city
      comment: "City where the CDN node is physically located"
    - name: "data_center_facility"
      expr: data_center_facility
      comment: "Data center facility identifier hosting the CDN node"
    - name: "compression_enabled"
      expr: compression_enabled
      comment: "Whether content compression is enabled on this node"
    - name: "drm_enabled"
      expr: drm_enabled
      comment: "Whether digital rights management is enabled on this node"
    - name: "activated_year"
      expr: YEAR(activated_date)
      comment: "Year the CDN node was activated"
    - name: "activated_month"
      expr: DATE_TRUNC('MONTH', activated_date)
      comment: "Month the CDN node was activated"
  measures:
    - name: "total_cdn_nodes"
      expr: COUNT(1)
      comment: "Total count of CDN nodes"
    - name: "avg_cache_hit_ratio_pct"
      expr: AVG(CAST(cache_hit_ratio_percentage AS DOUBLE))
      comment: "Average cache hit ratio percentage across CDN nodes - key efficiency indicator for content delivery"
    - name: "avg_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average latency in milliseconds - critical performance metric for player experience"
    - name: "total_bandwidth_capacity_gbps"
      expr: SUM(CAST(bandwidth_capacity_gbps AS DOUBLE))
      comment: "Total bandwidth capacity in Gbps across all CDN nodes"
    - name: "bandwidth_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(monthly_bandwidth_used_tb AS DOUBLE)) / NULLIF(SUM(CAST(monthly_bandwidth_quota_tb AS DOUBLE)), 0), 2)
      comment: "Percentage of monthly bandwidth quota utilized - key capacity planning metric"
    - name: "storage_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(cache_storage_used_tb AS DOUBLE)) / NULLIF(SUM(CAST(cache_storage_quota_tb AS DOUBLE)), 0), 2)
      comment: "Percentage of cache storage quota utilized - indicates when expansion is needed"
    - name: "total_monthly_cdn_cost_usd"
      expr: SUM(CAST(monthly_bandwidth_used_tb AS DOUBLE) * CAST(cost_per_gb_usd AS DOUBLE) * 1024)
      comment: "Total monthly CDN cost in USD based on bandwidth usage - critical for infrastructure budget management"
    - name: "avg_cost_per_gb_usd"
      expr: AVG(CAST(cost_per_gb_usd AS DOUBLE))
      comment: "Average cost per gigabyte across CDN nodes - used for cost optimization decisions"
    - name: "total_concurrent_connections"
      expr: SUM(CAST(current_concurrent_connections AS BIGINT))
      comment: "Total current concurrent connections across all CDN nodes"
    - name: "avg_uptime_sla_pct"
      expr: AVG(CAST(uptime_sla_percentage AS DOUBLE))
      comment: "Average uptime SLA percentage - key service quality metric for player satisfaction"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_game_server`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game server performance, capacity utilization, and operational health metrics for real-time gaming infrastructure"
  source: "`gaming_ecm`.`infrastructure`.`game_server`"
  dimensions:
    - name: "server_status"
      expr: server_status
      comment: "Current operational status of the game server (active, idle, maintenance, terminated)"
    - name: "server_type"
      expr: server_type
      comment: "Type classification of the game server (dedicated, shared, match-based)"
    - name: "capacity_tier"
      expr: capacity_tier
      comment: "Capacity tier of the server (small, medium, large, xlarge)"
    - name: "health_check_status"
      expr: health_check_status
      comment: "Latest health check status of the game server"
    - name: "availability_zone"
      expr: availability_zone
      comment: "Cloud availability zone where the game server is deployed"
    - name: "auto_scaling_group"
      expr: auto_scaling_group
      comment: "Auto-scaling group identifier for capacity management"
    - name: "drm_enabled"
      expr: drm_enabled
      comment: "Whether digital rights management is enabled on this server"
    - name: "provisioned_year"
      expr: YEAR(provisioned_timestamp)
      comment: "Year the game server was provisioned"
    - name: "provisioned_month"
      expr: DATE_TRUNC('MONTH', provisioned_timestamp)
      comment: "Month the game server was provisioned"
  measures:
    - name: "total_game_servers"
      expr: COUNT(1)
      comment: "Total count of game servers"
    - name: "avg_cpu_utilization_pct"
      expr: AVG(CAST(cpu_utilization_pct AS DOUBLE))
      comment: "Average CPU utilization percentage - key metric for capacity planning and cost optimization"
    - name: "avg_memory_utilization_pct"
      expr: AVG(CAST(memory_utilization_pct AS DOUBLE))
      comment: "Average memory utilization percentage - indicates when vertical scaling is needed"
    - name: "avg_fps"
      expr: AVG(CAST(average_fps AS DOUBLE))
      comment: "Average frames per second - critical player experience quality metric"
    - name: "avg_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds - key performance indicator for real-time gameplay"
    - name: "total_hourly_infrastructure_cost_usd"
      expr: SUM(CAST(cost_per_hour AS DOUBLE))
      comment: "Total hourly infrastructure cost in USD across all game servers - critical for budget management"
    - name: "avg_uptime_pct"
      expr: AVG(CAST(uptime_percentage AS DOUBLE))
      comment: "Average uptime percentage - key reliability metric for service quality"
    - name: "avg_network_bandwidth_mbps"
      expr: AVG(CAST(network_bandwidth_mbps AS DOUBLE))
      comment: "Average network bandwidth in Mbps - indicates network capacity adequacy"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure incident tracking, resolution performance, and business impact metrics for operational excellence"
  source: "`gaming_ecm`.`infrastructure`.`infrastructure_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the infrastructure incident (open, investigating, mitigating, resolved, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (critical, high, medium, low)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for incident analysis and prevention"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the incident"
    - name: "detected_by_source"
      expr: detected_by_source
      comment: "Source that detected the incident (monitoring, user report, automated alert)"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the incident breached SLA commitments"
    - name: "external_communication_flag"
      expr: external_communication_flag
      comment: "Whether external player communication was required"
    - name: "detection_year"
      expr: YEAR(detection_timestamp)
      comment: "Year the incident was detected"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month the incident was detected"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total count of infrastructure incidents"
    - name: "total_ccu_affected"
      expr: SUM(CAST(ccu_affected_count AS BIGINT))
      comment: "Total concurrent users affected by incidents - key player impact metric"
    - name: "total_estimated_revenue_impact_usd"
      expr: SUM(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Total estimated revenue impact in USD from incidents - critical business impact metric for prioritization"
    - name: "avg_estimated_revenue_impact_usd"
      expr: AVG(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Average estimated revenue impact per incident - used for incident severity calibration"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that breached SLA - key service quality metric"
    - name: "avg_ccu_affected_per_incident"
      expr: AVG(CAST(ccu_affected_count AS BIGINT))
      comment: "Average concurrent users affected per incident - indicates incident blast radius"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_matchmaking_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matchmaking performance, wait time, and match quality metrics for player experience optimization"
  source: "`gaming_ecm`.`infrastructure`.`matchmaking_ticket`"
  dimensions:
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current status of the matchmaking ticket (queued, matched, cancelled, expired, failed)"
    - name: "matchmaking_priority"
      expr: matchmaking_priority
      comment: "Priority level assigned to the matchmaking ticket"
    - name: "platform"
      expr: platform
      comment: "Gaming platform for the matchmaking request (PC, console, mobile)"
    - name: "input_method"
      expr: input_method
      comment: "Input method used by the player (keyboard_mouse, controller, touch)"
    - name: "crossplay_enabled_flag"
      expr: crossplay_enabled_flag
      comment: "Whether crossplay is enabled for this matchmaking ticket"
    - name: "voice_chat_enabled_flag"
      expr: voice_chat_enabled_flag
      comment: "Whether voice chat is enabled for this matchmaking ticket"
    - name: "party_leader_flag"
      expr: party_leader_flag
      comment: "Whether this player is the party leader"
    - name: "backfill_eligible_flag"
      expr: backfill_eligible_flag
      comment: "Whether this ticket is eligible for match backfill"
    - name: "submitted_year"
      expr: YEAR(submitted_timestamp)
      comment: "Year the matchmaking ticket was submitted"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the matchmaking ticket was submitted"
  measures:
    - name: "total_matchmaking_tickets"
      expr: COUNT(1)
      comment: "Total count of matchmaking tickets"
    - name: "match_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ticket_status = 'matched' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tickets that successfully matched - key matchmaking effectiveness metric"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ticket_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tickets cancelled by players - indicates player frustration with wait times"
    - name: "avg_match_quality_score"
      expr: AVG(CAST(match_quality_score AS DOUBLE))
      comment: "Average match quality score - critical metric for balanced and fair matchmaking"
    - name: "avg_skill_rating"
      expr: AVG(CAST(skill_rating AS DOUBLE))
      comment: "Average skill rating of players in matchmaking queue"
    - name: "avg_skill_range_width"
      expr: AVG(CAST(skill_range_max AS DOUBLE) - CAST(skill_range_min AS DOUBLE))
      comment: "Average skill range width - indicates matchmaking tolerance and affects match quality"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_network_performance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network performance monitoring, SLA compliance, and infrastructure health metrics for operational excellence"
  source: "`gaming_ecm`.`infrastructure`.`network_performance_event`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of infrastructure component being measured (cdn, game_server, matchmaking, database)"
    - name: "monitoring_source"
      expr: monitoring_source
      comment: "Source system that generated the performance measurement"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure performance (synthetic, real_user, agent)"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform code for the performance measurement"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of SLA breach if applicable"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether this event represents an SLA breach"
    - name: "alert_triggered_flag"
      expr: alert_triggered_flag
      comment: "Whether an operational alert was triggered by this event"
    - name: "fps_impact_flag"
      expr: fps_impact_flag
      comment: "Whether this performance event impacted player FPS"
    - name: "measurement_year"
      expr: YEAR(measurement_timestamp)
      comment: "Year the performance measurement was taken"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month the performance measurement was taken"
  measures:
    - name: "total_performance_events"
      expr: COUNT(1)
      comment: "Total count of network performance measurement events"
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds - critical player experience metric"
    - name: "avg_packet_loss_pct"
      expr: AVG(CAST(packet_loss_percentage AS DOUBLE))
      comment: "Average packet loss percentage - key indicator of network quality issues"
    - name: "avg_jitter_ms"
      expr: AVG(CAST(jitter_ms AS DOUBLE))
      comment: "Average network jitter in milliseconds - affects real-time gameplay smoothness"
    - name: "avg_availability_pct"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average infrastructure availability percentage - key SLA metric"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of performance events that breached SLA - critical service quality metric"
    - name: "avg_cpu_utilization_pct"
      expr: AVG(CAST(cpu_utilization_percentage AS DOUBLE))
      comment: "Average CPU utilization percentage across measured components"
    - name: "avg_memory_utilization_pct"
      expr: AVG(CAST(memory_utilization_percentage AS DOUBLE))
      comment: "Average memory utilization percentage across measured components"
    - name: "avg_throughput_mbps"
      expr: AVG(CAST(throughput_mbps AS DOUBLE))
      comment: "Average network throughput in Mbps - indicates bandwidth adequacy"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_seconds AS BIGINT)) / 3600.0
      comment: "Total downtime in hours - critical availability metric for business impact assessment"
    - name: "total_ccu_affected"
      expr: SUM(CAST(ccu_count AS BIGINT))
      comment: "Total concurrent users affected by performance events"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for telemetry - indicates monitoring reliability"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_server_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game session performance, player engagement, and server utilization metrics for capacity planning and player experience"
  source: "`gaming_ecm`.`infrastructure`.`server_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Current status of the server session (active, completed, terminated, crashed)"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason the session was terminated (normal, timeout, crash, admin)"
    - name: "match_result"
      expr: match_result
      comment: "Result of the match if applicable (win, loss, draw, abandoned)"
    - name: "map_name"
      expr: map_name
      comment: "Name of the game map used in the session"
    - name: "is_private"
      expr: is_private
      comment: "Whether the session is a private match"
    - name: "is_ranked"
      expr: is_ranked
      comment: "Whether the session is a ranked competitive match"
    - name: "session_start_year"
      expr: YEAR(session_start_timestamp)
      comment: "Year the session started"
    - name: "session_start_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month the session started"
  measures:
    - name: "total_server_sessions"
      expr: COUNT(1)
      comment: "Total count of server sessions"
    - name: "avg_session_fps"
      expr: AVG(CAST(average_fps AS DOUBLE))
      comment: "Average frames per second across sessions - critical player experience quality metric"
    - name: "avg_session_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds - key performance indicator for gameplay quality"
    - name: "avg_packet_loss_pct"
      expr: AVG(CAST(packet_loss_percent AS DOUBLE))
      comment: "Average packet loss percentage - indicates network quality issues affecting gameplay"
    - name: "avg_cpu_utilization_pct"
      expr: AVG(CAST(cpu_utilization_percent AS DOUBLE))
      comment: "Average CPU utilization percentage - used for server capacity planning"
    - name: "avg_memory_utilization_pct"
      expr: AVG(CAST(memory_utilization_percent AS DOUBLE))
      comment: "Average memory utilization percentage - indicates when vertical scaling is needed"
    - name: "avg_player_count"
      expr: AVG(CAST(average_player_count AS DOUBLE))
      comment: "Average player count per session - key engagement metric"
    - name: "server_capacity_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(average_player_count AS DOUBLE)) / NULLIF(AVG(CAST(max_player_capacity AS DOUBLE)), 0), 2)
      comment: "Average server capacity utilization percentage - critical for capacity planning and cost optimization"
    - name: "total_bandwidth_gb"
      expr: SUM(CAST(total_bandwidth_mb AS DOUBLE)) / 1024.0
      comment: "Total bandwidth consumed in gigabytes - used for network capacity planning and cost management"
    - name: "crash_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN termination_reason = 'crash' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that crashed - critical stability metric affecting player satisfaction"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_server_fleet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Server fleet capacity, performance, cost efficiency, and operational health metrics for infrastructure management"
  source: "`gaming_ecm`.`infrastructure`.`server_fleet`"
  dimensions:
    - name: "fleet_status"
      expr: fleet_status
      comment: "Current operational status of the server fleet (active, scaling, maintenance, decommissioned)"
    - name: "deployment_tier"
      expr: deployment_tier
      comment: "Deployment tier classification (production, staging, development)"
    - name: "cloud_provider"
      expr: cloud_provider
      comment: "Cloud infrastructure provider (AWS, Azure, GCP)"
    - name: "instance_type"
      expr: instance_type
      comment: "Cloud instance type used by the fleet"
    - name: "health_check_status"
      expr: health_check_status
      comment: "Latest health check status of the fleet"
    - name: "is_active"
      expr: is_active
      comment: "Whether the fleet is currently active"
    - name: "owner_team"
      expr: owner_team
      comment: "Team responsible for managing the fleet"
    - name: "deployment_year"
      expr: YEAR(deployment_timestamp)
      comment: "Year the fleet was deployed"
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', deployment_timestamp)
      comment: "Month the fleet was deployed"
  measures:
    - name: "total_server_fleets"
      expr: COUNT(1)
      comment: "Total count of server fleets"
    - name: "avg_fleet_fps"
      expr: AVG(CAST(average_fps AS DOUBLE))
      comment: "Average frames per second across fleets - key player experience quality metric"
    - name: "avg_fleet_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds - critical performance indicator"
    - name: "total_hourly_fleet_cost_usd"
      expr: SUM(CAST(cost_per_hour AS DOUBLE))
      comment: "Total hourly cost in USD across all fleets - critical for infrastructure budget management"
    - name: "avg_uptime_pct"
      expr: AVG(CAST(uptime_percentage AS DOUBLE))
      comment: "Average uptime percentage - key reliability and SLA metric"
    - name: "fleet_capacity_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(current_instance_count AS DOUBLE)) / NULLIF(SUM(CAST(max_instance_count AS DOUBLE)), 0), 2)
      comment: "Fleet capacity utilization percentage - critical for autoscaling decisions and cost optimization"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_cloud_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cloud resource provisioning, cost management, and utilization metrics for infrastructure optimization"
  source: "`gaming_ecm`.`infrastructure`.`cloud_resource`"
  dimensions:
    - name: "resource_type"
      expr: resource_type
      comment: "Type of cloud resource (compute, storage, network, database)"
    - name: "cloud_provider"
      expr: cloud_provider
      comment: "Cloud infrastructure provider (AWS, Azure, GCP)"
    - name: "provisioning_status"
      expr: provisioning_status
      comment: "Current provisioning status (active, pending, terminated, failed)"
    - name: "lifecycle_state"
      expr: lifecycle_state
      comment: "Lifecycle state of the resource"
    - name: "environment"
      expr: environment
      comment: "Environment classification (production, staging, development, test)"
    - name: "instance_family"
      expr: instance_family
      comment: "Cloud instance family classification"
    - name: "instance_size"
      expr: instance_size
      comment: "Cloud instance size (small, medium, large, xlarge)"
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system running on the resource"
    - name: "auto_scaling_enabled"
      expr: auto_scaling_enabled
      comment: "Whether auto-scaling is enabled for this resource"
    - name: "backup_enabled"
      expr: backup_enabled
      comment: "Whether backup is enabled for this resource"
    - name: "monitoring_enabled"
      expr: monitoring_enabled
      comment: "Whether monitoring is enabled for this resource"
    - name: "provisioned_year"
      expr: YEAR(provisioned_timestamp)
      comment: "Year the resource was provisioned"
    - name: "provisioned_month"
      expr: DATE_TRUNC('MONTH', provisioned_timestamp)
      comment: "Month the resource was provisioned"
  measures:
    - name: "total_cloud_resources"
      expr: COUNT(1)
      comment: "Total count of cloud resources"
    - name: "total_monthly_cloud_cost_usd"
      expr: SUM(CAST(monthly_cost_rate AS DOUBLE))
      comment: "Total monthly cloud cost in USD - critical for infrastructure budget management and cost optimization"
    - name: "total_cumulative_spend_usd"
      expr: SUM(CAST(cumulative_spend AS DOUBLE))
      comment: "Total cumulative spend in USD across all resources - key financial metric for TCO analysis"
    - name: "avg_monthly_cost_per_resource_usd"
      expr: AVG(CAST(monthly_cost_rate AS DOUBLE))
      comment: "Average monthly cost per resource in USD - used for cost benchmarking"
    - name: "total_cpu_cores"
      expr: SUM(CAST(cpu_cores AS DOUBLE))
      comment: "Total CPU cores provisioned across all resources"
    - name: "total_memory_gb"
      expr: SUM(CAST(memory_gb AS DOUBLE))
      comment: "Total memory in GB provisioned across all resources"
    - name: "total_storage_gb"
      expr: SUM(CAST(storage_gb AS DOUBLE))
      comment: "Total storage in GB provisioned across all resources"
    - name: "avg_uptime_sla_pct"
      expr: AVG(CAST(uptime_sla_percent AS DOUBLE))
      comment: "Average uptime SLA percentage - key service quality metric"
    - name: "avg_network_bandwidth_gbps"
      expr: AVG(CAST(network_bandwidth_gbps AS DOUBLE))
      comment: "Average network bandwidth in Gbps - indicates network capacity"
$$;