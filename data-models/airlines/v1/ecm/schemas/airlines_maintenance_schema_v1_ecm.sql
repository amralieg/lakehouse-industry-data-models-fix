-- Schema for Domain: maintenance | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`maintenance` COMMENT 'Aircraft MRO (Maintenance Repair and Overhaul) lifecycle management including scheduled and unscheduled maintenance, work orders, airworthiness directives (ADs), component life-limited parts tracking, MEL (Minimum Equipment List) deferrals, AOG (Aircraft on Ground) events, APU maintenance, Part-145 approved maintenance organisation records, and defect tracking. Aligns with AMOS Aircraft Maintenance and Engineering System.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the maintenance work order. Primary key for all MRO (Maintenance Repair and Overhaul) execution records.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Work orders performed by external MROs generate AP invoices. Links work order to vendor invoice for cost verification, payment processing, and audit trail of maintenance spend.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to safety.audit_finding. Business justification: Work orders may be raised to address audit findings (corrective maintenance for non-compliances). Link tracks finding closure and corrective action implementation, supports audit follow-up, and demons',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft on which this maintenance work order is being performed. Links to the aircraft master record.',
    `approved_maintenance_org_id` BIGINT COMMENT 'Reference to the AMO (Approved Maintenance Organisation) or Part-145 certified organization performing the work. Links to the maintenance organization master record.',
    `audit_event_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_event. Business justification: Work orders are sampled during maintenance audits to verify compliance with approved procedures, proper documentation, and certifying staff authorization. Linking work orders to audit events enables a',
    `certifying_staff_id` BIGINT COMMENT 'Reference to the licensed aircraft maintenance engineer who certified the work order completion and signed the Certificate of Release to Service (CRS). Links to the crew/engineer master record.',
    `alert_id` BIGINT COMMENT 'Foreign key linking to safety.alert. Business justification: Safety alerts may mandate maintenance actions (urgent inspections, modifications). Link tracks alert compliance, supports regulatory response tracking, and demonstrates timely implementation of safety',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Maintenance work orders incur costs that must be allocated to cost centers (maintenance bases, aircraft types). This FK enables cost tracking and budgeting for maintenance activities.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Work orders implement corrective actions from audits, investigations, occurrences. Direct link tracks action closure, supports SMS corrective action tracking, and demonstrates regulatory compliance wi',
    `recommendation_id` BIGINT COMMENT 'Foreign key linking to safety.recommendation. Business justification: Work orders implement safety recommendations from investigations, audits. Link tracks recommendation closure, supports SMS recommendation tracking, and demonstrates regulatory compliance with safety r',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Work orders on leased aircraft require lease contract linkage for maintenance reserve claims, lease return condition tracking, and lessor reporting. Critical for lease return inspections and MR billin',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Work orders may be generated to mitigate identified hazards (e.g., proactive modification to address known risk). Link tracks hazard control implementation, supports SMS hazard register closure, and d',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Work orders frequently originate from safety occurrences (bird strikes, incidents, accidents). Real-world airline process: occurrence triggers corrective maintenance work. Critical for causal tracking',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: MRO work orders frequently subcontracted to external Part-145 vendors. Tracks performing vendor (distinct from approved_maintenance_org approval holder) for invoice reconciliation, vendor performance ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Links corrective maintenance to parts procurement for cost allocation and AOG parts tracking. Real process: maintenance planners reference PO status when scheduling work; finance allocates material co',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Maintenance work orders are often driven by regulatory requirements (ADs, SBs, compliance checks). This FK links the work order to the regulatory requirement for compliance tracking and audit trail.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Work orders are executed at specific airport stations. Links station_code (plain text) to station.station_id for operational tracking, cost allocation by location, and maintenance capacity planning. E',
    `wildlife_strike_id` BIGINT COMMENT 'Foreign key linking to safety.wildlife_strike. Business justification: Wildlife strikes often require maintenance work orders (engine inspection, radome repair). Direct link for cost tracking, supports wildlife strike damage assessment, and enables analysis of strike-rel',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance work was completed and aircraft returned to service. Used for turnaround time analysis and maintenance efficiency metrics.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual labor cost incurred for the work order in the airlines reporting currency, calculated from actual man-hours and labor rates. Used for cost accounting and variance analysis.',
    `actual_man_hours` DECIMAL(18,2) COMMENT 'Actual labor hours expended on the work order, aggregated from technician time entries. Used for cost accounting, efficiency analysis, and maintenance program refinement.',
    `actual_material_cost` DECIMAL(18,2) COMMENT 'Actual material and parts cost incurred for the work order in the airlines reporting currency, aggregated from material requisitions and component removals. Used for cost accounting and inventory valuation.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance work commenced. Used for schedule adherence tracking and labor cost allocation.',
    `ad_reference` STRING COMMENT 'Reference to the Airworthiness Directive number if this work order is compliance with a mandatory AD. Format varies by authority (e.g., FAA AD 2023-01-01, EASA AD 2023-0001).',
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
    `mel_reference` STRING COMMENT 'Reference to the MEL item number if this work order is a deferred defect under MEL authority. Indicates the regulatory deferral category (A, B, C, D) and item number.',
    `notes` STRING COMMENT 'Additional free-text notes, remarks, or special instructions related to the work order. May include coordination notes, parts availability updates, or engineering disposition.',
    `originating_source` STRING COMMENT 'The trigger or authority that initiated this work order. AD (Airworthiness Directive) indicates mandatory regulatory action; SB (Service Bulletin) indicates manufacturer recommendation; MEL indicates deferred defect; defect indicates pilot or engineer report; interval indicates scheduled maintenance program; modification indicates design change; inspection indicates regulatory or operational audit. [ENUM-REF-CANDIDATE: ad|sb|mel|defect|interval|modification|inspection — 7 candidates stripped; promote to reference product]',
    `part_145_approval_reference` STRING COMMENT 'Reference to the Part-145 maintenance organisation approval certificate number under which this work was performed. Required for regulatory compliance and airworthiness release.',
    `priority_level` STRING COMMENT 'Business priority assigned to the work order. Critical indicates AOG (Aircraft on Ground) or safety-critical; high indicates flight-impacting; medium indicates scheduled with tight window; low indicates deferrable; routine indicates standard interval work.. Valid values are `critical|high|medium|low|routine`',
    `sb_reference` STRING COMMENT 'Reference to the manufacturer Service Bulletin number if this work order implements a recommended modification or inspection. Format varies by OEM (e.g., Boeing SB 737-32-1234, Airbus SB A320-32-1234).',
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
    `component_id` BIGINT COMMENT 'Foreign key linking to maintenance.component. Business justification: Work order task may involve a specific component. The work_order_task table has component_part_number and component_serial_number but no FK. Adding component_id FK normalizes this and removes redundan',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Dual-role crew members (pilot-engineers, flight engineers with A&P) perform line maintenance tasks. Business process: dual-role workforce utilization tracking, labor cost allocation, regulatory compli',
    `defect_report_id` BIGINT COMMENT 'Reference to the originating defect or discrepancy record that triggered this corrective maintenance task. Links unscheduled maintenance to reported defects.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Individual tasks may fulfill specific corrective actions (granular implementation tracking). Enables task-level verification of corrective action completion for audit compliance, supports detailed eff',
    `employee_id` BIGINT COMMENT 'Reference to the certified inspector who performed independent inspection and verification of the completed task. Required for critical tasks and return-to-service certification.',
    `mel_deferral_id` BIGINT COMMENT 'Foreign key linking to maintenance.mel_deferral. Business justification: Work order task may be related to a MEL deferral. The work_order_task table has mel_reference (STRING) but no FK. Adding mel_deferral_id FK normalizes this and removes redundant mel_reference.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Individual maintenance tasks may be tied to specific safety events requiring rectification (e.g., post-incident inspection tasks). Enables granular tracking of occurrence-driven maintenance actions fo',
    `primary_work_technician_employee_id` BIGINT COMMENT 'Reference to the certified aircraft maintenance technician who performed the work. Links to employee/crew master data.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order header that contains this task line.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Actual labor hours expended to complete this task, captured for cost accounting, productivity analysis, and future task planning.',
    `airworthiness_directive_reference` STRING COMMENT 'Reference number of the Airworthiness Directive if this task is performed to comply with a mandatory AD issued by the aviation authority (FAA/EASA). Critical for regulatory compliance.',
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
    `service_bulletin_reference` STRING COMMENT 'Reference number of the manufacturer Service Bulletin if this task implements a recommended or mandatory modification, inspection, or service action.',
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
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Maintenance programs require approval from the operators primary regulatory authority (FAA, EASA, etc.). Tracking this approval is fundamental to Part 121/145 operations, audit compliance, and determ',
    `ad_compliance_status` STRING COMMENT 'Overall compliance status of Airworthiness Directives (ADs) incorporated into this maintenance program.. Valid values are `compliant|pending|overdue|not_applicable`',
    `aircraft_registration` STRING COMMENT 'Tail number or registration mark of the aircraft to which this maintenance program applies. May be null for type-level programs.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `aircraft_type_code` STRING COMMENT 'ICAO aircraft type designator (e.g., B738, A320, B77W) defining the aircraft model family for which this maintenance program is approved.. Valid values are `^[A-Z0-9]{3,10}$`',
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
    `part_145_organization` STRING COMMENT 'Name or identifier of the EASA Part-145 or FAA Part 145 approved maintenance organization responsible for executing this maintenance program.',
    `program_description` STRING COMMENT 'Detailed textual description of the maintenance program scope, objectives, and key features.',
    `program_name` STRING COMMENT 'Business-friendly name or title of the maintenance program (e.g., B737-800 AMP Rev 12, A320 Family Maintenance Program).',
    `program_status` STRING COMMENT 'Current lifecycle status of the maintenance program indicating its regulatory and operational state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|superseded|withdrawn|archived — 7 candidates stripped; promote to reference product]',
    `program_type` STRING COMMENT 'Classification of the maintenance program: AMP (Aircraft Maintenance Program), CMP (Component Maintenance Program), EMP (Engine Maintenance Program), sampling program, MSG-3 based, or other.. Valid values are `amp|cmp|emp|sampling|msg3|other`',
    `reliability_program_reference` STRING COMMENT 'Reference to the associated aircraft reliability program or monitoring system that feeds data into maintenance program adjustments.',
    `revision` STRING COMMENT 'Revision or version identifier of the maintenance program as approved by the regulatory authority (e.g., Rev 12, 2023-01, V3.5).. Valid values are `^[A-Z0-9./-]{1,20}$`',
    `sb_incorporation_status` STRING COMMENT 'Status of manufacturer Service Bulletin (SB) incorporation into this maintenance program.. Valid values are `current|pending|partial|not_applicable`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this maintenance program record.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Approved aircraft maintenance program (AMP) master record defining the scheduled maintenance framework for an aircraft type or individual registration. Captures program revision, EASA/FAA approval reference, maintenance planning document (MPD) baseline, interval structure (flight hours, flight cycles, calendar days), escalation approvals, and effectivity. SSOT for what maintenance is required and at what intervals per regulatory approval.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`check` (
    `check_id` BIGINT COMMENT 'Primary key for check',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: Maintenance check is performed by an approved maintenance organization. The check table has part_145_approval_number and mro_facility_name but no FK. Adding approved_maintenance_org_id FK normalizes t',
    `audit_event_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_event. Business justification: Major maintenance checks (C-checks, D-checks) are subject to regulatory and internal audits. Linking checks to audit events enables compliance verification, finding resolution tracking, and documentat',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Major maintenance checks are planned against annual maintenance budgets. Links check to budget plan for variance analysis, forecast accuracy tracking, and budget consumption reporting.',
    `certifying_staff_id` BIGINT COMMENT 'Foreign key linking to maintenance.certifying_staff. Business justification: Maintenance check is certified by a certifying engineer. The check table has certifying_engineer_license (STRING) but no FK. Adding certifying_staff_id FK normalizes this relationship and removes redu',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Major maintenance checks on leased aircraft drive maintenance reserve accruals and lease return condition compliance. Essential for lessor reporting and MR reconciliation at lease expiry.',
    `program_id` BIGINT COMMENT 'Reference to the overarching maintenance program that defines the schedule and requirements for this check type. Links to the regulatory-approved maintenance plan.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Maintenance checks (A/C/D checks) performed at specific stations. Links maintenance_station_code to station.station_id for hangar capacity planning, check performance tracking by location, and regulat',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Major maintenance checks may be triggered by safety occurrences (e.g., heavy landing requiring special inspection). Links unscheduled checks to causal events for fleet-wide risk assessment and regulat',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Maintenance check is associated with a work order. The check table has work_order_number (STRING) but no FK. Adding work_order_id FK allows proper relational integrity and removes redundant work_order',
    `actual_induction_date` DATE COMMENT 'The actual date when the aircraft entered the maintenance facility and work commenced. May differ from scheduled date due to operational constraints.',
    `actual_man_hours` DECIMAL(18,2) COMMENT 'The actual total labor hours consumed during execution of this maintenance check. Used for cost accounting and efficiency analysis.',
    `actual_release_date` DATE COMMENT 'The actual date when the aircraft was certified airworthy and released back to operational service after completion of the maintenance check.',
    `aircraft_registration` STRING COMMENT 'The unique registration identifier (tail number) of the aircraft undergoing this maintenance check. Links to the specific aircraft in the fleet.. Valid values are `^[A-Z0-9]{5,7}$`',
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
    `total_cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred for this maintenance check including labor, parts, materials, and overhead. Used for maintenance budget tracking and cost per flight hour analysis.',
    CONSTRAINT pk_check PRIMARY KEY(`check_id`)
) COMMENT 'Scheduled maintenance check event (A-check, B-check, C-check, D-check, line check, transit check) planned or executed against a specific aircraft registration. Records check type, due date, due flight hours, due cycles, actual induction date, release date, station/MRO facility, man-hours consumed, downtime days, and next-due projections. Bridges the maintenance program to actual execution events.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` (
    `airworthiness_directive_id` BIGINT COMMENT 'Primary key for airworthiness_directive',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Airworthiness Directives are issued by regulatory authorities (FAA, EASA, TCCA, etc.). Tracking the issuing authority is fundamental to AD management, compliance verification, and determining applicab',
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
    `related_ad_numbers` STRING COMMENT 'Comma-separated list of related AD numbers from other authorities addressing the same unsafe condition (e.g., FAA AD referencing equivalent EASA AD).',
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
    `certifying_staff_id` BIGINT COMMENT 'Reference to the certified maintenance technician who signed off the airworthiness directive compliance action.',
    `component_id` BIGINT COMMENT 'Reference to the specific aircraft component (engine, APU, landing gear, etc.) to which this airworthiness directive applies, if component-specific.',
    `employee_id` BIGINT COMMENT 'Reference to the quality assurance inspector who verified the airworthiness directive compliance action.',
    `airworthiness_directive_id` BIGINT COMMENT 'Foreign key linking to maintenance.airworthiness_directive. Business justification: AD compliance tracks compliance with a specific airworthiness directive. The ad_compliance table has ad_number, ad_title, and issuing_authority but no FK to airworthiness_directive. Adding maintenance',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: AD compliance records must track which regulatory authority issued the AD for proper regulatory reporting, audit trails, and determining which authority to notify of compliance status. Essential for m',
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
    `airworthiness_directive_id` BIGINT COMMENT 'Foreign key linking to maintenance.airworthiness_directive. Business justification: Service bulletin may be associated with an airworthiness directive. The service_bulletin table has associated_ad_number (STRING) but no FK. Adding associated_maintenance_airworthiness_directive_id FK ',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Service Bulletins can become mandatory through regulatory action (e.g., FAA issues AD mandating SB compliance). Tracking which authority mandated the SB is essential for compliance management, determi',
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
    `related_bulletin_numbers` STRING COMMENT 'Comma-separated list of related service bulletin numbers that should be reviewed or implemented in conjunction with this bulletin.',
    `revision_date` DATE COMMENT 'Date of the most recent revision to the service bulletin. Null if no revisions have been issued. Format: yyyy-MM-dd.',
    `revision_number` STRING COMMENT 'Revision level of the service bulletin. Tracks updates and amendments to the original bulletin (e.g., Original, 1, 2, A, B).. Valid values are `^[0-9]{1,3}$|^[A-Z]$|^Original$`',
    `superseded_bulletin_number` STRING COMMENT 'Service bulletin number that this bulletin supersedes or replaces. Null if this is the original bulletin with no predecessor.',
    `technical_description` STRING COMMENT 'Detailed technical description of the modification, inspection, or replacement procedure outlined in the service bulletin. Summarizes the work scope and technical rationale.',
    CONSTRAINT pk_service_bulletin PRIMARY KEY(`service_bulletin_id`)
) COMMENT 'Manufacturer Service Bulletin (SB) and Service Letter (SL) master record issued by OEM (Airbus, Boeing, CFM, etc.) recommending or mandating modifications, inspections, or part replacements. Captures SB number, revision, OEM, ATA chapter, category (mandatory/recommended/optional), effectivity, compliance threshold, and cross-reference to any associated AD. SSOT for OEM technical communication tracking.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`defect_report` (
    `defect_report_id` BIGINT COMMENT 'Unique identifier for the aircraft defect report record. Primary key.',
    `airspace_deviation_id` BIGINT COMMENT 'Foreign key linking to safety.airspace_deviation. Business justification: Airspace deviations may reveal equipment defects (autopilot malfunction, navigation system failure). Link supports causal analysis, tracks deviation-driven maintenance, and enables identification of e',
    `certifying_staff_id` BIGINT COMMENT 'Identifier of the quality inspector or certifying staff who verified rectification and closed the defect report. Null if not yet closed.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Defects discovered at specific airport stations. Links discovery_station_code to station.station_id for quality tracking by location, identifying stations with high defect discovery rates, and targeti',
    `fdr_event_id` BIGINT COMMENT 'Foreign key linking to safety.fdr_event. Business justification: FDR events may correlate with defect reports (hard landings, overspeed events requiring inspection). Link supports integrated analysis of flight data and maintenance findings, validates FDR exceedance',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Defects may identify new hazards or confirm existing ones (e.g., recurring defect pattern reveals systemic hazard). Link supports SMS hazard register updates, enables defect-driven hazard identificati',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to safety.investigation. Business justification: Defects often trigger formal safety investigations; linking enables tracking investigation outcomes back to originating defect. Critical for SMS closed-loop corrective action tracking and regulatory i',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Safety-reportable defects are safety occurrences that must be tracked in the SMS. This FK links the defect report to the safety occurrence for regulatory reporting and trend analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported the defect.',
    `regulatory_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_violation. Business justification: Certain defects constitute regulatory violations (e.g., continued operation with expired AD compliance, MEL category exceedance). Linking defect reports to violations enables tracking of enforcement a',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Flight/cabin crew discover and report defects during operations. Complements existing employee_id FK with crew-specific context (qualifications, recency, position). Business process: defect discovery ',
    `runway_incursion_id` BIGINT COMMENT 'Foreign key linking to safety.runway_incursion. Business justification: Runway incursions may result in aircraft damage requiring defect reports (tire damage, gear inspection). Link supports incident investigation, tracks incursion-related maintenance, and enables analysi',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Defect report is rectified via a work order. The defect_report table has work_order_number (STRING) but no FK. Adding work_order_id FK normalizes this and removes redundant work_order_number.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration mark of the aircraft on which the defect was discovered (e.g., N12345, G-ABCD).. Valid values are `^[A-Z0-9-]{5,10}$`',
    `airworthiness_directive_reference` STRING COMMENT 'Reference number of the Airworthiness Directive (AD) related to this defect, if applicable (e.g., FAA-2023-0456, EASA-2022-0123). Null if not AD-related.. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{2,4}$`',
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
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight on which the defect was discovered. Null for defects found during ground maintenance.',
    `flight_number` STRING COMMENT 'Flight number on which the defect was discovered (if discovered during flight operations). Null for defects found during ground maintenance.. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this defect report record was last updated in the system.',
    `maintenance_organization_code` STRING COMMENT 'EASA Part-145 or FAA Repair Station certificate number of the approved maintenance organization that rectified the defect.. Valid values are `^[A-Z0-9.]{4,15}$`',
    `mel_applicable_flag` BOOLEAN COMMENT 'Indicates whether the defect is eligible for deferral under the aircraft Minimum Equipment List (MEL). True if MEL item exists for this defect, false otherwise.',
    `mel_category` STRING COMMENT 'MEL deferral category indicating repair interval: A (repair interval specified by MEL), B (repair within 3 days), C (repair within 10 days), D (repair within 120 days). Null if not deferred.. Valid values are `A|B|C|D`',
    `mel_item_reference` STRING COMMENT 'MEL item number or reference code authorizing deferral of this defect. Null if not deferred under MEL.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `part_number_replaced` STRING COMMENT 'Manufacturer part number of the component replaced during rectification. Null if no part replacement occurred.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `rectification_action_description` STRING COMMENT 'Detailed description of the corrective action taken to rectify the defect, including parts replaced, repairs performed, and tests conducted. Null if not yet rectified.',
    `rectification_station_code` STRING COMMENT 'IATA three-letter airport code of the station where the defect was rectified. Null if not yet rectified.. Valid values are `^[A-Z]{3}$`',
    `rectification_timestamp` TIMESTAMP COMMENT 'Date and time when the defect rectification work was completed. Null if not yet rectified.',
    `reported_by_role` STRING COMMENT 'Role of the person who reported the defect (flight crew, cabin crew, maintenance technician, quality inspector, or engineer).. Valid values are `flight-crew|cabin-crew|maintenance-technician|quality-inspector|engineer`',
    `safety_reportable_flag` BOOLEAN COMMENT 'Indicates whether this defect meets regulatory criteria for mandatory safety occurrence reporting to aviation authorities (FAA, EASA, national CAA). True if reportable, false otherwise.',
    `serial_number_installed` STRING COMMENT 'Serial number of the serviceable component installed on the aircraft during rectification. Null if no part installation occurred.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `serial_number_removed` STRING COMMENT 'Serial number of the defective component removed from the aircraft. Null if no part removal occurred.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `severity_level` STRING COMMENT 'Engineering assessment of defect severity: critical (immediate safety impact, AOG), major (significant operational impact), minor (limited impact, deferrable), cosmetic (no operational impact).. Valid values are `critical|major|minor|cosmetic`',
    CONSTRAINT pk_defect_report PRIMARY KEY(`defect_report_id`)
) COMMENT 'Aircraft defect and discrepancy record raised by flight crew (via technical log), cabin crew, or maintenance technicians. Captures ATA chapter, defect description, discovery phase (pre-flight/in-flight/post-flight/hangar), MEL/CDL applicability, deferral category (A/B/C/D), deferral expiry, rectification work order reference, station, and open/deferred/closed status. SSOT for unscheduled maintenance demand origination.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`mel_item` (
    `mel_item_id` BIGINT COMMENT 'Primary key for mel_item',
    `aircraft_type_id` BIGINT COMMENT 'Reference to the aircraft type for which this MEL item applies (e.g., Boeing 737-800, Airbus A320-200).',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: MEL items are approved by specific regulatory authorities as part of the operators MEL approval process. Tracking the approval authority is essential for legal dispatch decisions, determining which a',
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
    `defect_report_id` BIGINT COMMENT 'Identifier of the associated defect report or pilot write-up that triggered the MEL deferral.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: MEL deferrals opened at specific stations. Links deferral_station_code to station.station_id for regulatory compliance tracking by location, identifying stations with high deferral rates, and ensuring',
    `mel_item_id` BIGINT COMMENT 'Foreign key linking to maintenance.mel_item. Business justification: MEL deferral is based on a MEL item definition. The mel_deferral table has mel_item_reference (STRING) but no FK. Adding maintenance_mel_item_id FK normalizes this and removes redundant mel_item_refer',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: MEL deferrals may result from safety occurrences (e.g., in-flight malfunction deferred under MEL). Tracking this link supports risk management, regulatory reporting, and analysis of deferral impact on',
    `certifying_staff_id` BIGINT COMMENT 'Identifier of the Part-145 certified maintenance engineer or certifying staff who authorized the MEL deferral.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Active MEL deferrals may require notification to the regulatory authority that approved the MEL, especially for Category A/B items or extensions. Tracking the authority enables automated compliance re',
    `work_order_id` BIGINT COMMENT 'Identifier of the maintenance work order created to rectify the deferred item. Null if not yet created.',
    `aircraft_registration` STRING COMMENT 'The unique registration identifier (tail number) of the aircraft on which the MEL deferral is active.. Valid values are `^[A-Z0-9-]{5,10}$`',
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
    `ad_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.ad_compliance_record. Business justification: Components are subject to component-specific Airworthiness Directives. Linking components to their AD compliance records enables tracking of component-level AD compliance (distinct from aircraft-level',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft on which this component is currently installed, if applicable. Null if component is in shop or store.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Component failures causing safety occurrences need direct linkage for reliability analysis and fleet-wide risk assessment. Enables component-level safety performance tracking, supports manufacturer re',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Rotable components meeting capitalization thresholds are fixed assets. Links component to asset record for depreciation tracking, NBV reporting, and asset disposal accounting.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Specific components may be associated with identified hazards (design flaws, known failure modes). Link supports component-level risk tracking, informs procurement decisions, and enables targeted moni',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Components on leased aircraft must track lease contract for lease return inventory reconciliation, maintenance reserve claims, and lessor asset tracking. Required for lease return audits.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Tracks OEM/supplier of installed component for warranty claims, AD applicability verification, and approved source compliance. Real process: airworthiness staff verify component pedigree against appro',
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
    `current_location_code` STRING COMMENT 'Code identifying the specific location where the component is currently held. May be aircraft registration, shop code, warehouse code, or station code depending on location type.. Valid values are `^[A-Z0-9]{3,10}$`',
    `current_location_type` STRING COMMENT 'Type of location where the component is currently held. Aircraft indicates installed on aircraft, shop indicates undergoing maintenance, store indicates warehouse inventory, quarantine indicates awaiting inspection, scrap indicates condemned.. Valid values are `aircraft|shop|store|quarantine|scrap`',
    `cycles_remaining_to_limit` BIGINT COMMENT 'Flight cycles remaining before the component reaches its life limit or next scheduled maintenance event. Null if not applicable or unlimited.',
    `cycles_since_overhaul` BIGINT COMMENT 'Flight cycles accumulated since the last major overhaul or shop visit. Reset to zero after overhaul. Null if component has never been overhauled.',
    `installation_date` DATE COMMENT 'Date when the component was installed on the current aircraft. Null if component is not currently installed on an aircraft.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this component record was last updated in the maintenance system.',
    `last_overhaul_date` DATE COMMENT 'Date when the component last underwent major overhaul or shop visit. Null if component has never been overhauled.',
    `life_limited_part_flag` BOOLEAN COMMENT 'Indicates whether this component is a life-limited part subject to mandatory retirement at specified life limits per airworthiness directives. True if LLP, false otherwise.',
    `maintenance_organization_code` STRING COMMENT 'Approval code of the Part-145 approved maintenance organization that last performed maintenance or issued the airworthiness certificate for this component.. Valid values are `^[A-Z0-9.]{4,15}$`',
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

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`llp_status` (
    `llp_status_id` BIGINT COMMENT 'Unique identifier for the life-limited part status record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft on which this life-limited part is installed.',
    `component_id` BIGINT COMMENT 'Reference to the parent component or assembly (e.g., engine, landing gear) containing this LLP.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the most recent flight after which the accumulated life was updated. Ensures traceability of life consumption.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order under which the LLP was removed. Provides traceability to the removal event.',
    `accumulated_life` STRING COMMENT 'The total life consumed by the LLP since new or since last overhaul, expressed in the unit defined by life_limit_type. Updated after each flight or maintenance event.',
    `airworthiness_directive_compliance` STRING COMMENT 'Indicates whether the LLP is compliant with all applicable Airworthiness Directives issued by aviation authorities. Non-compliance may ground the aircraft.. Valid values are `compliant|non_compliant|not_applicable`',
    `alert_threshold` STRING COMMENT 'The remaining life value at which maintenance planning alerts are triggered. Typically set to allow sufficient lead time for part procurement and scheduling (e.g., 1000 cycles before limit).',
    `alert_threshold_percentage` DECIMAL(18,2) COMMENT 'Alert threshold expressed as a percentage of certified life limit. Typically set between 5% and 15% remaining life.',
    `certified_life_limit` STRING COMMENT 'The maximum allowable life of the LLP as certified by the manufacturer and approved by the aviation authority. Expressed in the unit defined by life_limit_type (e.g., 20000 cycles, 50000 flight hours). The part MUST be retired at or before this limit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LLP status record was first created in the system. Part of the audit trail.',
    `installation_cycles_at_install` STRING COMMENT 'The accumulated cycles on the LLP at the time of installation on the current aircraft or component. Used to calculate total life consumption.',
    `installation_date` DATE COMMENT 'Date when the LLP was installed on the current aircraft or component. Critical for calendar-based life tracking.',
    `installation_flight_number` STRING COMMENT 'Flight number or operational reference at the time of LLP installation. Provides traceability to the installation event.',
    `last_overhaul_date` DATE COMMENT 'Date of the most recent overhaul or refurbishment of the LLP. Null if the part has never been overhauled.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Timestamp when the LLP status record was last updated with new accumulated life data. Critical for data currency verification.',
    `life_limit_type` STRING COMMENT 'The unit of measure by which the LLP life is tracked: cycles (takeoff/landing cycles), flight hours, calendar days, or a combination. Defined by the manufacturer and certified by the aviation authority.. Valid values are `cycles|flight_hours|calendar_days|combined`',
    `llp_category` STRING COMMENT 'Classification of the LLP by component type. Engine LLPs (discs, shafts, hubs) and landing gear components are the most common.. Valid values are `engine_disc|engine_shaft|engine_hub|landing_gear|rotor|other`',
    `llp_status_status` STRING COMMENT 'Current operational status of the LLP: serviceable (within normal operating range), alert (approaching threshold), critical (near limit), expired (at or beyond limit, must be removed), removed (no longer installed).. Valid values are `serviceable|alert|critical|expired|removed`',
    `maintenance_organization_code` STRING COMMENT 'Code of the Part-145 approved maintenance organization responsible for tracking and maintaining this LLP. Critical for regulatory compliance.. Valid values are `^[A-Z0-9.]{3,15}$`',
    `manufacturer_name` STRING COMMENT 'Name of the OEM (Original Equipment Manufacturer) who produced the LLP (e.g., GE Aviation, Pratt & Whitney, Rolls-Royce, Safran).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this LLP status record was last modified. Part of the audit trail for regulatory compliance.',
    `next_inspection_due_life` STRING COMMENT 'The accumulated life value at which the next scheduled inspection of the LLP is due. May be required before the certified life limit.',
    `overhaul_count` STRING COMMENT 'Number of times the LLP has been overhauled or refurbished. Some LLPs may be overhauled with life extension, others are single-life components.',
    `part_number` STRING COMMENT 'Manufacturer part number identifying the specific LLP type (e.g., engine disc, shaft, hub). Critical for airworthiness tracking.. Valid values are `^[A-Z0-9-]{5,25}$`',
    `remaining_life` STRING COMMENT 'The remaining life before the LLP reaches its certified limit, calculated as certified_life_limit minus accumulated_life. Critical for maintenance planning and AOG prevention.',
    `remaining_life_percentage` DECIMAL(18,2) COMMENT 'Percentage of remaining life relative to the certified limit, calculated as (remaining_life / certified_life_limit) * 100. Used for threshold alerting and planning.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special conditions, or maintenance history relevant to the LLP status. Used for operational context and audit trail.',
    `removal_date` DATE COMMENT 'Date when the LLP was removed from service. Null if the part is still installed and serviceable.',
    `removal_reason` STRING COMMENT 'Reason for LLP removal from service: life limit reached (planned retirement), scheduled maintenance, unscheduled removal (defect), AOG event, or component replacement.. Valid values are `life_limit_reached|scheduled_maintenance|unscheduled_removal|aog_event|component_replacement|other`',
    `serial_number` STRING COMMENT 'Unique serial number of the individual LLP unit. Each LLP must be individually tracked throughout its lifecycle.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `service_bulletin_compliance` STRING COMMENT 'Indicates whether the LLP is compliant with all applicable manufacturer Service Bulletins. Some SBs are mandatory for continued airworthiness.. Valid values are `compliant|non_compliant|not_applicable`',
    CONSTRAINT pk_llp_status PRIMARY KEY(`llp_status_id`)
) COMMENT 'Life-Limited Part (LLP) status record tracking the accumulated life consumption of each LLP against its certified life limit (cycles, flight hours, or calendar). Captures part number, serial number, life limit type, certified limit value, accumulated value, remaining life, last update flight/cycle reference, and alert threshold. Critical for airworthiness — LLPs must be retired at or before their certified limit. Primarily applies to engine LLPs (discs, shafts, hubs) and landing gear components.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`component_removal` (
    `component_removal_id` BIGINT COMMENT 'Unique identifier for the component removal transaction. Primary key for the component removal record.',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: Component removal is performed by an approved maintenance organization. The component_removal table has part_145_approval_number (STRING) but no FK. Adding approved_maintenance_org_id FK normalizes th',
    `certifying_staff_id` BIGINT COMMENT 'Employee identifier or license number of the authorized inspector who certified the component installation for return to service.',
    `employee_id` BIGINT COMMENT 'Employee identifier or license number of the certified aircraft maintenance technician who performed the component removal and installation.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Component removals trigger fixed asset accounting when rotable components are capitalized. Links removal transaction to asset record for depreciation adjustment, disposal accounting, and NBV tracking.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Component removals performed at specific stations. Links maintenance_station_code to station.station_id for inventory management, tracking component flow through maintenance network, and capability as',
    `component_id` BIGINT COMMENT 'Foreign key linking to maintenance.component. Business justification: Component removal tracks the specific component being removed. The component_removal table has removed_component_part_number and removed_component_serial_number but no FK. Adding removed_component_id ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Links removed unserviceable component to replacement part PO for warranty processing and cost allocation. Real process: warranty claims require proof of replacement part procurement; finance allocates',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Component removals may be occurrence-driven (emergency removal after incident, wildlife strike damage). Critical for causal analysis, warranty claims, and tracking occurrence-related maintenance costs',
    `wildlife_strike_id` BIGINT COMMENT 'Foreign key linking to safety.wildlife_strike. Business justification: Wildlife strikes frequently necessitate component removal (engine fan blades, radome). Link supports damage assessment, tracks strike-related component costs, and informs wildlife strike risk analysis',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Component removal is performed as part of a work order. The component_removal table has work_order_number (STRING) but no FK. Adding work_order_id FK normalizes this and removes redundant work_order_n',
    `ad_reference_number` STRING COMMENT 'Reference number of the airworthiness directive that mandated the component removal, if applicable. ADs are mandatory safety directives issued by aviation authorities.. Valid values are `^AD[0-9]{4}-[0-9]{2}-[0-9]{2}$`',
    `aircraft_registration` STRING COMMENT 'The tail number or registration mark of the aircraft from which the component was removed. Unique identifier assigned by the national civil aviation authority.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `aircraft_total_cycles_at_removal` BIGINT COMMENT 'Cumulative total flight cycles (takeoff and landing pairs) recorded on the aircraft at the time the component was removed. Critical for fatigue-sensitive component tracking.',
    `aircraft_total_hours_at_removal` DECIMAL(18,2) COMMENT 'Cumulative total flight hours recorded on the aircraft at the time the component was removed. Used for component life tracking and trend analysis.',
    `aog_event_flag` BOOLEAN COMMENT 'Boolean indicator of whether this component removal was part of an AOG event (aircraft grounded and unable to operate). True indicates AOG situation requiring expedited parts and maintenance.',
    `ata_chapter` STRING COMMENT 'Two-digit ATA chapter code identifying the aircraft system to which the component belongs (e.g., 32 for Landing Gear, 71 for Power Plant).. Valid values are `^[0-9]{2}$`',
    `ata_position_code` STRING COMMENT 'Specific location code on the aircraft where the component is installed (e.g., LH-ENG-1 for left engine position 1). Defines the physical mounting point.. Valid values are `^[A-Z0-9]{2,10}$`',
    `component_cycles_at_removal` BIGINT COMMENT 'Total operating cycles accumulated by the removed component since new or since last overhaul. Critical for life-limited parts tracking.',
    `component_cycles_since_new` BIGINT COMMENT 'Total cycles the removed component has operated since it was manufactured (cycles since new). Never resets, tracks full component life.',
    `component_hours_at_removal` DECIMAL(18,2) COMMENT 'Total operating hours accumulated by the removed component since new or since last overhaul. Used to determine remaining life and maintenance intervals.',
    `component_time_since_new_hours` DECIMAL(18,2) COMMENT 'Total hours the removed component has operated since it was manufactured (time since new). Never resets, tracks full component life.',
    `crs_reference_number` STRING COMMENT 'Reference number of the Certificate of Release to Service document that authorizes the aircraft to return to operation after the component installation. Required by EASA Part-145.. Valid values are `^CRS[0-9]{8,12}$`',
    `installation_date` DATE COMMENT 'Calendar date on which the replacement component was installed on the aircraft.',
    `installation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the replacement component installation was completed and recorded in the maintenance system.',
    `installed_component_condition_code` STRING COMMENT 'Condition of the replacement component at installation: new from manufacturer, overhauled (zero-timed), serviceable (used but airworthy), or repaired.. Valid values are `new|overhauled|serviceable|repaired`',
    `installed_component_part_number` STRING COMMENT 'Manufacturer part number of the replacement component that was installed on the aircraft. May be same or alternate part number as removed component.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `installed_component_serial_number` STRING COMMENT 'Unique serial number of the replacement component that was installed. Establishes the new fitment record for the aircraft position.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `mel_deferral_reference` STRING COMMENT 'Reference number of the MEL deferral if the component removal was deferred under minimum equipment list provisions, allowing aircraft operation with the defect.. Valid values are `^MEL[0-9]{6,10}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this component removal record was first created in the maintenance management system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this component removal record was last modified in the maintenance management system.',
    `removal_date` DATE COMMENT 'Calendar date on which the component was physically removed from the aircraft.',
    `removal_reason_code` STRING COMMENT 'Classification of why the component was removed: scheduled maintenance, unscheduled failure, defect found, upgrade/modification, inspection requirement, life-limited part expiry, or airworthiness directive compliance. [ENUM-REF-CANDIDATE: scheduled|unscheduled|defect|upgrade|inspection|life_limit|ad_compliance — 7 candidates stripped; promote to reference product]',
    `removal_reason_description` STRING COMMENT 'Detailed free-text explanation of the reason for component removal, including any defect descriptions, pilot reports, or maintenance findings that triggered the removal.',
    `removal_timestamp` TIMESTAMP COMMENT 'Precise date and time when the component removal was completed and recorded in the maintenance system.',
    `removed_component_condition_code` STRING COMMENT 'Assessment of the removed component condition: serviceable (can be reused as-is), unserviceable (requires maintenance), repairable (can be overhauled), beyond repair, or scrap (must be disposed).. Valid values are `serviceable|unserviceable|beyond_repair|repairable|scrap`',
    `sb_reference_number` STRING COMMENT 'Reference number of the manufacturer service bulletin that recommended or required the component removal, if applicable. Service bulletins are OEM-issued maintenance instructions.. Valid values are `^SB[A-Z0-9-]{6,15}$`',
    `transaction_status` STRING COMMENT 'Current workflow status of the component removal transaction: draft (initiated), in progress (work underway), completed (physical work done), certified (CRS issued), or cancelled.. Valid values are `draft|in_progress|completed|certified|cancelled`',
    `warranty_claim_flag` BOOLEAN COMMENT 'Boolean indicator of whether the component removal is eligible for warranty claim against the manufacturer or vendor. True indicates warranty coverage applies.',
    CONSTRAINT pk_component_removal PRIMARY KEY(`component_removal_id`)
) COMMENT 'Component removal and installation transaction recording the physical swap of a serialised component on an aircraft. Captures removal reason (scheduled/unscheduled/defect/upgrade), removed component S/N, installed component S/N, aircraft registration, ATA position, station, technician, work order reference, aircraft hours/cycles at removal, and CRS reference. Maintains the full fitment history and traceability chain for each component.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`aog_event` (
    `aog_event_id` BIGINT COMMENT 'Unique identifier for the AOG event record. Primary key.',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: AOG event is handled by a maintenance organization. The aog_event table has maintenance_organization_code (STRING) but no FK. Adding approved_maintenance_org_id FK normalizes this and removes redundan',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Commander/crew member declares AOG based on operational assessment. Complements employee_id with crew-specific context (qualifications, authority). Business process: AOG declaration authority tracking',
    `flight_revenue_performance_id` BIGINT COMMENT 'Foreign key linking to revenue.flight_revenue_performance. Business justification: AOG events directly cause flight cancellations with measurable revenue loss. Airlines track revenue impact per AOG incident for financial reporting, insurance claims, vendor penalty assessment, and ex',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: AOG events are often safety-related (serious defects, incidents requiring grounding). Linking supports integrated safety-operational analysis, enables tracking of safety-driven operational disruptions',
    `employee_id` BIGINT COMMENT 'Employee identifier of the AOG coordinator responsible for managing the recovery and resolution of this AOG event.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: AOG parts procurement tracking for cost recovery and vendor performance (AOG response time SLA). Real process: operations tracks AOG PO from requisition to delivery for disruption cost analysis; procu',
    `regulatory_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_violation. Business justification: AOG events caused by compliance failures (e.g., operating beyond AD compliance limits, expired airworthiness certificate) may trigger regulatory violations and enforcement actions. This link tracks th',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: AOG event is resolved via a work order. The aog_event table has resolution_work_order_number (STRING) but no FK. Adding resolution_work_order_id FK normalizes this and removes redundant resolution_wor',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: AOG events occur at specific airport stations. Links station_code to station.station_id for operational disruption analysis, AOG recovery resource planning, spare parts positioning, and identifying st',
    `actual_rts_timestamp` TIMESTAMP COMMENT 'The actual date and time when the aircraft was certified airworthy and returned to operational service following AOG resolution.',
    `aircraft_registration` STRING COMMENT 'The unique registration identifier (tail number) of the aircraft that experienced the AOG event.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `airworthiness_directive_reference` STRING COMMENT 'Reference to any applicable Airworthiness Directive that was related to or triggered the AOG event.',
    `aog_declaration_timestamp` TIMESTAMP COMMENT 'The precise date and time when the aircraft was officially declared AOG due to an unresolved technical defect or missing airworthy component.',
    `aog_duration_hours` DECIMAL(18,2) COMMENT 'Total duration in hours that the aircraft remained in AOG status, calculated from declaration timestamp to actual RTS timestamp.',
    `aog_notification_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether automated AOG notification was sent to operations control, maintenance planning, and executive stakeholders.',
    `aog_severity_level` STRING COMMENT 'Classification of the AOG event severity based on operational impact, safety implications, and recovery complexity.. Valid values are `critical|high|medium|low`',
    `aog_status` STRING COMMENT 'Current lifecycle status of the AOG event tracking its progression from declaration through resolution. [ENUM-REF-CANDIDATE: declared|in_progress|parts_ordered|parts_received|work_in_progress|resolved|closed — 7 candidates stripped; promote to reference product]',
    `ata_chapter` STRING COMMENT 'The ATA 100 specification chapter code identifying the aircraft system affected (e.g., 32 for Landing Gear, 71 for Power Plant).. Valid values are `^[0-9]{2}(-[0-9]{2})?$`',
    `component_part_number` STRING COMMENT 'The manufacturer part number of the failed or missing component that caused the AOG condition.',
    `component_serial_number` STRING COMMENT 'The unique serial number of the specific component instance that failed or was missing.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective maintenance action taken to restore the aircraft to airworthy status.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AOG event record was first created in the system.',
    `defect_code` STRING COMMENT 'The standardized maintenance defect code from the airlines defect taxonomy that categorizes the technical failure.',
    `estimated_revenue_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact in USD from lost revenue due to cancelled and delayed flights resulting from this AOG event.',
    `estimated_rts_timestamp` TIMESTAMP COMMENT 'The initially estimated date and time when the aircraft is expected to return to airworthy service status.',
    `flights_cancelled_count` STRING COMMENT 'Number of scheduled flights that were cancelled as a direct result of this AOG event.',
    `flights_delayed_count` STRING COMMENT 'Number of scheduled flights that were delayed as a direct result of this AOG event.',
    `grounding_reason` STRING COMMENT 'Detailed narrative description of the technical defect, failure, or missing component that caused the aircraft to be grounded.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this AOG event record was last updated or modified.',
    `mel_reference` STRING COMMENT 'Reference to the MEL item number if the defect was initially deferred under MEL provisions before escalating to AOG status.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause that led to the AOG event.. Valid values are `component_failure|human_error|design_defect|wear_and_tear|foreign_object_damage|environmental`',
    `vendor_support_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether external vendor or OEM technical support was required to resolve the AOG event.',
    CONSTRAINT pk_aog_event PRIMARY KEY(`aog_event_id`)
) COMMENT 'Aircraft on Ground (AOG) event record capturing instances where an aircraft is grounded due to an unresolved technical defect or missing airworthy component. Records AOG declaration timestamp, station, grounding reason, ATA chapter, AOG coordinator, AOG parts order reference, estimated return-to-service (RTS) time, actual RTS time, total AOG duration, revenue impact (cancelled/delayed flights), and resolution work order. Critical for operational recovery and MRO performance measurement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`technical_log` (
    `technical_log_id` BIGINT COMMENT 'Unique identifier for the aircraft technical log sector page record. Primary key.',
    `certifying_staff_id` BIGINT COMMENT 'Foreign key linking to maintenance.certifying_staff. Business justification: Technical log is signed by certifying staff. The technical_log table has certifying_staff_name and certifying_staff_licence_number but no FK. Adding certifying_staff_id FK normalizes this and removes ',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Aircraft commander signs technical log accepting aircraft airworthiness. Complements employee_id with crew operational context. Business process: commander accountability for airworthiness acceptance,',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Technical logs record aircraft status at departure station. Links departure_station_code to station.station_id for airworthiness tracking by location, pre-flight inspection quality monitoring, and reg',
    `employee_id` BIGINT COMMENT 'The system user ID of the person who last modified this technical log record. Used for audit trail and accountability.',
    `fdr_event_id` BIGINT COMMENT 'Foreign key linking to safety.fdr_event. Business justification: Technical logs and FDR events both document flight anomalies (crew reports vs. recorded data). Cross-reference supports data validation, reconciles pilot reports with objective data, and enables compr',
    `release_id` BIGINT COMMENT 'Foreign key linking to maintenance.release. Business justification: Technical log references a Certificate of Release to Service. The technical_log table has crs_reference_number (STRING) but no FK. Adding maintenance_release_id FK normalizes this and removes redundan',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Technical logs document in-flight occurrences (pilot reports of malfunctions, anomalies). Direct link enables correlation of pilot reports with formal safety investigations, supports occurrence data v',
    `aircraft_registration` STRING COMMENT 'The unique registration marking assigned to the aircraft by the national civil aviation authority (e.g., N12345, G-ABCD). This is the aircraft tail number.. Valid values are `^[A-Z0-9-]{5,10}$`',
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
    `flight_number` STRING COMMENT 'The commercial flight number for this sector (e.g., BA123, AA4567). Links the technical log entry to the operational flight.. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$`',
    `fuel_remaining_kg` DECIMAL(18,2) COMMENT 'The quantity of fuel remaining at the end of the sector, measured in kilograms. Used for fuel planning and anomaly detection.',
    `fuel_uplift_kg` DECIMAL(18,2) COMMENT 'The quantity of fuel uplifted for this sector, measured in kilograms. Recorded for fuel management and performance monitoring.',
    `landing_timestamp` TIMESTAMP COMMENT 'The timestamp when the aircraft touched down on the runway (On time in OOOI). Used for flight cycle counting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this technical log sector page record was last modified. Used for audit trail and change tracking.',
    `maintenance_organization_code` STRING COMMENT 'The approval code of the Part-145 approved maintenance organization that performed maintenance work and issued the CRS (e.g., EASA.145.1234, FAA Repair Station Certificate Number).. Valid values are `^[A-Z0-9.]{3,15}$`',
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
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: Certificate of Release to Service is issued by an approved maintenance organization. The release table has part_145_organization_code (STRING) but no FK. Adding approved_maintenance_org_id FK normaliz',
    `audit_event_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_event. Business justification: Maintenance releases (CRS - Certificate of Release to Service) are key audit evidence for airworthiness compliance. Linking releases to audit events enables verification of proper certification, track',
    `certifying_staff_id` BIGINT COMMENT 'Foreign key linking to maintenance.certifying_staff. Business justification: Certificate of Release to Service is issued by certifying staff. The release table has certifying_staff_name and certifying_staff_licence_number but no FK. Adding certifying_staff_id FK normalizes thi',
    `component_id` BIGINT COMMENT 'Foreign key linking to maintenance.component. Business justification: Certificate of Release to Service may be for a component. The release table has component_part_number and component_serial_number but no FK. Adding component_id FK normalizes this and removes redundan',
    `employee_id` BIGINT COMMENT 'System user identifier of the person who last modified this maintenance release record. Audit trail for accountability.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Maintenance releases (CRS) issued at specific stations. Links maintenance_station_code to station.station_id for regulatory oversight, quality assurance tracking by location, and certifying staff auth',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Certificate of Release to Service is issued for a work order. The release table has work_order_number (STRING) but no FK. Adding work_order_id FK normalizes this and removes redundant work_order_numbe',
    `aircraft_registration` STRING COMMENT 'Tail number of the aircraft for which this release to service is issued. National registration mark assigned by civil aviation authority.. Valid values are `^[A-Z]{1,2}-[A-Z0-9]{3,5}$`',
    `aircraft_total_cycles_at_release` STRING COMMENT 'Cumulative total flight cycles (takeoff and landing pairs) recorded on the aircraft at the time of release to service. Used for fatigue-sensitive component life tracking.',
    `aircraft_total_hours_at_release` DECIMAL(18,2) COMMENT 'Cumulative total flight hours (block hours) recorded on the aircraft at the time of release to service. Critical for life-limited parts tracking and maintenance interval calculations.',
    `aircraft_type_code` STRING COMMENT 'ICAO aircraft type designator for the aircraft model (e.g., B738 for Boeing 737-800, A320 for Airbus A320).. Valid values are `^[A-Z0-9]{3,7}$`',
    `airworthiness_directive_reference` STRING COMMENT 'Reference number of the airworthiness directive complied with during this maintenance activity, if applicable. Mandatory safety-related modification or inspection.',
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
    `mel_reference` STRING COMMENT 'MEL item reference if this release rectifies a previously deferred defect under MEL authority, returning the system to full operational status.',
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
    `service_bulletin_reference` STRING COMMENT 'Manufacturer service bulletin number incorporated during this maintenance activity, if applicable. Optional or recommended modification or inspection.',
    CONSTRAINT pk_release PRIMARY KEY(`release_id`)
) COMMENT 'Certificate of Release to Service (CRS) record issued by Part-145 certifying staff confirming that maintenance work has been completed satisfactorily and the aircraft or component is airworthy for return to service. Captures CRS number, work order reference, certifying staff name and licence number, approval organisation (Part-145 AMO), scope of work, date/time of release, aircraft hours/cycles at release, and any open items or limitations. Legally mandated airworthiness release document.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` (
    `approved_maintenance_org_id` BIGINT COMMENT 'Unique identifier for the Part-145 approved maintenance organisation record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: External MROs generate AP invoices for services rendered. Links MRO to their invoices for vendor payment tracking, spend analysis, and contract compliance verification.',
    `audit_event_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_event. Business justification: Part 145 approved maintenance organizations undergo regular regulatory audits (surveillance, renewal). Linking the organization to audit events tracks compliance history, certification status, and fin',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.audit. Business justification: Maintenance organizations are audited (Part-145 audits, IOSA). Link tracks audit history and findings against specific MROs, supports vendor quality management, and enables audit-driven MRO selection ',
    `emergency_drill_id` BIGINT COMMENT 'Foreign key linking to safety.emergency_drill. Business justification: MROs participate in emergency drills (aircraft recovery, hazmat response). Link tracks participation and performance, supports emergency response capability assessment, and demonstrates regulatory com',
    `employee_id` BIGINT COMMENT 'User ID or system identifier of the person or process that last modified this record.',
    `case_id` BIGINT COMMENT 'Foreign key linking to safety.case. Business justification: Safety cases may involve MRO capabilities and approvals (novel maintenance procedures, alternative compliance methods). Link supports regulatory submission, documents MRO role in safety case implement',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Part-145 maintenance stations operate under master service agreements governing rate cards, SLA terms, liability, insurance. Real process: maintenance planning references contract for labor rates and ',
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
    `station_code` STRING COMMENT 'Three-letter IATA or ICAO airport/station code where the maintenance organisation is located (e.g., FRA, LHR, JFK).. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_approved_maintenance_org PRIMARY KEY(`approved_maintenance_org_id`)
) COMMENT 'Part-145 Approved Maintenance Organisation (AMO) master record for internal base/line maintenance and contracted third-party MRO providers. Captures organisation name, ICAO/IATA station code, approval number, issuing authority (EASA Part-145, FAA Part-145 Repair Station, CAAC CCAR-145), approval scope (airframe rating, engine rating, component rating, avionics rating), capability list reference, approval expiry date, audit history, and commercial contract status. SSOT for MRO vendor qualification, regulatory approval tracking, and outsourced maintenance governance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`certifying_staff` (
    `certifying_staff_id` BIGINT COMMENT 'Unique identifier for the certifying staff member. Primary key for the certifying staff master record.',
    `audit_event_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_event. Business justification: Certifying staff are subject to competency audits, license verification, and authorization reviews. Linking staff to audit events tracks qualification compliance, training currency, and regulatory fin',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.audit. Business justification: Individual certifying staff may be subject to audits (competency audits, license verification). Link supports competency assurance, tracks audit findings against personnel, and demonstrates regulatory',
    `employee_id` BIGINT COMMENT 'The user ID or system identifier of the person or process that last modified this certifying staff record. Used for audit trail and accountability.',
    `authorisation_scope` STRING COMMENT 'The scope of maintenance tasks and ATA chapters the certifying staff member is authorized to sign off under the Part-145 approval. May include limitations or exclusions (e.g., authorized for line maintenance only, not base maintenance; authorized for ATA 32 Landing Gear but not ATA 71 Powerplant).',
    `authorization_effective_date` DATE COMMENT 'The date from which the certifying staff member is authorized to issue CRS under the current Part-145 organisation. Used to validate the legitimacy of historical sign-offs.',
    `authorization_expiry_date` DATE COMMENT 'The date on which the certifying staff members authorization under the current Part-145 organisation expires or is withdrawn. Null if authorization is open-ended pending employment or contract status.',
    `authorization_reference` STRING COMMENT 'The internal authorization or stamp number assigned by the Part-145 organisation to this certifying staff member. This reference appears on Certificates of Release to Service (CRS) and work orders to trace who certified the maintenance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certifying staff record was first created in the system. Used for audit trail and data lineage.',
    `email_address` STRING COMMENT 'Primary email address for official communication, training notifications, licence renewal reminders, and work order assignments.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_end_date` DATE COMMENT 'The date on which the certifying staff members employment or contract with the maintenance organisation ended. Null if currently employed.',
    `employment_start_date` DATE COMMENT 'The date on which the certifying staff member commenced employment or contract with the current maintenance organisation.',
    `employment_status` STRING COMMENT 'Current employment or contract status of the certifying staff member with the maintenance organisation. Active = currently employed and authorized; Inactive = on leave or temporarily not working; Suspended = authorization withdrawn pending investigation; Terminated = no longer employed.. Valid values are `active|inactive|suspended|terminated`',
    `full_name` STRING COMMENT 'The full legal name of the certifying staff member as it appears on their licence and official identification documents.',
    `issuing_authority` STRING COMMENT 'The national aviation authority or regulatory body that issued the licence (e.g., EASA, FAA, CAAC, DGCA, Transport Canada). This determines the regulatory framework and reciprocity agreements applicable to the licence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this certifying staff record was last updated. Used for audit trail and change tracking.',
    `last_recency_activity_date` DATE COMMENT 'The date of the most recent maintenance activity that counts toward recency requirements. Used to calculate whether the certifying staff member remains current.',
    `licence_category` STRING COMMENT 'The category of aircraft maintenance licence held. EASA categories: A (line maintenance), B1 (mechanical systems), B2 (avionics), B3 (non-pressurized piston aircraft), C (base maintenance). FAA: A&P (Airframe and Powerplant).. Valid values are `A|B1|B2|B3|C|A&P`',
    `licence_expiry_date` DATE COMMENT 'The date on which the aircraft maintenance licence expires and must be renewed. Critical for compliance tracking and work assignment eligibility.',
    `licence_issue_date` DATE COMMENT 'The date on which the aircraft maintenance licence was originally issued by the regulatory authority.',
    `licence_number` STRING COMMENT 'The unique aircraft maintenance engineer (AME) or Airframe and Powerplant (A&P) licence number issued by the national aviation authority. This is the regulatory identifier that authorizes the individual to certify maintenance work.. Valid values are `^[A-Z0-9-.]{6,20}$`',
    `licence_subcategory` STRING COMMENT 'The subcategory or endorsement within the licence category, such as B1.1 (turbine aeroplanes), B1.2 (piston aeroplanes), B1.3 (turbine helicopters), B1.4 (piston helicopters), B2 (avionics). Defines the specific aircraft propulsion and structural systems the licence holder is qualified for.',
    `medical_certificate_expiry_date` DATE COMMENT 'The expiry date of the medical certificate required for certifying staff in some jurisdictions. Ensures the individual is medically fit to perform safety-critical maintenance tasks.',
    `next_training_due_date` DATE COMMENT 'The date by which the certifying staff member must complete their next recurrent training to maintain authorization. Critical for proactive compliance management.',
    `part_145_organization_code` STRING COMMENT 'The approval code of the Part-145 maintenance organisation that currently employs or contracts this certifying staff member. This links the individual to the approved maintenance organisation under which they are authorized to issue Certificates of Release to Service (CRS).. Valid values are `^[A-Z0-9.]{4,15}$`',
    `phone_number` STRING COMMENT 'Primary contact phone number for emergency callouts, Aircraft on Ground (AOG) situations, and operational coordination.',
    `recency_experience_status` STRING COMMENT 'Indicates whether the certifying staff member has maintained the required recency of experience (e.g., performed maintenance within the last 2 years on the relevant aircraft type) as mandated by Part-66 and Part-145. Current = meets recency requirements; Lapsed = recency expired, requalification needed; Suspended = temporarily not authorized.. Valid values are `current|lapsed|suspended`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special qualifications, limitations, or administrative comments related to the certifying staff member (e.g., authorized for AOG callouts, restricted to line maintenance only, pending type rating renewal).',
    `shift_pattern` STRING COMMENT 'The typical shift or roster pattern for the certifying staff member (e.g., day shift, night shift, rotating 4-on-3-off, on-call). Used for crew scheduling and availability planning.',
    `staff_number` STRING COMMENT 'The externally-known employee or contractor identifier assigned by the maintenance organization or airline HR system. Used for payroll, access control, and work order assignment.. Valid values are `^[A-Z0-9]{6,12}$`',
    `training_completion_date` DATE COMMENT 'The date on which the certifying staff member completed their most recent mandatory training (e.g., type rating course, human factors, dangerous goods, SMS). Used for compliance tracking and audit trails.',
    `type_ratings` STRING COMMENT 'Comma-separated list of aircraft type ratings held by the certifying staff member (e.g., B737, A320, B777, A350). Type ratings authorize the individual to certify maintenance on specific aircraft models.',
    CONSTRAINT pk_certifying_staff PRIMARY KEY(`certifying_staff_id`)
) COMMENT 'Certifying staff master record for licensed aircraft maintenance engineers (AMEs) and authorised technicians qualified to issue CRS under Part-66/Part-145 or FAA A&P licence. Captures staff ID, licence number, licence category (A/B1/B2/C), type ratings, authorisation scope, issuing authority, licence expiry, medical validity, and current approval organisation. SSOT for maintenance sign-off authority and regulatory compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`forecast` (
    `forecast_id` BIGINT COMMENT 'Primary key for forecast',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: Maintenance forecast identifies the maintenance organization. The forecast table has part_145_organization_code (STRING) but no FK. Adding approved_maintenance_org_id FK normalizes this and removes re',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Maintenance forecasts feed annual budget planning. Links forecast to budget plan for multi-year planning, budget version control, and forecast-to-actual variance analysis.',
    `component_id` BIGINT COMMENT 'Foreign key linking to maintenance.component. Business justification: Maintenance forecast may be for a specific component. The forecast table has component_part_number and component_serial_number but no FK. Adding component_id FK normalizes this and removes redundant c',
    `program_id` BIGINT COMMENT 'Foreign key linking to maintenance.program. Business justification: Maintenance forecast is based on a maintenance program. The forecast table has maintenance_program_reference (STRING) but no FK. Adding maintenance_program_id FK normalizes this and removes redundant ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Links forecasted maintenance event to advance parts procurement for long-lead-time items (engines, landing gear). Real process: maintenance planning triggers PO 6-12 months ahead of forecast check; pr',
    `aircraft_registration` STRING COMMENT 'Tail number uniquely identifying the aircraft for which this forecast applies. Links to fleet master data.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `airworthiness_directive_number` STRING COMMENT 'Official AD number issued by the aviation authority (FAA, EASA, etc.) when the forecast pertains to a repetitive AD compliance interval.. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{2,4}[A-Z]?$`',
    `ata_chapter` STRING COMMENT 'Two-digit ATA chapter code categorizing the aircraft system or component subject to the forecasted maintenance (e.g., 32 for Landing Gear, 71 for Powerplant).. Valid values are `^[0-9]{2}$`',
    `average_daily_utilization_cycles` DECIMAL(18,2) COMMENT 'Average flight cycles per day for this aircraft over the recent historical period, used to project future due dates from cycle-based intervals.',
    `average_daily_utilization_hours` DECIMAL(18,2) COMMENT 'Average flight hours per day for this aircraft over the recent historical period, used to project future due dates from hour-based intervals.',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when this forecast record was calculated or last recalculated. Used to track forecast freshness and trigger recalculation cycles.',
    `confidence_level` STRING COMMENT 'Qualitative assessment of forecast accuracy based on data quality, utilization stability, and planning assumptions. High indicates stable utilization and reliable data; low indicates volatile operations or incomplete data.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was first created in the system. Part of audit trail for data lineage and compliance.',
    `current_flight_cycles` STRING COMMENT 'Current cumulative flight cycles on the aircraft or component at the time of forecast calculation. Baseline for projecting due thresholds.',
    `current_flight_hours` DECIMAL(18,2) COMMENT 'Current cumulative flight hours on the aircraft or component at the time of forecast calculation. Baseline for projecting due thresholds.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Projected total cost in US dollars for the forecasted maintenance event, including labor, parts, and overhead. Used for budget planning and financial forecasting.',
    `estimated_downtime_days` STRING COMMENT 'Projected number of days the aircraft will be out of service (AOG or in maintenance) to complete the forecasted maintenance event.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Projected total labor hours required to complete the forecasted maintenance task, used for resource planning and cost estimation.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast record. Active forecasts are used for planning; superseded forecasts have been replaced by newer calculations; completed forecasts correspond to executed maintenance events.. Valid values are `active|superseded|cancelled|completed`',
    `forecast_type` STRING COMMENT 'Category of maintenance event being forecasted: scheduled check (A/C/D), life-limited part retirement, airworthiness directive repetitive interval, or APU overhaul.. Valid values are `A-check|C-check|D-check|LLP retirement|AD repetitive|APU overhaul`',
    `hangar_slot_reservation_required` BOOLEAN COMMENT 'Indicates whether this forecasted maintenance event requires advance reservation of hangar capacity and maintenance slots at a Part-145 facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was last updated. Tracks data currency and supports change auditing.',
    `maintenance_station_code` STRING COMMENT 'Three-letter IATA or ICAO station code of the planned maintenance facility or base where the forecasted maintenance is expected to be performed.. Valid values are `^[A-Z]{3}$`',
    `maintenance_task_code` STRING COMMENT 'Alphanumeric code identifying the specific maintenance task or check from the Maintenance Planning Document (MPD) or maintenance program.. Valid values are `^[A-Z0-9]{4,12}$`',
    `planning_horizon_days` STRING COMMENT 'Number of days from the forecast calculation date to the projected due date. Indicates how far in advance this maintenance event is being planned.',
    `projected_due_date` DATE COMMENT 'Forecasted calendar date when the maintenance event is expected to become due based on current utilization trends and remaining intervals.',
    `projected_due_flight_cycles` STRING COMMENT 'Forecasted cumulative flight cycles (takeoff-landing pairs) at which the maintenance event will become due. Used for cycle-based maintenance intervals.',
    `projected_due_flight_hours` DECIMAL(18,2) COMMENT 'Forecasted cumulative flight hours at which the maintenance event will become due. Used for hour-based maintenance intervals.',
    `remaining_flight_cycles` STRING COMMENT 'Calculated remaining flight cycles until the maintenance event becomes due (projected_due_flight_cycles minus current_flight_cycles).',
    `remaining_flight_hours` DECIMAL(18,2) COMMENT 'Calculated remaining flight hours until the maintenance event becomes due (projected_due_flight_hours minus current_flight_hours).',
    `remarks` STRING COMMENT 'Free-text field for maintenance planners to record notes, assumptions, special conditions, or planning considerations related to this forecast.',
    `version` STRING COMMENT 'Sequential version number of this forecast for the same aircraft and maintenance task. Increments each time the forecast is recalculated, enabling historical trend analysis.',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Forward-looking maintenance planning forecast record projecting when each aircraft will next reach scheduled maintenance thresholds (check due dates, component hard-time limits, AD repetitive intervals). Captures tail number, forecast type (A/C/D-check, LLP retirement, AD repetitive), projected due date, projected due FH, projected due FC, planning horizon, confidence level, and last recalculation timestamp. Enables long-range maintenance planning and hangar slot reservation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`visit` (
    `visit_id` BIGINT COMMENT 'Primary key for visit',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to maintenance.approved_maintenance_org. Business justification: Maintenance visit is at an approved maintenance organization facility. The visit table has amo_facility_code (STRING) but no FK. Adding approved_maintenance_org_id FK normalizes this and removes redun',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Maintenance visits are tracked against budgeted maintenance spend. Links visit to budget plan for cost control, variance reporting, and annual budget performance tracking.',
    `certifying_staff_id` BIGINT COMMENT 'Foreign key linking to maintenance.certifying_staff. Business justification: Maintenance visit is certified by certifying staff. The visit table has certifying_staff_licence_number (STRING) but no FK. Adding certifying_staff_id FK normalizes this and removes redundant certifyi',
    `program_id` BIGINT COMMENT 'Foreign key linking to maintenance.program. Business justification: Maintenance visit is based on a maintenance program. The visit table has maintenance_program_reference (STRING) but no FK. Adding maintenance_program_id FK normalizes this and removes redundant mainte',
    `release_id` BIGINT COMMENT 'Foreign key linking to maintenance.release. Business justification: Maintenance visit results in a Certificate of Release to Service. The visit table has crs_reference_number (STRING) but no FK. Adding maintenance_release_id FK normalizes this and removes redundant cr',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Maintenance visits occur at specific stations. Links station_code to station.station_id for hangar capacity planning, visit cost tracking by location, and maintenance network performance analysis.',
    `actual_release_date` DATE COMMENT 'Actual date when the aircraft was released from maintenance and returned to service. Null until visit is completed.',
    `actual_release_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the aircraft was released from maintenance, including time zone. Used for on-time performance and turnaround time analysis.',
    `ad_compliance_count` STRING COMMENT 'Number of airworthiness directives complied with during this maintenance visit. Critical for regulatory compliance tracking.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration mark of the aircraft undergoing maintenance. Links to fleet master data.. Valid values are `^[A-Z0-9]{5,7}$`',
    `aircraft_total_cycles_at_induction` STRING COMMENT 'Cumulative total flight cycles (takeoff/landing pairs) of the aircraft at the time of maintenance visit induction. Used for cycle-based maintenance tracking.',
    `aircraft_total_flight_hours_at_induction` DECIMAL(18,2) COMMENT 'Cumulative total flight hours (block hours) of the aircraft at the time of maintenance visit induction. Used for interval-based maintenance tracking.',
    `check_type` STRING COMMENT 'Maintenance check designation (A, B, C, D, 1C, 2C, etc.) indicating the scope and depth of scheduled maintenance performed during this visit.. Valid values are `^[A-Z][0-9]{0,2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance visit record was first created in the system. Used for audit trail and data lineage.',
    `crs_issue_date` DATE COMMENT 'Date when the Certificate of Release to Service (EASA Form 1 / FAA Form 337 equivalent) was issued, certifying the aircraft is airworthy and released from maintenance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this visit record. Typically USD but may vary by MRO facility location.. Valid values are `^[A-Z]{3}$`',
    `defect_count` STRING COMMENT 'Total number of defects or discrepancies identified and rectified during this maintenance visit. Used for quality and reliability analysis.',
    `delay_hours` DECIMAL(18,2) COMMENT 'Total delay in hours between planned release date and actual release date. Negative values indicate early completion. Used for schedule adherence and performance analysis.',
    `delay_reason_category` STRING COMMENT 'Primary category explaining any delay in the maintenance visit: on_time (no delay), parts_delay (awaiting material), technical_finding (unexpected defects), resource_constraint (labor/tooling shortage), weather (environmental), vendor_delay (external supplier), scope_change (work scope expansion). [ENUM-REF-CANDIDATE: on_time|parts_delay|technical_finding|resource_constraint|weather|vendor_delay|scope_change — 7 candidates stripped; promote to reference product]',
    `estimated_release_date` DATE COMMENT 'Current estimated date for aircraft release, updated as work progresses. May differ from planned date due to findings or delays.',
    `induction_date` DATE COMMENT 'Date when the aircraft was inducted into the maintenance facility and work commenced. Marks the start of the visit lifecycle.',
    `induction_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the aircraft was inducted into the maintenance facility, including time zone. Used for detailed scheduling and SLA tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance visit record was last updated. Used for audit trail and change tracking.',
    `llp_replacement_count` STRING COMMENT 'Number of life-limited parts replaced during this maintenance visit. Critical for airworthiness and component life tracking.',
    `mel_deferral_count` STRING COMMENT 'Number of MEL deferrals addressed or cleared during this maintenance visit. Used for dispatch reliability analysis.',
    `planned_release_date` DATE COMMENT 'Originally scheduled date for aircraft release back to service. Used for capacity planning and schedule recovery analysis.',
    `reference_number` STRING COMMENT 'External business identifier for the maintenance visit, used for tracking and invoicing across MRO facilities and operators.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or observations related to this maintenance visit. Used for operational context and audit trail.',
    `sb_incorporation_count` STRING COMMENT 'Number of manufacturer service bulletins incorporated during this maintenance visit. Used for fleet modification tracking.',
    `total_labour_cost_usd` DECIMAL(18,2) COMMENT 'Total labor cost for all maintenance work performed during this visit, in US dollars. Calculated from man-hours and labor rates.',
    `total_man_hours_actual` DECIMAL(18,2) COMMENT 'Total actual labor hours expended on all maintenance tasks in this visit. Used for cost tracking and productivity analysis.',
    `total_man_hours_planned` DECIMAL(18,2) COMMENT 'Total planned labor hours for all maintenance tasks in this visit, used for resource planning and capacity management.',
    `total_material_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of all parts, components, consumables, and materials used during this maintenance visit, in US dollars. Excludes labor costs.',
    `total_visit_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of the maintenance visit including labor, material, overhead, and facility charges, in US dollars. Used for MRO commercial management and budget tracking.',
    `visit_status` STRING COMMENT 'Current lifecycle status of the maintenance visit: planned (scheduled but not started), inducted (aircraft received at facility), in_progress (work underway), inspection (quality assurance), awaiting_parts (work paused for material), released (aircraft returned to service), cancelled (visit aborted). [ENUM-REF-CANDIDATE: planned|inducted|in_progress|inspection|awaiting_parts|released|cancelled — 7 candidates stripped; promote to reference product]',
    `visit_type` STRING COMMENT 'Classification of maintenance visit: line (routine checks at gate/hangar), base (scheduled major checks), heavy (C/D checks), engine_shop (engine overhaul), component_shop (component repair), aog_recovery (Aircraft on Ground emergency repair).. Valid values are `line|base|heavy|engine_shop|component_shop|aog_recovery`',
    `work_order_count` STRING COMMENT 'Total number of individual work orders or work packages executed during this maintenance visit. Used for complexity and scope tracking.',
    `work_scope_summary` STRING COMMENT 'High-level textual summary of the maintenance work scope, including major tasks, inspections, modifications, and component replacements planned or performed during this visit.',
    CONSTRAINT pk_visit PRIMARY KEY(`visit_id`)
) COMMENT 'Planned or actual maintenance visit (induction) record at a specific MRO facility or line station. Captures visit reference, aircraft registration, visit type (line/base/engine shop), induction date, planned release date, actual release date, AMO facility, work scope summary, total man-hours, total material cost, total labour cost, and visit status. Bridges maintenance planning to MRO commercial management and cost tracking.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`engineering_order` (
    `engineering_order_id` BIGINT COMMENT 'Unique identifier for the engineering order. Primary key.',
    `component_id` BIGINT COMMENT 'Foreign key linking to maintenance.component. Business justification: Engineering order may target a specific component. The engineering_order table has component_part_number and component_serial_number but no FK. Adding component_id FK normalizes this and removes redun',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Engineering orders for aircraft modifications create or modify fixed assets (STCs, major mods). Links EO to asset record for capitalization, depreciation, and asset register updates.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to safety.corrective_action. Business justification: Engineering orders (modifications, STCs) often implement corrective actions from safety recommendations. Links design changes to safety actions, tracks major modification implementation, and supports ',
    `recommendation_id` BIGINT COMMENT 'Foreign key linking to safety.recommendation. Business justification: Engineering orders implement design/modification recommendations from safety investigations. Critical for tracking major safety improvements, supports regulatory approval of recommendation-driven modi',
    `employee_id` BIGINT COMMENT 'Employee identifier or license number of the certifying engineer who approved this engineering order.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: STC/modification implementation requires specialized kits and parts with certification traceability. Real process: engineering references PO for material certification documents (Form 1/8130-3) requir',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Engineering orders (STCs, major modifications) require design approval from specific regulatory authorities. Tracking the approval authority is mandatory for airworthiness compliance, determining whic',
    `case_id` BIGINT COMMENT 'Foreign key linking to safety.case. Business justification: Engineering orders (major modifications) require safety cases for regulatory approval. Link tracks case-to-implementation, supports regulatory submission documentation, and demonstrates that approved ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Engineering order is executed via a work order. The engineering_order table has work_order_number (STRING) but no FK. Adding work_order_id FK normalizes this and removes redundant work_order_number.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration mark of the aircraft to which this engineering order applies. May be null for fleet-wide orders.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `aircraft_type_code` STRING COMMENT 'ICAO or manufacturer aircraft type designator (e.g., B737, A320, B77W) indicating the aircraft model family to which this order applies.. Valid values are `^[A-Z0-9]{3,10}$`',
    `approval_date` DATE COMMENT 'Date on which the engineering order was approved by the engineering authority or CAMO.',
    `ata_chapter` STRING COMMENT 'ATA iSpec 2200 chapter code identifying the aircraft system or component affected by this engineering order (e.g., 27 for flight controls, 32 for landing gear).. Valid values are `^[0-9]{2}(-[0-9]{2})?$`',
    `camo_organization_code` STRING COMMENT 'EASA Part-M Subpart G CAMO approval number of the organization managing the continuing airworthiness for this engineering order.. Valid values are `^[A-Z0-9.]{3,15}$`',
    `compliance_due_date` DATE COMMENT 'Calendar date by which this engineering order must be complied with, if a time-based compliance threshold applies.',
    `compliance_due_flight_cycles` STRING COMMENT 'Aircraft total flight cycles at which this engineering order must be complied with, if a cycle-based compliance threshold applies.',
    `compliance_due_flight_hours` DECIMAL(18,2) COMMENT 'Aircraft total flight hours at which this engineering order must be complied with, if a flight-hour-based compliance threshold applies.',
    `compliance_method` STRING COMMENT 'Method of compliance for this engineering order: mandatory (must be done), optional (operator discretion), on-condition (when defect found), or at next opportunity (next scheduled maintenance).. Valid values are `mandatory|optional|on_condition|at_next_opportunity`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this engineering order record was first created in the system.',
    `design_approval_reference` STRING COMMENT 'Reference to the design approval document: EASA Form 1, FAA Form 337, DER (Designated Engineering Representative) approval, or STC number authorizing the modification.',
    `document_url` STRING COMMENT 'URL or file path to the engineering order document, technical drawings, or supporting documentation stored in the document management system.',
    `effective_date` DATE COMMENT 'Date from which this engineering order becomes effective and may be applied to aircraft.',
    `effectivity` STRING COMMENT 'Effectivity statement defining which aircraft, serial numbers, or configurations this engineering order applies to (e.g., all aircraft, specific MSN range, or configuration-dependent).',
    `eo_number` STRING COMMENT 'The externally-known business identifier for the engineering order, typically formatted as EO- followed by alphanumeric code.. Valid values are `^EO-[A-Z0-9]{6,12}$`',
    `eo_revision` STRING COMMENT 'Revision level of the engineering order, incremented when the order is modified or updated.. Valid values are `^[A-Z0-9]{1,5}$`',
    `eo_status` STRING COMMENT 'Current lifecycle status of the engineering order in the approval and execution workflow.. Valid values are `draft|approved|in_progress|completed|cancelled|superseded`',
    `eo_type` STRING COMMENT 'Classification of the engineering order: structural repair, modification, STC (Supplemental Type Certificate), deviation from type design, design change, or service bulletin incorporation.. Valid values are `structural_repair|modification|stc|deviation|design_change|service_bulletin`',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in US dollars to accomplish the engineering order, including labor, parts, and materials.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated total labor hours required to accomplish the engineering order, used for planning and cost estimation.',
    `expiry_date` DATE COMMENT 'Date on which this engineering order expires or is superseded. Null for orders with indefinite validity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this engineering order record was last updated in the system.',
    `modification_description` STRING COMMENT 'Detailed technical description of the structural repair, modification, or deviation being authorized by this engineering order.',
    `part_145_organization_code` STRING COMMENT 'EASA Part-145 or FAA Part 145 approval number of the maintenance organization authorized to perform the work defined in this engineering order.. Valid values are `^[A-Z0-9.]{3,15}$`',
    `related_ad_number` STRING COMMENT 'Airworthiness Directive number if this engineering order is issued in response to or in compliance with an AD. Null if not AD-related.',
    `related_sb_number` STRING COMMENT 'Manufacturer Service Bulletin number if this engineering order implements or references an SB. Null if not SB-related.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or clarifications related to this engineering order.',
    `stc_number` STRING COMMENT 'STC number if the engineering order implements a supplemental type certificate modification. Null if not applicable.. Valid values are `^STC-[A-Z0-9]{5,15}$`',
    `superseded_by_eo_number` STRING COMMENT 'EO number of the engineering order that supersedes this one. Null if not superseded.',
    CONSTRAINT pk_engineering_order PRIMARY KEY(`engineering_order_id`)
) COMMENT 'Engineering Order (EO) or Modification Order issued by the airlines engineering department authorising a structural repair, modification, or deviation from type design. Captures EO number, revision, ATA chapter, modification type (STC, repair scheme, deviation), design approval reference (EASA Form 1, DER approval), effectivity, compliance method, and associated work order. SSOT for fleet modification and repair scheme management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`material_request` (
    `material_request_id` BIGINT COMMENT 'Primary key for material_request',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager who approved the material requisition for processing.',
    `primary_material_requestor_employee_id` BIGINT COMMENT 'Identifier of the maintenance planner, technician, or engineer who raised the material requisition.',
    `tertiary_material_employee_id` BIGINT COMMENT 'System user identifier of the person who last modified this material request record.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external vendor or supplier from whom the part was procured, if applicable for externally sourced materials.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order against which this material request was raised.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration mark of the aircraft for which the material is being requested.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `ata_chapter` STRING COMMENT 'Two-digit ATA chapter code classifying the aircraft system to which the requested part belongs (e.g., 32 for Landing Gear, 71 for Power Plant).. Valid values are `^[0-9]{2}$`',
    `batch_number` STRING COMMENT 'Batch or lot number of the issued material for traceability and quality control purposes, particularly important for life-limited parts and consumables.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this material request record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the material cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `issue_date` DATE COMMENT 'The date when the material was physically issued from the store location to the maintenance technician or work location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this material request record was last updated or modified.',
    `part_description` STRING COMMENT 'Detailed textual description of the part, consumable, or tooling item being requested to aid identification and verification.',
    `part_number` STRING COMMENT 'Manufacturer or OEM (Original Equipment Manufacturer) part number identifying the specific component, consumable, or tooling being requested.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `priority_level` STRING COMMENT 'Priority classification of the material request determining the urgency of fulfilment. AOG (Aircraft on Ground) requests receive immediate attention.. Valid values are `low|normal|high|urgent|aog`',
    `purchase_order_number` STRING COMMENT 'Reference to the purchase order number if the material was procured externally to fulfil this requisition.. Valid values are `^[A-Z0-9]{8,20}$`',
    `quantity_issued` DECIMAL(18,2) COMMENT 'The actual quantity of the part or material issued from stores to fulfil this request. May differ from quantity requested due to partial fulfilment or substitution.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'The quantity of the part or material requested for the maintenance work order.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special handling instructions, or comments related to the material requisition.',
    `request_status` STRING COMMENT 'Current lifecycle status of the material requisition indicating its progress through the procurement and fulfilment workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|issued|partially_fulfilled|fulfilled|cancelled|rejected — 8 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Classification of the material request based on urgency and purpose. AOG (Aircraft on Ground) requests receive highest priority.. Valid values are `routine|aog|critical|stock_replenishment|project`',
    `requested_date` DATE COMMENT 'The date when the material requisition was created and submitted by the maintenance planner or technician.',
    `required_by_date` DATE COMMENT 'The target date by which the material must be available to support the scheduled maintenance work order execution.',
    `requisition_number` STRING COMMENT 'Externally-known unique requisition number assigned to this material request for tracking and reference purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `return_quantity` DECIMAL(18,2) COMMENT 'The quantity of material returned to store if the full issued quantity was not consumed during maintenance execution.',
    `return_to_store_flag` BOOLEAN COMMENT 'Indicates whether unused material from this requisition was returned to store inventory after work order completion.',
    `serial_number` STRING COMMENT 'Serial number of the specific component issued, applicable for serialized rotable parts and life-limited parts (LLP) requiring individual tracking.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `shelf_life_expiry_date` DATE COMMENT 'Expiration date for time-sensitive materials such as sealants, adhesives, lubricants, and chemicals that have limited shelf life.',
    `station_code` STRING COMMENT 'Three-letter IATA airport or station code where the material is required for maintenance execution.. Valid values are `^[A-Z]{3}$`',
    `store_location_code` STRING COMMENT 'Code identifying the warehouse, store, or inventory location from which the material is to be issued.. Valid values are `^[A-Z0-9]{3,10}$`',
    `substitute_part_number` STRING COMMENT 'The part number of the substitute material that was issued if the originally requested part was unavailable.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether an alternative or substitute part was issued in place of the originally requested part number.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the material requisition calculated as quantity issued multiplied by unit cost.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the material at the time of requisition, used for inventory valuation and cost tracking.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the requested quantity (e.g., each, kilogram, liter, meter). [ENUM-REF-CANDIDATE: each|kg|liter|meter|gallon|pound|set|kit — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_material_request PRIMARY KEY(`material_request_id`)
) COMMENT 'Material requisition record raised against a work order to request parts, consumables, or tooling required for maintenance execution. Captures requisition number, work order reference, part number, quantity required, unit of measure, urgency (AOG/routine/stock), requested date, issue date, issue quantity, store location, and fulfilment status. Links MRO execution to materials management and inventory consumption.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`apu_status` (
    `apu_status_id` BIGINT COMMENT 'Unique identifier for the APU status record. Primary key.',
    `aircraft_id` BIGINT COMMENT 'Reference to the aircraft on which this APU is currently installed.',
    `defect_report_id` BIGINT COMMENT 'Reference to the most recent defect report raised against this APU, if any.',
    `work_order_id` BIGINT COMMENT 'Reference to the most recent maintenance work order performed on this APU.',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: APU status on leased aircraft requires lease contract linkage for maintenance reserve calculations and lease return condition verification. Critical for lessor APU condition reporting.',
    `airworthiness_certificate_expiry_date` DATE COMMENT 'Expiry date of the APU airworthiness certificate. APU must not be operated beyond this date without certificate renewal.',
    `airworthiness_certificate_number` STRING COMMENT 'Certificate number issued by the aviation authority confirming the APU meets airworthiness standards and is approved for installation.',
    `apu_model` STRING COMMENT 'APU model designation as specified by the manufacturer (e.g., GTCP131-9A, APS3200).',
    `apu_part_number` STRING COMMENT 'Manufacturer part number identifying the APU model and configuration. Used for parts catalog and maintenance program applicability.',
    `apu_serial_number` STRING COMMENT 'Unique serial number assigned by the APU manufacturer to this specific unit. Used for tracking maintenance history and airworthiness compliance.',
    `borescope_inspection_interval_hours` DECIMAL(18,2) COMMENT 'Operating hours interval between borescope inspections as specified in the APU maintenance program.',
    `cycles_since_new` STRING COMMENT 'Total operating cycles accumulated by the APU since it was manufactured (never reset, even after overhaul).',
    `cycles_since_overhaul` STRING COMMENT 'Operating cycles accumulated since the last major overhaul or shop visit. Reset to zero after overhaul. Used to determine next overhaul due.',
    `hours_since_new` DECIMAL(18,2) COMMENT 'Total operating hours accumulated by the APU since it was manufactured (never reset, even after overhaul).',
    `hours_since_overhaul` DECIMAL(18,2) COMMENT 'Operating hours accumulated since the last major overhaul or shop visit. Reset to zero after overhaul. Used to determine next overhaul due.',
    `installation_date` DATE COMMENT 'Date when the APU was installed on the current aircraft. Used to calculate time-in-service and time-since-installation intervals.',
    `installation_flight_cycles` STRING COMMENT 'Total aircraft flight cycles at the time the APU was installed. Used as baseline for calculating APU cycles-on-wing.',
    `installation_flight_hours` DECIMAL(18,2) COMMENT 'Total aircraft flight hours at the time the APU was installed. Used as baseline for calculating APU time-on-wing.',
    `last_borescope_inspection_date` DATE COMMENT 'Date of the most recent borescope inspection of the APU hot section. Borescope inspections are performed to assess internal condition without disassembly.',
    `last_borescope_inspection_hours` DECIMAL(18,2) COMMENT 'Total APU operating hours at the time of the last borescope inspection. Used to calculate next inspection due.',
    `last_overhaul_date` DATE COMMENT 'Date when the APU last underwent major overhaul or shop visit at a Part-145 approved maintenance organization.',
    `last_overhaul_organization` STRING COMMENT 'Name or code of the Part-145 approved maintenance organization that performed the last APU overhaul.',
    `lease_status` STRING COMMENT 'Ownership and lease status of the APU. Indicates whether the APU is owned by the operator, leased from a lessor, on loan from another operator, or part of a pooling agreement.. Valid values are `owned|leased|on_loan|pooled`',
    `maintenance_program_reference` STRING COMMENT 'Reference to the approved APU maintenance program document that defines all scheduled maintenance tasks and intervals for this APU model.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) of the APU (e.g., Honeywell, Pratt & Whitney Canada).',
    `mel_category` STRING COMMENT 'MEL category of the APU deferral if applicable. Category A requires rectification before next flight, B within 3 days, C within 10 days, D within 120 days.. Valid values are `A|B|C|D`',
    `mel_deferral_reference` STRING COMMENT 'Reference to the active MEL deferral if the APU is currently operating under a deferral. Empty if APU is fully serviceable.',
    `next_borescope_inspection_due_hours` DECIMAL(18,2) COMMENT 'Total APU operating hours at which the next borescope inspection is due.',
    `next_overhaul_due_cycles` STRING COMMENT 'Total APU operating cycles at which the next overhaul is due. Calculated as cycles_since_overhaul plus overhaul_interval_cycles.',
    `next_overhaul_due_date` DATE COMMENT 'Calendar date by which the next APU overhaul must be completed, based on the calendar interval limit.',
    `next_overhaul_due_hours` DECIMAL(18,2) COMMENT 'Total APU operating hours at which the next overhaul is due. Calculated as hours_since_overhaul plus overhaul_interval_hours.',
    `operational_status` STRING COMMENT 'Current functional state of the APU independent of airworthiness status. Indicates whether the APU can be started and operated.. Valid values are `operational|non_operational|limited_operation|test_mode`',
    `overhaul_interval_cycles` STRING COMMENT 'Manufacturer-specified or operator-approved interval in operating cycles between major overhauls. Defines when the next overhaul is due.',
    `overhaul_interval_hours` DECIMAL(18,2) COMMENT 'Manufacturer-specified or operator-approved interval in operating hours between major overhauls. Defines when the next overhaul is due.',
    `overhaul_interval_months` STRING COMMENT 'Calendar time interval in months between major overhauls, whichever limit is reached first (hours, cycles, or months).',
    `owner_organization` STRING COMMENT 'Legal owner of the APU (airline, lessor, or leasing company). May differ from the aircraft operator.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this APU status record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this APU status record was last modified in the system.',
    `remaining_cycles_to_overhaul` STRING COMMENT 'Operating cycles remaining until the next overhaul is due. Calculated as next_overhaul_due_cycles minus total_apu_cycles.',
    `remaining_hours_to_overhaul` DECIMAL(18,2) COMMENT 'Operating hours remaining until the next overhaul is due. Calculated as next_overhaul_due_hours minus total_apu_hours.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special conditions related to the APU status and maintenance history.',
    `removal_date` DATE COMMENT 'Date when the APU was removed from the aircraft. Null if the APU is currently installed.',
    `removal_reason` STRING COMMENT 'Reason for APU removal from the aircraft (e.g., scheduled overhaul, unscheduled failure, aircraft retirement, component upgrade).',
    `serviceability_status` STRING COMMENT 'Current operational and airworthiness status of the APU. Serviceable means the APU is fully operational and meets all airworthiness requirements. Unserviceable indicates the APU has a defect that prevents operation. Deferred indicates operation under MEL deferral.. Valid values are `serviceable|unserviceable|deferred|aog|under_maintenance|awaiting_parts`',
    `storage_location` STRING COMMENT 'Physical storage location or warehouse code where the APU is stored if removed from aircraft. Empty if currently installed.',
    `total_apu_cycles` STRING COMMENT 'Cumulative start-stop cycles of the APU since new or since last zero-time overhaul. One cycle equals one start and shutdown sequence.',
    `total_apu_hours` DECIMAL(18,2) COMMENT 'Cumulative operating hours of the APU since new or since last zero-time overhaul. Primary maintenance interval parameter for APU maintenance program.',
    CONSTRAINT pk_apu_status PRIMARY KEY(`apu_status_id`)
) COMMENT 'Auxiliary Power Unit (APU) status and utilisation record tracking the operational and maintenance state of the APU fitted to each aircraft. Captures APU part number, serial number, total APU hours, total APU cycles, time since last overhaul (TSO hours/cycles), next overhaul due, current serviceability status, last borescope inspection date, and fitted aircraft registration. APU has its own maintenance programme separate from the airframe.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`reliability_event` (
    `reliability_event_id` BIGINT COMMENT 'Unique identifier for the reliability event record. Primary key for the reliability event entity.',
    `component_id` BIGINT COMMENT 'Foreign key linking to maintenance.component. Business justification: Reliability event may involve a specific component. The reliability_event table has component_part_number and component_serial_number but no FK. Adding component_id FK normalizes this and removes redu',
    `employee_id` BIGINT COMMENT 'The user identifier of the person who last modified this reliability event record.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to safety.hazard. Business justification: Reliability events may identify or confirm hazards (chronic issues revealing systemic risks). Link supports proactive hazard identification from operational data, enables reliability-driven SMS hazard',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to safety.investigation. Business justification: Reliability events (chronic issues, trends) may trigger formal safety investigations when patterns indicate systemic risk. Link supports proactive safety management, enables reliability-driven investi',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: Captures which part number experienced reliability event (delay, repeat defect) for MSG-3 analysis and manufacturer notification. Real process: reliability engineers analyze event rates by part number',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Reliability events (delays, defects, cancellations) occur at specific stations. Links station_code to station.station_id for reliability analysis by location, identifying stations with chronic issues,',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Reliability event may be resolved via a work order. The reliability_event table has work_order_number (STRING) but no FK. Adding work_order_id FK normalizes this and removes redundant work_order_numbe',
    `aircraft_registration` STRING COMMENT 'The unique registration identifier (tail number) of the aircraft on which the reliability event occurred.. Valid values are `^[A-Z0-9]{5,6}$`',
    `aircraft_total_cycles_at_event` STRING COMMENT 'The cumulative total flight cycles (takeoff/landing cycles) of the aircraft at the time the reliability event occurred.',
    `aircraft_total_hours_at_event` DECIMAL(18,2) COMMENT 'The cumulative total flight hours (airframe hours) of the aircraft at the time the reliability event occurred.',
    `aircraft_type_code` STRING COMMENT 'IATA or ICAO aircraft type designator code (e.g., B738 for Boeing 737-800, A320 for Airbus A320).. Valid values are `^[A-Z0-9]{3,4}$`',
    `alert_level` STRING COMMENT 'The alert level assigned to this reliability event based on frequency and severity thresholds: green (within normal limits), amber (approaching alert threshold), red (exceeds alert threshold, requires immediate action).. Valid values are `green|amber|red`',
    `ata_chapter` STRING COMMENT 'The two-digit ATA chapter code identifying the aircraft system involved in the reliability event (e.g., 21=Air Conditioning, 32=Landing Gear, 71=Power Plant).. Valid values are `^[0-9]{2}$`',
    `ata_section` STRING COMMENT 'The ATA section code providing more granular system identification within the ATA chapter (format: XX-YY).. Valid values are `^[0-9]{2}-[0-9]{2}$`',
    `chronic_event_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) identifying whether this reliability event is part of a chronic (recurring) reliability issue requiring fleet-wide attention or MSG-3 task review.',
    `closure_date` DATE COMMENT 'The date when the reliability event was formally closed after completion of all corrective actions and documentation.',
    `corrective_action` STRING COMMENT 'Description of the corrective maintenance action or operational procedure change implemented to resolve the reliability event and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this reliability event record was first created in the system (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `defect_code` STRING COMMENT 'The standardized defect code or fault code identifying the specific technical issue that caused the reliability event.',
    `defect_description` STRING COMMENT 'Free-text description of the technical defect or issue that triggered the reliability event, as reported by flight crew or maintenance personnel.',
    `delay_minutes` STRING COMMENT 'The total delay duration in minutes caused by the reliability event. Null if event type is not a delay. Technical delays are typically >15 minutes per IATA standards.',
    `event_date` DATE COMMENT 'The calendar date on which the reliability event occurred (format: yyyy-MM-dd).',
    `event_status` STRING COMMENT 'The current lifecycle status of the reliability event: open (newly reported), under_investigation (root cause analysis in progress), resolved (corrective action completed), closed (event fully documented and archived).. Valid values are `open|under_investigation|resolved|closed`',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the reliability event was recorded or occurred (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `event_type` STRING COMMENT 'The category of reliability event: technical_delay (delay >15 minutes due to technical issue), cancellation (flight cancelled due to technical issue), ifsd (In-Flight Shutdown), atb (Air Turnback), diversion (unscheduled landing at alternate airport), unscheduled_removal (component removed outside scheduled maintenance).. Valid values are `technical_delay|cancellation|ifsd|atb|diversion|unscheduled_removal`',
    `flight_number` STRING COMMENT 'The airline flight number associated with the reliability event (e.g., AA1234, BA456).. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this reliability event record was last updated or modified (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `maintenance_organization_code` STRING COMMENT 'The code identifying the Part-145 approved maintenance organization or station that performed the corrective action.',
    `manufacturer_serial_number` STRING COMMENT 'The unique serial number assigned by the aircraft manufacturer to this specific airframe.',
    `msg3_task_reference` STRING COMMENT 'Reference to the MSG-3 scheduled maintenance task that may require effectiveness review based on this reliability event.',
    `pirep_reference` STRING COMMENT 'Reference number or identifier of the pilot report (PIREP) that documented the in-flight reliability event.',
    `remarks` STRING COMMENT 'Additional free-text notes, observations, or contextual information related to the reliability event.',
    `repeat_event_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) identifying whether this reliability event is a repeat occurrence of a previously reported issue on the same aircraft or component.',
    `reporting_period` STRING COMMENT 'The year-month reporting period for monthly reliability reporting aggregation (format: YYYY-MM).. Valid values are `^[0-9]{4}-[0-9]{2}$`',
    `root_cause_category` STRING COMMENT 'The high-level classification of the root cause: design (inherent design issue), maintenance (maintenance-induced), operational (crew or operational procedure issue), no_fault_found (defect could not be replicated), external (weather, FOD, bird strike, etc.).. Valid values are `design|maintenance|operational|no_fault_found|external`',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the identified root cause of the reliability event, including contributing factors and failure mode analysis.',
    CONSTRAINT pk_reliability_event PRIMARY KEY(`reliability_event_id`)
) COMMENT 'Reliability programme event record capturing technical dispatch reliability data per IATA AHM (Airline Handbook of Maintenance) standards. Records technical delays (>15 min), cancellations, in-flight shutdowns (IFSD), air turnbacks (ATB), diversions, and unscheduled component removals. Captures event type, ATA chapter, aircraft type/MSN, tail number, station, flight number, event date, delay minutes, root cause category (design/maintenance/operational/no-fault-found), corrective action, and repeat/chronic flag. Feeds monthly reliability reports, alert level monitoring, and MSG-3 task effectiveness reviews.';

CREATE OR REPLACE TABLE `airlines_ecm`.`maintenance`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'Unique identifier for this maintenance vendor contract record. Primary key.',
    `approved_maintenance_org_id` BIGINT COMMENT 'Foreign key linking to the approved Part-145 maintenance organisation that is party to this vendor contract.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor that supplies parts, tooling, consumables, or services under this contract.',
    `capability_scope` STRING COMMENT 'Textual description of the specific maintenance capabilities, part categories, or service types covered under this contract (e.g., engine components, avionics repair, AOG support). Explicitly identified in detection phase relationship data.',
    `contract_end_date` DATE COMMENT 'Expiry or termination date of the commercial contract. Null indicates open-ended or evergreen contract. Explicitly identified in detection phase relationship data.',
    `contract_start_date` DATE COMMENT 'Effective start date of the commercial contract between the maintenance organisation and vendor. Explicitly identified in detection phase relationship data.',
    `contract_status` STRING COMMENT 'Current lifecycle status of this maintenance vendor contract: active, inactive, suspended, expired, or pending renewal.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review or scorecard assessment conducted for this vendor relationship.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next formal performance review or contract renewal discussion for this vendor relationship.',
    `performance_score` DECIMAL(18,2) COMMENT 'Quantitative performance rating or scorecard result for this vendor relationship, typically based on on-time delivery, quality defect rate, and responsiveness. Explicitly identified in detection phase relationship data.',
    `rate_card` STRING COMMENT 'Reference identifier or document number for the pricing schedule, labor rates, or unit costs applicable to this maintenance org-vendor contract. Explicitly identified in detection phase relationship data.',
    `service_level_agreement` STRING COMMENT 'Textual description or reference to the SLA terms governing response time, turnaround time, quality standards, and availability commitments for this vendor relationship. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_vendor_contract PRIMARY KEY(`vendor_contract_id`)
) COMMENT 'This association product represents the commercial contract between an approved Part-145 maintenance organisation and a vendor for procurement of parts, tooling, consumables, or services. It captures contract terms, service level agreements, rate cards, capability scope, and performance metrics that exist only in the context of this specific org-vendor relationship. Each record links one approved maintenance organisation to one vendor with contractual and performance attributes.. Existence Justification: In airline maintenance operations, approved Part-145 maintenance organisations frequently engage multiple vendors for different procurement categories (parts suppliers, tooling vendors, consumables providers), and each vendor may serve multiple maintenance organisations across the airlines network or third-party MRO facilities. The business actively manages these relationships as commercial contracts with specific terms, SLAs, rate cards, capability scopes, and performance metrics that vary by org-vendor pairing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_defect_report_id` FOREIGN KEY (`defect_report_id`) REFERENCES `airlines_ecm`.`maintenance`.`defect_report`(`defect_report_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_mel_deferral_id` FOREIGN KEY (`mel_deferral_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_deferral`(`mel_deferral_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_program_id` FOREIGN KEY (`program_id`) REFERENCES `airlines_ecm`.`maintenance`.`program`(`program_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ADD CONSTRAINT `fk_maintenance_check_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_airworthiness_directive_id` FOREIGN KEY (`airworthiness_directive_id`) REFERENCES `airlines_ecm`.`maintenance`.`airworthiness_directive`(`airworthiness_directive_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ADD CONSTRAINT `fk_maintenance_ad_compliance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ADD CONSTRAINT `fk_maintenance_service_bulletin_airworthiness_directive_id` FOREIGN KEY (`airworthiness_directive_id`) REFERENCES `airlines_ecm`.`maintenance`.`airworthiness_directive`(`airworthiness_directive_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ADD CONSTRAINT `fk_maintenance_defect_report_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_defect_report_id` FOREIGN KEY (`defect_report_id`) REFERENCES `airlines_ecm`.`maintenance`.`defect_report`(`defect_report_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_mel_item_id` FOREIGN KEY (`mel_item_id`) REFERENCES `airlines_ecm`.`maintenance`.`mel_item`(`mel_item_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ADD CONSTRAINT `fk_maintenance_mel_deferral_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ADD CONSTRAINT `fk_maintenance_llp_status_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ADD CONSTRAINT `fk_maintenance_llp_status_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ADD CONSTRAINT `fk_maintenance_component_removal_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ADD CONSTRAINT `fk_maintenance_aog_event_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ADD CONSTRAINT `fk_maintenance_aog_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ADD CONSTRAINT `fk_maintenance_technical_log_release_id` FOREIGN KEY (`release_id`) REFERENCES `airlines_ecm`.`maintenance`.`release`(`release_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ADD CONSTRAINT `fk_maintenance_release_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ADD CONSTRAINT `fk_maintenance_forecast_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ADD CONSTRAINT `fk_maintenance_forecast_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ADD CONSTRAINT `fk_maintenance_forecast_program_id` FOREIGN KEY (`program_id`) REFERENCES `airlines_ecm`.`maintenance`.`program`(`program_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ADD CONSTRAINT `fk_maintenance_visit_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ADD CONSTRAINT `fk_maintenance_visit_certifying_staff_id` FOREIGN KEY (`certifying_staff_id`) REFERENCES `airlines_ecm`.`maintenance`.`certifying_staff`(`certifying_staff_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ADD CONSTRAINT `fk_maintenance_visit_program_id` FOREIGN KEY (`program_id`) REFERENCES `airlines_ecm`.`maintenance`.`program`(`program_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ADD CONSTRAINT `fk_maintenance_visit_release_id` FOREIGN KEY (`release_id`) REFERENCES `airlines_ecm`.`maintenance`.`release`(`release_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ADD CONSTRAINT `fk_maintenance_engineering_order_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ADD CONSTRAINT `fk_maintenance_engineering_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ADD CONSTRAINT `fk_maintenance_material_request_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ADD CONSTRAINT `fk_maintenance_apu_status_defect_report_id` FOREIGN KEY (`defect_report_id`) REFERENCES `airlines_ecm`.`maintenance`.`defect_report`(`defect_report_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ADD CONSTRAINT `fk_maintenance_apu_status_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_component_id` FOREIGN KEY (`component_id`) REFERENCES `airlines_ecm`.`maintenance`.`component`(`component_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `airlines_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ADD CONSTRAINT `fk_maintenance_vendor_contract_approved_maintenance_org_id` FOREIGN KEY (`approved_maintenance_org_id`) REFERENCES `airlines_ecm`.`maintenance`.`approved_maintenance_org`(`approved_maintenance_org_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`maintenance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `airlines_ecm`.`maintenance` SET TAGS ('dbx_domain' = 'maintenance');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Addressing Audit Finding Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Organization ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Engineer ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Alert Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Recommendation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Mitigating Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `wildlife_strike_id` SET TAGS ('dbx_business_glossary_term' = 'Wildlife Strike Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_man_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Man-Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `ad_reference` SET TAGS ('dbx_business_glossary_term' = 'AD (Airworthiness Directive) Reference');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `mel_reference` SET TAGS ('dbx_business_glossary_term' = 'MEL (Minimum Equipment List) Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Work Order Notes');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `originating_source` SET TAGS ('dbx_business_glossary_term' = 'Originating Source');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `part_145_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Part-145 Approval Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|routine');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order` ALTER COLUMN `sb_reference` SET TAGS ('dbx_business_glossary_term' = 'SB (Service Bulletin) Reference');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Technician Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `defect_report_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `mel_deferral_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Deferral Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `primary_work_technician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Employee ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `primary_work_technician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `primary_work_technician_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `airworthiness_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Reference');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `service_bulletin_reference` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Reference');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`program` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `ad_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Compliance Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `ad_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|pending|overdue|not_applicable');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `part_145_organization` SET TAGS ('dbx_business_glossary_term' = 'Part-145 Approved Organization');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Program Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'amp|cmp|emp|sampling|msg3|other');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `reliability_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Reliability Program Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Program Revision Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `revision` SET TAGS ('dbx_value_regex' = '^[A-Z0-9./-]{1,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `sb_incorporation_status` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Incorporation Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `sb_incorporation_status` SET TAGS ('dbx_value_regex' = 'current|pending|partial|not_applicable');
ALTER TABLE `airlines_ecm`.`maintenance`.`program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `check_id` SET TAGS ('dbx_business_glossary_term' = 'Check Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Program ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `actual_induction_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Induction Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `actual_man_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Man-Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,7}$');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Check Cost Amount');
ALTER TABLE `airlines_ecm`.`maintenance`.`check` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `related_ad_numbers` SET TAGS ('dbx_business_glossary_term' = 'Related Airworthiness Directive (AD) Numbers');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `serial_number_range` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Subject');
ALTER TABLE `airlines_ecm`.`maintenance`.`airworthiness_directive` ALTER COLUMN `superseded_ad_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded Airworthiness Directive (AD) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `ad_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Compliance ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Related Alert Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Mechanic ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Airworthiness Directive Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`ad_compliance` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `service_bulletin_id` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `airworthiness_directive_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Maintenance Airworthiness Directive Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `related_bulletin_numbers` SET TAGS ('dbx_business_glossary_term' = 'Related Service Bulletin (SB) Numbers');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Revision Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Revision Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$|^[A-Z]$|^Original$');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `superseded_bulletin_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded Service Bulletin (SB) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`service_bulletin` ALTER COLUMN `technical_description` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Technical Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `defect_report_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Report ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `airspace_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Airspace Deviation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By Inspector ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `fdr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fdr Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Identified Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `runway_incursion_id` SET TAGS ('dbx_business_glossary_term' = 'Runway Incursion Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `airworthiness_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `airworthiness_directive_reference` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{2,4}$');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `maintenance_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Organization Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `maintenance_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{4,15}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `mel_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Applicable Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `mel_category` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Deferral Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `mel_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `mel_item_reference` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Item Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `mel_item_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `part_number_replaced` SET TAGS ('dbx_business_glossary_term' = 'Part Number Replaced');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `part_number_replaced` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `rectification_action_description` SET TAGS ('dbx_business_glossary_term' = 'Rectification Action Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `rectification_station_code` SET TAGS ('dbx_business_glossary_term' = 'Rectification Station Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `rectification_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `rectification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rectification Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_business_glossary_term' = 'Reported By Role');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_value_regex' = 'flight-crew|cabin-crew|maintenance-technician|quality-inspector|engineer');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `safety_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Reportable Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `serial_number_installed` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Installed');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `serial_number_installed` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `serial_number_removed` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Removed');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `serial_number_removed` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity Level');
ALTER TABLE `airlines_ecm`.`maintenance`.`defect_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|cosmetic');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `mel_item_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Item Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_item` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `mel_deferral_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Deferral ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Accepting Commander Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `defect_report_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Report ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Deferral Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `mel_item_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Mel Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Related Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration (Tail Number)');
ALTER TABLE `airlines_ecm`.`maintenance`.`mel_deferral` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`component` SET TAGS ('dbx_subdomain' = 'asset_tracking');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `ad_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Compliance Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `current_location_code` SET TAGS ('dbx_business_glossary_term' = 'Current Location Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `current_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `current_location_type` SET TAGS ('dbx_business_glossary_term' = 'Current Location Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `current_location_type` SET TAGS ('dbx_value_regex' = 'aircraft|shop|store|quarantine|scrap');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `cycles_remaining_to_limit` SET TAGS ('dbx_business_glossary_term' = 'Cycles Remaining to Limit');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `cycles_since_overhaul` SET TAGS ('dbx_business_glossary_term' = 'Cycles Since Overhaul (CSO)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `last_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last Overhaul Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `life_limited_part_flag` SET TAGS ('dbx_business_glossary_term' = 'Life-Limited Part (LLP) Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `maintenance_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Organization Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`component` ALTER COLUMN `maintenance_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{4,15}$');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` SET TAGS ('dbx_subdomain' = 'asset_tracking');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `llp_status_id` SET TAGS ('dbx_business_glossary_term' = 'Life-Limited Part (LLP) Status ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Last Update Flight ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Removal Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `accumulated_life` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Life');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `airworthiness_directive_compliance` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Compliance');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `airworthiness_directive_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `alert_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `alert_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Percentage');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `certified_life_limit` SET TAGS ('dbx_business_glossary_term' = 'Certified Life Limit');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `installation_cycles_at_install` SET TAGS ('dbx_business_glossary_term' = 'Installation Cycles at Install');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `installation_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Installation Flight Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `last_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last Overhaul Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `life_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Life Limit Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `life_limit_type` SET TAGS ('dbx_value_regex' = 'cycles|flight_hours|calendar_days|combined');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `llp_category` SET TAGS ('dbx_business_glossary_term' = 'Life-Limited Part (LLP) Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `llp_category` SET TAGS ('dbx_value_regex' = 'engine_disc|engine_shaft|engine_hub|landing_gear|rotor|other');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `llp_status_status` SET TAGS ('dbx_business_glossary_term' = 'Life-Limited Part (LLP) Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `llp_status_status` SET TAGS ('dbx_value_regex' = 'serviceable|alert|critical|expired|removed');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `maintenance_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Organization Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `maintenance_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{3,15}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `next_inspection_due_life` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Life');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `overhaul_count` SET TAGS ('dbx_business_glossary_term' = 'Overhaul Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,25}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `remaining_life` SET TAGS ('dbx_business_glossary_term' = 'Remaining Life');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `remaining_life_percentage` SET TAGS ('dbx_business_glossary_term' = 'Remaining Life Percentage');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `removal_reason` SET TAGS ('dbx_value_regex' = 'life_limit_reached|scheduled_maintenance|unscheduled_removal|aog_event|component_replacement|other');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `service_bulletin_compliance` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Compliance');
ALTER TABLE `airlines_ecm`.`maintenance`.`llp_status` ALTER COLUMN `service_bulletin_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` SET TAGS ('dbx_subdomain' = 'asset_tracking');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `component_removal_id` SET TAGS ('dbx_business_glossary_term' = 'Component Removal ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Inspector ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Technician ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Removed Component Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `wildlife_strike_id` SET TAGS ('dbx_business_glossary_term' = 'Wildlife Strike Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `ad_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Reference Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `ad_reference_number` SET TAGS ('dbx_value_regex' = '^AD[0-9]{4}-[0-9]{2}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `aircraft_total_cycles_at_removal` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Cycles at Removal');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `aircraft_total_hours_at_removal` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Hours at Removal');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `aog_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Event Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `ata_position_code` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Position Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `ata_position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `component_cycles_at_removal` SET TAGS ('dbx_business_glossary_term' = 'Component Cycles at Removal');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `component_cycles_since_new` SET TAGS ('dbx_business_glossary_term' = 'Component Cycles Since New (CSN)');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `component_hours_at_removal` SET TAGS ('dbx_business_glossary_term' = 'Component Hours at Removal');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `component_time_since_new_hours` SET TAGS ('dbx_business_glossary_term' = 'Component Time Since New (TSN) Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `crs_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Release to Service (CRS) Reference Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `crs_reference_number` SET TAGS ('dbx_value_regex' = '^CRS[0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `installation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Installation Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `installed_component_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Installed Component Condition Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `installed_component_condition_code` SET TAGS ('dbx_value_regex' = 'new|overhauled|serviceable|repaired');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `installed_component_part_number` SET TAGS ('dbx_business_glossary_term' = 'Installed Component Part Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `installed_component_part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `installed_component_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Installed Component Serial Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `installed_component_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `mel_deferral_reference` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Deferral Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `mel_deferral_reference` SET TAGS ('dbx_value_regex' = '^MEL[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `removal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `removal_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `removal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Removal Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `removed_component_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Removed Component Condition Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `removed_component_condition_code` SET TAGS ('dbx_value_regex' = 'serviceable|unserviceable|beyond_repair|repairable|scrap');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `sb_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Reference Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `sb_reference_number` SET TAGS ('dbx_value_regex' = '^SB[A-Z0-9-]{6,15}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|certified|cancelled');
ALTER TABLE `airlines_ecm`.`maintenance`.`component_removal` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `aog_event_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Event ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Declaring Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `flight_revenue_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Impacted Flight Revenue Performance Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Related Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Coordinator ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Resolution Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `actual_rts_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Return to Service (RTS) Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `airworthiness_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `aog_declaration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Declaration Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `aog_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Duration in Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `aog_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Notification Sent Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `aog_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Severity Level');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `aog_severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `aog_status` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}(-[0-9]{2})?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `component_part_number` SET TAGS ('dbx_business_glossary_term' = 'Component Part Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `component_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Component Serial Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact in United States Dollars (USD)');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `estimated_rts_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Return to Service (RTS) Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `flights_cancelled_count` SET TAGS ('dbx_business_glossary_term' = 'Flights Cancelled Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `flights_delayed_count` SET TAGS ('dbx_business_glossary_term' = 'Flights Delayed Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `grounding_reason` SET TAGS ('dbx_business_glossary_term' = 'Grounding Reason Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `mel_reference` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'component_failure|human_error|design_defect|wear_and_tear|foreign_object_damage|environmental');
ALTER TABLE `airlines_ecm`.`maintenance`.`aog_event` ALTER COLUMN `vendor_support_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Support Required Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `technical_log_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Log ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Commander Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Departure Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `fdr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fdr Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `release_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Release Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Related Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `fuel_remaining_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Remaining (Kilograms)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `fuel_uplift_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift (Kilograms)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `landing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Landing Timestamp (On)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `maintenance_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Organization Code (Part-145 Approval)');
ALTER TABLE `airlines_ecm`.`maintenance`.`technical_log` ALTER COLUMN `maintenance_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{3,15}$');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`release` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `release_id` SET TAGS ('dbx_business_glossary_term' = 'Release Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}-[A-Z0-9]{3,5}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_total_cycles_at_release` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Cycles at Release');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_total_hours_at_release` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Hours at Release');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,7}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `airworthiness_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Reference');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `mel_reference` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Reference');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`release` ALTER COLUMN `service_bulletin_reference` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Organisation (AMO) ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `emergency_drill_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
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
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) / International Civil Aviation Organization (ICAO) Station Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`approved_maintenance_org` ALTER COLUMN `station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `authorisation_scope` SET TAGS ('dbx_business_glossary_term' = 'Authorisation Scope');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `authorization_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `employment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Employment End Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `employment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Start Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `last_recency_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recency Activity Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `licence_category` SET TAGS ('dbx_business_glossary_term' = 'Licence Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `licence_category` SET TAGS ('dbx_value_regex' = 'A|B1|B2|B3|C|A&P');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `licence_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Licence Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `licence_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Licence Issue Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `licence_number` SET TAGS ('dbx_business_glossary_term' = 'Licence Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `licence_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{6,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `licence_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `licence_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `licence_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Licence Subcategory');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `next_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `part_145_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Part-145 Organisation Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `part_145_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{4,15}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `recency_experience_status` SET TAGS ('dbx_business_glossary_term' = 'Recency Experience Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `recency_experience_status` SET TAGS ('dbx_value_regex' = 'current|lapsed|suspended');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `staff_number` SET TAGS ('dbx_business_glossary_term' = 'Staff Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `staff_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`certifying_staff` ALTER COLUMN `type_ratings` SET TAGS ('dbx_business_glossary_term' = 'Type Ratings');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Program Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `airworthiness_directive_number` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `airworthiness_directive_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{2,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `average_daily_utilization_cycles` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Utilization Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `average_daily_utilization_hours` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Utilization Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Calculation Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `current_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Current Flight Cycles (FC)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `current_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Current Flight Hours (FH)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `estimated_downtime_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Days');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'active|superseded|cancelled|completed');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'A-check|C-check|D-check|LLP retirement|AD repetitive|APU overhaul');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `hangar_slot_reservation_required` SET TAGS ('dbx_business_glossary_term' = 'Hangar Slot Reservation Required Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `maintenance_station_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Station Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `maintenance_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `maintenance_task_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `maintenance_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Days');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `projected_due_date` SET TAGS ('dbx_business_glossary_term' = 'Projected Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `projected_due_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Projected Due Flight Cycles (FC)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `projected_due_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Projected Due Flight Hours (FH)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `remaining_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Remaining Flight Cycles (FC)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `remaining_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Remaining Flight Hours (FH)');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Forecast Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`forecast` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Maintenance Org Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `certifying_staff_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Staff Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Program Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `release_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Release Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `actual_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `ad_compliance_count` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Compliance Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,7}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `aircraft_total_cycles_at_induction` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Cycles at Induction');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `aircraft_total_flight_hours_at_induction` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Flight Hours at Induction');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Check Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `check_type` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{0,2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `crs_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Release to Service (CRS) Issue Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Visit Delay Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `delay_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `estimated_release_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Release Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `induction_date` SET TAGS ('dbx_business_glossary_term' = 'Induction Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `induction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Induction Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `llp_replacement_count` SET TAGS ('dbx_business_glossary_term' = 'Life-Limited Parts (LLP) Replacement Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `mel_deferral_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Deferral Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `planned_release_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Release Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Reference Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `sb_incorporation_count` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Incorporation Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `total_labour_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Labour Cost (USD)');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `total_labour_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `total_man_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Total Man-Hours Actual');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `total_man_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Man-Hours Planned');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `total_material_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Material Cost (USD)');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `total_material_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `total_visit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Visit Cost (USD)');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `total_visit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_value_regex' = 'line|base|heavy|engine_shop|component_shop|aog_recovery');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `work_order_count` SET TAGS ('dbx_business_glossary_term' = 'Work Order Count');
ALTER TABLE `airlines_ecm`.`maintenance`.`visit` ALTER COLUMN `work_scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Work Scope Summary');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `engineering_order_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Order (EO) Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Corrective Action Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Recommendation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Engineer Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Case Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}(-[0-9]{2})?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `camo_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Continuing Airworthiness Management Organization (CAMO) Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `camo_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{3,15}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `compliance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `compliance_due_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Compliance Due Flight Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `compliance_due_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Compliance Due Flight Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `compliance_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Method');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `compliance_method` SET TAGS ('dbx_value_regex' = 'mandatory|optional|on_condition|at_next_opportunity');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `design_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Design Approval Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `effectivity` SET TAGS ('dbx_business_glossary_term' = 'Effectivity');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `eo_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Order (EO) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `eo_number` SET TAGS ('dbx_value_regex' = '^EO-[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `eo_revision` SET TAGS ('dbx_business_glossary_term' = 'Engineering Order (EO) Revision');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `eo_revision` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `eo_status` SET TAGS ('dbx_business_glossary_term' = 'Engineering Order (EO) Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `eo_status` SET TAGS ('dbx_value_regex' = 'draft|approved|in_progress|completed|cancelled|superseded');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `eo_type` SET TAGS ('dbx_business_glossary_term' = 'Engineering Order (EO) Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `eo_type` SET TAGS ('dbx_value_regex' = 'structural_repair|modification|stc|deviation|design_change|service_bulletin');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `modification_description` SET TAGS ('dbx_business_glossary_term' = 'Modification Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `part_145_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Part-145 Approved Maintenance Organization Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `part_145_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{3,15}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `related_ad_number` SET TAGS ('dbx_business_glossary_term' = 'Related Airworthiness Directive (AD) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `related_sb_number` SET TAGS ('dbx_business_glossary_term' = 'Related Service Bulletin (SB) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `stc_number` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Type Certificate (STC) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `stc_number` SET TAGS ('dbx_value_regex' = '^STC-[A-Z0-9]{5,15}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`engineering_order` ALTER COLUMN `superseded_by_eo_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Engineering Order (EO) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `material_request_id` SET TAGS ('dbx_business_glossary_term' = 'Material Request Identifier');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `primary_material_requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `primary_material_requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `primary_material_requestor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `tertiary_material_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `tertiary_material_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `tertiary_material_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Material Batch Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Material Issue Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Material Request Priority Level');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|aog');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `quantity_issued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Material Request Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Material Request Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Material Request Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'routine|aog|critical|stock_replenishment|project');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Material Requested Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Material Required By Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Material Return Quantity');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `return_to_store_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Store Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Component Serial Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `store_location_code` SET TAGS ('dbx_business_glossary_term' = 'Store Location Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `store_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `substitute_part_number` SET TAGS ('dbx_business_glossary_term' = 'Substitute Part Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `substitute_part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Substitution Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Total Cost');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Unit Cost');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`material_request` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` SET TAGS ('dbx_subdomain' = 'asset_tracking');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `apu_status_id` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Status ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `defect_report_id` SET TAGS ('dbx_business_glossary_term' = 'Last APU Defect Report ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Last APU Work Order ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `airworthiness_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'APU Airworthiness Certificate Expiry Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `airworthiness_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'APU Airworthiness Certificate Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `apu_model` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Model');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `apu_part_number` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Part Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `apu_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Power Unit (APU) Serial Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `borescope_inspection_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'APU Borescope Inspection Interval Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `cycles_since_new` SET TAGS ('dbx_business_glossary_term' = 'APU Cycles Since New');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `cycles_since_overhaul` SET TAGS ('dbx_business_glossary_term' = 'APU Cycles Since Overhaul (CSO)');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `hours_since_new` SET TAGS ('dbx_business_glossary_term' = 'APU Hours Since New');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `hours_since_overhaul` SET TAGS ('dbx_business_glossary_term' = 'APU Hours Since Overhaul (TSO)');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'APU Installation Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `installation_flight_cycles` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Flight Cycles at APU Installation');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `installation_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Flight Hours at APU Installation');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `last_borescope_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last APU Borescope Inspection Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `last_borescope_inspection_hours` SET TAGS ('dbx_business_glossary_term' = 'APU Hours at Last Borescope Inspection');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `last_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last APU Overhaul Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `last_overhaul_organization` SET TAGS ('dbx_business_glossary_term' = 'Last APU Overhaul Organization');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'APU Lease Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `lease_status` SET TAGS ('dbx_value_regex' = 'owned|leased|on_loan|pooled');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `maintenance_program_reference` SET TAGS ('dbx_business_glossary_term' = 'APU Maintenance Program Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'APU Manufacturer Name');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `mel_category` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `mel_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `mel_deferral_reference` SET TAGS ('dbx_business_glossary_term' = 'Minimum Equipment List (MEL) Deferral Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `next_borescope_inspection_due_hours` SET TAGS ('dbx_business_glossary_term' = 'Next APU Borescope Inspection Due Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `next_overhaul_due_cycles` SET TAGS ('dbx_business_glossary_term' = 'Next APU Overhaul Due Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `next_overhaul_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next APU Overhaul Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `next_overhaul_due_hours` SET TAGS ('dbx_business_glossary_term' = 'Next APU Overhaul Due Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'APU Operational Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|non_operational|limited_operation|test_mode');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `overhaul_interval_cycles` SET TAGS ('dbx_business_glossary_term' = 'APU Overhaul Interval Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `overhaul_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'APU Overhaul Interval Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `overhaul_interval_months` SET TAGS ('dbx_business_glossary_term' = 'APU Overhaul Interval Months');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'APU Owner Organization');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `remaining_cycles_to_overhaul` SET TAGS ('dbx_business_glossary_term' = 'Remaining Cycles to APU Overhaul');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `remaining_hours_to_overhaul` SET TAGS ('dbx_business_glossary_term' = 'Remaining Hours to APU Overhaul');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'APU Status Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'APU Removal Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'APU Removal Reason');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `serviceability_status` SET TAGS ('dbx_business_glossary_term' = 'APU Serviceability Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `serviceability_status` SET TAGS ('dbx_value_regex' = 'serviceable|unserviceable|deferred|aog|under_maintenance|awaiting_parts');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'APU Storage Location');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `total_apu_cycles` SET TAGS ('dbx_business_glossary_term' = 'Total Auxiliary Power Unit (APU) Operating Cycles');
ALTER TABLE `airlines_ecm`.`maintenance`.`apu_status` ALTER COLUMN `total_apu_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Auxiliary Power Unit (APU) Operating Hours');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `reliability_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Identified Hazard Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration (Tail Number)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,6}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `aircraft_total_cycles_at_event` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Flight Cycles at Event');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `aircraft_total_hours_at_event` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Total Flight Hours at Event');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,4}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `alert_level` SET TAGS ('dbx_business_glossary_term' = 'Reliability Alert Level');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `alert_level` SET TAGS ('dbx_value_regex' = 'green|amber|red');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `ata_section` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Section');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `ata_section` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `chronic_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Event Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Event Closure Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `delay_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|resolved|closed');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Type');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'technical_delay|cancellation|ifsd|atb|diversion|unscheduled_removal');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `maintenance_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Organization Code');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `manufacturer_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number (MSN)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `msg3_task_reference` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Steering Group 3 (MSG-3) Task Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `pirep_reference` SET TAGS ('dbx_business_glossary_term' = 'Pilot Report (PIREP) Reference');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Remarks');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `repeat_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Event Flag');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period (Year-Month)');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'design|maintenance|operational|no_fault_found|external');
ALTER TABLE `airlines_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` SET TAGS ('dbx_subdomain' = 'defect_management');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` SET TAGS ('dbx_association_edges' = 'maintenance.approved_maintenance_org,procurement.vendor');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Vendor Contract ID');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `approved_maintenance_org_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Vendor Contract - Approved Maintenance Org Id');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Vendor Contract - Vendor Id');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `capability_scope` SET TAGS ('dbx_business_glossary_term' = 'Capability Scope');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `rate_card` SET TAGS ('dbx_business_glossary_term' = 'Rate Card');
ALTER TABLE `airlines_ecm`.`maintenance`.`vendor_contract` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
