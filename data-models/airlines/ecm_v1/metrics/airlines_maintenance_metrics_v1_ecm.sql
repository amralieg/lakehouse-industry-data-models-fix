-- Metric views for domain: maintenance | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core maintenance work order execution metrics tracking labor efficiency, cost performance, and operational disruption"
  source: "`airlines_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (open, in progress, completed, cancelled)"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of maintenance work (scheduled, unscheduled, modification, inspection)"
    - name: "priority_level"
      expr: priority_level
      comment: "Work order priority classification (critical, high, medium, low)"
    - name: "ata_chapter_code"
      expr: ata_chapter_code
      comment: "ATA chapter code identifying the aircraft system affected"
    - name: "aog_flag"
      expr: aog_flag
      comment: "Aircraft on ground flag indicating critical grounding event"
    - name: "maintenance_check_type"
      expr: maintenance_check_type
      comment: "Type of maintenance check (A-check, B-check, C-check, D-check)"
    - name: "completion_year"
      expr: YEAR(actual_completion_timestamp)
      comment: "Year when work order was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_timestamp)
      comment: "Month when work order was completed"
    - name: "scheduled_start_year"
      expr: YEAR(scheduled_start_timestamp)
      comment: "Year when work order was scheduled to start"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost across all work orders"
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost across all work orders"
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost across all work orders"
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all work orders"
    - name: "total_actual_man_hours"
      expr: SUM(CAST(actual_man_hours AS DOUBLE))
      comment: "Total actual man-hours consumed across all work orders"
    - name: "total_estimated_man_hours"
      expr: SUM(CAST(estimated_man_hours AS DOUBLE))
      comment: "Total estimated man-hours planned across all work orders"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total aircraft downtime hours caused by maintenance work orders"
    - name: "avg_actual_man_hours"
      expr: AVG(CAST(actual_man_hours AS DOUBLE))
      comment: "Average actual man-hours per work order"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average aircraft downtime hours per work order"
    - name: "aog_work_orders"
      expr: COUNT(CASE WHEN aog_flag = TRUE THEN 1 END)
      comment: "Count of work orders that caused aircraft on ground events"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_aog_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aircraft on ground event metrics tracking operational disruption, recovery performance, and revenue impact"
  source: "`airlines_ecm`.`maintenance`.`aog_event`"
  dimensions:
    - name: "aog_status"
      expr: aog_status
      comment: "Current status of the AOG event (active, resolved, escalated)"
    - name: "aog_severity_level"
      expr: aog_severity_level
      comment: "Severity classification of the AOG event"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the grounding event"
    - name: "ata_chapter"
      expr: ata_chapter
      comment: "ATA chapter code of the system that caused the AOG"
    - name: "vendor_support_required_flag"
      expr: vendor_support_required_flag
      comment: "Flag indicating whether external vendor support was required"
    - name: "declaration_year"
      expr: YEAR(aog_declaration_timestamp)
      comment: "Year when AOG was declared"
    - name: "declaration_month"
      expr: DATE_TRUNC('MONTH', aog_declaration_timestamp)
      comment: "Month when AOG was declared"
  measures:
    - name: "total_aog_events"
      expr: COUNT(1)
      comment: "Total number of aircraft on ground events"
    - name: "total_aog_duration_hours"
      expr: SUM(CAST(aog_duration_hours AS DOUBLE))
      comment: "Total aircraft grounding duration in hours across all AOG events"
    - name: "avg_aog_duration_hours"
      expr: AVG(CAST(aog_duration_hours AS DOUBLE))
      comment: "Average duration in hours per AOG event"
    - name: "total_estimated_revenue_impact_usd"
      expr: SUM(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Total estimated revenue loss from all AOG events in USD"
    - name: "avg_estimated_revenue_impact_usd"
      expr: AVG(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Average estimated revenue loss per AOG event in USD"
    - name: "aog_with_vendor_support"
      expr: COUNT(CASE WHEN vendor_support_required_flag = TRUE THEN 1 END)
      comment: "Count of AOG events requiring external vendor support"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_defect_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect reporting and rectification metrics tracking maintenance quality, safety compliance, and MEL deferral management"
  source: "`airlines_ecm`.`maintenance`.`defect_report`"
  dimensions:
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of the defect (open, deferred, rectified, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the defect"
    - name: "ata_chapter"
      expr: ata_chapter
      comment: "ATA chapter code of the affected aircraft system"
    - name: "aog_flag"
      expr: aog_flag
      comment: "Flag indicating whether defect caused aircraft on ground event"
    - name: "mel_applicable_flag"
      expr: mel_applicable_flag
      comment: "Flag indicating whether MEL deferral is applicable"
    - name: "mel_category"
      expr: mel_category
      comment: "MEL category classification (A, B, C, D)"
    - name: "safety_reportable_flag"
      expr: safety_reportable_flag
      comment: "Flag indicating whether defect is reportable to safety authorities"
    - name: "discovery_phase"
      expr: discovery_phase
      comment: "Flight phase when defect was discovered"
    - name: "discovery_year"
      expr: YEAR(discovery_timestamp)
      comment: "Year when defect was discovered"
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_timestamp)
      comment: "Month when defect was discovered"
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defect reports"
    - name: "aog_defects"
      expr: COUNT(CASE WHEN aog_flag = TRUE THEN 1 END)
      comment: "Count of defects that caused aircraft on ground events"
    - name: "mel_deferred_defects"
      expr: COUNT(CASE WHEN mel_applicable_flag = TRUE THEN 1 END)
      comment: "Count of defects deferred under MEL provisions"
    - name: "safety_reportable_defects"
      expr: COUNT(CASE WHEN safety_reportable_flag = TRUE THEN 1 END)
      comment: "Count of defects requiring safety authority reporting"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduled maintenance check execution metrics tracking check performance, cost efficiency, and compliance"
  source: "`airlines_ecm`.`maintenance`.`check`"
  dimensions:
    - name: "check_status"
      expr: check_status
      comment: "Current status of the maintenance check"
    - name: "check_type"
      expr: check_type
      comment: "Type of maintenance check (A-check, B-check, C-check, D-check, line, base)"
    - name: "aog_event_flag"
      expr: aog_event_flag
      comment: "Flag indicating whether check resulted in AOG event"
    - name: "actual_release_year"
      expr: YEAR(actual_release_date)
      comment: "Year when aircraft was released from check"
    - name: "actual_release_month"
      expr: DATE_TRUNC('MONTH', actual_release_date)
      comment: "Month when aircraft was released from check"
    - name: "scheduled_induction_year"
      expr: YEAR(scheduled_induction_date)
      comment: "Year when check was scheduled to begin"
  measures:
    - name: "total_checks"
      expr: COUNT(1)
      comment: "Total number of maintenance checks"
    - name: "total_check_cost"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total cost of all maintenance checks"
    - name: "avg_check_cost"
      expr: AVG(CAST(total_cost_amount AS DOUBLE))
      comment: "Average cost per maintenance check"
    - name: "total_actual_man_hours"
      expr: SUM(CAST(actual_man_hours AS DOUBLE))
      comment: "Total actual man-hours consumed across all checks"
    - name: "total_planned_man_hours"
      expr: SUM(CAST(planned_man_hours AS DOUBLE))
      comment: "Total planned man-hours across all checks"
    - name: "avg_actual_man_hours"
      expr: AVG(CAST(actual_man_hours AS DOUBLE))
      comment: "Average actual man-hours per check"
    - name: "total_downtime_days"
      expr: SUM(CAST(downtime_days AS DOUBLE))
      comment: "Total aircraft downtime in days across all checks"
    - name: "avg_downtime_days"
      expr: AVG(CAST(downtime_days AS DOUBLE))
      comment: "Average aircraft downtime in days per check"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component lifecycle and airworthiness metrics tracking utilization, remaining life, and asset value"
  source: "`airlines_ecm`.`maintenance`.`component`"
  dimensions:
    - name: "serviceable_status"
      expr: serviceable_status
      comment: "Current serviceability status of the component"
    - name: "condition_code"
      expr: condition_code
      comment: "Condition code classification of the component"
    - name: "ata_chapter"
      expr: ata_chapter
      comment: "ATA chapter code of the component"
    - name: "life_limited_part_flag"
      expr: life_limited_part_flag
      comment: "Flag indicating whether component is life-limited"
    - name: "rotable_flag"
      expr: rotable_flag
      comment: "Flag indicating whether component is rotable (repairable)"
    - name: "criticality_classification"
      expr: criticality_classification
      comment: "Criticality classification of the component"
    - name: "current_location_type"
      expr: current_location_type
      comment: "Type of current location (aircraft, warehouse, repair shop)"
    - name: "owner_type"
      expr: owner_type
      comment: "Ownership type of the component (owned, leased, pooled)"
    - name: "manufacture_year"
      expr: YEAR(manufacture_date)
      comment: "Year when component was manufactured"
  measures:
    - name: "total_components"
      expr: COUNT(1)
      comment: "Total number of components in inventory"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all components"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per component"
    - name: "total_time_since_new"
      expr: SUM(CAST(total_time_since_new AS DOUBLE))
      comment: "Total accumulated flight hours since new across all components"
    - name: "avg_time_since_new"
      expr: AVG(CAST(total_time_since_new AS DOUBLE))
      comment: "Average flight hours since new per component"
    - name: "total_time_since_overhaul"
      expr: SUM(CAST(time_since_overhaul AS DOUBLE))
      comment: "Total accumulated flight hours since last overhaul across all components"
    - name: "avg_time_remaining_to_limit"
      expr: AVG(CAST(time_remaining_to_limit AS DOUBLE))
      comment: "Average remaining flight hours to life limit per component"
    - name: "life_limited_components"
      expr: COUNT(CASE WHEN life_limited_part_flag = TRUE THEN 1 END)
      comment: "Count of life-limited parts requiring lifecycle tracking"
    - name: "rotable_components"
      expr: COUNT(CASE WHEN rotable_flag = TRUE THEN 1 END)
      comment: "Count of rotable (repairable) components"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_mel_deferral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MEL deferral management metrics tracking deferral utilization, expiry risk, and operational restrictions"
  source: "`airlines_ecm`.`maintenance`.`mel_deferral`"
  dimensions:
    - name: "deferral_status"
      expr: deferral_status
      comment: "Current status of the MEL deferral (open, extended, closed)"
    - name: "mel_category"
      expr: mel_category
      comment: "MEL category classification (A, B, C, D)"
    - name: "aog_risk_flag"
      expr: aog_risk_flag
      comment: "Flag indicating elevated AOG risk from this deferral"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag indicating whether regulatory notification is required"
    - name: "deferral_open_year"
      expr: YEAR(deferral_open_date)
      comment: "Year when deferral was opened"
    - name: "deferral_open_month"
      expr: DATE_TRUNC('MONTH', deferral_open_date)
      comment: "Month when deferral was opened"
    - name: "deferral_expiry_year"
      expr: YEAR(deferral_expiry_date)
      comment: "Year when deferral expires"
  measures:
    - name: "total_deferrals"
      expr: COUNT(1)
      comment: "Total number of MEL deferrals"
    - name: "total_flight_hours_at_deferral"
      expr: SUM(CAST(flight_hours_at_deferral AS DOUBLE))
      comment: "Total flight hours accumulated at time of deferral"
    - name: "avg_flight_hours_at_deferral"
      expr: AVG(CAST(flight_hours_at_deferral AS DOUBLE))
      comment: "Average flight hours at time of deferral"
    - name: "aog_risk_deferrals"
      expr: COUNT(CASE WHEN aog_risk_flag = TRUE THEN 1 END)
      comment: "Count of deferrals with elevated AOG risk"
    - name: "regulatory_notification_deferrals"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Count of deferrals requiring regulatory notification"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance visit execution metrics tracking hangar visit performance, cost efficiency, and schedule adherence"
  source: "`airlines_ecm`.`maintenance`.`visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the maintenance visit"
    - name: "visit_type"
      expr: visit_type
      comment: "Type of maintenance visit (scheduled, unscheduled, modification)"
    - name: "check_type"
      expr: check_type
      comment: "Type of maintenance check performed during visit"
    - name: "delay_reason_category"
      expr: delay_reason_category
      comment: "Category of delay reason if visit was delayed"
    - name: "induction_year"
      expr: YEAR(induction_date)
      comment: "Year when aircraft was inducted for maintenance visit"
    - name: "induction_month"
      expr: DATE_TRUNC('MONTH', induction_date)
      comment: "Month when aircraft was inducted for maintenance visit"
    - name: "actual_release_year"
      expr: YEAR(actual_release_date)
      comment: "Year when aircraft was released from maintenance visit"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of maintenance visits"
    - name: "total_visit_cost_usd"
      expr: SUM(CAST(total_visit_cost_usd AS DOUBLE))
      comment: "Total cost of all maintenance visits in USD"
    - name: "avg_visit_cost_usd"
      expr: AVG(CAST(total_visit_cost_usd AS DOUBLE))
      comment: "Average cost per maintenance visit in USD"
    - name: "total_labour_cost_usd"
      expr: SUM(CAST(total_labour_cost_usd AS DOUBLE))
      comment: "Total labor cost across all visits in USD"
    - name: "total_material_cost_usd"
      expr: SUM(CAST(total_material_cost_usd AS DOUBLE))
      comment: "Total material cost across all visits in USD"
    - name: "total_man_hours_actual"
      expr: SUM(CAST(total_man_hours_actual AS DOUBLE))
      comment: "Total actual man-hours consumed across all visits"
    - name: "total_man_hours_planned"
      expr: SUM(CAST(total_man_hours_planned AS DOUBLE))
      comment: "Total planned man-hours across all visits"
    - name: "avg_man_hours_actual"
      expr: AVG(CAST(total_man_hours_actual AS DOUBLE))
      comment: "Average actual man-hours per visit"
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_hours AS DOUBLE))
      comment: "Total delay hours across all visits"
    - name: "avg_delay_hours"
      expr: AVG(CAST(delay_hours AS DOUBLE))
      comment: "Average delay hours per visit"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_ad_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Airworthiness directive compliance metrics tracking regulatory adherence, accomplishment performance, and repetitive AD management"
  source: "`airlines_ecm`.`maintenance`.`ad_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the airworthiness directive"
    - name: "compliance_method"
      expr: compliance_method
      comment: "Method used to comply with the AD"
    - name: "repetitive_flag"
      expr: repetitive_flag
      comment: "Flag indicating whether AD requires repetitive compliance"
    - name: "accomplishment_year"
      expr: YEAR(accomplishment_date)
      comment: "Year when AD was accomplished"
    - name: "accomplishment_month"
      expr: DATE_TRUNC('MONTH', accomplishment_date)
      comment: "Month when AD was accomplished"
    - name: "next_due_year"
      expr: YEAR(next_due_date)
      comment: "Year when next AD compliance is due"
  measures:
    - name: "total_ad_compliance_records"
      expr: COUNT(1)
      comment: "Total number of AD compliance records"
    - name: "total_accomplishment_flight_hours"
      expr: SUM(CAST(accomplishment_flight_hours AS DOUBLE))
      comment: "Total flight hours at time of AD accomplishment"
    - name: "avg_accomplishment_flight_hours"
      expr: AVG(CAST(accomplishment_flight_hours AS DOUBLE))
      comment: "Average flight hours at time of AD accomplishment"
    - name: "total_next_due_flight_hours"
      expr: SUM(CAST(next_due_flight_hours AS DOUBLE))
      comment: "Total flight hours when next AD compliance is due"
    - name: "total_repetitive_interval_hours"
      expr: SUM(CAST(repetitive_interval_hours AS DOUBLE))
      comment: "Total repetitive interval hours for recurring ADs"
    - name: "repetitive_ads"
      expr: COUNT(CASE WHEN repetitive_flag = TRUE THEN 1 END)
      comment: "Count of airworthiness directives requiring repetitive compliance"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_reliability_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability event metrics tracking chronic issues, repeat failures, and maintenance effectiveness"
  source: "`airlines_ecm`.`maintenance`.`reliability_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the reliability event"
    - name: "event_type"
      expr: event_type
      comment: "Type of reliability event"
    - name: "ata_chapter"
      expr: ata_chapter
      comment: "ATA chapter code of the affected system"
    - name: "chronic_event_flag"
      expr: chronic_event_flag
      comment: "Flag indicating chronic recurring event"
    - name: "repeat_event_flag"
      expr: repeat_event_flag
      comment: "Flag indicating repeat occurrence of same event"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the reliability event"
    - name: "alert_level"
      expr: alert_level
      comment: "Alert level classification of the event"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year when reliability event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month when reliability event occurred"
  measures:
    - name: "total_reliability_events"
      expr: COUNT(1)
      comment: "Total number of reliability events"
    - name: "chronic_events"
      expr: COUNT(CASE WHEN chronic_event_flag = TRUE THEN 1 END)
      comment: "Count of chronic recurring reliability events"
    - name: "repeat_events"
      expr: COUNT(CASE WHEN repeat_event_flag = TRUE THEN 1 END)
      comment: "Count of repeat reliability events"
    - name: "total_aircraft_hours_at_event"
      expr: SUM(CAST(aircraft_total_hours_at_event AS DOUBLE))
      comment: "Total aircraft flight hours at time of reliability events"
    - name: "avg_aircraft_hours_at_event"
      expr: AVG(CAST(aircraft_total_hours_at_event AS DOUBLE))
      comment: "Average aircraft flight hours at time of reliability event"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance forecast metrics tracking planning accuracy, cost projections, and resource requirements"
  source: "`airlines_ecm`.`maintenance`.`forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the maintenance forecast"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of maintenance forecast"
    - name: "ata_chapter"
      expr: ata_chapter
      comment: "ATA chapter code of the forecasted maintenance"
    - name: "hangar_slot_reservation_required"
      expr: hangar_slot_reservation_required
      comment: "Flag indicating whether hangar slot reservation is required"
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the forecast"
    - name: "projected_due_year"
      expr: YEAR(projected_due_date)
      comment: "Year when maintenance is projected to be due"
    - name: "projected_due_month"
      expr: DATE_TRUNC('MONTH', projected_due_date)
      comment: "Month when maintenance is projected to be due"
  measures:
    - name: "total_forecasts"
      expr: COUNT(1)
      comment: "Total number of maintenance forecasts"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of forecasted maintenance in USD"
    - name: "avg_estimated_cost_usd"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average estimated cost per forecast in USD"
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for forecasted maintenance"
    - name: "avg_estimated_labor_hours"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per forecast"
    - name: "total_remaining_flight_hours"
      expr: SUM(CAST(remaining_flight_hours AS DOUBLE))
      comment: "Total remaining flight hours until forecasted maintenance is due"
    - name: "avg_remaining_flight_hours"
      expr: AVG(CAST(remaining_flight_hours AS DOUBLE))
      comment: "Average remaining flight hours until maintenance is due"
    - name: "hangar_slot_required_forecasts"
      expr: COUNT(CASE WHEN hangar_slot_reservation_required = TRUE THEN 1 END)
      comment: "Count of forecasts requiring hangar slot reservation"
$$;