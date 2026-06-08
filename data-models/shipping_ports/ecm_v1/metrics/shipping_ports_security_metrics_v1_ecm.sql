-- Metric views for domain: security | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core security incident KPIs tracking incident volume, severity distribution, response times, and financial impact for port security operations and ISPS compliance"
  source: "`shipping_ports_ecm`.`security`.`security_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of security incident (breach, unauthorized access, theft, etc.)"
    - name: "incident_subtype"
      expr: subtype
      comment: "Detailed subtype classification of the security incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (critical, high, medium, low)"
    - name: "threat_level"
      expr: threat_level
      comment: "Assessed threat level associated with the incident"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, investigating, closed, escalated)"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation process"
    - name: "marsec_level"
      expr: marsec_level
      comment: "Maritime Security (MARSEC) level at time of incident"
    - name: "incident_year"
      expr: YEAR(datetime)
      comment: "Year when the incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month when the incident occurred"
    - name: "incident_date"
      expr: DATE(datetime)
      comment: "Date when the incident occurred"
    - name: "cargo_involved_flag"
      expr: cargo_involved_flag
      comment: "Whether cargo was involved in the incident"
    - name: "law_enforcement_notified_flag"
      expr: law_enforcement_notified_flag
      comment: "Whether law enforcement was notified"
    - name: "pfso_notified_flag"
      expr: pfso_notified_flag
      comment: "Whether Port Facility Security Officer was notified"
    - name: "national_authority_escalated_flag"
      expr: national_authority_escalated_flag
      comment: "Whether incident was escalated to national authority"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of security incidents reported"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact across all incidents in base currency"
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per incident"
    - name: "incidents_with_cargo"
      expr: COUNT(CASE WHEN cargo_involved_flag = TRUE THEN 1 END)
      comment: "Count of incidents involving cargo"
    - name: "incidents_law_enforcement_notified"
      expr: COUNT(CASE WHEN law_enforcement_notified_flag = TRUE THEN 1 END)
      comment: "Count of incidents where law enforcement was notified"
    - name: "incidents_escalated_to_national_authority"
      expr: COUNT(CASE WHEN national_authority_escalated_flag = TRUE THEN 1 END)
      comment: "Count of incidents escalated to national maritime authority"
    - name: "critical_severity_incidents"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Count of critical severity incidents requiring immediate executive attention"
    - name: "high_severity_incidents"
      expr: COUNT(CASE WHEN severity_level = 'High' THEN 1 END)
      comment: "Count of high severity incidents"
    - name: "incidents_with_cctv_footage"
      expr: COUNT(CASE WHEN cctv_footage_available_flag = TRUE THEN 1 END)
      comment: "Count of incidents with CCTV footage available for investigation"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_access_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access control performance metrics tracking access decisions, denial rates, alarm triggers, and security violations for port facility access management"
  source: "`shipping_ports_ecm`.`security`.`access_event`"
  dimensions:
    - name: "access_decision"
      expr: access_decision
      comment: "Access control decision (granted, denied, override)"
    - name: "event_type"
      expr: event_type
      comment: "Type of access event (entry, exit, attempt, violation)"
    - name: "access_point_type"
      expr: access_point_type
      comment: "Type of access point (gate, door, turnstile, vehicle barrier)"
    - name: "access_purpose"
      expr: access_purpose
      comment: "Stated purpose of access request"
    - name: "direction"
      expr: direction
      comment: "Direction of access (entry, exit)"
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential used for access"
    - name: "marsec_level"
      expr: marsec_level
      comment: "Maritime Security level at time of access event"
    - name: "zone_classification"
      expr: zone_classification
      comment: "Security classification of the zone accessed"
    - name: "alarm_triggered_flag"
      expr: alarm_triggered_flag
      comment: "Whether an alarm was triggered during access"
    - name: "anti_passback_violation_flag"
      expr: anti_passback_violation_flag
      comment: "Whether anti-passback rules were violated"
    - name: "time_zone_restriction_violated_flag"
      expr: time_zone_restriction_violated_flag
      comment: "Whether time-based access restrictions were violated"
    - name: "visitor_flag"
      expr: visitor_flag
      comment: "Whether the access was by a visitor"
    - name: "escort_required_flag"
      expr: escort_required_flag
      comment: "Whether escort was required for this access"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year of the access event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the access event"
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of the access event"
    - name: "event_hour"
      expr: HOUR(event_timestamp)
      comment: "Hour of day when access event occurred"
  measures:
    - name: "total_access_events"
      expr: COUNT(1)
      comment: "Total number of access events recorded"
    - name: "access_granted_count"
      expr: COUNT(CASE WHEN access_decision = 'Granted' THEN 1 END)
      comment: "Count of access requests that were granted"
    - name: "access_denied_count"
      expr: COUNT(CASE WHEN access_decision = 'Denied' THEN 1 END)
      comment: "Count of access requests that were denied"
    - name: "alarm_triggered_count"
      expr: COUNT(CASE WHEN alarm_triggered_flag = TRUE THEN 1 END)
      comment: "Count of access events that triggered security alarms"
    - name: "anti_passback_violations"
      expr: COUNT(CASE WHEN anti_passback_violation_flag = TRUE THEN 1 END)
      comment: "Count of anti-passback rule violations indicating potential tailgating or credential sharing"
    - name: "time_restriction_violations"
      expr: COUNT(CASE WHEN time_zone_restriction_violated_flag = TRUE THEN 1 END)
      comment: "Count of time-based access restriction violations"
    - name: "visitor_access_events"
      expr: COUNT(CASE WHEN visitor_flag = TRUE THEN 1 END)
      comment: "Count of access events by visitors"
    - name: "avg_biometric_match_score"
      expr: AVG(CAST(biometric_match_score AS DOUBLE))
      comment: "Average biometric match score for biometric-authenticated access events"
    - name: "avg_temperature_reading"
      expr: AVG(CAST(temperature_reading_celsius AS DOUBLE))
      comment: "Average temperature reading for health screening access points"
    - name: "unique_credentials_used"
      expr: COUNT(DISTINCT credential_number)
      comment: "Count of unique credentials used for access"
    - name: "unique_persons_accessed"
      expr: COUNT(DISTINCT person_name)
      comment: "Count of unique individuals who accessed the facility"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_cyber_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cybersecurity incident metrics tracking cyber threats, data breaches, operational disruption, and incident response effectiveness for maritime OT/IT systems"
  source: "`shipping_ports_ecm`.`security`.`cyber_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of cyber incident (malware, phishing, DDoS, unauthorized access, etc.)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the cyber incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the cyber incident"
    - name: "attack_vector"
      expr: attack_vector
      comment: "Attack vector used (email, network, physical, supply chain, etc.)"
    - name: "threat_actor_type"
      expr: threat_actor_type
      comment: "Type of threat actor (nation-state, criminal, insider, hacktivist, etc.)"
    - name: "data_breach_flag"
      expr: data_breach_flag
      comment: "Whether the incident resulted in a data breach"
    - name: "pii_exposed_flag"
      expr: pii_exposed_flag
      comment: "Whether personally identifiable information was exposed"
    - name: "operational_disruption_flag"
      expr: operational_disruption_flag
      comment: "Whether the incident caused operational disruption to port operations"
    - name: "law_enforcement_notification_flag"
      expr: law_enforcement_notification_flag
      comment: "Whether law enforcement was notified"
    - name: "cert_notification_flag"
      expr: cert_notification_flag
      comment: "Whether Computer Emergency Response Team was notified"
    - name: "maritime_authority_notification_flag"
      expr: maritime_authority_notification_flag
      comment: "Whether maritime authority was notified per IMO MSC-FAL.1/Circ.3"
    - name: "external_support_engaged_flag"
      expr: external_support_engaged_flag
      comment: "Whether external cybersecurity support was engaged"
    - name: "incident_year"
      expr: YEAR(occurrence_timestamp)
      comment: "Year when the cyber incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', occurrence_timestamp)
      comment: "Month when the cyber incident occurred"
    - name: "detection_year"
      expr: YEAR(detection_timestamp)
      comment: "Year when the cyber incident was detected"
  measures:
    - name: "total_cyber_incidents"
      expr: COUNT(1)
      comment: "Total number of cyber security incidents"
    - name: "data_breach_incidents"
      expr: COUNT(CASE WHEN data_breach_flag = TRUE THEN 1 END)
      comment: "Count of incidents resulting in data breaches"
    - name: "pii_exposure_incidents"
      expr: COUNT(CASE WHEN pii_exposed_flag = TRUE THEN 1 END)
      comment: "Count of incidents exposing personally identifiable information"
    - name: "operational_disruption_incidents"
      expr: COUNT(CASE WHEN operational_disruption_flag = TRUE THEN 1 END)
      comment: "Count of incidents causing operational disruption to port operations"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of cyber incidents"
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per cyber incident"
    - name: "incidents_requiring_external_support"
      expr: COUNT(CASE WHEN external_support_engaged_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring external cybersecurity support"
    - name: "incidents_notified_to_maritime_authority"
      expr: COUNT(CASE WHEN maritime_authority_notification_flag = TRUE THEN 1 END)
      comment: "Count of incidents reported to maritime authority per IMO guidelines"
    - name: "incidents_notified_to_law_enforcement"
      expr: COUNT(CASE WHEN law_enforcement_notification_flag = TRUE THEN 1 END)
      comment: "Count of incidents reported to law enforcement"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_patrol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security patrol effectiveness metrics tracking patrol completion, compliance, anomaly detection, and incident response for physical security operations"
  source: "`shipping_ports_ecm`.`security`.`patrol`"
  dimensions:
    - name: "patrol_type"
      expr: patrol_type
      comment: "Type of patrol (scheduled, random, response, special)"
    - name: "patrol_status"
      expr: patrol_status
      comment: "Status of the patrol (scheduled, in-progress, completed, cancelled)"
    - name: "marsec_level"
      expr: marsec_level
      comment: "Maritime Security level during patrol"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the patrol was completed in compliance with procedures"
    - name: "incident_reported_flag"
      expr: incident_reported_flag
      comment: "Whether an incident was reported during the patrol"
    - name: "cctv_verification_flag"
      expr: cctv_verification_flag
      comment: "Whether CCTV verification was performed"
    - name: "lighting_verification_flag"
      expr: lighting_verification_flag
      comment: "Whether lighting adequacy was verified"
    - name: "perimeter_integrity_flag"
      expr: perimeter_integrity_flag
      comment: "Whether perimeter integrity was confirmed"
    - name: "supervisor_review_flag"
      expr: supervisor_review_flag
      comment: "Whether supervisor review was completed"
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions during patrol"
    - name: "visibility_level"
      expr: visibility_level
      comment: "Visibility level during patrol"
    - name: "patrol_year"
      expr: YEAR(scheduled_start_time)
      comment: "Year of scheduled patrol"
    - name: "patrol_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_time)
      comment: "Month of scheduled patrol"
    - name: "patrol_date"
      expr: DATE(scheduled_start_time)
      comment: "Date of scheduled patrol"
  measures:
    - name: "total_patrols"
      expr: COUNT(1)
      comment: "Total number of security patrols conducted"
    - name: "completed_patrols"
      expr: COUNT(CASE WHEN patrol_status = 'Completed' THEN 1 END)
      comment: "Count of patrols completed"
    - name: "compliant_patrols"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of patrols completed in full compliance with procedures"
    - name: "patrols_with_incidents"
      expr: COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END)
      comment: "Count of patrols during which security incidents were reported"
    - name: "patrols_with_anomalies"
      expr: COUNT(CASE WHEN anomalies_detected IS NOT NULL AND anomalies_detected != '' THEN 1 END)
      comment: "Count of patrols where anomalies were detected"
    - name: "patrols_with_perimeter_breach"
      expr: COUNT(CASE WHEN perimeter_integrity_flag = FALSE THEN 1 END)
      comment: "Count of patrols identifying perimeter integrity issues"
    - name: "total_distance_covered_km"
      expr: SUM(CAST(distance_covered_km AS DOUBLE))
      comment: "Total distance covered by all patrols in kilometers"
    - name: "avg_distance_covered_km"
      expr: AVG(CAST(distance_covered_km AS DOUBLE))
      comment: "Average distance covered per patrol in kilometers"
    - name: "patrols_requiring_supervisor_review"
      expr: COUNT(CASE WHEN supervisor_review_flag = TRUE THEN 1 END)
      comment: "Count of patrols requiring supervisor review due to findings"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_visitor_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visitor management metrics tracking visitor volume, screening effectiveness, restricted area access, and security incidents for port facility visitor control"
  source: "`shipping_ports_ecm`.`security`.`visitor_log`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the visit (scheduled, in-progress, completed, cancelled)"
    - name: "visit_purpose_category"
      expr: visit_purpose_category
      comment: "Category of visit purpose (business, inspection, delivery, maintenance, etc.)"
    - name: "visit_purpose"
      expr: visit_purpose
      comment: "Detailed purpose of the visit"
    - name: "organization_type"
      expr: organization_type
      comment: "Type of visitor organization (government, contractor, vendor, customer, etc.)"
    - name: "escort_required_flag"
      expr: escort_required_flag
      comment: "Whether escort was required for the visitor"
    - name: "restricted_area_access_flag"
      expr: restricted_area_access_flag
      comment: "Whether visitor accessed restricted security areas"
    - name: "security_screening_completed_flag"
      expr: security_screening_completed_flag
      comment: "Whether security screening was completed"
    - name: "pfso_approval_required_flag"
      expr: pfso_approval_required_flag
      comment: "Whether Port Facility Security Officer approval was required"
    - name: "security_incident_flag"
      expr: security_incident_flag
      comment: "Whether a security incident occurred during the visit"
    - name: "vehicle_entry_flag"
      expr: vehicle_entry_flag
      comment: "Whether visitor entered with a vehicle"
    - name: "badge_returned_flag"
      expr: badge_returned_flag
      comment: "Whether visitor badge was returned upon exit"
    - name: "watchlist_check_status"
      expr: watchlist_check_status
      comment: "Status of watchlist check (clear, match, pending)"
    - name: "marsec_level"
      expr: marsec_level
      comment: "Maritime Security level during visit"
    - name: "entry_year"
      expr: YEAR(entry_timestamp)
      comment: "Year of visitor entry"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_timestamp)
      comment: "Month of visitor entry"
    - name: "entry_date"
      expr: DATE(entry_timestamp)
      comment: "Date of visitor entry"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of visitor visits logged"
    - name: "completed_visits"
      expr: COUNT(CASE WHEN visit_status = 'Completed' THEN 1 END)
      comment: "Count of completed visits"
    - name: "visits_requiring_escort"
      expr: COUNT(CASE WHEN escort_required_flag = TRUE THEN 1 END)
      comment: "Count of visits requiring security escort"
    - name: "restricted_area_visits"
      expr: COUNT(CASE WHEN restricted_area_access_flag = TRUE THEN 1 END)
      comment: "Count of visits accessing restricted security areas"
    - name: "visits_with_security_incidents"
      expr: COUNT(CASE WHEN security_incident_flag = TRUE THEN 1 END)
      comment: "Count of visits during which security incidents occurred"
    - name: "visits_requiring_pfso_approval"
      expr: COUNT(CASE WHEN pfso_approval_required_flag = TRUE THEN 1 END)
      comment: "Count of visits requiring Port Facility Security Officer approval"
    - name: "vehicle_entries"
      expr: COUNT(CASE WHEN vehicle_entry_flag = TRUE THEN 1 END)
      comment: "Count of visits involving vehicle entry"
    - name: "unreturned_badges"
      expr: COUNT(CASE WHEN badge_returned_flag = FALSE AND visit_status = 'Completed' THEN 1 END)
      comment: "Count of completed visits where visitor badge was not returned"
    - name: "unique_visitors"
      expr: COUNT(DISTINCT visitor_full_name)
      comment: "Count of unique individual visitors"
    - name: "unique_visitor_organizations"
      expr: COUNT(DISTINCT organization_name)
      comment: "Count of unique visitor organizations"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_screening_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security screening effectiveness metrics tracking screening outcomes, prohibited item detection, watchlist matches, and alert response for cargo and personnel screening"
  source: "`shipping_ports_ecm`.`security`.`screening_record`"
  dimensions:
    - name: "screening_outcome"
      expr: screening_outcome
      comment: "Outcome of the screening (cleared, detained, rejected, escalated)"
    - name: "screening_status"
      expr: screening_status
      comment: "Status of the screening record"
    - name: "screening_method"
      expr: screening_method
      comment: "Primary screening method used (X-ray, physical, canine, etc.)"
    - name: "secondary_screening_method"
      expr: secondary_screening_method
      comment: "Secondary screening method if escalated"
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject screened (person, cargo, vehicle, baggage)"
    - name: "alert_triggered_flag"
      expr: alert_triggered_flag
      comment: "Whether a screening alert was triggered"
    - name: "alert_type"
      expr: alert_type
      comment: "Type of alert triggered"
    - name: "prohibited_item_detected_flag"
      expr: prohibited_item_detected_flag
      comment: "Whether prohibited items were detected"
    - name: "watchlist_match_flag"
      expr: watchlist_match_flag
      comment: "Whether subject matched a security watchlist"
    - name: "radiation_threshold_exceeded_flag"
      expr: radiation_threshold_exceeded_flag
      comment: "Whether radiation threshold was exceeded"
    - name: "pfso_notified_flag"
      expr: pfso_notified_flag
      comment: "Whether Port Facility Security Officer was notified"
    - name: "customs_notification_flag"
      expr: customs_notification_flag
      comment: "Whether customs authority was notified"
    - name: "supervisor_override_flag"
      expr: supervisor_override_flag
      comment: "Whether supervisor override was required"
    - name: "marsec_level"
      expr: marsec_level
      comment: "Maritime Security level during screening"
    - name: "screening_year"
      expr: YEAR(screening_timestamp)
      comment: "Year of screening"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_timestamp)
      comment: "Month of screening"
    - name: "screening_date"
      expr: DATE(screening_timestamp)
      comment: "Date of screening"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of security screenings conducted"
    - name: "screenings_cleared"
      expr: COUNT(CASE WHEN screening_outcome = 'Cleared' THEN 1 END)
      comment: "Count of screenings resulting in clearance"
    - name: "screenings_with_alerts"
      expr: COUNT(CASE WHEN alert_triggered_flag = TRUE THEN 1 END)
      comment: "Count of screenings triggering security alerts"
    - name: "prohibited_items_detected"
      expr: COUNT(CASE WHEN prohibited_item_detected_flag = TRUE THEN 1 END)
      comment: "Count of screenings detecting prohibited items"
    - name: "watchlist_matches"
      expr: COUNT(CASE WHEN watchlist_match_flag = TRUE THEN 1 END)
      comment: "Count of screenings matching security watchlists"
    - name: "radiation_threshold_exceedances"
      expr: COUNT(CASE WHEN radiation_threshold_exceeded_flag = TRUE THEN 1 END)
      comment: "Count of screenings exceeding radiation detection thresholds"
    - name: "screenings_requiring_pfso_notification"
      expr: COUNT(CASE WHEN pfso_notified_flag = TRUE THEN 1 END)
      comment: "Count of screenings requiring Port Facility Security Officer notification"
    - name: "screenings_requiring_customs_notification"
      expr: COUNT(CASE WHEN customs_notification_flag = TRUE THEN 1 END)
      comment: "Count of screenings requiring customs authority notification"
    - name: "supervisor_overrides"
      expr: COUNT(CASE WHEN supervisor_override_flag = TRUE THEN 1 END)
      comment: "Count of screenings requiring supervisor override"
    - name: "avg_biometric_match_score"
      expr: AVG(CAST(biometric_match_score AS DOUBLE))
      comment: "Average biometric match score for biometric screenings"
    - name: "avg_radiation_reading"
      expr: AVG(CAST(radiation_reading AS DOUBLE))
      comment: "Average radiation reading across all screenings"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_threat_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Threat assessment metrics tracking threat ratings, vulnerability findings, risk levels, and countermeasure recommendations for ISPS compliance and security planning"
  source: "`shipping_ports_ecm`.`security`.`threat_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of threat assessment (facility, vessel, port-wide, special)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the threat assessment"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the assessment"
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating from the assessment (critical, high, medium, low)"
    - name: "threat_terrorism_rating"
      expr: threat_terrorism_rating
      comment: "Terrorism threat rating"
    - name: "threat_piracy_rating"
      expr: threat_piracy_rating
      comment: "Piracy threat rating"
    - name: "threat_sabotage_rating"
      expr: threat_sabotage_rating
      comment: "Sabotage threat rating"
    - name: "threat_cyber_rating"
      expr: threat_cyber_rating
      comment: "Cyber threat rating"
    - name: "threat_smuggling_rating"
      expr: threat_smuggling_rating
      comment: "Smuggling threat rating"
    - name: "threat_stowaways_rating"
      expr: threat_stowaways_rating
      comment: "Stowaway threat rating"
    - name: "classification_level"
      expr: classification_level
      comment: "Security classification level of the assessment"
    - name: "conducting_authority"
      expr: conducting_authority
      comment: "Authority conducting the threat assessment"
    - name: "stakeholder_consultation_conducted"
      expr: stakeholder_consultation_conducted
      comment: "Whether stakeholder consultation was conducted"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of threat assessment"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of assessment approval"
  measures:
    - name: "total_threat_assessments"
      expr: COUNT(1)
      comment: "Total number of threat assessments conducted"
    - name: "approved_assessments"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved threat assessments"
    - name: "critical_risk_assessments"
      expr: COUNT(CASE WHEN overall_risk_rating = 'Critical' THEN 1 END)
      comment: "Count of assessments with critical overall risk rating"
    - name: "high_risk_assessments"
      expr: COUNT(CASE WHEN overall_risk_rating = 'High' THEN 1 END)
      comment: "Count of assessments with high overall risk rating"
    - name: "assessments_evaluating_terrorism"
      expr: COUNT(CASE WHEN threat_terrorism_evaluated = TRUE THEN 1 END)
      comment: "Count of assessments evaluating terrorism threat"
    - name: "assessments_evaluating_cyber"
      expr: COUNT(CASE WHEN threat_cyber_evaluated = TRUE THEN 1 END)
      comment: "Count of assessments evaluating cyber threat"
    - name: "assessments_evaluating_piracy"
      expr: COUNT(CASE WHEN threat_piracy_evaluated = TRUE THEN 1 END)
      comment: "Count of assessments evaluating piracy threat"
    - name: "assessments_with_stakeholder_consultation"
      expr: COUNT(CASE WHEN stakeholder_consultation_conducted = TRUE THEN 1 END)
      comment: "Count of assessments with stakeholder consultation"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_drill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security drill and exercise metrics tracking drill completion, compliance, deficiencies identified, and corrective actions for ISPS training and preparedness"
  source: "`shipping_ports_ecm`.`security`.`drill`"
  dimensions:
    - name: "drill_type"
      expr: drill_type
      comment: "Type of security drill (tabletop, functional, full-scale, etc.)"
    - name: "drill_status"
      expr: drill_status
      comment: "Status of the drill (scheduled, completed, cancelled)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the drill execution"
    - name: "security_level_during_drill"
      expr: security_level_during_drill
      comment: "Security level during drill execution"
    - name: "drill_year"
      expr: YEAR(scheduled_date)
      comment: "Year of scheduled drill"
    - name: "drill_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled drill"
    - name: "drill_quarter"
      expr: CONCAT('Q', QUARTER(scheduled_date))
      comment: "Quarter of scheduled drill"
  measures:
    - name: "total_drills"
      expr: COUNT(1)
      comment: "Total number of security drills conducted"
    - name: "completed_drills"
      expr: COUNT(CASE WHEN drill_status = 'Completed' THEN 1 END)
      comment: "Count of completed security drills"
    - name: "compliant_drills"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of drills executed in compliance with ISPS requirements"
    - name: "drills_with_deficiencies"
      expr: COUNT(CASE WHEN deficiencies_identified IS NOT NULL AND deficiencies_identified != '' THEN 1 END)
      comment: "Count of drills identifying security deficiencies"
    - name: "drills_with_corrective_actions"
      expr: COUNT(CASE WHEN corrective_actions_raised IS NOT NULL AND corrective_actions_raised != '' THEN 1 END)
      comment: "Count of drills resulting in corrective actions"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_stowaway_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stowaway incident metrics tracking detection, detention, repatriation costs, and security breach analysis for maritime stowaway management"
  source: "`shipping_ports_ecm`.`security`.`stowaway_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Status of the stowaway case"
    - name: "detection_location_type"
      expr: detection_location_type
      comment: "Type of location where stowaway was detected (vessel, terminal, gate, etc.)"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which stowaway was detected"
    - name: "detention_status"
      expr: detention_status
      comment: "Detention status of the stowaway"
    - name: "repatriation_status"
      expr: repatriation_status
      comment: "Repatriation status of the stowaway"
    - name: "security_breach_flag"
      expr: security_breach_flag
      comment: "Whether the case represents a security breach"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "immigration_authority_notified_flag"
      expr: immigration_authority_notified_flag
      comment: "Whether immigration authority was notified"
    - name: "port_authority_notified_flag"
      expr: port_authority_notified_flag
      comment: "Whether port authority was notified"
    - name: "shipping_line_notified_flag"
      expr: shipping_line_notified_flag
      comment: "Whether shipping line was notified"
    - name: "detection_year"
      expr: YEAR(detection_timestamp)
      comment: "Year of stowaway detection"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month of stowaway detection"
    - name: "repatriation_year"
      expr: YEAR(repatriation_date)
      comment: "Year of repatriation"
  measures:
    - name: "total_stowaway_cases"
      expr: COUNT(1)
      comment: "Total number of stowaway cases"
    - name: "cases_with_security_breach"
      expr: COUNT(CASE WHEN security_breach_flag = TRUE THEN 1 END)
      comment: "Count of stowaway cases representing security breaches"
    - name: "cases_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of cases requiring corrective security actions"
    - name: "total_repatriation_cost"
      expr: SUM(CAST(repatriation_cost_amount AS DOUBLE))
      comment: "Total repatriation cost across all stowaway cases"
    - name: "avg_repatriation_cost"
      expr: AVG(CAST(repatriation_cost_amount AS DOUBLE))
      comment: "Average repatriation cost per stowaway case"
    - name: "repatriated_cases"
      expr: COUNT(CASE WHEN repatriation_status = 'Repatriated' THEN 1 END)
      comment: "Count of cases where stowaways were successfully repatriated"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`security_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security corrective action tracking metrics measuring action completion, overdue items, cost, and closure effectiveness for continuous security improvement"
  source: "`shipping_ports_ecm`.`security`.`security_corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Status of the corrective action"
    - name: "action_priority"
      expr: action_priority
      comment: "Priority level of the corrective action (critical, high, medium, low)"
    - name: "action_category"
      expr: action_category
      comment: "Category of corrective action"
    - name: "source_type"
      expr: source_type
      comment: "Source type that generated the corrective action (audit, incident, drill, etc.)"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the corrective action"
    - name: "overdue_flag"
      expr: overdue_flag
      comment: "Whether the corrective action is overdue"
    - name: "preventive_action_flag"
      expr: preventive_action_flag
      comment: "Whether this is a preventive action"
    - name: "root_cause_analysis_flag"
      expr: root_cause_analysis_flag
      comment: "Whether root cause analysis was performed"
    - name: "security_plan_amendment_required_flag"
      expr: security_plan_amendment_required_flag
      comment: "Whether facility security plan amendment is required"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required"
    - name: "marsec_level"
      expr: marsec_level
      comment: "Maritime Security level associated with the action"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the corrective action was identified"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the corrective action was identified"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year of target completion"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of security corrective actions"
    - name: "completed_actions"
      expr: COUNT(CASE WHEN action_status = 'Completed' THEN 1 END)
      comment: "Count of completed corrective actions"
    - name: "overdue_actions"
      expr: COUNT(CASE WHEN overdue_flag = TRUE THEN 1 END)
      comment: "Count of overdue corrective actions requiring escalation"
    - name: "critical_priority_actions"
      expr: COUNT(CASE WHEN action_priority = 'Critical' THEN 1 END)
      comment: "Count of critical priority corrective actions"
    - name: "actions_requiring_plan_amendment"
      expr: COUNT(CASE WHEN security_plan_amendment_required_flag = TRUE THEN 1 END)
      comment: "Count of actions requiring facility security plan amendment"
    - name: "actions_requiring_regulatory_notification"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of actions requiring regulatory notification"
    - name: "actions_with_root_cause_analysis"
      expr: COUNT(CASE WHEN root_cause_analysis_flag = TRUE THEN 1 END)
      comment: "Count of actions with root cause analysis performed"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all corrective actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of completed corrective actions"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per corrective action"
$$;