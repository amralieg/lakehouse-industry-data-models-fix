-- Metric views for domain: scheduling | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appointment volume and no‑show count per care site, clinician, appointment type and month"
  source: "`healthcare_ecm`.`scheduling`.`scheduling_appointment`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site where the appointment is scheduled"
    - name: "clinician_id"
      expr: clinician_id
      comment: "Identifier of the clinician assigned to the appointment"
    - name: "appointment_type_id"
      expr: appointment_type_id
      comment: "Identifier of the appointment type"
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (e.g., scheduled, cancelled, completed)"
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of the scheduled appointment date"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of scheduled appointments"
    - name: "no_show_appointments"
      expr: SUM(CASE WHEN no_show_flag THEN 1 ELSE 0 END)
      comment: "Count of appointments where the patient did not show up"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_appointment_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks financial and operational impact of appointment status transitions"
  source: "`healthcare_ecm`.`scheduling`.`appointment_status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "The status an appointment transitioned to"
    - name: "prior_status"
      expr: prior_status
      comment: "The status an appointment transitioned from"
    - name: "transition_month"
      expr: DATE_TRUNC('month', transition_timestamp)
      comment: "Month of the status transition event"
  measures:
    - name: "status_change_count"
      expr: COUNT(1)
      comment: "Number of appointment status change events"
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Sum of estimated revenue impact from status changes"
    - name: "total_no_show_penalty_amount"
      expr: SUM(CAST(no_show_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties applied for no‑shows"
    - name: "no_show_penalty_applied_count"
      expr: SUM(CASE WHEN no_show_penalty_applied THEN 1 ELSE 0 END)
      comment: "Count of status changes where a no‑show penalty was applied"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_block_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency of OR/clinical blocks"
  source: "`healthcare_ecm`.`scheduling`.`block_utilization`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the block is defined"
    - name: "clinician_id"
      expr: clinician_id
      comment: "Clinician assigned to the block"
    - name: "or_block_id"
      expr: or_block_id
      comment: "Identifier of the OR block"
    - name: "block_date"
      expr: utilization_date
      comment: "Date of block utilization"
    - name: "block_status"
      expr: block_status
      comment: "Current status of the block (e.g., active, cancelled)"
  measures:
    - name: "avg_turnover_minutes"
      expr: AVG(CAST(average_turnover_minutes AS DOUBLE))
      comment: "Average turnover time (minutes) between cases in a block"
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average block utilization percentage"
    - name: "total_target_utilization_percentage"
      expr: SUM(CAST(target_utilization_percentage AS DOUBLE))
      comment: "Sum of target utilization percentages for planning"
$$;