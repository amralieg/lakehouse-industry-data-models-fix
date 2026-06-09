-- Schema for Domain: scheduling | Business: Healthcare | Version: v1_mvm
-- Generated on: 2026-05-04 19:04:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm`.`scheduling` COMMENT 'Appointment and resource scheduling across all care settings. Includes outpatient appointments (Epic Cadence), surgical scheduling (OpTime), procedure scheduling, resource allocation (rooms, equipment, staff), waitlist management, appointment reminders, no-show tracking, and capacity planning. Supports patient access and operational throughput optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`appointment` (
    `appointment_id` BIGINT COMMENT 'Unique identifier for the scheduled appointment. Primary key for the appointment record across all care settings and modalities.',
    `appointment_type_id` BIGINT COMMENT 'FK to scheduling.appointment_type',
    `authorization_id` BIGINT COMMENT 'Unique identifier for the insurance authorization or pre-certification associated with this appointment, if required by the payer.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Appointments are scheduled as part of care plan execution; care plans drive visit frequency, type, and multidisciplinary coordination. Essential for chronic care management, care coordination billing,',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the healthcare facility or clinic location where the appointment is scheduled to take place.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Appointment-to-cash reconciliation: revenue cycle teams must trace each scheduled appointment to its resulting claim for denial management, no-show billing, and appointment conversion rate reporting. ',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Appointments requiring prior authorization must link to the authorization record for verification at scheduling and check-in. Schedulers validate authorization status, approved units, and date ranges ',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Non-surgical clinical orders (imaging, procedure, therapy orders) result in scheduled appointments. Linking scheduling_appointment to the originating clinical_order supports order-completion tracking,',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary provider scheduled to deliver care during this appointment.',
    `coverage_id` BIGINT COMMENT 'Foreign key linking to billing.billing_coverage. Business justification: Insurance verification at scheduling: the billing coverage record verified at time of appointment booking must be captured for coverage at time of service audits and payer dispute resolution. Revenu',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: At appointment booking, staff verify the applicable coverage policy to confirm the service is covered, check medical necessity criteria, and identify PA requirements. Healthcare schedulers routinely r',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the patient associated with this appointment. Links to the patient master record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Appointments are scheduled for specific diagnoses that drive specialty routing, authorization requirements, and visit type determination. Essential for pre-visit planning and specialty access manageme',
    `eligibility_check_id` BIGINT COMMENT 'Foreign key linking to patient.eligibility_check. Business justification: scheduling_appointment.insurance_verification_status reflects the result of a specific eligibility_check performed at scheduling time. Linking to the eligibility_check record enables revenue cycle sta',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Real-time eligibility verification at appointment booking confirms active coverage, copay amounts, and authorization requirements. Schedulers perform eligibility checks before confirming appointments ',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to insurance.eligibility_span. Business justification: Appointment booking requires verifying the patients active eligibility span to confirm coverage dates, PCP assignment, and referral requirements. The existing eligibility_id links to claim.eligibilit',
    `protocol_id` BIGINT COMMENT 'Foreign key linking to radiology.protocol. Business justification: When scheduling a radiology appointment, the imaging protocol determines slot duration, patient prep instructions, fasting requirements, and contrast screening needs. Schedulers must reference the pro',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: scheduling_appointment carries insurance_verification_status and insurance_verification_timestamp, requiring a reference to the specific coverage verified. Drives prior authorization workflows, eligib',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Appointments must verify active enrollment status at scheduled date to prevent scheduling patients without coverage. Schedulers check enrollment effective/termination dates and PCP assignment requirem',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Enterprise scheduling dashboards, patient safety duplicate detection, and cross-facility appointment history reports require appointments linked to the master patient identity (MPI). Demographics FK e',
    `network_affiliation_id` BIGINT COMMENT 'Foreign key linking to provider.network_affiliation. Business justification: Network status determines patient cost-sharing and appointment eligibility per payer contracts. Links appointment to specific network tier and panel status, enabling real-time verification of in-netwo',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: When a patient books an appointment, they occupy a specific open slot. This FK links the appointment back to the slot it was booked into, enabling slot utilization tracking, overbooking analysis, and ',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Appointments require real-time insurance verification at booking. Schedulers validate payer eligibility, authorization requirements, and network status before confirming appointments. Payer determines',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: When booking an appointment, scheduling systems check the governing prior auth rule to determine if PA is required before the visit. This drives PA workflow initiation at scheduling time and is a core',
    `room_id` BIGINT COMMENT 'Unique identifier for the specific exam room, procedure room, or virtual room assigned to this appointment.',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Appointments are scheduled under a specific clinical service (e.g., Cardiology, Orthopedics). Service-level appointment volume reporting, referral routing, and capacity management require this link. A',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Individual recurring appointments (weekly dialysis, monthly INR checks, regular wound care visits) are generated from standing orders. Linking each scheduling_appointment to its originating standing_o',
    `visit_id` BIGINT COMMENT 'Unique identifier for the associated visit or encounter record if the appointment has been fulfilled. Null for future or cancelled appointments.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Visit reason codes require ICD-10 validation for clinical accuracy, insurance authorization, billing compliance, and quality reporting. Essential for appointment booking workflows and claim submission',
    `appointment_number` STRING COMMENT 'Human-readable business identifier for the appointment, typically displayed to patients and staff. May follow facility-specific numbering conventions.',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the appointment. Tracks progression from scheduling through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|confirmed|checked-in|roomed|arrived|in-progress|completed|cancelled|no-show|rescheduled — 10 candidates stripped; promote to reference product]',
    `arrival_timestamp` TIMESTAMP COMMENT 'The date and time when the patient physically arrived at the facility or joined the virtual waiting room for telehealth appointments.',
    `billing_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the appointment is eligible for billing based on completion status, documentation, and payer rules. Used by revenue cycle to determine billable encounters.',
    `booking_channel` STRING COMMENT 'The channel or interface through which the appointment was originally scheduled. Used for patient access analytics and channel optimization.. Valid values are `phone|online-portal|mobile-app|in-person|referral|system-generated`',
    `booking_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was originally created or booked in the scheduling system.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded explanation for why the appointment was cancelled. May indicate patient-initiated, provider-initiated, or system-initiated cancellation.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code representing the cancellation reason category (e.g., patient request, provider unavailable, weather, no-show conversion).',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was cancelled. Null for non-cancelled appointments.',
    `cancelled_by` STRING COMMENT 'Indicates which party initiated the cancellation of the appointment.. Valid values are `patient|provider|facility|system`',
    `care_setting` STRING COMMENT 'The physical or virtual care environment where the appointment will take place. [ENUM-REF-CANDIDATE: outpatient|emergency|inpatient-consult|procedural|surgical|telehealth|home-health — 7 candidates stripped; promote to reference product]',
    `check_in_timestamp` TIMESTAMP COMMENT 'The date and time when the patient checked in for the appointment, either at a kiosk, front desk, or via mobile check-in.',
    `confirmation_status` STRING COMMENT 'Indicates whether the patient has confirmed their intent to attend the appointment. Separate from appointment status to track patient engagement.. Valid values are `pending|confirmed|declined|needs-action`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'The date and time when the patient confirmed the appointment, either through automated reminder response or manual confirmation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this appointment record was first created in the scheduling system. Audit trail for record creation.',
    `duration_minutes` STRING COMMENT 'The planned duration of the appointment in minutes. Calculated from scheduled start and end times or set by appointment type template.',
    `end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the clinical encounter concluded and the patient was discharged from the appointment.',
    `insurance_verification_status` STRING COMMENT 'Indicates whether patient insurance eligibility and benefits have been verified for this appointment. Critical for revenue cycle and patient financial counseling.. Valid values are `verified|pending|failed|not-required|expired`',
    `insurance_verification_timestamp` TIMESTAMP COMMENT 'The date and time when insurance eligibility was last verified for this appointment.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the patient failed to attend the scheduled appointment without prior cancellation. Used for no-show tracking and patient access policies.',
    `patient_device_type` STRING COMMENT 'The type of device the patient used to access the telehealth appointment (e.g., smartphone, tablet, desktop, laptop). Used for technical support and quality improvement.',
    `priority` STRING COMMENT 'Clinical urgency or priority level assigned to the appointment. Influences scheduling order and resource allocation.. Valid values are `routine|urgent|stat|elective|emergent`',
    `provider_attestation_flag` BOOLEAN COMMENT 'Indicates whether the provider has attested that the telehealth visit met all clinical and regulatory requirements for billing and documentation. Required for telehealth reimbursement.',
    `roomed_timestamp` TIMESTAMP COMMENT 'The date and time when the patient was placed in an exam room or virtual consultation room and is ready to be seen by the provider.',
    `scheduled_date` DATE COMMENT 'The calendar date on which the appointment is scheduled to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the appointment is scheduled to end, including timezone.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the appointment is scheduled to begin, including timezone.',
    `start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the provider began the clinical encounter. May differ from scheduled start time.',
    `telehealth_access_code` STRING COMMENT 'The meeting ID, access code, or PIN required to join the telehealth session. Used for platforms that require separate authentication.',
    `telehealth_connection_status` STRING COMMENT 'Real-time or final status of the telehealth session connection. Tracks technical success of the virtual visit.. Valid values are `not-started|connected|disconnected|failed|completed`',
    `telehealth_platform` STRING COMMENT 'The technology platform or vendor used to conduct the virtual visit (e.g., Epic Video Visit, Zoom for Healthcare, Amwell, Doxy.me). Null for in-person appointments.',
    `telehealth_session_url` STRING COMMENT 'The unique web link or meeting URL provided to the patient and provider to join the virtual visit. Contains session-specific access credentials.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this appointment record was last modified. Audit trail for record changes.',
    `visit_modality` STRING COMMENT 'The mode of interaction for the appointment. Distinguishes traditional in-person visits from telehealth and asynchronous digital encounters.. Valid values are `in-person|video|phone|e-visit|asynchronous`',
    `visit_reason` STRING COMMENT 'Free-text or coded description of the clinical reason or chief complaint for the appointment as stated by the patient or referring provider.',
    `visit_reason_code` STRING COMMENT 'Standardized clinical code representing the reason for the visit. May use ICD-10, SNOMED CT, or internal reason code taxonomy.',
    CONSTRAINT pk_appointment PRIMARY KEY(`appointment_id`)
) COMMENT 'Core master record for every scheduled patient encounter across all care settings (outpatient, ED, procedural, inpatient consult) and all visit modalities (in-person, video/telehealth, phone, e-visit/asynchronous). Captures appointment type, visit reason, care setting, scheduled date/time, duration, status (scheduled, confirmed, checked-in, roomed, arrived, in-progress, completed, cancelled, no-show), priority, booking channel, originating order/referral reference, and insurance verification status. For telehealth/virtual modalities: captures platform (Zoom, Amwell, Epic Video Visit), session URL/access code, connection status, patient device type, provider attestation, and billing eligibility. SSOT for all scheduled patient encounters regardless of modality — aligns with HL7 FHIR Appointment resource. Sourced from Epic Cadence, Cerner Millennium, and telehealth platform integrations.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`appointment_type` (
    `appointment_type_id` BIGINT COMMENT 'Unique identifier for the appointment type. Primary key.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: Appointment types map to specific insurance benefits (preventive care, specialist visit, mental health). This mapping drives copay display, visit limit tracking, and patient cost estimates at scheduli',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Appointment types map to CDM entries for automated charge capture. When appointment is completed, system posts charges based on this mapping. Standard revenue cycle configuration in healthcare to ensu',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Appointment types are directly governed by coverage policies — certain types require PA, have visit limits, or are excluded under specific policies. Linking appointment_type to coverage_policy enables',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Appointment types map to CPT codes for RVU calculation, billing class determination, default duration estimation, and reimbursement forecasting. Core to scheduling configuration and revenue cycle.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Appointment types for preventive services, DME-related visits, and facility-billed encounters are coded under HCPCS rather than CPT. Linking appointment_type to hcpcs_code enables correct billing clas',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Each appointment type governed by policies defining referral requirements, prior authorization rules, billing class restrictions, and patient eligibility criteria. Standard healthcare governance model',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Appointment types have associated prior auth rules determining whether PA is required. The existing prior_authorization_required boolean flag is a denormalization of the rule. Linking to prior_auth_ru',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Appointment types belong to a clinical service (e.g., Cardiology New Patient Visit, Oncology Follow-up). Service-level appointment type governance, billing class assignment, and scheduling rule manage',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Appointment types are specialty-specific (cardiology follow-up vs. orthopedic consult). Linking to specialty enables specialty-based scheduling rules, network adequacy reporting, payer enrollment vali',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: Healthcare appointment types (e.g., telehealth, controlled substance, surgical consult) require specific staff training. This link supports required training per appointment type enforcement — a nam',
    `allows_self_scheduling` BOOLEAN COMMENT 'Indicates whether patients can self-schedule this appointment type through patient portals or online booking systems (e.g., Epic MyChart).',
    `allows_telehealth` BOOLEAN COMMENT 'Indicates whether this appointment type can be conducted via telehealth or virtual visit platforms. Supports remote care delivery and patient access expansion.',
    `appointment_type_category` STRING COMMENT 'High-level classification of the appointment type for grouping and reporting purposes. [ENUM-REF-CANDIDATE: office_visit|telehealth|surgical|procedural|diagnostic|wellness|urgent_care — 7 candidates stripped; promote to reference product]',
    `appointment_type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the appointment type across scheduling systems. Used in Epic Cadence and Cerner Millennium for booking logic.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `appointment_type_description` STRING COMMENT 'Detailed description of the appointment type, including clinical purpose, patient preparation instructions, and scheduling guidelines.',
    `appointment_type_name` STRING COMMENT 'Human-readable name of the appointment type (e.g., New Patient Visit, Follow-Up, Annual Wellness Visit, Pre-Op Consultation, Telehealth Visit).',
    `appointment_type_status` STRING COMMENT 'Current lifecycle status of the appointment type. Inactive or retired types are not available for new scheduling.. Valid values are `active|inactive|suspended|retired`',
    `billing_class` STRING COMMENT 'The billing classification for this appointment type (professional, facility, technical, or global). Determines charge capture and claim submission rules.. Valid values are `professional|facility|technical|global`',
    `cancellation_notice_hours` STRING COMMENT 'Minimum number of hours notice required for appointment cancellation without penalty. Supports scheduling policy enforcement and capacity optimization.',
    `care_setting` STRING COMMENT 'The care delivery setting where this appointment type is applicable (e.g., outpatient clinic, emergency department, telehealth platform).. Valid values are `outpatient|inpatient|emergency|telehealth|home_health|ambulatory_surgery`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this appointment type record was first created in the system. Supports audit trail and data lineage.',
    `default_duration_minutes` STRING COMMENT 'Standard duration in minutes allocated for this appointment type. Used by scheduling systems for capacity planning and slot allocation.',
    `effective_end_date` DATE COMMENT 'The date when this appointment type was retired or discontinued. Null for currently active types.',
    `effective_start_date` DATE COMMENT 'The date when this appointment type became available for scheduling. Supports historical tracking and compliance reporting.',
    `equipment_required` STRING COMMENT 'Specialized equipment or resources required for this appointment type (e.g., ultrasound machine, EKG, surgical instruments). Supports resource scheduling and capacity planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this appointment type record was last updated. Supports change tracking and audit compliance.',
    `maximum_duration_minutes` STRING COMMENT 'Maximum allowable duration in minutes for this appointment type. Prevents over-allocation of provider time and supports throughput optimization.',
    `minimum_duration_minutes` STRING COMMENT 'Minimum allowable duration in minutes for this appointment type. Enforces scheduling constraints to ensure adequate time for clinical activities.',
    `no_show_penalty_applies` BOOLEAN COMMENT 'Indicates whether a no-show penalty or fee applies to this appointment type. Supports revenue protection and patient accountability.',
    `patient_class` STRING COMMENT 'Classification of the patient relationship for this appointment type (e.g., new patient, established patient, return visit). Impacts billing and documentation requirements.. Valid values are `new_patient|established_patient|return_patient|referral`',
    `preparation_instructions` STRING COMMENT 'Instructions provided to patients before the appointment (e.g., fasting requirements, medication holds, forms to complete). Supports patient education and visit readiness.',
    `quality_measure_applicable` BOOLEAN COMMENT 'Indicates whether this appointment type is subject to quality measurement and reporting requirements (e.g., HEDIS, MIPS, CAHPS).',
    `reminder_lead_time_days` STRING COMMENT 'Number of days before the appointment when automated reminders should be sent to patients. Supports no-show reduction and patient engagement.',
    `requires_interpreter` BOOLEAN COMMENT 'Indicates whether this appointment type typically requires interpreter services. Supports resource allocation and compliance with language access requirements.',
    `requires_referral` BOOLEAN COMMENT 'Indicates whether this appointment type requires a referral from a Primary Care Physician (PCP) or other provider. Used for authorization and scheduling validation.',
    `room_type_required` STRING COMMENT 'The type of clinical room or facility space required for this appointment type (e.g., exam room, procedure room, operating room, telehealth station).',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'Malpractice RVU assigned to this appointment type. Reflects professional liability insurance costs.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'Practice expense RVU assigned to this appointment type. Reflects overhead costs associated with delivering the service.',
    `rvu_work` DECIMAL(18,2) COMMENT 'Work RVU assigned to this appointment type for physician productivity tracking and compensation. Based on CMS Physician Fee Schedule.',
    `staff_roles_required` STRING COMMENT 'Clinical and administrative staff roles required to support this appointment type (e.g., physician, nurse, medical assistant, anesthesiologist). Comma-separated list.',
    `visit_type_code` STRING COMMENT 'Standard visit type code used for billing and revenue cycle integration. Maps to charge capture and claim submission workflows.',
    `waitlist_eligible` BOOLEAN COMMENT 'Indicates whether patients can be placed on a waitlist for this appointment type when no slots are available. Supports access optimization and patient satisfaction.',
    CONSTRAINT pk_appointment_type PRIMARY KEY(`appointment_type_id`)
) COMMENT 'Reference catalog of all appointment types defined across care settings (e.g., new patient visit, follow-up, annual wellness, pre-op, post-op, telehealth, urgent care). Includes CPT/visit type code mapping, default duration, care setting applicability, specialty association, and scheduling rules. Drives appointment booking logic and capacity planning in Epic Cadence and Cerner Millennium.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`schedule_template` (
    `schedule_template_id` BIGINT COMMENT 'Unique identifier for the schedule template record. Primary key.',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: A schedule template is configured for a specific appointment type (e.g., new patient visit, follow-up). schedule_template currently stores appointment_type_code as a denormalized STRING. Replacing it ',
    `care_site_id` BIGINT COMMENT 'Identifier for the facility or location where this schedule template is applicable.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Schedule templates are built around a specific clinicians availability pattern. Credentialing and scheduling teams use clinician-linked templates to manage provider schedules, enforce availability ru',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Schedule templates are owned by provider groups in multi-provider practices (e.g., a cardiology groups weekly template). Group-level template ownership drives panel management, group scheduling repor',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Schedule templates are built for specific providers whose NPI must be validated against the federal NPI registry for credentialing compliance and network directory accuracy. provider_npi is a denormal',
    `or_suite_id` BIGINT COMMENT 'Foreign key linking to facility.or_suite. Business justification: Surgical schedule templates are defined for specific OR suites (e.g., OR Suite 3 template for cardiac surgery). OR suite-specific templates govern surgical scheduling rules, block time, and turnover r',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Schedule templates must comply with regulatory policies governing work hour limits, rest periods, credentialing requirements, and fair access rules. Real compliance need in healthcare scheduling.',
    `schedulable_resource_id` BIGINT COMMENT 'Identifier for the resource (room, equipment, facility) to which this template applies. Null if template applies to a provider.',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Schedule templates are built per clinical service line (e.g., Oncology service template, Orthopedics service template). Service-level capacity planning, block time allocation, and scheduling rule gove',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Templates are specialty-specific to enforce appropriate slot durations, appointment types, and staffing requirements. Specialty-based template management drives network adequacy reporting and scheduli',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Schedule templates are defined at the unit level (e.g., Cardiology Clinic unit, Ambulatory Surgery unit) to govern unit-specific scheduling rules, slot durations, and capacity. Unit-level template man',
    `approval_status` STRING COMMENT 'Approval status of the schedule template. Templates may require administrative or clinical approval before becoming active.. Valid values are `pending|approved|rejected|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule template was approved. Null if not yet approved or approval is not required.',
    `auto_confirm_flag` BOOLEAN COMMENT 'Indicates whether appointments scheduled under this template are automatically confirmed or require manual confirmation. True auto-confirms; False requires manual review.',
    `buffer_time_minutes` STRING COMMENT 'Buffer time in minutes added between consecutive appointment slots to allow for provider preparation, documentation, or patient transition.',
    `cancellation_policy_code` STRING COMMENT 'Code identifying the cancellation policy applicable to appointments scheduled under this template (e.g., 24_HOUR, 48_HOUR, NO_SHOW_FEE).',
    `care_setting` STRING COMMENT 'The care delivery setting where this schedule template is used (outpatient clinic, surgical suite, emergency department, telehealth, etc.).. Valid values are `outpatient|inpatient|emergency|surgical|telehealth|home_health`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule template record was first created in the system.',
    `day_of_week` STRING COMMENT 'Comma-separated list of days of the week this template applies to (e.g., Monday,Wednesday,Friday). Used for weekly recurrence patterns. [ENUM-REF-CANDIDATE: Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday — promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this schedule template expires and stops generating appointment slots. Null indicates open-ended template.',
    `effective_start_date` DATE COMMENT 'Date when this schedule template becomes active and begins generating appointment slots.',
    `max_slots_per_session` STRING COMMENT 'Maximum number of appointment slots that can be scheduled within a single session. Used for capacity planning and overbooking control.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule template record was last modified.',
    `no_show_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether no-show events are tracked for appointments scheduled under this template. True enables tracking; False does not.',
    `notes` STRING COMMENT 'Free-text notes or comments about this schedule template, including special instructions, restrictions, or administrative remarks.',
    `overbooking_allowed_flag` BOOLEAN COMMENT 'Indicates whether overbooking (scheduling beyond max_slots_per_session) is permitted for this template. True allows overbooking; False enforces strict capacity limits.',
    `overbooking_limit` STRING COMMENT 'Maximum number of additional slots that can be overbooked beyond max_slots_per_session. Null if overbooking is not allowed.',
    `patient_class` STRING COMMENT 'Classification of patients eligible for appointments under this template (e.g., NEW, ESTABLISHED, REFERRAL, SELF_PAY). [ENUM-REF-CANDIDATE: new|established|referral|self_pay|medicare|medicaid|commercial — promote to reference product]',
    `priority_level` STRING COMMENT 'Priority classification for appointments scheduled under this template. Determines scheduling urgency and slot allocation rules.. Valid values are `routine|urgent|emergent|elective`',
    `recurrence_pattern` STRING COMMENT 'Defines how the template recurs over time: daily, weekly, biweekly, monthly, rotating shift, or custom pattern.. Valid values are `daily|weekly|biweekly|monthly|rotating|custom`',
    `recurrence_rule` STRING COMMENT 'Detailed recurrence rule in iCalendar RRULE format or system-specific notation defining the exact repeat logic (e.g., FREQ=WEEKLY;BYDAY=MO,WE,FR).',
    `reminder_enabled_flag` BOOLEAN COMMENT 'Indicates whether automated appointment reminders (SMS, email, phone) are sent for appointments scheduled under this template. True enables reminders; False disables.',
    `reminder_lead_time_hours` STRING COMMENT 'Number of hours before the appointment when the reminder is sent. Null if reminders are not enabled.',
    `service_type_code` STRING COMMENT 'Code identifying the type of clinical service provided during appointments scheduled under this template (e.g., OFFICE_VISIT, SURGERY, DIAGNOSTIC).',
    `session_duration_minutes` STRING COMMENT 'Total duration of the scheduled session in minutes. Calculated as the difference between session start and end times.',
    `session_end_time` TIMESTAMP COMMENT 'Time of day when the scheduled session ends, in HH:MM 24-hour format (e.g., 17:00, 21:00).',
    `session_start_time` TIMESTAMP COMMENT 'Time of day when the scheduled session begins, in HH:MM 24-hour format (e.g., 08:00, 13:30).',
    `slot_duration_minutes` STRING COMMENT 'Duration of each individual appointment slot within the session, in minutes (e.g., 15, 30, 60). Determines how many slots are generated per session.',
    `source_system` STRING COMMENT 'Name of the source system from which this schedule template record originated (e.g., Epic Cadence, Cerner Scheduling, OpTime).',
    `source_system_code` STRING COMMENT 'Unique identifier for this schedule template in the source system. Used for data lineage and reconciliation.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether this schedule template supports telehealth/virtual appointments. True enables telehealth; False restricts to in-person only.',
    `template_name` STRING COMMENT 'Business-friendly name for the schedule template (e.g., Dr. Smith Monday Clinic, OR 3 Weekday Block).',
    `template_status` STRING COMMENT 'Current lifecycle status of the schedule template. Active templates are used for slot generation; inactive/retired templates are historical.. Valid values are `active|inactive|draft|suspended|retired|pending`',
    `template_type` STRING COMMENT 'Classification of the schedule template indicating whether it applies to a provider, resource, facility, equipment, room, or staff member.. Valid values are `provider|resource|facility|equipment|room|staff`',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Indicates whether a waitlist is maintained for this schedule template when all slots are filled. True enables waitlist management; False does not.',
    CONSTRAINT pk_schedule_template PRIMARY KEY(`schedule_template_id`)
) COMMENT 'Provider and resource schedule templates defining recurring availability patterns (daily, weekly, rotating) plus real-time availability exceptions, overrides, and leave records. For templates: captures template name, effective date range, applicable provider or resource, time block definitions, appointment type slots, session duration, and recurrence rules. For availability exceptions: captures provider NPI, exception type (vacation, CME, administrative, on-call, blocked, emergency override), start/end datetime, care setting, reason for unavailability, and approval status. SSOT for all provider/resource availability — both the recurring blueprint and its real-time modifications. Aligns with HL7 FHIR Schedule resource. Used by Epic Cadence and OpTime to generate open scheduling slots.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`open_slot` (
    `open_slot_id` BIGINT COMMENT 'Unique identifier for the open scheduling slot. Primary key for the open_slot data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where the slot is available. Links to the facility master data product. Critical for multi-site organizations.',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider (physician, nurse practitioner, therapist) assigned to this slot. Links to the provider master data product. Used for provider-specific appointment booking.',
    `equipment_asset_id` BIGINT COMMENT 'Reference to specialized medical equipment required for this slot. Links to the equipment resource data product. Examples include MRI machines, surgical robots, dialysis machines. Null if no specific equipment is required.',
    `room_id` BIGINT COMMENT 'Reference to the specific room or treatment space allocated for this slot. Links to the room resource data product. Used for surgical scheduling (OpTime) and procedure room allocation.',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: An open slot belongs to a specific schedulable resource (provider, room, or equipment). While open_slot already has clinician_id, equipment_asset_id, and room_id as cross-domain FKs, the in-domain sch',
    `schedule_template_id` BIGINT COMMENT 'Reference to the parent schedule template from which this slot was generated. Links to the schedule data product that defines recurring availability patterns for providers, rooms, or equipment.',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Open slots are offered under specific clinical services for referral routing and patient self-scheduling. Service-level slot availability reporting and access metrics (e.g., third-next-available appoi',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Slot availability by specialty drives patient self-scheduling, network adequacy gap analysis, and provider directory accuracy. specialty is a denormalized text representation of the specialty entity; ',
    `appointment_type_eligibility` STRING COMMENT 'Comma-separated list of appointment types that are eligible to be booked in this slot. Examples include new patient, follow-up, annual physical, procedure. Enforces business rules for slot utilization.',
    `block_reason` STRING COMMENT 'Free-text explanation for why the slot is blocked or unavailable. Examples include provider time off, equipment maintenance, facility closure, administrative time. Null if slot is available for booking.',
    `block_type` STRING COMMENT 'Categorization of the reason the slot is blocked. Used for reporting on non-clinical time utilization and capacity planning. Null if slot is not blocked.. Valid values are `administrative|personal|maintenance|training|meeting|other`',
    `care_setting` STRING COMMENT 'The care delivery environment where the slot is available. Distinguishes between outpatient clinics, inpatient units, emergency department (ED), operating room (OR), telehealth, and home health settings.. Valid values are `outpatient|inpatient|emergency|surgical|telehealth|home_health`',
    `comment` STRING COMMENT 'Free-text notes or special instructions associated with the slot. May include preparation requirements, patient instructions, or scheduling coordinator notes. Visible to scheduling staff and potentially to patients.',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when this slot record was first created in the scheduling system. Used for audit trail and slot generation tracking.',
    `hold_expiration_datetime` TIMESTAMP COMMENT 'The date and time when a held slot will automatically be released if not confirmed. Null if slot is not currently held. Used to prevent indefinite slot blocking and optimize capacity utilization.',
    `hold_reason` STRING COMMENT 'Free-text explanation for why the slot is held. Examples include pending insurance authorization, awaiting patient callback, reserved for urgent referral. Null if slot is not held.',
    `hold_status` STRING COMMENT 'Indicates whether the slot is currently held for a specific patient or referral. Held slots are temporarily reserved pending confirmation. Expired holds are automatically released after a configured timeout period.. Valid values are `available|held|released|expired`',
    `insurance_eligibility` STRING COMMENT 'Comma-separated list of insurance types or payer groups accepted for this slot. Examples include Medicare, Medicaid, commercial, self-pay. Used for payer-specific access management and network compliance.',
    `last_modified_datetime` TIMESTAMP COMMENT 'The date and time when this slot record was last updated. Tracks changes to slot status, capacity, or configuration. Critical for real-time slot availability synchronization.',
    `max_capacity` STRING COMMENT 'The maximum number of appointments that can be booked in this slot. Typically 1 for individual provider appointments, but may be higher for group visits, classes, or high-volume clinics.',
    `online_booking_cutoff_hours` STRING COMMENT 'The minimum number of hours in advance that a patient must book this slot online. Prevents same-day or last-minute online bookings. Null if no cutoff applies or online booking is disabled.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether this slot is available for patient self-scheduling through online portals such as Epic MyChart or Cerner patient portal. False restricts booking to staff-assisted scheduling only.',
    `overbook_allowed_flag` BOOLEAN COMMENT 'Indicates whether this slot can be overbooked beyond its max_capacity. True allows scheduling additional appointments when slot is full, typically used for urgent or walk-in patients. False enforces strict capacity limits.',
    `patient_type_eligibility` STRING COMMENT 'Defines which patient types can book this slot. Examples include established patient only, new patient only, pediatric, adult, geriatric. Used to enforce age restrictions and patient relationship requirements.',
    `remaining_capacity` STRING COMMENT 'The number of appointments that can still be booked in this slot. Supports overbooking scenarios where multiple patients can be scheduled in the same time slot. Value of 0 indicates slot is fully booked.',
    `slot_category` STRING COMMENT 'Broad categorization of the slot for grouping and filtering purposes. Examples include outpatient, surgical, diagnostic, telehealth, emergency. Used for capacity planning and reporting.',
    `slot_duration_minutes` STRING COMMENT 'The length of the slot in minutes, calculated as the difference between slot_end_datetime and slot_start_datetime. Standard durations vary by appointment type and provider specialty.',
    `slot_end_datetime` TIMESTAMP COMMENT 'The date and time when the slot ends. Represents the latest time an appointment can conclude in this slot. Used to calculate slot duration and prevent overbooking.',
    `slot_identifier` STRING COMMENT 'Human-readable business identifier for the slot, typically generated from schedule template and date/time. Used for external reference and display in Epic Cadence and Cerner scheduling interfaces.',
    `slot_start_datetime` TIMESTAMP COMMENT 'The date and time when the slot begins. Represents the earliest time an appointment can start in this slot. Critical for patient scheduling and resource allocation.',
    `slot_status` STRING COMMENT 'Current availability status of the slot. Free indicates bookable, busy indicates occupied, busy-unavailable indicates blocked, busy-tentative indicates held pending confirmation. Aligns with HL7 FHIR SlotStatus value set.. Valid values are `free|busy|busy-unavailable|busy-tentative|entered-in-error`',
    `slot_type` STRING COMMENT 'Classification of the slot indicating the kind of appointment or service that can be booked. Examples include new patient visit, follow-up, procedure, telehealth, walk-in. Sourced from Epic Cadence visit type or Cerner appointment type configuration.',
    `source_system` STRING COMMENT 'The operational system of record from which this slot was sourced. Examples include Epic Cadence for outpatient scheduling, OpTime for surgical scheduling, Cerner scheduling for inpatient appointments.. Valid values are `epic_cadence|cerner_scheduling|optime|meditech|other`',
    `source_system_identifier` STRING COMMENT 'The unique identifier for this slot in the source operational system. Used for data lineage, reconciliation, and bidirectional synchronization between lakehouse and operational systems.',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Indicates whether patients can be added to a waitlist for this slot if it is fully booked. True enables waitlist management for high-demand slots. Used for cancellation backfill and access optimization.',
    CONSTRAINT pk_open_slot PRIMARY KEY(`open_slot_id`)
) COMMENT 'Individual available scheduling slots generated from schedule templates for providers, rooms, and equipment. Captures slot date/time, duration, slot type, care setting, resource assignment, appointment type eligibility, hold status, and remaining capacity. Represents the real-time inventory of bookable time — aligns with HL7 FHIR Slot resource. Consumed by appointment booking workflows, patient self-scheduling (Epic MyChart), and patient access teams in Epic Cadence and Cerner scheduling.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`surgical_case` (
    `surgical_case_id` BIGINT COMMENT 'Unique identifier for the surgical or procedural case. Primary key for the surgical case record. System-generated surrogate key used across Epic OpTime and Cerner SurgiNet modules.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: A surgical case originates from a scheduled appointment in the scheduling system. Linking surgical_case to its parent scheduling_appointment enables end-to-end traceability from appointment booking th',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to encounter.encounter_authorization. Business justification: Pre-operative authorization verification is a mandatory surgical scheduling workflow. Surgical scheduling teams must confirm the encounter-level prior authorization covers the planned surgical case be',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Surgical procedures routinely require prior authorization. Case coordinators verify authorization approval, approved CPT codes, and unit limits before scheduling OR time. Authorization status is a gat',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Surgical cases originate from surgical orders placed by surgeons. OR scheduling requires linking cases to originating orders for authorization verification, clinical indication tracking, and regulator',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: surgical_case has consent_obtained_indicator and consent_timestamp as local flags, but Joint Commission and CMS Conditions of Participation require a formal, auditable consent record for every surgica',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Surgical case scheduling requires coverage policy verification to confirm the procedure is covered, identify medical necessity criteria, and determine PA requirements. Surgical scheduling teams refere',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Surgical cases require pre-operative diagnosis for authorization, case planning, DRG prediction, and procedure appropriateness determination. Core to surgical scheduling workflow and perioperative car',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: DRG assignment at case scheduling enables reimbursement forecasting, case costing, length-of-stay estimation, and OR block value analysis. Essential for surgical service line financial planning.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Surgical cases are attributed to a surgical group for billing, quality reporting, and service line management. Group-level surgical case attribution drives group contract compliance, value-based care ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Surgical cases need plan-specific benefit verification for inpatient vs outpatient coverage, copays, deductibles, and network requirements. Surgery schedulers verify plan benefits to estimate patient ',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: Surgical cases involving implants or specialty devices are governed by vendor contracts (consignment implant agreements, loaner instrument programs). OR supply chain managers and compliance teams requ',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Surgical prior authorization, case costing, and surgical billing are coverage-specific, not just payer-specific. surgical_case already has payer_id but the specific plan/coverage determines benefits, ',
    `malpractice_coverage_id` BIGINT COMMENT 'Foreign key linking to provider.malpractice_coverage. Business justification: Surgical case scheduling requires current malpractice insurance verification per hospital medical staff bylaws and risk management policies. Links case to active policy covering procedure specialty an',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Surgical case management requires the patients active member enrollment record to verify benefits, confirm coverage at time of surgery, and coordinate billing. surgical_case has health_plan_id and pa',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: surgical_case.mrn is a denormalized patient identifier with no FK. Surgical safety protocols (Joint Commission, CMS), surgical quality reporting (NSQIP), and post-op follow-up workflows require direct',
    `or_block_id` BIGINT COMMENT 'Foreign key linking to scheduling.or_block. Business justification: A surgical case is scheduled within an OR block time allocation. This FK captures which block the case consumes time from, enabling block utilization reporting and capacity management. surgical_case.b',
    `or_suite_id` BIGINT COMMENT 'Identifier for the specific operating room or surgical suite where the case is scheduled. Used for room assignment, equipment allocation, and capacity management.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Surgical cases require payer-specific pre-certification, utilization review, and authorization before OR booking. Surgery schedulers verify payer requirements, timely filing limits, and authorization ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Pre-operative diagnosis ICD code required for surgical authorization, medical necessity validation, DRG assignment, and clinical documentation. Essential for case scheduling approval and compliance.',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Surgical cases require pre-operative imaging (chest X-ray, CT). surgical_case already has preop_lab_order_id for labs; the analogous pre-op imaging order link is missing. This supports pre-op checklis',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Pre-operative lab orders (type & screen, CBC, coagulation studies) are mandatory surgical workflow requirements. Critical for surgical clearance protocols, anesthesia safety, and tracking completion o',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Primary procedure CPT lookup required for OR block allocation, case costing, anesthesia base unit calculation, equipment requirements, and surgical billing. Critical for perioperative scheduling and r',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Surgical procedures almost universally require prior authorization. Linking surgical_case to the governing prior_auth_rule enables tracking which rule was applied, turnaround time compliance, and regu',
    `privileging_id` BIGINT COMMENT 'Foreign key linking to provider.privileging. Business justification: Surgical case scheduling requires verification of procedure-specific clinical privileges per Joint Commission MS standards. Links case to exact privilege record covering the CPT code, ensuring surgeon',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Surgical cases belong to a clinical service (e.g., Cardiovascular Surgery, Orthopedic Surgery). Service-level surgical volume, block time utilization, and quality reporting require this FK. The existi',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Surgical case specialty attribution drives OR utilization reporting, quality metrics by specialty, service line P&L, and CMS specialty-based quality program reporting. specialty is a denormalized text',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_location. Business justification: Surgical case cart preparation requires linking each case to its designated supply staging inventory location (sterile core, OR satellite). Perioperative supply chain teams use this to pull and stage ',
    `utilization_review_id` BIGINT COMMENT 'Foreign key linking to insurance.utilization_review. Business justification: Inpatient and high-cost surgical cases are subject to utilization review governing approved length of stay and medical necessity. Linking surgical_case to utilization_review enables payer compliance t',
    `visit_id` BIGINT COMMENT 'Reference to the encounter or visit during which this surgical case occurs. Links to the inpatient admission or outpatient encounter record.',
    `actual_duration_minutes` STRING COMMENT 'Actual length of the surgical procedure in minutes. Calculated from actual start and end times. Used for performance benchmarking and future duration estimation refinement.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when the surgical procedure concluded. Captured when the patient exits the OR or when closure is complete. Used for duration variance analysis and turnover time calculation.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when the surgical procedure began. Captured when the patient enters the operating room or when incision occurs, depending on institutional policy. Used for on-time start performance measurement.',
    `add_on_case_indicator` BOOLEAN COMMENT 'Indicates whether this case was added to the schedule after the initial scheduling deadline. Add-on cases may indicate urgent needs or scheduling inefficiencies.',
    `anesthesia_type` STRING COMMENT 'Type of anesthesia planned or administered for the surgical case. Determines anesthesia staffing requirements, billing codes, and patient preparation protocols.. Valid values are `general|regional|local|monitored_anesthesia_care|sedation|none`',
    `asa_classification` STRING COMMENT 'ASA physical status classification representing the patients pre-anesthesia medical condition. Ranges from I (healthy) to VI (brain-dead organ donor). Used for risk stratification and anesthesia planning.. Valid values are `I|II|III|IV|V|VI`',
    `block_time_indicator` BOOLEAN COMMENT 'Indicates whether this case is scheduled within a surgeons allocated block time. Block time is pre-reserved OR time assigned to specific surgeons or services. Used for block utilization reporting.',
    `cancellation_reason` STRING COMMENT 'Reason for case cancellation if status is cancelled. Categorized into patient-related, physician-related, facility-related, or administrative reasons. Used for quality improvement and scheduling optimization.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the surgical case was cancelled. Used to measure cancellation lead time and assess impact on OR utilization.',
    `case_number` STRING COMMENT 'Business identifier for the surgical case. Human-readable case number assigned by the surgical scheduling system. Used for operational tracking and communication between surgical staff.. Valid values are `^[A-Z0-9]{8,20}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the surgical case. Tracks progression from initial request through completion or cancellation. Critical for operational dashboards and capacity planning. [ENUM-REF-CANDIDATE: requested|scheduled|confirmed|in_progress|completed|cancelled|postponed|on_hold — 8 candidates stripped; promote to reference product]',
    `case_type` STRING COMMENT 'Classification of the surgical case based on patient status and urgency. Determines scheduling priority, resource allocation, and billing rules.. Valid values are `inpatient|outpatient|ambulatory|emergency|trauma|transplant`',
    `consent_obtained_indicator` BOOLEAN COMMENT 'Indicates whether informed consent has been obtained from the patient or legal representative. Required before proceeding with surgery. Used for compliance verification.',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when informed consent was obtained. Used for regulatory compliance documentation and pre-operative checklist verification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the surgical case record was first created in the system. Used for audit trail and data lineage tracking.',
    `equipment_requirements` STRING COMMENT 'Special equipment or instrumentation required for the surgical case. Free-text or structured list of equipment codes. Used for equipment scheduling and availability verification.',
    `estimated_duration_minutes` STRING COMMENT 'Estimated length of the surgical procedure in minutes. Based on historical averages for the procedure type, surgeon, and patient complexity. Used for block time allocation and scheduling optimization.',
    `facility_code` STRING COMMENT 'Code identifying the hospital or surgical facility where the case is performed. Used for multi-site health systems to track case volume and resource utilization by location.. Valid values are `^[A-Z0-9]{3,10}$`',
    `implant_required` BOOLEAN COMMENT 'Indicates whether the surgical case requires implantable devices or hardware. Triggers supply chain coordination and implant tracking requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the surgical case record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `laterality` STRING COMMENT 'Anatomical side on which the procedure is performed. Critical for surgical site verification and wrong-site surgery prevention. Part of the Universal Protocol.. Valid values are `left|right|bilateral|not_applicable`',
    `patient_class` STRING COMMENT 'Patient classification for the surgical encounter. Determines billing rules, bed assignment requirements, and post-operative care pathways.. Valid values are `inpatient|outpatient|observation|same_day_surgery|extended_recovery`',
    `post_op_diagnosis` STRING COMMENT 'Final clinical diagnosis documented after the surgical procedure. May differ from pre-operative diagnosis based on intra-operative findings. Used for billing and clinical documentation.',
    `requires_blood_products` BOOLEAN COMMENT 'Indicates whether the surgical case requires blood products to be available. Triggers blood bank coordination and type-and-screen orders.',
    `requires_icu_bed` BOOLEAN COMMENT 'Indicates whether the patient will require an ICU bed post-operatively. Used for bed management and capacity planning coordination between OR and ICU.',
    `scheduled_date` DATE COMMENT 'Date on which the surgical procedure is scheduled to occur. Used for day-level capacity planning and patient preparation scheduling.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Anticipated date and time when the surgical case is expected to conclude. Calculated from scheduled start time plus estimated duration. Used for downstream resource planning.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise date and time when the surgical case is scheduled to begin. Used for minute-level OR scheduling, staff coordination, and patient arrival instructions.',
    `site_marked_indicator` BOOLEAN COMMENT 'Indicates whether the surgical site has been marked by the surgeon. Required by the Universal Protocol for procedures involving laterality or multiple structures. Used for pre-operative safety checklist.',
    `timeout_completed_indicator` BOOLEAN COMMENT 'Indicates whether the surgical team completed the mandatory pre-incision timeout. Timeout verifies patient identity, procedure, site, and team readiness. Required by The Joint Commission.',
    `urgency_level` STRING COMMENT 'Clinical urgency classification of the surgical case. Determines scheduling priority and resource allocation. Emergent cases may displace elective cases.. Valid values are `elective|urgent|emergent|trauma`',
    CONSTRAINT pk_surgical_case PRIMARY KEY(`surgical_case_id`)
) COMMENT 'Master record for every scheduled surgical or procedural case managed through OpTime or Cerner SurgiNet. Captures case type, procedure codes (CPT/ICD-10-PCS), scheduled OR suite, primary surgeon, anesthesia type, estimated duration, case status (requested, scheduled, in-progress, completed, cancelled), ASA classification, and block time utilization. SSOT for surgical scheduling distinct from outpatient appointments.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`or_block` (
    `or_block_id` BIGINT COMMENT 'Unique identifier for the operating room block time allocation record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the hospital or surgical facility where the OR block is allocated.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: OR blocks map to facility charges in CDM for OR time billing. Block type determines facility fee structure (prime time vs. off-hours). Needed for automated OR facility charge capture and block utiliza',
    `clinician_id` BIGINT COMMENT 'Identifier of the individual surgeon who owns the block, if block_owner_type is surgeon. References provider master data.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: OR blocks are commonly owned by surgical groups (e.g., a cardiac surgery group owns Monday morning block time). Group-owned OR block management drives block utilization reporting, group contract compl',
    `or_suite_id` BIGINT COMMENT 'Identifier of the specific operating room or surgical suite assigned to this block.',
    `service_id` BIGINT COMMENT 'Identifier of the surgical service or service line that owns the block, if block_owner_type is service.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: OR block allocation governed by utilization policies, fair access rules, release policies, and anti-discrimination requirements. Real governance need in surgical scheduling operations.',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: An OR block is allocated to a specific schedulable resource — typically a surgeon or surgical service. While or_block has clinician_id (cross-domain) and owner_service_id (cross-domain), the in-domain',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: OR block allocation by specialty is a core hospital operations concept driving OR utilization reporting, specialty-based block release rules, and surgical service line management. owner_specialty_code',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_location. Business justification: OR blocks are served by dedicated supply staging inventory locations (OR core supply rooms, specialty carts). Linking or_block to inventory_location enables block-level supply planning, par level mana',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: OR blocks allocated by procedure type require CPT reference for duration estimation, equipment planning, anesthesia type determination, and block utilization analysis. Core to perioperative capacity m',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: OR blocks allocated to specific service lines (orthopedics, cardiac, spine) are tied to vendor contracts governing implants and devices used in those blocks. Supply chain and OR directors use this lin',
    `allows_overbooking` BOOLEAN COMMENT 'Indicates whether cases can be scheduled beyond the allocated block end time, allowing for extended use of the OR suite.',
    `allows_sharing` BOOLEAN COMMENT 'Indicates whether the block owner permits other surgeons or services to share unused portions of the block time.',
    `anesthesia_type_required` STRING COMMENT 'Type of anesthesia typically required for cases scheduled in this block (e.g., general, regional, local, MAC). Used for resource planning.',
    `block_duration_minutes` STRING COMMENT 'Total duration of the OR block in minutes, calculated from start to end time.',
    `block_end_time` TIMESTAMP COMMENT 'Time of day when the OR block ends, in HH:mm format (e.g., 15:30). Represents the scheduled end of the allocated time window.',
    `block_name` STRING COMMENT 'Descriptive name of the OR block, often including the service or surgeon name for easy identification.',
    `block_number` STRING COMMENT 'Business identifier or code for the OR block allocation, used for scheduling and reporting purposes.',
    `block_owner_type` STRING COMMENT 'Type of entity that owns or controls the block time allocation (service line, individual surgeon, specialty, department, or open block).. Valid values are `service|surgeon|specialty|department|open`',
    `block_start_time` TIMESTAMP COMMENT 'Time of day when the OR block begins, in HH:mm format (e.g., 07:30). Represents the scheduled start of the allocated time window.',
    `block_status` STRING COMMENT 'Current operational status of the OR block allocation indicating whether it is available for scheduling.. Valid values are `active|suspended|cancelled|expired|pending`',
    `block_type` STRING COMMENT 'Classification of the block allocation indicating priority and usage rules (primary block has first priority, secondary is backup, open is available to all, flex is flexible allocation, call is for on-call cases).. Valid values are `primary|secondary|tertiary|open|flex|call`',
    `cancellation_reason` STRING COMMENT 'Reason why the block allocation was permanently cancelled (e.g., surgeon departure, service line closure, contract termination).',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which OR block time and associated costs are allocated for accounting and budgeting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the OR block allocation record was first created in the system.',
    `day_of_week` STRING COMMENT 'Day of the week on which this block time is allocated (recurring weekly schedule). [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this block allocation expires or is no longer active. Null indicates an open-ended allocation.',
    `effective_start_date` DATE COMMENT 'Date when this block allocation becomes active and available for scheduling.',
    `equipment_set_required` STRING COMMENT 'Standard equipment set or configuration required for cases in this block (e.g., orthopedic, cardiac, robotic). Used for OR setup and resource allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the OR block allocation record was most recently updated or modified.',
    `minimum_utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of block time that must be utilized to maintain the block allocation. Used for performance monitoring and block reallocation decisions.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to the block allocation, including scheduling preferences, restrictions, or coordination requirements.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority of this block when multiple blocks overlap or compete for the same OR suite. Lower numbers indicate higher priority.',
    `recurring_pattern` STRING COMMENT 'Pattern describing how the block recurs over time (e.g., every week, every other week, first Monday of month). [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|first_week|second_week|third_week|fourth_week|custom — 8 candidates stripped; promote to reference product]',
    `release_lead_time_days` STRING COMMENT 'Number of days before the block date that unused time must be released, if release_rule_type is days_before.',
    `release_lead_time_hours` STRING COMMENT 'Number of hours before the block start time that unused time must be released, if release_rule_type is hours_before.',
    `release_rule_type` STRING COMMENT 'Type of rule governing when unused block time is released back to the general pool for other surgeons or services to use.. Valid values are `days_before|hours_before|no_release|manual`',
    `staff_roles_required` STRING COMMENT 'Comma-separated list of staff roles or specialties required to support cases in this block (e.g., scrub nurse, circulating nurse, surgical tech, perfusionist).',
    `suspension_reason` STRING COMMENT 'Reason why the block was suspended or temporarily inactivated (e.g., low utilization, surgeon leave, facility maintenance).',
    `target_utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Target percentage of block time utilization that the owner is expected to achieve for optimal OR capacity management.',
    CONSTRAINT pk_or_block PRIMARY KEY(`or_block_id`)
) COMMENT 'Operating room block time allocations assigned to surgical services, specialties, or individual surgeons. Captures block owner (service/surgeon), OR suite, day of week, start/end time, block type (primary, secondary, open), release rules, utilization thresholds, and effective date range. Drives OR capacity planning and block utilization reporting. Sourced from Epic OpTime block scheduling.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` (
    `schedulable_resource_id` BIGINT COMMENT 'Unique identifier for the schedulable resource. Primary key for the schedulable resource entity.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Schedulable resources are physically located in specific buildings, driving scheduling constraints (travel time, cross-building availability). The plain-text building column on schedulable_resource ',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility or hospital where this resource is located or primarily operates. Links to the facility domain master.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Clinicians are the primary schedulable resource type. A direct FK enables provider directory sync, credentialing status validation at scheduling time, and resolving which clinician a resource record r',
    `equipment_asset_id` BIGINT COMMENT 'Unique asset identifier or serial number for equipment resources. Links to the supply chain domain equipment asset master. Applicable only to equipment resources. Null for non-equipment resources.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Schedulable resources can represent a provider groups shared capacity (e.g., a group practice pool). Group-level resource scheduling drives panel capacity management, group contract utilization, and ',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Schedulable resources representing providers carry an NPI that must resolve to the federal NPI registry for credentialing verification, network participation validation, and CMS regulatory reporting. ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Organizational providers (hospitals, clinics) are schedulable resources for facility-level scheduling (e.g., scheduling a procedure at a specific org). Linking enables facility credentialing validatio',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Schedulable resources are associated with specific clinical services for scheduling eligibility and availability reporting (e.g., a clinician schedulable only for Cardiology service). Service-level re',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Schedulable resources are specialty-typed for patient-to-provider matching, network adequacy reporting, and availability filtering. specialty_code is a denormalized representation of the specialty ent',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Schedulable resources (clinicians, rooms, equipment) are assigned to specific clinical units for scheduling availability and constraint management. Unit-level resource capacity reporting is a core ope',
    `accepts_new_patients` BOOLEAN COMMENT 'Indicates whether the provider resource is currently accepting new patient appointments. True if accepting new patients, False otherwise. Applicable only to provider resources.',
    `allows_overbooking` BOOLEAN COMMENT 'Indicates whether the resource permits overbooking (scheduling more appointments than standard capacity allows). True if overbooking is permitted, False otherwise.',
    `care_setting` STRING COMMENT 'Primary care setting or service delivery environment where the resource operates (e.g., inpatient, outpatient, emergency department, ambulatory surgery center, home health, telehealth).. Valid values are `inpatient|outpatient|emergency|ambulatory_surgery|home_health|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this resource record was first created in the system. Supports audit trail and data lineage.',
    `credentialing_expiration_date` DATE COMMENT 'Date when the providers current credentialing and privileging expires and must be renewed. Applicable only to provider resources.',
    `credentialing_status` STRING COMMENT 'Current status of the providers credentialing and privileging process. Applicable only to provider resources. Active indicates fully credentialed and privileged; pending indicates credentialing in progress; expired, suspended, or revoked indicate loss of privileges.. Valid values are `active|pending|expired|suspended|revoked`',
    `default_slot_duration_minutes` STRING COMMENT 'Standard duration in minutes for a single scheduling slot or appointment block for this resource. Used as the default when creating schedules.',
    `effective_end_date` DATE COMMENT 'Date when the resource was retired or became unavailable for scheduling. Null for currently active resources. Supports historical tracking and temporal queries.',
    `effective_start_date` DATE COMMENT 'Date when the resource became active and available for scheduling. Supports historical tracking and temporal queries.',
    `floor` STRING COMMENT 'Floor number or level within the building where the resource is located. Applicable primarily to room and equipment resources.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this resource record was most recently updated. Supports audit trail and change tracking.',
    `license_number` STRING COMMENT 'State-issued professional license number for provider resources. Applicable only to provider resources. Null for non-provider resources.',
    `license_state` STRING COMMENT 'Two-letter state code where the provider license was issued. Applicable only to provider resources.. Valid values are `^[A-Z]{2}$`',
    `location_code` STRING COMMENT 'Code representing the specific location, building, or campus where the resource is situated. Used for geographic and logistical scheduling.',
    `maintenance_window_end` TIMESTAMP COMMENT 'End date and time of scheduled maintenance or downtime window. Applicable primarily to equipment and room resources.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Start date and time of scheduled maintenance or downtime window during which the resource is unavailable for scheduling. Applicable primarily to equipment and room resources.',
    `minimum_turnover_time_minutes` STRING COMMENT 'Minimum time in minutes required between consecutive appointments or uses of the resource. Includes cleaning, setup, and preparation time. Critical for scheduling optimization and capacity planning.',
    `overbooking_limit` STRING COMMENT 'Maximum number of additional appointments that can be overbooked beyond standard capacity. Applicable only when allows_overbooking is True.',
    `provider_type` STRING COMMENT 'Classification of provider role or credential level (e.g., physician, nurse practitioner, physician assistant, physical therapist, registered nurse). Applicable only to provider resources. Null for non-provider resources.',
    `resource_code` STRING COMMENT 'Unique business identifier or code for the resource. May be an internal system code, asset tag, or room number depending on resource type.',
    `resource_name` STRING COMMENT 'Human-readable name or title of the schedulable resource. For providers, this is the full name; for rooms, the room designation; for equipment, the equipment name or model.',
    `resource_type` STRING COMMENT 'Classification of the schedulable resource: provider (physicians, APPs, therapists), room (exam, OR suite, procedure, imaging, infusion bay), equipment (MRI, CT, C-arm, surgical robot, laser, perfusion pump), or care team.. Valid values are `provider|room|equipment|care_team`',
    `room_capacity` STRING COMMENT 'Maximum number of patients or occupants that can be accommodated in the room simultaneously. Applicable only to room resources. Null for non-room resources.',
    `room_configuration` STRING COMMENT 'Physical configuration or layout of the room (e.g., single-bed, multi-bed, open bay, private suite). Applicable only to room resources.',
    `scheduling_constraints` STRING COMMENT 'Free-text description of any special scheduling rules, restrictions, or constraints that apply to this resource (e.g., only available for specific appointment types, requires advance booking, limited to certain patient populations).',
    `scheduling_status` STRING COMMENT 'Current availability status of the resource for scheduling purposes. Active resources are available for scheduling; inactive resources are temporarily unavailable; maintenance resources are undergoing service; reserved resources are held for specific purposes; retired resources are permanently removed from service.. Valid values are `active|inactive|maintenance|reserved|retired`',
    `sterilization_cycle_required` BOOLEAN COMMENT 'Indicates whether the resource requires a sterilization cycle between uses. True if sterilization is required, False otherwise. Applicable primarily to equipment and room resources used in surgical or procedural settings.',
    `sterilization_duration_minutes` STRING COMMENT 'Duration in minutes required to complete the sterilization cycle for the resource. Applicable only when sterilization_cycle_required is True.',
    `telehealth_enabled` BOOLEAN COMMENT 'Indicates whether the resource supports telehealth or virtual visit appointments. True if telehealth is supported, False otherwise. Applicable primarily to provider resources.',
    CONSTRAINT pk_schedulable_resource PRIMARY KEY(`schedulable_resource_id`)
) COMMENT 'Master catalog of all resources that can be scheduled across care settings: providers (physicians, APPs, therapists), rooms (exam, OR suite, procedure, imaging, infusion bay), equipment (MRI, CT, C-arm, surgical robot, laser, perfusion pump), and care teams. Captures resource type, name, NPI (for providers), location/facility, building/floor/unit (for rooms), room capacity and configuration, specialty, equipment asset ID, maintenance windows, sterilization cycle requirements, minimum turnover time, active/inactive status, and scheduling constraints. SSOT for resource identity within the scheduling domain. Links to workforce domain (provider master), facility domain (location/room master), and supply domain (equipment asset master) via cross-domain FKs.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` (
    `resource_assignment_id` BIGINT COMMENT 'Unique identifier for the resource assignment record. Primary key for the resource assignment entity.',
    `appointment_id` BIGINT COMMENT 'Foreign key reference to the appointment or scheduled event to which this resource is assigned.',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider (physician, surgeon, specialist) assigned to this appointment or case. Populated when resource_type is provider.',
    `credential_id` BIGINT COMMENT 'Foreign key linking to provider.credential. Business justification: Resource assignments require credential verification at time of scheduling. A direct FK to the specific credential verified enables audit trails for Joint Commission compliance, credentialing expirati',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key reference to the specific equipment asset assigned or reserved for this appointment or procedure. Includes surgical instruments, imaging devices, anesthesia machines, and specialized medical equipment.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Resource assignments generate HCPCS-coded charges (e.g., anesthesia time units, DME, facility equipment). charge_code is a denormalized HCPCS value used for claims generation and billing. Linking to h',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: A resource assignment fills a specific open slot — when a provider, room, or equipment is assigned to an appointment, that assignment corresponds to an open slot being consumed. This FK enables slot-l',
    `or_block_id` BIGINT COMMENT 'Foreign key linking to scheduling.or_block. Business justification: Resources (staff, equipment, rooms) can be assigned directly to OR blocks for surgical scheduling. This FK links resource assignments to the OR block they support, enabling block-level staffing analys',
    `privileging_id` BIGINT COMMENT 'Foreign key linking to provider.privileging. Business justification: Resource assignments must verify the assigned clinician holds the required privilege for the procedure. A direct FK to privileging enables real-time privilege validation, FPPE/OPPE compliance tracking',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure-based resource assignments require CPT lookup for equipment requirements, staff role determination, privilege verification, and billing modifier application. Essential for surgical and proce',
    `procedure_event_id` BIGINT COMMENT 'Foreign key reference to the specific procedure or service being performed. Links to the procedure master for clinical and billing context.',
    `room_id` BIGINT COMMENT 'Foreign key reference to the physical room or space assigned for this appointment or procedure. Includes Operating Rooms (OR), exam rooms, treatment rooms, and procedure suites.',
    `substitute_for_resource_assignment_id` BIGINT COMMENT 'Foreign key reference to another resource assignment that this assignment is substituting for. Used when a resource is replaced due to unavailability, conflict, or last-minute changes.',
    `surgical_case_id` BIGINT COMMENT 'Foreign key reference to the surgical case record when the assignment is for an Operating Room (OR) procedure. Null for non-surgical appointments.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Resource assignments (staff, rooms, equipment) must reconcile with actual encounter visits for billing charge capture, utilization analysis, and clinical documentation workflows. Healthcare operations',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the resource assignment concluded. Used to calculate actual duration, resource utilization, and case completion metrics.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the resource assignment began. Captures real-world start time for variance analysis, billing accuracy, and operational performance measurement.',
    `assignment_notes` STRING COMMENT 'Free-text notes or special instructions related to this resource assignment. May include preferences, constraints, special equipment needs, or coordination details.',
    `assignment_priority` STRING COMMENT 'Priority level for this resource assignment. Determines scheduling precedence and resource allocation urgency, especially critical for Operating Room (OR) and Emergency Department (ED) scheduling.. Valid values are `routine|urgent|emergent|elective|stat`',
    `assignment_role` STRING COMMENT 'Specific role or function the resource performs in this appointment or case. Examples include primary surgeon, co-surgeon, anesthesiologist, Certified Registered Nurse Anesthetist (CRNA), scrub technician, circulating nurse, perfusionist, equipment operator, primary care provider. [ENUM-REF-CANDIDATE: primary_surgeon|co_surgeon|assistant_surgeon|anesthesiologist|crna|scrub_tech|circulating_nurse|perfusionist|equipment_operator|primary_provider|consulting_provider|radiologist|pathologist|respiratory_therapist — promote to reference product]',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the resource assignment. Tracks progression from initial request through confirmation, active use, and final release or cancellation. [ENUM-REF-CANDIDATE: requested|confirmed|in_use|completed|released|declined|cancelled|no_show — 8 candidates stripped; promote to reference product]',
    `billable_flag` BOOLEAN COMMENT 'Boolean indicator of whether this resource assignment generates a billable charge. Used to determine which assignments flow to revenue cycle and claims processing.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason for cancellation of this resource assignment. Supports root cause analysis of scheduling disruptions and resource availability issues.',
    `cancelled_datetime` TIMESTAMP COMMENT 'Date and time when this resource assignment was cancelled. Null if the assignment was not cancelled. Used for cancellation rate analysis and resource utilization metrics.',
    `confirmation_datetime` TIMESTAMP COMMENT 'Date and time when the resource confirmed their assignment. Tracks confirmation lead time and supports compliance with staffing notification requirements.',
    `confirmation_status` STRING COMMENT 'Indicates whether the assigned resource has confirmed their availability and commitment to this assignment. Critical for surgical case staffing and high-acuity appointments.. Valid values are `pending|confirmed|declined|tentative|cancelled`',
    `conflict_description` STRING COMMENT 'Free-text description of the nature of the scheduling conflict, if one exists. Provides context for resolution and audit trail of scheduling issues.',
    `conflict_flag` BOOLEAN COMMENT 'Boolean indicator of whether this resource assignment has a scheduling conflict with another assignment or unavailability period. Triggers alerts for scheduling coordinators to resolve double-bookings.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this resource assignment record was first created in the data platform. Audit timestamp for record creation.',
    `credentialing_verification_datetime` TIMESTAMP COMMENT 'Date and time when credentialing verification was completed for this assignment. Documents compliance with pre-assignment credentialing checks.',
    `credentialing_verified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the assigned resources credentials, licenses, and privileges have been verified as current and appropriate for this assignment. Critical for Joint Commission (TJC) compliance and risk management.',
    `duration_minutes` STRING COMMENT 'Planned or actual duration of the resource assignment in minutes. Calculated from start and end times or specified during scheduling for capacity planning.',
    `equipment_asset_tag` STRING COMMENT 'Physical asset tag or serial number of the specific equipment unit assigned. Enables traceability for maintenance, sterilization, and recall management.',
    `equipment_reservation_status` STRING COMMENT 'Current status of equipment reservation for this assignment. Tracks equipment lifecycle from initial reservation through active use and return to inventory.. Valid values are `reserved|allocated|in_use|returned|unavailable`',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance performed on the assigned equipment. Supports compliance with manufacturer and regulatory maintenance schedules.',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this resource assignment record was most recently updated. Audit timestamp for tracking changes to assignment details, status, or metadata.',
    `maintenance_clearance_flag` BOOLEAN COMMENT 'Boolean indicator of whether assigned equipment has passed required maintenance checks and is cleared for clinical use. Ensures equipment safety and regulatory compliance.',
    `no_show_flag` BOOLEAN COMMENT 'Boolean indicator of whether the assigned resource failed to appear for their scheduled assignment. Used for provider and staff attendance tracking and performance management.',
    `primary_assignment_flag` BOOLEAN COMMENT 'Boolean indicator of whether this is the primary resource assignment for the appointment or case. Distinguishes the lead provider or primary room from supporting resources.',
    `requested_datetime` TIMESTAMP COMMENT 'Date and time when this resource assignment was initially requested or created. Supports lead time analysis and scheduling workflow tracking.',
    `resource_type` STRING COMMENT 'Category of resource being assigned. Distinguishes between human resources (providers, staff, care team members) and physical resources (rooms, equipment).. Valid values are `provider|room|equipment|staff|care_team_member|anesthesia_resource`',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the resource assignment is scheduled to conclude. Used for capacity planning and resource turnover scheduling.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the resource assignment begins. Represents when the provider, room, or equipment is scheduled to be engaged for this appointment or procedure.',
    `source_system` STRING COMMENT 'Identifier of the system or module that originated this resource assignment record. Supports data lineage tracking and system-specific business rules.. Valid values are `epic_cadence|epic_optime|cerner_surginet|meditech|manual_entry|interface`',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this resource assignment in the source system. Enables traceability back to the originating Electronic Health Record (EHR) or scheduling system.',
    `sterilization_batch_number` STRING COMMENT 'Batch or lot number from the sterilization process for assigned equipment. Enables traceability in case of sterilization failures or Healthcare-Associated Infection (HAI) investigations.',
    `sterilization_clearance_flag` BOOLEAN COMMENT 'Boolean indicator of whether assigned equipment has passed sterilization and is cleared for use. Critical for infection control and patient safety in surgical and procedural settings.',
    CONSTRAINT pk_resource_assignment PRIMARY KEY(`resource_assignment_id`)
) COMMENT 'Association record linking schedulable resources (providers, rooms, equipment, care team members) to specific appointments, surgical cases, or procedures. Captures assignment role (primary surgeon, co-surgeon, anesthesiologist, CRNA, scrub tech, circulating nurse, perfusionist, room, equipment operator), assignment status (requested, confirmed, in-use, released, declined), start/end time, confirmation flag, credentialing verification status, equipment asset ID, equipment reservation status, maintenance/sterilization clearance, conflict flags, and actual vs. scheduled participation. SSOT for all resource-to-event associations in the scheduling domain — including surgical case team assignments and equipment reservations. Supports multi-resource scheduling, OR team staffing, equipment management, credentialing compliance, and case documentation.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` (
    `waitlist_entry_id` BIGINT COMMENT 'Unique identifier for the waitlist entry record. Primary key.',
    `appointment_id` BIGINT COMMENT 'Identifier for the appointment that was successfully scheduled from this waitlist entry. Null if not yet scheduled. Links to scheduling appointment master data.',
    `authorization_id` BIGINT COMMENT 'Identifier for the prior authorization record if authorization has been obtained. Null if not yet authorized or not required. Links to authorization master data.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Waitlist entries for care coordination visits are linked to active care plans requiring multidisciplinary follow-up. Critical for transitions of care management, readmission prevention, and complex ca',
    `care_site_id` BIGINT COMMENT 'Identifier for the care site or facility requested by the patient. Null if no specific facility preference. Links to facility master data.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Waitlist entries for authorization-required services track authorization status to prioritize patients with approved authorizations for scheduling. Care coordinators proactively obtain authorizations ',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Non-referral clinical orders (procedure orders, imaging orders, infusion orders) can result in waitlist placement when capacity is unavailable. Linking waitlist_entry to the originating clinical_order',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Waitlist management requires verifying the requested service is covered under the patients plan before placement, especially for procedures with coverage restrictions or medical necessity criteria. C',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Waitlist entries exist before an appointment is created and must be triaged and prioritized by the driving diagnosis (e.g., cancer diagnosis gets expedited access). This link enables access-to-care re',
    `eligibility_span_id` BIGINT COMMENT 'Foreign key linking to insurance.eligibility_span. Business justification: Waitlist entries must track the patients eligibility span to monitor coverage expiration — if coverage lapses before the patient is scheduled, the entry must be flagged or removed. This is a standard',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Waitlist entries track plan-specific network restrictions, authorization requirements, and benefit limitations to match patients with appropriate appointment slots and providers when capacity becomes ',
    `insurance_coverage_id` BIGINT COMMENT 'Identifier for the patient insurance coverage to be used for the appointment. Links to insurance coverage master data.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient on the waitlist. Links to the patient master record.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: CMS timely access standards and HRSA access-to-care obligations directly govern waitlist management. Linking waitlist_entry to the specific obligation it must satisfy enables compliance monitoring of ',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Waitlist management prioritizes patients based on payer authorization status and coverage verification. Schedulers check payer requirements before offering appointments from waitlist to ensure authori',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Waitlist management governed by access policies, anti-discrimination rules, priority scoring policies, and SLA requirements. Regulatory and accreditation requirement in healthcare.',
    `clinician_id` BIGINT COMMENT 'Identifier for the specific provider requested by the patient or referring provider. Null if no specific provider preference. Links to provider master data.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Waitlist entries for PA-required services must reference the applicable prior auth rule to initiate authorization before the patient reaches the top of the waitlist. This prevents scheduling delays ca',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Waitlist entries for specialty care are driven by specific clinical problems requiring intervention. Essential for specialty access tracking, care gap management, and prioritization of patients with h',
    `referral_order_id` BIGINT COMMENT 'Identifier for the clinical order that triggered this waitlist entry, if applicable. Null for non-order-based entries. Links to clinical order master data.',
    `appointment_type_id` BIGINT COMMENT 'Identifier for the type of appointment requested by the patient or ordering provider. Links to appointment type master data.',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: A waitlist entry represents a patient waiting for a specific schedulable resource (a particular provider, room type, or equipment). This in-domain FK complements the cross-domain primary_waitlist_clin',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Waitlist entries represent patients waiting for a specific clinical service (e.g., Orthopedics, Neurology). Service-level waitlist reporting, access metrics, and demand forecasting are standard health',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Waitlist management requires knowing which specialty the patient needs to drive provider matching, wait time reporting by specialty, and network adequacy analysis. specialty_required is a denormalized',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Patients on waitlists are often waiting for capacity in a specific clinical unit (e.g., Cardiology unit, Oncology infusion unit). Unit-level waitlist management, bed capacity planning, and access repo',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Waitlist resolution reporting and access-to-care metrics require linking a fulfilled waitlist entry to the resulting visit. Healthcare operations track which visit resolved a waitlist entry for HEDIS ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Waitlist visit reason ICD codes enable clinical prioritization, authorization requirement determination, specialty matching, and quality measure tracking. Critical for access management and care gap c',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization from the payer is required before scheduling the appointment. True if authorization must be obtained.',
    `care_setting` STRING COMMENT 'Type of care setting required for the appointment: outpatient clinic, inpatient admission, emergency department, ambulatory surgery center, telehealth virtual visit, home health visit.. Valid values are `outpatient|inpatient|emergency|ambulatory_surgery|telehealth|home_health`',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this waitlist entry record was first created in the system. Audit timestamp for record creation.',
    `entry_number` STRING COMMENT 'Business-facing unique identifier or tracking number for the waitlist entry, used for patient communication and scheduling team reference.',
    `entry_status` STRING COMMENT 'Current lifecycle status of the waitlist entry: active (awaiting action), offered (appointment offered to patient), accepted (patient accepted offer), expired (entry aged out or SLA missed), removed (manually removed from queue), pending (awaiting information or approval), in_progress (actively being worked by scheduling team), scheduled (appointment successfully scheduled), escalated (escalated due to aging or priority), closed (completed or resolved). [ENUM-REF-CANDIDATE: active|offered|accepted|expired|removed|pending|in_progress|scheduled|escalated|closed — 10 candidates stripped; promote to reference product]',
    `entry_type` STRING COMMENT 'Classification of the waitlist entry indicating the source or nature of the scheduling request: waitlist (patient-initiated or provider-requested appointment waitlist), referral_queue (unscheduled referral awaiting scheduling), order_based (pending order requiring appointment), recall (recall-driven request for follow-up), surgical_request (surgical scheduling request), work_queue (general scheduling department work item).. Valid values are `waitlist|referral_queue|order_based|recall|surgical_request|work_queue`',
    `escalation_datetime` TIMESTAMP COMMENT 'Date and time when the waitlist entry was escalated. Null if never escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this waitlist entry has been escalated due to aging, priority, or SLA breach. True if escalated for management attention.',
    `escalation_reason` STRING COMMENT 'Free-text or coded reason for escalation (e.g., SLA breach, high clinical priority, patient complaint, aging threshold exceeded).',
    `estimated_wait_time_days` STRING COMMENT 'Estimated number of days the patient will wait from queue entry to scheduled appointment, based on current capacity and demand forecasting.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter is required for the appointment. True if interpreter services must be arranged.',
    `language_preference` STRING COMMENT 'Patient preferred language for communication and care delivery. ISO 639-2 three-letter language code (e.g., eng for English, spa for Spanish).',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this waitlist entry record was last updated. Audit timestamp for record modification.',
    `last_outreach_datetime` TIMESTAMP COMMENT 'Date and time of the most recent outreach attempt to the patient. Null if no outreach has been attempted.',
    `last_outreach_method` STRING COMMENT 'Method used for the most recent outreach attempt: phone call, email, SMS text, patient portal message, postal mail.. Valid values are `phone|email|sms|portal|mail`',
    `notes` STRING COMMENT 'Free-text notes and comments from scheduling staff regarding patient preferences, special requirements, barriers to scheduling, or other relevant information.',
    `outreach_attempt_count` STRING COMMENT 'Number of times the scheduling team has attempted to contact the patient to schedule the appointment. Used for tracking patient engagement and no-contact protocols.',
    `preferred_contact_channel` STRING COMMENT 'Patient preferred method of contact for scheduling outreach and appointment notifications: phone, email, SMS text message, patient portal message, postal mail.. Valid values are `phone|email|sms|portal|mail`',
    `preferred_days_of_week` STRING COMMENT 'Patient preference for days of the week for scheduling (e.g., Monday, Wednesday, Friday). Stored as comma-separated list or coded representation.',
    `preferred_time_of_day` STRING COMMENT 'Patient preference for time of day for scheduling: morning (before noon), afternoon (noon to 5pm), evening (after 5pm), any (no preference).. Valid values are `morning|afternoon|evening|any`',
    `priority_level` STRING COMMENT 'Clinical or operational priority assigned to the waitlist entry, determining urgency of scheduling action. Values align with clinical acuity and access standards. [ENUM-REF-CANDIDATE: routine|urgent|emergent|stat|high|medium|low — 7 candidates stripped; promote to reference product]',
    `queue_entry_datetime` TIMESTAMP COMMENT 'Date and time when the patient was added to the waitlist or scheduling queue. Used for aging calculations and first-in-first-out queue management.',
    `removal_datetime` TIMESTAMP COMMENT 'Date and time when the waitlist entry was removed from the queue without scheduling (e.g., patient declined, no longer needed, duplicate entry). Null if not removed.',
    `removal_reason` STRING COMMENT 'Free-text or coded reason for removing the entry from the waitlist without scheduling (e.g., patient declined, no longer clinically indicated, duplicate entry, patient deceased, scheduled elsewhere).',
    `scheduled_datetime` TIMESTAMP COMMENT 'Date and time when the appointment was successfully scheduled and the waitlist entry was resolved. Null if not yet scheduled.',
    `sla_target_datetime` TIMESTAMP COMMENT 'Target date and time by which the scheduling action should be completed per organizational or regulatory service level agreement. Used for compliance monitoring and escalation triggers.',
    `source_system` STRING COMMENT 'Name of the source system or module that created the waitlist entry (e.g., Epic Cadence, Epic OpTime, Cerner Scheduling, referral management system).',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this waitlist entry in the source system. Used for data lineage and reconciliation.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient is eligible and willing to receive care via telehealth modality for this appointment request. True if telehealth is an acceptable option.',
    `transportation_assistance_needed_flag` BOOLEAN COMMENT 'Indicates whether the patient requires transportation assistance to attend the appointment. True if transportation support is needed.',
    `visit_reason` STRING COMMENT 'Free-text description of the clinical reason or chief complaint for the requested appointment.',
    `visit_reason_code` STRING COMMENT 'Coded representation of the visit reason using standard clinical terminology (e.g., SNOMED CT, ICD-10).',
    CONSTRAINT pk_waitlist_entry PRIMARY KEY(`waitlist_entry_id`)
) COMMENT 'Tracks all scheduling work items awaiting action — including patients on scheduling waitlists, unscheduled referrals, pending orders, recall-driven requests, surgical scheduling requests, and scheduling department work queues. Captures entry type (waitlist, referral queue, order-based, recall, surgical request), priority level, requested appointment type, patient scheduling preferences (preferred provider, preferred care site/location, preferred days/times, preferred contact channel, language preference, transportation needs, telehealth eligibility), queue entry datetime, assigned scheduling team, SLA target datetime, estimated wait time, status (active, offered, accepted, expired, removed, pending, in-progress, scheduled, escalated, closed), escalation/aging flags, and outreach attempt history. SSOT for all scheduling queue, waitlist, and patient preference management. Supports patient access optimization, scheduling department workflow, demand management, access SLA compliance, and patient-centered scheduling.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` (
    `surgical_case_team_id` BIGINT COMMENT 'Unique identifier for the surgical case team assignment record. Primary key for this entity.',
    `exclusion_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.exclusion_screening. Business justification: CMS requires OIG/SAM exclusion screening of all surgical team members before federally-funded procedures. This link supports pre-surgical team exclusion verification — a named CMS Conditions of Part',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: Each surgical case team member is a schedulable resource in the scheduling domain (surgeon, anesthesiologist, scrub tech, circulator). This FK links the team member record to the schedulable_resource ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Surgical case team specialty attribution drives OR team composition validation, specialty-based quality metrics, and service line reporting. specialty_code is a denormalized representation of the spec',
    `surgical_case_id` BIGINT COMMENT 'Reference to the surgical case for which this team member is assigned. Links to the surgical_case product.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Surgical case team members must be linked to credentialed clinicians for privileging verification, Joint Commission compliance, and OR team quality reporting. Role-prefixed team_member_clinician_id us',
    `training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: Surgical team members require procedure-specific training verification including scrub technique, equipment operation, and specialty certifications. Joint Commission and medical staff bylaws requireme',
    `actual_end_datetime` TIMESTAMP COMMENT 'The actual date and time when the team member completed their participation in the surgical case. Used for time tracking and billing.',
    `actual_start_datetime` TIMESTAMP COMMENT 'The actual date and time when the team member began their participation in the surgical case. Used for time tracking and billing.',
    `assignment_notes` STRING COMMENT 'Free-text notes regarding this team member assignment. May include special requirements, preferences, or coordination details.',
    `assignment_priority` STRING COMMENT 'Numeric priority ranking of this team member assignment relative to other assignments for the same case. Lower numbers indicate higher priority. Used for scheduling conflict resolution.',
    `assignment_status` STRING COMMENT 'Current status of the team member assignment. Tracks the lifecycle from scheduling through completion or cancellation.. Valid values are `scheduled|confirmed|in_progress|completed|cancelled|no_show`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this team members participation is billable to the patient or payer. True if billable, False if non-billable (e.g., resident supervision, observation).',
    `billing_modifier_code` STRING COMMENT 'CPT or HCPCS modifier code applied to this team members billing for the surgical case. Used to indicate special circumstances (e.g., assistant surgeon, co-surgeon, teaching physician).',
    `board_certification_status` STRING COMMENT 'Current status of the team members board certification in their specialty. Used for quality reporting and credentialing.. Valid values are `certified|not_certified|expired|pending`',
    `call_status` STRING COMMENT 'Indicates whether the team member is scheduled, on-call, backup, or responding to an emergency for this case. Used for staffing and scheduling analytics.. Valid values are `scheduled|on_call|backup|emergency`',
    `cancellation_datetime` TIMESTAMP COMMENT 'The date and time when this team member assignment was cancelled. Null if assignment was not cancelled.',
    `cancellation_reason` STRING COMMENT 'Reason why this team member assignment was cancelled. May include provider unavailability, case cancellation, or scheduling changes.',
    `confirmation_datetime` TIMESTAMP COMMENT 'The date and time when the team member confirmed their participation in the surgical case.',
    `confirmation_status` STRING COMMENT 'Status indicating whether the team member has confirmed their availability and commitment to participate in this surgical case.. Valid values are `pending|confirmed|declined|tentative`',
    `conflict_description` STRING COMMENT 'Detailed description of any scheduling conflict identified for this team member assignment. Includes conflicting case number or appointment details.',
    `conflict_flag` BOOLEAN COMMENT 'Indicates whether this team member assignment has a scheduling conflict with another commitment. True if conflict exists, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this team member assignment record was first created in the system. Used for audit trail and data lineage.',
    `credentialing_verification_datetime` TIMESTAMP COMMENT 'The date and time when the team members credentials and privileges were verified for this surgical case.',
    `credentialing_verified_flag` BOOLEAN COMMENT 'Indicates whether the team members credentials and privileges have been verified for this specific surgical case. True if verified, False if not verified or pending.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this team member assignment record was last modified. Used for audit trail and change tracking.',
    `license_number` STRING COMMENT 'The professional license number of the team member. Required for regulatory compliance and credentialing verification.',
    `license_state` STRING COMMENT 'Two-letter state code where the team members professional license was issued. Must match the facilitys state or have reciprocity agreement.. Valid values are `^[A-Z]{2}$`',
    `participation_duration_minutes` STRING COMMENT 'Total duration in minutes of the team members actual participation in the surgical case. Calculated from actual start and end times.',
    `primary_role_flag` BOOLEAN COMMENT 'Indicates whether this team member holds the primary responsibility for their role category (e.g., primary surgeon vs. assisting surgeon). True if primary, False if secondary or assisting.',
    `primary_surgeon_name` STRING COMMENT 'Full name of the primary surgeon. Used for operational communication, patient information, and surgical schedule displays. [Moved from surgical_case: Denormalized display attribute derived from the primary surgeon relationship. Should be removed as it can be derived from the surgical_case_team association joined to clinician.]',
    `privilege_code` STRING COMMENT 'Code representing the specific clinical privilege that authorizes this team member to perform their role in this surgical case. Links to the providers credentialing and privileging records.',
    `quality_measure_applicable_flag` BOOLEAN COMMENT 'Indicates whether this team member assignment is subject to quality measurement or reporting requirements. True if applicable, False otherwise.',
    `replacement_team_member_npi` STRING COMMENT 'The NPI of the replacement team member if this assignment was substituted. Used to track last-minute staffing changes.. Valid values are `^[0-9]{10}$`',
    `requested_datetime` TIMESTAMP COMMENT 'The date and time when this team member was requested for assignment to the surgical case.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'The date and time when the team member is scheduled to complete their participation in the surgical case.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'The date and time when the team member is scheduled to begin their participation in the surgical case.',
    `scrub_time_minutes` STRING COMMENT 'Time in minutes spent by the team member in surgical scrub preparation. Applicable to scrubbed team members (surgeons, scrub techs).',
    `source_system` STRING COMMENT 'Name of the source system from which this team member assignment record originated (e.g., Epic OpTime, Cerner SurgiNet).',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this team member assignment in the source system. Used for data lineage and reconciliation.',
    `supervising_provider_npi` STRING COMMENT 'The NPI of the attending physician or supervising provider if this team member is a resident, fellow, or student. Required for teaching case billing compliance.. Valid values are `^[0-9]{10}$`',
    `teaching_case_flag` BOOLEAN COMMENT 'Indicates whether this is a teaching case with resident or student participation under supervision. True if teaching case, False otherwise. Impacts billing and documentation requirements.',
    `team_member_name` STRING COMMENT 'Full legal name of the care team member assigned to this surgical case. Used for case documentation and credentialing verification.',
    `team_role_code` STRING COMMENT 'Standardized code representing the role of the team member in the surgical case. Values: SURGEON (primary surgeon), CO_SURGEON (assisting surgeon), ANESTHESIOLOGIST (physician anesthesiologist), CRNA (Certified Registered Nurse Anesthetist), SCRUB_TECH (scrub technician), CIRCULATING_NURSE (circulating nurse). [ENUM-REF-CANDIDATE: SURGEON|CO_SURGEON|ANESTHESIOLOGIST|CRNA|SCRUB_TECH|CIRCULATING_NURSE|PERFUSIONIST|FIRST_ASSIST|SURGICAL_RESIDENT|ANESTHESIA_RESIDENT|STUDENT_NURSE — promote to reference product]. Valid values are `SURGEON|CO_SURGEON|ANESTHESIOLOGIST|CRNA|SCRUB_TECH|CIRCULATING_NURSE`',
    `team_role_description` STRING COMMENT 'Human-readable description of the team members role and responsibilities during the surgical case.',
    `time_in_room_minutes` STRING COMMENT 'Total time in minutes that the team member spent in the operating room for this case. Used for efficiency and utilization analysis.',
    CONSTRAINT pk_surgical_case_team PRIMARY KEY(`surgical_case_team_id`)
) COMMENT 'Association entity capturing the full care team assigned to a surgical case including primary surgeon, co-surgeon, anesthesiologist, CRNA, scrub technician, circulating nurse, and perfusionist. Captures team member role, NPI, assignment status, scheduled vs. actual participation, and case-specific credentialing verification status. Carries rich business data beyond a simple FK — essential for OR staffing, credentialing compliance, and case documentation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ADD CONSTRAINT `fk_scheduling_appointment_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `healthcare_ecm`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_schedule_template_id` FOREIGN KEY (`schedule_template_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedule_template`(`schedule_template_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_or_block_id` FOREIGN KEY (`or_block_id`) REFERENCES `healthcare_ecm`.`scheduling`.`or_block`(`or_block_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `healthcare_ecm`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_or_block_id` FOREIGN KEY (`or_block_id`) REFERENCES `healthcare_ecm`.`scheduling`.`or_block`(`or_block_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_substitute_for_resource_assignment_id` FOREIGN KEY (`substitute_for_resource_assignment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`resource_assignment`(`resource_assignment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment`(`appointment_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `healthcare_ecm`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `healthcare_ecm`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm`.`scheduling` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm`.`scheduling` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Coverage Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `eligibility_check_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Eligibility Verification Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Protocol Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `network_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Affiliation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Arrival Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `billing_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Eligibility Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `booking_channel` SET TAGS ('dbx_value_regex' = 'phone|online-portal|mobile-app|in-person|referral|system-generated');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_value_regex' = 'patient|provider|facility|system');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|declined|needs-action');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appointment End Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not-required|expired');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `insurance_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `patient_device_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Device Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Appointment Priority');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|elective|emergent');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `provider_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Attestation Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `roomed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roomed Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appointment Start Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Access Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Connection Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_value_regex' = 'not-started|connected|disconnected|failed|completed');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session URL (Uniform Resource Locator)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `visit_modality` SET TAGS ('dbx_business_glossary_term' = 'Visit Modality');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `visit_modality` SET TAGS ('dbx_value_regex' = 'in-person|video|phone|e-visit|asynchronous');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `visit_reason` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment` ALTER COLUMN `visit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `allows_self_scheduling` SET TAGS ('dbx_business_glossary_term' = 'Allows Self-Scheduling Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Allows Telehealth Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_category` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Category');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_code` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_description` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Description');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Name');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `billing_class` SET TAGS ('dbx_business_glossary_term' = 'Billing Class');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `billing_class` SET TAGS ('dbx_value_regex' = 'professional|facility|technical|global');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Required in Hours');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|telehealth|home_health|ambulatory_surgery');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `default_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Default Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `maximum_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `minimum_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `no_show_penalty_applies` SET TAGS ('dbx_business_glossary_term' = 'No-Show Penalty Applies Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'new_patient|established_patient|return_patient|referral');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `preparation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Patient Preparation Instructions');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `quality_measure_applicable` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Applicable Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time in Days');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `requires_interpreter` SET TAGS ('dbx_business_glossary_term' = 'Requires Interpreter Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `requires_referral` SET TAGS ('dbx_business_glossary_term' = 'Requires Referral Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `room_type_required` SET TAGS ('dbx_business_glossary_term' = 'Room Type Required');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_malpractice` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Malpractice Component');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_practice_expense` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Practice Expense Component');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Work Component');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `staff_roles_required` SET TAGS ('dbx_business_glossary_term' = 'Staff Roles Required');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `visit_type_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Type Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`appointment_type` ALTER COLUMN `waitlist_eligible` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Eligible Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Template ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Or Suite Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `auto_confirm_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Confirm Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `buffer_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Buffer Time Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `max_slots_per_session` SET TAGS ('dbx_business_glossary_term' = 'Maximum Slots Per Session');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `no_show_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Tracking Enabled Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent|elective');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|rotating|custom');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_rule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Rule');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Reminder Enabled Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time Hours');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `session_end_time` SET TAGS ('dbx_business_glossary_term' = 'Session End Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `session_start_time` SET TAGS ('dbx_business_glossary_term' = 'Session Start Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Duration Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|retired|pending');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `template_type` SET TAGS ('dbx_value_regex' = 'provider|resource|facility|equipment|room|staff');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedule_template` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `appointment_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Eligibility');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Block Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `block_type` SET TAGS ('dbx_value_regex' = 'administrative|personal|maintenance|training|meeting|other');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Slot Comment');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `hold_expiration_datetime` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'available|held|released|expired');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `insurance_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Insurance Eligibility');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_cutoff_hours` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Cutoff Hours');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `overbook_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbook Allowed Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `patient_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Patient Type Eligibility');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `slot_category` SET TAGS ('dbx_business_glossary_term' = 'Slot Category');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `slot_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Slot End Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_business_glossary_term' = 'Slot Business Identifier');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `slot_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Slot Start Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_value_regex' = 'free|busy|busy-unavailable|busy-tentative|entered-in-error');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'epic_cadence|cerner_scheduling|optime|meditech|other');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `healthcare_ecm`.`scheduling`.`open_slot` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` SET TAGS ('dbx_subdomain' = 'surgical_operations');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Implant Vendor Contract Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `malpractice_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Coverage Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `or_block_id` SET TAGS ('dbx_business_glossary_term' = 'Or Block Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Identifier');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Op Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Preop Imaging Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Preop Lab Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Privileging Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Staging Inventory Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `utilization_review_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Review Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `add_on_case_indicator` SET TAGS ('dbx_business_glossary_term' = 'Add-On Case Indicator');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_value_regex' = 'general|regional|local|monitored_anesthesia_care|sedation|none');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `asa_classification` SET TAGS ('dbx_business_glossary_term' = 'American Society of Anesthesiologists (ASA) Physical Status Classification');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `asa_classification` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|VI');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `block_time_indicator` SET TAGS ('dbx_business_glossary_term' = 'Block Time Indicator');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Number');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ambulatory|emergency|trauma|transplant');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `consent_obtained_indicator` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Indicator');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Equipment Requirements');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `implant_required` SET TAGS ('dbx_business_glossary_term' = 'Implant Required Indicator');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Surgical Laterality');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|same_day_surgery|extended_recovery');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Post-Operative Diagnosis');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_business_glossary_term' = 'Requires Blood Products Indicator');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `requires_icu_bed` SET TAGS ('dbx_business_glossary_term' = 'Requires Intensive Care Unit (ICU) Bed Indicator');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Surgery Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `site_marked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Surgical Site Marked Indicator');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `timeout_completed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Surgical Timeout Completed Indicator');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Case Urgency Level');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|trauma');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` SET TAGS ('dbx_subdomain' = 'surgical_operations');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `or_block_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Block ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Surgeon ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Suite ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Service ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Inventory Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Target Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `allows_overbooking` SET TAGS ('dbx_business_glossary_term' = 'Allows Overbooking Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `allows_sharing` SET TAGS ('dbx_business_glossary_term' = 'Allows Sharing Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `anesthesia_type_required` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type Required');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Block Duration Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_end_time` SET TAGS ('dbx_business_glossary_term' = 'Block End Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Block Name');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_number` SET TAGS ('dbx_business_glossary_term' = 'Block Number');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_owner_type` SET TAGS ('dbx_value_regex' = 'service|surgeon|specialty|department|open');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_start_time` SET TAGS ('dbx_business_glossary_term' = 'Block Start Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Block Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|expired|pending');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `block_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|open|flex|call');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `equipment_set_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Set Required');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `minimum_utilization_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Utilization Threshold Percentage');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `recurring_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurring Pattern');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `release_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Release Lead Time Days');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `release_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Release Lead Time Hours');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `release_rule_type` SET TAGS ('dbx_business_glossary_term' = 'Release Rule Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `release_rule_type` SET TAGS ('dbx_value_regex' = 'days_before|hours_before|no_release|manual');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `staff_roles_required` SET TAGS ('dbx_business_glossary_term' = 'Staff Roles Required');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`or_block` ALTER COLUMN `target_utilization_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Utilization Threshold Percentage');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` SET TAGS ('dbx_subdomain' = 'resource_planning');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `allows_overbooking` SET TAGS ('dbx_business_glossary_term' = 'Allows Overbooking Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|ambulatory_surgery|home_health|telehealth');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|revoked');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `default_slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Default Slot Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `floor` SET TAGS ('dbx_business_glossary_term' = 'Floor Number or Level');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Professional License Number');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_end` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `minimum_turnover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Turnover Time in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Name');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'provider|room|equipment|care_team');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_business_glossary_term' = 'Room Capacity');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_configuration` SET TAGS ('dbx_business_glossary_term' = 'Room Configuration Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_constraints` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Constraints');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|reserved|retired');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_cycle_required` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Cycle Required Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` SET TAGS ('dbx_subdomain' = 'resource_planning');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Assignment Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `or_block_id` SET TAGS ('dbx_business_glossary_term' = 'Or Block Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Privileging Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `substitute_for_resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute For Resource Assignment Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent|elective|stat');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|declined|tentative|cancelled');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `credentialing_verification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verification Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `credentialing_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verified Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Tag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Reservation Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_reservation_status` SET TAGS ('dbx_value_regex' = 'reserved|allocated|in_use|returned|unavailable');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `maintenance_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Clearance Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `primary_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `requested_datetime` SET TAGS ('dbx_business_glossary_term' = 'Requested Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'provider|room|equipment|staff|care_team_member|anesthesia_resource');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'epic_cadence|epic_optime|cerner_surginet|meditech|manual_entry|interface');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `sterilization_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Batch Number');
ALTER TABLE `healthcare_ecm`.`scheduling`.`resource_assignment` ALTER COLUMN `sterilization_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Clearance Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `waitlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Appointment Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Facility Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Provider Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Order Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Appointment Type Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|ambulatory_surgery|telehealth|home_health');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Number');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Type');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'waitlist|referral_queue|order_based|recall|surgical_request|work_queue');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `estimated_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Wait Time in Days');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Method');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('dbx_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Notes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `outreach_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Preferred Days of Week');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_business_glossary_term' = 'Preferred Time of Day');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|any');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `queue_entry_datetime` SET TAGS ('dbx_business_glossary_term' = 'Queue Entry Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_datetime` SET TAGS ('dbx_business_glossary_term' = 'Removal Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `scheduled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `sla_target_datetime` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date and Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `transportation_assistance_needed_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Assistance Needed Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` SET TAGS ('dbx_subdomain' = 'surgical_operations');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `surgical_case_team_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Team ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `exclusion_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Screening Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case ID');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Team Member Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority Rank');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|in_progress|completed|cancelled|no_show');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `billing_modifier_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Modifier Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|expired|pending');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `call_status` SET TAGS ('dbx_business_glossary_term' = 'Call Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `call_status` SET TAGS ('dbx_value_regex' = 'scheduled|on_call|backup|emergency');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `confirmation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|declined|tentative');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Conflict Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `credentialing_verification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verification Date Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `credentialing_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verified Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Professional License Number');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `participation_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Participation Duration Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Role Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `primary_surgeon_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Surgeon Name');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `privilege_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `quality_measure_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Applicable Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('dbx_business_glossary_term' = 'Replacement Team Member National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `replacement_team_member_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `requested_datetime` SET TAGS ('dbx_business_glossary_term' = 'Requested Date Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date Time');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `scrub_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Scrub Time Minutes');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Supervising Provider National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `supervising_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `teaching_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Teaching Case Flag');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('dbx_business_glossary_term' = 'Team Member Full Name');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_member_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_role_code` SET TAGS ('dbx_business_glossary_term' = 'Team Role Code');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_role_code` SET TAGS ('dbx_value_regex' = 'SURGEON|CO_SURGEON|ANESTHESIOLOGIST|CRNA|SCRUB_TECH|CIRCULATING_NURSE');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `team_role_description` SET TAGS ('dbx_business_glossary_term' = 'Team Role Description');
ALTER TABLE `healthcare_ecm`.`scheduling`.`surgical_case_team` ALTER COLUMN `time_in_room_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time In Operating Room (OR) Minutes');
