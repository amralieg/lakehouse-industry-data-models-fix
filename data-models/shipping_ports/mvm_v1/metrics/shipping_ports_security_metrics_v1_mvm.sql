-- Metric views for domain: security | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_access_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for port access credentials — tracks credential health, biometric enrollment coverage, expiry risk, and revocation rates to support access governance and compliance decisions."
  source: "`shipping_ports_ecm`.`security`.`access_credential`"
  dimensions:
    - name: "credential_type"
      expr: credential_type
      comment: "Type of access credential (e.g. TWIC, port pass, visitor badge) — primary segmentation for access governance reporting."
    - name: "credential_status"
      expr: credential_status
      comment: "Current lifecycle status of the credential (active, expired, revoked, suspended) — used to filter and segment compliance dashboards."
    - name: "holder_type"
      expr: holder_type
      comment: "Category of credential holder (employee, contractor, visitor, vessel crew) — drives workforce access segmentation."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the credential — used to track regulatory source and audit trail."
    - name: "marsec_level_access"
      expr: marsec_level_access
      comment: "MARSEC level for which this credential grants access — critical for maritime security compliance segmentation."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of the background check associated with the credential — key compliance dimension."
    - name: "biometric_modality"
      expr: biometric_modality
      comment: "Type of biometric enrolled (fingerprint, iris, facial) — used to assess biometric coverage by modality."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the credential was issued — enables trend analysis of credential issuance volumes."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the credential expires — used to forecast upcoming expiry volumes and renewal workload."
  measures:
    - name: "total_active_credentials"
      expr: COUNT(CASE WHEN credential_status = 'ACTIVE' THEN access_credential_id END)
      comment: "Total number of currently active access credentials — baseline KPI for access population size and workforce access governance."
    - name: "biometric_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN biometric_enrolled = TRUE THEN access_credential_id END) / NULLIF(COUNT(access_credential_id), 0), 2)
      comment: "Percentage of credentials with biometric enrollment — measures biometric coverage maturity; low rates indicate security gaps requiring investment."
    - name: "revocation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credential_status = 'REVOKED' THEN access_credential_id END) / NULLIF(COUNT(access_credential_id), 0), 2)
      comment: "Percentage of credentials that have been revoked — elevated rates signal workforce security issues or policy enforcement activity."
    - name: "escort_required_credential_count"
      expr: COUNT(CASE WHEN escort_required = TRUE THEN access_credential_id END)
      comment: "Number of credentials requiring escort — drives escort resource planning and highlights restricted-access population size."
    - name: "credentials_expiring_within_30_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) AND credential_status = 'ACTIVE' THEN access_credential_id END)
      comment: "Count of active credentials expiring within the next 30 days — critical operational KPI for renewal workload forecasting and avoiding access lapses."
    - name: "background_check_pending_count"
      expr: COUNT(CASE WHEN background_check_status = 'PENDING' THEN access_credential_id END)
      comment: "Number of credentials with a pending background check — unresolved background checks represent a compliance and security risk requiring immediate action."
    - name: "renewal_notification_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_notification_sent = TRUE THEN access_credential_id END) / NULLIF(COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE, 60) THEN access_credential_id END), 0), 2)
      comment: "Percentage of near-expiry credentials for which a renewal notification has been sent — measures proactive credential management effectiveness."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_access_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time and historical KPIs for port access events — tracks access denial rates, alarm triggers, anti-passback violations, and visitor activity to support security operations and threat detection."
  source: "`shipping_ports_ecm`.`security`.`access_event`"
  dimensions:
    - name: "access_decision"
      expr: access_decision
      comment: "Outcome of the access attempt (granted, denied, override) — primary dimension for access control effectiveness analysis."
    - name: "access_point_type"
      expr: access_point_type
      comment: "Type of access point where the event occurred (gate, turnstile, door, vessel gangway) — used to identify high-risk entry points."
    - name: "zone_classification"
      expr: zone_classification
      comment: "Security classification of the zone accessed — enables risk-stratified analysis of access patterns."
    - name: "marsec_level"
      expr: marsec_level
      comment: "MARSEC level in effect at the time of the event — critical for correlating access patterns with security posture."
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential used for the access attempt — used to segment access events by credential category."
    - name: "direction"
      expr: direction
      comment: "Direction of movement (entry/exit) — used to track occupancy and detect anomalies such as tailgating."
    - name: "event_type"
      expr: event_type
      comment: "Category of access event (normal, alarm, override, violation) — primary operational segmentation for security monitoring."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the access event — enables daily trend analysis of access volumes and anomalies."
    - name: "event_hour"
      expr: HOUR(event_timestamp)
      comment: "Hour of day the event occurred — used to identify peak access periods and off-hours anomalies."
  measures:
    - name: "total_access_events"
      expr: COUNT(access_event_id)
      comment: "Total number of access events — baseline throughput KPI for port access operations and capacity planning."
    - name: "access_denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN access_decision = 'DENIED' THEN access_event_id END) / NULLIF(COUNT(access_event_id), 0), 2)
      comment: "Percentage of access attempts that were denied — elevated denial rates indicate credential issues, policy gaps, or potential intrusion attempts requiring investigation."
    - name: "alarm_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alarm_triggered_flag = TRUE THEN access_event_id END) / NULLIF(COUNT(access_event_id), 0), 2)
      comment: "Percentage of access events that triggered an alarm — key security operations KPI; rising rates signal deteriorating access control or increased threat activity."
    - name: "anti_passback_violation_count"
      expr: COUNT(CASE WHEN anti_passback_violation_flag = TRUE THEN access_event_id END)
      comment: "Number of anti-passback violations detected — indicates tailgating or credential sharing, both serious security breaches requiring investigation."
    - name: "override_event_count"
      expr: COUNT(CASE WHEN access_decision = 'OVERRIDE' THEN access_event_id END)
      comment: "Number of access events granted via override — overrides bypass normal controls and must be monitored for abuse; high counts warrant audit review."
    - name: "visitor_access_event_count"
      expr: COUNT(CASE WHEN visitor_flag = TRUE THEN access_event_id END)
      comment: "Number of access events by visitors — visitor access represents elevated risk and must be tracked for compliance with port security plans."
    - name: "time_zone_restriction_violation_count"
      expr: COUNT(CASE WHEN time_zone_restriction_violated_flag = TRUE THEN access_event_id END)
      comment: "Number of events where time-zone access restrictions were violated — direct indicator of access control policy non-compliance requiring corrective action."
    - name: "avg_biometric_match_score"
      expr: ROUND(AVG(CAST(biometric_match_score AS DOUBLE)), 4)
      comment: "Average biometric match score across access events — declining scores may indicate biometric system degradation or spoofing attempts, informing maintenance and security investment decisions."
    - name: "distinct_credentials_used"
      expr: COUNT(DISTINCT access_credential_id)
      comment: "Number of unique credentials that generated access events in the period — measures active access population size and supports anomaly detection for dormant credential usage."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_access_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure KPIs for port access points — tracks operational status, maintenance compliance, CCTV coverage, and anti-tailgating capability to support security infrastructure investment and readiness decisions."
  source: "`shipping_ports_ecm`.`security`.`access_point`"
  dimensions:
    - name: "access_point_type"
      expr: access_point_type
      comment: "Type of access point (gate, turnstile, door, gangway) — primary segmentation for infrastructure analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the access point (operational, offline, maintenance) — used to track availability and readiness."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation at the access point (manual, semi-automated, fully automated) — informs technology investment decisions."
    - name: "barrier_type"
      expr: barrier_type
      comment: "Physical barrier type (bollard, boom gate, turnstile) — used to assess physical security infrastructure mix."
    - name: "access_level_required"
      expr: access_level_required
      comment: "Minimum access level required to pass this point — used to segment infrastructure by security tier."
    - name: "installation_month"
      expr: DATE_TRUNC('month', installation_date)
      comment: "Month the access point was installed — used for asset age analysis and replacement planning."
  measures:
    - name: "total_access_points"
      expr: COUNT(access_point_id)
      comment: "Total number of access points in the port — baseline infrastructure inventory KPI for capacity and coverage planning."
    - name: "operational_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'OPERATIONAL' THEN access_point_id END) / NULLIF(COUNT(access_point_id), 0), 2)
      comment: "Percentage of access points currently operational — low availability rates indicate infrastructure gaps that compromise port security posture."
    - name: "cctv_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cctv_coverage_flag = TRUE THEN access_point_id END) / NULLIF(COUNT(access_point_id), 0), 2)
      comment: "Percentage of access points with CCTV coverage — CCTV gaps at access points are a direct security vulnerability and regulatory compliance risk."
    - name: "anti_tailgating_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN anti_tailgating_enabled_flag = TRUE THEN access_point_id END) / NULLIF(COUNT(access_point_id), 0), 2)
      comment: "Percentage of access points with anti-tailgating enabled — low rates indicate vulnerability to unauthorized entry via tailgating, a key ISPS compliance concern."
    - name: "overdue_maintenance_count"
      expr: COUNT(CASE WHEN next_maintenance_due_date < CURRENT_DATE AND operational_status = 'OPERATIONAL' THEN access_point_id END)
      comment: "Number of operational access points with overdue maintenance — overdue maintenance increases failure risk and may void compliance certifications."
    - name: "alarm_integrated_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alarm_integration_flag = TRUE THEN access_point_id END) / NULLIF(COUNT(access_point_id), 0), 2)
      comment: "Percentage of access points integrated with the alarm system — non-integrated points create blind spots in the security response chain."
    - name: "certification_expiring_within_90_days"
      expr: COUNT(CASE WHEN certification_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN access_point_id END)
      comment: "Number of access points whose compliance certification expires within 90 days — expired certifications create regulatory non-compliance and potential port authority sanctions."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_facility_security_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for Facility Security Plans (FSPs) — tracks plan currency, CCTV coverage, drill compliance, audit outcomes, and MARSEC readiness to support ISPS Code compliance and port security governance."
  source: "`shipping_ports_ecm`.`security`.`facility_security_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the FSP (approved, draft, expired, under review) — primary governance dimension for plan lifecycle management."
    - name: "document_classification"
      expr: document_classification
      comment: "Security classification of the FSP document — used to ensure appropriate handling and access controls."
    - name: "last_audit_outcome"
      expr: last_audit_outcome
      comment: "Outcome of the most recent security audit (pass, fail, conditional) — key compliance dimension for regulatory reporting."
    - name: "access_control_system_type"
      expr: access_control_system_type
      comment: "Type of access control system described in the plan — used to segment facilities by technology maturity."
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the FSP was approved — used for trend analysis of plan approval cycles."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the FSP became effective — used to track plan currency and renewal cycles."
  measures:
    - name: "total_active_plans"
      expr: COUNT(CASE WHEN plan_status = 'APPROVED' THEN facility_security_plan_id END)
      comment: "Number of currently approved Facility Security Plans — baseline KPI for ISPS compliance coverage across port facilities."
    - name: "plans_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND plan_status = 'APPROVED' THEN facility_security_plan_id END)
      comment: "Number of approved FSPs expiring within 90 days — expired plans create immediate ISPS non-compliance; this KPI drives renewal prioritization."
    - name: "avg_cctv_coverage_pct"
      expr: ROUND(AVG(CAST(cctv_coverage_percentage AS DOUBLE)), 2)
      comment: "Average CCTV coverage percentage across all facility security plans — low averages indicate surveillance gaps requiring capital investment."
    - name: "cybersecurity_measures_inclusion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cybersecurity_measures_included = TRUE THEN facility_security_plan_id END) / NULLIF(COUNT(facility_security_plan_id), 0), 2)
      comment: "Percentage of FSPs that include cybersecurity measures — as port systems digitize, cyber-physical integration in FSPs is a regulatory and operational imperative."
    - name: "avg_patrol_frequency_hours"
      expr: ROUND(AVG(CAST(patrol_frequency_hours AS DOUBLE)), 2)
      comment: "Average patrol frequency (in hours) across facility security plans — lower values indicate more frequent patrols; used to benchmark security intensity against threat levels."
    - name: "overdue_drill_count"
      expr: COUNT(CASE WHEN next_drill_date < CURRENT_DATE AND plan_status = 'APPROVED' THEN facility_security_plan_id END)
      comment: "Number of approved FSPs with an overdue security drill — overdue drills are a direct ISPS Code violation and indicate preparedness gaps."
    - name: "overdue_review_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE AND plan_status = 'APPROVED' THEN facility_security_plan_id END)
      comment: "Number of approved FSPs past their scheduled review date — stale plans may not reflect current threat environments, creating compliance and operational risk."
    - name: "audit_fail_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN last_audit_outcome = 'FAIL' THEN facility_security_plan_id END) / NULLIF(COUNT(CASE WHEN last_audit_outcome IS NOT NULL THEN facility_security_plan_id END), 0), 2)
      comment: "Percentage of FSPs that failed their most recent audit — a leading indicator of systemic security plan quality issues requiring executive intervention."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_marsec_level_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for MARSEC level changes — tracks escalation frequency, acknowledgement timeliness, drill exercises, and geographic scope to support maritime security posture management and regulatory reporting."
  source: "`shipping_ports_ecm`.`security`.`marsec_level_change`"
  dimensions:
    - name: "new_marsec_level"
      expr: new_marsec_level
      comment: "The MARSEC level declared by this change (1, 2, 3) — primary dimension for security posture analysis."
    - name: "previous_marsec_level"
      expr: previous_marsec_level
      comment: "The MARSEC level prior to this change — used to analyze escalation and de-escalation patterns."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Coded reason for the MARSEC level change — used to categorize threat drivers and inform risk management decisions."
    - name: "issuing_authority_type"
      expr: issuing_authority_type
      comment: "Type of authority that issued the MARSEC change (national, port authority, facility) — used to distinguish regulatory-driven vs. locally-driven escalations."
    - name: "duration_type"
      expr: duration_type
      comment: "Whether the MARSEC change is temporary or permanent — informs resource planning and operational impact assessment."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the MARSEC change (port-wide, terminal, berth) — used to assess operational impact breadth."
    - name: "marsec_level_change_status"
      expr: marsec_level_change_status
      comment: "Current status of the MARSEC level change (active, superseded, cancelled) — used to filter to current security posture."
    - name: "declaration_month"
      expr: DATE_TRUNC('month', declaration_timestamp)
      comment: "Month the MARSEC change was declared — enables trend analysis of security escalation frequency over time."
  measures:
    - name: "total_marsec_escalations"
      expr: COUNT(CASE WHEN new_marsec_level > previous_marsec_level THEN marsec_level_change_id END)
      comment: "Total number of MARSEC level escalations (increases) — a rising trend signals deteriorating security environment requiring executive attention and resource reallocation."
    - name: "total_marsec_changes"
      expr: COUNT(marsec_level_change_id)
      comment: "Total number of MARSEC level changes in the period — baseline KPI for security posture volatility and operational disruption frequency."
    - name: "pfso_acknowledgement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pfso_acknowledged_flag = TRUE THEN marsec_level_change_id END) / NULLIF(COUNT(marsec_level_change_id), 0), 2)
      comment: "Percentage of MARSEC changes acknowledged by the Port Facility Security Officer — unacknowledged changes indicate communication failures in the security chain of command."
    - name: "drill_exercise_count"
      expr: COUNT(CASE WHEN drill_exercise_flag = TRUE THEN marsec_level_change_id END)
      comment: "Number of MARSEC changes that were drill exercises — tracks security preparedness exercise frequency against regulatory requirements."
    - name: "level_3_escalation_count"
      expr: COUNT(CASE WHEN new_marsec_level = '3' THEN marsec_level_change_id END)
      comment: "Number of MARSEC Level 3 declarations — the highest threat level; each occurrence represents a critical security event requiring board-level awareness and post-incident review."
    - name: "avg_notification_lag_minutes"
      expr: ROUND(AVG(TIMESTAMPDIFF(MINUTE, declaration_timestamp, notification_sent_timestamp)), 2)
      comment: "Average time in minutes between MARSEC change declaration and notification dispatch — delays in notification compromise coordinated security response; this KPI drives communication process improvement."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive and operational KPIs for port security incidents — tracks incident frequency, severity distribution, financial impact, investigation status, and escalation rates to support risk management, regulatory reporting, and security investment decisions."
  source: "`shipping_ports_ecm`.`security`.`security_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of security incident (intrusion, theft, vandalism, threat, etc.) — primary dimension for incident pattern analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (low, medium, high, critical) — used to prioritize response resources and escalation decisions."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, under investigation, closed) — used to track resolution pipeline and backlog."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation (pending, in progress, completed) — used to monitor investigation throughput and identify bottlenecks."
    - name: "threat_level"
      expr: threat_level
      comment: "Assessed threat level associated with the incident — used to correlate incidents with MARSEC posture and threat environment."
    - name: "incident_subtype"
      expr: subtype
      comment: "Sub-classification of the incident type — enables granular root cause analysis and trend detection."
    - name: "incident_month"
      expr: DATE_TRUNC('month', datetime)
      comment: "Month the incident occurred — primary time dimension for trend analysis and regulatory period reporting."
    - name: "incident_year"
      expr: DATE_TRUNC('year', datetime)
      comment: "Year the incident occurred — used for annual regulatory reporting and year-over-year comparison."
  measures:
    - name: "total_security_incidents"
      expr: COUNT(security_incident_id)
      comment: "Total number of security incidents in the period — primary KPI for port security performance; rising trends trigger executive review and resource reallocation."
    - name: "critical_high_severity_incident_count"
      expr: COUNT(CASE WHEN severity_level IN ('HIGH', 'CRITICAL') THEN security_incident_id END)
      comment: "Number of high or critical severity incidents — the most decision-relevant subset of incidents; directly informs security investment and MARSEC level decisions."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of security incidents — quantifies the business cost of security failures; essential for insurance, risk management, and security budget justification."
    - name: "avg_estimated_financial_impact"
      expr: ROUND(AVG(CAST(estimated_financial_impact AS DOUBLE)), 2)
      comment: "Average estimated financial impact per security incident — used to benchmark incident cost and prioritize prevention investments by incident type."
    - name: "law_enforcement_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN law_enforcement_notified_flag = TRUE THEN security_incident_id END) / NULLIF(COUNT(security_incident_id), 0), 2)
      comment: "Percentage of incidents escalated to law enforcement — indicates the proportion of incidents with criminal dimensions; rising rates signal a deteriorating security environment."
    - name: "national_authority_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN national_authority_escalated_flag = TRUE THEN security_incident_id END) / NULLIF(COUNT(security_incident_id), 0), 2)
      comment: "Percentage of incidents escalated to national authorities — the highest escalation tier; each occurrence represents a significant security event with potential national security implications."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status != 'CLOSED' THEN security_incident_id END)
      comment: "Number of currently open (unresolved) security incidents — a growing backlog indicates investigation capacity constraints or complex incidents requiring resource intervention."
    - name: "cargo_involved_incident_count"
      expr: COUNT(CASE WHEN cargo_involved_flag = TRUE THEN security_incident_id END)
      comment: "Number of incidents involving cargo — cargo security incidents have direct supply chain and customs compliance implications, making this a critical trade facilitation KPI."
    - name: "cctv_evidence_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cctv_footage_available_flag = TRUE THEN security_incident_id END) / NULLIF(COUNT(security_incident_id), 0), 2)
      comment: "Percentage of incidents for which CCTV footage is available — low rates indicate surveillance coverage gaps that impede investigations and undermine deterrence."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure and risk KPIs for port security zones — tracks zone coverage, patrol intensity, CCTV deployment, critical infrastructure designation, and risk assessment currency to support physical security planning and ISPS compliance."
  source: "`shipping_ports_ecm`.`security`.`zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of security zone (restricted, controlled, public) — primary dimension for zone risk stratification."
    - name: "zone_status"
      expr: zone_status
      comment: "Operational status of the zone (active, inactive, under construction) — used to filter to operationally relevant zones."
    - name: "threat_level"
      expr: threat_level
      comment: "Current threat level assigned to the zone — used to correlate zone characteristics with security posture."
    - name: "marsec_level_applicability"
      expr: marsec_level_applicability
      comment: "MARSEC levels for which this zone's controls apply — used to segment zones by regulatory applicability."
    - name: "patrol_type"
      expr: patrol_type
      comment: "Type of patrol conducted in the zone (foot, vehicle, CCTV-only) — used to assess patrol methodology mix."
    - name: "perimeter_fencing_type"
      expr: perimeter_fencing_type
      comment: "Type of perimeter fencing securing the zone — used to assess physical barrier quality and investment needs."
  measures:
    - name: "total_active_zones"
      expr: COUNT(CASE WHEN zone_status = 'ACTIVE' THEN zone_id END)
      comment: "Total number of active security zones — baseline KPI for port security perimeter coverage and zone management scope."
    - name: "critical_infrastructure_zone_count"
      expr: COUNT(CASE WHEN critical_infrastructure_flag = TRUE THEN zone_id END)
      comment: "Number of zones designated as critical infrastructure — these zones require the highest security investment and regulatory scrutiny; used to prioritize resource allocation."
    - name: "cctv_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cctv_coverage_flag = TRUE THEN zone_id END) / NULLIF(COUNT(CASE WHEN zone_status = 'ACTIVE' THEN zone_id END), 0), 2)
      comment: "Percentage of active zones with CCTV coverage — zones without CCTV are surveillance blind spots; this KPI drives camera deployment investment decisions."
    - name: "total_zone_area_sqm"
      expr: SUM(CAST(area_square_meters AS DOUBLE))
      comment: "Total area (in square meters) covered by security zones — used to normalize patrol and CCTV resource allocation per unit area."
    - name: "avg_patrol_frequency_hours"
      expr: ROUND(AVG(CAST(patrol_frequency_hours AS DOUBLE)), 2)
      comment: "Average patrol frequency in hours across all active zones — lower values indicate more frequent patrols; benchmarked against FSP requirements and threat levels."
    - name: "overdue_risk_assessment_count"
      expr: COUNT(CASE WHEN next_risk_assessment_due_date < CURRENT_DATE AND zone_status = 'ACTIVE' THEN zone_id END)
      comment: "Number of active zones with an overdue risk assessment — stale risk assessments mean security controls may not reflect current threats; a direct ISPS compliance gap."
    - name: "lighting_adequacy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lighting_adequacy_flag = TRUE THEN zone_id END) / NULLIF(COUNT(CASE WHEN zone_status = 'ACTIVE' THEN zone_id END), 0), 2)
      comment: "Percentage of active zones with adequate lighting — inadequate lighting is a fundamental physical security vulnerability enabling unauthorized access and reducing CCTV effectiveness."
    - name: "cybersecurity_zone_count"
      expr: COUNT(CASE WHEN cybersecurity_zone_flag = TRUE THEN zone_id END)
      comment: "Number of zones designated as cybersecurity zones — tracks the scope of cyber-physical security integration, a growing regulatory requirement for port facilities."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_zone_access_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance KPIs for zone access authorizations — tracks authorization currency, escort requirements, suspension and revocation rates, and review compliance to support least-privilege access governance and ISPS compliance."
  source: "`shipping_ports_ecm`.`security`.`zone_access_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the zone access authorization (active, suspended, revoked, expired) — primary dimension for access governance reporting."
    - name: "access_level"
      expr: access_level
      comment: "Level of access granted by this authorization — used to segment authorizations by privilege tier."
    - name: "marsec_level_override"
      expr: marsec_level_override
      comment: "MARSEC level override applied to this authorization — overrides represent elevated risk and require monitoring."
    - name: "authorization_month"
      expr: DATE_TRUNC('month', authorization_date)
      comment: "Month the authorization was granted — used for trend analysis of authorization issuance volumes."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the authorization became effective — used to track authorization lifecycle and renewal patterns."
  measures:
    - name: "total_active_authorizations"
      expr: COUNT(CASE WHEN authorization_status = 'ACTIVE' THEN zone_access_authorization_id END)
      comment: "Total number of active zone access authorizations — baseline KPI for access population size; large numbers relative to workforce size may indicate over-provisioning."
    - name: "authorizations_expiring_within_30_days"
      expr: COUNT(CASE WHEN effective_to_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) AND authorization_status = 'ACTIVE' THEN zone_access_authorization_id END)
      comment: "Number of active authorizations expiring within 30 days — drives proactive renewal management to prevent access disruptions for legitimate personnel."
    - name: "revocation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'REVOKED' THEN zone_access_authorization_id END) / NULLIF(COUNT(zone_access_authorization_id), 0), 2)
      comment: "Percentage of authorizations that have been revoked — elevated revocation rates signal workforce security issues or policy enforcement activity requiring investigation."
    - name: "suspension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'SUSPENDED' THEN zone_access_authorization_id END) / NULLIF(COUNT(zone_access_authorization_id), 0), 2)
      comment: "Percentage of authorizations currently suspended — suspended authorizations represent pending security reviews; high rates indicate systemic access governance issues."
    - name: "escort_required_authorization_count"
      expr: COUNT(CASE WHEN escort_required_flag = TRUE THEN zone_access_authorization_id END)
      comment: "Number of authorizations requiring escort — drives escort resource planning and highlights the restricted-access population requiring supervision."
    - name: "overdue_review_authorization_count"
      expr: COUNT(CASE WHEN next_review_due_date < CURRENT_DATE AND authorization_status = 'ACTIVE' THEN zone_access_authorization_id END)
      comment: "Number of active authorizations past their scheduled review date — unreviewed authorizations may grant access to personnel whose circumstances have changed, violating least-privilege principles."
    - name: "marsec_override_authorization_count"
      expr: COUNT(CASE WHEN marsec_level_override IS NOT NULL AND marsec_level_override != '' THEN zone_access_authorization_id END)
      comment: "Number of authorizations with a MARSEC level override — overrides bypass standard MARSEC-level access controls and must be minimized and audited to prevent security policy circumvention."
$$;