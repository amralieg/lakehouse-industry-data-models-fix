-- Schema for Domain: housekeeping | Business: Travel Hospitality | Version: v1_mvm
-- Generated on: 2026-05-08 06:03:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `travel_hospitality_ecm`.`housekeeping` COMMENT 'Room cleaning operations, maintenance scheduling, and service quality management. Manages room status transitions (dirty, clean, inspected, out-of-order), housekeeping assignments, cleaning schedules, quality inspections, linen and supply consumption, and maintenance request handoffs. Integrates with Oracle OPERA PMS for real-time room status updates. Tracks CPOR (Cost Per Occupied Room) for housekeeping labor and supplies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` (
    `hk_assignment_id` BIGINT COMMENT 'Unique identifier for the housekeeping assignment record. Primary key.',
    `amenity_fulfillment_id` BIGINT COMMENT 'Foreign key linking to experience.amenity_fulfillment. Business justification: Housekeeping assignments are the operational vehicle for in-room amenity delivery. Linking hk_assignment to amenity_fulfillment enables fulfillment SLA tracking, delivery time reporting, and labor cos',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Housekeeping assignments must be charged to departmental cost centers for USALI labor cost tracking, budget variance analysis, and departmental P&L reporting. Essential for rooms division financial ma',
    `attendant_id` BIGINT COMMENT 'Identifier of the housekeeping attendant assigned to perform the work.',
    `banquet_event_order_id` BIGINT COMMENT 'Foreign key linking to fnb.banquet_event_order. Business justification: Housekeeping assignments for function space setup and post-event teardown are driven by the F&B Banquet Event Order (BEO), which specifies linen colors, table configuration, and setup requirements. Ho',
    `beo_id` BIGINT COMMENT 'Foreign key linking to event.beo. Business justification: Banquet Event Orders specify detailed setup requirements (furniture arrangement, special cleaning protocols, amenity placement) that housekeeping must execute. Direct operational dependency for transl',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Daily housekeeping assignments should follow specific cleaning standards based on room type, guest segment, and brand tier. Many assignments reference one cleaning standard (N:1). Links operational as',
    `experience_special_request_id` BIGINT COMMENT 'Foreign key linking to experience.experience_special_request. Business justification: Special housekeeping requests (extra cleaning, specific timing, hypoallergenic products) are tracked as special requests. Real business process: Guest preference fulfillment tracking for VIP service, ',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces require housekeeping assignments for event preparation, maintenance, and post-event restoration. Critical for scheduling attendants to specific event venues and tracking service delive',
    `hk_schedule_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_schedule. Business justification: Daily housekeeping assignments are created based on the master schedule. This links individual room assignments to the shift structure. Many assignments are part of one schedule (N:1). The shift col',
    `note_id` BIGINT COMMENT 'Foreign key linking to guest.note. Business justification: Housekeeping Special Instruction Note Retrieval: housekeeping systems pull the specific guest note record (display_on_checkin=true, assigned_department=housekeeping) driving special instructions for a',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Housekeeping attendants report minibar consumption and chargeable amenities discovered during room cleaning. These must link to the POS check that bills the guest, enabling reconciliation of in-room F',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Room attendants require guest profile data (VIP status, allergies, preferences) for personalized service delivery. Pre-service briefing process depends on profile link. hk_assignment has vip_indicator',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the assignment is located.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Housekeeping assignments must link to active reservations to coordinate DND flags, preferred service times, VIP protocols, allergy flags, and guest-present status during room servicing. Essential for ',
    `room_assignment_id` BIGINT COMMENT 'Foreign key linking to reservation.room_assignment. Business justification: Room readiness workflow: housekeeping assignments are directly triggered by room assignments (check-in, early arrival, upgrade). Linking hk_assignment to room_assignment enables supervisors to see upg',
    `room_id` BIGINT COMMENT 'Identifier of the specific room assigned for cleaning or service.',
    `room_service_order_id` BIGINT COMMENT 'Foreign key linking to fnb.room_service_order. Business justification: In full-service hotels, tray retrieval assignments are triggered by room service orders — housekeeping is dispatched to collect trays/dishes after guest consumption. Linking hk_assignment to room_serv',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Guest complaints about room cleanliness generate service cases requiring reference to specific housekeeping assignment. Real business process: Service recovery tracking, attendant accountability, and ',
    `service_recovery_action_id` BIGINT COMMENT 'Foreign key linking to experience.service_recovery_action. Business justification: Housekeeping failures (missed service, room not ready, DND override errors) directly trigger service recovery actions. Linking hk_assignment to service_recovery_action supports housekeeping-specific G',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to spa.appointment. Business justification: Spa appointment triggers treatment room turnover assignments. Linking hk_assignment to the triggering appointment enables spa operations to track room-readiness SLAs per appointment, supports appointm',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: hk_assignment is the core housekeeping work order. Treatment rooms are a distinct spa asset class separate from inventory.room. Linking hk_assignment directly to treatment_room enables spa facility ma',
    `space_allocation_id` BIGINT COMMENT 'Foreign key linking to event.event_space_allocation. Business justification: When a function space is allocated for an event session, housekeeping is assigned to execute the specific setup style and teardown. Direct link enables space-level HK assignment tracking per allocatio',
    `vip_designation_id` BIGINT COMMENT 'Foreign key linking to guest.vip_designation. Business justification: VIP Pre-Arrival Housekeeping Setup process: housekeeping supervisors retrieve the vip_designation record to apply correct amenity tier, pre-arrival checklist, and special handling instructions. vip_in',
    `actual_end_time` TIMESTAMP COMMENT 'The actual timestamp when the attendant completed work on this assignment, captured from mobile device or PMS entry.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual timestamp when the attendant began work on this assignment, captured from mobile device or PMS entry.',
    `allergy_flags` STRING COMMENT 'Comma-separated list of guest allergy or sensitivity flags that require special cleaning products or procedures (e.g., fragrance-free, latex-free, pet dander).',
    `amenity_replenishment_flag` BOOLEAN COMMENT 'Indicates whether guest amenities (toiletries, coffee, water, etc.) were replenished during this assignment.',
    `assignment_date` DATE COMMENT 'The business date on which the housekeeping assignment is scheduled to be performed.',
    `assignment_number` STRING COMMENT 'Human-readable business identifier for the housekeeping assignment, typically formatted as property-date-sequence.',
    `assignment_type` STRING COMMENT 'The type of housekeeping service to be performed: stayover (occupied room refresh), departure (checkout cleaning), deep clean (thorough cleaning), turndown (evening service), VIP prep (special preparation), or inspection (quality check).. Valid values are `stayover|departure|deep_clean|turndown|vip_prep|inspection`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the assignment was cancelled, if applicable (e.g., guest extended stay, room out of order, early checkout).',
    `completion_status` STRING COMMENT 'The current lifecycle status of the assignment: assigned (not yet started), in_progress (attendant working), completed (attendant finished), inspected (supervisor approved), rejected (failed inspection), or cancelled (assignment voided).. Valid values are `assigned|in_progress|completed|inspected|rejected|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this assignment record was first created in the system.',
    `dnd_flag` BOOLEAN COMMENT 'Indicates whether the guest has activated the Do Not Disturb indicator at the time of assignment. True if DND is active; attendant should skip or defer service.',
    `estimated_end_time` TIMESTAMP COMMENT 'The planned timestamp when the attendant is expected to complete work on this assignment.',
    `estimated_start_time` TIMESTAMP COMMENT 'The planned timestamp when the attendant is expected to begin work on this assignment.',
    `guest_preference_instructions` STRING COMMENT 'Free-text instructions for the attendant regarding guest-specific preferences, special requests, or service notes (e.g., extra towels, hypoallergenic products, preferred pillow type).',
    `inspection_notes` STRING COMMENT 'Free-text notes from the inspector documenting quality issues, deficiencies, or commendations observed during inspection.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this assignment requires supervisor or quality assurance inspection before the room can be released to clean status.',
    `inspection_result` STRING COMMENT 'The outcome of the quality inspection: passed (meets standards), failed (requires rework), or conditional (minor issues noted but room released).. Valid values are `passed|failed|conditional`',
    `inspection_timestamp` TIMESTAMP COMMENT 'The timestamp when the quality inspection was completed by the supervisor or inspector.',
    `linen_change_flag` BOOLEAN COMMENT 'Indicates whether a full linen change (sheets, pillowcases, duvet covers) was performed during this assignment.',
    `maintenance_request_description` STRING COMMENT 'Free-text description of the maintenance issue identified by the attendant (e.g., leaking faucet, broken lamp, HVAC not cooling).',
    `maintenance_request_flag` BOOLEAN COMMENT 'Indicates whether the attendant identified a maintenance issue during service that requires a work order handoff to the maintenance department.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this assignment record was last modified in the system.',
    `preferred_service_time` TIMESTAMP COMMENT 'Guest-requested time window for housekeeping service (e.g., after 2pm, morning only), captured from guest profile or front desk communication.',
    `priority_level` STRING COMMENT 'The urgency level of the assignment: urgent (immediate attention required), high (priority guest or early arrival), normal (standard schedule), or low (can be deferred).. Valid values are `urgent|high|normal|low`',
    `reassignment_count` STRING COMMENT 'The number of times this assignment has been reassigned to a different attendant, indicating scheduling changes or workload rebalancing.',
    `room_credits` DECIMAL(18,2) COMMENT 'The number of room credits assigned to this task for productivity tracking and labor allocation. Standard departure cleaning typically equals 1.0 credit; stayovers may be 0.5; deep cleans may be 1.5-2.0.',
    `room_status_after` STRING COMMENT 'The room status after the attendant completes the assignment and updates the system.. Valid values are `dirty|clean|inspected|pickup|out_of_order|out_of_service`',
    `room_status_before` STRING COMMENT 'The room status at the time the assignment was created, before the attendant begins work.. Valid values are `dirty|clean|inspected|pickup|out_of_order|out_of_service`',
    `special_cleaning_code` STRING COMMENT 'Code indicating special cleaning protocols applied (e.g., COVID-19, biohazard, pet cleanup, smoke remediation).',
    `towel_change_flag` BOOLEAN COMMENT 'Indicates whether towels were replaced during this assignment.',
    CONSTRAINT pk_hk_assignment PRIMARY KEY(`hk_assignment_id`)
) COMMENT 'Transactional record of daily housekeeping work assignments, mapping attendants to specific rooms for a given shift. Captures assignment type (stayover, departure, deep clean, turndown, VIP prep), priority level, estimated and actual start/end times, room credits, completion status, and any guest preference instructions (DND, preferred time, allergy flags). Sourced from OPERA PMS housekeeping module. Serves as the primary labor allocation record for CPOR calculation and attendant productivity tracking.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` (
    `cleaning_task_id` BIGINT COMMENT 'Unique identifier for the cleaning task. Primary key.',
    `attendant_id` BIGINT COMMENT 'Reference to the housekeeping attendant assigned to perform this task.',
    `beo_id` BIGINT COMMENT 'Foreign key linking to event.beo. Business justification: BEOs specify setup style, special cleaning requirements, and timing for each event function. Cleaning tasks are generated directly from BEO instructions. Direct link enables BEO-driven task creation w',
    `cleaning_standard_id` BIGINT COMMENT 'Reference to the cleaning standard template that defines the task requirements and quality criteria.',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: Cleaning tasks for function space setup, teardown, and room block preparation are generated from event bookings. Direct link enables event-level labor cost tracking, task completion reporting per book',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces generate recurring cleaning tasks based on event schedules, usage intensity, and space type. Essential for task scheduling, labor allocation, and ensuring spaces meet cleanliness stand',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Cleaning tasks are granular work items performed within the context of a housekeeping assignment. The assignment is the work order; tasks are the line items. This link enables tracking of task-level p',
    `hk_schedule_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_schedule. Business justification: Cleaning tasks are performed during specific housekeeping shifts/schedules. This links operational task execution to the master schedule. Many cleaning tasks occur during one schedule (N:1). No bidire',
    `preference_id` BIGINT COMMENT 'Foreign key linking to guest.preference. Business justification: Task execution must honor guest-specific preferences (pillow type, room temperature, housekeeping schedule). Preference fulfillment workflow during cleaning requires direct link to preference record f',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where this cleaning task is performed.',
    `reservation_special_request_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_special_request. Business justification: Special request fulfillment tracking: cleaning tasks are frequently generated to fulfill guest special requests (extra pillows, foam pillow, specific room setup, amenity placement). Linking cleaning_t',
    `room_assignment_id` BIGINT COMMENT 'Reference to the parent housekeeping room assignment that contains this task.',
    `room_id` BIGINT COMMENT 'Reference to the specific room being cleaned.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Housekeeping productivity reporting by room type (credits earned, SLA compliance, time-per-clean) requires direct room_type reference. room_type_code is a denormalization of inventory.room_type. Domai',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Specific cleaning tasks (missed items, incomplete work) trigger guest complaints. Real business process: Task-level root cause analysis for service failures, identifying which specific cleaning steps ',
    `service_recovery_action_id` BIGINT COMMENT 'Foreign key linking to experience.service_recovery_action. Business justification: Specific cleaning task failures (skipped mandatory tasks, SLA breaches on guest-requested tasks) trigger service recovery actions. Linking at task level enables granular root-cause analysis for servic',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Cleaning tasks are executed in specific treatment rooms following each appointment. cleaning_task.room_id covers hotel rooms only. Linking to treatment_room enables task-level sanitation compliance au',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual cleaning tasks drive labor cost allocation to departments. Required for USALI departmental expense reporting, labor productivity analysis (cost per credit), and operational budget tracking ',
    `actual_end_time` TIMESTAMP COMMENT 'Actual timestamp when the attendant completed or stopped performing this task.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual timestamp when the attendant began performing this task, captured from mobile device or PMS entry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cleaning task record was first created in the system.',
    `credit_weight` DECIMAL(18,2) COMMENT 'Numeric credit value assigned to this task contributing to the attendants total room credits for workload balancing and productivity tracking.',
    `duration_minutes` STRING COMMENT 'Total time spent performing this task in minutes, calculated from actual start and end times or manually entered.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this task encountered an exception condition requiring supervisor attention or follow-up action.',
    `exception_notes` STRING COMMENT 'Free-text notes describing any exceptions, issues, or special circumstances encountered during task execution.',
    `guest_present` BOOLEAN COMMENT 'Indicates whether the guest was present in the room during task execution, affecting service approach and privacy considerations.',
    `guest_request_flag` BOOLEAN COMMENT 'Indicates whether this task was performed in response to a specific guest request rather than standard cleaning schedule.',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether this task requires formal inspection by a supervisor or quality control team member.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp when the task was inspected and quality verified.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this task is required for the room to be marked as clean and ready for guest occupancy.',
    `is_quality_checkpoint` BOOLEAN COMMENT 'Indicates whether this task requires supervisor inspection or quality verification before the room can be released.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cleaning task record was last updated, used for audit trail and data synchronization.',
    `maintenance_request_generated` BOOLEAN COMMENT 'Indicates whether this task resulted in a maintenance request being created for repair or follow-up work.',
    `quality_score` STRING COMMENT 'Numeric quality rating assigned to this task during inspection, typically on a scale of 1-5 or 1-10, used for attendant performance evaluation.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned timestamp when the task should begin based on the room assignment schedule.',
    `service_type` STRING COMMENT 'Type of room service being performed which determines the scope and depth of cleaning tasks required.. Valid values are `checkout|stayover|arrival|deep_clean|turndown|refresh`',
    `skip_reason_code` STRING COMMENT 'Standardized code indicating why the task was skipped or not completed (e.g., REFUSE for guest refused service, UNAVAIL for item unavailable, MAINT for maintenance required, DND for do not disturb).. Valid values are `^[A-Z0-9]{2,6}$`',
    `skip_reason_description` STRING COMMENT 'Detailed explanation of why the task was skipped, providing context for exception reporting and service recovery.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether this task was completed within the defined SLA target time, used for performance reporting and operational KPI tracking.',
    `sla_target_minutes` STRING COMMENT 'Target time in minutes for completing this task per the propertys service level agreement and room turnaround time standards.',
    `standard_duration_minutes` STRING COMMENT 'Expected time in minutes to complete this task per the cleaning standard, used for performance benchmarking and labor planning.',
    `supply_item_code` STRING COMMENT 'Code identifying the primary supply or consumable item used in this task (e.g., cleaning chemical, linen type, amenity SKU).. Valid values are `^[A-Z0-9]{2,10}$`',
    `supply_quantity_used` DECIMAL(18,2) COMMENT 'Quantity of the supply item consumed during this task, used for inventory tracking and CPOR (Cost Per Occupied Room) calculation.',
    `supply_unit_of_measure` STRING COMMENT 'Unit of measure for the supply quantity used (e.g., each, bottle, sheet, towel, roll, ounce, liter, set). [ENUM-REF-CANDIDATE: each|bottle|sheet|towel|roll|ounce|liter|set — 8 candidates stripped; promote to reference product]',
    `task_code` STRING COMMENT 'Standardized code identifying the type of cleaning task (e.g., BED for bed making, BATH for bathroom sanitization, VAC for vacuuming, LINEN for linen change, MINI for minibar restock, AMEN for amenity placement).. Valid values are `^[A-Z0-9]{2,10}$`',
    `task_name` STRING COMMENT 'Human-readable name of the cleaning task (e.g., Bed Making, Bathroom Sanitization, Vacuuming, Linen Change, Minibar Restock, Amenity Placement).',
    `task_priority` STRING COMMENT 'Priority level assigned to this task based on guest arrival time, room status urgency, or special requests.. Valid values are `standard|high|urgent|rush`',
    `task_sequence` STRING COMMENT 'Order in which this task should be performed within the room assignment per the cleaning standard operating procedure.',
    `task_status` STRING COMMENT 'Current completion status of the cleaning task within its lifecycle.. Valid values are `pending|in_progress|completed|skipped|failed|exception`',
    `task_type` STRING COMMENT 'Category of the cleaning task indicating the nature of work performed.. Valid values are `cleaning|sanitization|restocking|inspection|maintenance_prep|turndown`',
    `training_indicator` BOOLEAN COMMENT 'Indicates whether this task was performed as part of attendant training or onboarding, affecting performance evaluation and quality expectations.',
    CONSTRAINT pk_cleaning_task PRIMARY KEY(`cleaning_task_id`)
) COMMENT 'Granular operational record of individual cleaning tasks performed within a room assignment, including task type (bed making, bathroom sanitization, vacuuming, linen change, minibar restock, amenity placement), task sequence per cleaning standard, completion status, time spent (minutes), supplies consumed with quantities, and any exceptions or skip reasons (guest refused, item unavailable, maintenance required). Each task carries a credit weight contributing to the assignments total room credits. Enables quality control tracking, SLA compliance for room turnaround time standards, and provides task-level data for attendant training, performance coaching, and cleaning standard refinement.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Unique identifier for the quality inspection record. Primary key for the inspection entity.',
    `attendant_id` BIGINT COMMENT 'Reference to the housekeeper who cleaned the room prior to this inspection. Links to workforce/employee master data for performance tracking.',
    `banquet_event_order_id` BIGINT COMMENT 'Foreign key linking to fnb.banquet_event_order. Business justification: Pre-event function space inspections are conducted against BEO specifications to confirm F&B setup (linen, place settings, AV) meets requirements before guest arrival. Linking inspection to banquet_ev',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Inspections evaluate rooms against specific cleaning standards/SOPs. This links quality control to the standard being evaluated. Many inspections reference one cleaning standard (N:1). Essential for t',
    `cleaning_task_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_task. Business justification: An inspection is formally triggered by the completion of a cleaning task — cleaning_task has inspection_required (BOOLEAN) and inspection_timestamp fields confirming this direct relationship. Adding c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality inspections are labor activities that must be allocated to housekeeping department cost centers for accurate departmental expense tracking and quality assurance program cost analysis per USALI',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Housekeeping conducts daily cleanliness inspections of F&B outlet areas (dining rooms, bars, lobbies). Linking inspection to fnb_outlet enables outlet-level cleanliness score reporting, trend analysis',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces require quality inspections before event release and after cleaning completion. Essential for quality assurance, deficiency tracking, and ensuring spaces meet brand standards before hi',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Inspections verify the quality of work completed in housekeeping assignments. Linking inspection to the assignment that triggered it enables quality tracking per attendant and assignment, supports per',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Pre- and post-event meeting space inspections are a standard HK process for brand compliance and client SLA management. Event operations teams require inspection records tied to specific meeting space',
    `out_of_order_id` BIGINT COMMENT 'Foreign key linking to inventory.out_of_order. Business justification: Hotel quality management process: failed inspections triggering room OOO status must link to the resulting out_of_order record for root-cause analysis, OOO conversion rate KPIs, and regulatory safety ',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Facility inspections (pool, gym, spa areas) are a distinct HK workflow. QA managers conduct and record cleanliness/compliance inspections per facility for brand standards and regulatory compliance. In',
    `property_id` BIGINT COMMENT 'Reference to the property where the inspection occurred. Links to the property master data.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Pre-arrival inspections must link to incoming reservations to verify room readiness against guest arrival time, VIP status, and special requests. Critical for room release workflow and ensuring room m',
    `room_assignment_id` BIGINT COMMENT 'Foreign key linking to reservation.room_assignment. Business justification: Pre-arrival room readiness inspection: quality teams inspect the specific assigned room before guest arrival. Linking inspection to room_assignment enables tracking whether the inspected room matches ',
    `room_id` BIGINT COMMENT 'Reference to the specific room that was inspected. Links to the room inventory master data.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Critical inspection findings (failed cleanliness scores, maintenance issues blocking room sale) directly generate service cases. A direct FK supports inspection-to-case traceability for quality audits',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Inspections are conducted on treatment rooms to verify sanitation protocol compliance before room release. inspection.room_id covers hotel rooms only; treatment rooms are a separate spa asset. Spa man',
    `space_allocation_id` BIGINT COMMENT 'Foreign key linking to event.event_space_allocation. Business justification: Inspections are performed on allocated event spaces before guest arrival and after teardown to confirm setup compliance and space readiness. Direct link enables per-allocation inspection outcome repor',
    `vip_designation_id` BIGINT COMMENT 'Foreign key linking to guest.vip_designation. Business justification: VIP Room Readiness Inspection Report: mandatory pre-arrival supervisor inspections are triggered and governed by the vip_designation record (designation_code, pre_arrival_checklist_template). vip_flag',
    `amenity_check_flag` BOOLEAN COMMENT 'Boolean indicator whether the inspector verified that all required room amenities are present and properly stocked (toiletries, linens, coffee supplies, etc.).',
    `bathroom_quality_flag` BOOLEAN COMMENT 'Boolean indicator whether the bathroom meets cleanliness and quality standards, including fixtures, surfaces, and amenities, a critical GSS (Guest Satisfaction Score) driver.',
    `cleanliness_score` DECIMAL(18,2) COMMENT 'Sub-score specifically measuring cleanliness standards (surfaces, bathroom, floors, linens), a key component of overall quality score and GSS (Guest Satisfaction Score).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inspection record was first created in the system, used for audit trail and data lineage tracking.',
    `critical_deficiency_count` STRING COMMENT 'Number of critical deficiencies identified that directly impact guest safety or satisfaction (e.g., cleanliness issues, safety hazards), requiring immediate remediation.',
    `deficiency_count` STRING COMMENT 'Total number of deficiency items or quality issues identified during the inspection, used for quality scoring and housekeeper performance evaluation.',
    `deficiency_description` STRING COMMENT 'Detailed free-text description of all deficiencies and quality issues identified during the inspection, used for corrective action and training purposes.',
    `duration_minutes` STRING COMMENT 'Total time in minutes spent conducting the inspection, calculated from start to end timestamps, used for labor productivity analysis and CPOR (Cost Per Occupied Room) calculations.',
    `end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the inspector completed the room inspection, used for duration calculation and productivity tracking.',
    `guest_arrival_date` DATE COMMENT 'The scheduled arrival date of the next guest for this room, used to prioritize inspection urgency and ensure room readiness for check-in.',
    `inspection_number` STRING COMMENT 'Human-readable business identifier for the inspection, typically formatted as property code, date, and sequence number for operational tracking and reference.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection: scheduled (assigned but not started), in_progress (inspector actively reviewing), completed (inspection finished and passed), failed (deficiencies found requiring re-clean), or cancelled (inspection voided).. Valid values are `scheduled|in_progress|completed|failed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection based on its purpose: routine (standard post-cleaning check), deep_clean (periodic thorough inspection), turndown (evening service check), checkout (post-guest departure), maintenance_follow_up (verification after repair), or quality_audit (supervisory quality control).. Valid values are `routine|deep_clean|turndown|checkout|maintenance_follow_up|quality_audit`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this inspection record was last updated, used for audit trail and change tracking.',
    `linen_quality_flag` BOOLEAN COMMENT 'Boolean indicator whether linens (sheets, towels, pillowcases) meet quality standards with no stains, tears, or wear, critical for guest satisfaction.',
    `maintenance_issue_flag` BOOLEAN COMMENT 'Boolean indicator whether maintenance issues were identified during the inspection that require handoff to the maintenance department (e.g., broken fixtures, HVAC problems, plumbing issues).',
    `notes` STRING COMMENT 'Additional free-text notes and observations recorded by the inspector, including positive feedback, special conditions, or contextual information for operational reference.',
    `outcome` STRING COMMENT 'Final result of the inspection: pass (room meets quality standards and is released), fail (room requires re-clean), or conditional_pass (minor issues noted but room released with follow-up required).. Valid values are `pass|fail|conditional_pass`',
    `priority_level` STRING COMMENT 'Priority classification for the inspection based on guest arrival time, room type, and operational needs: urgent (VIP or immediate check-in), high (same-day arrival), normal (next-day arrival), or low (future availability).. Valid values are `urgent|high|normal|low`',
    `quality_score` DECIMAL(18,2) COMMENT 'Numerical quality score assigned to the room based on inspection criteria, typically on a 0-100 scale, used for GSS (Guest Satisfaction Score) correlation and housekeeper performance tracking.',
    `reclean_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the room requires re-cleaning due to deficiencies identified during inspection. True indicates the room failed inspection and must be re-cleaned before guest occupancy.',
    `room_release_flag` BOOLEAN COMMENT 'Boolean indicator whether the room has been formally released as inspected and made available for guest check-in. True indicates the room is ready for sale and occupancy.',
    `room_release_timestamp` TIMESTAMP COMMENT 'The precise date and time when the room was released as inspected and made available for guest occupancy, critical for RevPAR (Revenue Per Available Room) and inventory availability tracking.',
    `room_status_after` STRING COMMENT 'The room status set after the inspection is completed, typically inspected (if passed) or dirty (if failed and requires re-clean), critical for PMS (Property Management System) room availability updates.. Valid values are `dirty|clean|inspected|occupied|out_of_order|out_of_service`',
    `room_status_before` STRING COMMENT 'The room status immediately prior to the inspection, typically clean (post-housekeeping) or dirty (pre-cleaning), used for status transition tracking and operational workflow validation.. Valid values are `dirty|clean|inspected|occupied|out_of_order|out_of_service`',
    `scheduled_date` DATE COMMENT 'The date on which the inspection was scheduled to occur, used for planning and workload management.',
    `scheduled_time` TIMESTAMP COMMENT 'The precise date and time when the inspection was scheduled to begin, enabling time-based operational coordination.',
    `special_request_notes` STRING COMMENT 'Free-text notes capturing any special guest requests or room preparation requirements that the inspector must verify (e.g., hypoallergenic bedding, extra amenities, accessibility features).',
    `start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the inspector began the room inspection, used for duration calculation and operational analytics.',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Quality inspection record capturing the formal review of a cleaned room by a housekeeping supervisor or inspector before the room is released as inspected and made available for guest check-in. Records inspection outcome (pass/fail), deficiency items identified, re-clean required flag, inspector identity, inspection timestamp, and final room release status. Critical for GSS (Guest Satisfaction Score) and service quality management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` (
    `inspection_deficiency_id` BIGINT COMMENT 'Unique identifier for the inspection deficiency record. Primary key for the inspection deficiency entity.',
    `amenity_fulfillment_id` BIGINT COMMENT 'Foreign key linking to experience.amenity_fulfillment. Business justification: Inspection deficiencies for missing or incorrect amenities (wrong amenity placed, amenity not delivered) directly trigger corrective amenity_fulfillment records. Linking these supports deficiency-to-r',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Deficiencies represent violations of specific cleaning standards. This links quality failures to the standard that was not met. Many deficiencies can reference one cleaning standard (N:1). Critical fo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deficiency resolution costs (resolution_cost_amount) must be charged to a cost center for USALI expense tracking and budget variance reporting. Hotel finance teams require cost center attribution fo',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: Deficiencies found during pre-event and post-event inspections of function spaces and room blocks must be tracked against the event booking for quality reporting, client dispute resolution, and contra',
    `inspection_id` BIGINT COMMENT 'Reference to the parent quality inspection during which this deficiency was identified. Links to the inspection header record.',
    `inventory_control_id` BIGINT COMMENT 'Foreign key linking to revenue.inventory_control. Business justification: When inspection_deficiency.blocks_room_sale_flag is true, the deficiency directly triggers an inventory_control update (out_of_order_rooms, stop_sell). Revenue management and housekeeping both track t',
    `property_id` BIGINT COMMENT 'Reference to the property where the deficiency was identified. Supports multi-property quality benchmarking.',
    `room_id` BIGINT COMMENT 'Reference to the specific room where the deficiency was found. Enables room-level deficiency trend analysis.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Critical deficiencies discovered during inspection that impact guest experience generate service cases. Real business process: Proactive issue resolution and guest notification when inspection reveals',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Deficiencies found during treatment room inspections must be tracked against the specific treatment room to drive maintenance escalation, room-blocking decisions (blocks_room_sale_flag), and sanitatio',
    `actual_resolution_time_minutes` STRING COMMENT 'Actual time in minutes taken to resolve the deficiency. Enables variance analysis against estimates and supports CPOR (Cost Per Occupied Room) calculation.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the deficiency was assigned to a department or employee for resolution. Tracks handoff timing for SLA (Service Level Agreement) compliance.',
    `blocks_room_sale_flag` BOOLEAN COMMENT 'Indicates whether the deficiency prevents the room from being sold until resolved. Critical for revenue management and inventory availability.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the deficiency record was officially closed. Final lifecycle event for deficiency tracking.',
    `corrective_action_required` STRING COMMENT 'Description of the corrective action needed to resolve the deficiency. May include re-cleaning instructions, maintenance work orders, or amenity replenishment requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deficiency record was first created in the system. Audit trail for data lineage.',
    `deficiency_category` STRING COMMENT 'Primary classification of the deficiency type. Categories align with housekeeping quality standards and maintenance handoff protocols.. Valid values are `cleanliness|maintenance|amenity|linen|damage|safety`',
    `deficiency_description` STRING COMMENT 'Detailed free-text description of the specific deficiency observed during inspection. Provides context for corrective action and quality improvement analysis.',
    `deficiency_sequence` STRING COMMENT 'Sequential line number of this deficiency within the parent inspection. Orders deficiencies for reporting and review workflows.',
    `deficiency_subcategory` STRING COMMENT 'Detailed subcategory within the primary deficiency category. Examples: bathroom cleanliness, HVAC malfunction, missing amenity, torn linen, wall damage, fire safety violation. Enables granular trend analysis.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the deficiency was escalated to management due to severity, recurrence, or resolution delays. Triggers executive visibility.',
    `escalation_reason` STRING COMMENT 'Free-text explanation of why the deficiency was escalated. Provides context for management review and process improvement.',
    `estimated_resolution_time_minutes` STRING COMMENT 'Estimated time in minutes required to resolve the deficiency. Used for workload planning and labor cost estimation.',
    `guest_impacting_flag` BOOLEAN COMMENT 'Indicates whether the deficiency directly impacts guest experience or satisfaction. Used for GSS (Guest Satisfaction Score) correlation analysis.',
    `identified_timestamp` TIMESTAMP COMMENT 'Date and time when the deficiency was first identified during inspection. Business event timestamp for deficiency lifecycle tracking.',
    `inspector_notes` STRING COMMENT 'Additional free-text notes recorded by the inspector at the time of deficiency identification. Provides supplementary context.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this deficiency record was last modified. Audit trail for change tracking and data quality monitoring.',
    `location_detail` STRING COMMENT 'Specific location within the room where the deficiency was found. Examples: bathroom sink, bedroom closet, balcony door, minibar area. Enables precise corrective action.',
    `photo_attachment_url` STRING COMMENT 'URL or file path to photographic evidence of the deficiency. Supports visual documentation for training, dispute resolution, and quality audits.',
    `preventive_action_taken` STRING COMMENT 'Description of preventive actions implemented to avoid recurrence of this deficiency type. Supports continuous improvement programs.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this deficiency requires expedited resolution. True for deficiencies blocking room availability or impacting guest safety.',
    `recurring_deficiency_flag` BOOLEAN COMMENT 'Indicates whether this deficiency has been identified in previous inspections of the same room. Flags systemic quality issues requiring root cause analysis.',
    `resolution_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action was completed. Used to calculate actual resolution time and SLA compliance.',
    `resolution_cost_amount` DECIMAL(18,2) COMMENT 'Direct cost incurred to resolve the deficiency, including labor, materials, and supplies. Denominated in property base currency. Supports CPOR and GOP (Gross Operating Profit) analysis.',
    `resolution_notes` STRING COMMENT 'Free-text notes recorded by the resolver documenting the corrective action taken. Supports knowledge transfer and audit trail.',
    `resolution_started_timestamp` TIMESTAMP COMMENT 'Date and time when corrective action was initiated. Measures response time from identification to action.',
    `resolution_status` STRING COMMENT 'Current status of the deficiency resolution workflow. Tracks lifecycle from identification through verification and closure.. Valid values are `open|in_progress|resolved|verified|closed|escalated`',
    `root_cause_category` STRING COMMENT 'Classification of the underlying root cause of the deficiency. Supports continuous improvement and preventive action planning.. Valid values are `training|process|equipment|supply|staffing|vendor`',
    `root_cause_notes` STRING COMMENT 'Detailed notes on the root cause analysis performed for this deficiency. Documents findings for knowledge management and training.',
    `severity_level` STRING COMMENT 'Severity classification of the deficiency. Critical deficiencies prevent room sale; major deficiencies impact guest satisfaction; minor and cosmetic deficiencies are tracked for continuous improvement.. Valid values are `critical|major|minor|cosmetic`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the deficiency resolution was verified by a supervisor or quality inspector. Ensures quality control closure.',
    CONSTRAINT pk_inspection_deficiency PRIMARY KEY(`inspection_deficiency_id`)
) COMMENT 'Line-item record of individual deficiencies identified during a room quality inspection, including deficiency category (cleanliness, maintenance, amenity, linen, damage), severity level, description, corrective action required, resolution status, and resolution timestamp. Enables trend analysis for recurring quality issues and supports continuous improvement programs.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` (
    `hk_schedule_id` BIGINT COMMENT 'Unique identifier for the housekeeping schedule record. Primary key.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Housekeeping schedules are built against approved labor budgets. Linking hk_schedule to finance_budget enables scheduled-vs-budgeted labor variance reporting — a core hotel operations KPI. The denorma',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to revenue.demand_forecast. Business justification: Housekeeping labor scheduling is directly driven by the revenue demand forecast: projected_occupancy_pct and projected_rooms_sold determine planned_headcount and labor_budget_amount. Every hotel opera',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Hotel finance requires housekeeping labor costs to be reported within fiscal periods for P&L close and budget variance analysis. Linking hk_schedule to fiscal_period enables period-based labor cost ag',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property to which this housekeeping schedule applies.',
    `reservation_group_block_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_group_block. Business justification: Group block labor planning: large group arrivals and departures drive significant housekeeping staffing requirements. Linking hk_schedule to reservation_group_block allows housekeeping managers to pla',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shift schedules drive labor budget allocation to cost centers. Essential for labor forecasting, budget variance analysis, CPOR (Cost Per Occupied Room) calculation, and departmental P&L accuracy.',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: Housekeeping schedules are organized by facility section. Spa facilities (wet areas, treatment rooms, relaxation lounges) require dedicated housekeeping scheduling distinct from hotel floors. Linking ',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to revenue.strategy. Business justification: Revenue strategy defines planning horizons, target occupancy, and high-demand periods that directly govern housekeeping labor budgets and staffing approach. Hotel operations teams align the housekeepi',
    `assignment_method` STRING COMMENT 'The method used to assign sections to attendants for this schedule (seniority bidding, rotation, manager assignment, or fixed assignment).. Valid values are `seniority_bidding|rotation|manager_assignment|fixed`',
    `break_duration_minutes` STRING COMMENT 'The length of the scheduled break in minutes. Nullable if no break is scheduled.',
    `break_start_time` TIMESTAMP COMMENT 'The scheduled start time for the break window during the shift. Nullable if no formal break is scheduled.',
    `consecutive_days_worked` STRING COMMENT 'The number of consecutive days worked by attendants assigned to this schedule, tracked for union CBA compliance (maximum consecutive days before mandatory rest).',
    `cpor_target` DECIMAL(18,2) COMMENT 'The target Cost Per Occupied Room for housekeeping labor and supplies for this schedule, used for performance tracking and labor planning.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this housekeeping schedule record was first created in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this housekeeping schedule record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to this housekeeping schedule (e.g., VIP arrivals, special events, maintenance windows).',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'The number of hours beyond which overtime pay applies for attendants on this shift, per union CBA or local labor law.',
    `pip_compliance_flag` BOOLEAN COMMENT 'Indicates whether this schedule meets Property Improvement Plan (PIP) staffing requirements (True if compliant, False otherwise).',
    `planned_headcount` STRING COMMENT 'The number of housekeeping attendants planned to work during this shift, calibrated to occupancy forecast and room count.',
    `published_timestamp` TIMESTAMP COMMENT 'The date and time when the schedule was published and made available to housekeeping staff. Nullable if not yet published.',
    `schedule_date` DATE COMMENT 'The specific date for which this housekeeping schedule is defined. Used for daily operational planning.',
    `schedule_status` STRING COMMENT 'The current lifecycle status of the housekeeping schedule (draft, published, active, completed, or cancelled).. Valid values are `draft|published|active|completed|cancelled`',
    `section_code` STRING COMMENT 'The housekeeping section or zone code assigned for this schedule (e.g., floor grouping, wing, building). Used for section-to-attendant assignment.',
    `section_credit_value` DECIMAL(18,2) COMMENT 'The total credit value assigned to the section, representing the workload complexity (e.g., suite rooms may have higher credit values than standard rooms).',
    `section_room_count` STRING COMMENT 'The total number of rooms in the assigned housekeeping section.',
    `shift_end_time` TIMESTAMP COMMENT 'The scheduled end time for the housekeeping shift on the schedule date.',
    `shift_start_time` TIMESTAMP COMMENT 'The scheduled start time for the housekeeping shift on the schedule date.',
    `shift_type` STRING COMMENT 'The type of housekeeping shift being scheduled (AM morning shift, PM afternoon shift, overnight night shift, or split shift).. Valid values are `AM|PM|overnight|split`',
    `turndown_end_time` TIMESTAMP COMMENT 'The scheduled end time for turndown service during this shift. Nullable if turndown service is not scheduled.',
    `turndown_service_flag` BOOLEAN COMMENT 'Indicates whether turndown service is scheduled for this shift (True if turndown service is included, False otherwise).',
    `turndown_start_time` TIMESTAMP COMMENT 'The scheduled start time for turndown service during this shift. Nullable if turndown service is not scheduled.',
    CONSTRAINT pk_hk_schedule PRIMARY KEY(`hk_schedule_id`)
) COMMENT 'Master record of housekeeping operational scheduling at the property level, defining daily shift structures (AM/PM/overnight with start/end times and break windows), weekly section-to-attendant assignments (based on seniority bidding or rotation), and staffing levels calibrated to occupancy forecast tiers. Captures planned headcount per shift, section configurations (floor/zone groupings with room counts and credit values), turndown service windows, and shift-level labor budgets aligned to CPOR targets. Used for labor planning, union CBA scheduling compliance (consecutive days, overtime thresholds), and PIP staffing requirements. Deep clean rotation scheduling is managed separately in deep_clean_plan.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` (
    `attendant_id` BIGINT COMMENT 'Unique identifier for the housekeeping attendant record. Primary key for the attendant entity in the housekeeping domain.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Hotel labor cost reporting requires each attendant to be assigned to a cost center for payroll allocation and USALI Rooms department labor expense tracking. This is a standard HR/finance integration i',
    `property_id` BIGINT COMMENT 'Reference to the property where this attendant is primarily assigned. Supports multi-property workforce management.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Service cases about housekeeping quality need to track responsible attendant for accountability. Real business process: Performance management, coaching, and progressive discipline based on guest comp',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: Housekeeping attendants are often assigned exclusively to spa facilities requiring specialized training (chemical handling, sanitation protocols). Linking attendant to spa_facility enables spa-specifi',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this attendant record is currently active and available for scheduling and room assignments. Inactive records are retained for historical reporting but excluded from operational workflows.',
    `ada_accommodation_flag` BOOLEAN COMMENT 'Indicates whether the attendant has an approved reasonable accommodation under the Americans with Disabilities Act. Accommodations may include modified duty assignments, assistive equipment, or adjusted productivity targets. Details of specific accommodations are maintained in confidential HR records.',
    `attendance_points` STRING COMMENT 'Current attendance point balance under the propertys attendance policy. Points are typically assigned for absences, tardiness, and early departures, with progressive discipline triggered at defined thresholds. Points may expire after a rolling period (e.g., 12 months).',
    `attendant_code` STRING COMMENT 'Business identifier for the attendant used in daily operations, room assignment sheets, and housekeeping reports. Typically a short alphanumeric code displayed on badges and mobile devices.. Valid values are `^[A-Z0-9]{4,12}$`',
    `average_credits_per_shift` DECIMAL(18,2) COMMENT 'Rolling average of actual room credits completed per shift over the most recent evaluation period (typically 30 or 90 days). Used to track individual productivity trends and identify training needs or performance issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this attendant record was first created in the housekeeping system. Used for audit trail and data lineage tracking.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of workplace emergency or injury. Maintained for employee safety and OSHA compliance.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person. Critical for rapid communication in case of workplace accidents or medical emergencies.',
    `employment_status` STRING COMMENT 'Current employment lifecycle status of the attendant. Active attendants are available for scheduling. On-leave includes FMLA, medical, and personal leave. Seasonal workers are employed during peak periods. Probationary status applies to new hires during their initial evaluation period.. Valid values are `active|on_leave|suspended|terminated|seasonal|probationary`',
    `hire_date` DATE COMMENT 'Date the attendant was hired into the housekeeping department. Used to calculate seniority for union section bidding, vacation accrual, and tenure-based benefits.',
    `language_skills` STRING COMMENT 'Comma-separated list of languages the attendant can speak and understand. Important for guest interaction, safety communication, and team coordination in multilingual properties. Format: ISO 639-1 language codes (e.g., en,es,fr).',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review. Most properties conduct annual or semi-annual reviews aligned with merit increase cycles.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this attendant record was most recently modified. Tracks the recency of data for change data capture and incremental processing.',
    `locker_number` STRING COMMENT 'Assigned locker number in the employee locker room where the attendant stores personal belongings, uniform, and equipment during their shift.',
    `mobile_device_code` STRING COMMENT 'Identifier of the mobile device (smartphone or tablet) assigned to the attendant for receiving room assignments, updating room status, reporting maintenance issues, and communicating with supervisors. Integrates with property management system mobile housekeeping applications.',
    `notes` STRING COMMENT 'Free-text field for operational notes about the attendant, such as special skills, assignment preferences, equipment needs, or temporary restrictions. Used by supervisors for day-to-day workforce management.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the attendant. Based on quality inspections, productivity metrics, guest feedback, attendance, and adherence to standards. Used for merit increases, promotion decisions, and performance improvement plans.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `role_type` STRING COMMENT 'Primary housekeeping role classification. Determines work assignment types, productivity benchmarks, and labor cost allocation. Room attendants clean guest rooms, turndown attendants provide evening service, house persons handle heavy cleaning and linen transport, supervisors oversee sections, inspectors perform quality checks, and public area cleaners maintain lobbies and common spaces.. Valid values are `room_attendant|turndown_attendant|house_person|supervisor|inspector|public_area_cleaner`',
    `section_assignment` STRING COMMENT 'Current section or floor assignment within the property. Sections are typically organized by floor, wing, or building. Section assignments may be permanent (based on seniority bidding) or rotational.',
    `seniority_date` DATE COMMENT 'Date used for calculating seniority ranking within the housekeeping department. May differ from hire date due to transfers, breaks in service, or union contract provisions. Critical for section bidding rights and shift preference allocation.',
    `shift_assignment` STRING COMMENT 'Current shift assignment for the attendant. AM shift typically covers morning checkout cleaning, PM shift handles afternoon turnovers and turndown service, night shift performs deep cleaning and public area maintenance. Split shifts cover peak periods. On-call attendants fill in for absences.. Valid values are `am_shift|pm_shift|night_shift|split_shift|on_call|rotating`',
    `target_credits_per_shift` DECIMAL(18,2) COMMENT 'Productivity benchmark expressed as the target number of room credits the attendant should complete per shift. Room credits vary by room type: standard rooms = 1.0 credit, suites = 1.5-2.0 credits, checkout rooms = 1.2 credits, stayover rooms = 0.7 credits. Used for performance evaluation and labor cost per occupied room (CPOR) calculation.',
    `termination_date` DATE COMMENT 'Date the attendants employment ended. Null for active employees. Used for historical workforce analysis and rehire eligibility determination.',
    `uniform_size` STRING COMMENT 'Uniform size for the attendant used for ordering and inventory management of housekeeping uniforms. Format varies by property (e.g., S/M/L/XL or numeric sizing).',
    `union_classification` STRING COMMENT 'Union job classification code as defined in the collective bargaining agreement. Determines pay grade, work rules, and assignment restrictions. Examples include classifications for different room types, shift differentials, and specialized duties.',
    `union_member_flag` BOOLEAN COMMENT 'Indicates whether the attendant is a member of a labor union. Determines applicability of collective bargaining agreement provisions, grievance procedures, and union-specific benefits.',
    CONSTRAINT pk_attendant PRIMARY KEY(`attendant_id`)
) COMMENT 'Housekeeping-domain operational profile of a room attendant or housekeeping staff member, capturing their role (room attendant, turndown attendant, house person, supervisor, inspector, public area cleaner), section certifications (suite-qualified, VIP-certified), language skills, productivity benchmarks (target credits per shift by room type mix), seniority date for union section bidding, union membership status and CBA classification, training completion records for chemical handling and blood-borne pathogen protocols, and current shift assignment status. This is a domain-specific operational view — the full employee master record (payroll, benefits, personal details) is owned by the workforce domain.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` (
    `linen_management_id` BIGINT COMMENT 'Primary key for linen_management',
    `attendant_id` BIGINT COMMENT 'Identifier of the housekeeping staff member who performed or recorded the linen transaction.',
    `banquet_event_order_id` BIGINT COMMENT 'Foreign key linking to fnb.banquet_event_order. Business justification: Banquet linen pulls (tablecloths, napkins, skirting) are allocated per BEO. Linking linen_management to banquet_event_order enables post-event linen reconciliation, cost attribution per event, and lin',
    `beo_id` BIGINT COMMENT 'Foreign key linking to event.beo. Business justification: BEOs specify linen color, style, and quantity requirements per function. Linen management transactions are executed against BEO specifications for setup. Direct link enables BEO-driven linen pull work',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: Banquet linen (tablecloths, napkins, chair covers, skirting) is pulled, tracked, and billed against event bookings. Direct link enables event-level linen cost allocation, loss tracking, and supports c',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Linen transactions (issuance to floors, returns, discards) are associated with specific housekeeping assignments. This links linen inventory movements to operational context. Many linen transactions c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Linen transactions (purchases, transfers, discards) must be allocated to departmental cost centers for USALI operating expense reporting, inventory valuation, and departmental cost control of linen pr',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the linen transaction occurred.',
    `property_outlet_id` BIGINT COMMENT 'Foreign key linking to property.property_outlet. Business justification: Restaurant and bar outlets consume linens (tablecloths, napkins) tracked through linen_management. F&B and HK managers jointly manage outlet linen par levels and costs. A proper FK to property_outlet ',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Linen par-level tracking and loss prevention reporting require room-level linen transaction records. room_number on linen_management is a denormalization of inventory.room. Housekeeping managers expec',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Spa treatment rooms consume linens (massage sheets, towels, robes, blankets) tracked through hotel linen inventory for par level management, cost allocation, and laundry vendor billing managed by hous',
    `approval_status` STRING COMMENT 'Approval workflow status for high-value or exception transactions (discards, adjustments, transfers). Pending, approved, or rejected.. Valid values are `pending|approved|rejected`',
    `approved_by` BIGINT COMMENT 'Identifier of the manager or supervisor who approved the transaction in the workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was approved in the workflow.',
    `batch_number` STRING COMMENT 'Laundry batch or load number for items returned from external or internal laundry processing. Enables traceability.',
    `condition_grade` STRING COMMENT 'Quality condition assessment of the linen at time of transaction (new, excellent, good, fair, poor, damaged). Used for loss and shrinkage analysis.. Valid values are `new|excellent|good|fair|poor|damaged`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the linen transaction record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `destination_location` STRING COMMENT 'Target location of the linen movement (e.g., Floor 5 Linen Closet, Laundry for soiled returns, Discard Bin).',
    `discard_reason` STRING COMMENT 'Reason code for linen discard transactions (stained, torn, worn out, burned, lost, stolen, contaminated, expired). Used for loss and shrinkage root-cause analysis. [ENUM-REF-CANDIDATE: stained|torn|worn|burned|lost|stolen|contaminated|expired — 8 candidates stripped; promote to reference product]',
    `floor_number` STRING COMMENT 'Floor or level identifier where linen was issued to or returned from. Null for central laundry transactions.',
    `is_voided` BOOLEAN COMMENT 'Indicates whether the transaction has been voided or reversed. True if voided, False if active.',
    `item_code` STRING COMMENT 'Standardized SKU or item code for the specific linen product (e.g., size, quality grade, supplier code).. Valid values are `^[A-Z]{3}-[0-9]{4}$`',
    `item_description` STRING COMMENT 'Detailed description of the linen item including size, material, color, and quality specifications.',
    `item_type` STRING COMMENT 'Category of linen or terry item involved in the transaction (sheets, pillowcases, bath towels, hand towels, washcloths, bathrobes, pool towels, blankets, mattress pads, table linens). [ENUM-REF-CANDIDATE: sheet|pillowcase|duvet_cover|bath_towel|hand_towel|washcloth|bathrobe|pool_towel|blanket|mattress_pad|table_linen — 11 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the linen transaction record was last modified in the data platform.',
    `notes` STRING COMMENT 'Free-text notes or comments about the linen transaction for audit trail and operational context.',
    `par_level_after` STRING COMMENT 'Inventory par level for this item type at the location after the transaction. Enables variance analysis.',
    `par_level_before` STRING COMMENT 'Inventory par level for this item type at the location before the transaction. Used for par-level compliance tracking.',
    `purchase_order_number` STRING COMMENT 'Purchase order number for linen procurement transactions. Links to procurement system for three-way match.',
    `quantity` STRING COMMENT 'Number of linen units involved in the transaction. Positive for receipts/returns, negative for issuances/discards.',
    `section_code` STRING COMMENT 'Housekeeping section or zone code within the floor (e.g., North Wing, South Wing, Tower A). Used for par-level tracking by section.',
    `shift` STRING COMMENT 'Housekeeping shift during which the linen transaction occurred (AM, PM, or Night shift).. Valid values are `AM|PM|Night`',
    `source_location` STRING COMMENT 'Origin location of the linen movement (e.g., Central Laundry, Floor 3 Linen Closet, Property B for transfers).',
    `source_system` STRING COMMENT 'Name of the operational system that originated the transaction record (e.g., Oracle OPERA PMS, SAP MM, Internal Housekeeping App).',
    `source_system_code` STRING COMMENT 'Unique identifier of the transaction in the source operational system for reconciliation and traceability.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the transaction (quantity × unit_cost). Used for housekeeping expense tracking and CPOR analysis.',
    `transaction_date` DATE COMMENT 'Business date of the linen transaction for daily operational reporting and CPOR (Cost Per Occupied Room) calculation.',
    `transaction_number` STRING COMMENT 'Business-readable unique transaction number for linen movement tracking and audit trail.. Valid values are `^LIN-[0-9]{10}$`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the linen transaction was recorded in the system.',
    `transaction_type` STRING COMMENT 'Type of linen inventory movement: issuance to floors, return to laundry, discard due to damage, par-level adjustment, inter-property transfer, or new purchase receipt.. Valid values are `issuance|return|discard|adjustment|transfer|purchase`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the linen item at time of transaction. Used for CPOR (Cost Per Occupied Room) calculation and inventory valuation.',
    `unit_of_measure` STRING COMMENT 'Unit in which linen quantity is measured (piece, set, dozen, pound, kilogram).. Valid values are `piece|set|dozen|pound|kilogram`',
    `void_reason` STRING COMMENT 'Explanation for why the transaction was voided. Null if not voided.',
    `voided_by` BIGINT COMMENT 'Identifier of the user who voided the transaction. Null if not voided.',
    `voided_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was voided. Null if not voided.',
    CONSTRAINT pk_linen_management PRIMARY KEY(`linen_management_id`)
) COMMENT 'Transactional record of linen and terry inventory movements including issuance to floors, returns to laundry, discards, par-level adjustments, and inter-property transfers. Captures item type (sheets, pillowcases, bath towels, hand towels, washcloths, bathrobes, pool towels), quantity, movement type, floor/section, shift, condition grade, and cost per unit. Enables linen consumption tracking, loss/shrinkage analysis, par-level compliance, and CPOR calculation for linen and laundry expenses.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` (
    `supply_consumption_id` BIGINT COMMENT 'Unique identifier for the supply consumption transaction record.',
    `amenity_fulfillment_id` BIGINT COMMENT 'Foreign key linking to experience.amenity_fulfillment. Business justification: Amenity fulfillment (experience domain) physically consumes housekeeping supplies. Linking these supports amenity cost reconciliation, inventory variance analysis, and sustainability reporting — hotel',
    `beo_id` BIGINT COMMENT 'Foreign key linking to event.beo. Business justification: BEOs specify amenity placement and supply requirements for each event function. Supply consumption is executed against BEO specifications. Direct link enables BEO-level supply cost tracking, variance ',
    `cleaning_task_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_task. Business justification: Supply consumption occurs during specific cleaning tasks (e.g., amenity replenishment, chemical usage). This links supply usage to the granular task level for accurate CPOR tracking. Many supply consu',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: USALI departmental expense reporting requires supply/amenity consumption costs to be allocated to specific cost centers (Rooms, Housekeeping). The existing cost_center_code is a denormalized string;',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: Amenity and cleaning supply consumption for event function spaces and group room blocks is allocated against event bookings for cost accounting and client billing. Direct link enables per-event supply',
    `experience_special_request_id` BIGINT COMMENT 'Foreign key linking to experience.experience_special_request. Business justification: Guest special requests for extra amenities (pillows, toiletries, cribs) directly drive supply consumption records. Linking these enables cost-per-request reporting, fulfillment cost tracking, and amen',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: USALI departmental expense reporting requires supply consumption costs to be allocated to fiscal periods for month-end close and budget variance analysis. Linking supply_consumption to fiscal_period e',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Cleaning supplies consumed in F&B outlet areas (dining rooms, bars, kitchens) must be attributed to the outlet cost center for USALI departmental expense reporting. Linking supply_consumption to fnb_o',
    `hk_assignment_id` BIGINT COMMENT 'Identifier of the housekeeping work assignment during which the supplies were consumed.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Amenity consumption patterns by guest segment, VIP tier, loyalty status drive personalized amenity allocation and cost-per-guest profitability analysis. Business intelligence process requires profile ',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Facility-specific supply consumption (pool chemicals, gym cleaning supplies, spa amenities) must be tracked at the facility level for cost center allocation and sustainability reporting. Facilities ma',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the supply consumption occurred.',
    `room_amenity_id` BIGINT COMMENT 'Foreign key linking to inventory.room_amenity. Business justification: Amenity replenishment cost tracking and sustainability certification reporting require supply consumption records to reference the specific room_amenity SKU. amenity_type is a denormalization of inven',
    `room_id` BIGINT COMMENT 'Identifier of the specific guest room where supplies were consumed.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Supply cost budgeting and PAR level management by room type is a standard hospitality procurement process. room_type_code on supply_consumption is a denormalization of inventory.room_type. Direct FK e',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.segment. Business justification: Segment-Level Supply Cost Analysis: revenue and operations teams report amenity consumption costs by guest segment to optimize par levels and pricing. guest_segment is a denormalized code replaced by ',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to spa.appointment. Business justification: Supply consumption in treatment rooms (specialty linens, amenity kits, sanitation supplies) can be attributed to specific appointments for per-appointment cost tracking and supply forecasting. supply_',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Spa treatment rooms consume housekeeping supplies (cleaning chemicals, disinfectants, paper products, guest amenities) tracked for cost center allocation, budget variance analysis, and inventory reple',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Per-Stay Amenity Consumption Reporting: revenue managers and loyalty analysts correlate amenity supply costs directly to completed stays for CPOR (cost per occupied room) reporting and loyalty tier co',
    `batch_number` STRING COMMENT 'The batch or lot number of the supply item for traceability and quality control purposes.',
    `charge_amount` DECIMAL(18,2) COMMENT 'The amount charged to the guest folio for this supply consumption, if applicable.',
    `consumption_date` DATE COMMENT 'The calendar date on which the supply consumption occurred.',
    `consumption_reason` STRING COMMENT 'The business reason for the supply consumption (standard service, guest request, damage replacement, quality issue, special event).. Valid values are `STANDARD_SERVICE|GUEST_REQUEST|DAMAGE_REPLACEMENT|QUALITY_ISSUE|SPECIAL_EVENT`',
    `consumption_timestamp` TIMESTAMP COMMENT 'The precise date and time when the supply consumption was recorded in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amounts.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'The expiration date of the supply item, particularly relevant for perishable amenities and toiletries.',
    `gl_account_code` STRING COMMENT 'The general ledger account code for recording the supply expense.',
    `guest_charged_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the guest was charged for this supply consumption (e.g., minibar items, premium amenities).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the supply consumption event, special circumstances, or quality issues.',
    `occupancy_status` STRING COMMENT 'The occupancy status of the room at the time of supply consumption (occupied, vacant, checkout, stayover).. Valid values are `OCCUPIED|VACANT|CHECKOUT|STAYOVER`',
    `par_level` DECIMAL(18,2) COMMENT 'The standard par level (target inventory quantity) for this supply item in the room type.',
    `quality_grade` STRING COMMENT 'The quality grade classification of the supply item (premium, standard, economy, luxury).. Valid values are `PREMIUM|STANDARD|ECONOMY|LUXURY`',
    `quantity_consumed` DECIMAL(18,2) COMMENT 'The numeric quantity of the supply item consumed during this transaction.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this supply consumption record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this supply consumption record was last modified in the system.',
    `reorder_triggered` BOOLEAN COMMENT 'Boolean flag indicating whether this consumption event triggered an automatic reorder workflow in procurement.',
    `replenishment_action` STRING COMMENT 'The type of replenishment action taken by housekeeping staff (full restock, partial restock, no action, special request).. Valid values are `FULL_RESTOCK|PARTIAL_RESTOCK|NO_ACTION|SPECIAL_REQUEST`',
    `replenishment_quantity` DECIMAL(18,2) COMMENT 'The quantity of the supply item replenished to the room after consumption.',
    `shift_code` STRING COMMENT 'The housekeeping shift during which the supply consumption occurred (AM, PM, NIGHT, SWING).. Valid values are `AM|PM|NIGHT|SWING`',
    `source_system` STRING COMMENT 'The operational system from which this supply consumption record originated (Oracle OPERA PMS, MICROS POS, SAP MM, manual entry).. Valid values are `OPERA_PMS|MICROS_POS|SAP_MM|MANUAL_ENTRY`',
    `sustainability_certified` BOOLEAN COMMENT 'Boolean flag indicating whether the supply item carries environmental or sustainability certification.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the supply consumption calculated as quantity consumed multiplied by unit cost.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the supply item at the time of consumption.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the consumed quantity (each, box, case, bottle, roll, set, pair, ounce, liter). [ENUM-REF-CANDIDATE: EACH|BOX|CASE|BOTTLE|ROLL|SET|PAIR|OUNCE|LITER — 9 candidates stripped; promote to reference product]',
    `variance_from_par` DECIMAL(18,2) COMMENT 'The variance between actual consumption and the expected par level consumption.',
    `waste_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the consumption represents waste or spoilage rather than normal usage.',
    CONSTRAINT pk_supply_consumption PRIMARY KEY(`supply_consumption_id`)
) COMMENT 'Transactional record of guest room supply and amenity consumption by room and shift, including amenity type (toiletries, coffee supplies, stationery, in-room collateral), quantity consumed, unit cost, and replenishment action taken. Supports CPOR tracking for supplies and amenities, enables consumption benchmarking by room type and occupancy segment, and feeds procurement reorder workflows.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` (
    `lost_and_found_id` BIGINT COMMENT 'Unique identifier for the lost and found record. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Guests leave personal items in F&B outlets (restaurants, bars, banquet halls). Housekeeping and F&B staff log these with the specific outlet as discovery location for guest retrieval and liability tra',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Lost and found items are discovered during specific housekeeping assignments. This links item discovery to the operational context (who found it, when, during which room service). Many lost items can ',
    `identity_document_id` BIGINT COMMENT 'Foreign key linking to guest.identity_document. Business justification: Lost & Found Claim Identity Verification process: when a guest claims a high-value item, the verified identity_document record is linked to the claim for regulatory compliance and dispute resolution. ',
    `profile_id` BIGINT COMMENT 'Identifier of the guest associated with the room or area where the item was found, if known.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the item was discovered.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Lost item guest notification process: when housekeeping discovers a lost item, the hotel must link it to the specific reservation booking to contact the departed guest, process shipping charges, and r',
    `room_id` BIGINT COMMENT 'Identifier of the specific room where the item was found, if applicable.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Lost item inquiries generate service cases for tracking and resolution. Real business process: Guest property recovery workflow, service recovery when items cannot be located, and compensation decisio',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to spa.appointment. Business justification: Lost items are tied to specific spa appointments for guest identification, contact, and return coordination. Appointment context enables efficient guest notification and item matching in lost & found ',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Guests frequently leave personal items in spa treatment rooms. Spa staff log these in hotel-wide lost & found system managed by housekeeping operations for guest retrieval and liability tracking.',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Items found during specific stays need stay context for accurate guest notification, claim validation, and shipping coordination. Lost item recovery workflow depends on stay-level detail (dates, room,',
    `claim_date` DATE COMMENT 'Date when the item was claimed by the guest or authorized party.',
    `claim_status` STRING COMMENT 'Status of the claim process indicating whether the item has been claimed by a guest or remains unclaimed.. Valid values are `unclaimed|claim_pending|claimed|claim_denied`',
    `claimant_identification_number` STRING COMMENT 'Identification document number presented by the claimant for audit trail and verification.',
    `claimant_identification_type` STRING COMMENT 'Type of identification document presented by the claimant for verification purposes.. Valid values are `drivers_license|passport|national_id|employee_badge|other`',
    `claimant_name` STRING COMMENT 'Full name of the person who claimed the item, which may differ from the original guest if authorized representative.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lost and found record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value amount.. Valid values are `^[A-Z]{3}$`',
    `discovery_date` DATE COMMENT 'Date when the item was discovered by staff.',
    `discovery_location_detail` STRING COMMENT 'Specific location details within the location type (e.g., under bed, in closet, on table) to aid in verification during claim process.',
    `discovery_location_type` STRING COMMENT 'Type of location where the item was discovered. [ENUM-REF-CANDIDATE: guest_room|public_area|restaurant|meeting_room|fitness_center|pool|parking|lobby|other — 9 candidates stripped; promote to reference product]',
    `discovery_timestamp` TIMESTAMP COMMENT 'Precise date and time when the item was discovered and logged into the lost and found system.',
    `disposition_date` DATE COMMENT 'Date when the final disposition action was completed.',
    `disposition_notes` STRING COMMENT 'Additional notes regarding the disposition action including recipient organization for donations or authority contact for turned-over items.',
    `disposition_type` STRING COMMENT 'Final disposition action taken for the item after the retention period or claim resolution.. Valid values are `returned_to_guest|donated|discarded|turned_over_to_authorities|shipped_to_guest|pending`',
    `estimated_value_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of the item in the propertys base currency for liability and insurance purposes.',
    `guest_notification_date` DATE COMMENT 'Date when the guest was successfully notified about the found item.',
    `guest_notification_method` STRING COMMENT 'Communication channel used to notify the guest about the found item.. Valid values are `email|phone|sms|mail|in_person`',
    `guest_notification_status` STRING COMMENT 'Status of attempts to notify the guest about the discovered item.. Valid values are `not_attempted|attempted|notified|unable_to_contact`',
    `is_high_value_item` BOOLEAN COMMENT 'Flag indicating whether the item exceeds the propertys high-value threshold requiring special handling and management approval.',
    `item_brand` STRING COMMENT 'Brand or manufacturer name of the item, if identifiable.',
    `item_category` STRING COMMENT 'High-level classification of the lost item type for inventory and reporting purposes. [ENUM-REF-CANDIDATE: electronics|jewelry|clothing|documents|keys|wallet|luggage|personal_care|other — 9 candidates stripped; promote to reference product]',
    `item_color` STRING COMMENT 'Primary color of the item for identification purposes.',
    `item_description` STRING COMMENT 'Detailed textual description of the lost item including brand, color, size, distinguishing features, and condition at time of discovery.',
    `item_number` STRING COMMENT 'Externally-visible unique tracking number assigned to the lost and found item for guest reference and claim processing.. Valid values are `^LF-[0-9]{8}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lost and found record was last updated.',
    `lost_and_found_status` STRING COMMENT 'Current lifecycle status of the lost and found item tracking its progression from discovery through final disposition. [ENUM-REF-CANDIDATE: logged|guest_notified|claimed|pending_disposition|returned_to_guest|donated|discarded|turned_over_to_authorities — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'General notes and comments regarding the item, discovery circumstances, guest interactions, or special considerations.',
    `photo_url` STRING COMMENT 'URL or file path to photograph of the item for identification and verification purposes.',
    `requires_special_handling` BOOLEAN COMMENT 'Flag indicating whether the item requires special storage conditions or handling procedures (e.g., refrigeration, secure vault).',
    `retention_expiry_date` DATE COMMENT 'Date when the retention period expires and the item becomes eligible for disposition.',
    `retention_period_days` STRING COMMENT 'Number of days the item must be retained before disposition per property policy and local regulations.',
    `shipping_cost_amount` DECIMAL(18,2) COMMENT 'Cost charged to the guest for shipping the item to their location.',
    `shipping_tracking_number` STRING COMMENT 'Carrier tracking number if the item was shipped to the guest at their request.',
    `special_handling_instructions` STRING COMMENT 'Specific instructions for handling, storing, or preserving the item.',
    `storage_location` STRING COMMENT 'Secure storage location identifier where the item is being held (e.g., safe number, locker ID, storage room shelf).',
    CONSTRAINT pk_lost_and_found PRIMARY KEY(`lost_and_found_id`)
) COMMENT 'Operational record of lost and found items discovered during room cleaning or public area maintenance. Captures item description, category, estimated value, discovery location, discovery date/time, finder (attendant) identity, secure storage location, guest notification status, claim status, claim date, disposition (returned/donated/discarded/turned over to authorities), and retention period compliance. Supports guest service recovery, property liability management, and jurisdictional unclaimed property regulations.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` (
    `cleaning_standard_id` BIGINT COMMENT 'Unique identifier for the cleaning standard configuration. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand compliance reporting requires cleaning standards to be formally linked to a brand. Brand managers define and audit cleaning protocols per brand (e.g., Waldorf vs. Hampton). brand_tier is a denor',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Brand standards and PIP compliance require segment-differentiated cleaning protocols: luxury transient guests receive different amenity placement, linen change frequency, and inspection thresholds tha',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Tier-based room preparation: housekeeping applies distinct cleaning standards (amenity placement, linen protocols, welcome gifts) per loyalty tier. Operations and brand compliance teams report on tier',
    `amenity_items_list` STRING COMMENT 'Comma-separated or structured list of amenity items to be placed (e.g., shampoo, conditioner, body lotion, soap, dental kit, sewing kit, coffee pods, bottled water). Varies by brand tier and guest segment.',
    `amenity_placement_instructions` STRING COMMENT 'Detailed instructions for amenity item placement and presentation (e.g., toiletries arrangement, towel folding style, welcome card positioning, turndown chocolate placement). Ensures brand consistency and guest experience quality.',
    `approval_date` DATE COMMENT 'Date this cleaning standard was approved for operational use. Required for compliance audit trail.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this cleaning standard (e.g., Director of Housekeeping, Brand Standards Manager). Required for brand compliance and audit trail.',
    `brand_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether this standard is mandatory for brand compliance audits. True if required for franchise/brand certification. Non-compliance may result in brand penalties.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether attendants must complete certification training before executing this standard. True for specialized standards (e.g., deep clean, hazardous material handling, luxury suite service).',
    `chemical_product_specifications` STRING COMMENT 'Approved cleaning chemical products and usage instructions (e.g., all-purpose cleaner brand/dilution, glass cleaner, bathroom sanitizer, disinfectant contact time). Ensures safety compliance and brand standards.',
    `cleaning_standard_status` STRING COMMENT 'Current lifecycle status of the cleaning standard: active (in use), inactive (temporarily disabled), draft (under development), archived (historical record).. Valid values are `active|inactive|draft|archived`',
    `cleaning_type` STRING COMMENT 'Type of cleaning service this standard defines: stayover (occupied room daily service), departure (checkout deep clean), deep_clean (periodic intensive cleaning), turndown (evening service), public_area (lobby/corridor/amenity spaces), refresh (quick tidy between same-day checkouts).. Valid values are `stayover|departure|deep_clean|turndown|public_area|refresh`',
    `cost_per_execution_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost in USD to execute this cleaning standard once, including labor, supplies, and equipment depreciation. Used for CPOR (Cost Per Occupied Room) budgeting and variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cleaning standard record was first created in the system. Audit trail field.',
    `effective_date` DATE COMMENT 'Date this cleaning standard becomes active and enforceable. Used for seasonal standard changes and brand compliance rollouts.',
    `equipment_required` STRING COMMENT 'List of equipment and tools required to execute this standard (e.g., vacuum cleaner, microfiber cloths, mop, caddy, UV sanitizer). Used for attendant assignment and equipment allocation.',
    `expiration_date` DATE COMMENT 'Date this cleaning standard is no longer valid. Null for indefinite standards. Used for seasonal or promotional service upgrades.',
    `inspection_pass_threshold_score` DECIMAL(18,2) COMMENT 'Minimum quality inspection score (0-100 scale) required to pass this cleaning standard. Rooms scoring below threshold require re-cleaning. Typical luxury threshold: 95+, select service: 85+.',
    `labor_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated labor cost in USD for this cleaning standard execution, calculated as target_time_minutes multiplied by average hourly wage. Primary component of CPOR.',
    `last_review_date` DATE COMMENT 'Date this cleaning standard was last reviewed for accuracy and relevance. Standards should be reviewed annually or when brand requirements change.',
    `linen_change_frequency_days` STRING COMMENT 'Number of days between scheduled linen changes when protocol is every_n_days. Null for other protocols. Typical values: 2-3 for luxury, 3-5 for select service.',
    `linen_change_protocol` STRING COMMENT 'Linen replacement policy for this standard: full_change (all linens replaced), on_request (guest opt-in), every_n_days (scheduled rotation), departure_only (checkout only). Impacts sustainability metrics and laundry costs.. Valid values are `full_change|on_request|every_n_days|departure_only`',
    `maximum_time_minutes` STRING COMMENT 'Maximum allowable time in minutes for this cleaning standard. Exceeding this threshold triggers supervisor review and quality audit.',
    `minimum_time_minutes` STRING COMMENT 'Minimum time allocation in minutes required to complete this cleaning standard. Used for labor scheduling, productivity tracking, and CPOR (Cost Per Occupied Room) calculation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cleaning standard record was last modified. Audit trail field for change tracking.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this cleaning standard. Used for governance and continuous improvement workflows.',
    `notes` STRING COMMENT 'Free-text notes for additional context, historical changes, or operational guidance not captured in structured fields.',
    `quality_inspection_criteria` STRING COMMENT 'Structured quality inspection checklist and scoring rubric (e.g., cleanliness score, amenity placement accuracy, linen presentation, bathroom sanitation). Used by supervisors and quality auditors to validate standard compliance.',
    `special_instructions` STRING COMMENT 'Additional notes or special handling requirements (e.g., allergy-friendly cleaning for sensitive guests, pet-friendly room protocols, post-construction deep clean procedures).',
    `standard_code` STRING COMMENT 'Business identifier code for the cleaning standard (e.g., STY_LUX_SUITE, DEP_STD_KING, DEEP_PREM_DBL). Used for operational reference and system integration.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `standard_name` STRING COMMENT 'Human-readable name of the cleaning standard (e.g., Luxury Suite Stayover Service, Premium Departure Clean).',
    `supply_consumption_estimate` STRING COMMENT 'Estimated quantity of consumable supplies per cleaning execution (e.g., 2 trash bags, 1 toilet paper roll, 50ml all-purpose cleaner). Used for inventory forecasting and CPOR calculation.',
    `supply_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated consumable supply cost in USD per execution (chemicals, amenities, linens, trash bags). Used for inventory budgeting and CPOR calculation.',
    `sustainability_compliance_flag` BOOLEAN COMMENT 'Indicates whether this standard meets corporate sustainability and environmental compliance requirements (e.g., eco-friendly chemicals, linen reuse program, water conservation). True if compliant.',
    `target_time_minutes` STRING COMMENT 'Target time in minutes for completing this cleaning standard under normal conditions. Used for performance benchmarking and efficiency KPIs.',
    `task_checklist` STRING COMMENT 'Structured list of required cleaning tasks in sequence (e.g., strip linens, dust surfaces, vacuum, sanitize bathroom, restock amenities). Stored as delimited text or JSON. Used to generate attendant mobile app checklists.',
    `training_module_reference` STRING COMMENT 'Reference to the training module or learning content that teaches this cleaning standard (e.g., LMS course ID, training video URL, SOP document number). Used for onboarding and certification.',
    `version_number` STRING COMMENT 'Version number of this cleaning standard configuration. Incremented when standard is updated. Supports audit trail and change management.',
    CONSTRAINT pk_cleaning_standard PRIMARY KEY(`cleaning_standard_id`)
) COMMENT 'Reference master defining standard operating procedures, quality benchmarks, and amenity placement configurations for each cleaning type (stayover, departure, deep clean, turndown, public area) and room type/guest segment combination. Includes required tasks checklist, minimum time allocation, amenity items and placement instructions, linen change protocol, chemical product specifications, brand tier requirements, loyalty tier upgrade amenities, and brand compliance standards. Used to configure cleaning task templates, drive quality inspection scoring, and generate attendant placement checklists.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_hk_schedule_id` FOREIGN KEY (`hk_schedule_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`hk_schedule`(`hk_schedule_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_hk_schedule_id` FOREIGN KEY (`hk_schedule_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`hk_schedule`(`hk_schedule_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_cleaning_task_id` FOREIGN KEY (`cleaning_task_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_task`(`cleaning_task_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`inspection`(`inspection_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_cleaning_task_id` FOREIGN KEY (`cleaning_task_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`cleaning_task`(`cleaning_task_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `travel_hospitality_ecm`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);

-- ========= TAGS =========
ALTER SCHEMA `travel_hospitality_ecm`.`housekeeping` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `travel_hospitality_ecm`.`housekeeping` SET TAGS ('dbx_domain' = 'housekeeping');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Assignment ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `amenity_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Amenity Fulfillment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Attendant ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `banquet_event_order_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Beo Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `experience_special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Special Request Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Schedule Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Note Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Room Service Order Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `service_recovery_action_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Appointment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `space_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Event Space Allocation Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `vip_designation_id` SET TAGS ('dbx_business_glossary_term' = 'Vip Designation Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `allergy_flags` SET TAGS ('dbx_business_glossary_term' = 'Allergy Flags');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `allergy_flags` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `amenity_replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amenity Replenishment Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'stayover|departure|deep_clean|turndown|vip_prep|inspection');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|completed|inspected|rejected|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `dnd_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Disturb (DND) Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `estimated_end_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated End Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `estimated_start_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Start Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `guest_preference_instructions` SET TAGS ('dbx_business_glossary_term' = 'Guest Preference Instructions');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `guest_preference_instructions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `linen_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Linen Change Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `maintenance_request_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Description');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `maintenance_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `preferred_service_time` SET TAGS ('dbx_business_glossary_term' = 'Preferred Service Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Count');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_credits` SET TAGS ('dbx_business_glossary_term' = 'Room Credits');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_status_after` SET TAGS ('dbx_business_glossary_term' = 'Room Status After');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_status_after` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|pickup|out_of_order|out_of_service');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_status_before` SET TAGS ('dbx_business_glossary_term' = 'Room Status Before');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_status_before` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|pickup|out_of_order|out_of_service');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `special_cleaning_code` SET TAGS ('dbx_business_glossary_term' = 'Special Cleaning Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_assignment` ALTER COLUMN `towel_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Towel Change Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `cleaning_task_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Task ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Attendant ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Beo Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Schedule Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `reservation_special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Special Request Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `service_recovery_action_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Task Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `credit_weight` SET TAGS ('dbx_business_glossary_term' = 'Credit Weight');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `guest_present` SET TAGS ('dbx_business_glossary_term' = 'Guest Present');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `guest_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Request Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `is_quality_checkpoint` SET TAGS ('dbx_business_glossary_term' = 'Is Quality Checkpoint');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `maintenance_request_generated` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Generated');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'checkout|stayover|arrival|deep_clean|turndown|refresh');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `skip_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Skip Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `skip_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `skip_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Skip Reason Description');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `standard_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Duration Minutes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `supply_item_code` SET TAGS ('dbx_business_glossary_term' = 'Supply Item Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `supply_item_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `supply_quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Supply Quantity Used');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `supply_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Supply Unit of Measure');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_code` SET TAGS ('dbx_business_glossary_term' = 'Task Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|rush');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_sequence` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|skipped|failed|exception');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'cleaning|sanitization|restocking|inspection|maintenance_prep|turndown');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_task` ALTER COLUMN `training_indicator` SET TAGS ('dbx_business_glossary_term' = 'Training Indicator');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` SET TAGS ('dbx_subdomain' = 'quality_inspection');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeper ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `banquet_event_order_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `cleaning_task_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Task Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `out_of_order_id` SET TAGS ('dbx_business_glossary_term' = 'Out Of Order Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `space_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Event Space Allocation Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `vip_designation_id` SET TAGS ('dbx_business_glossary_term' = 'Vip Designation Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `amenity_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Amenity Check Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `bathroom_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Bathroom Quality Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `cleanliness_score` SET TAGS ('dbx_business_glossary_term' = 'Cleanliness Score');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `critical_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Count');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `guest_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Guest Arrival Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|deep_clean|turndown|checkout|maintenance_follow_up|quality_audit');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `linen_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Linen Quality Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `maintenance_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Issue Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Inspection Priority Level');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `reclean_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Clean Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `room_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Room Release Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `room_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Room Release Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `room_status_after` SET TAGS ('dbx_business_glossary_term' = 'Room Status After Inspection');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `room_status_after` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|occupied|out_of_order|out_of_service');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `room_status_before` SET TAGS ('dbx_business_glossary_term' = 'Room Status Before Inspection');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `room_status_before` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|occupied|out_of_order|out_of_service');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `scheduled_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `special_request_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Request Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` SET TAGS ('dbx_subdomain' = 'quality_inspection');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `inspection_deficiency_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Deficiency ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `amenity_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Amenity Fulfillment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `inventory_control_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Control Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `actual_resolution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Time (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `blocks_room_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocks Room Sale Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_category` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Category');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_category` SET TAGS ('dbx_value_regex' = 'cleanliness|maintenance|amenity|linen|damage|safety');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_sequence` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Sequence Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Subcategory');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `estimated_resolution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Resolution Time (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `guest_impacting_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Impacting Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Identified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `inspector_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `location_detail` SET TAGS ('dbx_business_glossary_term' = 'Location Detail');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `photo_attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment URL');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `preventive_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Taken');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `recurring_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurring Deficiency Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Completed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Cost Amount');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Started Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|verified|closed|escalated');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'training|process|equipment|supply|staffing|vendor');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `root_cause_notes` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|cosmetic');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Schedule ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Group Block Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Strategy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'seniority_bidding|rotation|manager_assignment|fixed');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration in Minutes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `break_start_time` SET TAGS ('dbx_business_glossary_term' = 'Break Start Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `consecutive_days_worked` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Days Worked');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `cpor_target` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Occupied Room (CPOR) Target');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `cpor_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Threshold Hours');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `pip_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|active|completed|cancelled');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `section_code` SET TAGS ('dbx_business_glossary_term' = 'Section Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `section_credit_value` SET TAGS ('dbx_business_glossary_term' = 'Section Credit Value');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `section_room_count` SET TAGS ('dbx_business_glossary_term' = 'Section Room Count');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'AM|PM|overnight|split');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `turndown_end_time` SET TAGS ('dbx_business_glossary_term' = 'Turndown Service End Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `turndown_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Turndown Service Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`hk_schedule` ALTER COLUMN `turndown_start_time` SET TAGS ('dbx_business_glossary_term' = 'Turndown Service Start Time');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Attendant Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `ada_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Accommodation Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `attendance_points` SET TAGS ('dbx_business_glossary_term' = 'Attendance Points');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `attendant_code` SET TAGS ('dbx_business_glossary_term' = 'Attendant Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `attendant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `average_credits_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Average Credits Per Shift');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated|seasonal|probationary');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `language_skills` SET TAGS ('dbx_business_glossary_term' = 'Language Skills');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `locker_number` SET TAGS ('dbx_business_glossary_term' = 'Locker Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Attendant Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Attendant Role Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'room_attendant|turndown_attendant|house_person|supervisor|inspector|public_area_cleaner');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `section_assignment` SET TAGS ('dbx_business_glossary_term' = 'Section Assignment');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `seniority_date` SET TAGS ('dbx_business_glossary_term' = 'Seniority Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_value_regex' = 'am_shift|pm_shift|night_shift|split_shift|on_call|rotating');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `target_credits_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Target Credits Per Shift');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `uniform_size` SET TAGS ('dbx_business_glossary_term' = 'Uniform Size');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `union_classification` SET TAGS ('dbx_business_glossary_term' = 'Union Classification Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`attendant` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Member Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `linen_management_id` SET TAGS ('dbx_business_glossary_term' = 'Linen Management Identifier');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeper ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `banquet_event_order_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Beo Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Linen Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'new|excellent|good|fair|poor|damaged');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `discard_reason` SET TAGS ('dbx_business_glossary_term' = 'Discard Reason');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Linen Item Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `item_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Linen Item Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `par_level_after` SET TAGS ('dbx_business_glossary_term' = 'Par Level After Transaction');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `par_level_before` SET TAGS ('dbx_business_glossary_term' = 'Par Level Before Transaction');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `section_code` SET TAGS ('dbx_business_glossary_term' = 'Section Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'AM|PM|Night');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `source_location` SET TAGS ('dbx_business_glossary_term' = 'Source Location');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Linen Transaction Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^LIN-[0-9]{10}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'issuance|return|discard|adjustment|transfer|purchase');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'piece|set|dozen|pound|kilogram');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `voided_by` SET TAGS ('dbx_business_glossary_term' = 'Voided By Employee ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`linen_management` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Void Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `supply_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Consumption ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `amenity_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Amenity Fulfillment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Beo Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `cleaning_task_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Task Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `experience_special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Special Request Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Assignment ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Room Amenity Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Appointment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Consumption Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `consumption_reason` SET TAGS ('dbx_business_glossary_term' = 'Consumption Reason');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `consumption_reason` SET TAGS ('dbx_value_regex' = 'STANDARD_SERVICE|GUEST_REQUEST|DAMAGE_REPLACEMENT|QUALITY_ISSUE|SPECIAL_EVENT');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consumption Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `guest_charged_indicator` SET TAGS ('dbx_business_glossary_term' = 'Guest Charged Indicator');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'OCCUPIED|VACANT|CHECKOUT|STAYOVER');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'PREMIUM|STANDARD|ECONOMY|LUXURY');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `reorder_triggered` SET TAGS ('dbx_business_glossary_term' = 'Reorder Triggered');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `replenishment_action` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Action');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `replenishment_action` SET TAGS ('dbx_value_regex' = 'FULL_RESTOCK|PARTIAL_RESTOCK|NO_ACTION|SPECIAL_REQUEST');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `replenishment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Quantity');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'AM|PM|NIGHT|SWING');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'OPERA_PMS|MICROS_POS|SAP_MM|MANUAL_ENTRY');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `sustainability_certified` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `variance_from_par` SET TAGS ('dbx_business_glossary_term' = 'Variance from Par');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`supply_consumption` ALTER COLUMN `waste_indicator` SET TAGS ('dbx_business_glossary_term' = 'Waste Indicator');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `lost_and_found_id` SET TAGS ('dbx_business_glossary_term' = 'Lost and Found ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `identity_document_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Document Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Appointment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claim_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'unclaimed|claim_pending|claimed|claim_denied');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Claimant Identification Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Identification Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_type` SET TAGS ('dbx_value_regex' = 'drivers_license|passport|national_id|employee_badge|other');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Name');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `discovery_location_detail` SET TAGS ('dbx_business_glossary_term' = 'Discovery Location Detail');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `discovery_location_type` SET TAGS ('dbx_business_glossary_term' = 'Discovery Location Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `disposition_type` SET TAGS ('dbx_business_glossary_term' = 'Disposition Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `disposition_type` SET TAGS ('dbx_value_regex' = 'returned_to_guest|donated|discarded|turned_over_to_authorities|shipped_to_guest|pending');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `estimated_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value Amount');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `estimated_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Method');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mail|in_person');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_status` SET TAGS ('dbx_value_regex' = 'not_attempted|attempted|notified|unable_to_contact');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `is_high_value_item` SET TAGS ('dbx_business_glossary_term' = 'High Value Item Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_brand` SET TAGS ('dbx_business_glossary_term' = 'Item Brand');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_color` SET TAGS ('dbx_business_glossary_term' = 'Item Color');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Lost and Found Item Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_number` SET TAGS ('dbx_value_regex' = '^LF-[0-9]{8}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `lost_and_found_status` SET TAGS ('dbx_business_glossary_term' = 'Lost and Found Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lost and Found Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `photo_url` SET TAGS ('dbx_business_glossary_term' = 'Item Photo URL');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `requires_special_handling` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `shipping_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Amount');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `shipping_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Tracking Number');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`lost_and_found` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard ID');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `amenity_items_list` SET TAGS ('dbx_business_glossary_term' = 'Amenity Items List');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `amenity_placement_instructions` SET TAGS ('dbx_business_glossary_term' = 'Amenity Placement Instructions');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `brand_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `chemical_product_specifications` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Specifications');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Standard Status');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_standard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Type');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_value_regex' = 'stayover|departure|deep_clean|turndown|public_area|refresh');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cost_per_execution_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Execution Estimate (USD)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `inspection_pass_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Pass Threshold Score');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `labor_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Estimate (USD)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `linen_change_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Linen Change Frequency (Days)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `linen_change_protocol` SET TAGS ('dbx_business_glossary_term' = 'Linen Change Protocol');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `linen_change_protocol` SET TAGS ('dbx_value_regex' = 'full_change|on_request|every_n_days|departure_only');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `maximum_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Time (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `minimum_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Time (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `quality_inspection_criteria` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Criteria');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Name');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `supply_consumption_estimate` SET TAGS ('dbx_business_glossary_term' = 'Supply Consumption Estimate');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `supply_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Supply Cost Estimate (USD)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `sustainability_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `target_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Time (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `task_checklist` SET TAGS ('dbx_business_glossary_term' = 'Task Checklist');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `training_module_reference` SET TAGS ('dbx_business_glossary_term' = 'Training Module Reference');
ALTER TABLE `travel_hospitality_ecm`.`housekeeping`.`cleaning_standard` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
