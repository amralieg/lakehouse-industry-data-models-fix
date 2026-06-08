-- Metric views for domain: security | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`security_access_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access control and entry/exit event metrics for venue security monitoring, credential validation, and occupancy tracking"
  source: "`sports_entertainment_ecm`.`security`.`access_event`"
  dimensions:
    - name: "access_direction"
      expr: access_direction
      comment: "Direction of access movement (entry, exit, lateral)"
    - name: "scan_result"
      expr: scan_result
      comment: "Outcome of the access scan (granted, denied, override)"
    - name: "checkpoint_name"
      expr: checkpoint_name
      comment: "Name of the security checkpoint where scan occurred"
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential used for access"
    - name: "credential_holder_category"
      expr: credential_holder_category
      comment: "Category of person holding the credential (staff, fan, vendor, media)"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code when access was denied"
    - name: "event_phase"
      expr: event_phase
      comment: "Phase of event during access (pre-event, during, post-event)"
    - name: "scan_date"
      expr: DATE(scan_timestamp)
      comment: "Date of access scan"
    - name: "scan_hour"
      expr: HOUR(scan_timestamp)
      comment: "Hour of day when scan occurred"
    - name: "biometric_verified_flag"
      expr: biometric_verified_flag
      comment: "Whether biometric verification was used"
    - name: "officer_override_flag"
      expr: officer_override_flag
      comment: "Whether a security officer manually overrode the system"
    - name: "watchlist_match_flag"
      expr: watchlist_match_flag
      comment: "Whether the credential matched a security watchlist"
    - name: "duplicate_scan_flag"
      expr: duplicate_scan_flag
      comment: "Whether this was a duplicate scan attempt"
  measures:
    - name: "total_access_events"
      expr: COUNT(1)
      comment: "Total number of access scan events"
    - name: "denied_access_count"
      expr: COUNT(CASE WHEN scan_result = 'denied' THEN 1 END)
      comment: "Number of access attempts that were denied"
    - name: "access_denial_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN scan_result = 'denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access attempts that were denied"
    - name: "officer_override_count"
      expr: COUNT(CASE WHEN officer_override_flag = True THEN 1 END)
      comment: "Number of access events requiring officer override"
    - name: "officer_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN officer_override_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access events requiring manual officer intervention"
    - name: "watchlist_match_count"
      expr: COUNT(CASE WHEN watchlist_match_flag = True THEN 1 END)
      comment: "Number of access attempts matching security watchlist"
    - name: "biometric_verification_count"
      expr: COUNT(CASE WHEN biometric_verified_flag = True THEN 1 END)
      comment: "Number of access events using biometric verification"
    - name: "unique_credentials_scanned"
      expr: COUNT(DISTINCT credential_id)
      comment: "Distinct count of credentials used for access"
    - name: "unique_checkpoints_used"
      expr: COUNT(DISTINCT checkpoint_name)
      comment: "Distinct count of checkpoints processing access events"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security incident tracking and response metrics for venue safety, threat management, and law enforcement coordination"
  source: "`sports_entertainment_ecm`.`security`.`security_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of security incident (assault, theft, trespass, medical, etc.)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of incident (open, investigating, closed)"
    - name: "severity_tier"
      expr: severity_tier
      comment: "Severity classification of the incident"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the incident"
    - name: "incident_date"
      expr: DATE(occurred_at)
      comment: "Date when incident occurred"
    - name: "incident_hour"
      expr: HOUR(occurred_at)
      comment: "Hour of day when incident occurred"
    - name: "law_enforcement_notified"
      expr: law_enforcement_notified
      comment: "Whether law enforcement was notified"
    - name: "evacuation_triggered"
      expr: evacuation_triggered
      comment: "Whether incident triggered evacuation"
    - name: "ban_issued"
      expr: ban_issued
      comment: "Whether a venue ban was issued as result"
    - name: "medical_referral_required"
      expr: medical_referral_required
      comment: "Whether medical assistance was required"
    - name: "surveillance_footage_available"
      expr: surveillance_footage_available
      comment: "Whether surveillance footage is available for review"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of security incidents reported"
    - name: "high_severity_incidents"
      expr: COUNT(CASE WHEN severity_tier IN ('Critical', 'High') THEN 1 END)
      comment: "Number of critical or high severity incidents"
    - name: "high_severity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity_tier IN ('Critical', 'High') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents classified as high or critical severity"
    - name: "law_enforcement_notification_count"
      expr: COUNT(CASE WHEN law_enforcement_notified = True THEN 1 END)
      comment: "Number of incidents requiring law enforcement notification"
    - name: "law_enforcement_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN law_enforcement_notified = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents escalated to law enforcement"
    - name: "evacuation_trigger_count"
      expr: COUNT(CASE WHEN evacuation_triggered = True THEN 1 END)
      comment: "Number of incidents that triggered evacuation procedures"
    - name: "ban_issuance_count"
      expr: COUNT(CASE WHEN ban_issued = True THEN 1 END)
      comment: "Number of incidents resulting in venue ban"
    - name: "medical_referral_count"
      expr: COUNT(CASE WHEN medical_referral_required = True THEN 1 END)
      comment: "Number of incidents requiring medical assistance"
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average response time in minutes from report to first response"
    - name: "unique_involved_persons"
      expr: COUNT(DISTINCT involved_party_name)
      comment: "Distinct count of persons involved in incidents"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`security_screening_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security screening throughput, efficiency, and threat detection metrics for checkpoint operations and prohibited item confiscation"
  source: "`sports_entertainment_ecm`.`security`.`screening_event`"
  dimensions:
    - name: "screening_outcome"
      expr: screening_outcome
      comment: "Result of screening (cleared, denied, escalated)"
    - name: "screening_method"
      expr: screening_method
      comment: "Method used for screening (magnetometer, manual, x-ray)"
    - name: "gate_number"
      expr: gate_number
      comment: "Gate number where screening occurred"
    - name: "lane_number"
      expr: lane_number
      comment: "Screening lane number"
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential presented for screening"
    - name: "screened_person_type"
      expr: screened_person_type
      comment: "Category of person screened (fan, staff, vendor)"
    - name: "screening_date"
      expr: DATE(screening_timestamp)
      comment: "Date of screening event"
    - name: "screening_hour"
      expr: HOUR(screening_timestamp)
      comment: "Hour of day when screening occurred"
    - name: "prohibited_item_flag"
      expr: prohibited_item_flag
      comment: "Whether a prohibited item was detected"
    - name: "item_confiscated_flag"
      expr: item_confiscated_flag
      comment: "Whether an item was confiscated"
    - name: "equipment_alarm_triggered_flag"
      expr: equipment_alarm_triggered_flag
      comment: "Whether screening equipment triggered an alarm"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether screening was escalated to supervisor or law enforcement"
    - name: "law_enforcement_notified_flag"
      expr: law_enforcement_notified_flag
      comment: "Whether law enforcement was notified"
    - name: "prohibited_item_category"
      expr: prohibited_item_category
      comment: "Category of prohibited item detected"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of screening events conducted"
    - name: "prohibited_item_detections"
      expr: COUNT(CASE WHEN prohibited_item_flag = True THEN 1 END)
      comment: "Number of screenings where prohibited items were detected"
    - name: "prohibited_item_detection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN prohibited_item_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings detecting prohibited items"
    - name: "confiscation_count"
      expr: COUNT(CASE WHEN item_confiscated_flag = True THEN 1 END)
      comment: "Number of screenings resulting in item confiscation"
    - name: "confiscation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN item_confiscated_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in confiscation"
    - name: "equipment_alarm_count"
      expr: COUNT(CASE WHEN equipment_alarm_triggered_flag = True THEN 1 END)
      comment: "Number of screenings triggering equipment alarms"
    - name: "alarm_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN equipment_alarm_triggered_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings triggering equipment alarms"
    - name: "escalation_count"
      expr: COUNT(CASE WHEN escalation_flag = True THEN 1 END)
      comment: "Number of screenings escalated to supervisor or law enforcement"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings requiring escalation"
    - name: "avg_screening_duration_seconds"
      expr: AVG(CAST(screening_duration_seconds AS DOUBLE))
      comment: "Average duration of screening process in seconds"
    - name: "avg_queue_wait_time_seconds"
      expr: AVG(CAST(queue_wait_time_seconds AS DOUBLE))
      comment: "Average queue wait time before screening in seconds"
    - name: "unique_gates_active"
      expr: COUNT(DISTINCT gate_number)
      comment: "Distinct count of gates conducting screenings"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`security_occupancy_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time venue occupancy monitoring and capacity management metrics for crowd safety and emergency response"
  source: "`sports_entertainment_ecm`.`security`.`occupancy_snapshot`"
  dimensions:
    - name: "zone_name"
      expr: zone_name
      comment: "Name of the venue zone being monitored"
    - name: "zone_type"
      expr: zone_type
      comment: "Type of venue zone (seating, concourse, VIP, etc.)"
    - name: "event_phase"
      expr: event_phase
      comment: "Phase of event during snapshot (pre-event, during, post-event)"
    - name: "crowd_density_category"
      expr: crowd_density_category
      comment: "Categorization of crowd density (low, moderate, high, critical)"
    - name: "occupancy_trend"
      expr: occupancy_trend
      comment: "Trend direction of occupancy (increasing, stable, decreasing)"
    - name: "snapshot_date"
      expr: DATE(snapshot_timestamp)
      comment: "Date of occupancy snapshot"
    - name: "snapshot_hour"
      expr: HOUR(snapshot_timestamp)
      comment: "Hour of day when snapshot was taken"
    - name: "capacity_alert_flag"
      expr: capacity_alert_flag
      comment: "Whether occupancy triggered a capacity alert"
    - name: "incident_flag"
      expr: incident_flag
      comment: "Whether an incident was occurring during snapshot"
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of capacity alert if triggered"
    - name: "security_level"
      expr: security_level
      comment: "Security posture level during snapshot"
    - name: "law_enforcement_present"
      expr: law_enforcement_present
      comment: "Whether law enforcement was present in zone"
  measures:
    - name: "total_snapshots"
      expr: COUNT(1)
      comment: "Total number of occupancy snapshots recorded"
    - name: "avg_occupancy_count"
      expr: AVG(CAST(current_occupancy_count AS DOUBLE))
      comment: "Average occupancy count across snapshots"
    - name: "avg_occupancy_pct"
      expr: AVG(CAST(occupancy_pct AS DOUBLE))
      comment: "Average occupancy as percentage of max capacity"
    - name: "max_occupancy_count"
      expr: MAX(CAST(current_occupancy_count AS DOUBLE))
      comment: "Peak occupancy count observed"
    - name: "capacity_alert_count"
      expr: COUNT(CASE WHEN capacity_alert_flag = True THEN 1 END)
      comment: "Number of snapshots triggering capacity alerts"
    - name: "capacity_alert_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capacity_alert_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of snapshots triggering capacity alerts"
    - name: "high_density_snapshot_count"
      expr: COUNT(CASE WHEN crowd_density_category IN ('High', 'Critical') THEN 1 END)
      comment: "Number of snapshots with high or critical crowd density"
    - name: "incident_concurrent_count"
      expr: COUNT(CASE WHEN incident_flag = True THEN 1 END)
      comment: "Number of snapshots with concurrent security incidents"
    - name: "avg_ingress_count"
      expr: AVG(CAST(ingress_count AS DOUBLE))
      comment: "Average number of people entering zone per snapshot interval"
    - name: "avg_egress_count"
      expr: AVG(CAST(egress_count AS DOUBLE))
      comment: "Average number of people exiting zone per snapshot interval"
    - name: "unique_zones_monitored"
      expr: COUNT(DISTINCT zone_name)
      comment: "Distinct count of zones with occupancy monitoring"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`security_venue_ban`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Venue ban enforcement and compliance metrics for patron safety, repeat offender tracking, and appeal management"
  source: "`sports_entertainment_ecm`.`security`.`venue_ban`"
  dimensions:
    - name: "ban_type"
      expr: ban_type
      comment: "Type of ban imposed (temporary, permanent, conditional)"
    - name: "ban_status"
      expr: ban_status
      comment: "Current status of ban (active, expired, appealed, overturned)"
    - name: "ban_reason_category"
      expr: ban_reason_category
      comment: "Category of violation leading to ban"
    - name: "enforcement_scope"
      expr: enforcement_scope
      comment: "Scope of ban enforcement (single venue, franchise, league-wide)"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of ban appeal if filed"
    - name: "ban_issued_date"
      expr: DATE(ban_issued_timestamp)
      comment: "Date when ban was issued"
    - name: "ban_start_date"
      expr: ban_start_date
      comment: "Effective start date of ban"
    - name: "ban_end_date"
      expr: ban_end_date
      comment: "Scheduled end date of ban"
    - name: "appeal_lodged_flag"
      expr: CASE WHEN appeal_lodged_date IS NOT NULL THEN True ELSE False END
      comment: "Whether an appeal has been filed"
    - name: "law_enforcement_involved"
      expr: CASE WHEN law_enforcement_agency IS NOT NULL THEN True ELSE False END
      comment: "Whether law enforcement was involved in ban decision"
    - name: "reinstatement_eligible"
      expr: reinstatement_eligible
      comment: "Whether banned person is eligible for reinstatement"
  measures:
    - name: "total_bans"
      expr: COUNT(1)
      comment: "Total number of venue bans issued"
    - name: "active_bans"
      expr: COUNT(CASE WHEN ban_status = 'Active' THEN 1 END)
      comment: "Number of currently active venue bans"
    - name: "permanent_bans"
      expr: COUNT(CASE WHEN ban_type = 'Permanent' THEN 1 END)
      comment: "Number of permanent bans issued"
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_lodged_date IS NOT NULL THEN 1 END)
      comment: "Number of bans with appeals filed"
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_lodged_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bans that are appealed"
    - name: "appeal_success_count"
      expr: COUNT(CASE WHEN appeal_status = 'Upheld' THEN 1 END)
      comment: "Number of successful appeals resulting in ban overturn"
    - name: "law_enforcement_referral_count"
      expr: COUNT(CASE WHEN law_enforcement_agency IS NOT NULL THEN 1 END)
      comment: "Number of bans involving law enforcement referral"
    - name: "unique_banned_persons"
      expr: COUNT(DISTINCT banned_person_full_name)
      comment: "Distinct count of persons with venue bans"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`security_law_enforcement_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Law enforcement resource deployment and cost metrics for event security planning, mutual aid coordination, and budget management"
  source: "`sports_entertainment_ecm`.`security`.`law_enforcement_deployment`"
  dimensions:
    - name: "agency_name"
      expr: agency_name
      comment: "Name of law enforcement agency deployed"
    - name: "agency_type"
      expr: agency_type
      comment: "Type of law enforcement agency (local, state, federal)"
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (routine, special event, emergency)"
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of deployment"
    - name: "threat_level"
      expr: threat_level
      comment: "Assessed threat level for the deployment"
    - name: "sear_rating"
      expr: sear_rating
      comment: "Special Event Assessment Rating (DHS classification)"
    - name: "deployment_date"
      expr: DATE(deployment_start_timestamp)
      comment: "Date of law enforcement deployment"
    - name: "k9_unit_flag"
      expr: k9_unit_flag
      comment: "Whether K9 units were deployed"
    - name: "mounted_unit_flag"
      expr: mounted_unit_flag
      comment: "Whether mounted units were deployed"
    - name: "overtime_authorized_flag"
      expr: overtime_authorized_flag
      comment: "Whether overtime was authorized for deployment"
    - name: "debrief_completed_flag"
      expr: debrief_completed_flag
      comment: "Whether post-deployment debrief was completed"
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of law enforcement deployments"
    - name: "total_planned_officers"
      expr: SUM(CAST(officer_count_planned AS DOUBLE))
      comment: "Total number of officers planned across all deployments"
    - name: "total_actual_officers"
      expr: SUM(CAST(officer_count_actual AS DOUBLE))
      comment: "Total number of officers actually deployed"
    - name: "avg_officers_per_deployment"
      expr: AVG(CAST(officer_count_actual AS DOUBLE))
      comment: "Average number of officers per deployment"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of law enforcement deployments in USD"
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of law enforcement deployments in USD"
    - name: "avg_cost_per_deployment_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average cost per law enforcement deployment in USD"
    - name: "cost_variance_usd"
      expr: SUM(actual_cost_usd - estimated_cost_usd)
      comment: "Total cost variance between estimated and actual deployment costs"
    - name: "k9_deployment_count"
      expr: COUNT(CASE WHEN k9_unit_flag = True THEN 1 END)
      comment: "Number of deployments including K9 units"
    - name: "total_arrests_made"
      expr: SUM(CAST(arrests_made_count AS DOUBLE))
      comment: "Total number of arrests made during deployments"
    - name: "total_incidents_reported"
      expr: SUM(CAST(incidents_reported_count AS DOUBLE))
      comment: "Total number of incidents reported during deployments"
    - name: "unique_agencies_deployed"
      expr: COUNT(DISTINCT agency_name)
      comment: "Distinct count of law enforcement agencies deployed"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`security_emergency_activation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency response activation and incident command metrics for crisis management, evacuation effectiveness, and multi-agency coordination"
  source: "`sports_entertainment_ecm`.`security`.`emergency_activation`"
  dimensions:
    - name: "activation_status"
      expr: activation_status
      comment: "Current status of emergency activation"
    - name: "threat_category"
      expr: threat_category
      comment: "Category of threat triggering activation"
    - name: "incident_severity_level"
      expr: incident_severity_level
      comment: "Severity level of the emergency incident"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of emergency response plan activated"
    - name: "activation_date"
      expr: DATE(activation_timestamp)
      comment: "Date of emergency activation"
    - name: "activation_hour"
      expr: HOUR(activation_timestamp)
      comment: "Hour of day when emergency was activated"
    - name: "drill_exercise"
      expr: drill_exercise
      comment: "Whether activation was a drill or actual emergency"
    - name: "false_alarm"
      expr: false_alarm
      comment: "Whether activation was determined to be false alarm"
    - name: "evacuation_initiated"
      expr: evacuation_initiated
      comment: "Whether evacuation was initiated"
    - name: "evacuation_type"
      expr: evacuation_type
      comment: "Type of evacuation if initiated (full, partial, shelter-in-place)"
    - name: "police_notified"
      expr: police_notified
      comment: "Whether police were notified"
    - name: "fire_department_notified"
      expr: fire_department_notified
      comment: "Whether fire department was notified"
    - name: "ems_notified"
      expr: ems_notified
      comment: "Whether EMS was notified"
    - name: "event_cancelled"
      expr: event_cancelled
      comment: "Whether event was cancelled due to emergency"
    - name: "broadcast_interrupted"
      expr: broadcast_interrupted
      comment: "Whether broadcast was interrupted"
  measures:
    - name: "total_activations"
      expr: COUNT(1)
      comment: "Total number of emergency activations"
    - name: "actual_emergency_count"
      expr: COUNT(CASE WHEN drill_exercise = False AND false_alarm = False THEN 1 END)
      comment: "Number of actual emergency activations (excluding drills and false alarms)"
    - name: "drill_count"
      expr: COUNT(CASE WHEN drill_exercise = True THEN 1 END)
      comment: "Number of emergency drill exercises conducted"
    - name: "false_alarm_count"
      expr: COUNT(CASE WHEN false_alarm = True THEN 1 END)
      comment: "Number of false alarm activations"
    - name: "false_alarm_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN false_alarm = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activations that were false alarms"
    - name: "evacuation_count"
      expr: COUNT(CASE WHEN evacuation_initiated = True THEN 1 END)
      comment: "Number of activations requiring evacuation"
    - name: "event_cancellation_count"
      expr: COUNT(CASE WHEN event_cancelled = True THEN 1 END)
      comment: "Number of activations resulting in event cancellation"
    - name: "avg_response_duration_minutes"
      expr: AVG(CAST(response_duration_minutes AS DOUBLE))
      comment: "Average duration of emergency response in minutes"
    - name: "total_confirmed_injuries"
      expr: SUM(CAST(confirmed_injuries_count AS DOUBLE))
      comment: "Total number of confirmed injuries across all activations"
    - name: "total_confirmed_fatalities"
      expr: SUM(CAST(confirmed_fatalities_count AS DOUBLE))
      comment: "Total number of confirmed fatalities across all activations"
    - name: "total_medical_transports"
      expr: SUM(CAST(medical_transports_count AS DOUBLE))
      comment: "Total number of medical transports during activations"
    - name: "multi_agency_response_count"
      expr: COUNT(CASE WHEN police_notified = True AND fire_department_notified = True THEN 1 END)
      comment: "Number of activations requiring multi-agency response"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`security_threat_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Threat intelligence and risk assessment metrics for proactive security planning, vulnerability management, and countermeasure effectiveness"
  source: "`sports_entertainment_ecm`.`security`.`threat_assessment`"
  dimensions:
    - name: "threat_level"
      expr: threat_level
      comment: "Overall assessed threat level"
    - name: "threat_category"
      expr: threat_category
      comment: "Category of threat assessed"
    - name: "threat_subcategory"
      expr: threat_subcategory
      comment: "Subcategory of threat for detailed classification"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of threat assessment conducted"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of threat assessment"
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of threat occurrence"
    - name: "consequence_rating"
      expr: consequence_rating
      comment: "Consequence rating if threat materializes"
    - name: "sear_level"
      expr: sear_level
      comment: "Special Event Assessment Rating level"
    - name: "assessment_date"
      expr: DATE(assessment_timestamp)
      comment: "Date of threat assessment"
    - name: "intelligence_classification"
      expr: intelligence_classification
      comment: "Classification level of intelligence used"
    - name: "dhs_coordination_flag"
      expr: dhs_coordination_flag
      comment: "Whether DHS coordination was involved"
    - name: "fbi_coordination_flag"
      expr: fbi_coordination_flag
      comment: "Whether FBI coordination was involved"
    - name: "local_law_enforcement_flag"
      expr: local_law_enforcement_flag
      comment: "Whether local law enforcement was involved"
    - name: "vip_presence_flag"
      expr: vip_presence_flag
      comment: "Whether VIP presence elevates threat assessment"
    - name: "evacuation_plan_flag"
      expr: evacuation_plan_flag
      comment: "Whether evacuation plan was developed"
    - name: "countermeasures_status"
      expr: countermeasures_status
      comment: "Status of countermeasures implementation"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of threat assessments conducted"
    - name: "high_threat_count"
      expr: COUNT(CASE WHEN threat_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of assessments with high or critical threat level"
    - name: "high_threat_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN threat_level IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments classified as high or critical threat"
    - name: "federal_coordination_count"
      expr: COUNT(CASE WHEN dhs_coordination_flag = True OR fbi_coordination_flag = True THEN 1 END)
      comment: "Number of assessments involving federal agency coordination"
    - name: "vip_event_count"
      expr: COUNT(CASE WHEN vip_presence_flag = True THEN 1 END)
      comment: "Number of assessments for events with VIP presence"
    - name: "evacuation_plan_required_count"
      expr: COUNT(CASE WHEN evacuation_plan_flag = True THEN 1 END)
      comment: "Number of assessments requiring evacuation plan development"
    - name: "countermeasures_implemented_count"
      expr: COUNT(CASE WHEN countermeasures_status = 'Implemented' THEN 1 END)
      comment: "Number of assessments with countermeasures fully implemented"
    - name: "avg_threat_level_score"
      expr: AVG(CAST(threat_level_score AS DOUBLE))
      comment: "Average numerical threat level score across assessments"
    - name: "unique_threat_categories"
      expr: COUNT(DISTINCT threat_category)
      comment: "Distinct count of threat categories assessed"
$$;