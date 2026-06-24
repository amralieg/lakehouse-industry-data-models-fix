-- Metric views for domain: scheduling | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_block_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OR block utilization KPIs for perioperative leadership: measures how efficiently allocated operating-room block time is consumed versus target, a primary driver of surgical margin and capacity decisions."
  source: "`vibe_healthcare_v1`.`scheduling`.`block_utilization`"
  dimensions:
    - name: "utilization_date"
      expr: DATE_TRUNC('DAY', utilization_date)
      comment: "Calendar day of the block utilization measurement for trend analysis."
    - name: "block_status"
      expr: block_status
      comment: "Lifecycle status of the OR block (e.g., active, released, cancelled) for filtering utilization."
    - name: "block_owner_type"
      expr: block_owner_type
      comment: "Type of block owner (service line, surgeon, group) to compare utilization across ownership models."
    - name: "owner_specialty_code"
      expr: owner_specialty_code
      comment: "Specialty owning the block, enabling service-line capacity benchmarking."
    - name: "prime_time_flag"
      expr: prime_time_flag
      comment: "Whether the block falls in prime operating hours, key to high-cost capacity decisions."
  measures:
    - name: "Block Count"
      expr: COUNT(1)
      comment: "Number of OR block utilization records, the denominator for block-level rates."
    - name: "Avg Utilization Pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average actual block utilization percentage; the core perioperative efficiency KPI."
    - name: "Avg Target Utilization Pct"
      expr: AVG(CAST(target_utilization_percentage AS DOUBLE))
      comment: "Average target utilization threshold to benchmark actuals against goal."
    - name: "Avg Utilization Variance Pct"
      expr: AVG(CAST(utilization_variance_percentage AS DOUBLE))
      comment: "Average gap between actual and target utilization, signalling over/under-allocation of block time."
    - name: "Avg Turnover Minutes"
      expr: AVG(CAST(average_turnover_minutes AS DOUBLE))
      comment: "Average room turnover time between cases; a key lever for adding case volume without new rooms."
    - name: "Blocks Meeting Threshold"
      expr: SUM(CASE WHEN meets_utilization_threshold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of blocks meeting the utilization threshold, used to compute compliance share."
    - name: "On Time First Case Count"
      expr: SUM(CASE WHEN first_case_on_time_start_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of blocks with an on-time first case start, the leading indicator of OR throughput discipline."
    - name: "Reallocation Risk Blocks"
      expr: SUM(CASE WHEN block_reallocation_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of blocks flagged for reallocation risk, driving capacity governance action."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_capacity_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinic and resource capacity utilization KPIs for operations leadership: tracks how scheduled and utilized hours compare to available capacity, informing staffing and access investment."
  source: "`vibe_healthcare_v1`.`scheduling`.`capacity_utilization`"
  dimensions:
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Start of the capacity planning period, bucketed monthly for trend reporting."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting (inpatient, ambulatory, etc.) to segment capacity performance."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Specialty being measured, enabling service-line access analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan to compare planning approaches."
    - name: "trend_indicator"
      expr: trend_indicator
      comment: "Directional trend flag for quick identification of improving/declining capacity."
  measures:
    - name: "Capacity Record Count"
      expr: COUNT(1)
      comment: "Number of capacity utilization records in scope."
    - name: "Avg Actual Utilization Rate Pct"
      expr: AVG(CAST(actual_utilization_rate_pct AS DOUBLE))
      comment: "Average actual capacity utilization rate; primary access and efficiency KPI."
    - name: "Avg Target Utilization Rate Pct"
      expr: AVG(CAST(target_utilization_rate_pct AS DOUBLE))
      comment: "Average target utilization rate to benchmark against actuals."
    - name: "Avg Variance Utilization Pct"
      expr: AVG(CAST(variance_utilization_pct AS DOUBLE))
      comment: "Average variance between actual and target utilization, flagging over/under capacity."
    - name: "Total Available Hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total available capacity hours, the denominator for utilization economics."
    - name: "Total Scheduled Hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours, indicating booking against available capacity."
    - name: "Total Utilized Hours"
      expr: SUM(CAST(utilized_hours AS DOUBLE))
      comment: "Total hours actually utilized, used with available hours to compute realized utilization."
    - name: "Total Variance Hours"
      expr: SUM(CAST(variance_hours AS DOUBLE))
      comment: "Total hour variance versus plan, quantifying wasted or over-extended capacity."
    - name: "Total Available FTE"
      expr: SUM(CAST(available_fte AS DOUBLE))
      comment: "Total available staffing FTE, linking capacity to workforce investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appointment status transition KPIs for access and revenue-cycle leadership: quantifies no-shows, cancellations, and their financial impact, a direct driver of access and net revenue."
  source: "`vibe_healthcare_v1`.`scheduling`.`appointment_status_history`"
  dimensions:
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month of the status transition for trend analysis of cancellation/no-show behavior."
    - name: "new_status"
      expr: new_status
      comment: "Resulting appointment status after the transition (e.g., no-show, cancelled, completed)."
    - name: "reason_category"
      expr: reason_category
      comment: "Category of the transition reason, enabling root-cause analysis of lost slots."
    - name: "transition_source"
      expr: transition_source
      comment: "Source of the transition (patient, staff, system) to target outreach interventions."
    - name: "within_policy_window"
      expr: within_policy_window
      comment: "Whether the change occurred within the cancellation policy window, relevant to penalty enforcement."
  measures:
    - name: "Status Transition Count"
      expr: COUNT(1)
      comment: "Total appointment status transitions, baseline for rate calculations."
    - name: "Total Estimated Revenue Impact"
      expr: SUM(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Total estimated revenue impact from status changes; quantifies financial exposure from cancellations/no-shows."
    - name: "Total No Show Penalty Amount"
      expr: SUM(CAST(no_show_penalty_amount AS DOUBLE))
      comment: "Total no-show penalty dollars assessed, a revenue-recovery and deterrence KPI."
    - name: "No Show Penalty Applied Count"
      expr: SUM(CASE WHEN no_show_penalty_applied = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transitions where a no-show penalty was applied, used for penalty enforcement rate."
    - name: "Patient Contacted Count"
      expr: SUM(CASE WHEN patient_contacted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transitions where the patient was contacted, measuring proactive outreach reach."
    - name: "Backfilled Slot Count"
      expr: SUM(CASE WHEN backfill_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of slots backfilled after cancellation, a recovery efficiency KPI for access teams."
    - name: "Within Policy Window Count"
      expr: SUM(CASE WHEN within_policy_window = TRUE THEN 1 ELSE 0 END)
      comment: "Count of changes within the policy window, used to compute policy-compliance share."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment_reminder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient appointment reminder KPIs for access and patient-engagement leadership: measures reminder delivery success and cost, directly tied to no-show reduction and engagement ROI."
  source: "`vibe_healthcare_v1`.`scheduling`.`appointment_reminder`"
  dimensions:
    - name: "appointment_date"
      expr: DATE_TRUNC('DAY', appointment_date)
      comment: "Scheduled appointment date for the reminder, for daily/weekly reminder volume trends."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel used to send the reminder (SMS, email, voice) to compare channel effectiveness."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome status of the reminder, key to delivery-rate KPIs."
    - name: "reminder_type"
      expr: reminder_type
      comment: "Type of reminder for segmentation of engagement performance."
    - name: "patient_response"
      expr: patient_response
      comment: "Patient response captured (confirmed, cancelled, no response), the engagement outcome dimension."
  measures:
    - name: "Reminder Count"
      expr: COUNT(1)
      comment: "Total reminders sent, baseline for delivery and engagement rates."
    - name: "Total Reminder Cost"
      expr: SUM(CAST(cost_per_reminder AS DOUBLE))
      comment: "Total cost of reminders, used to evaluate engagement program ROI against no-show savings."
    - name: "Avg Reminder Cost"
      expr: AVG(CAST(cost_per_reminder AS DOUBLE))
      comment: "Average cost per reminder, a unit-economics KPI for channel selection."
    - name: "Opt Out Count"
      expr: SUM(CASE WHEN opt_out_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients who opted out, a reachability erosion metric for engagement strategy."
    - name: "Distinct Patients Reminded"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients receiving reminders, measuring engagement program reach."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient access waitlist KPIs for ambulatory operations leadership: tracks waitlist volume, wait time, and escalations, a core access-to-care and patient-experience driver."
  source: "`vibe_healthcare_v1`.`scheduling`.`waitlist_entry`"
  dimensions:
    - name: "queue_entry_month"
      expr: DATE_TRUNC('MONTH', queue_entry_datetime)
      comment: "Month the patient entered the waitlist, for access trend reporting."
    - name: "entry_status"
      expr: entry_status
      comment: "Current waitlist entry status, used to segment active vs resolved demand."
    - name: "priority_level"
      expr: priority_level
      comment: "Clinical/operational priority of the waitlist entry for prioritized access management."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting of the requested service to compare access pressure across settings."
    - name: "specialty_required"
      expr: specialty_required
      comment: "Specialty required, identifying where access bottlenecks concentrate."
  measures:
    - name: "Waitlist Entry Count"
      expr: COUNT(1)
      comment: "Total waitlist entries, the headline measure of unmet appointment demand."
    - name: "Escalated Entry Count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated waitlist entries, signalling access risk requiring intervention."
    - name: "Authorization Required Count"
      expr: SUM(CASE WHEN authorization_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of entries requiring prior authorization, a process-friction KPI for scheduling throughput."
    - name: "Transportation Assistance Needed Count"
      expr: SUM(CASE WHEN transportation_assistance_needed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of entries needing transportation help, a health-equity and SDOH access indicator."
    - name: "Distinct Patients Waitlisted"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients on the waitlist, measuring true unique access demand."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_booking_queue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling booking queue KPIs for access center leadership: monitors queue aging, escalation, and outreach effectiveness that govern time-to-appointment and patient access SLAs."
  source: "`vibe_healthcare_v1`.`scheduling`.`booking_queue`"
  dimensions:
    - name: "queue_entry_month"
      expr: DATE_TRUNC('MONTH', queue_entry_datetime)
      comment: "Month a request entered the booking queue for trend analysis."
    - name: "queue_status"
      expr: queue_status
      comment: "Current booking queue status, separating open from resolved demand."
    - name: "queue_type"
      expr: queue_type
      comment: "Type of booking queue to compare workflows and SLAs."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the request for prioritized access management."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting of the requested service to segment access pressure."
  measures:
    - name: "Booking Queue Count"
      expr: COUNT(1)
      comment: "Total booking queue records, baseline for queue-management rates."
    - name: "Escalated Queue Count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated queue items, a leading SLA-breach indicator."
    - name: "Authorization Required Count"
      expr: SUM(CASE WHEN authorization_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count requiring prior authorization, quantifying booking friction."
    - name: "Telehealth Eligible Count"
      expr: SUM(CASE WHEN telehealth_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of telehealth-eligible requests, supporting virtual-care capacity diversion decisions."
    - name: "Distinct Patients In Queue"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients awaiting booking, measuring unique unmet demand."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_telehealth_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telehealth session KPIs for virtual-care leadership: tracks session completion, connection quality, no-shows, and billing eligibility, all critical to virtual-care strategy and reimbursement."
  source: "`vibe_healthcare_v1`.`scheduling`.`telehealth_session`"
  dimensions:
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_datetime)
      comment: "Month of the scheduled telehealth session for volume trend reporting."
    - name: "session_status"
      expr: session_status
      comment: "Final session status (completed, cancelled, no-show) for outcome analysis."
    - name: "session_type"
      expr: session_type
      comment: "Type of telehealth session to segment virtual-care modalities."
    - name: "connection_status"
      expr: connection_status
      comment: "Connection outcome status, central to virtual-care quality monitoring."
    - name: "platform_vendor"
      expr: platform_vendor
      comment: "Telehealth platform vendor for vendor-performance comparison."
  measures:
    - name: "Telehealth Session Count"
      expr: COUNT(1)
      comment: "Total telehealth sessions, baseline for virtual-care utilization and rate KPIs."
    - name: "Avg Connection Quality Score"
      expr: AVG(CAST(connection_quality_score AS DOUBLE))
      comment: "Average connection quality score, the primary virtual-care experience and reliability KPI."
    - name: "No Show Session Count"
      expr: SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of telehealth no-shows, used to compute virtual no-show rate."
    - name: "Billing Eligible Count"
      expr: SUM(CASE WHEN billing_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of billing-eligible sessions, tying telehealth volume to reimbursable revenue."
    - name: "Technical Issue Count"
      expr: SUM(CASE WHEN technical_issue_reported_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sessions with reported technical issues, driving platform and support investment."
    - name: "Interpreter Present Count"
      expr: SUM(CASE WHEN interpreter_present_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sessions with an interpreter present, a language-access equity indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_surgical_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical case scheduling KPIs for perioperative leadership: tracks case volume, cancellations, safety-checklist compliance, and add-ons that drive OR throughput, revenue, and patient safety."
  source: "`vibe_healthcare_v1`.`scheduling`.`surgical_case`"
  dimensions:
    - name: "scheduled_date"
      expr: DATE_TRUNC('DAY', scheduled_date)
      comment: "Scheduled date of the surgical case for daily OR planning and trends."
    - name: "case_status"
      expr: case_status
      comment: "Surgical case status (scheduled, completed, cancelled) for outcome analysis."
    - name: "service_line"
      expr: service_line
      comment: "Surgical service line, the key segmentation for OR margin and volume management."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Case urgency (elective, urgent, emergent) for prioritization and capacity planning."
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification, relevant to case risk and resource planning."
  measures:
    - name: "Surgical Case Count"
      expr: COUNT(1)
      comment: "Total surgical cases scheduled, the headline OR demand and throughput measure."
    - name: "Cancelled Case Count"
      expr: SUM(CASE WHEN case_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled cases, used to derive cancellation rate, a costly OR efficiency loss."
    - name: "Add On Case Count"
      expr: SUM(CASE WHEN add_on_case_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of add-on cases, indicating unplanned demand that stresses OR schedules."
    - name: "Timeout Completed Count"
      expr: SUM(CASE WHEN timeout_completed_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with a completed surgical timeout, a core patient-safety compliance KPI."
    - name: "Site Marked Count"
      expr: SUM(CASE WHEN site_marked_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with site marking completed, a wrong-site-surgery prevention KPI."
    - name: "Consent Obtained Count"
      expr: SUM(CASE WHEN consent_obtained_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with consent obtained, a compliance and patient-safety indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_case_material_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical case material usage KPIs for supply-chain and perioperative cost leadership: quantifies material consumption, cost, waste, and implant usage that drive surgical case profitability."
  source: "`vibe_healthcare_v1`.`scheduling`.`case_material_usage`"
  dimensions:
    - name: "usage_month"
      expr: DATE_TRUNC('MONTH', usage_timestamp)
      comment: "Month materials were used, for cost-trend reporting."
    - name: "charge_code"
      expr: charge_code
      comment: "Charge code associated with the material, linking usage to billing capture."
    - name: "implant_flag"
      expr: implant_flag
      comment: "Whether the material is an implant, the highest-cost surgical supply category."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the material is billable, central to charge-capture analysis."
    - name: "waste_flag"
      expr: waste_flag
      comment: "Whether the material was wasted, the key supply-cost-reduction lever."
  measures:
    - name: "Material Usage Count"
      expr: COUNT(1)
      comment: "Total material usage line records, baseline for usage and waste rates."
    - name: "Total Quantity Used"
      expr: SUM(CAST(quantity_used AS DOUBLE))
      comment: "Total quantity of materials consumed across cases, a utilization volume KPI."
    - name: "Total Unit Cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total material unit cost, quantifying surgical supply spend for cost management."
    - name: "Avg Unit Cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average material unit cost, a unit-economics KPI for sourcing decisions."
    - name: "Waste Material Count"
      expr: SUM(CASE WHEN waste_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of wasted material lines, the direct supply-waste reduction KPI."
    - name: "Implant Material Count"
      expr: SUM(CASE WHEN implant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of implant material lines, the high-cost category prioritized for cost governance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_recall_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient recall and care-gap outreach KPIs for population-health and quality leadership: tracks recall volume, outreach, and gap closure that drive HEDIS/Stars performance and value-based revenue."
  source: "`vibe_healthcare_v1`.`scheduling`.`recall_list`"
  dimensions:
    - name: "target_recall_month"
      expr: DATE_TRUNC('MONTH', target_recall_date)
      comment: "Month a recall is targeted, for outreach planning and trend reporting."
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status (open, completed, cancelled) for outcome analysis."
    - name: "recall_category"
      expr: recall_category
      comment: "Category of recall (preventive, chronic, etc.) to segment population-health outreach."
    - name: "priority_level"
      expr: priority_level
      comment: "Outreach priority level for prioritizing care-gap closure."
    - name: "hedis_measure_code"
      expr: hedis_measure_code
      comment: "Associated HEDIS measure, tying recalls to quality program performance."
  measures:
    - name: "Recall Count"
      expr: COUNT(1)
      comment: "Total recall list entries, baseline for outreach and gap-closure rates."
    - name: "ACO Attributed Count"
      expr: SUM(CASE WHEN aco_attributed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ACO-attributed recalls, linking outreach to value-based revenue at risk."
    - name: "Star Measure Applicable Count"
      expr: SUM(CASE WHEN star_measure_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recalls applicable to Stars measures, prioritizing Medicare Advantage quality impact."
    - name: "Numerator Eligible Count"
      expr: SUM(CASE WHEN quality_measure_numerator_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count eligible for the quality measure numerator, the target population for gap closure."
    - name: "Distinct Patients Recalled"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients on recall lists, measuring unique outreach reach."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appointment volume and no‑show count per care site, clinician, appointment type and month"
  source: "`vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of scheduled appointments"
$$;