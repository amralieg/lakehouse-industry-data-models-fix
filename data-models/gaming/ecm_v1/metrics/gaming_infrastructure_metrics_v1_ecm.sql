-- Metric views for domain: infrastructure | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core incident management KPIs tracking service disruptions, resolution performance, SLA compliance, and business impact across gaming infrastructure"
  source: "`gaming_ecm`.`infrastructure`.`infrastructure_incident`"
  dimensions:
    - name: "incident_severity"
      expr: severity_level
      comment: "Severity classification of the infrastructure incident (critical, high, medium, low)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, acknowledged, investigating, resolved, closed)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of the root cause (hardware, software, network, configuration, capacity, external)"
    - name: "affected_service"
      expr: affected_service_component
      comment: "Service or component affected by the incident"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the incident breached SLA commitments"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month when the incident was detected"
    - name: "detection_week"
      expr: DATE_TRUNC('WEEK', detection_timestamp)
      comment: "Week when the incident was detected"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier of the incident (L1, L2, L3, executive)"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of infrastructure incidents"
    - name: "total_ccu_affected"
      expr: SUM(CAST(ccu_affected_count AS BIGINT))
      comment: "Total concurrent users affected across all incidents"
    - name: "total_revenue_impact_usd"
      expr: SUM(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Total estimated revenue impact in USD from infrastructure incidents"
    - name: "avg_resolution_minutes"
      expr: AVG(CAST(actual_resolution_minutes AS DOUBLE))
      comment: "Average time to resolve incidents in minutes"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents that breached SLA commitments"
    - name: "avg_ccu_affected_per_incident"
      expr: AVG(CAST(ccu_affected_count AS DOUBLE))
      comment: "Average concurrent users affected per incident"
    - name: "critical_incident_count"
      expr: SUM(CASE WHEN severity_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity incidents"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_game_server`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game server performance and utilization KPIs tracking capacity, player load, latency, and operational efficiency across server fleet"
  source: "`gaming_ecm`.`infrastructure`.`game_server`"
  dimensions:
    - name: "server_status"
      expr: server_status
      comment: "Current operational status of the game server (active, idle, provisioning, terminated, maintenance)"
    - name: "server_type"
      expr: server_type
      comment: "Type classification of the game server (dedicated, shared, spot, reserved)"
    - name: "game_mode"
      expr: game_mode
      comment: "Game mode hosted on the server (battle royale, team deathmatch, co-op, etc.)"
    - name: "capacity_tier"
      expr: capacity_tier
      comment: "Capacity tier of the server (small, medium, large, xlarge)"
    - name: "health_status"
      expr: health_check_status
      comment: "Health check status of the server (healthy, degraded, unhealthy)"
    - name: "provisioned_month"
      expr: DATE_TRUNC('MONTH', provisioned_timestamp)
      comment: "Month when the server was provisioned"
    - name: "availability_zone"
      expr: availability_zone
      comment: "Cloud availability zone where the server is deployed"
  measures:
    - name: "total_servers"
      expr: COUNT(1)
      comment: "Total number of game servers"
    - name: "total_current_players"
      expr: SUM(CAST(current_player_count AS BIGINT))
      comment: "Total current players across all game servers"
    - name: "total_max_capacity"
      expr: SUM(CAST(max_player_capacity AS BIGINT))
      comment: "Total maximum player capacity across all game servers"
    - name: "avg_cpu_utilization_pct"
      expr: AVG(CAST(cpu_utilization_pct AS DOUBLE))
      comment: "Average CPU utilization percentage across game servers"
    - name: "avg_memory_utilization_pct"
      expr: AVG(CAST(memory_utilization_pct AS DOUBLE))
      comment: "Average memory utilization percentage across game servers"
    - name: "avg_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds across game servers"
    - name: "avg_fps"
      expr: AVG(CAST(average_fps AS DOUBLE))
      comment: "Average frames per second performance across game servers"
    - name: "total_hourly_cost"
      expr: SUM(CAST(cost_per_hour AS DOUBLE))
      comment: "Total hourly operating cost across all game servers in USD"
    - name: "active_server_count"
      expr: SUM(CASE WHEN server_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of servers in active operational status"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_matchmaking_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matchmaking performance KPIs tracking queue times, match quality, success rates, and player experience across matchmaking system"
  source: "`gaming_ecm`.`infrastructure`.`matchmaking_ticket`"
  dimensions:
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current status of the matchmaking ticket (queued, matched, cancelled, expired, failed)"
    - name: "game_mode"
      expr: game_mode
      comment: "Game mode requested for matchmaking"
    - name: "platform"
      expr: platform
      comment: "Gaming platform of the player (PC, PlayStation, Xbox, Switch, Mobile)"
    - name: "matchmaking_priority"
      expr: matchmaking_priority
      comment: "Priority tier of the matchmaking request (standard, premium, VIP)"
    - name: "crossplay_enabled"
      expr: crossplay_enabled_flag
      comment: "Whether crossplay was enabled for this matchmaking request"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month when the matchmaking ticket was submitted"
    - name: "submitted_hour"
      expr: DATE_TRUNC('HOUR', submitted_timestamp)
      comment: "Hour when the matchmaking ticket was submitted"
  measures:
    - name: "total_tickets"
      expr: COUNT(1)
      comment: "Total number of matchmaking tickets submitted"
    - name: "matched_ticket_count"
      expr: SUM(CASE WHEN ticket_status = 'matched' THEN 1 ELSE 0 END)
      comment: "Count of tickets that successfully matched into a game"
    - name: "cancelled_ticket_count"
      expr: SUM(CASE WHEN ticket_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of tickets cancelled by players before matching"
    - name: "expired_ticket_count"
      expr: SUM(CASE WHEN ticket_status = 'expired' THEN 1 ELSE 0 END)
      comment: "Count of tickets that expired due to timeout"
    - name: "avg_wait_duration_seconds"
      expr: AVG(CAST(wait_duration_seconds AS DOUBLE))
      comment: "Average wait time in seconds from submission to match"
    - name: "avg_match_quality_score"
      expr: AVG(CAST(match_quality_score AS DOUBLE))
      comment: "Average match quality score (skill balance, latency, party composition)"
    - name: "avg_skill_rating"
      expr: AVG(CAST(skill_rating AS DOUBLE))
      comment: "Average skill rating of players in matchmaking queue"
    - name: "avg_retry_count"
      expr: AVG(CAST(retry_count AS DOUBLE))
      comment: "Average number of retry attempts per matchmaking ticket"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_server_fleet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Server fleet capacity and efficiency KPIs tracking utilization, cost, performance, and availability across fleet deployments"
  source: "`gaming_ecm`.`infrastructure`.`server_fleet`"
  dimensions:
    - name: "fleet_status"
      expr: fleet_status
      comment: "Current operational status of the server fleet (active, scaling, maintenance, decommissioned)"
    - name: "deployment_tier"
      expr: deployment_tier
      comment: "Deployment tier of the fleet (production, staging, development, test)"
    - name: "game_mode"
      expr: game_mode
      comment: "Primary game mode served by the fleet"
    - name: "cloud_provider"
      expr: cloud_provider
      comment: "Cloud infrastructure provider (AWS, Azure, GCP, on-premise)"
    - name: "instance_type"
      expr: instance_type
      comment: "Instance type specification of the fleet servers"
    - name: "is_active"
      expr: is_active
      comment: "Whether the fleet is currently active and serving traffic"
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', deployment_timestamp)
      comment: "Month when the fleet was deployed"
  measures:
    - name: "total_fleets"
      expr: COUNT(1)
      comment: "Total number of server fleets"
    - name: "total_current_ccu"
      expr: SUM(CAST(current_ccu AS BIGINT))
      comment: "Total current concurrent users across all fleets"
    - name: "total_current_instances"
      expr: SUM(CAST(current_instance_count AS BIGINT))
      comment: "Total current server instances across all fleets"
    - name: "total_hourly_cost"
      expr: SUM(CAST(cost_per_hour AS DOUBLE))
      comment: "Total hourly operating cost across all fleets in USD"
    - name: "avg_uptime_percentage"
      expr: AVG(CAST(uptime_percentage AS DOUBLE))
      comment: "Average uptime percentage across server fleets"
    - name: "avg_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds across fleets"
    - name: "avg_fps"
      expr: AVG(CAST(average_fps AS DOUBLE))
      comment: "Average frames per second performance across fleets"
    - name: "total_incidents"
      expr: SUM(CAST(incident_count AS BIGINT))
      comment: "Total incident count across all server fleets"
    - name: "active_fleet_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fleets currently active and serving traffic"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_cdn_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CDN performance and efficiency KPIs tracking bandwidth utilization, cache effectiveness, latency, and cost across content delivery network"
  source: "`gaming_ecm`.`infrastructure`.`cdn_node`"
  dimensions:
    - name: "node_status"
      expr: cdn_node_status
      comment: "Current operational status of the CDN node (active, maintenance, degraded, offline)"
    - name: "node_type"
      expr: node_type
      comment: "Type classification of the CDN node (edge, origin, shield)"
    - name: "provider_name"
      expr: provider_name
      comment: "CDN provider operating the node (Akamai, Cloudflare, AWS CloudFront, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the CDN node is located"
    - name: "compression_enabled"
      expr: compression_enabled
      comment: "Whether compression is enabled on the CDN node"
    - name: "drm_enabled"
      expr: drm_enabled
      comment: "Whether DRM (Digital Rights Management) is enabled on the node"
    - name: "activated_month"
      expr: DATE_TRUNC('MONTH', activated_date)
      comment: "Month when the CDN node was activated"
  measures:
    - name: "total_cdn_nodes"
      expr: COUNT(1)
      comment: "Total number of CDN nodes"
    - name: "total_bandwidth_used_tb"
      expr: SUM(CAST(monthly_bandwidth_used_tb AS DOUBLE))
      comment: "Total bandwidth used in terabytes across all CDN nodes"
    - name: "total_bandwidth_quota_tb"
      expr: SUM(CAST(monthly_bandwidth_quota_tb AS DOUBLE))
      comment: "Total bandwidth quota in terabytes across all CDN nodes"
    - name: "total_storage_used_tb"
      expr: SUM(CAST(cache_storage_used_tb AS DOUBLE))
      comment: "Total cache storage used in terabytes across all CDN nodes"
    - name: "avg_cache_hit_ratio_pct"
      expr: AVG(CAST(cache_hit_ratio_percentage AS DOUBLE))
      comment: "Average cache hit ratio percentage across CDN nodes"
    - name: "avg_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average latency in milliseconds across CDN nodes"
    - name: "total_concurrent_connections"
      expr: SUM(CAST(current_concurrent_connections AS BIGINT))
      comment: "Total current concurrent connections across all CDN nodes"
    - name: "avg_cost_per_gb_usd"
      expr: AVG(CAST(cost_per_gb_usd AS DOUBLE))
      comment: "Average cost per gigabyte in USD across CDN nodes"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning KPIs tracking forecast accuracy, cost variance, scaling effectiveness, and resource optimization across infrastructure"
  source: "`gaming_ecm`.`infrastructure`.`capacity_plan`"
  dimensions:
    - name: "plan_status"
      expr: capacity_plan_status
      comment: "Current status of the capacity plan (draft, submitted, approved, active, completed, cancelled)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan (seasonal, event-driven, growth, optimization, emergency)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the capacity plan (pending, approved, rejected)"
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance associated with the plan (preventive, corrective, upgrade, migration)"
    - name: "player_impact_level"
      expr: player_impact_level
      comment: "Expected player impact level (none, low, medium, high, critical)"
    - name: "planning_year"
      expr: YEAR(planning_horizon_start_date)
      comment: "Year of the capacity planning horizon start"
    - name: "planning_quarter"
      expr: DATE_TRUNC('QUARTER', planning_horizon_start_date)
      comment: "Quarter of the capacity planning horizon start"
  measures:
    - name: "total_capacity_plans"
      expr: COUNT(1)
      comment: "Total number of capacity plans"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost in USD across all capacity plans"
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost in USD across all capacity plans"
    - name: "total_forecasted_peak_ccu"
      expr: SUM(CAST(forecasted_peak_ccu AS BIGINT))
      comment: "Total forecasted peak concurrent users across all capacity plans"
    - name: "total_forecasted_peak_pcu"
      expr: SUM(CAST(forecasted_peak_pcu AS BIGINT))
      comment: "Total forecasted peak player count across all capacity plans"
    - name: "avg_scaling_headroom_pct"
      expr: AVG(CAST(scaling_headroom_percentage AS DOUBLE))
      comment: "Average scaling headroom percentage planned for capacity buffer"
    - name: "avg_autoscaling_trigger_threshold_pct"
      expr: AVG(CAST(autoscaling_trigger_threshold_percentage AS DOUBLE))
      comment: "Average autoscaling trigger threshold percentage"
    - name: "approved_plan_count"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved capacity plans"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_security_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security incident KPIs tracking threat detection, response time, attack impact, and security posture across gaming infrastructure"
  source: "`gaming_ecm`.`infrastructure`.`security_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the security event (detected, investigating, mitigating, resolved, closed)"
    - name: "event_type"
      expr: event_type
      comment: "Type of security event (DDoS, intrusion, malware, data breach, unauthorized access, vulnerability exploit)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the security event (critical, high, medium, low, informational)"
    - name: "attack_vector"
      expr: attack_vector
      comment: "Attack vector used in the security event (network, application, social engineering, physical)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the security event (configuration, vulnerability, credential compromise, zero-day)"
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Whether the security event was determined to be a false positive"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the security event response breached SLA commitments"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month when the security event was detected"
  measures:
    - name: "total_security_events"
      expr: COUNT(1)
      comment: "Total number of security events detected"
    - name: "total_ccu_affected"
      expr: SUM(CAST(ccu_affected AS BIGINT))
      comment: "Total concurrent users affected by security events"
    - name: "total_revenue_impact_usd"
      expr: SUM(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Total estimated revenue impact in USD from security events"
    - name: "total_service_downtime_minutes"
      expr: SUM(CAST(service_downtime_minutes AS DOUBLE))
      comment: "Total service downtime in minutes caused by security events"
    - name: "avg_peak_attack_volume_gbps"
      expr: AVG(CAST(peak_attack_volume_gbps AS DOUBLE))
      comment: "Average peak attack volume in gigabits per second"
    - name: "avg_latency_spike_ms"
      expr: AVG(CAST(latency_spike_ms AS DOUBLE))
      comment: "Average latency spike in milliseconds during security events"
    - name: "critical_event_count"
      expr: SUM(CASE WHEN severity_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity security events"
    - name: "false_positive_count"
      expr: SUM(CASE WHEN false_positive_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of security events determined to be false positives"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of security events that breached response SLA"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_network_performance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network performance KPIs tracking latency, packet loss, throughput, availability, and SLA compliance across gaming network infrastructure"
  source: "`gaming_ecm`.`infrastructure`.`network_performance_event`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of network component measured (CDN, game server, matchmaking, load balancer, gateway)"
    - name: "platform_code"
      expr: platform_code
      comment: "Gaming platform code for the performance measurement"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the performance event breached SLA thresholds"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the SLA breach (critical, major, minor)"
    - name: "alert_triggered_flag"
      expr: alert_triggered_flag
      comment: "Whether an alert was triggered for this performance event"
    - name: "fps_impact_flag"
      expr: fps_impact_flag
      comment: "Whether the performance event impacted frames per second"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when the performance measurement was taken"
    - name: "measurement_hour"
      expr: DATE_TRUNC('HOUR', measurement_timestamp)
      comment: "Hour when the performance measurement was taken"
  measures:
    - name: "total_performance_events"
      expr: COUNT(1)
      comment: "Total number of network performance events recorded"
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds"
    - name: "avg_packet_loss_pct"
      expr: AVG(CAST(packet_loss_percentage AS DOUBLE))
      comment: "Average packet loss percentage"
    - name: "avg_jitter_ms"
      expr: AVG(CAST(jitter_ms AS DOUBLE))
      comment: "Average network jitter in milliseconds"
    - name: "avg_throughput_mbps"
      expr: AVG(CAST(throughput_mbps AS DOUBLE))
      comment: "Average network throughput in megabits per second"
    - name: "avg_availability_pct"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average availability percentage"
    - name: "avg_cpu_utilization_pct"
      expr: AVG(CAST(cpu_utilization_percentage AS DOUBLE))
      comment: "Average CPU utilization percentage during performance events"
    - name: "avg_memory_utilization_pct"
      expr: AVG(CAST(memory_utilization_percentage AS DOUBLE))
      comment: "Average memory utilization percentage during performance events"
    - name: "total_downtime_seconds"
      expr: SUM(CAST(downtime_seconds AS BIGINT))
      comment: "Total downtime in seconds across all performance events"
    - name: "total_error_count"
      expr: SUM(CAST(error_count AS BIGINT))
      comment: "Total error count across all performance events"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of performance events that breached SLA thresholds"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`infrastructure_cicd_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CI/CD pipeline KPIs tracking deployment velocity, success rates, quality gates, and build efficiency across infrastructure automation"
  source: "`gaming_ecm`.`infrastructure`.`cicd_pipeline`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the pipeline run (success, failed, cancelled, in-progress, queued)"
    - name: "target_environment"
      expr: target_environment
      comment: "Target deployment environment (production, staging, development, test)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "Type of trigger that initiated the pipeline (manual, scheduled, webhook, commit, pull-request)"
    - name: "deployment_approval_status"
      expr: deployment_approval_status
      comment: "Approval status for deployment (pending, approved, rejected, auto-approved)"
    - name: "quality_gate_passed"
      expr: quality_gate_passed
      comment: "Whether the pipeline passed quality gate checks"
    - name: "security_scan_status"
      expr: security_scan_status
      comment: "Status of security scan in the pipeline (passed, failed, skipped, warning)"
    - name: "pipeline_priority"
      expr: pipeline_priority
      comment: "Priority level of the pipeline execution (critical, high, normal, low)"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when the pipeline run started"
  measures:
    - name: "total_pipeline_runs"
      expr: COUNT(1)
      comment: "Total number of CI/CD pipeline runs"
    - name: "successful_run_count"
      expr: SUM(CASE WHEN run_status = 'success' THEN 1 ELSE 0 END)
      comment: "Count of successful pipeline runs"
    - name: "failed_run_count"
      expr: SUM(CASE WHEN run_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed pipeline runs"
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average pipeline execution duration in seconds"
    - name: "avg_test_coverage_pct"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage across pipeline runs"
    - name: "quality_gate_pass_count"
      expr: SUM(CASE WHEN quality_gate_passed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of pipeline runs that passed quality gates"
    - name: "avg_retry_count"
      expr: AVG(CAST(retry_count AS DOUBLE))
      comment: "Average number of retry attempts per pipeline run"
    - name: "total_stages_passed"
      expr: SUM(CAST(stages_passed AS BIGINT))
      comment: "Total number of pipeline stages passed across all runs"
    - name: "total_stages_failed"
      expr: SUM(CAST(stages_failed AS BIGINT))
      comment: "Total number of pipeline stages failed across all runs"
$$;