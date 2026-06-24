-- Schema for Domain: scheduling | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`scheduling` COMMENT 'Appointment and resource scheduling across all care settings. Includes outpatient appointments (Epic Cadence), surgical scheduling (OpTime), procedure scheduling, resource allocation (rooms, equipment, staff), waitlist management, appointment reminders, no-show tracking, and capacity planning. Supports patient access and operational throughput optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` (
    `appointment_type_id` BIGINT COMMENT 'Primary key',
    `cdm_entry_id` BIGINT COMMENT 'FK to CDM entry',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Appointment types for DME, home health, and certain preventive services are billed via HCPCS codes rather than CPT. The existing `billing_class` attribute signals this need. Payers require HCPCS class',
    `set_id` BIGINT COMMENT 'Foreign key linking to order.set. Business justification: Appointment types trigger associated order sets at scheduling (e.g., pre-op appointment type auto-populates a pre-op order set). This is a standard EHR clinical decision support workflow — scheduling ',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.form_template. Business justification: Healthcare operations require specific consent form templates per appointment type (e.g., surgical consult, research visit, procedure). This link drives automated consent workflow triggering at schedu',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Appointment types are specialty-specific (cardiology follow-up vs. orthopedic consult). Linking to provider.specialty enables specialty-based scheduling rule enforcement, payer prior authorization req',
    `allows_self_scheduling` BOOLEAN COMMENT 'Allows self-scheduling flag',
    `allows_telehealth` BOOLEAN COMMENT 'Allows telehealth flag',
    `appointment_type_status` STRING COMMENT 'Status. Valid values are `active|inactive|suspended|retired`',
    `billing_class` STRING COMMENT 'Billing class. Valid values are `professional|facility|technical|global`',
    `cancellation_notice_hours` STRING COMMENT 'Cancellation notice hours',
    `care_setting` STRING COMMENT 'Care setting. Valid values are `outpatient|inpatient|emergency|telehealth|home_health|ambulatory_surgery`',
    `appointment_type_category` STRING COMMENT 'Appointment type category',
    `appointment_type_code` STRING COMMENT 'Appointment type code. Valid values are `^[A-Z0-9_]{2,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `default_duration_minutes` STRING COMMENT 'Default duration',
    `appointment_type_description` STRING COMMENT 'Description',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `equipment_required` STRING COMMENT 'Equipment required',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `maximum_duration_minutes` STRING COMMENT 'Maximum duration',
    `minimum_duration_minutes` STRING COMMENT 'Minimum duration',
    `appointment_type_name` STRING COMMENT 'Name',
    `no_show_penalty_applies` BOOLEAN COMMENT 'No-show penalty applies',
    `patient_class` STRING COMMENT 'Patient class. Valid values are `new_patient|established_patient|return_patient|referral`',
    `preparation_instructions` STRING COMMENT 'Preparation instructions',
    `quality_measure_applicable` BOOLEAN COMMENT 'Quality measure applicable',
    `reminder_lead_time_days` STRING COMMENT 'Reminder lead time days',
    `requires_interpreter` BOOLEAN COMMENT 'Requires interpreter',
    `requires_referral` BOOLEAN COMMENT 'Requires referral',
    `room_type_required` STRING COMMENT 'Room type required',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'RVU malpractice',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'RVU practice expense',
    `rvu_work` DECIMAL(18,2) COMMENT 'RVU work',
    `staff_roles_required` STRING COMMENT 'Staff roles required',
    `vibe_placeholder` STRING COMMENT '',
    `visit_type_code` STRING COMMENT 'Visit type code',
    `waitlist_eligible` BOOLEAN COMMENT 'Waitlist eligible',
    CONSTRAINT pk_appointment_type PRIMARY KEY(`appointment_type_id`)
) COMMENT 'Reference catalog of all appointment types defined across care settings (e.g., new patient visit, follow-up, annual wellness, pre-op, post-op, telehealth, urgent care). Includes CPT/visit type code mapping, default duration, care setting applicability, specialty association, and scheduling rules. Drives appointment booking logic and capacity planning in Epic Cadence and Cerner Millennium.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` (
    `schedule_template_id` BIGINT COMMENT 'Primary key for schedule_template',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: schedule_template.appointment_type_code is a denormalized string referencing the appointment_type catalog. Adding a proper FK appointment_type_id normalizes this relationship — a schedule template is ',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Schedule templates are built for specific clinicians availability patterns. Credentialing-aware scheduling requires linking templates to clinician records for license/credentialing status validation ',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Schedule templates are built per provider and carry `provider_npi` as a plain denormalized attribute. Linking to npi_registry enables NPI validation at template creation, supports provider credentiali',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.form_template. Business justification: Schedule templates for research protocols, surgical blocks, or specialized clinics require a designated consent form template to be presented when slots are opened. This enables automated consent pack',
    `schedulable_resource_id` BIGINT COMMENT 'Identifier for the resource (room, equipment, facility) to which this template applies. Null if template applies to a provider.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Schedule templates are specialty-specific (e.g., cardiology vs. primary care session rules). Linking to provider.specialty enables specialty-based scheduling rule enforcement, HEDIS measure applicabil',
    `approval_status` STRING COMMENT 'Approval status of the schedule template. Templates may require administrative or clinical approval before becoming active.. Valid values are `pending|approved|rejected|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule template was approved. Null if not yet approved or approval is not required.',
    `auto_confirm_flag` BOOLEAN COMMENT 'Indicates whether appointments scheduled under this template are automatically confirmed or require manual confirmation. True auto-confirms; False requires manual review.',
    `buffer_time_minutes` STRING COMMENT 'Buffer time in minutes added between consecutive appointment slots to allow for provider preparation, documentation, or patient transition.',
    `cancellation_policy_code` STRING COMMENT 'Code identifying the cancellation policy applicable to appointments scheduled under this template (e.g., 24_HOUR, 48_HOUR, NO_SHOW_FEE).',
    `care_setting` STRING COMMENT 'The care delivery setting where this schedule template is used (outpatient clinic, surgical suite, emergency department, telehealth, etc.).. Valid values are `outpatient|inpatient|emergency|surgical|telehealth|home_health`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
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
    `source_system_code` STRING COMMENT 'Unique identifier for this schedule template in the source system. Used for data lineage and reconciliation.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether this schedule template supports telehealth/virtual appointments. True enables telehealth; False restricts to in-person only.',
    `template_name` STRING COMMENT 'Business-friendly name for the schedule template (e.g., Dr. Smith Monday Clinic, OR 3 Weekday Block).',
    `template_status` STRING COMMENT 'Current lifecycle status of the schedule template. Active templates are used for slot generation; inactive/retired templates are historical.. Valid values are `active|inactive|draft|suspended|retired|pending`',
    `template_type` STRING COMMENT 'Classification of the schedule template indicating whether it applies to a provider, resource, facility, equipment, room, or staff member.. Valid values are `provider|resource|facility|equipment|room|staff`',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_placeholder` STRING COMMENT '',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Indicates whether a waitlist is maintained for this schedule template when all slots are filled. True enables waitlist management; False does not.',
    CONSTRAINT pk_schedule_template PRIMARY KEY(`schedule_template_id`)
) COMMENT 'Provider and resource schedule templates defining recurring availability patterns (daily, weekly, rotating) plus real-time availability exceptions, overrides, and leave records. For templates: captures template name, effective date range, applicable provider or resource, time block definitions, appointment type slots, session duration, and recurrence rules. For availability exceptions: captures provider NPI, exception type (vacation, CME, administrative, on-call, blocked, emergency override), start/end datetime, care setting, reason for unavailability, and approval status. SSOT for all provider/resource availability — both the recurring blueprint and its real-time modifications. Aligns with HL7 FHIR Schedule resource. Used by Epic Cadence and OpTime to generate open scheduling slots.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` (
    `open_slot_id` BIGINT COMMENT 'Primary key for open_slot',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: open_slot.appointment_type_eligibility is a denormalized STRING field describing which appointment types can be booked into this slot. Replacing it with a proper FK appointment_type_id to appointment_',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider (physician, nurse practitioner, therapist) assigned to this slot. Links to the provider master data product. Used for provider-specific appointment booking.',
    `provider_availability_id` BIGINT COMMENT 'Foreign key linking to scheduling.provider_availability. Business justification: open_slot slots are generated within provider availability windows. Linking open_slot to provider_availability via provider_availability_id establishes the traceability chain: availability window → op',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: open_slot is generated from a schedule_template which belongs to a schedulable_resource, but open_slot has no direct FK to schedulable_resource. Adding schedulable_resource_id to open_slot enables dir',
    `schedule_template_id` BIGINT COMMENT 'Reference to the parent schedule template from which this slot was generated. Links to the schedule data product that defines recurring availability patterns for providers, rooms, or equipment.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Open slots are specialty-specific for patient-to-slot matching and network adequacy reporting. Linking to provider.specialty replaces the denormalized specialty string and enables payer network adequa',
    `block_reason` STRING COMMENT 'Free-text explanation for why the slot is blocked or unavailable. Examples include provider time off, equipment maintenance, facility closure, administrative time. Null if slot is available for booking.',
    `block_type` STRING COMMENT 'Categorization of the reason the slot is blocked. Used for reporting on non-clinical time utilization and capacity planning. Null if slot is not blocked.. Valid values are `administrative|personal|maintenance|training|meeting|other`',
    `care_setting` STRING COMMENT 'The care delivery environment where the slot is available. Distinguishes between outpatient clinics, inpatient units, emergency department (ED), operating room (OR), telehealth, and home health settings.. Valid values are `outpatient|inpatient|emergency|surgical|telehealth|home_health`',
    `comment` STRING COMMENT 'Free-text notes or special instructions associated with the slot. May include preparation requirements, patient instructions, or scheduling coordinator notes. Visible to scheduling staff and potentially to patients.',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when this slot record was first created in the scheduling system. Used for audit trail and slot generation tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
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
    `source_system_identifier` STRING COMMENT 'The unique identifier for this slot in the source operational system. Used for data lineage, reconciliation, and bidirectional synchronization between lakehouse and operational systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_placeholder` STRING COMMENT '',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Indicates whether patients can be added to a waitlist for this slot if it is fully booked. True enables waitlist management for high-demand slots. Used for cancellation backfill and access optimization.',
    CONSTRAINT pk_open_slot PRIMARY KEY(`open_slot_id`)
) COMMENT 'Individual available scheduling slots generated from schedule templates for providers, rooms, and equipment. Captures slot date/time, duration, slot type, care setting, resource assignment, appointment type eligibility, hold status, and remaining capacity. Represents the real-time inventory of bookable time — aligns with HL7 FHIR Slot resource. Consumed by appointment booking workflows, patient self-scheduling (Epic MyChart), and patient access teams in Epic Cadence and Cerner scheduling.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` (
    `surgical_case_id` BIGINT COMMENT 'Primary key for surgical_case',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: surgical_case.case_type is a STRING field that categorizes the surgical case (e.g., elective, urgent, emergent). appointment_type is the scheduling domains reference catalog for all appointment types',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: OR block scheduling assigns surgical time to specific providers identified by NPI (`block_owner_npi` is a plain denormalized attr). Linking to npi_registry supports OR block utilization reporting, cre',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Surgical interventions are frequently a defined step within an oncology, orthopedic, or cardiac care plan. Linking surgical_case to care_plan enables surgical care coordination reporting, care plan mi',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Surgical procedures routinely require prior authorization. Case coordinators verify authorization approval, approved CPT codes, and unit limits before scheduling OR time. Authorization status is a gat',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Surgical cases originate from surgical orders placed by surgeons. OR scheduling requires linking cases to originating orders for authorization verification, clinical indication tracking, and regulator',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: DRG assignment at case scheduling enables reimbursement forecasting, case costing, length-of-stay estimation, and OR block value analysis. Essential for surgical service line financial planning.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Surgical cases need plan-specific benefit verification for inpatient vs outpatient coverage, copays, deductibles, and network requirements. Surgery schedulers verify plan benefits to estimate patient ',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Every surgical case belongs to a specific patient. Surgical scheduling, pre-op workflows, consent tracking, and post-op documentation all require patient identity resolution via MPI. The existing `mrn',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: A surgical case occupies a specific OR block slot in the scheduling system. surgical_case has scheduled_date, scheduled_start_time, scheduled_end_time as denormalized time fields, but no FK to the ope',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Surgical cases occur at a specific facility. Linking to org_provider enables facility-level surgical volume reporting, CMS certification compliance, accreditation body reporting (Joint Commission), an',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Surgical cases require payer-specific pre-certification, utilization review, and authorization before OR booking. Surgery schedulers verify payer requirements, timely filing limits, and authorization ',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Pre-operative diagnosis ICD code required for surgical authorization, medical necessity validation, DRG assignment, and clinical documentation. Essential for case scheduling approval and compliance.',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Pre-operative lab orders (type & screen, CBC, coagulation studies) are mandatory surgical workflow requirements. Critical for surgical clearance protocols, anesthesia safety, and tracking completion o',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Primary procedure CPT lookup required for OR block allocation, case costing, anesthesia base unit calculation, equipment requirements, and surgical billing. Critical for perioperative scheduling and r',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Primary surgeon assignment is a core OR scheduling requirement. Direct FK to clinician enables surgical privileging verification, surgeon-level OR utilization reporting, malpractice coverage validatio',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Surgical scheduling requires knowing the applicable PA rule to determine documentation requirements, turnaround times, and auto-approval criteria before case scheduling. surgical_case has claim_prior_',
    `privileging_id` BIGINT COMMENT 'Foreign key linking to provider.privileging. Business justification: Surgical case scheduling requires verification of procedure-specific clinical privileges per Joint Commission MS standards. Links case to exact privilege record covering the CPT code, ensuring surgeon',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Surgical cases require procedure-specific treatment consent. OR staff verify consent matches scheduled procedure code and laterality. Critical for surgical timeout protocol, prevents wrong-site/wrong-',
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
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `equipment_requirements` STRING COMMENT 'Special equipment or instrumentation required for the surgical case. Free-text or structured list of equipment codes. Used for equipment scheduling and availability verification.',
    `estimated_duration_minutes` STRING COMMENT 'Estimated length of the surgical procedure in minutes. Based on historical averages for the procedure type, surgeon, and patient complexity. Used for block time allocation and scheduling optimization.',
    `implant_required` BOOLEAN COMMENT 'Indicates whether the surgical case requires implantable devices or hardware. Triggers supply chain coordination and implant tracking requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the surgical case record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `laterality` STRING COMMENT 'Anatomical side on which the procedure is performed. Critical for surgical site verification and wrong-site surgery prevention. Part of the Universal Protocol.. Valid values are `left|right|bilateral|not_applicable`',
    `patient_class` STRING COMMENT 'Patient classification for the surgical encounter. Determines billing rules, bed assignment requirements, and post-operative care pathways.. Valid values are `inpatient|outpatient|observation|same_day_surgery|extended_recovery`',
    `post_op_diagnosis` STRING COMMENT 'Final clinical diagnosis documented after the surgical procedure. May differ from pre-operative diagnosis based on intra-operative findings. Used for billing and clinical documentation.',
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Surgical cases mandate informed consent verification. OR teams check consent status on pre-operative checklists before case start. Required for Joint Commission compliance, CMS conditions of participa',
    `requires_blood_products` BOOLEAN COMMENT 'Indicates whether the surgical case requires blood products to be available. Triggers blood bank coordination and type-and-screen orders.',
    `requires_icu_bed` BOOLEAN COMMENT 'Indicates whether the patient will require an ICU bed post-operatively. Used for bed management and capacity planning coordination between OR and ICU.',
    `scheduled_date` DATE COMMENT 'Date on which the surgical procedure is scheduled to occur. Used for day-level capacity planning and patient preparation scheduling.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Anticipated date and time when the surgical case is expected to conclude. Calculated from scheduled start time plus estimated duration. Used for downstream resource planning.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise date and time when the surgical case is scheduled to begin. Used for minute-level OR scheduling, staff coordination, and patient arrival instructions.',
    `service_line` STRING COMMENT 'Clinical service line or specialty department responsible for the surgical case (e.g., Orthopedics, Cardiothoracic, General Surgery, Neurosurgery). Used for departmental reporting and resource allocation.',
    `site_marked_indicator` BOOLEAN COMMENT 'Indicates whether the surgical site has been marked by the surgeon. Required by the Universal Protocol for procedures involving laterality or multiple structures. Used for pre-operative safety checklist.',
    `specialty` STRING COMMENT 'Medical specialty of the primary surgeon or the procedure type. More granular than service line. Used for surgeon credentialing and case mix analysis.',
    `timeout_completed_indicator` BOOLEAN COMMENT 'Indicates whether the surgical team completed the mandatory pre-incision timeout. Timeout verifies patient identity, procedure, site, and team readiness. Required by The Joint Commission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `urgency_level` STRING COMMENT 'Clinical urgency classification of the surgical case. Determines scheduling priority and resource allocation. Emergent cases may displace elective cases.. Valid values are `elective|urgent|emergent|trauma`',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_surgical_case PRIMARY KEY(`surgical_case_id`)
) COMMENT 'Master record for every scheduled surgical or procedural case managed through OpTime or Cerner SurgiNet. Captures case type, procedure codes (CPT/ICD-10-PCS), scheduled OR suite, primary surgeon, anesthesia type, estimated duration, case status (requested, scheduled, in-progress, completed, cancelled), ASA classification, and block time utilization. SSOT for surgical scheduling distinct from outpatient appointments.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` (
    `schedulable_resource_id` BIGINT COMMENT 'Primary key for schedulable_resource',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: When a schedulable resource represents a clinician, linking to provider.clinician enables real-time credentialing and license status checks during scheduling, provider directory accuracy, and prevents',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Schedulable resources representing providers must be validated against the federal NPI registry for credentialing, billing, and CMS compliance. The plain `npi` column is a denormalization of npi_regis',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Schedulable resources (rooms, equipment, staff) belong to a specific facility. Linking to org_provider enables facility-level resource utilization reporting, accreditation body audits of resource avai',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Resources are often specialty-dedicated (cardiac cath lab, orthopedic OR). Linking to provider.specialty enables specialty-based resource allocation optimization, network adequacy reporting by special',
    `accepts_new_patients` BOOLEAN COMMENT 'Indicates whether the provider resource is currently accepting new patient appointments. True if accepting new patients, False otherwise. Applicable only to provider resources.',
    `allows_overbooking` BOOLEAN COMMENT 'Indicates whether the resource permits overbooking (scheduling more appointments than standard capacity allows). True if overbooking is permitted, False otherwise.',
    `building` STRING COMMENT 'Building name or number within the facility where the resource is located. Applicable primarily to room and equipment resources.',
    `care_setting` STRING COMMENT 'Primary care setting or service delivery environment where the resource operates (e.g., inpatient, outpatient, emergency department, ambulatory surgery center, home health, telehealth).. Valid values are `inpatient|outpatient|emergency|ambulatory_surgery|home_health|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
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
    `unit` STRING COMMENT 'Unit, wing, or zone designation within the floor where the resource is located. Applicable primarily to room and equipment resources.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_schedulable_resource PRIMARY KEY(`schedulable_resource_id`)
) COMMENT 'Master catalog of all resources that can be scheduled across care settings: providers (physicians, APPs, therapists), rooms (exam, OR suite, procedure, imaging, infusion bay), equipment (MRI, CT, C-arm, surgical robot, laser, perfusion pump), and care teams. Captures resource type, name, NPI (for providers), location/facility, building/floor/unit (for rooms), room capacity and configuration, specialty, equipment asset ID, maintenance windows, sterilization cycle requirements, minimum turnover time, active/inactive status, and scheduling constraints. SSOT for resource identity within the scheduling domain. Links to workforce domain (provider master), facility domain (location/room master), and supply domain (equipment asset master) via cross-domain FKs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` (
    `resource_assignment_id` BIGINT COMMENT 'Primary key for resource_assignment',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider (physician, surgeon, specialist) assigned to this appointment or case. Populated when resource_type is provider.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Equipment and supply resource assignments (surgical instruments, implants, DME) are billed via HCPCS codes for charge capture. The plain `charge_code` attribute is a denormalized HCPCS reference. Repl',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: resource_assignment links resources to surgical cases and visits, but for outpatient and non-surgical assignments, there is no link to the specific open_slot being consumed. Adding open_slot_id to res',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedure-based resource assignments require CPT lookup for equipment requirements, staff role determination, privilege verification, and billing modifier application. Essential for surgical and proce',
    `procedure_event_id` BIGINT COMMENT 'Foreign key reference to the specific procedure or service being performed. Links to the procedure master for clinical and billing context.',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: resource_assignment is the core association record linking resources to surgical cases and visits, but it has no FK to schedulable_resource — the master catalog of all schedulable resources. resource_',
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
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
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
    `privilege_code` STRING COMMENT 'Code representing the specific clinical privilege or authorization required and verified for this assignment. Links to the providers credentialed privileges for the procedure or service type.',
    `requested_datetime` TIMESTAMP COMMENT 'Date and time when this resource assignment was initially requested or created. Supports lead time analysis and scheduling workflow tracking.',
    `resource_type` STRING COMMENT 'Category of resource being assigned. Distinguishes between human resources (providers, staff, care team members) and physical resources (rooms, equipment).. Valid values are `provider|room|equipment|staff|care_team_member|anesthesia_resource`',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the resource assignment is scheduled to conclude. Used for capacity planning and resource turnover scheduling.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the resource assignment begins. Represents when the provider, room, or equipment is scheduled to be engaged for this appointment or procedure.',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this resource assignment in the source system. Enables traceability back to the originating Electronic Health Record (EHR) or scheduling system.',
    `sterilization_batch_number` STRING COMMENT 'Batch or lot number from the sterilization process for assigned equipment. Enables traceability in case of sterilization failures or Healthcare-Associated Infection (HAI) investigations.',
    `sterilization_clearance_flag` BOOLEAN COMMENT 'Boolean indicator of whether assigned equipment has passed sterilization and is cleared for use. Critical for infection control and patient safety in surgical and procedural settings.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_resource_assignment PRIMARY KEY(`resource_assignment_id`)
) COMMENT 'Association record linking schedulable resources (providers, rooms, equipment, care team members) to specific appointments, surgical cases, or procedures. Captures assignment role (primary surgeon, co-surgeon, anesthesiologist, CRNA, scrub tech, circulating nurse, perfusionist, room, equipment operator), assignment status (requested, confirmed, in-use, released, declined), start/end time, confirmation flag, credentialing verification status, equipment asset ID, equipment reservation status, maintenance/sterilization clearance, conflict flags, and actual vs. scheduled participation. SSOT for all resource-to-event associations in the scheduling domain — including surgical case team assignments and equipment reservations. Supports multi-resource scheduling, OR team staffing, equipment management, credentialing compliance, and case documentation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` (
    `waitlist_entry_id` BIGINT COMMENT 'Primary key for waitlist_entry',
    `authorization_id` BIGINT COMMENT 'Identifier for the prior authorization record if authorization has been obtained. Null if not yet authorized or not required. Links to authorization master data.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Waitlist entries for care coordination visits are linked to active care plans requiring multidisciplinary follow-up. Critical for transitions of care management, readmission prevention, and complex ca',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Waitlist entries for authorization-required services track authorization status to prioritize patients with approved authorizations for scheduling. Care coordinators proactively obtain authorizations ',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Waitlist entries for specialty referrals (oncology, orthopedics, cardiology) are driven by a specific clinical diagnosis. Linking to the diagnosis record enables referral-to-specialty waitlist managem',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Waitlist management requires real-time eligibility verification to prioritize patients with active coverage before offering open slots. Scheduling staff run eligibility checks on waitlisted patients; ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Waitlist entries track plan-specific network restrictions, authorization requirements, and benefit limitations to match patients with appropriate appointment slots and providers when capacity becomes ',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Care coordinators must trace which encounter visit triggered a waitlist placement (e.g., ED visit generating specialist waitlist) for care transition compliance and HRRP root-cause analysis. Role pref',
    `insurance_coverage_id` BIGINT COMMENT 'Identifier for the patient insurance coverage to be used for the appointment. Links to insurance coverage master data.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient on the waitlist. Links to the patient master record.',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: When a patient on the waitlist is successfully scheduled, the waitlist_entry should link to the open_slot that was booked. waitlist_entry.scheduled_datetime captures the scheduled time but has no FK t',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Waitlist management prioritizes patients based on payer authorization status and coverage verification. Schedulers check payer requirements before offering appointments from waitlist to ensure authori',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: waitlist_entry.specialty_required is a STRING capturing the required specialty, but there is no FK to the preferred provider or resource. Adding preferred_schedulable_resource_id to waitlist_entry ide',
    `clinician_id` BIGINT COMMENT 'Identifier for the specific provider requested by the patient or referring provider. Null if no specific provider preference. Links to provider master data.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: Care coordinators managing waitlists must know which PA rules apply to prepare documentation before a slot opens. waitlist_entry has authorization_required_flag and claim_prior_authorization_id (claim',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Waitlist entries for specialty care are driven by specific clinical problems requiring intervention. Essential for specialty access tracking, care gap management, and prioritization of patients with h',
    `referral_order_id` BIGINT COMMENT 'Identifier for the clinical order that triggered this waitlist entry, if applicable. Null for non-order-based entries. Links to clinical order master data.',
    `appointment_type_id` BIGINT COMMENT 'Identifier for the type of appointment requested by the patient or ordering provider. Links to appointment type master data.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Waitlist entries are specialty-specific — patients wait for a particular specialty. Linking to provider.specialty enables specialty-level waitlist analytics, network adequacy gap identification, and C',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Waitlist visit reason ICD codes enable clinical prioritization, authorization requirement determination, specialty matching, and quality measure tracking. Critical for access management and care gap c',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization from the payer is required before scheduling the appointment. True if authorization must be obtained.',
    `care_setting` STRING COMMENT 'Type of care setting required for the appointment: outpatient clinic, inpatient admission, emergency department, ambulatory surgery center, telehealth virtual visit, home health visit.. Valid values are `outpatient|inpatient|emergency|ambulatory_surgery|telehealth|home_health`',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this waitlist entry record was first created in the system. Audit timestamp for record creation.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
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
    `record_number` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Waitlist entries track consent status for procedure readiness. Scheduling teams verify required consents obtained before converting waitlist to scheduled appointment. Prevents delays, ensures regulato',
    `removal_datetime` TIMESTAMP COMMENT 'Date and time when the waitlist entry was removed from the queue without scheduling (e.g., patient declined, no longer needed, duplicate entry). Null if not removed.',
    `removal_reason` STRING COMMENT 'Free-text or coded reason for removing the entry from the waitlist without scheduling (e.g., patient declined, no longer clinically indicated, duplicate entry, patient deceased, scheduled elsewhere).',
    `scheduled_datetime` TIMESTAMP COMMENT 'Date and time when the appointment was successfully scheduled and the waitlist entry was resolved. Null if not yet scheduled.',
    `sla_target_datetime` TIMESTAMP COMMENT 'Target date and time by which the scheduling action should be completed per organizational or regulatory service level agreement. Used for compliance monitoring and escalation triggers.',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this waitlist entry in the source system. Used for data lineage and reconciliation.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient is eligible and willing to receive care via telehealth modality for this appointment request. True if telehealth is an acceptable option.',
    `transportation_assistance_needed_flag` BOOLEAN COMMENT 'Indicates whether the patient requires transportation assistance to attend the appointment. True if transportation support is needed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_placeholder` STRING COMMENT '',
    `visit_reason` STRING COMMENT 'Free-text description of the clinical reason or chief complaint for the requested appointment.',
    `visit_reason_code` STRING COMMENT 'Coded representation of the visit reason using standard clinical terminology (e.g., SNOMED CT, ICD-10).',
    CONSTRAINT pk_waitlist_entry PRIMARY KEY(`waitlist_entry_id`)
) COMMENT 'Tracks all scheduling work items awaiting action — including patients on scheduling waitlists, unscheduled referrals, pending orders, recall-driven requests, surgical scheduling requests, and scheduling department work queues. Captures entry type (waitlist, referral queue, order-based, recall, surgical request), priority level, requested appointment type, patient scheduling preferences (preferred provider, preferred care site/location, preferred days/times, preferred contact channel, language preference, transportation needs, telehealth eligibility), queue entry datetime, assigned scheduling team, SLA target datetime, estimated wait time, status (active, offered, accepted, expired, removed, pending, in-progress, scheduled, escalated, closed), escalation/aging flags, and outreach attempt history. SSOT for all scheduling queue, waitlist, and patient preference management. Supports patient access optimization, scheduling department workflow, demand management, access SLA compliance, and patient-centered scheduling.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` (
    `appointment_reminder_id` BIGINT COMMENT 'Primary key for appointment_reminder',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: appointment_reminder.reminder_type is a STRING that partially captures the type of appointment being reminded about. appointment_type is the authoritative reference for appointment categorization incl',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Appointment reminders for care plan follow-up visits (chronic disease management, post-discharge transitions) must reference the care plan to include plan-specific instructions and measure patient eng',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Appointment reminders reference the treating clinician for patient communication. Linking enables provider-level no-show analytics, credentialing status checks before reminder dispatch, and accurate p',
    `mpi_record_id` BIGINT COMMENT 'Foreign key reference to the patient who received this reminder. Links to the patient demographics product.',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: appointment_reminder records reminders sent for upcoming appointments, but has no FK to any scheduling entity within the domain. Adding open_slot_id to appointment_reminder links the reminder to the s',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Referral loop closure requires confirming appointment reminders were sent for referral-driven appointments. Care coordinators track whether referred patients received reminders; this link enables refe',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Surgical cases require pre-operative reminders (NPO instructions, arrival time, consent reminders). appointment_reminder has no FK to surgical_case, leaving surgical reminders disconnected from the ca',
    `telehealth_session_id` BIGINT COMMENT 'Foreign key linking to scheduling.telehealth_session. Business justification: Telehealth appointments require specific reminders including session access codes, platform instructions, and technical preparation guidance. appointment_reminder has no FK to telehealth_session. Addi',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Post-discharge follow-up reminder programs require linking reminders to the originating encounter visit to measure no-show rates by visit type, support HRRP readmission prevention reporting, and enabl',
    `actual_send_datetime` TIMESTAMP COMMENT 'The actual date and time when the reminder was sent by the messaging system. May differ from scheduled send time due to system delays or batch processing.',
    `appointment_date` DATE COMMENT 'The date of the appointment for which this reminder was sent. Denormalized from the scheduling_appointment product for reporting convenience.',
    `appointment_time` TIMESTAMP COMMENT 'The scheduled start time of the appointment for which this reminder was sent. Denormalized from the scheduling_appointment product for reporting convenience.',
    `attempt_number` STRING COMMENT 'The sequential attempt number for this reminder (e.g., 1 for first attempt, 2 for second attempt). Supports tracking of retry logic and escalation workflows.',
    `campaign_code` STRING COMMENT 'Identifier for the reminder campaign or program under which this reminder was sent (e.g., no-show reduction initiative, seasonal flu shot reminders). Supports program-level analytics.',
    `cost_per_reminder` DECIMAL(18,2) COMMENT 'The cost incurred for sending this reminder through the selected delivery channel (e.g., SMS carrier fees, IVR system costs). Supports cost analysis and Return on Investment (ROI) calculation for reminder programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_channel` STRING COMMENT 'The communication channel through which the reminder was sent (e.g., phone call, SMS text message, email, patient portal message, Interactive Voice Response (IVR), mobile app push notification).. Valid values are `phone|sms|email|patient_portal|ivr|push_notification`',
    `delivery_failure_reason` STRING COMMENT 'Detailed reason for delivery failure if the reminder was not successfully delivered (e.g., invalid phone number, email bounce, patient portal not activated, carrier rejection).',
    `delivery_status` STRING COMMENT 'The delivery status of the reminder message (e.g., sent, delivered, failed, bounced, undeliverable, pending, cancelled). Indicates whether the message successfully reached the patient. [ENUM-REF-CANDIDATE: sent|delivered|failed|bounced|undeliverable|pending|cancelled — 7 candidates stripped; promote to reference product]',
    `department_name` STRING COMMENT 'The name of the department where the appointment is scheduled. Denormalized for patient communication and reporting purposes.',
    `facility_name` STRING COMMENT 'The name of the facility where the appointment is scheduled. Denormalized for patient communication and reporting purposes.',
    `language_code` STRING COMMENT 'The two-letter ISO 639-1 language code for the language in which the reminder was sent (e.g., en for English, es for Spanish). Supports multilingual patient communication.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this reminder record was last modified in the source system. Supports change tracking and audit trail requirements.',
    `lead_time_days` STRING COMMENT 'The number of days before the appointment that this reminder was scheduled to be sent. Supports analysis of optimal reminder timing for no-show reduction.',
    `max_attempts_allowed` STRING COMMENT 'The maximum number of reminder attempts configured for this appointment type or reminder workflow. Used to determine when to stop retry attempts.',
    `message_content` STRING COMMENT 'The full text content of the reminder message sent to the patient. May contain appointment details and instructions. Stored for audit and quality review purposes.',
    `mrn` STRING COMMENT 'The patients medical record number. Protected Health Information (PHI) under HIPAA.',
    `opt_out_datetime` TIMESTAMP COMMENT 'The date and time when the patient opted out of automated reminders, if applicable. Null if patient has not opted out.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the patient has opted out of receiving automated reminders. True if patient has opted out, False otherwise. Supports patient communication preferences and regulatory compliance.',
    `patient_response` STRING COMMENT 'The patients response to the reminder, if any (e.g., confirmed attendance, cancelled appointment, requested reschedule, no response received, opted out of reminders).. Valid values are `confirmed|cancelled|rescheduled|no_response|opted_out`',
    `recipient_email_address` STRING COMMENT 'The email address to which the reminder was sent, if delivery channel was email. Protected Health Information (PHI) under HIPAA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone_number` STRING COMMENT 'The phone number to which the reminder was sent, if delivery channel was phone or SMS. Protected Health Information (PHI) under HIPAA.',
    `reminder_type` STRING COMMENT 'The type or sequence of the reminder in the automated reminder workflow (e.g., initial, first reminder, second reminder, final reminder, confirmation request, pre-visit instructions).. Valid values are `initial|first_reminder|second_reminder|final_reminder|confirmation_request|pre_visit`',
    `response_channel` STRING COMMENT 'The channel through which the patient responded to the reminder (e.g., phone call, SMS reply, email reply, patient portal, IVR system, mobile app).. Valid values are `phone|sms|email|patient_portal|ivr|mobile_app`',
    `response_datetime` TIMESTAMP COMMENT 'The date and time when the patient responded to the reminder, if applicable. Null if no response was received.',
    `scheduled_send_datetime` TIMESTAMP COMMENT 'The date and time when the reminder was scheduled to be sent, based on the reminder lead time configuration and appointment date.',
    `source_system_identifier` STRING COMMENT 'The unique identifier for this reminder record in the source system. Supports data reconciliation and traceability back to the operational system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_appointment_reminder PRIMARY KEY(`appointment_reminder_id`)
) COMMENT 'Records of all patient appointment reminders sent via automated channels (phone, SMS, email, patient portal). Captures reminder type, channel, scheduled send datetime, actual send datetime, delivery status, patient response (confirmed, cancelled, no response), reminder template used, and number of attempts. Supports patient engagement workflows and no-show reduction programs. Sourced from Epic Cadence automated messaging.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` (
    `telehealth_session_id` BIGINT COMMENT 'Primary key for telehealth_session',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: telehealth_session.session_type is a STRING field (e.g., video visit, e-visit, telephone visit) that partially overlaps with appointment_type categorization. appointment_type has an allows_teleh',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider conducting the telehealth session.',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: CMS and state regulations require documented patient consent for telehealth services. telehealth_session has consent_obtained_flag and consent_datetime as plain columns but no FK to the consent record',
    `credential_id` BIGINT COMMENT 'Foreign key linking to provider.credential. Business justification: Telehealth sessions require verification of active state licenses and DEA registrations per interstate compact rules and CMS telehealth billing requirements. Links session to specific credential used ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: CMS telehealth billing requires identification of the distant site facility. Linking to org_provider enables Medicare/Medicaid distant site billing compliance, state licensure verification for cross-s',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: CMS mandates HCPCS G-codes (e.g., G0425–G0427) for telehealth billing reimbursement. `billing_modifier_code` and `billing_eligible_flag` confirm billing classification is tracked at session level. Thi',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Telehealth coverage varies significantly by health plan (originating site rules, CMS waivers, state mandates). Billing and compliance teams must verify plan-level telehealth coverage at session creati',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient participating in the telehealth session.',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: A telehealth session occupies a specific open slot in the providers schedule. telehealth_session has scheduled_start_datetime and scheduled_end_datetime as denormalized time fields but no FK to the o',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Telehealth billing requires payer identification to apply correct billing modifiers (GT, 95, GQ) and verify payer-specific telehealth policies. telehealth_session has billing_modifier_code but no paye',
    `referral_order_id` BIGINT COMMENT 'Foreign key linking to order.referral_order. Business justification: Telehealth specialist consults are frequently the fulfillment of a referral order. Referral loop closure tracking — a CMS and payer requirement — requires knowing whether the referral was fulfilled vi',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Telehealth sessions require documented patient treatment consent before the session. telehealth_session already tracks consent_obtained_flag and consent_datetime but has no FK to the actual treatment_',
    `visit_id` BIGINT COMMENT 'Reference to the clinical visit or encounter associated with this telehealth session.',
    `actual_duration_minutes` STRING COMMENT 'Actual duration of the telehealth session in minutes, calculated from start to end time.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the telehealth session ended, as recorded by the platform or provider.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the telehealth session began, as recorded by the platform or provider.',
    `billing_eligible_flag` BOOLEAN COMMENT 'Indicates whether the telehealth session meets all requirements for billing and reimbursement. Based on completion status, duration, documentation, and payer rules.',
    `billing_modifier_code` STRING COMMENT 'CPT or HCPCS modifier code applied to the telehealth session for billing purposes (e.g., GT, 95, GQ). Indicates the service was delivered via telehealth.',
    `cancellation_datetime` TIMESTAMP COMMENT 'Date and time when the telehealth session was cancelled, if applicable.',
    `cancellation_reason` STRING COMMENT 'Reason provided for cancellation of the telehealth session. Used for operational analysis and patient access improvement.',
    `cancelled_by_role` STRING COMMENT 'Role of the person or system that initiated the cancellation of the telehealth session.. Valid values are `patient|provider|staff|system`',
    `connection_quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall quality of the telehealth connection, typically on a scale of 0-100. Based on bandwidth, latency, and stability metrics.',
    `connection_status` STRING COMMENT 'Technical status of the network connection during the telehealth session. Used to track quality and troubleshoot issues.. Valid values are `connected|disconnected|poor_quality|reconnected|failed`',
    `consent_datetime` TIMESTAMP COMMENT 'Date and time when patient consent for telehealth services was obtained and documented.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether patient consent for telehealth services was obtained prior to or at the start of the session. Required for compliance and legal protection.',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this telehealth session record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `interpreter_language` STRING COMMENT 'Language for which interpretation services were provided during the telehealth session, if applicable.',
    `interpreter_present_flag` BOOLEAN COMMENT 'Indicates whether an interpreter was actually present and participated in the telehealth session.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a language interpreter was required for the telehealth session to facilitate communication between patient and provider.',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this telehealth session record was most recently updated.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the patient failed to attend the scheduled telehealth session without prior cancellation.',
    `originating_site_code` STRING COMMENT 'Code identifying the location where the patient is physically located during the telehealth session. Required for certain telehealth billing scenarios.',
    `patient_browser` STRING COMMENT 'Web browser used by the patient to access the telehealth session, if applicable. Used for technical support and compatibility tracking.',
    `patient_device_type` STRING COMMENT 'Type of device used by the patient to access the telehealth session. Helps identify technical support needs and access patterns.. Valid values are `desktop|laptop|tablet|smartphone|other`',
    `patient_operating_system` STRING COMMENT 'Operating system of the device used by the patient (e.g., iOS, Android, Windows, macOS). Used for troubleshooting and compatibility analysis.',
    `platform_name` STRING COMMENT 'Name of the telehealth platform or application used to conduct the session (e.g., Epic MyChart Video, Zoom for Healthcare, Doxy.me).',
    `platform_vendor` STRING COMMENT 'Vendor or manufacturer of the telehealth platform used for the session.',
    `provider_attestation_datetime` TIMESTAMP COMMENT 'Date and time when the provider attested to the completion of the telehealth session.',
    `provider_attestation_flag` BOOLEAN COMMENT 'Indicates whether the provider has attested to the completion and clinical validity of the telehealth session. Required for billing and compliance.',
    `provider_device_type` STRING COMMENT 'Type of device used by the provider to conduct the telehealth session.. Valid values are `desktop|laptop|tablet|smartphone|other`',
    `recording_enabled_flag` BOOLEAN COMMENT 'Indicates whether the telehealth session was recorded for clinical, educational, or quality purposes. Requires explicit patient consent.',
    `scheduled_duration_minutes` STRING COMMENT 'Planned duration of the telehealth session in minutes, based on appointment type and clinical requirements.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned date and time when the telehealth session was scheduled to end.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned date and time when the telehealth session was scheduled to begin.',
    `session_access_code` STRING COMMENT 'PIN or access code required to join the telehealth session. Used for additional security and patient verification.',
    `session_number` STRING COMMENT 'Human-readable business identifier for the telehealth session, used for tracking and reference purposes.',
    `session_status` STRING COMMENT 'Current lifecycle status of the telehealth session. Tracks progression from scheduling through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|no_show|technical_failure`',
    `session_type` STRING COMMENT 'Type of telehealth modality used for the session. Determines workflow, platform requirements, and billing rules.. Valid values are `video|phone|asynchronous|chat|remote_monitoring`',
    `session_url` STRING COMMENT 'Web link or URL provided to the patient and provider to access the telehealth session. Confidential to prevent unauthorized access.',
    `technical_issue_description` STRING COMMENT 'Free-text description of any technical issues encountered during the telehealth session, such as connectivity problems, audio/video quality issues, or platform errors.',
    `technical_issue_reported_flag` BOOLEAN COMMENT 'Indicates whether any technical issues were reported during or after the telehealth session that impacted quality or completion.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_telehealth_session PRIMARY KEY(`telehealth_session_id`)
) COMMENT 'Records of telehealth and virtual care appointments including video visits, e-visits, and telephone encounters. Captures session type (video, phone, asynchronous), platform used, session URL/access code, scheduled and actual start/end times, technical connection status, patient device type, provider attestation of completion, and billing eligibility flag. Distinct from in-person appointments due to unique workflow, platform, and reimbursement requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` (
    `provider_availability_id` BIGINT COMMENT 'Primary key for provider_availability',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Provider availability is fundamentally about when a specific clinician is available. Direct FK enables availability queries by clinician for on-call management, credentialing status checks before slot',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Provider availability is location-specific — a clinician may be available at Hospital A but not Clinic B. Linking to org_provider enables facility-specific availability queries, on-call scheduling at ',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: provider_availability tracks when a provider or resource is available, but currently only links to schedule_template. The availability record must identify WHICH resource it belongs to — this is the f',
    `schedule_template_id` BIGINT COMMENT 'Identifier of the schedule template that this availability record modifies or overrides, if applicable.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Availability is specialty-scoped for patient matching and network adequacy gap analysis. Linking to provider.specialty enables regulators and payers to identify specialty-specific availability shortfa',
    `accepts_new_patients` BOOLEAN COMMENT 'Boolean indicator (True/False) whether the provider is accepting new patient appointments during this availability period.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `availability_status` STRING COMMENT 'Current status of the availability record in its lifecycle.. Valid values are `active|cancelled|pending|expired`',
    `availability_type` STRING COMMENT 'The type of availability record: scheduled (normal working hours), on_call (available for urgent calls), blocked (time blocked for non-clinical work), vacation (time off), cme (Continuing Medical Education), administrative (administrative duties).. Valid values are `scheduled|on_call|blocked|vacation|cme|administrative`',
    `booked_appointments` STRING COMMENT 'The current count of appointments already booked during this availability period. Used for capacity management.',
    `cancellation_reason` STRING COMMENT 'Free-text description of why this availability record was cancelled.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was cancelled. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `care_setting` STRING COMMENT 'The care setting or service location where the provider is available: inpatient, outpatient, emergency department, surgical suite, telehealth, or home health.. Valid values are `inpatient|outpatient|emergency|surgical|telehealth|home_health`',
    `coverage_area` STRING COMMENT 'Geographic or organizational coverage area for on-call availability. Examples: entire hospital, specific units, regional coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credentialing_status` STRING COMMENT 'The credentialing status of the provider at the facility during this availability period. Must be active for scheduling.. Valid values are `active|pending|expired|suspended`',
    `duration_minutes` STRING COMMENT 'The total duration of the availability period in minutes, calculated from start to end datetime.',
    `effective_end_date` DATE COMMENT 'The date when this availability record expires and is no longer valid for scheduling. Null indicates no expiration. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date when this availability record becomes effective for scheduling purposes. Format: yyyy-MM-dd.',
    `end_datetime` TIMESTAMP COMMENT 'The date and time when the provider availability period ends. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `insurance_type_accepted` STRING COMMENT 'Comma-separated list of insurance types or payer categories accepted during this availability period. Examples: Medicare, Medicaid, Commercial, Self-Pay.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `max_appointments` STRING COMMENT 'The maximum number of appointments that can be scheduled during this availability period. Null indicates no specific limit.',
    `notes` STRING COMMENT 'Free-text notes or comments about this availability record. May include special instructions, constraints, or context.',
    `on_call_type` STRING COMMENT 'The type of on-call availability when availability_type is on_call: primary (first responder), backup (secondary coverage), home (available from home), hospital (on-site coverage).. Valid values are `primary|backup|home|hospital`',
    `overbooking_allowed` BOOLEAN COMMENT 'Boolean indicator (True/False) whether overbooking beyond max_appointments is permitted during this availability period.',
    `overbooking_limit` STRING COMMENT 'The maximum number of overbooked appointments allowed beyond the standard max_appointments capacity.',
    `override_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) that identifies whether this availability record is an exception or override to the providers standard schedule template.',
    `patient_class` STRING COMMENT 'The patient classification or visit type that this availability supports.. Valid values are `inpatient|outpatient|observation|emergency|surgical|same_day`',
    `priority_level` STRING COMMENT 'The priority level of appointments that can be scheduled during this availability period.. Valid values are `routine|urgent|emergency`',
    `privilege_code` STRING COMMENT 'The clinical privilege code or category that the provider holds at this facility, defining the scope of services they can provide.',
    `recurrence_end_date` DATE COMMENT 'The date when a recurring availability pattern ends. Null for one-time availability records. Format: yyyy-MM-dd.',
    `recurrence_pattern` STRING COMMENT 'Indicates whether this availability record is a one-time event or part of a recurring pattern.. Valid values are `once|daily|weekly|biweekly|monthly`',
    `remaining_capacity` STRING COMMENT 'The number of additional appointments that can still be scheduled during this availability period, calculated as max_appointments minus booked_appointments.',
    `source_system_identifier` STRING COMMENT 'The unique identifier for this availability record in the source system.',
    `start_datetime` TIMESTAMP COMMENT 'The date and time when the provider availability period begins. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `telehealth_enabled` BOOLEAN COMMENT 'Boolean indicator (True/False) whether the provider is available for telehealth appointments during this period.',
    `unavailability_reason` STRING COMMENT 'Free-text description of the reason for unavailability when availability_type is blocked, vacation, cme, or administrative. Examples: conference attendance, personal leave, training, committee meeting.',
    `unavailability_reason_code` STRING COMMENT 'Standardized code representing the reason for unavailability. Used for reporting and analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_placeholder` STRING COMMENT '',
    CONSTRAINT pk_provider_availability PRIMARY KEY(`provider_availability_id`)
) COMMENT 'Real-time and planned provider availability records capturing when providers are available, unavailable, or on leave for scheduling purposes. Captures provider NPI, availability type (scheduled, on-call, blocked, vacation, CME, administrative), start/end datetime, care setting, and reason for unavailability. Distinct from schedule templates — this captures actual availability exceptions and overrides that modify the template-generated slots.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_provider_availability_id` FOREIGN KEY (`provider_availability_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`provider_availability`(`provider_availability_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_schedule_template_id` FOREIGN KEY (`schedule_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedule_template`(`schedule_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_substitute_for_resource_assignment_id` FOREIGN KEY (`substitute_for_resource_assignment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`resource_assignment`(`resource_assignment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_telehealth_session_id` FOREIGN KEY (`telehealth_session_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`telehealth_session`(`telehealth_session_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_schedule_template_id` FOREIGN KEY (`schedule_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedule_template`(`schedule_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`scheduling` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`scheduling` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Order Set Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Required Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `billing_class` SET TAGS ('dbx_value_regex' = 'professional|facility|technical|global');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|telehealth|home_health|ambulatory_surgery');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `default_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `maximum_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `minimum_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'new_patient|established_patient|return_patient|referral');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `patient_class` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `patient_class` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `preparation_instructions` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('dbx_subdomain' = 'resource_planning');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Required Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `auto_confirm_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Confirm Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `buffer_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Buffer Time Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `max_slots_per_session` SET TAGS ('dbx_business_glossary_term' = 'Maximum Slots Per Session');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `no_show_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Tracking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `patient_class` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `patient_class` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent|elective');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|rotating|custom');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_rule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Rule');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Reminder Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_end_time` SET TAGS ('dbx_business_glossary_term' = 'Session End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_start_time` SET TAGS ('dbx_business_glossary_term' = 'Session Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|retired|pending');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_type` SET TAGS ('dbx_value_regex' = 'provider|resource|facility|equipment|room|staff');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `provider_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Availability Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Block Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_type` SET TAGS ('dbx_value_regex' = 'administrative|personal|maintenance|training|meeting|other');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Slot Comment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_expiration_datetime` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_expiration_datetime` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'available|held|released|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `insurance_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Insurance Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `insurance_eligibility` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `insurance_eligibility` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_cutoff_hours` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Cutoff Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `overbook_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbook Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `patient_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Patient Type Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `patient_type_eligibility` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `patient_type_eligibility` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_category` SET TAGS ('dbx_business_glossary_term' = 'Slot Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Slot End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_business_glossary_term' = 'Slot Business Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Slot Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_value_regex' = 'free|busy|busy-unavailable|busy-tentative|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `drg_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Op Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Preop Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Surgeon Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Privileging Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `add_on_case_indicator` SET TAGS ('dbx_business_glossary_term' = 'Add-On Case Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_value_regex' = 'general|regional|local|monitored_anesthesia_care|sedation|none');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `asa_classification` SET TAGS ('dbx_business_glossary_term' = 'American Society of Anesthesiologists (ASA) Physical Status Classification');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `asa_classification` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|VI');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_time_indicator` SET TAGS ('dbx_business_glossary_term' = 'Block Time Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ambulatory|emergency|trauma|transplant');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_obtained_indicator` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_obtained_indicator` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_obtained_indicator` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Equipment Requirements');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `implant_required` SET TAGS ('dbx_business_glossary_term' = 'Implant Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Surgical Laterality');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|same_day_surgery|extended_recovery');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Post-Operative Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_business_glossary_term' = 'Requires Blood Products Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_icu_bed` SET TAGS ('dbx_business_glossary_term' = 'Requires Intensive Care Unit (ICU) Bed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Surgery Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Surgical Service Line');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `site_marked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Surgical Site Marked Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Surgical Specialty');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `timeout_completed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Surgical Timeout Completed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Case Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|trauma');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('dbx_subdomain' = 'resource_planning');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `allows_overbooking` SET TAGS ('dbx_business_glossary_term' = 'Allows Overbooking Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `building` SET TAGS ('dbx_business_glossary_term' = 'Building Name or Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|ambulatory_surgery|home_health|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|revoked');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `default_slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Default Slot Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `default_slot_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `floor` SET TAGS ('dbx_business_glossary_term' = 'Floor Number or Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Professional License Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_end` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `minimum_turnover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Turnover Time in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'provider|room|equipment|care_team');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_business_glossary_term' = 'Room Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_configuration` SET TAGS ('dbx_business_glossary_term' = 'Room Configuration Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_configuration` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_constraints` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Constraints');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|reserved|retired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_cycle_required` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Cycle Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `unit` SET TAGS ('dbx_business_glossary_term' = 'Unit or Wing');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` SET TAGS ('dbx_subdomain' = 'resource_planning');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `substitute_for_resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute For Resource Assignment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent|elective|stat');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `cancelled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|declined|tentative|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `conflict_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `credentialing_verification_datetime` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verification Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `credentialing_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Tag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Reservation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `equipment_reservation_status` SET TAGS ('dbx_value_regex' = 'reserved|allocated|in_use|returned|unavailable');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `maintenance_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Clearance Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `primary_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `privilege_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `requested_datetime` SET TAGS ('dbx_business_glossary_term' = 'Requested Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'provider|room|equipment|staff|care_team_member|anesthesia_resource');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `sterilization_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`resource_assignment` ALTER COLUMN `sterilization_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Clearance Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Index Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Appointment Type Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|ambulatory_surgery|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'waitlist|referral_queue|order_based|recall|surgical_request|work_queue');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `estimated_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Wait Time in Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Method');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('dbx_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `outreach_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Preferred Days of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_business_glossary_term' = 'Preferred Time of Day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|any');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `queue_entry_datetime` SET TAGS ('dbx_business_glossary_term' = 'Queue Entry Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_datetime` SET TAGS ('dbx_business_glossary_term' = 'Removal Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `scheduled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `sla_target_datetime` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `transportation_assistance_needed_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Assistance Needed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `actual_send_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Send Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `appointment_time` SET TAGS ('dbx_business_glossary_term' = 'Appointment Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `cost_per_reminder` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Reminder');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `cost_per_reminder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'phone|sms|email|patient_portal|ivr|push_notification');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `delivery_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Delivery Failure Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `department_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `facility_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `max_attempts_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attempts Allowed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `message_content` SET TAGS ('dbx_business_glossary_term' = 'Message Content');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `message_content` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `mrn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `opt_out_datetime` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `patient_response` SET TAGS ('dbx_business_glossary_term' = 'Patient Response');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `patient_response` SET TAGS ('dbx_value_regex' = 'confirmed|cancelled|rescheduled|no_response|opted_out');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `patient_response` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `patient_response` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `recipient_phone_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `reminder_type` SET TAGS ('dbx_business_glossary_term' = 'Reminder Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `reminder_type` SET TAGS ('dbx_value_regex' = 'initial|first_reminder|second_reminder|final_reminder|confirmation_request|pre_visit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'phone|sms|email|patient_portal|ivr|mobile_app');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `response_datetime` SET TAGS ('dbx_business_glossary_term' = 'Response Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `scheduled_send_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_reminder` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `telehealth_session_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Distant Site Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `billing_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `billing_modifier_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Modifier Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Role');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `cancelled_by_role` SET TAGS ('dbx_value_regex' = 'patient|provider|staff|system');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `connection_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Connection Quality Score');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `connection_status` SET TAGS ('dbx_business_glossary_term' = 'Technical Connection Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `connection_status` SET TAGS ('dbx_value_regex' = 'connected|disconnected|poor_quality|reconnected|failed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_datetime` SET TAGS ('dbx_business_glossary_term' = 'Consent Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_datetime` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_datetime` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `interpreter_language` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Language');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `interpreter_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Present Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `originating_site_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Site Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_browser` SET TAGS ('dbx_business_glossary_term' = 'Patient Web Browser');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_browser` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_browser` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_device_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Device Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|smartphone|other');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_device_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_device_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_business_glossary_term' = 'Patient Operating System');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `patient_operating_system` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `platform_vendor` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform Vendor');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_attestation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Provider Attestation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Attestation Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_device_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Device Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `provider_device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|smartphone|other');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `recording_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Recording Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_access_code` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Access Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_access_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show|technical_failure');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_type` SET TAGS ('dbx_value_regex' = 'video|phone|asynchronous|chat|remote_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_url` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `session_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `technical_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Technical Issue Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`telehealth_session` ALTER COLUMN `technical_issue_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Issue Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('dbx_subdomain' = 'resource_planning');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Template ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'active|cancelled|pending|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_business_glossary_term' = 'Availability Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_value_regex' = 'scheduled|on_call|blocked|vacation|cme|administrative');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `booked_appointments` SET TAGS ('dbx_business_glossary_term' = 'Booked Appointments Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `coverage_area` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `insurance_type_accepted` SET TAGS ('dbx_business_glossary_term' = 'Insurance Type Accepted');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `insurance_type_accepted` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `insurance_type_accepted` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `max_appointments` SET TAGS ('dbx_business_glossary_term' = 'Maximum Appointments');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `on_call_type` SET TAGS ('dbx_business_glossary_term' = 'On-Call Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `on_call_type` SET TAGS ('dbx_value_regex' = 'primary|backup|home|hospital');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `overbooking_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|emergency|surgical|same_day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergency');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `privilege_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recurrence End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'once|daily|weekly|biweekly|monthly');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `unavailability_reason` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `unavailability_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason Code');
