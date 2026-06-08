-- Metric views for domain: scheduling | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core scheduling KPIs derived from the appointment fact table. Tracks appointment volume, no-show rates, cancellation rates, telehealth adoption, and booking channel mix — all critical for capacity planning, access management, and patient engagement strategy."
  source: "`healthcare_ecm`.`scheduling`.`appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (e.g., Scheduled, Completed, Cancelled, No-Show). Primary dimension for funnel and outcome analysis."
    - name: "visit_modality"
      expr: visit_modality
      comment: "Mode of visit delivery (e.g., In-Person, Telehealth, Hybrid). Enables modality-mix analysis for capacity and access strategy."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (e.g., Online, Phone, Walk-In, Referral). Drives digital adoption and access strategy decisions."
    - name: "care_setting"
      expr: care_setting
      comment: "Clinical setting for the appointment (e.g., Outpatient, Inpatient, Urgent Care). Supports capacity allocation across care settings."
    - name: "priority"
      expr: priority
      comment: "Clinical priority level assigned to the appointment (e.g., Routine, Urgent, Emergent). Used to assess access equity and triage effectiveness."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for appointment cancellation. Identifies systemic access barriers and operational failure modes."
    - name: "scheduled_date"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of the scheduled appointment date. Enables trend analysis of appointment volume and outcomes over time."
    - name: "telehealth_platform"
      expr: telehealth_platform
      comment: "Platform used for telehealth visits (e.g., Zoom, Epic MyChart). Supports vendor performance and adoption tracking."
    - name: "insurance_verification_status"
      expr: insurance_verification_status
      comment: "Status of insurance verification at time of appointment. Linked to billing eligibility and revenue cycle risk."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Whether the appointment was confirmed by the patient. Predictive signal for no-show risk management."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of appointments. Baseline volume metric for capacity utilization and access reporting."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of appointments where the patient did not show up. Directly impacts provider productivity and revenue."
    - name: "no_show_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments resulting in a no-show. A key operational KPI — high rates signal access barriers, reminder failures, or scheduling mismatches."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN cancellation_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of appointments that were cancelled. Drives slot recovery and rebooking strategy."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments cancelled. Executives use this to assess scheduling reliability and patient commitment."
    - name: "telehealth_appointment_count"
      expr: COUNT(CASE WHEN visit_modality = 'Telehealth' THEN 1 END)
      comment: "Number of telehealth appointments. Tracks digital care delivery adoption and infrastructure demand."
    - name: "telehealth_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN visit_modality = 'Telehealth' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments delivered via telehealth. Strategic KPI for digital transformation and access expansion initiatives."
    - name: "online_booking_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_channel = 'Online' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments booked through online self-service channels. Measures digital engagement and call-center deflection success."
    - name: "insurance_verified_appointment_count"
      expr: COUNT(CASE WHEN billing_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of appointments with confirmed billing eligibility. Directly tied to clean claims rate and revenue cycle performance."
    - name: "insurance_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN billing_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments with billing eligibility confirmed. A revenue cycle quality KPI — low rates predict claim denials and write-offs."
    - name: "confirmed_appointment_count"
      expr: COUNT(CASE WHEN confirmation_status = 'Confirmed' THEN 1 END)
      comment: "Number of appointments with patient confirmation received. Confirmed appointments have significantly lower no-show rates."
    - name: "confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN confirmation_status = 'Confirmed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments confirmed by the patient. Operational KPI for reminder effectiveness and no-show prevention programs."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_open_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling capacity and slot availability KPIs. Tracks open slot inventory, online booking enablement, waitlist capacity, and hold utilization — essential for access management and provider capacity optimization."
  source: "`healthcare_ecm`.`scheduling`.`open_slot`"
  dimensions:
    - name: "slot_status"
      expr: slot_status
      comment: "Current status of the open slot (e.g., Available, Booked, Held, Blocked). Primary dimension for capacity availability analysis."
    - name: "slot_type"
      expr: slot_type
      comment: "Type of scheduling slot (e.g., Routine, Urgent, Block). Supports capacity mix and access tier analysis."
    - name: "slot_category"
      expr: slot_category
      comment: "Categorical grouping of the slot (e.g., New Patient, Follow-Up, Procedure). Enables access equity and demand-supply matching."
    - name: "care_setting"
      expr: care_setting
      comment: "Clinical setting associated with the slot. Supports capacity planning across outpatient, inpatient, and specialty settings."
    - name: "hold_status"
      expr: hold_status
      comment: "Whether the slot is currently on hold and the hold status. Identifies capacity locked in administrative holds vs. available for booking."
    - name: "slot_start_month"
      expr: DATE_TRUNC('month', slot_start_datetime)
      comment: "Month of the slot start datetime. Enables forward-looking capacity trend analysis."
    - name: "online_booking_enabled_flag"
      expr: online_booking_enabled_flag
      comment: "Whether the slot is available for online self-scheduling. Drives digital access strategy reporting."
    - name: "waitlist_enabled_flag"
      expr: waitlist_enabled_flag
      comment: "Whether the slot supports waitlist enrollment. Used to assess waitlist capacity and patient access management."
  measures:
    - name: "total_slots"
      expr: COUNT(1)
      comment: "Total number of scheduling slots in inventory. Baseline capacity metric for access and throughput planning."
    - name: "available_slot_count"
      expr: COUNT(CASE WHEN slot_status = 'Available' THEN 1 END)
      comment: "Number of slots currently available for booking. Direct measure of scheduling capacity and access supply."
    - name: "slot_availability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN slot_status = 'Available' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of total slots that are available for booking. Executives use this to assess access supply vs. demand balance."
    - name: "held_slot_count"
      expr: COUNT(CASE WHEN hold_status IS NOT NULL AND hold_status != '' THEN 1 END)
      comment: "Number of slots currently on administrative hold. High hold counts reduce effective capacity and patient access."
    - name: "held_slot_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_status IS NOT NULL AND hold_status != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots locked in holds. Operational KPI — excessive holds reduce bookable capacity and patient access."
    - name: "online_bookable_slot_count"
      expr: COUNT(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 END)
      comment: "Number of slots enabled for online self-scheduling. Measures digital access supply for patient self-service initiatives."
    - name: "online_bookable_slot_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots available for online booking. Strategic KPI for digital access expansion and call-center deflection."
    - name: "waitlist_enabled_slot_count"
      expr: COUNT(CASE WHEN waitlist_enabled_flag = TRUE THEN 1 END)
      comment: "Number of slots with waitlist enrollment enabled. Supports demand capture and slot fill optimization."
    - name: "overbook_allowed_slot_count"
      expr: COUNT(CASE WHEN overbook_allowed_flag = TRUE THEN 1 END)
      comment: "Number of slots where overbooking is permitted. Tracks overbooking exposure for patient experience and throughput risk management."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_or_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating room block scheduling KPIs. Tracks OR block utilization targets, release patterns, and block allocation efficiency — critical for surgical throughput, OR revenue optimization, and block time governance."
  source: "`healthcare_ecm`.`scheduling`.`or_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the OR block (e.g., Active, Released, Cancelled, Suspended). Primary dimension for block utilization analysis."
    - name: "block_type"
      expr: block_type
      comment: "Type of OR block (e.g., Exclusive, Shared, Open). Drives block allocation strategy and fairness analysis."
    - name: "block_owner_type"
      expr: block_owner_type
      comment: "Category of the block owner (e.g., Surgeon, Service Line, Group). Enables block utilization accountability by owner type."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week the OR block is scheduled. Identifies utilization patterns and peak/off-peak OR demand."
    - name: "anesthesia_type_required"
      expr: anesthesia_type_required
      comment: "Type of anesthesia required for the block (e.g., General, Regional, MAC). Supports anesthesia resource planning."
    - name: "release_rule_type"
      expr: release_rule_type
      comment: "Rule governing when unused block time is released to open scheduling. Drives block release policy governance."
    - name: "block_start_month"
      expr: DATE_TRUNC('month', block_start_time)
      comment: "Month of the OR block start time. Enables trend analysis of OR block scheduling and utilization over time."
    - name: "allows_overbooking"
      expr: allows_overbooking
      comment: "Whether the OR block permits overbooking. Tracks overbooking policy exposure across blocks."
  measures:
    - name: "total_or_blocks"
      expr: COUNT(1)
      comment: "Total number of OR blocks scheduled. Baseline metric for OR capacity inventory and surgical throughput planning."
    - name: "avg_target_utilization_threshold_pct"
      expr: ROUND(AVG(CAST(target_utilization_threshold_pct AS DOUBLE)), 2)
      comment: "Average target utilization threshold set for OR blocks. Benchmarks expected utilization against actual performance for block governance."
    - name: "avg_minimum_utilization_threshold_pct"
      expr: ROUND(AVG(CAST(minimum_utilization_threshold_pct AS DOUBLE)), 2)
      comment: "Average minimum utilization threshold required to retain OR block time. Blocks below this threshold are candidates for reallocation."
    - name: "blocks_below_minimum_utilization"
      expr: COUNT(CASE WHEN minimum_utilization_threshold_pct > 0 THEN 1 END)
      comment: "Number of OR blocks with a minimum utilization threshold set, indicating blocks under active governance scrutiny for potential release."
    - name: "released_block_count"
      expr: COUNT(CASE WHEN block_status = 'Released' THEN 1 END)
      comment: "Number of OR blocks that have been released back to open scheduling. Measures block release compliance and OR access for non-block cases."
    - name: "block_release_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN block_status = 'Released' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OR blocks released to open scheduling. High release rates may indicate underutilization; low rates may restrict access for add-on cases."
    - name: "cancelled_block_count"
      expr: COUNT(CASE WHEN block_status = 'Cancelled' THEN 1 END)
      comment: "Number of OR blocks cancelled. Cancelled blocks represent lost surgical revenue and OR throughput."
    - name: "block_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN block_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OR blocks cancelled. Executives use this to assess OR scheduling reliability and surgical case loss."
    - name: "shared_block_count"
      expr: COUNT(CASE WHEN allows_sharing = TRUE THEN 1 END)
      comment: "Number of OR blocks configured for sharing between providers or service lines. Tracks collaborative OR utilization and block sharing adoption."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_surgical_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical case scheduling and execution KPIs. Tracks case volume, urgency mix, add-on rates, consent compliance, safety checklist completion, and case status — essential for surgical throughput, patient safety, and OR governance."
  source: "`healthcare_ecm`.`scheduling`.`surgical_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the surgical case (e.g., Scheduled, In Progress, Completed, Cancelled). Primary dimension for surgical pipeline analysis."
    - name: "case_type"
      expr: case_type
      comment: "Type of surgical case (e.g., Elective, Urgent, Emergent). Drives case mix analysis and OR capacity planning."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Clinical urgency classification of the surgical case. Informs prioritization, OR scheduling, and patient safety governance."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia used or planned (e.g., General, Regional, Local). Supports anesthesia resource planning and case complexity analysis."
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification of the patient. Proxy for surgical risk and case complexity — used in quality and outcomes reporting."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient classification for the surgical case (e.g., Inpatient, Outpatient, Observation). Drives billing, capacity, and throughput analysis."
    - name: "laterality"
      expr: laterality
      comment: "Laterality of the surgical procedure (e.g., Left, Right, Bilateral). Used in surgical safety and site-marking compliance reporting."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of the scheduled surgical date. Enables trend analysis of surgical volume and case mix over time."
    - name: "add_on_case_indicator"
      expr: add_on_case_indicator
      comment: "Whether the case was added on to the OR schedule after initial block planning. Add-on cases indicate unplanned demand and OR flexibility requirements."
  measures:
    - name: "total_surgical_cases"
      expr: COUNT(1)
      comment: "Total number of surgical cases scheduled. Baseline metric for surgical throughput and OR utilization reporting."
    - name: "add_on_case_count"
      expr: COUNT(CASE WHEN add_on_case_indicator = TRUE THEN 1 END)
      comment: "Number of add-on surgical cases. High add-on rates indicate unplanned demand, OR disruption, and potential patient safety risk."
    - name: "add_on_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN add_on_case_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surgical cases that were add-ons. Executives use this to assess OR schedule predictability and elective vs. emergent case mix."
    - name: "cancelled_case_count"
      expr: COUNT(CASE WHEN case_status = 'Cancelled' THEN 1 END)
      comment: "Number of surgical cases cancelled. Cancellations represent lost OR revenue, wasted prep resources, and patient access failures."
    - name: "case_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN case_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surgical cases cancelled. A critical OR governance KPI — high rates signal scheduling, consent, or clinical readiness failures."
    - name: "consent_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surgical cases with documented patient consent obtained. A patient safety and regulatory compliance KPI — non-compliance is a serious liability."
    - name: "timeout_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN timeout_completed_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surgical cases with surgical timeout completed. A Joint Commission patient safety KPI — directly tied to wrong-site surgery prevention."
    - name: "site_marking_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN site_marked_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applicable surgical cases with surgical site marked. A patient safety KPI required for accreditation and malpractice risk management."
    - name: "icu_bed_required_case_count"
      expr: COUNT(CASE WHEN requires_icu_bed = TRUE THEN 1 END)
      comment: "Number of surgical cases requiring post-operative ICU bed placement. Drives ICU capacity planning and surgical case complexity reporting."
    - name: "implant_required_case_count"
      expr: COUNT(CASE WHEN implant_required = TRUE THEN 1 END)
      comment: "Number of surgical cases requiring implants. Drives supply chain planning, vendor contract utilization, and implant cost management."
    - name: "block_time_case_count"
      expr: COUNT(CASE WHEN block_time_indicator = TRUE THEN 1 END)
      comment: "Number of surgical cases performed within allocated OR block time. Used to calculate block time utilization and assess block allocation efficiency."
    - name: "block_time_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN block_time_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surgical cases utilizing allocated OR block time. A primary OR governance KPI — low rates indicate block time waste and reallocation opportunities."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient waitlist management KPIs. Tracks waitlist volume, escalation rates, SLA compliance, outreach effectiveness, and access equity — critical for patient access strategy, regulatory compliance, and care delay risk management."
  source: "`healthcare_ecm`.`scheduling`.`waitlist_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Current status of the waitlist entry (e.g., Active, Scheduled, Removed, Expired). Primary dimension for waitlist pipeline analysis."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of waitlist entry (e.g., Appointment, Procedure, Referral). Supports demand categorization and access planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Clinical priority assigned to the waitlist entry. Ensures high-priority patients are tracked for timely access and SLA compliance."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting associated with the waitlist entry. Enables access analysis across outpatient, specialty, and procedural settings."
    - name: "removal_reason"
      expr: removal_reason
      comment: "Reason the patient was removed from the waitlist (e.g., Scheduled, Declined, No Longer Needed). Distinguishes successful conversions from access failures."
    - name: "language_preference"
      expr: language_preference
      comment: "Patient language preference. Supports health equity analysis of waitlist access by language and interpreter need."
    - name: "telehealth_eligible_flag"
      expr: telehealth_eligible_flag
      comment: "Whether the waitlisted patient is eligible for telehealth. Identifies opportunities to accelerate access via virtual care."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the waitlist entry has been escalated due to clinical urgency or SLA breach. Tracks high-risk access delays requiring intervention."
    - name: "queue_entry_month"
      expr: DATE_TRUNC('month', queue_entry_datetime)
      comment: "Month the patient entered the waitlist queue. Enables cohort-based wait time trend analysis."
    - name: "preferred_contact_channel"
      expr: preferred_contact_channel
      comment: "Patient preferred outreach channel (e.g., Phone, SMS, Email, Portal). Drives outreach strategy optimization for waitlist conversion."
  measures:
    - name: "total_waitlist_entries"
      expr: COUNT(1)
      comment: "Total number of active and historical waitlist entries. Baseline metric for patient access demand and scheduling backlog."
    - name: "active_waitlist_count"
      expr: COUNT(CASE WHEN entry_status = 'Active' THEN 1 END)
      comment: "Number of patients currently on the waitlist. Directly measures scheduling backlog and access supply-demand gap."
    - name: "scheduled_from_waitlist_count"
      expr: COUNT(CASE WHEN scheduled_datetime IS NOT NULL THEN 1 END)
      comment: "Number of waitlist entries successfully converted to a scheduled appointment. Measures waitlist conversion effectiveness."
    - name: "waitlist_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN scheduled_datetime IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries converted to scheduled appointments. A key access management KPI — low rates indicate capacity constraints or outreach failures."
    - name: "escalated_entry_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of waitlist entries escalated due to clinical urgency or SLA breach. Tracks high-risk access delays requiring immediate intervention."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries that required escalation. Executives use this to assess access equity, triage effectiveness, and care delay risk."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_target_datetime IS NOT NULL AND scheduled_datetime > sla_target_datetime THEN 1 END)
      comment: "Number of waitlist entries where scheduling occurred after the SLA target datetime. Regulatory and accreditation risk KPI for timely access compliance."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_target_datetime IS NOT NULL AND (scheduled_datetime IS NULL OR scheduled_datetime <= sla_target_datetime) THEN 1 END) / NULLIF(COUNT(CASE WHEN sla_target_datetime IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of waitlist entries with SLA targets that were scheduled within the target window. A regulatory and patient access quality KPI."
    - name: "telehealth_eligible_waitlist_count"
      expr: COUNT(CASE WHEN telehealth_eligible_flag = TRUE THEN 1 END)
      comment: "Number of waitlisted patients eligible for telehealth. Identifies the addressable population for virtual care to accelerate access and reduce wait times."
    - name: "interpreter_required_waitlist_count"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE THEN 1 END)
      comment: "Number of waitlisted patients requiring interpreter services. Supports health equity reporting and interpreter resource planning."
    - name: "avg_outreach_attempts"
      expr: ROUND(AVG(CAST(outreach_attempt_count AS DOUBLE)), 2)
      comment: "Average number of outreach attempts made per waitlist entry. Measures outreach intensity and identifies entries requiring escalated contact strategies."
    - name: "transportation_assistance_needed_count"
      expr: COUNT(CASE WHEN transportation_assistance_needed_flag = TRUE THEN 1 END)
      comment: "Number of waitlisted patients needing transportation assistance. Supports social determinants of health (SDOH) access barrier analysis and care coordination."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_appointment_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appointment type catalog KPIs. Tracks RVU value, telehealth and self-scheduling enablement, referral and prior auth requirements, and quality measure applicability — essential for service line strategy, billing optimization, and access policy governance."
  source: "`healthcare_ecm`.`scheduling`.`appointment_type`"
  dimensions:
    - name: "appointment_type_category"
      expr: appointment_type_category
      comment: "High-level category of the appointment type (e.g., Preventive, Diagnostic, Therapeutic). Enables service line and care category analysis."
    - name: "appointment_type_status"
      expr: appointment_type_status
      comment: "Active/inactive status of the appointment type. Ensures metrics reflect only operationally active service types."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for the appointment type (e.g., Outpatient, Inpatient, Telehealth). Supports capacity and access planning by setting."
    - name: "billing_class"
      expr: billing_class
      comment: "Billing classification for the appointment type (e.g., Professional, Facility, Technical). Drives revenue cycle and billing strategy analysis."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class associated with the appointment type (e.g., New Patient, Established Patient). Supports access and panel management analysis."
    - name: "allows_telehealth"
      expr: allows_telehealth
      comment: "Whether the appointment type supports telehealth delivery. Tracks telehealth-eligible service catalog for digital access strategy."
    - name: "allows_self_scheduling"
      expr: allows_self_scheduling
      comment: "Whether patients can self-schedule this appointment type online. Measures self-service access enablement across the service catalog."
    - name: "requires_referral"
      expr: requires_referral
      comment: "Whether a referral is required for this appointment type. Impacts patient access pathways and care coordination workflows."
  measures:
    - name: "total_appointment_types"
      expr: COUNT(1)
      comment: "Total number of appointment types in the catalog. Baseline metric for service catalog breadth and governance."
    - name: "telehealth_enabled_type_count"
      expr: COUNT(CASE WHEN allows_telehealth = TRUE THEN 1 END)
      comment: "Number of appointment types enabled for telehealth delivery. Measures telehealth service catalog coverage for digital access strategy."
    - name: "telehealth_enablement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allows_telehealth = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointment types enabled for telehealth. Strategic KPI for digital transformation — low rates indicate barriers to virtual care expansion."
    - name: "self_scheduling_enabled_type_count"
      expr: COUNT(CASE WHEN allows_self_scheduling = TRUE THEN 1 END)
      comment: "Number of appointment types available for patient self-scheduling. Measures digital access supply and call-center deflection potential."
    - name: "self_scheduling_enablement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allows_self_scheduling = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointment types available for self-scheduling. Executives use this to assess digital access maturity and patient convenience."
    - name: "referral_required_type_count"
      expr: COUNT(CASE WHEN requires_referral = TRUE THEN 1 END)
      comment: "Number of appointment types requiring a referral. Identifies access friction points in the patient journey and care coordination burden."
    - name: "avg_rvu_work"
      expr: ROUND(AVG(CAST(rvu_work AS DOUBLE)), 4)
      comment: "Average work RVU value across appointment types. Measures clinical labor intensity and informs provider compensation and productivity benchmarking."
    - name: "total_rvu_work"
      expr: ROUND(SUM(CAST(rvu_work AS DOUBLE)), 2)
      comment: "Total work RVU value across all appointment types in the catalog. Proxy for aggregate clinical labor value and service line productivity potential."
    - name: "avg_rvu_practice_expense"
      expr: ROUND(AVG(CAST(rvu_practice_expense AS DOUBLE)), 4)
      comment: "Average practice expense RVU across appointment types. Informs cost structure analysis and facility overhead allocation by service type."
    - name: "quality_measure_applicable_type_count"
      expr: COUNT(CASE WHEN quality_measure_applicable = TRUE THEN 1 END)
      comment: "Number of appointment types linked to quality measure reporting. Tracks quality program coverage across the service catalog for value-based care performance."
    - name: "no_show_penalty_applicable_type_count"
      expr: COUNT(CASE WHEN no_show_penalty_applies = TRUE THEN 1 END)
      comment: "Number of appointment types with a no-show penalty policy. Measures no-show deterrence policy coverage across the service catalog."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`scheduling_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource assignment KPIs for scheduling. Tracks assignment volume, conflict rates, credentialing compliance, no-show rates, and billable assignment coverage — essential for provider productivity, patient safety, and revenue integrity."
  source: "`healthcare_ecm`.`scheduling`.`resource_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the resource assignment (e.g., Confirmed, Pending, Cancelled). Primary dimension for assignment pipeline analysis."
    - name: "resource_type"
      expr: resource_type
      comment: "Type of resource assigned (e.g., Clinician, Room, Equipment). Enables capacity analysis by resource category."
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the assigned resource in the care event (e.g., Attending, Resident, Technician). Supports staffing mix and supervision compliance analysis."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the resource assignment. Tracks assignment readiness and scheduling reliability."
    - name: "equipment_reservation_status"
      expr: equipment_reservation_status
      comment: "Status of equipment reservation for the assignment. Identifies equipment availability gaps that could delay care delivery."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_datetime)
      comment: "Month of the scheduled assignment start. Enables trend analysis of resource utilization and assignment volume over time."
    - name: "primary_assignment_flag"
      expr: primary_assignment_flag
      comment: "Whether this is the primary resource assignment for the event. Distinguishes primary from supporting resource assignments."
  measures:
    - name: "total_resource_assignments"
      expr: COUNT(1)
      comment: "Total number of resource assignments. Baseline metric for scheduling resource utilization and staffing coverage."
    - name: "conflict_assignment_count"
      expr: COUNT(CASE WHEN conflict_flag = TRUE THEN 1 END)
      comment: "Number of resource assignments with scheduling conflicts. Conflicts risk care delays, patient safety events, and provider burnout."
    - name: "conflict_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conflict_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resource assignments with scheduling conflicts. Executives use this to assess scheduling system integrity and operational risk."
    - name: "credentialing_verified_count"
      expr: COUNT(CASE WHEN credentialing_verified_flag = TRUE THEN 1 END)
      comment: "Number of resource assignments with credentialing verified. Credentialing compliance is a patient safety and regulatory requirement."
    - name: "credentialing_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resource assignments with verified credentialing. A critical patient safety and accreditation KPI — non-compliance is a regulatory liability."
    - name: "no_show_assignment_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of resource assignments where the resource did not show. Provider no-shows directly impact patient care delivery and OR/clinic throughput."
    - name: "resource_no_show_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resource assignments resulting in a no-show. Operational KPI for provider reliability and contingency staffing planning."
    - name: "billable_assignment_count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Number of resource assignments flagged as billable. Directly tied to revenue capture and billing completeness."
    - name: "billable_assignment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN billable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of resource assignments that are billable. Revenue integrity KPI — low rates indicate missed billing opportunities or documentation gaps."
    - name: "sterilization_cleared_assignment_count"
      expr: COUNT(CASE WHEN sterilization_clearance_flag = TRUE THEN 1 END)
      comment: "Number of equipment assignments with sterilization clearance confirmed. Patient safety KPI for infection control compliance in procedural settings."
    - name: "maintenance_cleared_assignment_count"
      expr: COUNT(CASE WHEN maintenance_clearance_flag = TRUE THEN 1 END)
      comment: "Number of equipment assignments with maintenance clearance confirmed. Tracks equipment safety compliance and reduces procedural delay risk."
$$;