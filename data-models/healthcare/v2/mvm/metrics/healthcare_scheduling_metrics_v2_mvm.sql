-- Metric views for domain: scheduling | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_open_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling capacity and slot utilization metrics. Tracks available, held, and online-bookable slots to inform capacity planning and access optimization decisions."
  source: "`vibe_healthcare_v1`.`scheduling`.`open_slot`"
  dimensions:
    - name: "slot_status"
      expr: slot_status
      comment: "Current status of the slot (e.g., open, booked, blocked, held) — primary grouping for capacity analysis."
    - name: "slot_type"
      expr: slot_type
      comment: "Type classification of the slot (e.g., routine, urgent, block) — used to segment capacity by clinical priority."
    - name: "slot_category"
      expr: slot_category
      comment: "Operational category of the slot — supports capacity reporting by service line or care type."
    - name: "care_setting"
      expr: care_setting
      comment: "Care delivery setting (e.g., inpatient, outpatient, telehealth) — key dimension for access and capacity strategy."
    - name: "block_type"
      expr: block_type
      comment: "Type of block applied to the slot — used to analyze blocked capacity and its causes."
    - name: "online_booking_enabled_flag"
      expr: online_booking_enabled_flag
      comment: "Indicates whether the slot is available for patient self-scheduling online — informs digital access strategy."
    - name: "overbook_allowed_flag"
      expr: overbook_allowed_flag
      comment: "Indicates whether overbooking is permitted for this slot — relevant for throughput and patient experience tradeoffs."
    - name: "waitlist_enabled_flag"
      expr: waitlist_enabled_flag
      comment: "Indicates whether waitlist enrollment is enabled for this slot — supports demand management analysis."
    - name: "slot_start_date"
      expr: DATE_TRUNC('day', slot_start_datetime)
      comment: "Date the slot is scheduled to begin — used for daily and weekly capacity trend analysis."
    - name: "slot_start_month"
      expr: DATE_TRUNC('month', slot_start_datetime)
      comment: "Month the slot is scheduled to begin — used for monthly capacity planning and forecasting."
  measures:
    - name: "total_slots"
      expr: COUNT(1)
      comment: "Total number of scheduling slots. Baseline capacity measure used to assess overall scheduling supply."
    - name: "open_slots"
      expr: COUNT(CASE WHEN slot_status = 'open' THEN 1 END)
      comment: "Number of slots currently in open/available status. Directly measures unfilled scheduling capacity available to patients."
    - name: "blocked_slots"
      expr: COUNT(CASE WHEN slot_status = 'blocked' THEN 1 END)
      comment: "Number of slots in blocked status. High blocked slot counts signal capacity leakage and operational inefficiency."
    - name: "held_slots"
      expr: COUNT(CASE WHEN hold_status IS NOT NULL AND hold_status != '' THEN 1 END)
      comment: "Number of slots currently on hold. Held slots represent temporarily reserved but unconfirmed capacity."
    - name: "online_bookable_slots"
      expr: COUNT(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 END)
      comment: "Number of slots enabled for online patient self-scheduling. Measures digital access capacity — a key patient experience and operational efficiency KPI."
    - name: "overbook_enabled_slots"
      expr: COUNT(CASE WHEN overbook_allowed_flag = TRUE THEN 1 END)
      comment: "Number of slots where overbooking is permitted. Informs throughput strategy and patient experience risk management."
    - name: "waitlist_enabled_slots"
      expr: COUNT(CASE WHEN waitlist_enabled_flag = TRUE THEN 1 END)
      comment: "Number of slots with waitlist enrollment enabled. Supports demand capture analysis when primary capacity is exhausted."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_provider_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider scheduling availability and capacity metrics. Tracks provider availability status, telehealth readiness, and new patient acceptance to support workforce and access planning."
  source: "`vibe_healthcare_v1`.`scheduling`.`provider_availability`"
  dimensions:
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the provider (e.g., available, unavailable, on-call) — primary dimension for capacity reporting."
    - name: "availability_type"
      expr: availability_type
      comment: "Type of availability block (e.g., scheduled, on-call, block) — used to segment provider capacity by operational mode."
    - name: "care_setting"
      expr: care_setting
      comment: "Care delivery setting for this availability block — supports access analysis by care modality."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the provider for this availability — ensures only credentialed capacity is counted in access metrics."
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Indicates whether the provider is accepting new patients during this availability — critical for patient access and panel management."
    - name: "telehealth_enabled"
      expr: telehealth_enabled
      comment: "Indicates whether telehealth is enabled for this availability block — measures virtual care capacity."
    - name: "overbooking_allowed"
      expr: overbooking_allowed
      comment: "Indicates whether overbooking is permitted for this availability — relevant for throughput optimization decisions."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class served during this availability (e.g., outpatient, inpatient) — used for capacity segmentation by patient population."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the availability period begins — used for monthly provider capacity trend analysis."
    - name: "on_call_type"
      expr: on_call_type
      comment: "Type of on-call coverage (e.g., primary, backup) — used to analyze on-call burden and coverage gaps."
  measures:
    - name: "total_availability_blocks"
      expr: COUNT(1)
      comment: "Total number of provider availability blocks. Baseline measure of scheduled provider capacity supply."
    - name: "available_blocks"
      expr: COUNT(CASE WHEN availability_status = 'available' THEN 1 END)
      comment: "Number of availability blocks in active available status. Directly measures schedulable provider capacity."
    - name: "new_patient_accepting_blocks"
      expr: COUNT(CASE WHEN accepts_new_patients = TRUE THEN 1 END)
      comment: "Number of availability blocks where the provider accepts new patients. Key access metric for panel growth and patient acquisition strategy."
    - name: "telehealth_enabled_blocks"
      expr: COUNT(CASE WHEN telehealth_enabled = TRUE THEN 1 END)
      comment: "Number of availability blocks with telehealth enabled. Measures virtual care capacity — informs telehealth expansion and access strategy."
    - name: "credentialed_available_blocks"
      expr: COUNT(CASE WHEN credentialing_status = 'active' AND availability_status = 'available' THEN 1 END)
      comment: "Number of availability blocks that are both credentialed and available. Represents true deployable clinical capacity — a compliance and quality KPI."
    - name: "distinct_providers_available"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of distinct clinicians with at least one availability block. Measures breadth of provider capacity across the scheduling network."
    - name: "overbooking_allowed_blocks"
      expr: COUNT(CASE WHEN overbooking_allowed = TRUE THEN 1 END)
      comment: "Number of availability blocks where overbooking is permitted. Informs throughput capacity beyond standard slot limits."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_surgical_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical case scheduling efficiency and throughput metrics. Tracks case volume, urgency distribution, cancellations, and duration accuracy to support OR utilization and surgical program management."
  source: "`vibe_healthcare_v1`.`scheduling`.`surgical_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the surgical case (e.g., scheduled, completed, cancelled) — primary dimension for case pipeline analysis."
    - name: "case_type"
      expr: case_type
      comment: "Type of surgical case (e.g., elective, emergent, add-on) — used to segment OR utilization by clinical priority."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Clinical urgency level of the surgical case — key dimension for prioritization and throughput management."
    - name: "service_line"
      expr: service_line
      comment: "Clinical service line for the surgical case (e.g., orthopedics, cardiac) — used for service-line-level OR utilization reporting."
    - name: "specialty"
      expr: specialty
      comment: "Surgical specialty associated with the case — supports specialty-level capacity and throughput analysis."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia planned for the case — used for anesthesia resource planning and case complexity analysis."
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification of the patient — measures case complexity and risk distribution across the surgical program."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class for the surgical case (e.g., inpatient, outpatient) — used for capacity and billing segmentation."
    - name: "add_on_case_indicator"
      expr: add_on_case_indicator
      comment: "Indicates whether the case was added on to the schedule outside normal planning — measures schedule disruption and OR agility."
    - name: "block_time_indicator"
      expr: block_time_indicator
      comment: "Indicates whether the case used block-reserved OR time — used to evaluate block time utilization efficiency."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month the surgical case is scheduled — used for monthly surgical volume and capacity trend analysis."
    - name: "requires_icu_bed"
      expr: requires_icu_bed
      comment: "Indicates whether the case requires post-operative ICU placement — informs downstream bed capacity planning."
  measures:
    - name: "total_surgical_cases"
      expr: COUNT(1)
      comment: "Total number of surgical cases. Baseline surgical volume measure used for throughput and capacity planning."
    - name: "cancelled_cases"
      expr: COUNT(CASE WHEN case_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled surgical cases. High cancellation rates signal scheduling inefficiency, patient access barriers, or clinical workflow issues."
    - name: "add_on_cases"
      expr: COUNT(CASE WHEN add_on_case_indicator = TRUE THEN 1 END)
      comment: "Number of add-on surgical cases. Measures unplanned schedule disruption — high add-on rates impact OR efficiency and staff satisfaction."
    - name: "block_time_cases"
      expr: COUNT(CASE WHEN block_time_indicator = TRUE THEN 1 END)
      comment: "Number of cases utilizing block-reserved OR time. Used to calculate block time utilization efficiency — a key OR management KPI."
    - name: "icu_required_cases"
      expr: COUNT(CASE WHEN requires_icu_bed = TRUE THEN 1 END)
      comment: "Number of surgical cases requiring post-operative ICU placement. Critical for downstream bed capacity planning and patient flow management."
    - name: "total_estimated_duration_minutes"
      expr: SUM(CAST(estimated_duration_minutes AS DOUBLE))
      comment: "Sum of estimated surgical durations in minutes. Used to calculate total planned OR time demand for capacity planning."
    - name: "avg_estimated_duration_minutes"
      expr: AVG(CAST(estimated_duration_minutes AS DOUBLE))
      comment: "Average estimated surgical case duration in minutes. Benchmarks case complexity and informs OR scheduling block sizing."
    - name: "consent_obtained_cases"
      expr: COUNT(CASE WHEN consent_obtained_indicator = TRUE THEN 1 END)
      comment: "Number of surgical cases with documented patient consent obtained. Measures pre-operative compliance — a regulatory and quality KPI."
    - name: "implant_required_cases"
      expr: COUNT(CASE WHEN implant_required = TRUE THEN 1 END)
      comment: "Number of cases requiring surgical implants. Informs supply chain planning and case cost management for high-cost implant programs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_telehealth_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telehealth session utilization, quality, and access metrics. Tracks session completion, no-show rates, technical issues, and interpreter usage to support virtual care program management."
  source: "`vibe_healthcare_v1`.`scheduling`.`telehealth_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Current status of the telehealth session (e.g., completed, cancelled, no-show) — primary dimension for session outcome analysis."
    - name: "session_type"
      expr: session_type
      comment: "Type of telehealth session (e.g., follow-up, new patient, urgent) — used to segment virtual care utilization by visit type."
    - name: "platform_name"
      expr: platform_name
      comment: "Telehealth platform used for the session — informs vendor performance and platform adoption analysis."
    - name: "patient_device_type"
      expr: patient_device_type
      comment: "Device type used by the patient (e.g., mobile, desktop, tablet) — informs digital access equity and technology support strategy."
    - name: "connection_status"
      expr: connection_status
      comment: "Technical connection status of the session — used to identify connectivity failure patterns and platform reliability issues."
    - name: "billing_eligible_flag"
      expr: billing_eligible_flag
      comment: "Indicates whether the session is eligible for billing — critical for telehealth revenue capture analysis."
    - name: "interpreter_required_flag"
      expr: interpreter_required_flag
      comment: "Indicates whether an interpreter was required — used to assess language access equity in telehealth delivery."
    - name: "interpreter_present_flag"
      expr: interpreter_present_flag
      comment: "Indicates whether an interpreter was present during the session — measures compliance with language access requirements."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Indicates whether the patient did not attend the scheduled telehealth session — key access and revenue leakage metric."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_datetime)
      comment: "Month the telehealth session was scheduled — used for monthly virtual care volume and trend analysis."
    - name: "originating_site_code"
      expr: originating_site_code
      comment: "Code identifying the patient's originating site for the telehealth session — used for geographic access and reimbursement analysis."
  measures:
    - name: "total_telehealth_sessions"
      expr: COUNT(1)
      comment: "Total number of telehealth sessions. Baseline virtual care volume measure for program scale and growth tracking."
    - name: "completed_sessions"
      expr: COUNT(CASE WHEN session_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed telehealth sessions. Primary throughput measure for virtual care program performance."
    - name: "no_show_sessions"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of telehealth sessions where the patient did not attend. High no-show rates signal access barriers, reminder gaps, or patient engagement issues."
    - name: "cancelled_sessions"
      expr: COUNT(CASE WHEN session_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled telehealth sessions. Measures schedule disruption and capacity waste in the virtual care program."
    - name: "billing_eligible_sessions"
      expr: COUNT(CASE WHEN billing_eligible_flag = TRUE THEN 1 END)
      comment: "Number of sessions eligible for billing. Directly measures billable virtual care volume — a key revenue capture KPI."
    - name: "technical_issue_sessions"
      expr: COUNT(CASE WHEN technical_issue_reported_flag = TRUE THEN 1 END)
      comment: "Number of sessions with a reported technical issue. Measures platform reliability and patient/provider experience quality."
    - name: "interpreter_gap_sessions"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE AND interpreter_present_flag = FALSE THEN 1 END)
      comment: "Number of sessions where an interpreter was required but not present. Measures language access compliance failures — a regulatory and equity KPI."
    - name: "avg_connection_quality_score"
      expr: AVG(CAST(connection_quality_score AS DOUBLE))
      comment: "Average technical connection quality score across telehealth sessions. Measures platform and network performance — informs vendor management and infrastructure investment decisions."
    - name: "provider_attested_sessions"
      expr: COUNT(CASE WHEN provider_attestation_flag = TRUE THEN 1 END)
      comment: "Number of sessions with provider attestation completed. Measures documentation compliance — required for telehealth billing and regulatory reporting."
    - name: "distinct_patients_served"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of distinct patients served via telehealth. Measures the reach and penetration of the virtual care program across the patient population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient waitlist management and access metrics. Tracks waitlist volume, escalations, outreach effectiveness, and SLA compliance to support access improvement and demand management decisions."
  source: "`vibe_healthcare_v1`.`scheduling`.`waitlist_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Current status of the waitlist entry (e.g., active, scheduled, removed) — primary dimension for waitlist pipeline analysis."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of waitlist entry (e.g., new patient, follow-up, urgent) — used to segment demand by clinical priority."
    - name: "priority_level"
      expr: priority_level
      comment: "Clinical priority level assigned to the waitlist entry — key dimension for access equity and SLA compliance analysis."
    - name: "care_setting"
      expr: care_setting
      comment: "Care delivery setting requested by the patient — used to segment waitlist demand by modality."
    - name: "removal_reason"
      expr: removal_reason
      comment: "Reason the patient was removed from the waitlist (e.g., scheduled, declined, lost to follow-up) — informs demand conversion and attrition analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the waitlist entry has been escalated due to urgency or SLA breach — measures access risk."
    - name: "telehealth_eligible_flag"
      expr: telehealth_eligible_flag
      comment: "Indicates whether the patient is eligible for telehealth — used to identify virtual care conversion opportunities from the waitlist."
    - name: "authorization_required_flag"
      expr: authorization_required_flag
      comment: "Indicates whether prior authorization is required before scheduling — measures administrative barriers to access."
    - name: "interpreter_required_flag"
      expr: interpreter_required_flag
      comment: "Indicates whether an interpreter is required — used to assess language access needs in the waitlist population."
    - name: "queue_entry_month"
      expr: DATE_TRUNC('month', queue_entry_datetime)
      comment: "Month the patient entered the waitlist queue — used for monthly demand intake trend analysis."
    - name: "last_outreach_method"
      expr: last_outreach_method
      comment: "Most recent outreach method used to contact the waitlisted patient — informs outreach channel effectiveness analysis."
  measures:
    - name: "total_waitlist_entries"
      expr: COUNT(1)
      comment: "Total number of waitlist entries. Baseline demand measure representing unmet scheduling capacity."
    - name: "active_waitlist_entries"
      expr: COUNT(CASE WHEN entry_status = 'active' THEN 1 END)
      comment: "Number of currently active waitlist entries. Measures real-time unmet demand — a primary access performance KPI."
    - name: "escalated_entries"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of waitlist entries that have been escalated. High escalation counts signal systemic access failures requiring immediate operational intervention."
    - name: "scheduled_from_waitlist"
      expr: COUNT(CASE WHEN entry_status = 'scheduled' OR scheduled_datetime IS NOT NULL THEN 1 END)
      comment: "Number of waitlist entries that resulted in a scheduled appointment. Measures waitlist conversion effectiveness — a key access throughput KPI."
    - name: "authorization_required_entries"
      expr: COUNT(CASE WHEN authorization_required_flag = TRUE THEN 1 END)
      comment: "Number of waitlist entries requiring prior authorization. Measures administrative burden on access — high counts indicate payer friction impeding patient care."
    - name: "telehealth_eligible_entries"
      expr: COUNT(CASE WHEN telehealth_eligible_flag = TRUE THEN 1 END)
      comment: "Number of waitlisted patients eligible for telehealth. Quantifies the virtual care conversion opportunity within the waitlist — informs access expansion strategy."
    - name: "distinct_patients_on_waitlist"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of distinct patients on the waitlist. Measures the breadth of unmet patient demand — a key access equity and capacity planning KPI."
    - name: "transportation_assistance_needed_entries"
      expr: COUNT(CASE WHEN transportation_assistance_needed_flag = TRUE THEN 1 END)
      comment: "Number of waitlisted patients needing transportation assistance. Measures social determinants of health barriers to access — informs care coordination and equity programs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment_reminder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appointment reminder delivery effectiveness and patient engagement metrics. Tracks delivery success, opt-out rates, patient response, and reminder cost to optimize outreach programs and reduce no-shows."
  source: "`vibe_healthcare_v1`.`scheduling`.`appointment_reminder`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome of the reminder (e.g., delivered, failed, pending) — primary dimension for outreach effectiveness analysis."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel used to deliver the reminder (e.g., SMS, email, phone) — used to compare channel effectiveness and cost efficiency."
    - name: "reminder_type"
      expr: reminder_type
      comment: "Type of reminder sent (e.g., initial, follow-up, cancellation) — used to analyze reminder sequence effectiveness."
    - name: "patient_response"
      expr: patient_response
      comment: "Patient's response to the reminder (e.g., confirmed, cancelled, no response) — measures patient engagement and intent."
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Indicates whether the patient has opted out of reminders — measures patient communication preference compliance."
    - name: "language_code"
      expr: language_code
      comment: "Language in which the reminder was sent — used to assess language access equity in outreach programs."
    - name: "department_name"
      expr: department_name
      comment: "Department associated with the appointment reminder — used for department-level outreach performance analysis."
    - name: "facility_name"
      expr: facility_name
      comment: "Facility associated with the appointment reminder — used for facility-level reminder program benchmarking."
    - name: "appointment_date_month"
      expr: DATE_TRUNC('month', appointment_date)
      comment: "Month of the associated appointment — used for monthly reminder volume and effectiveness trend analysis."
    - name: "delivery_failure_reason"
      expr: delivery_failure_reason
      comment: "Reason for reminder delivery failure — used to diagnose and resolve systemic outreach delivery issues."
  measures:
    - name: "total_reminders_sent"
      expr: COUNT(1)
      comment: "Total number of appointment reminders sent. Baseline outreach volume measure for reminder program scale analysis."
    - name: "delivered_reminders"
      expr: COUNT(CASE WHEN delivery_status = 'delivered' THEN 1 END)
      comment: "Number of reminders successfully delivered to patients. Measures outreach reach — a key input to no-show reduction programs."
    - name: "failed_reminders"
      expr: COUNT(CASE WHEN delivery_status = 'failed' THEN 1 END)
      comment: "Number of reminders that failed to deliver. High failure rates signal data quality issues (bad contact info) or channel infrastructure problems."
    - name: "patient_confirmed_reminders"
      expr: COUNT(CASE WHEN patient_response = 'confirmed' THEN 1 END)
      comment: "Number of reminders where the patient confirmed their appointment. Measures active patient engagement — directly linked to no-show reduction outcomes."
    - name: "opt_out_reminders"
      expr: COUNT(CASE WHEN opt_out_flag = TRUE THEN 1 END)
      comment: "Number of reminders associated with patients who have opted out. Measures communication preference compliance and outreach program reach limitations."
    - name: "total_reminder_cost"
      expr: SUM(CAST(cost_per_reminder AS DOUBLE))
      comment: "Total cost of appointment reminders sent. Measures outreach program spend — used to calculate cost-per-confirmation and ROI of reminder campaigns."
    - name: "avg_reminder_cost"
      expr: AVG(CAST(cost_per_reminder AS DOUBLE))
      comment: "Average cost per appointment reminder. Used to benchmark channel cost efficiency and optimize reminder program spend allocation."
    - name: "distinct_patients_reminded"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of distinct patients who received at least one reminder. Measures outreach program patient reach breadth."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical and clinical resource assignment efficiency and compliance metrics. Tracks assignment status, conflicts, credentialing compliance, and equipment readiness to support OR and resource management decisions."
  source: "`vibe_healthcare_v1`.`scheduling`.`resource_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the resource assignment (e.g., confirmed, cancelled, pending) — primary dimension for assignment pipeline analysis."
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the assigned resource (e.g., surgeon, anesthesiologist, scrub tech, room) — used to segment resource utilization by role type."
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource assigned (e.g., clinician, room, equipment) — key dimension for multi-resource capacity analysis."
    - name: "conflict_flag"
      expr: conflict_flag
      comment: "Indicates whether a scheduling conflict exists for this assignment — measures scheduling integrity and operational risk."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the resource assignment is billable — used for revenue capture and cost allocation analysis."
    - name: "credentialing_verified_flag"
      expr: credentialing_verified_flag
      comment: "Indicates whether the assigned clinician's credentials have been verified — measures compliance with privileging requirements."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Indicates whether the assigned resource did not appear for the scheduled assignment — measures reliability and operational disruption."
    - name: "primary_assignment_flag"
      expr: primary_assignment_flag
      comment: "Indicates whether this is the primary resource assignment for the case — used to distinguish primary from supporting resource roles."
    - name: "equipment_reservation_status"
      expr: equipment_reservation_status
      comment: "Reservation status of assigned equipment — used to track equipment availability and readiness for scheduled cases."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_datetime)
      comment: "Month the resource assignment is scheduled to begin — used for monthly resource utilization trend analysis."
  measures:
    - name: "total_resource_assignments"
      expr: COUNT(1)
      comment: "Total number of resource assignments. Baseline measure of scheduling resource demand across all case types."
    - name: "confirmed_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'confirmed' THEN 1 END)
      comment: "Number of confirmed resource assignments. Measures scheduling readiness — low confirmation rates signal operational risk for upcoming cases."
    - name: "conflicted_assignments"
      expr: COUNT(CASE WHEN conflict_flag = TRUE THEN 1 END)
      comment: "Number of resource assignments with scheduling conflicts. Measures scheduling integrity failures — conflicts must be resolved before case execution."
    - name: "credentialing_non_compliant_assignments"
      expr: COUNT(CASE WHEN credentialing_verified_flag = FALSE THEN 1 END)
      comment: "Number of assignments where credentialing has not been verified. Measures privileging compliance risk — a patient safety and regulatory KPI."
    - name: "no_show_assignments"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of resource assignments where the resource did not appear. Measures operational reliability and case disruption risk."
    - name: "billable_assignments"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Number of billable resource assignments. Measures revenue-generating resource utilization — used for cost allocation and billing completeness analysis."
    - name: "sterilization_cleared_assignments"
      expr: COUNT(CASE WHEN sterilization_clearance_flag = TRUE THEN 1 END)
      comment: "Number of assignments where sterilization clearance has been confirmed. Measures infection control compliance readiness for surgical cases."
    - name: "maintenance_cleared_assignments"
      expr: COUNT(CASE WHEN maintenance_clearance_flag = TRUE THEN 1 END)
      comment: "Number of assignments where equipment maintenance clearance is confirmed. Measures equipment safety compliance — a patient safety and regulatory KPI."
$$;