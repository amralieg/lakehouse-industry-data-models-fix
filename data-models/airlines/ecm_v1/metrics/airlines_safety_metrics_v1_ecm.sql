-- Metric views for domain: safety | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_occurrence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safety occurrence metrics tracking incidents, accidents, and safety events across the airline network with severity, injury, and regulatory reporting dimensions"
  source: "`airlines_ecm`.`safety`.`occurrence`"
  dimensions:
    - name: "occurrence_date"
      expr: occurrence_date
      comment: "Date when the safety occurrence happened"
    - name: "occurrence_year"
      expr: YEAR(occurrence_date)
      comment: "Year of occurrence for trend analysis"
    - name: "occurrence_month"
      expr: DATE_TRUNC('MONTH', occurrence_date)
      comment: "Month of occurrence for seasonal pattern analysis"
    - name: "classification"
      expr: classification
      comment: "Safety occurrence classification (e.g., accident, serious incident, incident)"
    - name: "category_code"
      expr: category_code
      comment: "Occurrence category code for grouping similar event types"
    - name: "subtype"
      expr: subtype
      comment: "Detailed subtype of the occurrence"
    - name: "flight_phase"
      expr: flight_phase
      comment: "Phase of flight when occurrence happened (takeoff, cruise, landing, etc.)"
    - name: "aircraft_damage_level"
      expr: aircraft_damage_level
      comment: "Level of aircraft damage (none, minor, substantial, destroyed)"
    - name: "injury_severity"
      expr: injury_severity
      comment: "Highest injury severity level in the occurrence"
    - name: "departure_airport_code"
      expr: departure_airport_code
      comment: "Origin airport code"
    - name: "arrival_airport_code"
      expr: arrival_airport_code
      comment: "Destination airport code"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required"
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification"
    - name: "reporting_source"
      expr: reporting_source
      comment: "Source of the occurrence report"
  measures:
    - name: "total_occurrences"
      expr: COUNT(occurrence_id)
      comment: "Total number of safety occurrences reported"
    - name: "total_fatalities"
      expr: SUM(CAST(fatalities_count AS BIGINT))
      comment: "Total number of fatalities across all occurrences"
    - name: "total_serious_injuries"
      expr: SUM(CAST(serious_injuries_count AS BIGINT))
      comment: "Total number of serious injuries across all occurrences"
    - name: "total_minor_injuries"
      expr: SUM(CAST(minor_injuries_count AS BIGINT))
      comment: "Total number of minor injuries across all occurrences"
    - name: "occurrences_with_fatalities"
      expr: COUNT(DISTINCT CASE WHEN CAST(fatalities_count AS BIGINT) > 0 THEN occurrence_id END)
      comment: "Number of occurrences that resulted in at least one fatality"
    - name: "occurrences_with_injuries"
      expr: COUNT(DISTINCT CASE WHEN CAST(serious_injuries_count AS BIGINT) > 0 OR CAST(minor_injuries_count AS BIGINT) > 0 THEN occurrence_id END)
      comment: "Number of occurrences that resulted in at least one injury"
    - name: "occurrences_with_aircraft_damage"
      expr: COUNT(DISTINCT CASE WHEN aircraft_damage_level IS NOT NULL AND aircraft_damage_level != 'none' THEN occurrence_id END)
      comment: "Number of occurrences that resulted in aircraft damage"
    - name: "regulatory_reportable_occurrences"
      expr: COUNT(DISTINCT CASE WHEN regulatory_notification_required = TRUE THEN occurrence_id END)
      comment: "Number of occurrences requiring regulatory notification"
    - name: "wildlife_strike_occurrences"
      expr: COUNT(DISTINCT CASE WHEN wildlife_strike_location IS NOT NULL THEN occurrence_id END)
      comment: "Number of occurrences involving wildlife strikes"
    - name: "runway_incursion_occurrences"
      expr: COUNT(DISTINCT CASE WHEN runway_incursion_severity IS NOT NULL THEN occurrence_id END)
      comment: "Number of occurrences classified as runway incursions"
    - name: "dangerous_goods_occurrences"
      expr: COUNT(DISTINCT CASE WHEN dangerous_goods_un_number IS NOT NULL THEN occurrence_id END)
      comment: "Number of occurrences involving dangerous goods"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_hazard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety hazard identification and risk management metrics tracking hazard lifecycle, risk ratings, and mitigation effectiveness"
  source: "`airlines_ecm`.`safety`.`hazard`"
  dimensions:
    - name: "identified_date"
      expr: identified_date
      comment: "Date when the hazard was first identified"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year of hazard identification"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month of hazard identification"
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current status of the hazard (open, mitigated, closed, etc.)"
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of the hazard"
    - name: "subcategory"
      expr: subcategory
      comment: "Subcategory of the hazard for detailed classification"
    - name: "identification_source"
      expr: identification_source
      comment: "Source through which the hazard was identified"
    - name: "initial_severity_rating"
      expr: initial_severity_rating
      comment: "Initial severity rating when hazard was first assessed"
    - name: "initial_likelihood_rating"
      expr: initial_likelihood_rating
      comment: "Initial likelihood rating when hazard was first assessed"
    - name: "current_severity_rating"
      expr: current_severity_rating
      comment: "Current severity rating after mitigation actions"
    - name: "current_likelihood_rating"
      expr: current_likelihood_rating
      comment: "Current likelihood rating after mitigation actions"
    - name: "affected_operations_area"
      expr: affected_operations_area
      comment: "Operational area affected by the hazard"
    - name: "affected_station"
      expr: affected_station
      comment: "Station affected by the hazard"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the hazard is reportable to regulatory authorities"
  measures:
    - name: "total_hazards"
      expr: COUNT(hazard_id)
      comment: "Total number of hazards identified"
    - name: "open_hazards"
      expr: COUNT(DISTINCT CASE WHEN hazard_status IN ('open', 'active', 'under review') THEN hazard_id END)
      comment: "Number of hazards currently open and requiring action"
    - name: "closed_hazards"
      expr: COUNT(DISTINCT CASE WHEN hazard_status = 'closed' THEN hazard_id END)
      comment: "Number of hazards that have been closed"
    - name: "mitigated_hazards"
      expr: COUNT(DISTINCT CASE WHEN hazard_status = 'mitigated' THEN hazard_id END)
      comment: "Number of hazards that have been successfully mitigated"
    - name: "regulatory_reportable_hazards"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN hazard_id END)
      comment: "Number of hazards requiring regulatory reporting"
    - name: "hazards_requiring_sop_revision"
      expr: COUNT(DISTINCT CASE WHEN sop_revision_required_flag = TRUE THEN hazard_id END)
      comment: "Number of hazards that require standard operating procedure revisions"
    - name: "hazards_with_notam"
      expr: COUNT(DISTINCT CASE WHEN notam_issued_flag = TRUE THEN hazard_id END)
      comment: "Number of hazards for which a Notice to Airmen was issued"
    - name: "overdue_hazards"
      expr: COUNT(DISTINCT CASE WHEN mitigation_target_date < CURRENT_DATE() AND hazard_status NOT IN ('closed', 'mitigated') THEN hazard_id END)
      comment: "Number of hazards past their mitigation target date and still open"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment metrics tracking risk evaluation, scoring, and control effectiveness across safety management system"
  source: "`airlines_ecm`.`safety`.`risk_assessment`"
  dimensions:
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date when the risk assessment was performed"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of risk assessment"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of risk assessment"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment conducted"
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for the risk assessment"
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk being assessed"
    - name: "risk_matrix_quadrant"
      expr: risk_matrix_quadrant
      comment: "Quadrant in the risk matrix (e.g., high severity/high likelihood)"
    - name: "risk_tolerance_level"
      expr: risk_tolerance_level
      comment: "Organizational tolerance level for this risk"
    - name: "likelihood_score"
      expr: likelihood_score
      comment: "Likelihood score assigned in the assessment"
    - name: "severity_score"
      expr: severity_score
      comment: "Severity score assigned in the assessment"
    - name: "regulatory_authority_notified_flag"
      expr: regulatory_authority_notified_flag
      comment: "Whether regulatory authority was notified of this risk"
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(risk_assessment_id)
      comment: "Total number of risk assessments conducted"
    - name: "completed_risk_assessments"
      expr: COUNT(DISTINCT CASE WHEN assessment_status = 'completed' THEN risk_assessment_id END)
      comment: "Number of risk assessments that have been completed"
    - name: "in_progress_risk_assessments"
      expr: COUNT(DISTINCT CASE WHEN assessment_status = 'in progress' THEN risk_assessment_id END)
      comment: "Number of risk assessments currently in progress"
    - name: "high_risk_assessments"
      expr: COUNT(DISTINCT CASE WHEN risk_matrix_quadrant LIKE '%high%' THEN risk_assessment_id END)
      comment: "Number of assessments identifying high-risk scenarios"
    - name: "assessments_notified_to_regulator"
      expr: COUNT(DISTINCT CASE WHEN regulatory_authority_notified_flag = TRUE THEN risk_assessment_id END)
      comment: "Number of risk assessments that required regulatory notification"
    - name: "overdue_reviews"
      expr: COUNT(DISTINCT CASE WHEN next_review_due_date < CURRENT_DATE() AND assessment_status != 'closed' THEN risk_assessment_id END)
      comment: "Number of risk assessments past their review due date"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety investigation metrics tracking investigation lifecycle, completion rates, and corrective action effectiveness"
  source: "`airlines_ecm`.`safety`.`investigation`"
  dimensions:
    - name: "start_date"
      expr: start_date
      comment: "Date when the investigation was initiated"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year investigation started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month investigation started"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation"
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (e.g., accident, incident, audit finding)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the investigation"
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification for this investigation"
    - name: "cvr_fdr_data_reviewed"
      expr: cvr_fdr_data_reviewed
      comment: "Whether cockpit voice recorder or flight data recorder data was reviewed"
    - name: "external_expert_consulted"
      expr: external_expert_consulted
      comment: "Whether external experts were consulted during investigation"
    - name: "risk_assessment_updated"
      expr: risk_assessment_updated
      comment: "Whether risk assessment was updated as a result of investigation"
  measures:
    - name: "total_investigations"
      expr: COUNT(investigation_id)
      comment: "Total number of safety investigations initiated"
    - name: "completed_investigations"
      expr: COUNT(DISTINCT CASE WHEN investigation_status = 'completed' THEN investigation_id END)
      comment: "Number of investigations that have been completed"
    - name: "in_progress_investigations"
      expr: COUNT(DISTINCT CASE WHEN investigation_status = 'in progress' THEN investigation_id END)
      comment: "Number of investigations currently in progress"
    - name: "overdue_investigations"
      expr: COUNT(DISTINCT CASE WHEN target_completion_date < CURRENT_DATE() AND investigation_status != 'completed' THEN investigation_id END)
      comment: "Number of investigations past their target completion date"
    - name: "investigations_with_fdr_review"
      expr: COUNT(DISTINCT CASE WHEN cvr_fdr_data_reviewed = TRUE THEN investigation_id END)
      comment: "Number of investigations that included flight data recorder review"
    - name: "investigations_with_external_experts"
      expr: COUNT(DISTINCT CASE WHEN external_expert_consulted = TRUE THEN investigation_id END)
      comment: "Number of investigations that required external expert consultation"
    - name: "investigations_updating_risk_assessment"
      expr: COUNT(DISTINCT CASE WHEN risk_assessment_updated = TRUE THEN investigation_id END)
      comment: "Number of investigations that resulted in risk assessment updates"
    - name: "total_investigation_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all investigations"
    - name: "avg_investigation_cost"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per investigation"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action metrics tracking action implementation, effectiveness, and closure rates for safety improvements"
  source: "`airlines_ecm`.`safety`.`corrective_action`"
  dimensions:
    - name: "target_completion_date"
      expr: target_completion_date
      comment: "Target date for completing the corrective action"
    - name: "actual_completion_date"
      expr: actual_completion_date
      comment: "Actual date when the corrective action was completed"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action"
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (immediate, preventive, systemic, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the corrective action"
    - name: "source_type"
      expr: source_type
      comment: "Source that triggered the corrective action (audit, occurrence, hazard, etc.)"
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for implementing the corrective action"
    - name: "verification_status"
      expr: verification_status
      comment: "Status of verification that the action was effective"
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Rating of how effective the corrective action was"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the corrective action"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost tracking"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(corrective_action_id)
      comment: "Total number of corrective actions initiated"
    - name: "completed_corrective_actions"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_status = 'completed' THEN corrective_action_id END)
      comment: "Number of corrective actions that have been completed"
    - name: "in_progress_corrective_actions"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_status = 'in progress' THEN corrective_action_id END)
      comment: "Number of corrective actions currently in progress"
    - name: "overdue_corrective_actions"
      expr: COUNT(DISTINCT CASE WHEN target_completion_date < CURRENT_DATE() AND corrective_action_status NOT IN ('completed', 'closed') THEN corrective_action_id END)
      comment: "Number of corrective actions past their target completion date"
    - name: "verified_corrective_actions"
      expr: COUNT(DISTINCT CASE WHEN verification_status = 'verified' THEN corrective_action_id END)
      comment: "Number of corrective actions that have been verified as effective"
    - name: "closed_corrective_actions"
      expr: COUNT(DISTINCT CASE WHEN closure_status = 'closed' THEN corrective_action_id END)
      comment: "Number of corrective actions that have been formally closed"
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all corrective actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions"
    - name: "avg_corrective_action_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety audit metrics tracking audit completion, findings severity distribution, and corrective action plan effectiveness"
  source: "`airlines_ecm`.`safety`.`audit`"
  dimensions:
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of the audit"
    - name: "actual_start_date"
      expr: actual_start_date
      comment: "Actual start date of the audit"
    - name: "audit_year"
      expr: YEAR(actual_start_date)
      comment: "Year the audit was conducted"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month the audit was conducted"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, IOSA, regulatory, etc.)"
    - name: "audited_department"
      expr: audited_department
      comment: "Department that was audited"
    - name: "audited_function"
      expr: audited_function
      comment: "Function that was audited"
    - name: "audited_station_code"
      expr: audited_station_code
      comment: "Station code where audit was conducted"
    - name: "regulatory_authority_name"
      expr: regulatory_authority_name
      comment: "Name of regulatory authority conducting or overseeing the audit"
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required
      comment: "Whether a corrective action plan is required"
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Whether a follow-up audit is required"
  measures:
    - name: "total_audits"
      expr: COUNT(audit_id)
      comment: "Total number of audits conducted"
    - name: "completed_audits"
      expr: COUNT(DISTINCT CASE WHEN audit_status = 'completed' THEN audit_id END)
      comment: "Number of audits that have been completed"
    - name: "in_progress_audits"
      expr: COUNT(DISTINCT CASE WHEN audit_status = 'in progress' THEN audit_id END)
      comment: "Number of audits currently in progress"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total number of critical findings across all audits"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total number of major findings across all audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS BIGINT))
      comment: "Total number of minor findings across all audits"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS BIGINT))
      comment: "Total number of all findings across all audits"
    - name: "audits_requiring_cap"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_plan_required = TRUE THEN audit_id END)
      comment: "Number of audits requiring a corrective action plan"
    - name: "audits_requiring_followup"
      expr: COUNT(DISTINCT CASE WHEN follow_up_audit_required = TRUE THEN audit_id END)
      comment: "Number of audits requiring a follow-up audit"
    - name: "overdue_cap_audits"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_plan_due_date < CURRENT_DATE() AND audit_status != 'closed' THEN audit_id END)
      comment: "Number of audits with overdue corrective action plans"
    - name: "avg_findings_per_audit"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average number of findings per audit"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_wildlife_strike`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wildlife strike metrics tracking strike frequency, damage severity, aircraft downtime, and repair costs for operational and safety planning"
  source: "`airlines_ecm`.`safety`.`wildlife_strike`"
  dimensions:
    - name: "damage_level"
      expr: damage_level
      comment: "Level of damage caused by the wildlife strike"
    - name: "aircraft_part_struck"
      expr: aircraft_part_struck
      comment: "Part of the aircraft that was struck"
    - name: "species_identified"
      expr: species_identified
      comment: "Species of wildlife involved in the strike"
    - name: "engine_ingestion_flag"
      expr: engine_ingestion_flag
      comment: "Whether the wildlife was ingested into an engine"
    - name: "effect_on_flight"
      expr: effect_on_flight
      comment: "Effect the strike had on the flight (none, precautionary landing, aborted takeoff, etc.)"
    - name: "sky_condition"
      expr: sky_condition
      comment: "Sky condition at the time of strike"
    - name: "precipitation"
      expr: precipitation
      comment: "Precipitation at the time of strike"
    - name: "pilot_warned_flag"
      expr: pilot_warned_flag
      comment: "Whether the pilot was warned of wildlife presence"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the strike is reportable to regulatory authorities"
    - name: "remains_collected_flag"
      expr: remains_collected_flag
      comment: "Whether wildlife remains were collected"
    - name: "remains_sent_to_lab_flag"
      expr: remains_sent_to_lab_flag
      comment: "Whether remains were sent to a lab for identification"
  measures:
    - name: "total_wildlife_strikes"
      expr: COUNT(wildlife_strike_id)
      comment: "Total number of wildlife strikes reported"
    - name: "strikes_with_damage"
      expr: COUNT(DISTINCT CASE WHEN damage_level IS NOT NULL AND damage_level != 'none' THEN wildlife_strike_id END)
      comment: "Number of wildlife strikes that caused damage"
    - name: "strikes_with_engine_ingestion"
      expr: COUNT(DISTINCT CASE WHEN engine_ingestion_flag = TRUE THEN wildlife_strike_id END)
      comment: "Number of strikes involving engine ingestion"
    - name: "strikes_affecting_flight"
      expr: COUNT(DISTINCT CASE WHEN effect_on_flight IS NOT NULL AND effect_on_flight != 'none' THEN wildlife_strike_id END)
      comment: "Number of strikes that had an operational effect on the flight"
    - name: "regulatory_reportable_strikes"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN wildlife_strike_id END)
      comment: "Number of strikes requiring regulatory reporting"
    - name: "total_aircraft_downtime_hours"
      expr: SUM(CAST(aircraft_out_of_service_hours AS DOUBLE))
      comment: "Total aircraft out-of-service hours due to wildlife strikes"
    - name: "total_repair_hours"
      expr: SUM(CAST(repair_hours AS DOUBLE))
      comment: "Total repair hours required for wildlife strike damage"
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated cost in USD of wildlife strike damage and repairs"
    - name: "avg_cost_per_strike"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost per wildlife strike"
    - name: "avg_downtime_per_strike"
      expr: AVG(CAST(aircraft_out_of_service_hours AS DOUBLE))
      comment: "Average aircraft downtime hours per wildlife strike"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`safety_spi_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety Performance Indicator measurement metrics tracking KPI achievement, threshold breaches, and trend analysis for safety management oversight"
  source: "`airlines_ecm`.`safety`.`spi_measurement`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the SPI measurement"
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Year of measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (daily, weekly, monthly, quarterly, annual)"
    - name: "reporting_period_year"
      expr: reporting_period_year
      comment: "Reporting year for the measurement"
    - name: "reporting_period_quarter"
      expr: reporting_period_quarter
      comment: "Reporting quarter for the measurement"
    - name: "reporting_period_month"
      expr: reporting_period_month
      comment: "Reporting month for the measurement"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (draft, approved, published, etc.)"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the measurement"
    - name: "target_met_flag"
      expr: target_met_flag
      comment: "Whether the target was met for this measurement"
    - name: "alert_threshold_breached_flag"
      expr: alert_threshold_breached_flag
      comment: "Whether the alert threshold was breached"
    - name: "warning_threshold_breached_flag"
      expr: warning_threshold_breached_flag
      comment: "Whether the warning threshold was breached"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required based on this measurement"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required for this measurement"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of the trend (improving, stable, deteriorating)"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for the measurement"
  measures:
    - name: "total_measurements"
      expr: COUNT(spi_measurement_id)
      comment: "Total number of SPI measurements recorded"
    - name: "measurements_meeting_target"
      expr: COUNT(DISTINCT CASE WHEN target_met_flag = TRUE THEN spi_measurement_id END)
      comment: "Number of measurements that met their target"
    - name: "measurements_breaching_alert"
      expr: COUNT(DISTINCT CASE WHEN alert_threshold_breached_flag = TRUE THEN spi_measurement_id END)
      comment: "Number of measurements that breached the alert threshold"
    - name: "measurements_breaching_warning"
      expr: COUNT(DISTINCT CASE WHEN warning_threshold_breached_flag = TRUE THEN spi_measurement_id END)
      comment: "Number of measurements that breached the warning threshold"
    - name: "measurements_requiring_corrective_action"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required_flag = TRUE THEN spi_measurement_id END)
      comment: "Number of measurements requiring corrective action"
    - name: "measurements_requiring_regulatory_reporting"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reporting_required_flag = TRUE THEN spi_measurement_id END)
      comment: "Number of measurements requiring regulatory reporting"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value across all measurements"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across all measurements"
    - name: "avg_variance_from_target"
      expr: AVG(CAST(variance_from_target AS DOUBLE))
      comment: "Average variance from target across all measurements"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage from target"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across measurements"
$$;