-- Metric views for domain: scheduling | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appointment metrics tracking volume, no-show rates, cancellation patterns, and telehealth adoption for operational scheduling performance management."
  source: "`healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (scheduled, completed, cancelled, no-show) for funnel analysis"
    - name: "visit_modality"
      expr: visit_modality
      comment: "Modality of the visit (in-person, telehealth, hybrid) for channel mix analysis"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting (inpatient, outpatient, ED, ambulatory) for volume segmentation"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which appointment was booked (online, phone, in-person) for self-service adoption tracking"
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Whether patient confirmed the appointment for confirmation effectiveness analysis"
    - name: "priority"
      expr: priority
      comment: "Appointment priority level for access and urgency analysis"
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of scheduled appointment for trend analysis"
    - name: "scheduled_week"
      expr: DATE_TRUNC('week', scheduled_date)
      comment: "Week of scheduled appointment for operational planning"
    - name: "insurance_verification_status"
      expr: insurance_verification_status
      comment: "Insurance verification status for revenue cycle readiness analysis"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of appointments scheduled - baseline volume metric for capacity planning"
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Count of no-show appointments for revenue loss and access impact analysis"
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "No-show rate as percentage - key operational KPI driving overbooking policy and patient outreach strategy"
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled appointments for slot recovery and waitlist activation"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Cancellation rate as percentage - drives access optimization and financial forecasting"
    - name: "telehealth_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN visit_modality = 'telehealth' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments conducted via telehealth - strategic digital health transformation KPI"
    - name: "self_scheduling_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_channel = 'online' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments booked online - measures patient self-service adoption and call center load reduction"
    - name: "completed_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'completed' THEN 1 END)
      comment: "Count of completed appointments for throughput and productivity measurement"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Appointment completion rate - measures effective utilization of scheduled capacity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_block_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating room block utilization metrics for surgical services capacity management, block reallocation decisions, and OR efficiency optimization."
  source: "`healthcare_ecm_v1`.`scheduling`.`block_utilization`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the OR block for active vs released analysis"
    - name: "block_owner_type"
      expr: block_owner_type
      comment: "Type of block owner (surgeon, service line, department) for allocation equity analysis"
    - name: "owner_specialty_code"
      expr: owner_specialty_code
      comment: "Specialty owning the block for service line performance comparison"
    - name: "prime_time_flag"
      expr: prime_time_flag
      comment: "Whether block is during prime time hours for premium capacity analysis"
    - name: "utilization_month"
      expr: DATE_TRUNC('month', utilization_date)
      comment: "Month of utilization for trend analysis and seasonal planning"
    - name: "first_case_on_time_flag"
      expr: first_case_on_time_start_flag
      comment: "Whether first case started on time - key OR efficiency indicator"
  measures:
    - name: "total_blocks"
      expr: COUNT(1)
      comment: "Total number of OR blocks evaluated for utilization tracking"
    - name: "avg_utilization_pct"
      expr: ROUND(AVG(CAST(utilization_percentage AS DOUBLE)), 2)
      comment: "Average block utilization percentage - primary KPI for OR capacity management and block reallocation decisions"
    - name: "avg_target_utilization_pct"
      expr: ROUND(AVG(CAST(target_utilization_percentage AS DOUBLE)), 2)
      comment: "Average target utilization threshold for gap-to-goal analysis"
    - name: "avg_utilization_variance_pct"
      expr: ROUND(AVG(CAST(utilization_variance_percentage AS DOUBLE)), 2)
      comment: "Average variance from target utilization - identifies underperforming blocks for reallocation"
    - name: "avg_turnover_minutes"
      expr: ROUND(AVG(CAST(average_turnover_minutes AS DOUBLE)), 2)
      comment: "Average turnover time between cases - key OR efficiency metric driving throughput improvement"
    - name: "blocks_below_threshold_count"
      expr: COUNT(CASE WHEN meets_utilization_threshold_flag = FALSE THEN 1 END)
      comment: "Count of blocks not meeting utilization threshold - triggers block reallocation review"
    - name: "blocks_at_reallocation_risk"
      expr: COUNT(CASE WHEN block_reallocation_risk_flag = TRUE THEN 1 END)
      comment: "Blocks flagged for potential reallocation - drives surgical services governance decisions"
    - name: "first_case_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN first_case_on_time_start_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "First case on-time start rate - industry benchmark metric for OR operational discipline"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_surgical_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical case volume, scheduling efficiency, and case mix metrics for perioperative services management and surgical growth strategy."
  source: "`healthcare_ecm_v1`.`scheduling`.`surgical_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current case status for pipeline and completion analysis"
    - name: "case_type"
      expr: case_type
      comment: "Type of surgical case (elective, urgent, emergent) for case mix and access analysis"
    - name: "specialty"
      expr: specialty
      comment: "Surgical specialty for service line performance comparison"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification for access and scheduling priority analysis"
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type for resource planning and case complexity analysis"
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class (inpatient, outpatient, observation) for volume and revenue mix"
    - name: "laterality"
      expr: laterality
      comment: "Laterality of procedure for safety and scheduling validation"
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of scheduled surgery for volume trend and growth analysis"
    - name: "add_on_case_indicator"
      expr: add_on_case_indicator
      comment: "Whether case was added on (not originally scheduled) for capacity flexibility analysis"
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification for case complexity and risk stratification"
  measures:
    - name: "total_surgical_cases"
      expr: COUNT(1)
      comment: "Total surgical case volume - primary throughput metric for perioperative services"
    - name: "completed_cases"
      expr: COUNT(CASE WHEN case_status = 'completed' THEN 1 END)
      comment: "Completed surgical cases for productivity and revenue realization"
    - name: "cancelled_cases"
      expr: COUNT(CASE WHEN case_status = 'cancelled' THEN 1 END)
      comment: "Cancelled surgical cases - each cancellation represents significant revenue loss and resource waste"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN case_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Surgical case cancellation rate - key quality and efficiency metric with direct revenue impact"
    - name: "add_on_case_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN add_on_case_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Add-on case rate - measures scheduling flexibility and unplanned demand absorption"
    - name: "icu_bed_required_count"
      expr: COUNT(CASE WHEN requires_icu_bed = TRUE THEN 1 END)
      comment: "Cases requiring ICU bed - critical for downstream capacity planning and bed management"
    - name: "implant_required_count"
      expr: COUNT(CASE WHEN implant_required = TRUE THEN 1 END)
      comment: "Cases requiring implants - drives supply chain coordination and cost management"
    - name: "consent_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Surgical consent documentation compliance rate - regulatory and patient safety requirement"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_capacity_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning and utilization metrics for scheduling resources including providers, rooms, and equipment to optimize access and throughput."
  source: "`healthcare_ecm_v1`.`scheduling`.`capacity_utilization`"
  dimensions:
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for capacity segmentation (ambulatory, inpatient, procedural)"
    - name: "specialty_code"
      expr: specialty_code
      comment: "Clinical specialty for provider-level capacity analysis"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan for strategic vs operational planning distinction"
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the capacity plan for active planning cycle tracking"
    - name: "trend_indicator"
      expr: trend_indicator
      comment: "Utilization trend direction for proactive capacity management"
    - name: "planning_period_month"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Planning period start month for temporal capacity analysis"
  measures:
    - name: "total_capacity_records"
      expr: COUNT(1)
      comment: "Total capacity utilization records for coverage validation"
    - name: "avg_actual_utilization_rate_pct"
      expr: ROUND(AVG(CAST(actual_utilization_rate_pct AS DOUBLE)), 2)
      comment: "Average actual utilization rate - primary capacity efficiency KPI"
    - name: "avg_target_utilization_rate_pct"
      expr: ROUND(AVG(CAST(target_utilization_rate_pct AS DOUBLE)), 2)
      comment: "Average target utilization rate for gap-to-goal benchmarking"
    - name: "avg_variance_utilization_pct"
      expr: ROUND(AVG(CAST(variance_utilization_pct AS DOUBLE)), 2)
      comment: "Average utilization variance from target - identifies over/under-utilized resources"
    - name: "total_available_hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total available scheduling hours for supply-side capacity measurement"
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours for demand-side capacity measurement"
    - name: "total_utilized_hours"
      expr: SUM(CAST(utilized_hours AS DOUBLE))
      comment: "Total utilized hours for actual throughput measurement"
    - name: "total_variance_hours"
      expr: SUM(CAST(variance_hours AS DOUBLE))
      comment: "Total variance hours (gap between scheduled and available) for capacity gap quantification"
    - name: "total_available_fte"
      expr: SUM(CAST(available_fte AS DOUBLE))
      comment: "Total available FTE for workforce capacity planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waitlist management metrics tracking patient access delays, queue depth, and conversion rates for access improvement initiatives."
  source: "`healthcare_ecm_v1`.`scheduling`.`waitlist_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Current waitlist entry status for pipeline analysis"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of waitlist entry for categorization of demand"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of waitlist entry for access equity analysis"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for waitlist segmentation"
    - name: "specialty_required"
      expr: specialty_required
      comment: "Required specialty for bottleneck identification by service line"
    - name: "telehealth_eligible_flag"
      expr: telehealth_eligible_flag
      comment: "Whether patient is eligible for telehealth - opportunity for virtual access to reduce wait times"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether entry has been escalated for urgent access management"
    - name: "queue_entry_month"
      expr: DATE_TRUNC('month', queue_entry_datetime)
      comment: "Month of queue entry for demand trend analysis"
  measures:
    - name: "total_waitlist_entries"
      expr: COUNT(1)
      comment: "Total waitlist volume - measures unmet demand and access constraints"
    - name: "active_waitlist_entries"
      expr: COUNT(CASE WHEN entry_status = 'active' THEN 1 END)
      comment: "Currently active waitlist entries - real-time access backlog indicator"
    - name: "escalated_entries"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Escalated waitlist entries requiring urgent intervention"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Waitlist escalation rate - indicates severity of access delays"
    - name: "telehealth_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist patients eligible for telehealth - quantifies virtual care opportunity to reduce backlog"
    - name: "scheduled_conversion_count"
      expr: COUNT(CASE WHEN entry_status = 'scheduled' THEN 1 END)
      comment: "Waitlist entries that converted to scheduled appointments - measures access recovery effectiveness"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_provider_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider availability and scheduling supply metrics for access optimization, template management, and provider productivity analysis."
  source: "`healthcare_ecm_v1`.`scheduling`.`provider_availability`"
  dimensions:
    - name: "availability_status"
      expr: availability_status
      comment: "Provider availability status for supply-side analysis"
    - name: "availability_type"
      expr: availability_type
      comment: "Type of availability (regular, on-call, coverage) for scheduling pattern analysis"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for provider supply segmentation"
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty for supply-demand matching by service line"
    - name: "telehealth_enabled"
      expr: telehealth_enabled
      comment: "Whether provider is telehealth-enabled for virtual capacity analysis"
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Whether provider accepts new patients - critical for growth and access"
    - name: "on_call_type"
      expr: on_call_type
      comment: "On-call type for coverage adequacy analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Effective month for temporal supply analysis"
  measures:
    - name: "total_availability_slots"
      expr: COUNT(1)
      comment: "Total provider availability records for supply measurement"
    - name: "available_slots"
      expr: COUNT(CASE WHEN availability_status = 'available' THEN 1 END)
      comment: "Currently available provider slots for real-time capacity assessment"
    - name: "unavailable_slots"
      expr: COUNT(CASE WHEN availability_status = 'unavailable' THEN 1 END)
      comment: "Unavailable provider slots for supply gap identification"
    - name: "telehealth_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of availability slots with telehealth enabled - measures virtual care readiness"
    - name: "new_patient_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepts_new_patients = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots accepting new patients - key growth and access metric"
    - name: "overbooking_allowed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overbooking_allowed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots allowing overbooking - measures scheduling flexibility to accommodate demand surges"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_recall_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient recall and care gap closure metrics for preventive care compliance, quality measure performance, and population health outreach effectiveness."
  source: "`healthcare_ecm_v1`.`scheduling`.`recall_list`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status for pipeline and closure tracking"
    - name: "recall_category"
      expr: recall_category
      comment: "Category of recall (preventive, chronic, follow-up) for program analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for outreach prioritization"
    - name: "hedis_measure_code"
      expr: hedis_measure_code
      comment: "HEDIS measure code for quality program performance tracking"
    - name: "cms_quality_program"
      expr: cms_quality_program
      comment: "CMS quality program for regulatory reporting alignment"
    - name: "star_measure_applicable"
      expr: star_measure_applicable
      comment: "Whether recall is tied to Star rating measure - drives MA plan revenue"
    - name: "last_outreach_method"
      expr: last_outreach_method
      comment: "Last outreach method used for channel effectiveness analysis"
    - name: "target_recall_month"
      expr: DATE_TRUNC('month', target_recall_date)
      comment: "Target recall month for outreach planning and compliance deadlines"
  measures:
    - name: "total_recall_entries"
      expr: COUNT(1)
      comment: "Total recall list volume for population health program scope"
    - name: "open_recalls"
      expr: COUNT(CASE WHEN recall_status = 'open' THEN 1 END)
      comment: "Open recall entries requiring outreach - measures care gap backlog"
    - name: "completed_recalls"
      expr: COUNT(CASE WHEN recall_status = 'completed' THEN 1 END)
      comment: "Completed recalls - measures care gap closure success"
    - name: "recall_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Recall closure rate - primary quality measure performance KPI driving Star ratings and VBC revenue"
    - name: "star_measure_recall_count"
      expr: COUNT(CASE WHEN star_measure_applicable = TRUE THEN 1 END)
      comment: "Recalls tied to Star rating measures - quantifies revenue-at-risk from quality gaps"
    - name: "hedis_numerator_eligible_count"
      expr: COUNT(CASE WHEN quality_measure_numerator_eligible = TRUE THEN 1 END)
      comment: "Recalls eligible for HEDIS numerator - measures quality reporting opportunity"
    - name: "overdue_recalls"
      expr: COUNT(CASE WHEN recall_status = 'open' AND target_recall_date < CURRENT_DATE() THEN 1 END)
      comment: "Overdue open recalls past target date - urgent action items for quality compliance"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_telehealth_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telehealth session quality and adoption metrics for virtual care program management, technology performance, and patient experience optimization."
  source: "`healthcare_ecm_v1`.`scheduling`.`telehealth_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Session status for completion and abandonment analysis"
    - name: "session_type"
      expr: session_type
      comment: "Type of telehealth session for program mix analysis"
    - name: "platform_name"
      expr: platform_name
      comment: "Telehealth platform for vendor performance comparison"
    - name: "connection_status"
      expr: connection_status
      comment: "Connection quality status for technology reliability analysis"
    - name: "patient_device_type"
      expr: patient_device_type
      comment: "Patient device type for digital equity and accessibility analysis"
    - name: "originating_site_code"
      expr: originating_site_code
      comment: "Originating site for geographic access analysis"
    - name: "session_month"
      expr: DATE_TRUNC('month', scheduled_start_datetime)
      comment: "Month of session for growth trend analysis"
  measures:
    - name: "total_telehealth_sessions"
      expr: COUNT(1)
      comment: "Total telehealth session volume - measures virtual care program scale"
    - name: "completed_sessions"
      expr: COUNT(CASE WHEN session_status = 'completed' THEN 1 END)
      comment: "Successfully completed telehealth sessions for throughput measurement"
    - name: "no_show_sessions"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Telehealth no-shows for virtual care engagement analysis"
    - name: "telehealth_no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Telehealth no-show rate - compared against in-person no-show rate to validate virtual care value proposition"
    - name: "technical_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN technical_issue_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Technical issue rate - measures platform reliability and patient experience risk"
    - name: "avg_connection_quality_score"
      expr: ROUND(AVG(CAST(connection_quality_score AS DOUBLE)), 2)
      comment: "Average connection quality score - technology performance KPI for vendor management"
    - name: "billing_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billing_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions eligible for billing - measures revenue capture from virtual care"
    - name: "consent_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Telehealth consent documentation rate - regulatory compliance requirement"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_appointment_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appointment lifecycle transition metrics for understanding scheduling workflow efficiency, patient engagement patterns, and financial impact of status changes."
  source: "`healthcare_ecm_v1`.`scheduling`.`appointment_status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "New appointment status after transition for flow analysis"
    - name: "prior_status"
      expr: prior_status
      comment: "Previous appointment status before transition for transition pattern analysis"
    - name: "reason_category"
      expr: reason_category
      comment: "Category of reason for status change for root cause analysis"
    - name: "transition_source"
      expr: transition_source
      comment: "Source of the transition (patient, staff, system) for accountability"
    - name: "initiated_by_role"
      expr: initiated_by_role
      comment: "Role that initiated the change for workflow analysis"
    - name: "patient_contact_method"
      expr: patient_contact_method
      comment: "Method used to contact patient for outreach effectiveness"
    - name: "transition_month"
      expr: DATE_TRUNC('month', transition_timestamp)
      comment: "Month of status transition for trend analysis"
  measures:
    - name: "total_status_transitions"
      expr: COUNT(1)
      comment: "Total appointment status transitions for workflow volume measurement"
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Total estimated revenue impact of status changes - quantifies financial cost of cancellations and no-shows"
    - name: "total_no_show_penalties"
      expr: SUM(CAST(no_show_penalty_amount AS DOUBLE))
      comment: "Total no-show penalty amounts assessed for revenue recovery tracking"
    - name: "no_show_penalty_applied_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_penalty_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of no-show penalty application for policy enforcement monitoring"
    - name: "patient_contacted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_contacted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of patient contact during status changes for engagement quality measurement"
    - name: "within_policy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN within_policy_window = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations within policy window - measures patient compliance with cancellation policies"
    - name: "hedis_impacted_transitions"
      expr: COUNT(CASE WHEN hedis_measure_applicable = TRUE THEN 1 END)
      comment: "Status transitions impacting HEDIS measures - quantifies quality measure risk from scheduling changes"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`scheduling_open_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open scheduling slot inventory metrics for real-time access monitoring, supply-demand matching, and patient access optimization."
  source: "`healthcare_ecm_v1`.`scheduling`.`open_slot`"
  dimensions:
    - name: "slot_status"
      expr: slot_status
      comment: "Current slot status (available, held, blocked) for inventory analysis"
    - name: "slot_type"
      expr: slot_type
      comment: "Type of scheduling slot for capacity mix analysis"
    - name: "slot_category"
      expr: slot_category
      comment: "Category of slot for segmentation"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for access analysis by venue type"
    - name: "specialty"
      expr: specialty
      comment: "Specialty for supply analysis by service line"
    - name: "online_booking_enabled_flag"
      expr: online_booking_enabled_flag
      comment: "Whether slot is available for online booking - measures digital access enablement"
    - name: "hold_status"
      expr: hold_status
      comment: "Hold status for slot reservation analysis"
    - name: "slot_start_month"
      expr: DATE_TRUNC('month', slot_start_datetime)
      comment: "Month of slot start for forward-looking capacity analysis"
  measures:
    - name: "total_slots"
      expr: COUNT(1)
      comment: "Total scheduling slot inventory for capacity supply measurement"
    - name: "available_slots"
      expr: COUNT(CASE WHEN slot_status = 'available' THEN 1 END)
      comment: "Currently available open slots - real-time access supply indicator"
    - name: "blocked_slots"
      expr: COUNT(CASE WHEN slot_status = 'blocked' THEN 1 END)
      comment: "Blocked slots reducing available capacity - identifies access constraints"
    - name: "held_slots"
      expr: COUNT(CASE WHEN slot_status = 'held' THEN 1 END)
      comment: "Held slots pending confirmation - measures reservation pipeline"
    - name: "online_booking_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots enabled for online booking - measures digital access strategy execution"
    - name: "overbook_allowed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overbook_allowed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots allowing overbooking - measures scheduling flexibility policy"
$$;