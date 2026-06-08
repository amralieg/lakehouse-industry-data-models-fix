-- Schema for Domain: maintenance | Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`maintenance` COMMENT 'Aircraft MRO (Maintenance Repair and Overhaul) lifecycle management including scheduled and unscheduled maintenance, work orders, airworthiness directives (ADs), component life-limited parts tracking, MEL (Minimum Equipment List) deferrals, AOG (Aircraft on Ground) events, APU maintenance, Part-145 approved maintenance organisation records, and defect tracking. Aligns with AMOS Aircraft Maintenance and Engineering System.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the maintenance work order. Primary key for all MRO (Maintenance Repair and Overhaul) execution records.',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft on which this maintenance work order is being performed. Links to the aircraft master record.',
    `airworthiness_directive_id` BIGINT COMMENT 'Foreign key linking to maintenance.airworthiness_directive. Business justification: work_order.ad_reference is a denormalized STRING reference to an Airworthiness Directive. Replacing with a proper FK to maintenance.airworthiness_directive normalizes the relationship, enables referen',
    `approved_maintenance_org_id` BIGINT COMMENT 'Reference to the AMO (Approved Maintenance Organisation) or Part-145 certified organization performing the work. Links to the maintenance organization master record.',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Cabin reconfiguration work orders (IFE upgrades, seat replacements, class reconfigurations) must reference the target cabin_configuration to validate scope, seat count changes, and post-work configura',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Maintenance work orders incur costs that must be allocated to cost centers (maintenance bases, aircraft types). This FK enables cost tracking and budgeting for maintenance activities.',
    `engine_id` BIGINT COMMENT 'Foreign key linking to fleet.engine. Business justification: Engine shop visit work orders must reference the specific fleet engine asset to update TSN/CSN, last shop visit date, LLP status, and power-by-hour contract tracking. Engine asset management is a core',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: AOG and line maintenance work orders are raised against the specific flight_leg that went unserviceable. Enables AOG impact analysis, delay/cancellation cost attribution to maintenance events, and OTP',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: MRO accounting requires direct GL traceability for maintenance expenditure postings. Aviation finance teams reconcile work order costs to specific GL accounts for period-end close and CASK reporting. ',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Work orders on leased aircraft require lease contract linkage for maintenance reserve claims, lease return condition tracking, and lessor reporting. Critical for lease return inspections and MR billin',
    `mel_item_id` BIGINT COMMENT 'Foreign key linking to maintenance.mel_item. Business justification: work_order.mel_reference is a denormalized STRING reference to a MEL item. Replacing with a proper FK to maintenance.mel_item normalizes the relationship. No reverse FK from mel_item to work_order exi',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Work orders may be generated to mitigate identified hazards (e.g., proactive modification to address known risk). Link tracks hazard control implementation, supports SMS hazard register closure, and d',
    `program_id` BIGINT COMMENT 'Foreign key linking to maintenance.program. Business justification: A work order is frequently generated from an approved Aircraft Maintenance Program (AMP). Linking work_order to program enables traceability from scheduled maintenance tasks back to the governing prog',
    `service_bulletin_id` BIGINT COMMENT 'Foreign key linking to maintenance.service_bulletin. Business justification: work_order.sb_reference is a denormalized STRING reference to a Service Bulletin. Replacing with a proper FK to maintenance.service_bulletin normalizes the relationship and enables referential integri',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Work orders are executed at specific airport stations. Links station_code (plain text) to station.station_id for operational tracking, cost allocation by location, and maintenance capacity planning. E',
    `turnaround_id` BIGINT COMMENT 'Foreign key linking to airport.turnaround. Business justification: Line maintenance work orders raised during aircraft turnarounds must reference the turnaround for delay code attribution, OTP reporting, and ground operations coordination. Aviation operations experts',
    `uld_id` BIGINT COMMENT 'Foreign key linking to cargo.uld. Business justification: Line maintenance raises work orders specifically for ULD repair and inspection (damage, structural integrity). Aviation MRO operations routinely track which ULD a work order addresses. No existing col',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance work was completed and aircraft returned to service. Used for turnaround time analysis and maintenance efficiency metrics.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual labor cost incurred for the work order in the airlines reporting currency, calculated from actual man-hours and labor rates. Used for cost accounting and variance analysis.',
    `actual_man_hours` DECIMAL(18,2) COMMENT 'Actual labor hours expended on the work order, aggregated from technician time entries. Used for cost accounting, efficiency analysis, and maintenance program refinement.',
    `actual_material_cost` DECIMAL(18,2) COMMENT 'Actual material and parts cost incurred for the work order in the airlines reporting currency, aggregated from material requisitions and component removals. Used for cost accounting and inventory valuation.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance work commenced. Used for schedule adherence tracking and labor cost allocation.',
    `aog_flag` BOOLEAN COMMENT 'Boolean indicator whether this work order is an AOG (Aircraft on Ground) event requiring critical priority and expedited parts/labor. True indicates aircraft is grounded and out of service; false indicates aircraft is serviceable or work is scheduled.',
    `ata_chapter_code` STRING COMMENT 'ATA 100 system chapter code identifying the aircraft system or component this work order addresses. Format is two-digit chapter, optional two-digit section, optional two-digit subject (e.g., 32 for Landing Gear, 32-41 for Wheels and Brakes).. Valid values are `^[0-9]{2}(-[0-9]{2}(-[0-9]{2})?)?$`',
    `corrective_action` STRING COMMENT 'Free-text description of the maintenance action performed to rectify the defect or complete the scheduled task. Includes reference to maintenance manual procedures, parts replaced, and tests performed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this work order record was first created in the maintenance system. Used for audit trail and work order lifecycle tracking.',
    `crs_reference` STRING COMMENT 'Reference number of the Certificate of Release to Service issued upon work order completion. Required for airworthiness compliance and regulatory audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this work order. Typically the airlines reporting currency.. Valid values are `^[A-Z]{3}$`',
    `defect_description` STRING COMMENT 'Free-text description of the defect, discrepancy, or maintenance requirement that triggered this work order. Captured from pilot reports, engineer inspections, or system alerts. May reference ATA chapter codes.',
    `deferral_expiry_date` DATE COMMENT 'Date by which a deferred work order (MEL deferral) must be completed to maintain airworthiness compliance. Null if work order is not deferred. Used for compliance tracking and maintenance planning.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total aircraft out-of-service hours from work order start to completion. Used for aircraft utilization analysis and maintenance efficiency metrics. Calculated as the difference between actual start and actual completion timestamps.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Planned labor cost for the work order in the airlines reporting currency, calculated from estimated man-hours and labor rates. Used for budgeting and cost forecasting.',
    `estimated_man_hours` DECIMAL(18,2) COMMENT 'Planned labor hours required to complete the work order, based on maintenance program standards or engineering estimates. Used for resource planning and cost estimation.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Planned material and parts cost for the work order in the airlines reporting currency. Includes consumables, rotables, and expendables. Used for budgeting and inventory planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this work order record was last updated. Used for audit trail and change tracking.',
    `maintenance_check_type` STRING COMMENT 'The maintenance program check interval or package this work order belongs to. A-check through D-check represent increasing scope and interval; daily/weekly/transit are operational checks; line maintenance is performed at the gate; base maintenance is performed in hangar; component maintenance is off-wing shop work. [ENUM-REF-CANDIDATE: a_check|b_check|c_check|d_check|daily|weekly|transit|line|base|component — 10 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional free-text notes, remarks, or special instructions related to the work order. May include coordination notes, parts availability updates, or engineering disposition.',
    `originating_source` STRING COMMENT 'The trigger or authority that initiated this work order. AD (Airworthiness Directive) indicates mandatory regulatory action; SB (Service Bulletin) indicates manufacturer recommendation; MEL indicates deferred defect; defect indicates pilot or engineer report; interval indicates scheduled maintenance program; modification indicates design change; inspection indicates regulatory or operational audit. [ENUM-REF-CANDIDATE: ad|sb|mel|defect|interval|modification|inspection — 7 candidates stripped; promote to reference product]',
    `part_145_approval_reference` STRING COMMENT 'Reference to the Part-145 maintenance organisation approval certificate number under which this work was performed. Required for regulatory compliance and airworthiness release.',
    `priority_level` STRING COMMENT 'Business priority assigned to the work order. Critical indicates AOG (Aircraft on Ground) or safety-critical; high indicates flight-impacting; medium indicates scheduled with tight window; low indicates deferrable; routine indicates standard interval work.. Valid values are `critical|high|medium|low|routine`',
    `scheduled_completion_timestamp` TIMESTAMP COMMENT 'Planned date and time when maintenance work is scheduled to be completed. Used for aircraft return-to-service planning and slot management.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when maintenance work is scheduled to begin. Used for resource planning and aircraft availability forecasting.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the certifying engineer signed off the work order and issued the Certificate of Release to Service (CRS). Marks the official completion and airworthiness release.',
    `work_order_number` STRING COMMENT 'Externally-known business identifier for the work order, typically formatted as WO followed by numeric sequence. Used for cross-system reference and operator communication.. Valid values are `^WO[0-9]{8,12}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle state of the work order. Open indicates work is scheduled but not started; in-progress indicates active execution; deferred indicates MEL (Minimum Equipment List) deferral or resource constraint; completed indicates work finished pending sign-off; closed indicates final approval and record closure; cancelled indicates work order voided.. Valid values are `open|in_progress|deferred|completed|closed|cancelled`',
    `work_order_type` STRING COMMENT 'Classification of the work order by maintenance category. Scheduled includes routine checks and intervals; unscheduled covers reactive maintenance; AOG (Aircraft on Ground) indicates critical grounding events; modification covers STC (Supplemental Type Certificate) and design changes; inspection includes regulatory and operational checks; defect rectification addresses reported discrepancies.. Valid values are `scheduled|unscheduled|aog|modification|inspection|defect_rectification`',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core MRO work order entity representing a discrete maintenance task or package issued against an aircraft, component, or system. Captures work order number, type (scheduled/unscheduled/AOG/modification), status lifecycle (open/in-progress/deferred/closed), originating source (AD, SB, MEL, defect, interval), estimated and actual man-hours, labour cost, material cost, station, start and completion timestamps, sign-off authority, Part-145 approval reference, and associated AMO. SSOT for all maintenance execution records. Links upward to maintenance program/check and downward to tasks, material requests, and component removals.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`work_order_task` (
    `work_order_task_id` BIGINT COMMENT 'Unique identifier for the work order task line item. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to safety.audit_finding. Business justification: Specific tasks within a work order may be added to address individual audit findings (e.g., an audit finding about a specific inspection technique requiring a dedicated task). Task-level audit finding',
    `airworthiness_directive_id` BIGINT COMMENT 'Foreign key linking to maintenance.airworthiness_directive. Business justification: work_order_task.airworthiness_directive_reference is a denormalized STRING. Replacing with a proper FK to maintenance.airworthiness_directive normalizes the relationship and enables full AD traceabili',
    `component_id` BIGINT COMMENT 'Foreign key linking to maintenance.component. Business justification: Work order task may involve a specific component. The work_order_task table has component_part_number and component_serial_number but no FK. Adding component_id FK normalizes this and removes redundan',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Dual-role crew members (pilot-engineers, flight engineers with A&P) perform line maintenance tasks. Business process: dual-role workforce utilization tracking, labor cost allocation, regulatory compli',
    `defect_report_id` BIGINT COMMENT 'Reference to the originating defect or discrepancy record that triggered this corrective maintenance task. Links unscheduled maintenance to reported defects.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Individual work order tasks may identify or mitigate specific hazards distinct from the parent work_orders hazard (e.g., a task discovers a new hazard during execution). SMS-integrated maintenance re',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Individual tasks may fulfill specific corrective actions (granular implementation tracking). Enables task-level verification of corrective action completion for audit compliance, supports detailed eff',
    `mel_deferral_id` BIGINT COMMENT 'Foreign key linking to maintenance.mel_deferral. Business justification: Work order task may be related to a MEL deferral. The work_order_task table has mel_reference (STRING) but no FK. Adding mel_deferral_id FK normalizes this and removes redundant mel_reference.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Individual maintenance tasks may be tied to specific safety events requiring rectification (e.g., post-incident inspection tasks). Enables granular tracking of occurrence-driven maintenance actions fo',
    `service_bulletin_id` BIGINT COMMENT 'Foreign key linking to maintenance.service_bulletin. Business justification: work_order_task.service_bulletin_reference is a denormalized STRING. Replacing with a proper FK to maintenance.service_bulletin normalizes the relationship and enables full SB traceability at the task',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order header that contains this task line.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Actual labor hours expended to complete this task, captured for cost accounting, productivity analysis, and future task planning.',
    `ata_chapter` STRING COMMENT 'Two-digit ATA chapter code identifying the aircraft system category (e.g., 32=Landing Gear, 71=Power Plant, 24=Electrical Power). Standard aircraft system classification.. Valid values are `^[0-9]{2}$`',
    `ata_section` STRING COMMENT 'ATA section code providing finer granularity within the ATA chapter, identifying the specific subsystem or component area.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this work order task record was first created in the maintenance system, used for audit trail and data lineage.',
    `deferral_expiry_date` DATE COMMENT 'The date by which a deferred task must be completed, as specified by MEL category limits (A/B/C/D) or other deferral authorization. Critical for compliance tracking.',
    `deferral_flag` BOOLEAN COMMENT 'Boolean indicator whether this task has been deferred under MEL or other approved deferral provisions. True indicates the task is deferred and must be tracked for completion within allowable limits.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned or standard labor hours required to complete this task, used for work planning, scheduling, and cost estimation.',
    `inspector_license_number` STRING COMMENT 'The Part-66 or equivalent aircraft maintenance license number of the inspector who verified the task, required for regulatory traceability and airworthiness certification.',
    `inspector_signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the inspector signed off the task verification, certifying that the work meets airworthiness standards and approved procedures.',
    `installed_component_serial_number` STRING COMMENT 'Serial number of the component installed during a replacement task, required for aircraft configuration control and life-limited parts tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this work order task record was last updated, used for audit trail, change tracking, and data synchronization.',
    `materials_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of materials, parts, and consumables used in this task, captured for maintenance cost accounting and budget tracking.',
    `removed_component_serial_number` STRING COMMENT 'Serial number of the component removed during a replacement task, required for component tracking, warranty claims, and rotable pool management.',
    `skill_trade_required` STRING COMMENT 'The specialized maintenance trade or skill category required to perform this task (avionics, airframe, powerplant, electrical, hydraulic, composite). Determines technician assignment and certification requirements.. Valid values are `avionics|airframe|powerplant|electrical|hydraulic|composite`',
    `task_card_reference` STRING COMMENT 'Reference number or code of the maintenance task card, job card, or work instruction document that defines this task. Links to approved maintenance procedures.',
    `task_completion_timestamp` TIMESTAMP COMMENT 'Date and time when this task was completed and signed off, marking the end of work and enabling aircraft return-to-service processing.',
    `task_description` STRING COMMENT 'Detailed narrative description of the maintenance action, inspection step, or repair work to be performed. Includes scope, method, and acceptance criteria.',
    `task_notes` STRING COMMENT 'Free-text field for technician notes, observations, findings, or special instructions related to this task. Captures important context not covered by structured fields.',
    `task_priority` STRING COMMENT 'Priority level assigned to this task for scheduling and resource allocation: critical (AOG/safety), high (operational impact), medium (scheduled), low (routine).. Valid values are `critical|high|medium|low`',
    `task_sequence_number` STRING COMMENT 'Sequential ordering of this task within the parent work order, used to control execution sequence and dependencies.',
    `task_start_timestamp` TIMESTAMP COMMENT 'Date and time when work on this task was initiated, used for labor tracking, downtime analysis, and task duration measurement.',
    `task_status` STRING COMMENT 'Current lifecycle status of the task: open (not started), in_progress (work underway), completed (finished and signed off), deferred (postponed under MEL), cancelled (no longer required).. Valid values are `open|in_progress|completed|deferred|cancelled`',
    `task_type` STRING COMMENT 'Classification of the maintenance task type indicating the nature of work: inspection (visual/NDT), repair (corrective action), replacement (component swap), modification (SB/AD compliance), lubrication, or servicing.. Valid values are `inspection|repair|replacement|modification|lubrication|servicing`',
    `technician_license_number` STRING COMMENT 'The Part-66 or equivalent aircraft maintenance license number of the technician who performed the task, required for regulatory traceability and certification compliance.',
    `technician_signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the technician signed off the completed task, certifying that the work was performed in accordance with approved data and procedures.',
    `work_location` STRING COMMENT 'Physical location where the task is performed: hangar (heavy maintenance), line (gate/ramp), shop (component workshop), vendor (external MRO facility).. Valid values are `hangar|line|shop|vendor`',
    CONSTRAINT pk_work_order_task PRIMARY KEY(`work_order_task_id`)
) COMMENT 'Individual task line within a work order, representing a discrete maintenance action, inspection step, or job card instruction. Tracks task card reference, ATA chapter/section, skill trade required (avionics, airframe, powerplant), estimated hours, actual hours, technician sign-off, inspector sign-off, status, and any deferred or carry-forward flags. Enables granular tracking of multi-task work packages.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`program` (
    `program_id` BIGINT COMMENT 'Primary key for program',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Under EASA Part-M, each aircraft must have an approved maintenance program (AMP) — the program is approved per registration mark. CAMO systems link the AMP to the specific aircraft for compliance moni',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Maintenance programs are structured around the MPD (Maintenance Planning Document) which is type-specific — interval structures, task cards, and escalation factors are defined at aircraft_type level. ',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: program.part_145_organization is a denormalized STRING reference to the Part-145 AMO responsible for executing the maintenance program. Replacing with a proper FK to maintenance.approved_maintenance_o',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Maintenance programs (MPD-based C/D-check schedules) require multi-year budget plans. Aviation finance teams build long-range maintenance cost forecasts tied to specific programs. This link enables pr',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Maintenance programs are assigned to cost centres (e.g., heavy maintenance, line maintenance, engine shop) for financial reporting and CASK allocation. Aviation controllers expect program costs to rol',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: MSG-3 maintenance programs are developed and revised based on safety risk assessments. CAMO and SMS managers require traceability from a program to the risk_assessment that justified its intervals or ',
    `aoc_number` STRING COMMENT 'Air Operator Certificate number under which this maintenance program is approved and operated.. Valid values are `^[A-Z0-9]{3,15}$`',
    `approval_date` DATE COMMENT 'Date on which the regulatory authority formally approved this maintenance program revision.',
    `approval_reference` STRING COMMENT 'Official reference number or certificate identifier issued by the regulatory authority approving this maintenance program.',
    `camo_organization` STRING COMMENT 'Name or identifier of the EASA Part-M Subpart G CAMO responsible for managing the continuing airworthiness under this program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance program record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this maintenance program becomes operationally effective and must be applied to the aircraft or fleet.',
    `effectivity_configuration` STRING COMMENT 'Specific aircraft configuration, modification state, or service bulletin incorporation status defining the applicability of this maintenance program.',
    `effectivity_serial_numbers` STRING COMMENT 'Comma-separated list or range of aircraft manufacturer serial numbers (MSN) to which this maintenance program applies. Null for type-level programs applicable to all aircraft of the type.',
    `escalation_approval_reference` STRING COMMENT 'Regulatory approval reference for any interval escalation applied to this maintenance program. Null if no escalation.',
    `escalation_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to maintenance intervals for escalation purposes (e.g., 1.05 for 5% escalation). Null if no escalation is approved.',
    `expiry_date` DATE COMMENT 'Date on which this maintenance program revision expires or is superseded. Null for currently active programs without defined end date.',
    `interval_structure` STRING COMMENT 'Primary interval structure used by this maintenance program to schedule tasks: flight hours (FH), flight cycles (FC), calendar days (DY), or combined thresholds.. Valid values are `flight_hours|flight_cycles|calendar_days|combined`',
    `mel_reference` STRING COMMENT 'Reference to the approved Minimum Equipment List (MEL) document associated with this maintenance program, defining permissible equipment deferrals.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this maintenance program record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance program record was last modified or updated.',
    `mpd_baseline` STRING COMMENT 'Manufacturers Maintenance Planning Document (MPD) baseline version or revision that forms the foundation of this approved maintenance program (e.g., Boeing D622W001 Rev 45, Airbus A320 MPD Rev 38).',
    `operator_name` STRING COMMENT 'Legal name of the airline or aircraft operator to whom this maintenance program is issued and approved.',
    `program_description` STRING COMMENT 'Detailed textual description of the maintenance program scope, objectives, and key features.',
    `program_name` STRING COMMENT 'Business-friendly name or title of the maintenance program (e.g., B737-800 AMP Rev 12, A320 Family Maintenance Program).',
    `program_status` STRING COMMENT 'Current lifecycle status of the maintenance program indicating its regulatory and operational state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|superseded|withdrawn|archived — 7 candidates stripped; promote to reference product]',
    `program_type` STRING COMMENT 'Classification of the maintenance program: AMP (Aircraft Maintenance Program), CMP (Component Maintenance Program), EMP (Engine Maintenance Program), sampling program, MSG-3 based, or other.. Valid values are `amp|cmp|emp|sampling|msg3|other`',
    `reliability_program_reference` STRING COMMENT 'Reference to the associated aircraft reliability program or monitoring system that feeds data into maintenance program adjustments.',
    `revision` STRING COMMENT 'Revision or version identifier of the maintenance program as approved by the regulatory authority (e.g., Rev 12, 2023-01, V3.5).. Valid values are `^[A-Z0-9./-]{1,20}$`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this maintenance program record.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Approved aircraft maintenance program (AMP) master record defining the scheduled maintenance framework for an aircraft type or individual registration. Captures program revision, EASA/FAA approval reference, maintenance planning document (MPD) baseline, interval structure (flight hours, flight cycles, calendar days), escalation approvals, and effectivity. SSOT for what maintenance is required and at what intervals per regulatory approval.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`check` (
    `check_id` BIGINT COMMENT 'Primary key for check',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: A full maintenance check (C/D-check) at an AMO generates a single consolidated AP invoice. Direct check→AP linkage supports three-way matching (check completion vs. invoice vs. payment) and MRO invoic',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to safety.audit_finding. Business justification: A maintenance check (C/D-check) can be specifically scheduled to address an audit finding requiring structural or system-level inspection. This is a real CAMO/quality process — the check is the planni',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: CAMO/Part-M regulatory requirement: every A/B/C/D-check must be traceable to a specific aircraft tail for airworthiness records, due-date tracking, and interval management. Aviation domain experts uni',
    `aircraft_lease_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_lease. Business justification: Pre-redelivery and lease-return checks are contractually mandated by the aircraft lease agreement — the check must reference the specific lease to verify return condition compliance (max cycles/hours,',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: Maintenance check is performed by an approved maintenance organization. The check table has part_145_approval_number and mro_facility_name but no FK. Adding approved_maintenance_org_id FK normalizes t',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Major maintenance checks are planned against annual maintenance budgets. Links check to budget plan for variance analysis, forecast accuracy tracking, and budget consumption reporting.',
    `alert_id` BIGINT COMMENT 'Foreign key linking to safety.alert. Business justification: A safety alert (EASA SIB, airworthiness alert) can trigger a maintenance check as the required compliance action. Linking check to alert at the planning level is a real regulatory compliance tracking ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Maintenance checks are charged to specific cost centres (heavy maintenance vs. line maintenance) for financial reporting and budget control. Aviation controllers track check costs by cost centre for C',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: A maintenance check (C/D-check) is a major cost event generating direct GL postings. Aviation finance requires check-level GL reference for maintenance cost recognition, IFRS capitalization decisions,',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: A corrective action (e.g., from an SMS finding or audit) may mandate a full maintenance check as its implementation vehicle. Linking check to corrective_action at the planning level — before work_orde',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Major maintenance checks on leased aircraft drive maintenance reserve accruals and lease return condition compliance. Essential for lessor reporting and MR reconciliation at lease expiry.',
    `program_id` BIGINT COMMENT 'Reference to the overarching maintenance program that defines the schedule and requirements for this check type. Links to the regulatory-approved maintenance plan.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Maintenance checks (A/C/D checks) performed at specific stations. Links maintenance_station_code to station.station_id for hangar capacity planning, check performance tracking by location, and regulat',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Major maintenance checks may be triggered by safety occurrences (e.g., heavy landing requiring special inspection). Links unscheduled checks to causal events for fleet-wide risk assessment and regulat',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Maintenance check is associated with a work order. The check table has work_order_number (STRING) but no FK. Adding work_order_id FK allows proper relational integrity and removes redundant work_order',
    `actual_induction_date` DATE COMMENT 'The actual date when the aircraft entered the maintenance facility and work commenced. May differ from scheduled date due to operational constraints.',
    `actual_man_hours` DECIMAL(18,2) COMMENT 'The actual total labor hours consumed during execution of this maintenance check. Used for cost accounting and efficiency analysis.',
    `actual_release_date` DATE COMMENT 'The actual date when the aircraft was certified airworthy and released back to operational service after completion of the maintenance check.',
    `airworthiness_directives_complied` STRING COMMENT 'The number of mandatory Airworthiness Directives (ADs) complied with during this maintenance check. ADs are legally enforceable safety regulations issued by aviation authorities.',
    `aog_event_flag` BOOLEAN COMMENT 'Boolean indicator of whether this maintenance check was triggered by or resulted in an Aircraft on Ground event, indicating unscheduled downtime with high operational impact.',
    `check_status` STRING COMMENT 'Current lifecycle status of the maintenance check event. Tracks progression from planning through execution to completion or cancellation.. Valid values are `planned|scheduled|in-progress|completed|deferred|cancelled`',
    `check_type` STRING COMMENT 'The category of scheduled maintenance check being performed. A-checks are light, frequent inspections; D-checks are heavy overhauls requiring aircraft disassembly.. Valid values are `A-check|B-check|C-check|D-check|line check|transit check`',
    `completion_timestamp` TIMESTAMP COMMENT 'The precise date and time when all maintenance tasks were completed and the aircraft was certified for return to service. Used for audit trail and performance tracking.',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the total cost amount. Airlines operate globally and may incur maintenance costs in multiple currencies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this maintenance check record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `defects_found_count` STRING COMMENT 'The total number of defects, discrepancies, or non-conformities identified during execution of this maintenance check. Used for quality and reliability analysis.',
    `downtime_days` DECIMAL(18,2) COMMENT 'The total number of days the aircraft was out of service for this maintenance check, calculated from induction to release. Critical for fleet utilization metrics.',
    `due_date` DATE COMMENT 'The calendar date by which this maintenance check must be completed to maintain airworthiness certification. Calculated from maintenance program intervals.',
    `due_flight_cycles` STRING COMMENT 'The cumulative aircraft flight cycles (takeoff-landing pairs) at which this maintenance check is due. Critical for structural fatigue monitoring.',
    `due_flight_hours` DECIMAL(18,2) COMMENT 'The cumulative aircraft flight hours at which this maintenance check is due. One of three interval metrics (hours, cycles, calendar) used to trigger maintenance.',
    `interval_days` STRING COMMENT 'The calendar day interval between occurrences of this check type as defined in the maintenance program. For example, A-checks typically occur every 500-800 flight hours or 200-300 cycles or 60-90 days, whichever comes first.',
    `interval_flight_cycles` STRING COMMENT 'The flight cycle interval between occurrences of this check type as defined in the maintenance program.',
    `interval_flight_hours` DECIMAL(18,2) COMMENT 'The flight hour interval between occurrences of this check type as defined in the maintenance program.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this maintenance check record was most recently updated. Tracks data currency and supports change data capture processes.',
    `mel_deferrals_count` STRING COMMENT 'The number of defects deferred under Minimum Equipment List provisions during this check, allowing aircraft return to service with specific inoperative equipment.',
    `next_due_date` DATE COMMENT 'The projected calendar date when the next occurrence of this check type will be due, calculated from completion date plus maintenance interval.',
    `next_due_flight_cycles` STRING COMMENT 'The projected cumulative aircraft flight cycles at which the next occurrence of this check type will be due.',
    `next_due_flight_hours` DECIMAL(18,2) COMMENT 'The projected cumulative aircraft flight hours at which the next occurrence of this check type will be due.',
    `planned_man_hours` DECIMAL(18,2) COMMENT 'The estimated total labor hours required to complete this maintenance check, used for resource planning and cost estimation.',
    `release_certificate_number` STRING COMMENT 'The unique identifier of the Certificate of Release to Service issued upon completion of this maintenance check, certifying the aircraft is airworthy.. Valid values are `^CRS[0-9]{8,12}$`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to this maintenance check. Used for operational context and knowledge transfer.',
    `scheduled_induction_date` DATE COMMENT 'The planned date when the aircraft will enter the maintenance facility to begin this check. Used for capacity planning and aircraft rotation scheduling.',
    `scheduled_release_date` DATE COMMENT 'The planned date when the aircraft is expected to be released back to service after completion of the maintenance check.',
    `service_bulletins_incorporated` STRING COMMENT 'The number of manufacturer service bulletins (recommended but not mandatory modifications or inspections) incorporated during this maintenance check.',
    CONSTRAINT pk_check PRIMARY KEY(`check_id`)
) COMMENT 'Scheduled maintenance check event (A-check, B-check, C-check, D-check, line check, transit check) planned or executed against a specific aircraft registration. Records check type, due date, due flight hours, due cycles, actual induction date, release date, station/MRO facility, man-hours consumed, downtime days, and next-due projections. Bridges the maintenance program to actual execution events.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` (
    `airworthiness_directive_id` BIGINT COMMENT 'Primary key for airworthiness_directive',
    `ad_number` STRING COMMENT 'Official AD number issued by the regulatory authority (e.g., FAA AD 2023-12-05, EASA AD 2023-0145). Unique identifier assigned by the issuing authority.. Valid values are `^[A-Z0-9-]+$`',
    `ad_status` STRING COMMENT 'Current lifecycle status of the AD. Active=currently enforceable, Superseded=replaced by newer AD, Cancelled=no longer applicable, Proposed=under review, Interim=temporary emergency AD.. Valid values are `active|superseded|cancelled|proposed|interim`',
    `aircraft_type` STRING COMMENT 'Aircraft type designation to which this AD applies (e.g., Boeing 737-800, Airbus A320-200, Embraer E175). May include multiple types if AD applies broadly.',
    `airworthiness_directive_description` STRING COMMENT 'Detailed description of the unsafe condition, the corrective action required, and the rationale for the airworthiness directive.',
    `alternative_compliance_method` STRING COMMENT 'Description of approved Alternative Methods of Compliance (AMOC) that may be used in lieu of the prescribed action, if permitted by the issuing authority.',
    `applicability` STRING COMMENT 'Defines which aircraft, engines, propellers, or components are affected by this AD. Includes aircraft type, model, serial number ranges, and part numbers.',
    `compliance_interval_unit` STRING COMMENT 'Unit of measure for repetitive compliance interval. FH=Flight Hours, FC=Flight Cycles, days/months/years=calendar time. Null for one-time ADs.. Valid values are `FH|FC|days|months|years`',
    `compliance_interval_value` DECIMAL(18,2) COMMENT 'Numeric interval value for repetitive compliance actions (e.g., repeat inspection every 1000 flight hours). Null for one-time ADs.',
    `compliance_method` STRING COMMENT 'Type of compliance action required. One-time=single inspection or action, Repetitive=recurring inspections at intervals, Terminating=final action that eliminates need for repetitive compliance.. Valid values are `one-time|repetitive|terminating`',
    `compliance_threshold_unit` STRING COMMENT 'Unit of measure for compliance threshold. FH=Flight Hours, FC=Flight Cycles, days/months/years=calendar time.. Valid values are `FH|FC|days|months|years`',
    `compliance_threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value at which initial compliance action must be performed (e.g., 5000 flight hours, 2500 flight cycles, 180 calendar days).',
    `component_type` STRING COMMENT 'Category of component affected by the AD. Airframe=aircraft structure, Engine=propulsion system, Propeller=propeller assembly, Appliance=accessory or system component, APU=Auxiliary Power Unit.. Valid values are `airframe|engine|propeller|appliance|APU`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AD record was first created in the system.',
    `document_url` STRING COMMENT 'URL link to the official AD document on the issuing authoritys website (e.g., FAA AD docket, EASA AD repository).. Valid values are `^https?://.*$`',
    `effective_date` DATE COMMENT 'Date when the airworthiness directive becomes legally enforceable and compliance is required.',
    `estimated_cost_per_aircraft` DECIMAL(18,2) COMMENT 'Estimated cost in USD to comply with the AD per affected aircraft, including labor, parts, and downtime. Provided by issuing authority or operator estimate.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated labor hours required to perform the compliance action per aircraft, as provided by the issuing authority or manufacturer.',
    `issue_date` DATE COMMENT 'Date when the airworthiness directive was officially published by the issuing authority.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this AD record was last updated in the system.',
    `part_number_affected` STRING COMMENT 'Specific part number(s) of components affected by this AD. May include multiple part numbers if AD applies to a family of parts.',
    `remarks` STRING COMMENT 'Additional notes, clarifications, or operator-specific annotations regarding the AD compliance, interpretation, or fleet impact.',
    `serial_number_range` STRING COMMENT 'Serial number range of aircraft or components to which this AD applies (e.g., S/N 1001 through 5000). Null if AD applies to all serial numbers.',
    `subject` STRING COMMENT 'Brief title or subject line describing the nature of the airworthiness directive (e.g., Engine Fan Blade Inspection, Landing Gear Actuator Replacement).',
    `superseded_ad_number` STRING COMMENT 'AD number(s) that this directive supersedes or replaces. Multiple ADs may be listed if this AD consolidates previous directives. Null if no supersession.',
    CONSTRAINT pk_airworthiness_directive PRIMARY KEY(`airworthiness_directive_id`)
) COMMENT 'Airworthiness Directive (AD) master record issued by FAA, EASA, or national CAA mandating corrective action on aircraft, engines, or components. Captures AD number, issuing authority, effective date, compliance method (one-time/repetitive), threshold (FH/FC/calendar), interval, applicability (aircraft type, serial number range), superseded AD references, and compliance status per tail number. SSOT for regulatory AD tracking.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`ad_compliance` (
    `ad_compliance_id` BIGINT COMMENT 'Unique identifier for the airworthiness directive compliance record.',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft to which this airworthiness directive applies.',
    `alert_id` BIGINT COMMENT 'Foreign key linking to safety.alert. Business justification: Safety alerts may reference ADs requiring compliance (urgent AD implementation alerts). Link supports integrated regulatory compliance tracking, enables alert-driven AD prioritization, and tracks aler',
    `component_id` BIGINT COMMENT 'Reference to the specific aircraft component (engine, APU, landing gear, etc.) to which this airworthiness directive applies, if component-specific.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Regulatory AD compliance costs must be tracked separately for EASA/FAA regulatory reporting and insurance purposes. Aviation finance teams report AD-driven maintenance expenditure as a distinct GL cos',
    `airworthiness_directive_id` BIGINT COMMENT 'Foreign key linking to maintenance.airworthiness_directive. Business justification: AD compliance tracks compliance with a specific airworthiness directive. The ad_compliance table has ad_number, ad_title, and issuing_authority but no FK to airworthiness_directive. Adding maintenance',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: AD compliance activities may be initiated by safety occurrences that reveal fleet-wide issues (e.g., incident exposes design flaw requiring emergency AD). Links occurrence-driven regulatory compliance',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order under which the airworthiness directive compliance action was performed.',
    `accomplishment_date` DATE COMMENT 'The date on which the airworthiness directive compliance action was completed.',
    `accomplishment_flight_cycles` STRING COMMENT 'The total flight cycles (airframe or component) at the time the airworthiness directive compliance action was completed.',
    `accomplishment_flight_hours` DECIMAL(18,2) COMMENT 'The total flight hours (airframe or component) at the time the airworthiness directive compliance action was completed.',
    `ad_effective_date` DATE COMMENT 'The date on which the airworthiness directive becomes effective and compliance is required.',
    `amoc_approval_date` DATE COMMENT 'The date on which the alternative method of compliance was approved by the regulatory authority.',
    `amoc_approval_number` STRING COMMENT 'The regulatory approval number for an alternative method of compliance, if an AMOC has been granted by the authority.',
    `applicability` STRING COMMENT 'Description of the aircraft models, serial numbers, or component part numbers to which this airworthiness directive applies.',
    `certifying_mechanic_license_number` STRING COMMENT 'The license or certificate number of the mechanic who certified the airworthiness directive compliance action.',
    `compliance_method` STRING COMMENT 'The method selected to comply with the airworthiness directive: inspection, modification, replacement, operational limitation, or alternative method of compliance (AMOC).. Valid values are `inspection|modification|replacement|operational_limitation|alternative_method`',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting additional details, findings, or special circumstances related to the airworthiness directive compliance action.',
    `compliance_status` STRING COMMENT 'Current status of compliance with the airworthiness directive: open (pending action), complied (completed), deferred (postponed under MEL), not applicable (does not apply to this aircraft/component), superseded (replaced by newer AD), or cancelled (withdrawn by authority).. Valid values are `open|complied|deferred|not_applicable|superseded|cancelled`',
    `deferral_expiry_date` DATE COMMENT 'The date by which the deferred airworthiness directive compliance action must be completed.',
    `deferral_reference` STRING COMMENT 'Reference to the Minimum Equipment List (MEL) or Configuration Deviation List (CDL) item under which compliance with this airworthiness directive has been deferred.',
    `next_due_date` DATE COMMENT 'The calendar date by which the next repetitive airworthiness directive compliance action is due.',
    `next_due_flight_cycles` STRING COMMENT 'The flight cycles threshold at which the next repetitive airworthiness directive compliance action is due.',
    `next_due_flight_hours` DECIMAL(18,2) COMMENT 'The flight hours threshold at which the next repetitive airworthiness directive compliance action is due.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this airworthiness directive compliance record was first created in the system.',
    `record_updated_by` STRING COMMENT 'The user or system identifier that last updated this airworthiness directive compliance record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this airworthiness directive compliance record was last modified in the system.',
    `repetitive_flag` BOOLEAN COMMENT 'Indicates whether the airworthiness directive requires repetitive compliance actions (true) or is a one-time action (false).',
    `repetitive_interval_cycles` STRING COMMENT 'The flight cycles interval at which the airworthiness directive compliance action must be repeated, if applicable.',
    `repetitive_interval_days` STRING COMMENT 'The calendar days interval at which the airworthiness directive compliance action must be repeated, if applicable.',
    `repetitive_interval_hours` DECIMAL(18,2) COMMENT 'The flight hours interval at which the airworthiness directive compliance action must be repeated, if applicable.',
    `superseded_by_ad_number` STRING COMMENT 'The airworthiness directive number that supersedes this AD, if applicable.',
    CONSTRAINT pk_ad_compliance PRIMARY KEY(`ad_compliance_id`)
) COMMENT 'Compliance record tracking the status of each Airworthiness Directive against each applicable aircraft or component. Records compliance method selected, accomplishment date, flight hours at accomplishment, cycles at accomplishment, next-due date/hours/cycles for repetitive ADs, work order reference, certifying staff sign-off, and open/closed/deferred status. Enables airworthiness compliance reporting to FAA/EASA/CAA.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`service_bulletin` (
    `service_bulletin_id` BIGINT COMMENT 'Unique identifier for the service bulletin record. Primary key.',
    `aircraft_model_applicability` STRING COMMENT 'Aircraft model designations to which this service bulletin applies (e.g., A320-200, Boeing 737-800, Embraer E190). May include multiple models separated by commas.',
    `ata_chapter` STRING COMMENT 'ATA 100 chapter code identifying the aircraft system or component category addressed by the service bulletin (e.g., 32 for Landing Gear, 71 for Power Plant, 27 for Flight Controls).. Valid values are `^[0-9]{2}(-[0-9]{2})?$`',
    `bulletin_category` STRING COMMENT 'Classification of the service bulletin indicating the urgency and compliance requirement. Mandatory bulletins are typically linked to Airworthiness Directives (ADs), while Recommended and Optional bulletins are at operator discretion.. Valid values are `Mandatory|Recommended|Optional|Alert|Information`',
    `bulletin_number` STRING COMMENT 'Official service bulletin number issued by the Original Equipment Manufacturer (OEM). Format varies by manufacturer (e.g., Boeing SB format: 737-57-1234, Airbus SB format: A320-32-1045).. Valid values are `^[A-Z0-9]{2,6}-[0-9]{2,6}(-[A-Z0-9]{1,4})?$`',
    `bulletin_title` STRING COMMENT 'Descriptive title of the service bulletin summarizing the subject matter and purpose of the modification or inspection.',
    `bulletin_type` STRING COMMENT 'Type of technical communication issued by the OEM. Service Bulletins are formal modification instructions, Service Letters are informational, Alert Service Bulletins address urgent safety issues.. Valid values are `Service Bulletin|Service Letter|Alert Service Bulletin|All Operators Message|Technical Bulletin|Product Improvement`',
    `compliance_completion_date` DATE COMMENT 'Date when compliance with the service bulletin was completed across the applicable fleet. Null if compliance is not yet complete. Format: yyyy-MM-dd.',
    `compliance_status` STRING COMMENT 'Current compliance status of the service bulletin within the operators fleet. Tracks whether the bulletin has been implemented, is in progress, or has been deferred.. Valid values are `Not Started|In Progress|Completed|Deferred|Not Applicable|Cancelled`',
    `compliance_threshold` STRING COMMENT 'Compliance deadline or threshold expressed in flight hours, flight cycles, calendar time, or next scheduled maintenance event (e.g., Within 12 months, Before 10,000 flight hours, At next C-Check).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service bulletin record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `document_url` STRING COMMENT 'URL or file path to the full service bulletin document stored in the airlines document management system or OEM portal.. Valid values are `^https?://.*$`',
    `effectivity` STRING COMMENT 'Aircraft serial numbers, model series, or configuration codes to which the service bulletin applies. Defines the population of aircraft or components affected (e.g., All A320-200 MSN 1000-5000, Boeing 737-800 Line Numbers 1-999).',
    `engine_model_applicability` STRING COMMENT 'Engine model designations to which this service bulletin applies (e.g., CFM56-5B, PW1100G, Trent 1000). Null if bulletin does not apply to engines.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost to implement the service bulletin including parts, labor, and downtime. Expressed in USD for standardization.',
    `estimated_man_hours` DECIMAL(18,2) COMMENT 'OEM-estimated labor hours required to complete the service bulletin task. Used for maintenance planning and cost estimation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the service bulletin is currently active and applicable. False if the bulletin has been superseded, cancelled, or completed across the fleet.',
    `issue_date` DATE COMMENT 'Date the service bulletin was officially issued by the OEM. Format: yyyy-MM-dd.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service bulletin record was last updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `oem_name` STRING COMMENT 'Name of the manufacturer or supplier that issued the service bulletin (e.g., Airbus, Boeing, CFM International, Pratt & Whitney). [ENUM-REF-CANDIDATE: Airbus|Boeing|Bombardier|Embraer|ATR|CFM International|Pratt & Whitney|Rolls-Royce|General Electric|Honeywell|Collins Aerospace|Safran|Thales|Liebherr|Goodrich — 15 candidates stripped; promote to reference product]',
    `part_numbers_affected` STRING COMMENT 'Comma-separated list of part numbers (P/N) affected by this service bulletin. Identifies components requiring modification, inspection, or replacement.',
    `reason_for_issue` STRING COMMENT 'Business or technical justification for issuing the service bulletin (e.g., Prevent premature wear, Improve reliability, Address safety concern, Regulatory compliance).',
    `revision_date` DATE COMMENT 'Date of the most recent revision to the service bulletin. Null if no revisions have been issued. Format: yyyy-MM-dd.',
    `revision_number` STRING COMMENT 'Revision level of the service bulletin. Tracks updates and amendments to the original bulletin (e.g., Original, 1, 2, A, B).. Valid values are `^[0-9]{1,3}$|^[A-Z]$|^Original$`',
    `superseded_bulletin_number` STRING COMMENT 'Service bulletin number that this bulletin supersedes or replaces. Null if this is the original bulletin with no predecessor.',
    `technical_description` STRING COMMENT 'Detailed technical description of the modification, inspection, or replacement procedure outlined in the service bulletin. Summarizes the work scope and technical rationale.',
    CONSTRAINT pk_service_bulletin PRIMARY KEY(`service_bulletin_id`)
) COMMENT 'Manufacturer Service Bulletin (SB) and Service Letter (SL) master record issued by OEM (Airbus, Boeing, CFM, etc.) recommending or mandating modifications, inspections, or part replacements. Captures SB number, revision, OEM, ATA chapter, category (mandatory/recommended/optional), effectivity, compliance threshold, and cross-reference to any associated AD. SSOT for OEM technical communication tracking.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`defect_report` (
    `defect_report_id` BIGINT COMMENT 'Unique identifier for the aircraft defect report record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Defect reports must be linked to the specific aircraft for MEL management, reliability reporting, and airworthiness tracking — a core CAMO function. Enables fleet-level defect trend analysis per tail.',
    `airworthiness_directive_id` BIGINT COMMENT 'Foreign key linking to maintenance.airworthiness_directive. Business justification: defect_report.airworthiness_directive_reference is a denormalized STRING. A defect may be directly linked to an AD finding. Replacing with a proper FK to maintenance.airworthiness_directive normalizes',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: defect_report.maintenance_organization_code is a denormalized STRING reference to the maintenance organization that handled the defect. Replacing with a proper FK to maintenance.approved_maintenance_o',
    `component_id` BIGINT COMMENT 'Foreign key linking to maintenance.component. Business justification: A defect report is raised against a specific aircraft component. defect_report has serial_number_installed and serial_number_removed which are denormalized component identifiers. Adding component_id F',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: A recurring or safety-significant defect report can directly drive a corrective action raised by the quality/safety department, independent of a formal investigation. This is a real airline quality pr',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Defects discovered at specific airport stations. Links discovery_station_code to station.station_id for quality tracking by location, identifying stations with high defect discovery rates, and targeti',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Defects are discovered and raised against a specific operated sector. Reliability reporting, AOG tracking, and safety investigation all require linking defect_report to the exact flight_leg. Removes d',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Defect reports are raised against specific flight numbers for reliability engineering, delay attribution, and OTP impact reporting. Aviation domain experts universally expect defect_report to referenc',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Defects may identify new hazards or confirm existing ones (e.g., recurring defect pattern reveals systemic hazard). Link supports SMS hazard register updates, enables defect-driven hazard identificati',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to safety.investigation. Business justification: Defects often trigger formal safety investigations; linking enables tracking investigation outcomes back to originating defect. Critical for SMS closed-loop corrective action tracking and regulatory i',
    `mel_item_id` BIGINT COMMENT 'Foreign key linking to maintenance.mel_item. Business justification: defect_report.mel_item_reference is a denormalized STRING. A defect report often references the applicable MEL item when the defect is deferred. Replacing with a proper FK to maintenance.mel_item norm',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Safety-reportable defects are safety occurrences that must be tracked in the SMS. This FK links the defect report to the safety occurrence for regulatory reporting and trend analysis.',
    `report_id` BIGINT COMMENT 'Foreign key linking to safety.report. Business justification: A safety-reportable defect (defect_report.safety_reportable_flag=true) generates a safety report directly — this can occur without an occurrence being raised (e.g., a ground maintenance finding). Dire',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Flight/cabin crew discover and report defects during operations. Complements existing employee_id FK with crew-specific context (qualifications, recency, position). Business process: defect discovery ',
    `turnaround_id` BIGINT COMMENT 'Foreign key linking to airport.turnaround. Business justification: Defects discovered during turnaround must be linked to the turnaround event for delay attribution, OTP impact analysis, and ground operations reporting. Aviation line maintenance experts expect defect',
    `uld_id` BIGINT COMMENT 'Foreign key linking to cargo.uld. Business justification: Cargo/ground staff discover ULD damage during loading/unloading and raise a defect report against the specific ULD. This is a standard aviation ground operations process linking cargo equipment defect',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Defect report is rectified via a work order. The defect_report table has work_order_number (STRING) but no FK. Adding work_order_id FK normalizes this and removes redundant work_order_number.',
    `aog_flag` BOOLEAN COMMENT 'Indicates whether this defect has grounded the aircraft, preventing dispatch until rectified. True if AOG, false otherwise.',
    `ata_chapter` STRING COMMENT 'ATA iSpec 2200 chapter code classifying the aircraft system affected by the defect (e.g., 32 for Landing Gear, 71 for Power Plant, 27 for Flight Controls).. Valid values are `^[0-9]{2}(-[0-9]{2}(-[0-9]{2})?)?$`',
    `cdl_applicable_flag` BOOLEAN COMMENT 'Indicates whether the defect is eligible for deferral under the aircraft Configuration Deviation List (CDL) for missing or inoperative external components. True if CDL item exists, false otherwise.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the defect report was formally closed after verification and sign-off. Null if not yet closed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this defect report record was first created in the system.',
    `defect_description` STRING COMMENT 'Detailed narrative description of the defect or discrepancy as reported by flight crew, cabin crew, or maintenance technician. Free-text field capturing symptoms, observations, and operational impact.',
    `defect_number` STRING COMMENT 'Business identifier for the defect report, typically generated by AMOS or technical log system. Externally referenced in work orders and maintenance records.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `defect_status` STRING COMMENT 'Current lifecycle status of the defect report (open - awaiting action, deferred - MEL/CDL deferral applied, rectified - repair completed, closed - verified and signed off, cancelled - invalid report).. Valid values are `open|deferred|rectified|closed|cancelled`',
    `deferral_expiry_timestamp` TIMESTAMP COMMENT 'Date and time by which the deferred defect must be rectified per MEL/CDL category. Null if not deferred or if defect is already rectified.',
    `discovery_phase` STRING COMMENT 'Operational phase during which the defect was discovered (pre-flight inspection, in-flight, post-flight walk-around, hangar maintenance, line maintenance, or base maintenance check).. Valid values are `pre-flight|in-flight|post-flight|hangar|line-maintenance|base-maintenance`',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time when the defect was discovered. Principal business event timestamp for the defect lifecycle.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this defect report record was last updated in the system.',
    `mel_applicable_flag` BOOLEAN COMMENT 'Indicates whether the defect is eligible for deferral under the aircraft Minimum Equipment List (MEL). True if MEL item exists for this defect, false otherwise.',
    `mel_category` STRING COMMENT 'MEL deferral category indicating repair interval: A (repair interval specified by MEL), B (repair within 3 days), C (repair within 10 days), D (repair within 120 days). Null if not deferred.. Valid values are `A|B|C|D`',
    `part_number_replaced` STRING COMMENT 'Manufacturer part number of the component replaced during rectification. Null if no part replacement occurred.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `rectification_action_description` STRING COMMENT 'Detailed description of the corrective action taken to rectify the defect, including parts replaced, repairs performed, and tests conducted. Null if not yet rectified.',
    `rectification_station_code` STRING COMMENT 'IATA three-letter airport code of the station where the defect was rectified. Null if not yet rectified.. Valid values are `^[A-Z]{3}$`',
    `rectification_timestamp` TIMESTAMP COMMENT 'Date and time when the defect rectification work was completed. Null if not yet rectified.',
    `reported_by_role` STRING COMMENT 'Role of the person who reported the defect (flight crew, cabin crew, maintenance technician, quality inspector, or engineer).. Valid values are `flight-crew|cabin-crew|maintenance-technician|quality-inspector|engineer`',
    `safety_reportable_flag` BOOLEAN COMMENT 'Indicates whether this defect meets regulatory criteria for mandatory safety occurrence reporting to aviation authorities (FAA, EASA, national CAA). True if reportable, false otherwise.',
    `severity_level` STRING COMMENT 'Engineering assessment of defect severity: critical (immediate safety impact, AOG), major (significant operational impact), minor (limited impact, deferrable), cosmetic (no operational impact).. Valid values are `critical|major|minor|cosmetic`',
    CONSTRAINT pk_defect_report PRIMARY KEY(`defect_report_id`)
) COMMENT 'Aircraft defect and discrepancy record raised by flight crew (via technical log), cabin crew, or maintenance technicians. Captures ATA chapter, defect description, discovery phase (pre-flight/in-flight/post-flight/hangar), MEL/CDL applicability, deferral category (A/B/C/D), deferral expiry, rectification work order reference, station, and open/deferred/closed status. SSOT for unscheduled maintenance demand origination.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`mel_item` (
    `mel_item_id` BIGINT COMMENT 'Primary key for mel_item',
    `aircraft_type_id` BIGINT COMMENT 'Reference to the aircraft type for which this MEL item applies (e.g., Boeing 737-800, Airbus A320-200).',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Each MEL item manages a specific known hazard (an inoperative system representing a defined safety hazard). SMS integration requires traceability from MEL items to the hazard register — a real require',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: MEL items are approved based on safety risk assessments demonstrating acceptable dispatch risk with the item inoperative. EASA AMC to Part-CAT and MMEL development process require traceability from ea',
    `ata_chapter` STRING COMMENT 'Two-digit ATA chapter code categorizing the aircraft system (e.g., 21=Air Conditioning, 32=Landing Gear, 34=Navigation).. Valid values are `^[0-9]{2}$`',
    `ata_section` STRING COMMENT 'Two-digit ATA section code within the chapter, providing finer system categorization.. Valid values are `^[0-9]{2}$`',
    `ata_subject` STRING COMMENT 'Two-digit ATA subject code providing the most granular system classification.. Valid values are `^[0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this MEL item record was first created in the system.',
    `deferral_category` STRING COMMENT 'The MEL category defining the maximum time an item may remain inoperative: A (no time limit with conditions), B (3 consecutive calendar days), C (10 consecutive calendar days), D (120 consecutive calendar days).. Valid values are `A|B|C|D`',
    `dispatch_conditions` STRING COMMENT 'Additional conditions or restrictions for dispatch with this item inoperative (e.g., Day VFR only, Maximum altitude FL250, Reduced passenger capacity).',
    `effective_date` DATE COMMENT 'The date from which this MEL item configuration becomes effective and may be used for dispatch decisions.',
    `expiry_date` DATE COMMENT 'The date on which this MEL item configuration is superseded or withdrawn. Null for currently active items.',
    `item_description` STRING COMMENT 'Detailed description of the inoperative system, component, or equipment covered by this MEL item (e.g., Passenger Oxygen System - One Passenger Service Unit).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this MEL item record was last updated.',
    `maintenance_procedures` STRING COMMENT 'Specific maintenance actions required before dispatch with this item inoperative (e.g., Deactivate and placard, Secure and stow equipment).',
    `maximum_deferral_days` STRING COMMENT 'The maximum number of consecutive calendar days the item may remain inoperative before rectification is required. Null for Category A items with no time limit.',
    `mel_item_number` STRING COMMENT 'The unique MEL item number following ATA chapter structure (e.g., 21-31-01, 34-12-02A). This is the externally-known identifier for the MEL item.. Valid values are `^[0-9]{2}-[0-9]{2}-[0-9]{2}[A-Z]?$`',
    `mel_item_status` STRING COMMENT 'Current lifecycle status of this MEL item configuration: active (in use), superseded (replaced by newer revision), withdrawn (no longer applicable), pending_approval (awaiting regulatory acceptance).. Valid values are `active|superseded|withdrawn|pending_approval`',
    `mmel_reference` STRING COMMENT 'Reference to the corresponding Master MEL item number and revision from the aircraft manufacturer or regulatory authority MMEL document.',
    `mmel_revision_date` DATE COMMENT 'The effective date of the MMEL revision from which this MEL item was derived.',
    `number_installed` STRING COMMENT 'The total number of units of this system or component installed on the aircraft type.',
    `number_required_dispatch` STRING COMMENT 'The minimum number of units that must be operative for the aircraft to be dispatched under this MEL item.',
    `operational_procedures` STRING COMMENT 'Specific operational procedures, limitations, or restrictions that flight crew must follow when dispatching with this item inoperative (e.g., Flight in icing conditions prohibited).',
    `operator_mel_revision` STRING COMMENT 'The operator-specific MEL document revision number under which this item is published.',
    `placard_location` STRING COMMENT 'The specific location where the placard must be installed (e.g., Overhead panel, Seat 12A armrest, Flight deck door).',
    `placard_required` BOOLEAN COMMENT 'Indicates whether a placard must be installed in the cockpit or cabin to inform crew of the inoperative item.',
    `placard_text` STRING COMMENT 'The exact text that must appear on the placard if placard_required is true (e.g., INOP, DO NOT USE).',
    `regulatory_approval_reference` STRING COMMENT 'Reference to the regulatory authority approval document or letter of acceptance for this MEL item (e.g., FAA OpSpec D085, EASA Part-CAT approval).',
    `remarks` STRING COMMENT 'Additional notes, clarifications, or special instructions related to this MEL item that do not fit in other structured fields.',
    CONSTRAINT pk_mel_item PRIMARY KEY(`mel_item_id`)
) COMMENT 'Minimum Equipment List (MEL) item master defining approved deferral conditions for inoperative aircraft systems or components. Captures ATA chapter, MEL item number, revision, deferral category (A/B/C/D), maximum deferral period, operational/maintenance procedures required, placard requirements, dispatch conditions, and MMEL (Master MEL) reference. SSOT for MEL configuration per aircraft type.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`mel_deferral` (
    `mel_deferral_id` BIGINT COMMENT 'Unique identifier for the MEL deferral instance. Primary key.',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Commander accepts MEL deferral and operational restrictions before flight. Business process: crew acceptance of deferred defects, operational decision tracking, regulatory compliance (commander must a',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: MEL deferrals are aircraft-specific airworthiness documents — regulators require tracking which aircraft is dispatched with a deferred defect, expiry dates per tail, and open deferral counts. Fundamen',
    `defect_report_id` BIGINT COMMENT 'Identifier of the associated defect report or pilot write-up that triggered the MEL deferral.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: MEL deferrals opened at specific stations. Links deferral_station_code to station.station_id for regulatory compliance tracking by location, identifying stations with high deferral rates, and ensuring',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: MEL deferral time limits (Cat A/B/C/D) start from the sector where the defect was deferred. Compliance monitoring requires knowing the originating flight_leg. Aviation domain experts universally expec',
    `mel_item_id` BIGINT COMMENT 'Foreign key linking to maintenance.mel_item. Business justification: MEL deferral is based on a MEL item definition. The mel_deferral table has mel_item_reference (STRING) but no FK. Adding maintenance_mel_item_id FK normalizes this and removes redundant mel_item_refer',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: MEL deferrals may result from safety occurrences (e.g., in-flight malfunction deferred under MEL). Tracking this link supports risk management, regulatory reporting, and analysis of deferral impact on',
    `work_order_id` BIGINT COMMENT 'Identifier of the maintenance work order created to rectify the deferred item. Null if not yet created.',
    `aog_risk_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this deferral poses a high risk of causing an AOG event if not rectified promptly (true) or not (false).',
    `certifying_staff_license_number` STRING COMMENT 'The license or authorization number of the certifying staff who approved the deferral.',
    `closure_date` DATE COMMENT 'The date on which the MEL deferral record was administratively closed in the maintenance system. Null if still open.',
    `closure_remarks` STRING COMMENT 'Free-text remarks or notes recorded when the deferral was closed, including any follow-up actions or observations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this MEL deferral record was first created in the maintenance system.',
    `deferral_description` STRING COMMENT 'Free-text description of the inoperative item and the nature of the deferral, including any operational restrictions or procedures.',
    `deferral_expiry_date` DATE COMMENT 'The date by which the deferred item must be rectified according to the MEL category interval. Null if no expiry applies (Category A).',
    `deferral_open_date` DATE COMMENT 'The date on which the MEL deferral was opened and the item was deferred from service.',
    `deferral_open_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the MEL deferral was opened in the maintenance system.',
    `deferral_status` STRING COMMENT 'Current lifecycle status of the MEL deferral: open (active), extended (interval extended), rectified (repair completed), closed (administratively closed), expired (exceeded allowed interval).. Valid values are `open|extended|rectified|closed|expired`',
    `extension_authority` STRING COMMENT 'The name or identifier of the authority (e.g., Chief Engineer, Maintenance Control) who approved the deferral extension.',
    `extension_count` STRING COMMENT 'The number of times the deferral expiry date has been extended beyond the original MEL category interval.',
    `flight_cycles_at_deferral` STRING COMMENT 'The total accumulated flight cycles (takeoff-landing cycles) on the aircraft at the time the MEL deferral was opened.',
    `flight_hours_at_deferral` DECIMAL(18,2) COMMENT 'The total accumulated flight hours (block hours) on the aircraft at the time the MEL deferral was opened.',
    `last_extension_date` DATE COMMENT 'The date of the most recent extension of the deferral expiry date. Null if never extended.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this MEL deferral record was last updated in the maintenance system.',
    `maintenance_procedures_applied` STRING COMMENT 'Description of any maintenance procedures or placarding actions performed when the deferral was opened (e.g., circuit breaker collared, placard installed).',
    `mel_category` STRING COMMENT 'The MEL category defining the operational constraints and rectification interval: A (no dispatch allowed), B (rectify within 3 days), C (rectify within 10 days), D (rectify within 120 days).. Valid values are `A|B|C|D`',
    `operational_restrictions` STRING COMMENT 'Specific operational restrictions or limitations imposed by the MEL deferral (e.g., flight altitude limits, route restrictions, weather minimums).',
    `rectification_date` DATE COMMENT 'The date on which the deferred item was rectified and returned to service. Null if not yet rectified.',
    `rectification_station_code` STRING COMMENT 'The IATA three-letter airport code of the station where the deferred item was rectified. Null if not yet rectified.. Valid values are `^[A-Z]{3}$`',
    `rectification_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the deferred item was rectified and the deferral was closed.',
    `regulatory_notification_date` DATE COMMENT 'The date on which the civil aviation authority was notified of this deferral. Null if notification not required or not yet sent.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether this deferral requires notification to the civil aviation authority (true) or not (false).',
    CONSTRAINT pk_mel_deferral PRIMARY KEY(`mel_deferral_id`)
) COMMENT 'Active MEL deferral instance recording a specific inoperative item deferred on a tail number under an approved MEL category. Captures tail number, MEL item reference, deferral open date, deferral expiry date, flight hours/cycles at deferral, station, authorising certifying staff, associated defect report, rectification work order, and closure details. Enables AOG risk monitoring and deferral expiry alerting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`component` (
    `component_id` BIGINT COMMENT 'Unique identifier for the aircraft component or rotable part record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft on which this component is currently installed, if applicable. Null if component is in shop or store.',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: component.maintenance_organization_code is a denormalized STRING reference to the maintenance organization responsible for the component. Replacing with a proper FK to maintenance.approved_maintenance',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Component tracking and rotable part logistics require knowing which station a component is currently located at. Aviation MRO operations depend on this for AOG dispatch, loan/exchange decisions, and i',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Rotable components meeting capitalization thresholds are fixed assets. Links component to asset record for depreciation tracking, NBV reporting, and asset disposal accounting.',
    `engine_id` BIGINT COMMENT 'Foreign key linking to fleet.engine. Business justification: When a maintenance.component record represents an engine module or LLP, it must reference the fleet.engine asset record for TSN/CSN reconciliation, LLP life tracking, and lease return condition verifi',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Specific components may be associated with identified hazards (design flaws, known failure modes). Link supports component-level risk tracking, informs procurement decisions, and enables targeted moni',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Components on leased aircraft must track lease contract for lease return inventory reconciliation, maintenance reserve claims, and lessor asset tracking. Required for lease return audits.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase or acquisition cost of the component in the airlines functional currency. Used for asset valuation and depreciation calculations.',
    `airworthiness_certificate_date` DATE COMMENT 'Issue date of the current airworthiness release certificate for this component.',
    `airworthiness_certificate_number` STRING COMMENT 'Unique reference number of the airworthiness release certificate (EASA Form 1, FAA 8130-3, or equivalent) certifying this component as airworthy and fit for installation.. Valid values are `^[A-Z0-9-/]{5,30}$`',
    `airworthiness_certificate_type` STRING COMMENT 'Type of airworthiness release certificate accompanying this component. EASA Form 1, FAA Form 8130-3, and CAA CRS are the most common authorized release certificates.. Valid values are `easa_form_1|faa_8130_3|caa_crs|tcca_form_24_0078|other`',
    `ata_chapter` STRING COMMENT 'ATA iSpec 2200 chapter code classifying the component by aircraft system (e.g., 32 for landing gear, 71 for powerplant, 24 for electrical). Industry-standard taxonomy for aircraft systems.. Valid values are `^[0-9]{2}(-[0-9]{2}(-[0-9]{2})?)?$`',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number for batch-tracked components. Used for traceability in case of manufacturing defects or airworthiness directives. Null for serialized-only components.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `component_description` STRING COMMENT 'Detailed textual description of the component including type, function, and key characteristics. Used for identification and maintenance planning.',
    `condition_code` STRING COMMENT 'Two-letter ATA Spec 2000 condition code indicating the maintenance and airworthiness status of the component (e.g., AR=As Removed, OH=Overhauled, NE=New, RP=Repaired, SV=Serviceable).. Valid values are `^[A-Z]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this component record was first created in the maintenance system.',
    `criticality_classification` STRING COMMENT 'Classification of the components criticality to flight operations and safety. AOG-critical components ground the aircraft if unserviceable, flight-safety components affect airworthiness, operational components affect dispatch reliability.. Valid values are `aog_critical|flight_safety|operational|non_critical`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost and other monetary values associated with this component.. Valid values are `^[A-Z]{3}$`',
    `current_location_type` STRING COMMENT 'Type of location where the component is currently held. Aircraft indicates installed on aircraft, shop indicates undergoing maintenance, store indicates warehouse inventory, quarantine indicates awaiting inspection, scrap indicates condemned.. Valid values are `aircraft|shop|store|quarantine|scrap`',
    `cycles_remaining_to_limit` BIGINT COMMENT 'Flight cycles remaining before the component reaches its life limit or next scheduled maintenance event. Null if not applicable or unlimited.',
    `cycles_since_overhaul` BIGINT COMMENT 'Flight cycles accumulated since the last major overhaul or shop visit. Reset to zero after overhaul. Null if component has never been overhauled.',
    `installation_date` DATE COMMENT 'Date when the component was installed on the current aircraft. Null if component is not currently installed on an aircraft.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this component record was last updated in the maintenance system.',
    `last_overhaul_date` DATE COMMENT 'Date when the component last underwent major overhaul or shop visit. Null if component has never been overhauled.',
    `life_limited_part_flag` BOOLEAN COMMENT 'Indicates whether this component is a life-limited part subject to mandatory retirement at specified life limits per airworthiness directives. True if LLP, false otherwise.',
    `manufacture_date` DATE COMMENT 'Date when the component was originally manufactured by the OEM. Used for age-based maintenance requirements and warranty tracking.',
    `manufacturer_code` STRING COMMENT 'Standardized code identifying the component manufacturer. Typically ICAO or industry-standard manufacturer identifier.. Valid values are `^[A-Z0-9]{2,5}$`',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) who produced this component.',
    `owner_type` STRING COMMENT 'Ownership classification of the component. Owned indicates airline-owned, leased indicates leased from lessor, pooled indicates part of rotable pool agreement, consignment indicates supplier-owned inventory.. Valid values are `owned|leased|pooled|consignment|customer_furnished`',
    `part_number` STRING COMMENT 'Manufacturer part number identifying the component type. Standard alphanumeric identifier used across aviation industry for component cataloging.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `removal_date` DATE COMMENT 'Date when the component was last removed from an aircraft. Null if component has never been installed or is currently installed.',
    `removal_reason` STRING COMMENT 'Reason code for the last removal of this component from an aircraft. Used for reliability analysis and maintenance planning. [ENUM-REF-CANDIDATE: scheduled_maintenance|unscheduled_maintenance|defect|llp_limit|modification|aog|inspection|lease_return|other — 9 candidates stripped; promote to reference product]',
    `rotable_flag` BOOLEAN COMMENT 'Indicates whether this component is a rotable (repairable) part that can be overhauled and returned to service, as opposed to expendable parts. True if rotable, false if expendable.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this individual component instance. Enables traceability throughout component lifecycle.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `serviceable_status` STRING COMMENT 'Current airworthiness and serviceability status of the component. Serviceable indicates ready for installation, unserviceable indicates requires maintenance, quarantine indicates awaiting inspection. [ENUM-REF-CANDIDATE: serviceable|unserviceable|repairable|beyond_economic_repair|condemned|quarantine|inspection_required — 7 candidates stripped; promote to reference product]',
    `shelf_life_expiry_date` DATE COMMENT 'Date when the component reaches the end of its shelf life and must be inspected, tested, or scrapped. Applicable to time-sensitive components such as rubber seals, batteries, and life vests. Null if not applicable.',
    `time_remaining_to_limit` DECIMAL(18,2) COMMENT 'Flight hours remaining before the component reaches its life limit or next scheduled maintenance event. Measured in hours. Null if not applicable or unlimited.',
    `time_since_overhaul` DECIMAL(18,2) COMMENT 'Flight hours accumulated since the last major overhaul or shop visit. Measured in hours. Reset to zero after overhaul. Null if component has never been overhauled.',
    `total_cycles_since_new` BIGINT COMMENT 'Cumulative flight cycles (takeoff/landing cycles) accumulated by this component since original manufacture. Critical for fatigue-sensitive components and LLP tracking.',
    `total_time_since_new` DECIMAL(18,2) COMMENT 'Cumulative flight hours accumulated by this component since original manufacture. Measured in hours. Critical for life-limited part tracking and maintenance scheduling.',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturer or overhaul shop warranty for this component expires. Null if no warranty applies.',
    CONSTRAINT pk_component PRIMARY KEY(`component_id`)
) COMMENT 'Aircraft component and rotable part master record tracking individual serialised and batch-tracked parts across the fleet. Captures part number (P/N), serial number (S/N), ATA chapter, component description, manufacturer, life-limited part (LLP) flag, total time since new (TTSN), total cycles since new (TCSN), time since overhaul (TSO), cycles since overhaul (CSO), current location (aircraft/shop/store), airworthiness release certificate (CRS/Form 1/8130-3) reference, and serviceable/unserviceable status.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`technical_log` (
    `technical_log_id` BIGINT COMMENT 'Unique identifier for the aircraft technical log sector page record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: The technical log is the primary per-flight airworthiness document (EASA Part-M / FAA 14 CFR 91.417) and must be traceable to the specific aircraft for TSN/CSN accumulation, defect carry-forward, and ',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: technical_log.maintenance_organization_code is a denormalized STRING reference to the maintenance organization that performed the release. Replacing with a proper FK to maintenance.approved_maintenanc',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Aircraft commander signs technical log accepting aircraft airworthiness. Complements employee_id with crew operational context. Business process: commander accountability for airworthiness acceptance,',
    `alert_id` BIGINT COMMENT 'Foreign key linking to safety.alert. Business justification: A safety alert requiring pre-flight or daily checks generates technical log entries as compliance evidence. Linking technical_log to the alert that mandated the check is a real regulatory compliance t',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Technical log entries are attributed to cost centres for flight operations and line maintenance cost reporting. Aviation controllers allocate sector costs (fuel, line maintenance) to specific cost cen',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Technical logs record aircraft status at departure station. Links departure_station_code to station.station_id for airworthiness tracking by location, pre-flight inspection quality monitoring, and reg',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Each technical log entry records airworthiness status for a specific operated sector. Line maintenance, OCC, and airworthiness monitoring all require traceability from technical_log to the exact fligh',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Each technical log entry is a regulatory record for a specific flight sector. Linking to flight_number_id enables direct OTP analysis, crew duty tracking, and airworthiness record traceability per ope',
    `release_id` BIGINT COMMENT 'Foreign key linking to maintenance.release. Business justification: Technical log references a Certificate of Release to Service. The technical_log table has crs_reference_number (STRING) but no FK. Adding maintenance_release_id FK normalizes this and removes redundan',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Technical logs document in-flight occurrences (pilot reports of malfunctions, anomalies). Direct link enables correlation of pilot reports with formal safety investigations, supports occurrence data v',
    `report_id` BIGINT COMMENT 'Foreign key linking to safety.report. Business justification: Safety-reportable technical log entries (safety_reportable_flag) must be linked to the safety report filed against them. This is a direct ICAO/EASA regulatory traceability requirement — the safety rep',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Route-level reliability reporting (defect rates, delay minutes, component failure patterns per route) is a standard airline engineering KPI. Linking technical_log directly to route enables route perfo',
    `turnaround_id` BIGINT COMMENT 'Foreign key linking to airport.turnaround. Business justification: The technical log is the primary per-sector airworthiness document raised during each ground stop. Linking it to the turnaround enables integrated sector/ground event reporting, fuel and service recon',
    `aircraft_total_cycles` STRING COMMENT 'The cumulative total flight cycles (takeoff and landing pairs) at the end of this sector. Critical for fatigue-sensitive component life tracking.',
    `aircraft_total_hours` DECIMAL(18,2) COMMENT 'The cumulative total airframe hours at the end of this sector. Critical for maintenance scheduling and airworthiness compliance.',
    `airworthiness_directive_compliance` STRING COMMENT 'Notes or references to any Airworthiness Directives (ADs) complied with during this sector or affecting the aircrafts airworthiness status.',
    `arrival_station_code` STRING COMMENT 'The three-letter IATA airport code for the arrival station (e.g., LHR, JFK, SIN).. Valid values are `^[A-Z]{3}$`',
    `block_hours` DECIMAL(18,2) COMMENT 'The duration in hours from block off to block on for this sector. Used for maintenance interval tracking and crew duty time.',
    `block_off_timestamp` TIMESTAMP COMMENT 'The timestamp when the aircraft pushed back from the gate or commenced taxi for departure (Out time in OOOI). Marks the start of block hours.',
    `block_on_timestamp` TIMESTAMP COMMENT 'The timestamp when the aircraft arrived at the gate and parking brake was set (In time in OOOI). Marks the end of block hours.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this technical log sector page record was first created in the system. Used for audit trail and data lineage.',
    `crs_issued_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Release to Service was issued for maintenance work performed before or during this sector. True if CRS was issued, false otherwise.',
    `defects_raised_count` STRING COMMENT 'The number of new defects or discrepancies raised by the crew during or after this sector. Links to individual defect records.',
    `deferred_defects_carried_forward` STRING COMMENT 'A summary or list of deferred defect reference numbers carried forward from previous sectors and still active on this flight. Provides continuity of airworthiness status.',
    `flight_hours` DECIMAL(18,2) COMMENT 'The duration in hours from takeoff to landing for this sector. Used for airframe and engine life-limited parts tracking.',
    `fuel_remaining_kg` DECIMAL(18,2) COMMENT 'The quantity of fuel remaining at the end of the sector, measured in kilograms. Used for fuel planning and anomaly detection.',
    `fuel_uplift_kg` DECIMAL(18,2) COMMENT 'The quantity of fuel uplifted for this sector, measured in kilograms. Recorded for fuel management and performance monitoring.',
    `landing_timestamp` TIMESTAMP COMMENT 'The timestamp when the aircraft touched down on the runway (On time in OOOI). Used for flight cycle counting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this technical log sector page record was last modified. Used for audit trail and change tracking.',
    `mel_items_active_count` STRING COMMENT 'The number of MEL deferred defects active and carried forward on this sector. Indicates aircraft dispatch with inoperative equipment under MEL authority.',
    `oil_uplift_litres` DECIMAL(18,2) COMMENT 'The quantity of engine oil uplifted for this sector, measured in litres. Monitored for engine health and consumption trends.',
    `pre_flight_inspection_status` STRING COMMENT 'The outcome of the commanders pre-flight walk-around inspection. Indicates whether the aircraft was found airworthy or defects were noted.. Valid values are `satisfactory|defects_noted|inspection_deferred`',
    `remarks` STRING COMMENT 'Free-text remarks or notes entered by the commander, crew, or maintenance staff regarding this sector. May include operational notes, weather conditions, or other relevant observations.',
    `sector_date` DATE COMMENT 'The calendar date on which this flight sector was operated, in UTC.',
    `takeoff_timestamp` TIMESTAMP COMMENT 'The timestamp when the aircraft became airborne (Off time in OOOI). Used for flight cycle counting.',
    `technical_log_status` STRING COMMENT 'The current status of this technical log sector page record. Open indicates the sector is in progress or pending closure; closed indicates all entries are complete and signed off.. Valid values are `open|closed|under_review|archived`',
    CONSTRAINT pk_technical_log PRIMARY KEY(`technical_log_id`)
) COMMENT 'Aircraft technical log (ATL) sector page record capturing the official per-flight airworthiness and maintenance record as required by EASA Part-M / FAA 14 CFR 91.417. Records flight sector (departure/arrival), commander acceptance, pre-flight inspection status, fuel/oil state, defects raised by crew, MEL items active, deferred defects carried forward, CRS (Certificate of Release to Service) issued for rectification work, certifying staff licence number, and aircraft total hours/cycles at sector end. The legal airworthiness continuity document — must be retained for the life of the aircraft.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`release` (
    `release_id` BIGINT COMMENT 'Primary key for release',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: A Certificate of Release to Service (CRS) is issued for a specific aircraft under EASA Part-145/FAA regulations — the release must reference the aircraft for next-due interval tracking, total hours/cy',
    `airworthiness_directive_id` BIGINT COMMENT 'Foreign key linking to maintenance.airworthiness_directive. Business justification: release.airworthiness_directive_reference is a denormalized STRING. A Certificate of Release to Service (CRS) often references the specific AD that was complied with. Replacing with a proper FK to mai',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: Certificate of Release to Service is issued by an approved maintenance organization. The release table has part_145_organization_code (STRING) but no FK. Adding approved_maintenance_org_id FK normaliz',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.member. Business justification: A Certificate of Release to Service (CRS) must be signed by a licensed certifying staff member. Regulatory requirement (Part-145/Part-66) mandates traceability of the individual who released the aircr',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: A Certificate of Release to Service (CRS) clears the aircraft for a specific next departure flight_leg. Role-prefix cleared_ distinguishes this from the work_order FK already on release. Regulatory ',
    `component_id` BIGINT COMMENT 'Foreign key linking to maintenance.component. Business justification: Certificate of Release to Service may be for a component. The release table has component_part_number and component_serial_number but no FK. Adding component_id FK normalizes this and removes redundan',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Maintenance releases (CRS) issued at specific stations. Links maintenance_station_code to station.station_id for regulatory oversight, quality assurance tracking by location, and certifying staff auth',
    `mel_item_id` BIGINT COMMENT 'Foreign key linking to maintenance.mel_item. Business justification: release.mel_reference is a denormalized STRING. A CRS may reference the MEL item that was addressed or remains active. Replacing with a proper FK to maintenance.mel_item normalizes the relationship. N',
    `service_bulletin_id` BIGINT COMMENT 'Foreign key linking to maintenance.service_bulletin. Business justification: release.service_bulletin_reference is a denormalized STRING. A CRS often references the specific SB that was incorporated. Replacing with a proper FK to maintenance.service_bulletin normalizes the rel',
    `uld_id` BIGINT COMMENT 'Foreign key linking to cargo.uld. Business justification: After ULD repair, certifying staff issue a Certificate of Release to Service (CRS) returning the ULD to serviceable status. Aviation regulators (EASA Part-145, FAA) require a release record per repair',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Certificate of Release to Service is issued for a work order. The release table has work_order_number (STRING) but no FK. Adding work_order_id FK normalizes this and removes redundant work_order_numbe',
    `aircraft_total_cycles_at_release` STRING COMMENT 'Cumulative total flight cycles (takeoff and landing pairs) recorded on the aircraft at the time of release to service. Used for fatigue-sensitive component life tracking.',
    `aircraft_total_hours_at_release` DECIMAL(18,2) COMMENT 'Cumulative total flight hours (block hours) recorded on the aircraft at the time of release to service. Critical for life-limited parts tracking and maintenance interval calculations.',
    `aircraft_type_code` STRING COMMENT 'ICAO aircraft type designator for the aircraft model (e.g., B738 for Boeing 737-800, A320 for Airbus A320).. Valid values are `^[A-Z0-9]{3,7}$`',
    `approval_authority` STRING COMMENT 'National or regional aviation authority under whose regulations this release to service is issued (e.g., EASA, FAA, TCCA, CAAC). Determines applicable regulatory framework.. Valid values are `EASA|FAA|TCCA|CAAC|ANAC|CASA`',
    `ata_chapter` STRING COMMENT 'Two-digit ATA chapter code categorizing the aircraft system or component area covered by this maintenance release (e.g., 32 for Landing Gear, 71 for Powerplant).. Valid values are `^[0-9]{2}$`',
    `certifying_staff_authorization_reference` STRING COMMENT 'Internal authorization or stamp number issued by the Part-145 organization to the certifying staff, confirming their scope of approval within the AMO.',
    `component_cycles_at_release` STRING COMMENT 'Total operating cycles accumulated on the component at the time of release, applicable for component-level maintenance releases. Tracks cycles-since-new or cycles-since-overhaul.',
    `component_hours_at_release` DECIMAL(18,2) COMMENT 'Total operating hours accumulated on the component at the time of release, applicable for component-level maintenance releases. Tracks time-since-new or time-since-overhaul.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance release record was first created in the AMOS or maintenance management system. Audit trail for record creation.',
    `crs_number` STRING COMMENT 'Unique externally-known certificate number issued by the Part-145 approved maintenance organization certifying airworthiness release. Legally mandated document identifier.. Valid values are `^CRS[A-Z0-9]{8,15}$`',
    `digital_signature_hash` STRING COMMENT 'Cryptographic hash of the digital signature applied to the electronic CRS document, ensuring authenticity and non-repudiation of the release certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance release record was last updated or modified. Audit trail for record changes.',
    `maintenance_type` STRING COMMENT 'Classification of the maintenance activity certified by this release: scheduled check, unscheduled defect repair, airworthiness directive compliance, service bulletin incorporation, MEL rectification, AOG recovery, component overhaul, or aircraft modification. [ENUM-REF-CANDIDATE: scheduled|unscheduled|ad_compliance|sb_incorporation|mel_deferral_rectification|aog_recovery|component_overhaul|modification — 8 candidates stripped; promote to reference product]',
    `next_due_cycles` STRING COMMENT 'Aircraft total cycles at which the next scheduled maintenance action is due, as established or updated by this release. Used for maintenance planning and scheduling.',
    `next_due_date` DATE COMMENT 'Calendar date by which the next scheduled maintenance action is due, as established or updated by this release. Used for calendar-based maintenance intervals.',
    `next_due_hours` DECIMAL(18,2) COMMENT 'Aircraft total hours at which the next scheduled maintenance action is due, as established or updated by this release. Used for maintenance planning and scheduling.',
    `open_items_description` STRING COMMENT 'Description of any open maintenance items, deferred defects, or limitations that remain after this release. Documents any MEL deferrals or work not completed that affect operational capability.',
    `operational_limitations` STRING COMMENT 'Any operational restrictions or limitations imposed on the aircraft or component as a result of the maintenance performed or deferred items. May include speed, altitude, or route restrictions.',
    `release_category` STRING COMMENT 'Category of asset for which this release to service is issued: complete aircraft, engine, APU (Auxiliary Power Unit), line-replaceable component, or cabin interior.. Valid values are `aircraft|engine|apu|component|cabin`',
    `release_status` STRING COMMENT 'Current lifecycle status of the Certificate of Release to Service. Tracks whether the CRS is in draft, officially issued, superseded by a later release, or voided due to error.. Valid values are `draft|issued|superseded|voided|under_review`',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the certifying staff signed the Certificate of Release to Service, officially releasing the aircraft or component back to airworthy status. Principal business event timestamp for this transaction.',
    `remarks` STRING COMMENT 'Additional free-text remarks, notes, or clarifications provided by the certifying staff regarding the release to service. May include special instructions or observations.',
    `scope_of_work_description` STRING COMMENT 'Detailed narrative description of the maintenance tasks, inspections, repairs, modifications, or component replacements performed under this release. Summarizes the work certified as airworthy.',
    CONSTRAINT pk_release PRIMARY KEY(`release_id`)
) COMMENT 'Certificate of Release to Service (CRS) record issued by Part-145 certifying staff confirming that maintenance work has been completed satisfactorily and the aircraft or component is airworthy for return to service. Captures CRS number, work order reference, certifying staff name and licence number, approval organisation (Part-145 AMO), scope of work, date/time of release, aircraft hours/cycles at release, and any open items or limitations. Legally mandated airworthiness release document.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` (
    `approved_maintenance_org_id` BIGINT COMMENT 'Unique identifier for the Part-145 approved maintenance organisation record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: External MROs generate AP invoices for services rendered. Links MRO to their invoices for vendor payment tracking, spend analysis, and contract compliance verification.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.audit. Business justification: Maintenance organizations are audited (Part-145 audits, IOSA). Link tracks audit history and findings against specific MROs, supports vendor quality management, and enables audit-driven MRO selection ',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: In multi-entity airline groups, AMO contracts are held by specific legal entities/company codes for intercompany accounting and tax purposes. Aviation finance requires AMO-to-company-code mapping for ',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: AMOs operate at specific airport stations; this link supports station-level maintenance capability queries, AOG response planning, and contract management. Aviation experts expect AMOs to be formally ',
    `accountable_manager_name` STRING COMMENT 'Name of the accountable manager responsible for ensuring the maintenance organisation complies with Part-145 requirements.',
    `address_line1` STRING COMMENT 'Primary street address line of the maintenance organisation facility.',
    `address_line2` STRING COMMENT 'Secondary street address line (building, suite, floor) of the maintenance organisation facility.',
    `airframe_rating_flag` BOOLEAN COMMENT 'Indicates whether the organisation holds airframe maintenance rating approval.',
    `aog_support_available_flag` BOOLEAN COMMENT 'Indicates whether the maintenance organisation provides 24/7 AOG (Aircraft on Ground) emergency support services.',
    `approval_expiry_date` DATE COMMENT 'Date when the Part-145 approval certificate expires and requires renewal. Null if approval has no fixed expiry (continuous validity subject to surveillance).',
    `approval_issue_date` DATE COMMENT 'Date when the Part-145 approval certificate was originally issued by the regulatory authority.',
    `approval_number` STRING COMMENT 'Official Part-145 approval certificate number issued by the regulatory authority (e.g., EASA.145.1234, FAA-RS-ABC123).. Valid values are `^[A-Z0-9./-]{3,30}$`',
    `approval_scope` STRING COMMENT 'Textual description of the maintenance capabilities and ratings covered by the approval (e.g., Airframe rating: Boeing 737 series, Airbus A320 family; Engine rating: CFM56-7B; Component rating: Landing gear, hydraulics).',
    `approval_status` STRING COMMENT 'Current regulatory status of the Part-145 approval certificate: active, suspended, expired, revoked, or pending renewal.. Valid values are `active|suspended|expired|revoked|pending_renewal`',
    `apu_rating_flag` BOOLEAN COMMENT 'Indicates whether the organisation holds Auxiliary Power Unit (APU) maintenance rating approval.',
    `audit_findings_count` STRING COMMENT 'Number of open audit findings or corrective action requests from the last audit.',
    `avionics_rating_flag` BOOLEAN COMMENT 'Indicates whether the organisation holds avionics and electrical systems maintenance rating approval.',
    `capability_list_reference` STRING COMMENT 'Reference identifier or document number for the detailed capability list (CoA appendix) that enumerates specific aircraft types, engines, and components the organisation is approved to maintain.',
    `city` STRING COMMENT 'City where the maintenance organisation facility is located.',
    `component_rating_flag` BOOLEAN COMMENT 'Indicates whether the organisation holds component maintenance rating approval (e.g., landing gear, avionics, hydraulics).',
    `contact_email` STRING COMMENT 'Primary contact email address for the maintenance organisation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact telephone number for the maintenance organisation.',
    `contract_end_date` DATE COMMENT 'Expiry or termination date of the commercial maintenance services contract. Null for open-ended contracts.',
    `contract_start_date` DATE COMMENT 'Effective start date of the commercial maintenance services contract.',
    `contract_status` STRING COMMENT 'Status of the commercial contract with the third-party MRO provider: active, inactive, pending, or terminated. Not applicable for internal maintenance organisations.. Valid values are `active|inactive|pending|terminated`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the maintenance organisation is registered and operates (e.g., DEU, USA, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this approved maintenance organisation record was first created in the system.',
    `engine_rating_flag` BOOLEAN COMMENT 'Indicates whether the organisation holds engine maintenance rating approval.',
    `issuing_authority` STRING COMMENT 'National or regional aviation authority that issued the Part-145 approval certificate (e.g., EASA, FAA, CAAC, TCCA, CASA, ANAC, DGCA). [ENUM-REF-CANDIDATE: EASA|FAA|CAAC|TCCA|CASA|ANAC|DGCA — 7 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent regulatory or internal audit conducted at the maintenance organisation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this approved maintenance organisation record was last modified.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next regulatory surveillance audit or internal quality audit.',
    `organization_code` STRING COMMENT 'Internal short code or identifier for the maintenance organisation used in operational systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `organization_name` STRING COMMENT 'Legal name of the approved maintenance organisation (AMO) as registered with the issuing authority.',
    `organization_type` STRING COMMENT 'Classification of the maintenance organisation: internal base maintenance, internal line maintenance, third-party MRO provider, OEM service center, component repair shop, or engine overhaul shop.. Valid values are `internal_base|internal_line|third_party_mro|oem_service_center|component_shop|engine_shop`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the maintenance organisation facility address.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this maintenance organisation is designated as a preferred or strategic vendor for outsourced MRO services.',
    `quality_rating` DECIMAL(18,2) COMMENT 'Internal quality performance rating score for the maintenance organisation, typically on a scale of 0.00 to 5.00, based on defect rates, on-time delivery, and audit results.',
    CONSTRAINT pk_approved_maintenance_org PRIMARY KEY(`approved_maintenance_org_id`)
) COMMENT 'Part-145 Approved Maintenance Organisation (AMO) master record for internal base/line maintenance and contracted third-party MRO providers. Captures organisation name, ICAO/IATA station code, approval number, issuing authority (EASA Part-145, FAA Part-145 Repair Station, CAAC CCAR-145), approval scope (airframe rating, engine rating, component rating, avionics rating), capability list reference, approval expiry date, audit history, and commercial contract status. SSOT for MRO vendor qualification, regulatory approval tracking, and outsourced maintenance governance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` (
    `ad_incorporation_id` BIGINT COMMENT 'Primary key for the ad_incorporation association',
    `airworthiness_directive_id` BIGINT COMMENT 'Foreign key linking to the Airworthiness Directive being incorporated into the program',
    `program_id` BIGINT COMMENT 'Foreign key linking to the Maintenance Program (AMP) into which the AD is incorporated',
    `ad_compliance_status` STRING COMMENT 'Overall compliance status of Airworthiness Directives (ADs) incorporated into this maintenance program. [Moved from program: This is a rolled-up summary of AD compliance across all incorporated ADs. The per-AD compliance status belongs at the ad_incorporation level (incorporation_status attribute), not as a single aggregate on the program. The program-level field should be derived or replaced by querying the association table.]. Valid values are `compliant|pending|overdue|not_applicable`',
    `applicability_override` STRING COMMENT 'Operator or CAMO-specific applicability determination that narrows, clarifies, or overrides the ADs general applicability statement for this specific programs fleet effectivity (e.g., restricted to MSN range 1234-5678 within this operators fleet).',
    `compliance_method` STRING COMMENT 'The specific compliance method selected for this program-AD combination. May differ from the ADs default compliance_method if an AMOC was approved or if the operator selected an alternative from the ADs options.',
    `effective_date` DATE COMMENT 'Date on which this AD incorporation became effective within the specific maintenance program. May differ from the ADs own effective date if the CAMO obtained a deferred compliance approval.',
    `incorporation_status` STRING COMMENT 'Current status of this ADs incorporation into the program. INCORPORATED=AD is fully embedded in the program tasks; DEFERRED=incorporation approved for later revision; NOT_APPLICABLE=CAMO has determined this AD does not apply to this programs effectivity; PENDING=under review.',
    `revision_reference` STRING COMMENT 'The program revision identifier at which this AD was formally incorporated (e.g., Rev 12, Amendment 4). Provides traceability for regulatory audits showing when the AD entered the program.',
    CONSTRAINT pk_ad_incorporation PRIMARY KEY(`ad_incorporation_id`)
) COMMENT 'This association product represents the formal incorporation of an Airworthiness Directive into a specific Maintenance Program (AMP). It captures the regulatory compliance contract between a program and an AD — tracking incorporation status, compliance method selected for this program, effective date of incorporation, the program revision at which the AD was incorporated, and any operator-specific applicability overrides. Each record is a live regulatory obligation managed by the CAMO and subject to airworthiness authority audit.. Existence Justification: In aviation MRO operations, a Maintenance Program (AMP) formally incorporates multiple Airworthiness Directives, and a single AD applies to multiple maintenance programs (e.g., across different aircraft types or operator AMPs). Airlines and CAMOs actively manage an AD Incorporation or Program AD Compliance Matrix as a regulatory obligation — tracking which ADs are incorporated into which programs, at what revision, with what compliance method and status. This is not an analytical correlation; it is a live, audited, regulatory record that engineers create, update, and present to airworthiness authorities.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` (
    `sb_incorporation_id` BIGINT COMMENT 'Primary key for the sb_incorporation association',
    `program_id` BIGINT COMMENT 'Foreign key linking to the Approved Aircraft Maintenance Program (AMP) against which this Service Bulletin has been evaluated or incorporated.',
    `service_bulletin_id` BIGINT COMMENT 'Foreign key linking to the Service Bulletin that has been evaluated or incorporated within this maintenance program.',
    `applicability_decision` STRING COMMENT 'CAMO determination of whether this Service Bulletin is applicable to the aircraft effectivity covered by this maintenance program. A single SB may be applicable to one program but not another depending on MSN range, configuration, or modification state.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost (USD) to implement this Service Bulletin within the context of this specific maintenance program, accounting for program-specific labor rates, scheduled maintenance opportunities, and fleet size. Distinct from the generic OEM cost estimate on the service_bulletin record, which does not account for program-specific factors.',
    `incorporation_date` DATE COMMENT 'Date on which the CAMO formally incorporated or closed out this Service Bulletin within this maintenance program. Null if status is UNDER_EVALUATION or DEFERRED. Belongs to the program-SB relationship, not to the SB or program independently.',
    `incorporation_status` STRING COMMENT 'Current CAMO decision status for this Service Bulletin within this specific maintenance program. Indicates whether the SB has been formally incorporated into the program, deferred to a future revision, determined not applicable, or is still under evaluation. This status belongs to the program-SB combination, not to either entity alone.',
    `revision_incorporated` STRING COMMENT 'The specific revision level of the Service Bulletin that was incorporated into this maintenance program (e.g., Rev 3, Original). Tracks which SB revision the program is aligned to, enabling traceability when the OEM issues subsequent SB revisions.',
    `sb_incorporation_status` STRING COMMENT 'Status of manufacturer Service Bulletin (SB) incorporation into this maintenance program. [Moved from program: This attribute on program is a scalar summary of overall SB incorporation status for the entire program. The per-SB incorporation status for each program-SB combination belongs in the sb_incorporation association, where it can be tracked at the individual SB level with full detail. The program-level summary field conflates what should be granular per-SB records into a single string, losing all per-SB traceability.]. Valid values are `current|pending|partial|not_applicable`',
    CONSTRAINT pk_sb_incorporation PRIMARY KEY(`sb_incorporation_id`)
) COMMENT 'This association product represents the formal SB Incorporation contract between a maintenance program and a service bulletin. It captures the CAMOs official evaluation and embodiment decision for each Service Bulletin within a specific Approved Aircraft Maintenance Program (AMP), including incorporation status, decision date, revision level incorporated, and program-level cost estimate. Each record links one program to one service_bulletin and holds attributes that exist only in the context of this program-SB combination, supporting EASA Part-M/Part-CAMO regulatory compliance reporting and lessor SB status reporting.. Existence Justification: In MRO aviation operations, airlines formally manage an SB Incorporation Matrix — a structured record of which Service Bulletins have been evaluated, incorporated, deferred, or rejected for each Approved Aircraft Maintenance Program (AMP). This is an actively managed operational concept: maintenance planners create, update, and close these records as SBs are issued by OEMs and evaluated against each programs scope, configuration, and regulatory requirements. A single AMP covers multiple SBs (e.g., all applicable Airbus SBs for an A320 fleet program), and a single SB may be evaluated against multiple AMPs (e.g., an Airbus SB applicable to both narrow-body and wide-body programs operated by the same airline). The relationship carries its own data — incorporation status, decision date, revision incorporated, and cost estimate — that belongs to neither the program nor the SB alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_airworthiness_directive_id` FOREIGN KEY (`airworthiness_directive_id`) REFERENCES `airlines_ecm`.`maintenance`.`airworthiness_directive`(`airworthiness_directive_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_mel_item_id` FOREIGN KEY (`mel_item_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_item`(`mel_item_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `airlines_ecm`.`maintenance`.`program`(`program_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_service_bulletin_id` FOREIGN KEY (`service_bulletin_id`) REFERENCES `airlines_ecm`.`maintenance`.`service_bulletin`(`service_bulletin_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_airworthiness_directive_id` FOREIGN KEY (`airworthiness_directive_id`) REFERENCES `airlines_ecm`.`maintenance`.`airworthiness_directive`(`airworthiness_directive_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_defect_report_id` FOREIGN KEY (`defect_report_id`) REFERENCES `airlines_ecm`.`maintenance`.`defect_report`(`defect_report_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_mel_deferral_id` FOREIGN KEY (`mel_deferral_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_deferral`(`mel_deferral_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_service_bulletin_id` FOREIGN KEY (`service_bulletin_id`) REFERENCES `airlines_ecm`.`maintenance`.`service_bulletin`(`service_bulletin_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ADD CONSTRAINT `fk_maintenance_program_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_program_id` FOREIGN KEY (`program_id`) REFERENCES `airlines_ecm`.`maintenance`.`program`(`program_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_airworthiness_directive_id` FOREIGN KEY (`airworthiness_directive_id`) REFERENCES `airlines_ecm`.`maintenance`.`airworthiness_directive`(`airworthiness_directive_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_airworthiness_directive_id` FOREIGN KEY (`airworthiness_directive_id`) REFERENCES `airlines_ecm`.`maintenance`.`airworthiness_directive`(`airworthiness_directive_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_mel_item_id` FOREIGN KEY (`mel_item_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_item`(`mel_item_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_defect_report_id` FOREIGN KEY (`defect_report_id`) REFERENCES `airlines_ecm`.`maintenance`.`defect_report`(`defect_report_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_mel_item_id` FOREIGN KEY (`mel_item_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_item`(`mel_item_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ADD CONSTRAINT `fk_maintenance_component_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_release_id` FOREIGN KEY (`release_id`) REFERENCES `airlines_ecm`.`maintenance`.`release`(`release_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_airworthiness_directive_id` FOREIGN KEY (`airworthiness_directive_id`) REFERENCES `airlines_ecm`.`maintenance`.`airworthiness_directive`(`airworthiness_directive_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_mel_item_id` FOREIGN KEY (`mel_item_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_item`(`mel_item_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_service_bulletin_id` FOREIGN KEY (`service_bulletin_id`) REFERENCES `airlines_ecm`.`maintenance`.`service_bulletin`(`service_bulletin_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ADD CONSTRAINT `fk_maintenance_ad_incorporation_airworthiness_directive_id` FOREIGN KEY (`airworthiness_directive_id`) REFERENCES `airlines_ecm`.`maintenance`.`airworthiness_directive`(`airworthiness_directive_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ADD CONSTRAINT `fk_maintenance_ad_incorporation_program_id` FOREIGN KEY (`program_id`) REFERENCES `airlines_ecm`.`maintenance`.`program`(`program_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ADD CONSTRAINT `fk_maintenance_sb_incorporation_program_id` FOREIGN KEY (`program_id`) REFERENCES `airlines_ecm`.`maintenance`.`program`(`program_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ADD CONSTRAINT `fk_maintenance_sb_incorporation_service_bulletin_id` FOREIGN KEY (`service_bulletin_id`) REFERENCES `airlines_ecm`.`maintenance`.`service_bulletin`(`service_bulletin_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`maintenance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `airlines_ecm`.`maintenance` SET TAGS ('dbx_domain' = 'maintenance');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_subdomain' = 'work_orders');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Organization ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Engine Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `mel_item_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Mitigating Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `service_bulletin_id` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `uld_id` SET TAGS ('dbx_business_glossary_term' = 'Uld Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_man_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Man-Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `aog_flag` SET TAGS ('dbx_business_glossary_term' = 'AOG (Aircraft on Ground) Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `ata_chapter_code` SET TAGS ('dbx_business_glossary_term' = 'ATA (Air Transport Association) Chapter Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `ata_chapter_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}(-[0-9]{2}(-[0-9]{2})?)?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `crs_reference` SET TAGS ('dbx_business_glossary_term' = 'CRS (Certificate of Release to Service) Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `deferral_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Deferral Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_man_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Man-Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `maintenance_check_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Check Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Work Order Notes');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `originating_source` SET TAGS ('dbx_business_glossary_term' = 'Originating Source');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `part_145_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Part-145 Approval Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|routine');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `scheduled_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO[0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|deferred|completed|closed|cancelled');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'scheduled|unscheduled|aog|modification|inspection|defect_rectification');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` SET TAGS ('dbx_subdomain' = 'work_orders');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Addressing Audit Finding Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Technician Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `defect_report_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Identified Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `mel_deferral_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Deferral Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `service_bulletin_id` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `ata_section` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Section');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `deferral_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Deferral Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `deferral_flag` SET TAGS ('dbx_business_glossary_term' = 'Deferral Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `inspector_license_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector License Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `inspector_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `inspector_signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspector Sign-Off Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `installed_component_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Installed Component Serial Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `materials_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Materials Cost Amount');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `removed_component_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Removed Component Serial Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `skill_trade_required` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Required');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `skill_trade_required` SET TAGS ('dbx_value_regex' = 'avionics|airframe|powerplant|electrical|hydraulic|composite');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Task Card Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_notes` SET TAGS ('dbx_business_glossary_term' = 'Task Notes');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Start Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|deferred|cancelled');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'inspection|repair|replacement|modification|lubrication|servicing');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `technician_license_number` SET TAGS ('dbx_business_glossary_term' = 'Technician License Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `technician_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `technician_signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Technician Sign-Off Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_location` SET TAGS ('dbx_value_regex' = 'hangar|line|shop|vendor');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` SET TAGS ('dbx_subdomain' = 'compliance_planning');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `aoc_number` SET TAGS ('dbx_business_glossary_term' = 'Air Operator Certificate (AOC) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `aoc_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `camo_organization` SET TAGS ('dbx_business_glossary_term' = 'Continuing Airworthiness Management Organization (CAMO)');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `effectivity_configuration` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Configuration');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `effectivity_serial_numbers` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Serial Numbers');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `escalation_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Escalation Approval Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `escalation_factor` SET TAGS ('dbx_business_glossary_term' = 'Escalation Factor');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `interval_structure` SET TAGS ('dbx_business_glossary_term' = 'Interval Structure Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `interval_structure` SET TAGS ('dbx_value_regex' = 'flight_hours|flight_cycles|calendar_days|combined');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `mel_reference` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `mpd_baseline` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Planning Document (MPD) Baseline');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Program Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'amp|cmp|emp|sampling|msg3|other');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `reliability_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Reliability Program Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Program Revision Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `revision` SET TAGS ('dbx_value_regex' = '^[A-Z0-9./-]{1,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` SET TAGS ('dbx_subdomain' = 'work_orders');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Check Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Addressing Audit Finding Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `aircraft_lease_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Lease Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Alert Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Program ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `actual_induction_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Induction Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `actual_man_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Man-Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `airworthiness_directives_complied` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directives (ADs) Complied');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `aog_event_flag` SET TAGS ('dbx_business_glossary_term' = 'AOG (Aircraft on Ground) Event Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `check_status` SET TAGS ('dbx_business_glossary_term' = 'Check Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `check_status` SET TAGS ('dbx_value_regex' = 'planned|scheduled|in-progress|completed|deferred|cancelled');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Check Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `check_type` SET TAGS ('dbx_value_regex' = 'A-check|B-check|C-check|D-check|line check|transit check');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check Completion Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `defects_found_count` SET TAGS ('dbx_business_glossary_term' = 'Defects Found Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `downtime_days` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Downtime Days');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Check Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `due_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Due Flight Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `due_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Due Flight Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `interval_days` SET TAGS ('dbx_business_glossary_term' = 'Check Interval Days');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `interval_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Check Interval Flight Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `interval_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Check Interval Flight Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `mel_deferrals_count` SET TAGS ('dbx_business_glossary_term' = 'MEL (Minimum Equipment List) Deferrals Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Check Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `next_due_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Next Due Flight Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `next_due_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Next Due Flight Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `planned_man_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Man-Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `release_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Release to Service (CRS) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `release_certificate_number` SET TAGS ('dbx_value_regex' = '^CRS[0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Check Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `scheduled_induction_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Induction Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `scheduled_release_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Release Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `service_bulletins_incorporated` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletins Incorporated');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` SET TAGS ('dbx_subdomain' = 'compliance_planning');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `ad_number` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `ad_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `ad_status` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `ad_status` SET TAGS ('dbx_value_regex' = 'active|superseded|cancelled|proposed|interim');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `aircraft_type` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `airworthiness_directive_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `alternative_compliance_method` SET TAGS ('dbx_business_glossary_term' = 'Alternative Compliance Method');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `applicability` SET TAGS ('dbx_business_glossary_term' = 'Applicability');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `compliance_interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Compliance Interval Unit');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `compliance_interval_unit` SET TAGS ('dbx_value_regex' = 'FH|FC|days|months|years');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `compliance_interval_value` SET TAGS ('dbx_business_glossary_term' = 'Compliance Interval Value');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `compliance_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Method');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `compliance_method` SET TAGS ('dbx_value_regex' = 'one-time|repetitive|terminating');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `compliance_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Unit');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `compliance_threshold_unit` SET TAGS ('dbx_value_regex' = 'FH|FC|days|months|years');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `compliance_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Value');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'airframe|engine|propeller|appliance|APU');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `estimated_cost_per_aircraft` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Aircraft');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `estimated_cost_per_aircraft` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `part_number_affected` SET TAGS ('dbx_business_glossary_term' = 'Part Number Affected');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `serial_number_range` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Subject');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `superseded_ad_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded Airworthiness Directive (AD) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` SET TAGS ('dbx_subdomain' = 'compliance_planning');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `ad_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Compliance ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Related Alert Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Airworthiness Directive Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `accomplishment_date` SET TAGS ('dbx_business_glossary_term' = 'Accomplishment Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `accomplishment_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Accomplishment Flight Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `accomplishment_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Accomplishment Flight Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `ad_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Effective Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `amoc_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Alternative Method of Compliance (AMOC) Approval Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `amoc_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Method of Compliance (AMOC) Approval Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `applicability` SET TAGS ('dbx_business_glossary_term' = 'Applicability');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `certifying_mechanic_license_number` SET TAGS ('dbx_business_glossary_term' = 'Certifying Mechanic License Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `certifying_mechanic_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `compliance_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Method');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `compliance_method` SET TAGS ('dbx_value_regex' = 'inspection|modification|replacement|operational_limitation|alternative_method');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'open|complied|deferred|not_applicable|superseded|cancelled');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `deferral_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Deferral Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `deferral_reference` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `next_due_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Next Due Flight Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `next_due_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Next Due Flight Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `repetitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Repetitive Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `repetitive_interval_cycles` SET TAGS ('dbx_business_glossary_term' = 'Repetitive Interval Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `repetitive_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Repetitive Interval Days');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `repetitive_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'Repetitive Interval Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `superseded_by_ad_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Airworthiness Directive (AD) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` SET TAGS ('dbx_subdomain' = 'compliance_planning');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `service_bulletin_id` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `aircraft_model_applicability` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Model Applicability');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}(-[0-9]{2})?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `bulletin_category` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `bulletin_category` SET TAGS ('dbx_value_regex' = 'Mandatory|Recommended|Optional|Alert|Information');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `bulletin_number` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `bulletin_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}-[0-9]{2,6}(-[A-Z0-9]{1,4})?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `bulletin_title` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Title');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `bulletin_type` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `bulletin_type` SET TAGS ('dbx_value_regex' = 'Service Bulletin|Service Letter|Alert Service Bulletin|All Operators Message|Technical Bulletin|Product Improvement');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `compliance_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Compliance Completion Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Compliance Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Deferred|Not Applicable|Cancelled');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `compliance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Compliance Threshold');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `effectivity` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Effectivity');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `engine_model_applicability` SET TAGS ('dbx_business_glossary_term' = 'Engine Model Applicability');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost in United States Dollars (USD)');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `estimated_man_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Maintenance Man-Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Active Indicator');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Issue Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `oem_name` SET TAGS ('dbx_business_glossary_term' = 'Original Equipment Manufacturer (OEM) Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `part_numbers_affected` SET TAGS ('dbx_business_glossary_term' = 'Affected Part Numbers');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `reason_for_issue` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Reason for Issue');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Revision Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Revision Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$|^[A-Z]$|^Original$');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `superseded_bulletin_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded Service Bulletin (SB) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `technical_description` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Technical Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` SET TAGS ('dbx_subdomain' = 'work_orders');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `defect_report_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Report ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Identified Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `mel_item_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `uld_id` SET TAGS ('dbx_business_glossary_term' = 'Uld Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `aog_flag` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}(-[0-9]{2}(-[0-9]{2})?)?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `cdl_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Configuration Deviation List (CDL) Applicable Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Defect Closed Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `defect_number` SET TAGS ('dbx_business_glossary_term' = 'Defect Report Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `defect_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `defect_status` SET TAGS ('dbx_business_glossary_term' = 'Defect Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `defect_status` SET TAGS ('dbx_value_regex' = 'open|deferred|rectified|closed|cancelled');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `deferral_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deferral Expiry Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `discovery_phase` SET TAGS ('dbx_business_glossary_term' = 'Defect Discovery Phase');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `discovery_phase` SET TAGS ('dbx_value_regex' = 'pre-flight|in-flight|post-flight|hangar|line-maintenance|base-maintenance');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `mel_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Applicable Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `mel_category` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Deferral Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `mel_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `part_number_replaced` SET TAGS ('dbx_business_glossary_term' = 'Part Number Replaced');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `part_number_replaced` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `rectification_action_description` SET TAGS ('dbx_business_glossary_term' = 'Rectification Action Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `rectification_station_code` SET TAGS ('dbx_business_glossary_term' = 'Rectification Station Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `rectification_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `rectification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rectification Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_business_glossary_term' = 'Reported By Role');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_value_regex' = 'flight-crew|cabin-crew|maintenance-technician|quality-inspector|engineer');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `safety_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Reportable Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity Level');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|cosmetic');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` SET TAGS ('dbx_subdomain' = 'compliance_planning');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `mel_item_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Item Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `ata_section` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Section');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `ata_section` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `ata_subject` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Subject');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `ata_subject` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `deferral_category` SET TAGS ('dbx_business_glossary_term' = 'MEL Deferral Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `deferral_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `dispatch_conditions` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Conditions');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'MEL Item Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `maintenance_procedures` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Procedures');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `maximum_deferral_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Deferral Days');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `mel_item_number` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Item Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `mel_item_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{2}-[0-9]{2}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `mel_item_status` SET TAGS ('dbx_business_glossary_term' = 'MEL Item Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `mel_item_status` SET TAGS ('dbx_value_regex' = 'active|superseded|withdrawn|pending_approval');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `mmel_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Minimum Equipment List (MMEL) Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `mmel_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Master Minimum Equipment List (MMEL) Revision Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `number_installed` SET TAGS ('dbx_business_glossary_term' = 'Number of Units Installed');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `number_required_dispatch` SET TAGS ('dbx_business_glossary_term' = 'Number Required for Dispatch');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `operational_procedures` SET TAGS ('dbx_business_glossary_term' = 'Operational Procedures');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `operator_mel_revision` SET TAGS ('dbx_business_glossary_term' = 'Operator MEL Revision Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `placard_location` SET TAGS ('dbx_business_glossary_term' = 'Placard Location');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `placard_required` SET TAGS ('dbx_business_glossary_term' = 'Placard Required Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `placard_text` SET TAGS ('dbx_business_glossary_term' = 'Placard Text');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'MEL Item Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` SET TAGS ('dbx_subdomain' = 'compliance_planning');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `mel_deferral_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Deferral ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Accepting Commander Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `defect_report_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Report ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Deferral Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `mel_item_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Mel Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Related Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `aog_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Risk Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `certifying_staff_license_number` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff License Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `certifying_staff_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `closure_remarks` SET TAGS ('dbx_business_glossary_term' = 'Closure Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `deferral_description` SET TAGS ('dbx_business_glossary_term' = 'Deferral Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `deferral_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Deferral Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `deferral_open_date` SET TAGS ('dbx_business_glossary_term' = 'Deferral Open Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `deferral_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deferral Open Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `deferral_status` SET TAGS ('dbx_business_glossary_term' = 'Deferral Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `deferral_status` SET TAGS ('dbx_value_regex' = 'open|extended|rectified|closed|expired');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `extension_authority` SET TAGS ('dbx_business_glossary_term' = 'Extension Authority');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Extension Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `flight_cycles_at_deferral` SET TAGS ('dbx_business_glossary_term' = 'Flight Cycles at Deferral');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `flight_hours_at_deferral` SET TAGS ('dbx_business_glossary_term' = 'Flight Hours at Deferral');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `last_extension_date` SET TAGS ('dbx_business_glossary_term' = 'Last Extension Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `maintenance_procedures_applied` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Procedures Applied');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `mel_category` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `mel_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `operational_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Operational Restrictions');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `rectification_date` SET TAGS ('dbx_business_glossary_term' = 'Rectification Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `rectification_station_code` SET TAGS ('dbx_business_glossary_term' = 'Rectification Station Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `rectification_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `rectification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rectification Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Current Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `engine_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Engine Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `airworthiness_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Certificate Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `airworthiness_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Certificate Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `airworthiness_certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-/]{5,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `airworthiness_certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Certificate Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `airworthiness_certificate_type` SET TAGS ('dbx_value_regex' = 'easa_form_1|faa_8130_3|caa_crs|tcca_form_24_0078|other');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}(-[0-9]{2}(-[0-9]{2})?)?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_business_glossary_term' = 'Criticality Classification');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_value_regex' = 'aog_critical|flight_safety|operational|non_critical');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `current_location_type` SET TAGS ('dbx_business_glossary_term' = 'Current Location Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `current_location_type` SET TAGS ('dbx_value_regex' = 'aircraft|shop|store|quarantine|scrap');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `cycles_remaining_to_limit` SET TAGS ('dbx_business_glossary_term' = 'Cycles Remaining to Limit');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `cycles_since_overhaul` SET TAGS ('dbx_business_glossary_term' = 'Cycles Since Overhaul (CSO)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `last_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last Overhaul Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `life_limited_part_flag` SET TAGS ('dbx_business_glossary_term' = 'Life-Limited Part (LLP) Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `manufacturer_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `manufacturer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,5}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'owned|leased|pooled|consignment|customer_furnished');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number (P/N)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `rotable_flag` SET TAGS ('dbx_business_glossary_term' = 'Rotable Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (S/N)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `serviceable_status` SET TAGS ('dbx_business_glossary_term' = 'Serviceable Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `time_remaining_to_limit` SET TAGS ('dbx_business_glossary_term' = 'Time Remaining to Limit');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `time_since_overhaul` SET TAGS ('dbx_business_glossary_term' = 'Time Since Overhaul (TSO)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `total_cycles_since_new` SET TAGS ('dbx_business_glossary_term' = 'Total Cycles Since New (TCSN)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `total_time_since_new` SET TAGS ('dbx_business_glossary_term' = 'Total Time Since New (TTSN)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` SET TAGS ('dbx_subdomain' = 'work_orders');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `technical_log_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Log ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Commander Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Alert Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Departure Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `release_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Release Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Related Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `aircraft_total_cycles` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Cycles (Cumulative)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `aircraft_total_hours` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Hours (Cumulative)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `airworthiness_directive_compliance` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Compliance Notes');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `arrival_station_code` SET TAGS ('dbx_business_glossary_term' = 'Arrival Station Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `arrival_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `block_hours` SET TAGS ('dbx_business_glossary_term' = 'Block Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `block_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Block Off Timestamp (Out)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `block_on_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Block On Timestamp (In)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `crs_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'CRS (Certificate of Release to Service) Issued Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `defects_raised_count` SET TAGS ('dbx_business_glossary_term' = 'Defects Raised Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `deferred_defects_carried_forward` SET TAGS ('dbx_business_glossary_term' = 'Deferred Defects Carried Forward (Summary)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Flight Hours (Airborne Hours)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `fuel_remaining_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Remaining (Kilograms)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `fuel_uplift_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift (Kilograms)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `landing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Landing Timestamp (On)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `mel_items_active_count` SET TAGS ('dbx_business_glossary_term' = 'MEL (Minimum Equipment List) Items Active Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `oil_uplift_litres` SET TAGS ('dbx_business_glossary_term' = 'Oil Uplift (Litres)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `pre_flight_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Flight Inspection Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `pre_flight_inspection_status` SET TAGS ('dbx_value_regex' = 'satisfactory|defects_noted|inspection_deferred');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks (Free Text)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `sector_date` SET TAGS ('dbx_business_glossary_term' = 'Sector Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `takeoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Takeoff Timestamp (Off)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `technical_log_status` SET TAGS ('dbx_business_glossary_term' = 'Technical Log Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `technical_log_status` SET TAGS ('dbx_value_regex' = 'open|closed|under_review|archived');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` SET TAGS ('dbx_subdomain' = 'work_orders');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `release_id` SET TAGS ('dbx_business_glossary_term' = 'Release Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Cleared Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `mel_item_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `service_bulletin_id` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `uld_id` SET TAGS ('dbx_business_glossary_term' = 'Uld Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_total_cycles_at_release` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Cycles at Release');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_total_hours_at_release` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Hours at Release');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,7}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'EASA|FAA|TCCA|CAAC|ANAC|CASA');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `certifying_staff_authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff Authorization Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `component_cycles_at_release` SET TAGS ('dbx_business_glossary_term' = 'Component Cycles at Release');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `component_hours_at_release` SET TAGS ('dbx_business_glossary_term' = 'Component Hours at Release');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `crs_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Release to Service (CRS) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `crs_number` SET TAGS ('dbx_value_regex' = '^CRS[A-Z0-9]{8,15}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `digital_signature_hash` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Hash');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `next_due_cycles` SET TAGS ('dbx_business_glossary_term' = 'Next Due Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `next_due_hours` SET TAGS ('dbx_business_glossary_term' = 'Next Due Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `open_items_description` SET TAGS ('dbx_business_glossary_term' = 'Open Items Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `operational_limitations` SET TAGS ('dbx_business_glossary_term' = 'Operational Limitations');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `release_category` SET TAGS ('dbx_business_glossary_term' = 'Release Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `release_category` SET TAGS ('dbx_value_regex' = 'aircraft|engine|apu|component|cabin');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'draft|issued|superseded|voided|under_review');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release to Service Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Release Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `scope_of_work_description` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Organisation (AMO) ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `accountable_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Accountable Manager Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `airframe_rating_flag` SET TAGS ('dbx_business_glossary_term' = 'Airframe Rating Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `aog_support_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Support Available Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `approval_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Issue Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Certificate Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `approval_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9./-]{3,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `approval_scope` SET TAGS ('dbx_business_glossary_term' = 'Approval Scope Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending_renewal');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `apu_rating_flag` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Rating Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `avionics_rating_flag` SET TAGS ('dbx_business_glossary_term' = 'Avionics Rating Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `capability_list_reference` SET TAGS ('dbx_business_glossary_term' = 'Capability List Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `component_rating_flag` SET TAGS ('dbx_business_glossary_term' = 'Component Rating Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Commercial Contract Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `engine_rating_flag` SET TAGS ('dbx_business_glossary_term' = 'Engine Rating Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Authority');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `organization_code` SET TAGS ('dbx_business_glossary_term' = 'Organisation Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organisation Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Organisation Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `organization_type` SET TAGS ('dbx_value_regex' = 'internal_base|internal_line|third_party_mro|oem_service_center|component_shop|engine_shop');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating Score');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` SET TAGS ('dbx_subdomain' = 'compliance_planning');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` SET TAGS ('dbx_association_edges' = 'maintenance.program,maintenance.airworthiness_directive');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `ad_incorporation_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Incorporation - Ad Incorporation Id');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Incorporation - Airworthiness Directive Id');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Incorporation - Program Id');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `ad_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Compliance Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `ad_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|pending|overdue|not_applicable');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `applicability_override` SET TAGS ('dbx_business_glossary_term' = 'Applicability Override');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `compliance_method` SET TAGS ('dbx_business_glossary_term' = 'Program Compliance Method');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Effective Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `incorporation_status` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_incorporation` ALTER COLUMN `revision_reference` SET TAGS ('dbx_business_glossary_term' = 'Incorporating Revision Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` SET TAGS ('dbx_subdomain' = 'compliance_planning');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` SET TAGS ('dbx_association_edges' = 'maintenance.program,maintenance.service_bulletin');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `sb_incorporation_id` SET TAGS ('dbx_business_glossary_term' = 'Sb Incorporation - Sb Incorporation Id');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Sb Incorporation - Program Id');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `service_bulletin_id` SET TAGS ('dbx_business_glossary_term' = 'Sb Incorporation - Service Bulletin Id');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `applicability_decision` SET TAGS ('dbx_business_glossary_term' = 'SB Applicability Decision');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Program-Level SB Cost Estimate');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'SB Incorporation Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `incorporation_status` SET TAGS ('dbx_business_glossary_term' = 'SB Incorporation Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `revision_incorporated` SET TAGS ('dbx_business_glossary_term' = 'SB Revision Incorporated');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `sb_incorporation_status` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Incorporation Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`sb_incorporation` ALTER COLUMN `sb_incorporation_status` SET TAGS ('dbx_value_regex' = 'current|pending|partial|not_applicable');
