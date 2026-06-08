-- Schema for Domain: safety | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`safety` COMMENT 'Manages operational health, safety, and environmental (HSE) compliance including workplace safety incidents, OSHA reporting, dangerous goods handling certifications, facility safety audits, driver safety programs, and emergency response planning across all Transport Shipping operations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`hse_incident` (
    `hse_incident_id` BIGINT COMMENT 'Unique identifier for the HSE incident record. Primary key for the incident entity.',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: Air cargo incidents (loading accidents, hazmat events, cargo damage) require AWB linkage for IATA incident reporting, airline accountability, insurance claims, and regulatory compliance. Essential for',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Ocean freight incidents require BOL linkage for maritime incident reporting, cargo claims, P&I club notifications, and IMO regulatory compliance. Critical for vessel-based incident investigation and c',
    `booking_id` BIGINT COMMENT 'Foreign key linking to freight.booking. Business justification: Incidents during booking phase or cargo preparation require booking linkage for investigation and to track incidents by booking channel, carrier, or service type. Supports pre-transport incident analy',
    `cfs_operation_id` BIGINT COMMENT 'Foreign key linking to freight.cfs_operation. Business justification: CFS warehouse operations have significant incident risk (equipment accidents, cargo handling injuries, storage incidents). Linking enables facility-specific safety analysis, operation type risk profil',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: HSE incidents during transport operations (loading accidents, handling injuries, vehicle collisions) require shipment context for root cause analysis, regulatory reporting (OSHA 300), and corrective a',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: CFS consolidation/deconsolidation operations are high-risk for incidents (forklift accidents, cargo damage, hazmat exposure). Linking incidents to consolidation enables facility safety analysis, NVOCC',
    `corridor_leg_id` BIGINT COMMENT 'Foreign key linking to route.corridor_leg. Business justification: HSE incidents (vehicle accidents, cargo damage, driver injuries) occur on specific corridor legs. Existing route_plan_id doesnt specify which leg. Leg-level attribution is critical for incident inves',
    `employee_id` BIGINT COMMENT 'Reference to the Transport Shipping employee involved in or injured by the incident. Null if injured party is not an employee.',
    `facility_id` BIGINT COMMENT 'Reference to the Transport Shipping facility, warehouse, or depot where the incident occurred. Null if incident occurred on route or at external location.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: HSE incidents during freight operations (loading accidents, transport damage, hazmat spills) require linkage to freight order for investigation, root cause analysis, customer notification, insurance c',
    `intermodal_transfer_id` BIGINT COMMENT 'Foreign key linking to freight.intermodal_transfer. Business justification: Intermodal transfer operations are high-risk points for incidents (crane accidents, cargo drops, seal breaches, container damage). Linking enables transfer facility safety analysis, equipment incident',
    `plan_id` BIGINT COMMENT 'Reference to the delivery or transport route where the incident occurred. Null if incident did not occur on an active route.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Incidents at agent-operated facilities or during agent-handled segments require linking to the responsible agent for accountability, investigation, insurance claims, and performance tracking. Essentia',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Incidents during carrier-operated transport legs require tracking the responsible carrier for liability determination, investigation coordination, regulatory reporting, and corrective action enforceme',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Incidents occur during specific transport legs (origin loading, line-haul, destination unloading). Leg-level attribution enables carrier performance analysis, route safety profiling, and targeted corr',
    `transport_asset_id` BIGINT COMMENT 'Reference to the fleet vehicle involved in the incident (for vehicle accidents or incidents occurring in/around vehicles). Null if no vehicle was involved.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: HSE incidents generate formal incident reports that are transport documents for regulatory submission (OSHA, DOT). Required for compliance reporting and insurance claims. Domain experts expect inciden',
    `related_hse_incident_id` BIGINT COMMENT 'Self-referencing FK on hse_incident (related_hse_incident_id)',
    `body_part_affected` STRING COMMENT 'The body part(s) injured or affected by the incident (e.g., hand, back, head, respiratory system). Null for non-injury incidents.',
    `closed_date` DATE COMMENT 'The date when the incident was officially closed after investigation completion and corrective action implementation. Null if incident is still open.',
    `corrective_actions_completed_flag` BOOLEAN COMMENT 'Indicates whether all identified corrective actions have been implemented and verified. False if actions are still pending.',
    `corrective_actions_required` STRING COMMENT 'Summary of corrective and preventive actions identified as necessary to prevent recurrence of similar incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this incident record was first created in the HSE system.',
    `dangerous_goods_involved_flag` BOOLEAN COMMENT 'Indicates whether dangerous goods (hazardous materials, hazmat) were involved in or contributed to the incident.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the injured party was unable to work due to the incident. Zero for incidents not resulting in lost time. Used for Lost Time Injury (LTI) rate calculations.',
    `days_restricted_duty` STRING COMMENT 'Number of calendar days the injured party worked on restricted or light duty due to the incident. Zero if no work restrictions were imposed.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in environmental damage or pollution (spill, release, contamination).',
    `estimated_damage_cost` DECIMAL(18,2) COMMENT 'Estimated monetary cost of property damage resulting from the incident, in the reporting currency (USD). Null if no property damage occurred.',
    `hazmat_un_number` STRING COMMENT 'The UN number identifying the dangerous goods involved in the incident (e.g., UN1203 for gasoline). Null if no dangerous goods were involved.. Valid values are `^UN[0-9]{4}$`',
    `immediate_cause` STRING COMMENT 'The direct, proximate cause that triggered the incident (e.g., slippery surface, equipment malfunction, human error).',
    `incident_datetime` TIMESTAMP COMMENT 'The precise date and time when the HSE incident occurred. This is the actual event timestamp, not the reporting timestamp.',
    `incident_description` STRING COMMENT 'Comprehensive narrative description of what happened during the incident, including sequence of events, conditions, and immediate circumstances.',
    `incident_number` STRING COMMENT 'Externally-visible unique incident reference number used for tracking and reporting. Format: INC-YYYYMMDD sequence.. Valid values are `^INC-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current status of the incident in its investigation and resolution lifecycle: open (newly reported), under investigation (active root cause analysis), pending review (awaiting management approval), closed (investigation complete and actions implemented), reopened (closed incident requiring additional investigation).. Valid values are `open|under_investigation|pending_review|closed|reopened`',
    `incident_type` STRING COMMENT 'Primary classification of the HSE incident: injury (personal harm), near-miss (potential incident without harm), property damage (facility/equipment damage), environmental spill (release of hazardous materials), vehicle accident (fleet collision or incident), hazmat exposure (dangerous goods exposure).. Valid values are `injury|near_miss|property_damage|environmental_spill|vehicle_accident|hazmat_exposure`',
    `injured_party_name` STRING COMMENT 'Full name of the person(s) injured or affected by the incident. May be employee, contractor, or third party. Null for property-only or near-miss incidents.',
    `injured_party_type` STRING COMMENT 'Classification of the injured or affected party: employee (Transport Shipping employee), contractor (third-party contractor), third-party (customer, vendor, partner), public (member of public), none (no injury - property or near-miss incident).. Valid values are `employee|contractor|third_party|public|none`',
    `injury_type` STRING COMMENT 'Specific type or nature of injury sustained (e.g., laceration, fracture, sprain, burn, respiratory exposure). Null for non-injury incidents. [ENUM-REF-CANDIDATE: laceration|fracture|sprain|strain|burn|contusion|abrasion|puncture|amputation|respiratory|chemical_exposure|heat_stress|cold_stress|hearing_loss|eye_injury|back_injury|head_injury|multiple_injuries — promote to reference product]',
    `investigation_assigned_to` STRING COMMENT 'Name or identifier of the HSE manager, safety officer, or investigation team assigned to lead the incident investigation.',
    `investigation_completed_date` DATE COMMENT 'The date when the incident investigation was completed and findings were documented. Null if investigation is still in progress.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this incident record was last updated or modified.',
    `location_description` STRING COMMENT 'Detailed free-text description of the specific location where the incident occurred, including building, floor, area, or GPS coordinates if applicable.',
    `location_type` STRING COMMENT 'Type of location where the incident occurred: facility (Transport Shipping facility), warehouse (storage facility), depot (distribution center), route (in-transit on delivery route), vehicle (inside transport vehicle), customer site (at customer premises), public area (public road or space). [ENUM-REF-CANDIDATE: facility|warehouse|depot|route|vehicle|customer_site|public_area — 7 candidates stripped; promote to reference product]',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether this incident meets OSHA criteria for recordability under 29 CFR 1904. True if the incident must be recorded on OSHA Form 300.',
    `property_damage_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in damage to property, equipment, vehicles, or facilities.',
    `regulatory_report_submitted_date` DATE COMMENT 'The date when the incident was officially reported to the relevant regulatory authority. Null if not yet submitted or not required.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this incident must be reported to regulatory authorities (OSHA, RIDDOR, local HSE agencies, DOT, etc.) based on severity and jurisdiction.',
    `reported_by_name` STRING COMMENT 'Name of the person who initially reported the incident to HSE management or the safety system.',
    `reported_datetime` TIMESTAMP COMMENT 'The date and time when the incident was officially reported to HSE management or the safety system.',
    `root_cause_analysis` STRING COMMENT 'Detailed findings from the root cause analysis investigation, including contributing factors, systemic issues, and causal chain.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying root cause identified through investigation: human factors (behavior, fatigue, distraction), equipment failure (mechanical/technical fault), process deficiency (inadequate procedure), environmental conditions (weather, lighting, noise), training gap (insufficient knowledge/skills), supervision inadequate (lack of oversight).. Valid values are `human_factors|equipment_failure|process_deficiency|environmental_conditions|training_gap|supervision_inadequate`',
    `severity_classification` STRING COMMENT 'Severity level of the incident based on outcome: fatality (death), lost-time injury (LTI - absence from work), recordable (OSHA recordable injury/illness), medical treatment (professional care required), first-aid (minor treatment only), near-miss (no injury occurred).. Valid values are `fatality|lost_time_injury|recordable|medical_treatment|first_aid|near_miss`',
    `shift` STRING COMMENT 'The work shift during which the incident occurred: day (daytime shift), night (overnight shift), evening (evening shift), rotating (rotating shift schedule).. Valid values are `day|night|evening|rotating`',
    `spill_volume_liters` DECIMAL(18,2) COMMENT 'Volume of hazardous material or pollutant spilled or released, measured in liters. Null if no spill occurred.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time and location of the incident (e.g., clear, rain, snow, fog, ice). Relevant for outdoor and route incidents.',
    `witness_count` STRING COMMENT 'Number of witnesses who observed the incident and provided statements during the investigation.',
    CONSTRAINT pk_hse_incident PRIMARY KEY(`hse_incident_id`)
) COMMENT 'Core master record for all Health, Safety, and Environmental (HSE) incidents occurring across Transport Shipping operations. Captures incident type (injury, near-miss, property damage, environmental spill, vehicle accident), severity classification (fatality, lost-time injury, recordable, first-aid, near-miss), incident date/time, location (facility, route, depot), description of events, immediate causes, root cause category, injured parties, regulatory reportability flag (OSHA recordable, RIDDOR, etc.), and incident lifecycle status (open, under investigation, closed). Serves as the SSOT for all workplace and operational safety events.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` (
    `incident_investigation_id` BIGINT COMMENT 'Unique identifier for the incident investigation record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee ID of the lead investigator responsible for managing the investigation process and ensuring completion. Typically a trained HSE professional or manager.',
    `hse_incident_id` BIGINT COMMENT 'Foreign key reference to the parent HSE incident that triggered this investigation. Links to the originating incident record.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Incident investigations produce formal investigation reports that are transport documents for regulatory submission (OSHA, insurance, legal). Required for compliance, liability management, and regulat',
    `reopened_incident_investigation_id` BIGINT COMMENT 'Self-referencing FK on incident_investigation (reopened_incident_investigation_id)',
    `contributing_factors` STRING COMMENT 'Detailed list of contributing factors identified during the investigation. May include human factors, equipment failures, procedural gaps, environmental conditions, and organizational factors.',
    `corrective_action_count` STRING COMMENT 'Total number of corrective actions generated from this investigation. Used for tracking investigation effectiveness and action closure rates.',
    `corrective_actions_recommended` STRING COMMENT 'Detailed list of corrective actions recommended by the investigation team to prevent recurrence. Includes immediate actions, short-term improvements, and long-term systemic changes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigation record was first created in the system. Audit trail field for data governance.',
    `environmental_factors_identified` STRING COMMENT 'Environmental factors contributing to the incident, such as weather conditions, lighting, noise, temperature, or workspace layout.',
    `equipment_factors_identified` STRING COMMENT 'Equipment or mechanical factors contributing to the incident, such as equipment failure, design flaws, maintenance deficiencies, or inadequate safeguards.',
    `evidence_collected` BOOLEAN COMMENT 'Indicates whether physical or digital evidence was collected during the investigation. Includes photos, videos, equipment samples, documents, and logs.',
    `evidence_description` STRING COMMENT 'Description of evidence collected during the investigation. Includes types of evidence, chain of custody notes, and storage location references.',
    `external_investigator_engaged` BOOLEAN COMMENT 'Indicates whether an external third-party investigator or consultant was engaged to support the investigation. Common for high-severity incidents or specialized expertise needs.',
    `external_investigator_name` STRING COMMENT 'Name of the external investigation firm or consultant engaged. Used for vendor management and audit trails.',
    `human_factors_identified` STRING COMMENT 'Human factors contributing to the incident, such as fatigue, training gaps, communication failures, situational awareness issues, or procedural non-compliance.',
    `immediate_cause` STRING COMMENT 'The immediate or proximate cause that directly led to the incident. Distinct from root cause, which addresses underlying systemic issues.',
    `incident_scene_preserved` BOOLEAN COMMENT 'Indicates whether the incident scene was preserved for investigation purposes. Critical for forensic analysis and root cause determination.',
    `investigation_closed_date` DATE COMMENT 'Date when the investigation was formally closed after all corrective actions were reviewed and approved. Final lifecycle milestone.',
    `investigation_completed_date` DATE COMMENT 'Date when the investigation was completed and all findings documented. Marks the end of the investigation phase before closure and regulatory submission.',
    `investigation_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the investigation cost estimate. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `investigation_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost of conducting the investigation, including labor hours, external consultants, testing, and evidence analysis. Used for HSE budget management.',
    `investigation_duration_days` STRING COMMENT 'Total number of calendar days from investigation initiation to completion. Used for performance monitoring and continuous improvement of investigation processes.',
    `investigation_initiated_date` DATE COMMENT 'Date when the formal investigation was officially initiated. Regulatory compliance often requires investigation to begin within 24-48 hours of incident occurrence.',
    `investigation_initiated_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the investigation was formally initiated. Used for compliance tracking and SLA monitoring.',
    `investigation_methodology` STRING COMMENT 'Formal investigation methodology applied to determine root cause. Common methods include 5-Why, Fault Tree Analysis, ICAM (Incident Cause Analysis Method), Fishbone Diagram, and Bow-Tie Analysis. [ENUM-REF-CANDIDATE: 5_why|fault_tree_analysis|icam|root_cause_analysis|fishbone_diagram|bow_tie|tripod_beta|taproot|scat|incident_cause_analysis — 10 candidates stripped; promote to reference product]',
    `investigation_notes` STRING COMMENT 'Additional notes, observations, or context captured during the investigation process. Free-text field for investigator commentary and supplemental information.',
    `investigation_number` STRING COMMENT 'Externally-known unique business identifier for the investigation. Format: INV-YYYYMMDD-XXXXXX. Used for tracking and regulatory reporting.. Valid values are `^INV-[0-9]{8}-[A-Z0-9]{6}$`',
    `investigation_priority` STRING COMMENT 'Priority level assigned to the investigation based on incident severity, potential for recurrence, and regulatory requirements. Determines resource allocation and completion timelines.. Valid values are `critical|high|medium|low`',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation process. Tracks progression from initiation through closure and regulatory submission. [ENUM-REF-CANDIDATE: initiated|in_progress|witness_interviews|root_cause_analysis|corrective_actions|pending_review|completed|closed|regulatory_submitted — 9 candidates stripped; promote to reference product]',
    `investigation_team_members` STRING COMMENT 'Comma-separated list of investigation team member names or IDs. Includes subject matter experts, safety officers, operational managers, and union representatives as applicable.',
    `lead_investigator_name` STRING COMMENT 'Full name of the lead investigator. Captured for reporting and audit trail purposes.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the investigation that should be shared across the organization. Used for safety training, process improvement, and knowledge management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this investigation record was last modified. Audit trail field for data governance and change tracking.',
    `organizational_factors_identified` STRING COMMENT 'Organizational or systemic factors contributing to the incident, such as inadequate policies, resource constraints, safety culture issues, or management system gaps.',
    `preventive_actions_recommended` STRING COMMENT 'Preventive actions recommended to address similar risks across the organization. Broader than corrective actions, focusing on systemic risk reduction.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority to which the investigation was reported. Examples include OSHA, DOT, IMO, IATA, local labor departments, or environmental agencies.',
    `regulatory_case_number` STRING COMMENT 'Case or reference number assigned by the regulatory authority for tracking this investigation. Used for correspondence and follow-up.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether regulatory notification or reporting is required for this investigation based on incident severity and jurisdiction. Drives compliance workflows.',
    `regulatory_submission_date` DATE COMMENT 'Date when the investigation report was submitted to the relevant regulatory authority. Critical for compliance tracking and audit trails.',
    `regulatory_submission_status` STRING COMMENT 'Status of regulatory submission for this investigation. Tracks compliance with OSHA, DOT, IMO, IATA, and other governing body reporting requirements. [ENUM-REF-CANDIDATE: not_required|pending|submitted|acknowledged|under_review|accepted|rejected — 7 candidates stripped; promote to reference product]',
    `root_cause_determination` STRING COMMENT 'Final determination of the root cause(s) of the incident based on investigation findings. Represents the fundamental reason(s) the incident occurred, addressing underlying systemic issues.',
    `witness_count` STRING COMMENT 'Total number of witnesses interviewed during the investigation. Used for investigation thoroughness assessment.',
    `witness_statements_summary` STRING COMMENT 'High-level summary of witness statements collected during the investigation. Detailed statements are stored separately for confidentiality. This field captures key themes and observations.',
    CONSTRAINT pk_incident_investigation PRIMARY KEY(`incident_investigation_id`)
) COMMENT 'Transactional record managing the formal investigation process triggered by an HSE incident. Captures investigation team members, investigation methodology (5-Why, Fault Tree, ICAM), timeline of investigation activities, witness statements summary, contributing factors identified, root cause determination, corrective action recommendations, investigation completion date, and regulatory submission status. Links to the parent hse_incident and tracks the full investigation lifecycle from initiation through closure.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action record. Primary key for the corrective action entity.',
    `audit_id` BIGINT COMMENT 'Reference to the safety audit that identified the finding requiring this corrective action, if applicable.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Corrective actions from shipment-related incidents (packaging failures, temperature excursions, DG violations) require shipment reference for customer notification, claim processing, and recurrence pr',
    `facility_id` BIGINT COMMENT 'Warehouse, terminal, or facility where the corrective action is to be implemented.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Corrective actions may be raised to address specific registered hazards (in addition to incidents/audits). This FK links actions to the hazard they mitigate, supporting hazard control effectiveness tr',
    `hse_incident_id` BIGINT COMMENT 'Reference to the safety incident that triggered this corrective action, if applicable.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Safety corrective actions often drive sustainability capital investments: incident reveals need for electric vehicle fleet, LED lighting after electrical fire, solar panels after generator failure. Ca',
    `observation_id` BIGINT COMMENT 'Reference to the near-miss report that prompted this corrective action, if applicable.',
    `employee_id` BIGINT COMMENT 'Employee responsible for implementing and completing the corrective action.',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Corrective actions may be raised to improve safety programs (e.g., action to update training materials in Driver Safety Program). This FK links actions to the program they improve, supporting program ',
    `quaternary_corrective_last_modified_by_employee_id` BIGINT COMMENT 'Employee who last modified the corrective action record.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Corrective actions arising from partner-related incidents or audit findings must track the responsible partner for accountability, completion verification, and performance impact assessment. Standard ',
    `tertiary_corrective_created_by_employee_id` BIGINT COMMENT 'Employee who created the corrective action record.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Corrective actions require documented evidence of completion for audit verification, regulatory compliance, and ISO certification. Auditors and regulators require formal documentation proving correcti',
    `parent_corrective_action_id` BIGINT COMMENT 'Self-referencing FK on corrective_action (parent_corrective_action_id)',
    `action_number` STRING COMMENT 'Business-facing unique identifier for the corrective action, typically formatted as CA-YYYYNNNN for external reference and tracking.. Valid values are `^CA-[0-9]{8}$`',
    `action_type` STRING COMMENT 'Classification of the action: corrective (addresses existing nonconformity), preventive (eliminates potential cause), or improvement (enhances HSE performance beyond compliance).. Valid values are `corrective|preventive|improvement`',
    `actual_completion_date` DATE COMMENT 'Date when the corrective action was actually completed and ready for verification.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the corrective action.',
    `assigned_department` STRING COMMENT 'Department or business unit responsible for executing the corrective action.',
    `assigned_owner_name` STRING COMMENT 'Full name of the employee assigned as the action owner for quick reference and reporting.',
    `closure_date` DATE COMMENT 'Date when the corrective action was formally closed after successful verification and effectiveness review.',
    `compliance_deadline` DATE COMMENT 'Regulatory or legal deadline by which the corrective action must be completed to maintain compliance.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action to be taken, including specific steps, methods, and expected outcomes.',
    `corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action tracking its progress from identification through closure. [ENUM-REF-CANDIDATE: open|in_progress|pending_verification|verified|closed|overdue|cancelled — 7 candidates stripped; promote to reference product]',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated and actual cost amounts.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action record was first created in the system.',
    `days_overdue` STRING COMMENT 'Number of days past the target completion date, calculated when action is not completed on time.',
    `effectiveness_review_date` DATE COMMENT 'Date when the effectiveness review was conducted, typically 30-90 days after action completion.',
    `effectiveness_review_notes` STRING COMMENT 'Detailed findings from the effectiveness review including evidence of sustained improvement and any follow-up actions needed.',
    `effectiveness_review_outcome` STRING COMMENT 'Assessment of whether the corrective action successfully eliminated the root cause and prevented recurrence.. Valid values are `effective|partially_effective|ineffective|pending_review`',
    `escalation_date` DATE COMMENT 'Date when the corrective action was escalated to higher management for intervention.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator that the corrective action requires management escalation due to overdue status, high risk, or implementation barriers.',
    `escalation_reason` STRING COMMENT 'Explanation of why the corrective action required escalation (e.g., resource constraints, technical complexity, regulatory deadline risk).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action including labor, materials, equipment, and training.',
    `hazard_category` STRING COMMENT 'Classification of the hazard type addressed by this action (e.g., chemical exposure, ergonomic, fall hazard, vehicle safety, dangerous goods handling). [ENUM-REF-CANDIDATE: chemical_exposure|ergonomic|fall_hazard|vehicle_safety|dangerous_goods|electrical|fire|confined_space|machinery|noise — promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action record was last updated.',
    `location_description` STRING COMMENT 'Specific location within the facility where the action is required (e.g., loading dock, warehouse aisle, driver break room).',
    `priority` STRING COMMENT 'Urgency and importance level of the corrective action based on risk severity and regulatory impact.. Valid values are `critical|high|medium|low`',
    `recurrence_prevention_measures` STRING COMMENT 'Specific measures implemented to prevent recurrence of the nonconformity or hazard, including process changes, training, or engineering controls.',
    `regulatory_finding_id` BIGINT COMMENT 'Reference to the regulatory inspection finding that mandated this corrective action, if applicable.',
    `regulatory_requirement` STRING COMMENT 'Specific OSHA, DOT, IATA, IMO, or other regulatory standard that mandates this corrective action.',
    `root_cause_analysis` STRING COMMENT 'Documentation of the root cause investigation findings that identified the underlying cause of the nonconformity or hazard.',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action must be completed, often driven by regulatory deadlines or risk severity.',
    `title` STRING COMMENT 'Brief summary title of the corrective action for quick identification and reporting purposes.',
    `training_completion_date` DATE COMMENT 'Date when all required training associated with the corrective action was completed.',
    `training_required_flag` BOOLEAN COMMENT 'Indicator that employee training is required as part of the corrective action implementation.',
    `verification_date` DATE COMMENT 'Date when the verification of corrective action effectiveness was completed.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was implemented effectively and achieved the intended outcome.. Valid values are `inspection|audit|testing|documentation_review|observation|measurement`',
    `verification_notes` STRING COMMENT 'Detailed notes from the verification process documenting findings, evidence reviewed, and verification outcome.',
    `verification_status` STRING COMMENT 'Status of the verification process confirming whether the corrective action was successfully implemented.. Valid values are `not_started|pending|verified|failed|reopen_required`',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Transactional record tracking corrective and preventive actions (CAPAs) raised from incident investigations, safety audits, near-miss reports, and regulatory findings. Captures action description, action type (corrective/preventive/improvement), assigned owner, target completion date, actual completion date, verification method, verification status, effectiveness review outcome, and escalation flag. Supports OSHA, ISO 45001, and internal HSE management system compliance by ensuring all identified hazards result in tracked remediation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` (
    `osha_recordable_id` BIGINT COMMENT 'Unique identifier for the OSHA recordable injury or illness case. Primary key for regulatory compliance tracking.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who sustained the recordable injury or illness. Links to workforce master data.',
    `facility_id` BIGINT COMMENT 'Unique identifier of the facility or warehouse where the incident occurred. Links to facility master data for site-level safety performance tracking.',
    `hse_incident_id` BIGINT COMMENT 'Reference to the originating operational HSE incident record from which this OSHA recordable case was derived. Links regulatory filing to operational incident management.',
    `related_osha_recordable_id` BIGINT COMMENT 'Self-referencing FK on osha_recordable (related_osha_recordable_id)',
    `amputation_flag` BOOLEAN COMMENT 'Indicates whether the injury resulted in amputation of any body part. Triggers OSHA 24-hour reporting requirement for severe injuries.',
    `body_part_affected` STRING COMMENT 'Specific body part or system affected by the injury or illness (e.g., lower back, right hand, respiratory system). Used for ergonomic and hazard analysis.',
    `case_classification` STRING COMMENT 'OSHA 300 Log classification of case severity: death, days away from work, job transfer or restriction, or other recordable case. Determines column placement on OSHA 300 Log.. Valid values are `death|days_away_from_work|job_transfer_restriction|other_recordable`',
    `case_closed_date` DATE COMMENT 'Date on which the OSHA recordable case was formally closed. Indicates completion of all medical treatment, return to work, and regulatory filing obligations.',
    `case_number` STRING COMMENT 'Official OSHA case number assigned to this recordable incident. Used for OSHA 300 Log reporting and regulatory filings.. Valid values are `^[A-Z0-9]{4,20}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the OSHA recordable case. Tracks case progression from initial determination through closure or appeal.. Valid values are `open|closed|under_review|appealed`',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions implemented to prevent recurrence of similar incidents. Links regulatory compliance to continuous improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this OSHA recordable case record was first created in the system. Audit trail for regulatory compliance tracking.',
    `days_away_from_work` STRING COMMENT 'Total number of calendar days the employee was unable to work as a result of the injury or illness. Used for OSHA 300 Log column 5 and DART rate calculation.',
    `days_on_job_transfer_restriction` STRING COMMENT 'Total number of calendar days the employee was on restricted work activity or job transfer due to the injury or illness. Used for OSHA 300 Log column 6 and DART rate calculation.',
    `death_date` DATE COMMENT 'Date of employee death if the injury or illness was fatal. Required for OSHA fatality reporting within 8 hours.',
    `death_flag` BOOLEAN COMMENT 'Indicates whether the injury or illness resulted in the death of the employee. Critical flag for OSHA 300 Log column 1 and fatality reporting requirements.',
    `event_description` STRING COMMENT 'Narrative description of how the injury or illness occurred, including contributing factors and circumstances. Required for OSHA 301 Incident Report.',
    `eye_loss_flag` BOOLEAN COMMENT 'Indicates whether the injury resulted in loss of an eye. Triggers OSHA 24-hour reporting requirement for severe injuries.',
    `hire_date` DATE COMMENT 'Date the employee was hired. Used to calculate tenure at time of incident for new-hire safety analysis and onboarding program effectiveness.',
    `hospitalization_flag` BOOLEAN COMMENT 'Indicates whether the employee was hospitalized overnight as an in-patient. Triggers OSHA 8-hour reporting requirement for severe injuries.',
    `incident_date` DATE COMMENT 'Date on which the injury or illness occurred. Principal business event timestamp for OSHA 300 Log chronological recording.',
    `incident_time` TIMESTAMP COMMENT 'Time of day when the incident occurred (24-hour format HH:MM). Used for shift-based safety analysis and temporal risk pattern identification.',
    `injury_illness_type` STRING COMMENT 'Classification of the recordable case as injury or specific illness category per OSHA 300 Log column requirements.. Valid values are `injury|skin_disorder|respiratory_condition|poisoning|hearing_loss|other_illness`',
    `job_title` STRING COMMENT 'Job title or role of the employee at the time of the incident. Used for occupational risk analysis and role-based safety program targeting.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code indicating the regulatory jurisdiction (e.g., USA for OSHA, GBR for RIDDOR, AUS for Safe Work Australia). Supports multi-jurisdiction compliance.. Valid values are `^[A-Z]{2,3}$`',
    `nature_of_injury_illness` STRING COMMENT 'Detailed description of the nature of the injury or illness (e.g., fracture, sprain, laceration, chemical burn, respiratory illness). Free-text field for OSHA 301 reporting.',
    `osha_300a_included_flag` BOOLEAN COMMENT 'Indicates whether this case was included in the annual OSHA 300A Summary of Work-Related Injuries and Illnesses for the reporting year.',
    `physician_diagnosis` STRING COMMENT 'Medical diagnosis provided by treating physician or healthcare professional. Used to determine recordability and case classification.',
    `privacy_case_flag` BOOLEAN COMMENT 'Indicates whether this case qualifies as a privacy concern case per OSHA criteria (e.g., sexual assault, mental illness, HIV, hepatitis, tuberculosis). Employee name may be withheld from OSHA 300 Log.',
    `recordable_determination_date` DATE COMMENT 'Date on which the case was determined to be OSHA recordable. Used for compliance timeline tracking and audit trail.',
    `regulatory_framework` STRING COMMENT 'Specific regulatory framework under which this recordable case is filed (e.g., OSHA for US, RIDDOR for UK, Safe Work Australia, EU OSH Directive). Enables global HSE compliance tracking.. Valid values are `OSHA|RIDDOR|Safe_Work_Australia|EU_OSH_Directive`',
    `regulatory_submission_date` DATE COMMENT 'Date on which this recordable case was formally submitted to the regulatory authority (e.g., OSHA, RIDDOR). Used for compliance deadline tracking.',
    `regulatory_submission_method` STRING COMMENT 'Method by which the case was submitted to regulatory authorities (electronic filing, paper form, phone report). Tracks compliance process efficiency.. Valid values are `electronic|paper|phone|not_submitted`',
    `reporting_year` STRING COMMENT 'Calendar year for which this case is recorded on the OSHA 300 Log. Used for annual summary aggregation and OSHA 300A posting requirements.',
    `root_cause_category` STRING COMMENT 'High-level category of the root cause identified through incident investigation (e.g., equipment failure, human error, procedural gap, environmental factor). Used for preventive action targeting.',
    `treatment_facility_name` STRING COMMENT 'Name of the medical facility or healthcare provider where the employee received treatment. Required for OSHA 301 Incident Report.',
    `treatment_type` STRING COMMENT 'Type of medical treatment provided. Distinguishes first aid (non-recordable) from medical treatment beyond first aid (recordable).. Valid values are `first_aid|medical_treatment|hospitalization|emergency_care`',
    `updated_by_user` STRING COMMENT 'User ID or name of the person who last updated this record. Supports audit trail and accountability for regulatory data integrity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this OSHA recordable case record was last modified. Audit trail for case lifecycle management and data quality.',
    `work_related_determination` STRING COMMENT 'Determination of whether the injury or illness is work-related per OSHA criteria. Only work-related cases are recordable on OSHA 300 Log.. Valid values are `work_related|not_work_related|under_review`',
    CONSTRAINT pk_osha_recordable PRIMARY KEY(`osha_recordable_id`)
) COMMENT 'Regulatory compliance record capturing OSHA-recordable injury and illness cases for US operations, aligned with OSHA 300/300A/301 reporting requirements. Captures case number, employee details (role, tenure), nature of injury/illness, body part affected, days away from work, days on restricted duty, job transfer flag, privacy case flag, and annual summary aggregation period. Also supports equivalent regulatory frameworks for non-US jurisdictions (RIDDOR UK, Safe Work Australia, EU OSH Directive). Distinct from the operational hse_incident record — this is the formal regulatory filing entity.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the safety audit record. Primary key.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Safety audits of network partners (3PLs, agents, carriers) are standard supply chain risk management practice. Links audit to partner for certification tracking, contract compliance verification, and ',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Safety audits verify implementation and effectiveness of specific safety programs (e.g., audit of Lockout/Tagout program). This FK links each audit to the program being audited, enabling program-speci',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Safety audits generate comprehensive document packages (audit reports, findings, corrective action plans, evidence). Standard audit workflow requires packaging all audit documentation together for reg',
    `employee_id` BIGINT COMMENT 'Identifier of the lead auditor responsible for planning, conducting, and reporting the audit.',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: ISO 45001, ISO 14001 safety audit results are disclosed in ESG reports under GRI 403 (Occupational Health & Safety) and SASB standards. External assurance providers require linking audit findings to p',
    `facility_id` BIGINT COMMENT 'Identifier of the primary facility, depot, warehouse, or operational site where the audit is conducted.',
    `previous_audit_id` BIGINT COMMENT 'Identifier of the previous audit conducted at this facility or for this scope. Used to track audit history and trend analysis. Null if this is the first audit.',
    `followup_audit_id` BIGINT COMMENT 'Self-referencing FK on audit (followup_audit_id)',
    `actual_end_date` DATE COMMENT 'Actual date when the audit fieldwork was completed. Used to measure audit duration and efficiency.',
    `actual_start_date` DATE COMMENT 'Actual date when the audit fieldwork commenced. May differ from scheduled date due to operational constraints or delays.',
    `areas_audited` STRING COMMENT 'Comma-separated list or free text description of specific operational areas, processes, or systems covered in the audit (e.g., hazardous materials handling, forklift operations, emergency response procedures, PPE compliance, ergonomics program).',
    `audit_number` STRING COMMENT 'Externally-known unique audit reference number assigned to this safety audit for tracking and reporting purposes. Format: prefix-year-sequence (e.g., HSE-2024-000123).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$`',
    `audit_scope` STRING COMMENT 'Defines the breadth and boundaries of the audit: facility-wide (entire site), department-specific (single operational unit), process-specific (focused on particular workflow), system-specific (management system audit), multi-site (covering multiple locations), or limited-scope (targeted investigation).. Valid values are `facility_wide|department_specific|process_specific|system_specific|multi_site|limited_scope`',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled (planned but not started), in_progress (fieldwork underway), fieldwork_complete (on-site work done, report pending), report_draft (draft report issued), report_final (final report issued), closed (all corrective actions complete), or cancelled. [ENUM-REF-CANDIDATE: scheduled|in_progress|fieldwork_complete|report_draft|report_final|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit based on who conducts it: internal (conducted by Transport Shipping personnel), external (conducted by independent auditors), regulatory (mandated by government agencies), third_party (conducted by contracted audit firms), certification (for ISO/OHSAS certification), or surveillance (periodic follow-up audit).. Valid values are `internal|external|regulatory|third_party|certification|surveillance`',
    `certification_body` STRING COMMENT 'Name of the third-party certification body conducting the audit for ISO 45001, OHSAS 18001, or other management system certification. Null if not a certification audit.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which all corrective actions identified in the audit must be completed. Used for compliance tracking and follow-up scheduling.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this audit record. Used for accountability and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system. Used for audit trail and data lineage.',
    `criteria` STRING COMMENT 'Detailed description of the criteria, policies, procedures, or requirements against which the audit was conducted. May reference specific clauses of standards, internal policies, or regulatory requirements.',
    `critical_findings_count` STRING COMMENT 'Number of critical non-conformances or findings identified during the audit. Critical findings represent immediate safety risks or major regulatory violations requiring urgent corrective action.',
    `department` STRING COMMENT 'Specific department or business unit within the facility that is the focus of the audit (e.g., Operations, Maintenance, Warehouse, Fleet, Customs). Null if audit is facility-wide.',
    `documents_reviewed_count` STRING COMMENT 'Number of documents, records, or procedures reviewed during the audit (e.g., safety policies, training records, incident reports, inspection logs).',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours spent conducting the audit, including preparation, fieldwork, interviews, and reporting. Used for resource planning and audit efficiency analysis.',
    `employees_interviewed_count` STRING COMMENT 'Number of employees interviewed during the audit as part of the evidence-gathering process.',
    `facility_type` STRING COMMENT 'Type of operational facility being audited: warehouse, distribution center, depot, terminal, office, maintenance facility, or cross-dock. [ENUM-REF-CANDIDATE: warehouse|distribution_center|depot|terminal|office|maintenance_facility|cross_dock — 7 candidates stripped; promote to reference product]',
    `follow_up_audit_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify closure of corrective actions. True if follow-up is mandated, false otherwise.',
    `follow_up_audit_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up audit to verify corrective action implementation. Null if no follow-up is required.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this audit record. Used for change accountability and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last updated. Used for change tracking and data quality monitoring.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor for reporting and accountability purposes.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformances or findings identified. Major findings represent significant gaps in compliance or safety management that require formal corrective action plans.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformances or findings identified. Minor findings represent isolated lapses or documentation gaps that require corrective action but do not pose immediate risk.',
    `next_scheduled_audit_date` DATE COMMENT 'Planned date for the next periodic audit of this facility or scope, based on audit frequency requirements (e.g., annual, biennial). Used for audit program planning.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, context, or observations about the audit that do not fit into structured fields. May include special circumstances, audit challenges, or contextual information.',
    `objective` STRING COMMENT 'Primary objective or purpose of the audit (e.g., annual compliance verification, incident follow-up, pre-certification assessment, new facility commissioning, post-acquisition integration). Free text to capture specific business context.',
    `observations_count` STRING COMMENT 'Number of observations or opportunities for improvement noted during the audit. Observations are not non-conformances but represent best practice recommendations.',
    `overall_audit_rating` STRING COMMENT 'Summary rating assigned by the audit team reflecting the overall health, safety, and environmental compliance posture of the audited entity: excellent (exceeds standards), satisfactory (meets standards), needs_improvement (minor gaps), unsatisfactory (significant gaps), or critical (immediate action required).. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory|critical`',
    `positive_findings_count` STRING COMMENT 'Number of positive findings or commendations noted during the audit, recognizing exemplary safety practices or compliance achievements.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or governing body that mandated the audit (e.g., OSHA, IMO, IATA, local labor ministry). Applicable only for regulatory audits; null for internal or voluntary audits.',
    `report_issued_date` DATE COMMENT 'Date when the final audit report was formally issued to the audited facility and stakeholders.',
    `scheduled_end_date` DATE COMMENT 'Planned date when the audit was scheduled to conclude. Used for resource planning and timeline management.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the audit was scheduled to begin. Used for planning and compliance tracking.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score representing the percentage of audit criteria met or compliance level achieved (0.00 to 100.00). Used for quantitative benchmarking and trend analysis.',
    `standard` STRING COMMENT 'The health, safety, and environmental standard or framework against which the audit is conducted (e.g., ISO 45001, OHSAS 18001, IATA ISAGO, SQAS, OSHA VPP, C-TPAT security standards, internal HSE policy). Free text to accommodate various international and industry-specific standards.',
    `team_members` STRING COMMENT 'Comma-separated list of names or identifiers of additional audit team members who participated in the audit alongside the lead auditor.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for planned and ad-hoc HSE safety audits conducted at Transport Shipping facilities, depots, warehouses, and operational sites. Captures audit type (internal, external, regulatory, third-party), audit scope (facility-wide, department, process-specific), audit standard (ISO 45001, OHSAS 18001, IATA ISAGO, SQAS), lead auditor, audit team, scheduled date, actual date, overall audit rating, number of findings by severity, and audit report reference. Distinct from facility-level operational inspections — this is a formal structured audit with a defined scope and standard.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` (
    `safety_audit_finding_id` BIGINT COMMENT 'Unique identifier for the safety audit finding record. Primary key for the safety audit finding entity.',
    `audit_id` BIGINT COMMENT 'Reference to the parent safety audit during which this finding was identified. Links the finding to the specific audit event.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Audit findings from partner audits must link to the audited partner for corrective action assignment, follow-up verification, partner performance scoring, and contract compliance enforcement. Essentia',
    `corrective_action_id` BIGINT COMMENT 'Reference to the corrective action record raised to address this finding. Links finding to remediation workflow.',
    `facility_id` BIGINT COMMENT 'Reference to the specific facility, warehouse, terminal, or site where the finding was identified.',
    `previous_finding_safety_audit_finding_id` BIGINT COMMENT 'Reference to the previous finding record if this is a repeat finding. Enables tracking of recurring issues.',
    `employee_id` BIGINT COMMENT 'Reference to the auditor or audit team member who identified and documented this finding.',
    `quaternary_safety_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified this finding record. Supports audit trail and accountability.',
    `tertiary_safety_verified_by_employee_id` BIGINT COMMENT 'Reference to the auditor or safety manager who verified the effectiveness of corrective action and authorized finding closure.',
    `related_safety_audit_finding_id` BIGINT COMMENT 'Self-referencing FK on safety_audit_finding (related_safety_audit_finding_id)',
    `actual_closure_date` DATE COMMENT 'Actual date on which the finding was verified as closed following successful completion and verification of corrective action.',
    `audit_program_type` STRING COMMENT 'Type of audit program or framework under which this finding was identified. Supports traceability across multiple audit programs. [ENUM-REF-CANDIDATE: iso_45001|iata_isago|sqas|osha_vpp|internal_hse|client_audit|regulatory_inspection|certification_audit — 8 candidates stripped; promote to reference product]',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether this finding requires formal corrective action. True for major/minor non-conformances; false for observations or positive findings.',
    `cost_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement corrective action and resolve the finding. Used for budgeting and prioritization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this finding record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact estimate. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Code identifying the department or operational unit responsible for the area where the finding was identified. Used for accountability and trend analysis.',
    `evidence_collected` STRING COMMENT 'Description of objective evidence collected to support the finding. May include document references, photographs, witness statements, measurements, or observations.',
    `finding_category` STRING COMMENT 'Business domain or functional area to which the finding relates. Enables categorization and trend analysis across Health, Safety, and Environmental (HSE) domains. [ENUM-REF-CANDIDATE: workplace_safety|dangerous_goods_handling|driver_safety|facility_safety|equipment_safety|emergency_preparedness|training_compliance|documentation|ppe_compliance|environmental_health_safety — 10 candidates stripped; promote to reference product]',
    `finding_date` DATE COMMENT 'Date on which the finding was identified during the audit. Represents the business event timestamp for the finding discovery.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the non-conformance, observation, or positive practice identified. Includes what was observed, where, and why it constitutes a finding.',
    `finding_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this finding for tracking and communication purposes. Used in audit reports and corrective action tracking.. Valid values are `^[A-Z0-9-]+$`',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding in the corrective action workflow. Tracks progress from identification through closure. [ENUM-REF-CANDIDATE: open|under_review|corrective_action_assigned|corrective_action_in_progress|pending_verification|closed|overdue — 7 candidates stripped; promote to reference product]',
    `finding_type` STRING COMMENT 'Classification of the finding severity and nature. Major non-conformance requires immediate corrective action; minor non-conformance requires action within defined timeframe; observation is advisory; positive finding recognizes good practice.. Valid values are `major_non_conformance|minor_non_conformance|observation|opportunity_for_improvement|positive_finding|critical_non_conformance`',
    `immediate_action_taken` STRING COMMENT 'Description of any immediate containment or interim actions taken at the time of finding identification to mitigate immediate risk.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this finding record was last updated. Audit trail for record changes.',
    `likelihood_score` STRING COMMENT 'Numerical score representing the probability that the identified hazard or non-conformance will result in an incident. Typically scored 1-5 where 5 is most likely.',
    `location_type` STRING COMMENT 'Type of facility or location where the finding was identified. Enables location-based trend analysis. [ENUM-REF-CANDIDATE: warehouse|distribution_center|terminal|office|vehicle|aircraft|vessel|container_freight_station|customs_facility|maintenance_facility — 10 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to the finding. Used for supplementary information not captured in structured fields.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body to which the finding was reported. Examples: OSHA, IATA, IMO, national civil aviation authority, maritime authority.',
    `regulatory_report_date` DATE COMMENT 'Date on which the finding was reported to the relevant regulatory authority, if applicable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this finding must be reported to external regulatory authorities such as OSHA, IATA, or maritime authorities.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this finding is a recurrence of a previously identified and closed finding. Repeat findings indicate ineffective corrective action.',
    `risk_rating` STRING COMMENT 'Assessment of the risk level associated with this finding based on likelihood and severity of potential harm. Used to prioritize corrective actions.. Valid values are `critical|high|medium|low|negligible`',
    `root_cause_analysis_required_flag` BOOLEAN COMMENT 'Indicates whether formal root cause analysis is required for this finding. Typically required for major non-conformances and critical findings.',
    `root_cause_description` STRING COMMENT 'Description of the underlying root cause(s) identified through root cause analysis. Addresses systemic issues rather than symptoms.',
    `severity_score` STRING COMMENT 'Numerical score representing the potential impact or consequence if the hazard materializes. Typically scored 1-5 where 5 is most severe (fatality or catastrophic loss).',
    `standard_clause_reference` STRING COMMENT 'Specific clause, section, or requirement number from the applicable standard or regulation that was violated or observed. Examples: ISO 45001 clause 8.1.2, OSHA 1910.178, IATA DGR 7.1.4.',
    `standard_name` STRING COMMENT 'Name of the standard, regulation, or framework against which the audit was conducted. Examples: ISO 45001:2018, OSHA 29 CFR 1910, IATA ISAGO, SQAS.',
    `target_closure_date` DATE COMMENT 'Target date by which the finding must be resolved and corrective action completed. Based on finding severity and regulatory requirements.',
    `verification_date` DATE COMMENT 'Date on which the corrective action was verified as effective and the finding was confirmed closed.',
    `verification_method` STRING COMMENT 'Method used to verify that corrective action has been effectively implemented and the finding resolved. [ENUM-REF-CANDIDATE: document_review|site_inspection|interview|testing|measurement|photographic_evidence|combination — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_safety_audit_finding PRIMARY KEY(`safety_audit_finding_id`)
) COMMENT 'Individual finding record raised during a safety audit, capturing each non-conformance, observation, or opportunity for improvement identified. Captures finding reference number, finding type (major non-conformance, minor non-conformance, observation, positive finding), clause or standard requirement violated, finding description, evidence collected, risk rating, and link to corrective action raised. Supports audit traceability and regulatory follow-up across ISO 45001, IATA ISAGO, and SQAS audit programs. Note: distinct from finance.audit_finding which covers financial/SOX audit findings.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` (
    `facility_inspection_id` BIGINT COMMENT 'Unique identifier for the facility inspection record. Primary key for the facility inspection entity.',
    `template_id` BIGINT COMMENT 'Reference to the standardized inspection checklist template used for this inspection, defining the specific items and criteria to be evaluated.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to safety.emergency_response_plan. Business justification: Facility inspections verify emergency response plan readiness (e.g., checking emergency exits, assembly points, equipment). This FK links inspections to the ERP they verify, supporting ERP audit requi',
    `facility_id` BIGINT COMMENT 'Reference to the facility where the inspection was conducted (warehouse, depot, sorting hub, office, terminal, or distribution center).',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Network nodes (terminals, hubs, cross-dock facilities) require HSE inspections for material handling, vehicle movements, hazmat storage. Facility inspections must reference the specific node for compl',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor who conducted the inspection. Typically a safety officer, facility manager, or certified inspector.',
    `followup_facility_inspection_id` BIGINT COMMENT 'Self-referencing FK on facility_inspection (followup_facility_inspection_id)',
    `approval_date` DATE COMMENT 'Date when the inspection report was formally approved by management, signifying acceptance of findings and corrective action plans.',
    `checklist_completion_status` STRING COMMENT 'Indicates whether all items on the inspection checklist have been evaluated. Not started means no items checked; partial means some items remain; complete means all items evaluated.. Valid values are `not_started|partial|complete`',
    `corrective_action_due_date` DATE COMMENT 'Target date by which all corrective actions for deficiencies must be completed and verified, based on severity and regulatory requirements.',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether formal corrective action plans must be created and tracked to address deficiencies found during this inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first created in the system, typically when the inspection was scheduled or initiated.',
    `critical_deficiencies` STRING COMMENT 'Number of deficiencies classified as critical or high-severity, representing immediate safety hazards or regulatory violations requiring urgent remediation.',
    `deficiencies_found` STRING COMMENT 'Total count of safety deficiencies, non-conformances, or violations identified during the inspection that require corrective action.',
    `deficiency_summary` STRING COMMENT 'Consolidated narrative description of all deficiencies found during the inspection, including locations, conditions observed, and potential safety impacts.',
    `follow_up_inspection_date` DATE COMMENT 'Scheduled date for the follow-up inspection to verify corrective action completion, if required.',
    `follow_up_inspection_required` BOOLEAN COMMENT 'Flag indicating whether a follow-up inspection must be scheduled to verify that corrective actions have been completed and deficiencies resolved.',
    `immediate_actions_taken` STRING COMMENT 'Description of any immediate remediation actions performed on-site during or immediately following the inspection to address critical safety hazards (e.g., cordoning off area, shutting down equipment, posting warnings).',
    `inspection_date` DATE COMMENT 'The calendar date on which the inspection was conducted or is scheduled to be conducted.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the inspector completed the on-site inspection activities and finalized the checklist.',
    `inspection_frequency` STRING COMMENT 'Scheduled recurrence pattern for this type of inspection at the facility. Daily for high-risk areas; weekly for operational zones; monthly for general facility; quarterly for equipment; annual for comprehensive audits; ad hoc for incident-driven inspections.. Valid values are `daily|weekly|monthly|quarterly|annual|ad_hoc`',
    `inspection_notes` STRING COMMENT 'Free-text field for inspector to record additional observations, context, recommendations, or special circumstances encountered during the inspection.',
    `inspection_number` STRING COMMENT 'Business identifier for the inspection, typically formatted as a human-readable code used in operational communications and reporting.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `inspection_score` DECIMAL(18,2) COMMENT 'Numerical score or rating assigned to the inspection based on checklist compliance, typically expressed as a percentage (0.00 to 100.00) representing the proportion of items meeting safety standards.',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the inspector began the on-site inspection activities.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection. Scheduled indicates planned but not started; in progress indicates inspector is actively conducting the inspection; completed indicates inspection finished and documented; cancelled indicates inspection was not performed; overdue indicates scheduled inspection was not completed by due date.. Valid values are `scheduled|in_progress|completed|cancelled|overdue`',
    `inspection_type` STRING COMMENT 'Category of safety inspection conducted. Fire safety covers fire suppression systems and exits; housekeeping covers cleanliness and organization; equipment covers machinery and tools; emergency egress covers evacuation routes; hazmat storage covers dangerous goods handling areas; electrical covers wiring and power systems.. Valid values are `fire_safety|housekeeping|equipment|emergency_egress|hazmat_storage|electrical`',
    `inspector_certification_number` STRING COMMENT 'Professional certification or license number of the inspector, if applicable (e.g., OSHA certification, fire safety certification, hazmat handling certification).',
    `inspector_name` STRING COMMENT 'Full name of the individual who performed the inspection, captured for audit trail and accountability purposes.',
    `items_inspected` STRING COMMENT 'Number of checklist items that have been evaluated and marked as inspected by the inspector.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection record, capturing changes to status, findings, or corrective actions.',
    `major_deficiencies` STRING COMMENT 'Number of deficiencies classified as major or medium-severity, representing significant safety concerns that require timely corrective action.',
    `minor_deficiencies` STRING COMMENT 'Number of deficiencies classified as minor or low-severity, representing housekeeping issues or minor non-conformances that should be addressed but do not pose immediate risk.',
    `overall_inspection_result` STRING COMMENT 'Summary outcome of the inspection. Pass indicates no deficiencies or only minor issues; pass with observations indicates deficiencies noted but not critical; fail indicates critical deficiencies requiring immediate action; incomplete indicates inspection could not be fully completed.. Valid values are `pass|pass_with_observations|fail|incomplete`',
    `regulatory_compliance_status` STRING COMMENT 'Assessment of whether the facility meets applicable regulatory requirements (OSHA, fire code, environmental regulations) based on inspection findings. Compliant means all requirements met; non-compliant means violations found; conditional means temporary variance or pending remediation; not applicable means no specific regulations apply to this inspection type.. Valid values are `compliant|non_compliant|conditional|not_applicable`',
    `report_document_url` STRING COMMENT 'Link or file path to the detailed inspection report document, including photos, annotated checklists, and supporting evidence.',
    `total_checklist_items` STRING COMMENT 'Total number of inspection items on the checklist template that must be evaluated during this inspection.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection, relevant for outdoor facility areas and external safety features (e.g., clear, rain, snow, extreme heat).',
    CONSTRAINT pk_facility_inspection PRIMARY KEY(`facility_inspection_id`)
) COMMENT 'Operational record for routine and scheduled safety inspections conducted at Transport Shipping facilities including warehouses, depots, sorting hubs, and offices. Captures inspection type (fire safety, housekeeping, equipment, emergency egress, hazmat storage), inspection frequency (daily, weekly, monthly), inspector identity, inspection date, checklist completion status, number of deficiencies found, deficiency descriptions, and immediate remediation actions taken. Distinct from formal safety_audit — inspections are routine operational checks, not structured compliance audits.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`dg_certification` (
    `dg_certification_id` BIGINT COMMENT 'Unique identifier for the dangerous goods certification record. Primary key.',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: DG certifications ARE certificates - this links the safety-domain certification record to its formal certificate document. Required for regulatory compliance verification, audit trails, and shipper/ca',
    `employee_id` BIGINT COMMENT 'The unique identifier of the Transport Shipping manager or supervisor responsible for ensuring this certification remains current and that the holder maintains competency. Links to employee master data.',
    `holder_employee_id` BIGINT COMMENT 'The unique identifier of the entity (employee, facility, vehicle, equipment, or organizational unit) that holds this certification. This is a polymorphic reference resolved based on holder_type.',
    `modified_by_user_employee_id` BIGINT COMMENT 'The system user ID or employee identifier of the person who last modified this certification record. Audit trail field for accountability and data governance.',
    `renewed_dg_certification_id` BIGINT COMMENT 'Self-referencing FK on dg_certification (renewed_dg_certification_id)',
    `assessment_score` DECIMAL(18,2) COMMENT 'The numerical score or percentage achieved by the certification holder on the final examination or competency assessment, if applicable. Typically expressed as a percentage (0.00 to 100.00). Null if no formal assessment was required.',
    `certification_scope` STRING COMMENT 'The specific dangerous goods function or role that this certification authorizes the holder to perform. Packer (authorized to pack DG into packages), shipper (authorized to prepare DG shipments and documentation), handler (authorized to physically handle DG cargo), inspector (authorized to inspect DG shipments for compliance), driver (authorized to transport DG by road), acceptance checker (authorized to accept DG shipments at origin), load planner (authorized to plan aircraft/vessel loading with DG), emergency responder (trained for DG incident response), security screener (authorized to screen DG cargo). [ENUM-REF-CANDIDATE: packer|shipper|handler|inspector|driver|acceptance_checker|load_planner|emergency_responder|security_screener — 9 candidates stripped; promote to reference product]',
    `certification_status` STRING COMMENT 'The current lifecycle status of the dangerous goods certification. Active (valid and in force), expired (validity period has ended), suspended (temporarily invalid due to compliance issue or pending investigation), revoked (permanently invalidated by authority), pending_renewal (approaching expiry and renewal process initiated), cancelled (voluntarily terminated by holder or organization).. Valid values are `active|expired|suspended|revoked|pending_renewal|cancelled`',
    `certification_type` STRING COMMENT 'The regulatory framework or standard under which the dangerous goods certification was issued. IATA DGR (International Air Transport Association Dangerous Goods Regulations) for air transport, IMDG (International Maritime Dangerous Goods Code) for ocean transport, ADR (European Agreement concerning the International Carriage of Dangerous Goods by Road), RID (Regulations concerning the International Carriage of Dangerous Goods by Rail), ICAO TI (International Civil Aviation Organization Technical Instructions), 49 CFR (US Code of Federal Regulations for hazmat), UN Model Regulations (United Nations Recommendations on the Transport of Dangerous Goods). [ENUM-REF-CANDIDATE: IATA DGR|IMDG|ADR|RID|ICAO TI|49 CFR|UN Model Regulations — 7 candidates stripped; promote to reference product]',
    `competency_level` STRING COMMENT 'The proficiency or qualification level of the certification holder in dangerous goods handling. Basic (entry-level awareness training), intermediate (operational handling certification), advanced (senior handler or supervisor certification), specialist (expert in specific DG classes or complex operations), instructor (authorized to train and certify others).. Valid values are `basic|intermediate|advanced|specialist|instructor`',
    `compliance_audit_date` DATE COMMENT 'The date of the most recent compliance audit or inspection that verified the certification holders continued competency and adherence to dangerous goods regulations. Null if no audit has been conducted.',
    `compliance_audit_result` STRING COMMENT 'The outcome of the most recent compliance audit. Pass (full compliance confirmed), pass_with_observations (compliant but minor improvement areas noted), fail (non-compliance identified requiring corrective action), not_audited (no audit conducted).. Valid values are `pass|pass_with_observations|fail|not_audited`',
    `cost_center_code` STRING COMMENT 'The financial cost center code to which the certification training and maintenance costs are allocated. Used for budgeting and cost tracking of dangerous goods compliance programs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was first created in the Transport Shipping system. Audit trail field for data governance and compliance tracking.',
    `dg_class_coverage` STRING COMMENT 'The UN dangerous goods classes that this certification covers, represented as a comma-separated list of class numbers (e.g., 1,2,3,4,5,6,7,8,9). Class 1 (explosives), Class 2 (gases), Class 3 (flammable liquids), Class 4 (flammable solids), Class 5 (oxidizing substances), Class 6 (toxic substances), Class 7 (radioactive material), Class 8 (corrosive substances), Class 9 (miscellaneous dangerous goods). Empty if certification covers all classes.',
    `expiry_date` DATE COMMENT 'The date on which this dangerous goods certification expires and is no longer valid. After this date, the holder must renew or recertify to continue performing DG functions. Null if the certification has no expiry (rare, typically only for certain facility certifications).',
    `geographic_scope` STRING COMMENT 'The geographic region or jurisdiction(s) where this certification is recognized and valid. May be global (IATA/ICAO certifications), regional (EU ADR), or country-specific (US 49 CFR). Represented as comma-separated ISO 3166-1 alpha-3 country codes or region codes.',
    `holder_name` STRING COMMENT 'The full name or designation of the certification holder (employee full name, facility name, vehicle registration, equipment serial number, or organizational unit name). Provides human-readable identification.',
    `holder_type` STRING COMMENT 'The category of entity that holds this dangerous goods certification. Employee (individual person trained and certified), facility (warehouse or terminal authorized for DG handling), vehicle (truck, aircraft, vessel certified for DG transport), equipment (container, packaging, handling equipment), organizational unit (business division or operational unit).. Valid values are `employee|facility|vehicle|equipment|organizational_unit`',
    `issue_date` DATE COMMENT 'The date on which the dangerous goods certification was originally issued to the holder. This is the effective start date of the certification validity period.',
    `issuing_authority` STRING COMMENT 'The name of the regulatory body, training organization, or competent authority that issued this dangerous goods certification. Examples include IATA-accredited training centers, national civil aviation authorities, maritime administrations, or DOT-approved training providers.',
    `issuing_authority_code` STRING COMMENT 'The standardized code or registration number of the issuing authority, if applicable. For example, IATA training center code, CAA registration number, or DOT training provider ID.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was most recently updated in the Transport Shipping system. Audit trail field for data governance and change tracking.',
    `last_renewal_date` DATE COMMENT 'The date on which this certification was most recently renewed or recertified. Null if the certification has never been renewed (i.e., still on original issue).',
    `mode_of_transport` STRING COMMENT 'The transport mode(s) for which this dangerous goods certification is valid. Air (IATA/ICAO regulations), ocean (IMDG Code), road (ADR), rail (RID), multimodal (valid across multiple modes).. Valid values are `air|ocean|road|rail|multimodal`',
    `next_recurrent_training_due_date` DATE COMMENT 'The date by which the certification holder must complete the next recurrent dangerous goods training session to maintain certification validity. Calculated based on last training date plus recurrent_training_frequency_months. Null if no recurrent training is required.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, restrictions, or comments related to this dangerous goods certification. May include notes on specialized training, limitations on scope, or historical context.',
    `pass_threshold` DECIMAL(18,2) COMMENT 'The minimum score or percentage required to pass the certification examination and obtain the certification. Typically 80.00 or 85.00 for dangerous goods certifications. Null if no formal assessment was required.',
    `recurrent_training_frequency_months` STRING COMMENT 'The required interval in months between recurrent dangerous goods training sessions to maintain certification validity. Typically 24 months (2 years) for IATA DGR certifications. Null if no recurrent training is required.',
    `regulatory_version` STRING COMMENT 'The edition or version of the dangerous goods regulations under which this certification was issued. For example, IATA DGR 64th Edition, IMDG Code Amendment 40-20. Important for tracking regulatory currency as DG regulations are updated regularly.',
    `reinstatement_date` DATE COMMENT 'The date on which a previously suspended certification was reinstated to active status after corrective actions were completed. Null if certification has never been suspended or has not been reinstated.',
    `renewal_due_date` DATE COMMENT 'The date by which the certification renewal process must be completed to maintain continuous validity. Typically set 30-90 days before expiry_date to allow time for recertification training and processing.',
    `renewal_status` STRING COMMENT 'The current status of the certification renewal process. Not_required (certification is not yet due for renewal), pending (renewal window has opened but not yet initiated), in_progress (renewal training or recertification underway), completed (renewal successfully completed and new certification issued), overdue (expiry date passed without renewal).. Valid values are `not_required|pending|in_progress|completed|overdue`',
    `revocation_date` DATE COMMENT 'The date on which the certification was permanently revoked by the issuing authority or by Transport Shipping management. Null if certification has never been revoked.',
    `revocation_reason` STRING COMMENT 'The reason or justification for permanent revocation of the certification, if certification_status is revoked. Examples include serious compliance violation, safety incident caused by holder negligence, fraudulent certification, or regulatory enforcement action. Null if certification has never been revoked.',
    `suspension_date` DATE COMMENT 'The date on which the certification was suspended. Null if certification has never been suspended.',
    `suspension_reason` STRING COMMENT 'The reason or justification for suspension of the certification, if certification_status is suspended. Examples include compliance violation, incident investigation, failure to complete recurrent training, or regulatory audit finding. Null if certification has never been suspended.',
    `training_completion_date` DATE COMMENT 'The date on which the certification holder successfully completed the required dangerous goods training course and passed any required examinations.',
    `training_course_reference` STRING COMMENT 'The reference number, code, or identifier of the dangerous goods training course that the certification holder completed to obtain this certification. Links to the training program record.',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified with the issuing authority or through an independent verification process. Null if never verified.',
    `verification_status` STRING COMMENT 'The status of third-party or internal verification of the certification authenticity and validity. Verified (certification confirmed with issuing authority), pending_verification (verification request submitted but not yet confirmed), verification_failed (issuing authority could not confirm or certification found invalid), not_verified (no verification attempted).. Valid values are `verified|pending_verification|verification_failed|not_verified`',
    CONSTRAINT pk_dg_certification PRIMARY KEY(`dg_certification_id`)
) COMMENT 'Master record for dangerous goods (DG) handling certifications held by Transport Shipping employees, facilities, and operational units. Captures certification type (IATA DGR, IMDG, ADR/RID, ICAO TI), certification holder type (individual employee, facility, vehicle), certification number, issuing authority, issue date, expiry date, certification scope (packer, shipper, handler, inspector), renewal status, and training course reference. Serves as the SSOT for DG competency and authorization records across air, ocean, road, and rail operations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`dg_incident` (
    `dg_incident_id` BIGINT COMMENT 'Unique identifier for the dangerous goods incident record. Primary key.',
    `air_waybill_id` BIGINT COMMENT 'Foreign key linking to freight.air_waybill. Business justification: DG incidents in air freight require proper AWB linkage (not just denormalized awb_number) for IATA DGR incident reporting, airline notification, and regulatory compliance. Enables proper relational qu',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Maritime DG incidents require proper BOL linkage (not just denormalized bol_number) for IMO/IMDG incident reporting, vessel operator notification, and port authority compliance. Essential for ocean fr',
    `cfs_operation_id` BIGINT COMMENT 'Foreign key linking to freight.cfs_operation. Business justification: CFS handling of dangerous goods requires incident tracking for facility safety compliance, storage incident analysis, and regulatory reporting to local authorities. Enables DG handling procedure revie',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment during which the dangerous goods incident occurred. Links incident to operational shipment record.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: Consolidated shipments with dangerous goods require incident linkage for deconsolidation safety procedures, segregation compliance verification, and NVOCC regulatory reporting. Critical for CFS DG han',
    `facility_id` BIGINT COMMENT 'Reference to the warehouse, terminal, or facility where the dangerous goods incident occurred if not in transit.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Dangerous goods incidents must link to freight order for compliance tracking, customer notification, regulatory reporting (IATA/IMO/DOT), insurance claims, and shipper accountability. Critical for DG ',
    `dg_certification_id` BIGINT COMMENT 'Foreign key linking to safety.dg_certification. Business justification: DG incidents should track which certified handler was involved. Links the incident to the specific DG certification of the employee handling the dangerous goods at the time of the incident. This suppo',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: A dangerous goods incident is often also recorded as a general HSE incident. The DG incident captures DG-specific details (UN number, hazard class, packing group, quantity) while the HSE incident capt',
    `employee_id` BIGINT COMMENT 'Reference to the employee who first reported the dangerous goods incident. Used for incident tracking and safety culture metrics.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Dangerous goods incidents during carrier transport require tracking which carrier was responsible for regulatory notification to authorities, liability assessment, remediation costs, and compliance en',
    `environmental_incident_id` BIGINT COMMENT 'Foreign key linking to safety.environmental_incident. Business justification: DG incidents that cause environmental releases (spills, emissions) spawn environmental_incident records. This FK links the DG incident to the resulting environmental incident, supporting integrated in',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Dangerous goods incidents (leaks, packaging failures, labeling violations) occur during specific transport segments. Leg-level tracking enables carrier accountability, mode-specific risk analysis (air',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Dangerous goods incidents require mandatory transport documentation (DG incident reports, emergency response documentation). Critical regulatory requirement under IATA/IMDG/DOT regulations. Every DG i',
    `related_dg_incident_id` BIGINT COMMENT 'Self-referencing FK on dg_incident (related_dg_incident_id)',
    `closure_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods incident was formally closed after all corrective actions were completed and verified.',
    `corrective_actions` STRING COMMENT 'Description of corrective and preventive actions implemented to prevent recurrence of similar dangerous goods incidents.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated incident cost.. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the dangerous goods incident occurred. Determines applicable national regulations and reporting authorities.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dangerous goods incident record was first created in the system. Used for audit trail and data lineage.',
    `emergency_response_actions` STRING COMMENT 'Detailed description of immediate emergency response actions taken to contain and mitigate the dangerous goods incident (e.g., spill containment, evacuation, fire suppression).',
    `environmental_impact_assessment` STRING COMMENT 'Assessment of environmental damage or contamination resulting from the dangerous goods incident. Used for EPA/environmental authority reporting and remediation planning.',
    `environmental_release_flag` BOOLEAN COMMENT 'Indicates whether the dangerous goods incident resulted in release of hazardous material to the environment (air, water, soil). Triggers additional reporting requirements.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of the dangerous goods incident including cleanup, remediation, fines, legal costs, and operational disruption. Used for financial impact analysis.',
    `fatalities_reported` STRING COMMENT 'Count of fatalities resulting from the dangerous goods incident. Triggers immediate regulatory notification and investigation.',
    `hazard_class` STRING COMMENT 'Primary hazard classification of the dangerous goods (e.g., 3 for flammable liquids, 8 for corrosives). Determines handling and emergency response protocols.. Valid values are `^[1-9](.[1-6])?$`',
    `incident_number` STRING COMMENT 'Externally-known business identifier for the dangerous goods incident, used for regulatory reporting and internal tracking.. Valid values are `^DGI-[0-9]{8,12}$`',
    `incident_status` STRING COMMENT 'Current lifecycle state of the dangerous goods incident investigation and remediation process.. Valid values are `reported|under_investigation|contained|resolved|closed`',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods incident occurred. Critical for regulatory reporting timelines and root cause analysis.',
    `incident_type` STRING COMMENT 'Classification of the dangerous goods incident event. Determines regulatory notification requirements and response protocols.. Valid values are `spillage|leakage|fire|explosion|contamination|mislabelling`',
    `injuries_reported` STRING COMMENT 'Count of personnel injuries resulting from the dangerous goods incident. Used for OSHA reporting and safety performance metrics.',
    `investigation_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods incident investigation was completed and findings documented.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this dangerous goods incident record was last updated. Used for audit trail and change tracking.',
    `location_description` STRING COMMENT 'Detailed description of the physical location where the dangerous goods incident occurred (e.g., loading dock, aircraft cargo hold, container yard).',
    `notes` STRING COMMENT 'Additional free-text notes and observations related to the dangerous goods incident. Used for supplementary documentation and context.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether mandatory regulatory notification has been submitted to the appropriate authority. Critical for compliance tracking.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory notification was submitted. Used to verify compliance with mandatory reporting timelines (typically 72 hours).',
    `notified_authority` STRING COMMENT 'Name of the regulatory authority to which the dangerous goods incident was reported (e.g., FAA, CAA, Coast Guard, national maritime authority).',
    `packing_group` STRING COMMENT 'Degree of danger presented by the dangerous goods: I (high danger), II (medium danger), III (low danger). Affects packaging and handling requirements.. Valid values are `I|II|III`',
    `proper_shipping_name` STRING COMMENT 'Official name of the dangerous goods substance as defined by UN regulations. Used for regulatory reporting and material identification.',
    `quantity_involved` DECIMAL(18,2) COMMENT 'Amount of dangerous goods substance involved in the incident. Used for environmental impact assessment and regulatory reporting thresholds.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity of dangerous goods involved in the incident.. Valid values are `kg|liter|cubic_meter|piece`',
    `regulatory_framework` STRING COMMENT 'Primary dangerous goods regulatory framework applicable to this incident based on transport mode and jurisdiction.. Valid values are `IATA_DGR|IMDG|ADR|RID|49CFR`',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the dangerous goods incident meets thresholds requiring mandatory notification to regulatory authorities (IATA, IMO, national CAA, maritime authority).',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods incident was first reported to internal safety management. Used to measure reporting compliance and response time.',
    `root_cause_analysis` STRING COMMENT 'Findings from root cause investigation identifying underlying factors that led to the dangerous goods incident. Used for corrective action planning.',
    `transport_mode` STRING COMMENT 'Mode of transport or facility type where the dangerous goods incident occurred. Determines applicable regulatory framework (IATA, IMDG, ADR, RID).. Valid values are `air|ocean|road|rail|warehouse|terminal`',
    `un_number` STRING COMMENT 'Four-digit UN identification number assigned to the dangerous goods substance involved in the incident. Mandatory for regulatory classification.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_dg_incident PRIMARY KEY(`dg_incident_id`)
) COMMENT 'Transactional record capturing dangerous goods (DG) incidents and occurrences during transport, handling, or storage. Captures DG UN number, proper shipping name, hazard class, packing group, quantity involved, incident type (spillage, leakage, fire, explosion, contamination, mislabelling), transport mode at time of incident, regulatory notification requirement (IATA, IMDG, ADR), notification sent flag, emergency response actions taken, and environmental impact assessment. Distinct from the general hse_incident — DG incidents have specific regulatory notification and reporting obligations under IATA DGR and IMDG Code.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` (
    `driver_safety_program_id` BIGINT COMMENT 'Unique identifier for the driver safety program. Primary key.',
    `superseded_driver_safety_program_id` BIGINT COMMENT 'Self-referencing FK on driver_safety_program (superseded_driver_safety_program_id)',
    `actual_enrollment_count` STRING COMMENT 'Current count of drivers who have enrolled in this safety program to date.',
    `applicable_driver_population` STRING COMMENT 'Target driver segment or population to which this safety program applies (e.g., long-haul drivers, last-mile delivery, hazmat-certified drivers).. Valid values are `long_haul|last_mile|hazmat|all_drivers|regional|urban`',
    `assessment_method` STRING COMMENT 'Method used to evaluate driver competency and program completion (e.g., written exam, practical test, observation, self-assessment).. Valid values are `written_exam|practical_test|observation|self_assessment|combined`',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this program results in a formal certification (true) or is informational only (false).',
    `certification_validity_days` STRING COMMENT 'Number of days the certification remains valid after program completion before recertification is required. Null if no certification or perpetual validity.',
    `completion_rate_target` DECIMAL(18,2) COMMENT 'Target percentage (0-100) of enrolled drivers expected to successfully complete the program.',
    `contact_email` STRING COMMENT 'Email address of the program coordinator or contact person for inquiries and support related to this safety program.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number of the program coordinator or contact person for inquiries and support related to this safety program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this driver safety program record was first created in the system.',
    `delivery_mode` STRING COMMENT 'Method by which the safety program training is delivered to drivers (e.g., classroom, online, blended, on-the-job, simulator-based).. Valid values are `classroom|online|blended|on_the_job|simulator`',
    `effective_end_date` DATE COMMENT 'Date when this driver safety program is scheduled to end or be retired. Null for ongoing programs.',
    `effective_start_date` DATE COMMENT 'Date when this driver safety program becomes active and available for driver enrollment.',
    `enrollment_criteria` STRING COMMENT 'Eligibility requirements and conditions for driver participation in the safety program (e.g., minimum driving hours, incident history, license class).',
    `geographic_scope` STRING COMMENT 'Geographic regions or countries where this safety program is applicable, using ISO 3166-1 alpha-3 country codes (e.g., USA, CAN, DEU, GBR).',
    `harsh_braking_rate_threshold` DECIMAL(18,2) COMMENT 'Maximum acceptable harsh braking rate (events per 100 miles or per trip) as defined by program KPI targets.',
    `language_availability` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes in which this program is available (e.g., EN, ES, FR, DE).',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this driver safety program record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this driver safety program record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when the program content and effectiveness were last reviewed and validated by safety management.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether participation in this safety program is mandatory (true) or voluntary (false) for the applicable driver population.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next program review and update cycle.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score (percentage or points) required to successfully complete the program assessment.',
    `program_code` STRING COMMENT 'Unique business identifier code for the driver safety program used in operational systems and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `program_cost_per_driver` DECIMAL(18,2) COMMENT 'Estimated or actual cost per driver to deliver this safety program, including training materials, instructor time, and certification fees.',
    `program_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for program cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `program_description` STRING COMMENT 'Comprehensive description of the safety program including scope, methodology, expected outcomes, and key learning modules.',
    `program_duration_days` STRING COMMENT 'Standard duration of the safety program measured in days from enrollment to completion.',
    `program_name` STRING COMMENT 'Full descriptive name of the driver safety program (e.g., Defensive Driving Excellence, Fatigue Management Initiative).',
    `program_objectives` STRING COMMENT 'Detailed description of the safety program goals, expected behavioral changes, and target outcomes.',
    `program_owner` STRING COMMENT 'Name or identifier of the business unit, department, or individual responsible for managing and maintaining this safety program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the driver safety program indicating operational state.. Valid values are `draft|active|suspended|completed|archived`',
    `program_type` STRING COMMENT 'Category of safety program defining the primary behavioral or operational focus area.. Valid values are `defensive_driving|fatigue_management|distracted_driving|speed_compliance|load_securing|hazmat_safety`',
    `program_version` STRING COMMENT 'Version number of the safety program content and curriculum (e.g., 1.0, 2.1) for tracking updates and revisions.. Valid values are `^[0-9]+.[0-9]+$`',
    `regulatory_alignment` STRING COMMENT 'Comma-separated list of regulatory frameworks and standards this program aligns with (e.g., DOT, FMCSA, EU Directive 2003/59, OSHA).',
    `seatbelt_compliance_rate_threshold` DECIMAL(18,2) COMMENT 'Minimum required seatbelt compliance rate expressed as a percentage (0-100) for program success criteria.',
    `speeding_events_threshold` DECIMAL(18,2) COMMENT 'Maximum acceptable number of speeding events per trip or per period as defined by the program KPI targets.',
    `target_enrollment_count` STRING COMMENT 'Planned or target number of drivers to be enrolled in this safety program during its active period.',
    `threshold_unit` STRING COMMENT 'Unit of measurement for KPI thresholds (e.g., per trip, per 100 miles, per month).. Valid values are `per_trip|per_100_miles|per_month|per_quarter`',
    `training_provider` STRING COMMENT 'Name of the external or internal organization providing training content and certification for this safety program.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this driver safety program record.',
    CONSTRAINT pk_driver_safety_program PRIMARY KEY(`driver_safety_program_id`)
) COMMENT 'Master record defining Transport Shipping driver safety programs and behavioral safety initiatives. Captures program name, program type (defensive driving, fatigue management, distracted driving, speed compliance, load securing), applicable driver population (long-haul, last-mile, hazmat), program objectives, KPI thresholds (speeding events per trip, harsh braking rate, seatbelt compliance rate), enrollment criteria, program duration, and regulatory alignment (DOT, FMCSA, EU Directive 2003/59). Serves as the program definition master — individual driver participation is tracked in driver_safety_event.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` (
    `driver_safety_event_id` BIGINT COMMENT 'Unique identifier for the driver safety event record. Primary key.',
    `coaching_session_id` BIGINT COMMENT 'Identifier of the coaching session conducted in response to this safety event.',
    `consignment_id` BIGINT COMMENT 'Identifier of the shipment being transported at the time of the event, if applicable.',
    `driver_profile_id` BIGINT COMMENT 'Identifier of the driver involved in the safety event.',
    `driver_safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.driver_safety_program. Business justification: Driver safety events (speeding, harsh braking, etc.) are tracked under specific driver safety programs. This FK links each event to the program context, enabling program-specific event analysis and th',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or fleet manager responsible for reviewing this safety event.',
    `hse_incident_id` BIGINT COMMENT 'Identifier of the formal safety incident record if this event escalated to an incident.',
    `plan_id` BIGINT COMMENT 'Identifier of the route being driven when the safety event occurred.',
    `plan_leg_id` BIGINT COMMENT 'Foreign key linking to route.route_plan_leg. Business justification: Driver safety events (speeding, harsh braking, fatigue alerts) occur during specific legs of multi-leg journeys. Leg-level attribution enables incident investigation, identifies high-risk leg segments',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Safety events involving subcontracted carrier drivers require tracking which carrier employed the driver for coaching accountability, insurance claims, carrier performance scoring, and contract compli',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Harsh braking, speeding, aggressive acceleration directly impact fuel efficiency and emissions. Telematics-based carbon reporting links safety events to emissions variance for driver coaching programs',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Driver safety events (speeding, harsh braking, distraction) occur during specific legs of multi-leg shipments. Leg-level linkage enables route-specific coaching, carrier performance scoring, and insur',
    `telematics_event_id` BIGINT COMMENT 'Reference to the raw telematics event record from which this safety event was derived.',
    `transport_asset_id` BIGINT COMMENT 'Identifier of the vehicle in which the safety event occurred.',
    `related_driver_safety_event_id` BIGINT COMMENT 'Self-referencing FK on driver_safety_event (related_driver_safety_event_id)',
    `coaching_completed_date` DATE COMMENT 'Date when driver coaching was completed for this safety event in format yyyy-MM-dd.',
    `coaching_completed_flag` BOOLEAN COMMENT 'Indicates whether required driver coaching has been completed for this safety event.',
    `coaching_required_flag` BOOLEAN COMMENT 'Indicates whether driver coaching is required as a result of this safety event.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action taken or planned in response to this safety event.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required beyond coaching in response to this safety event.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this safety event record was first created in the system in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dashcam_footage_reference` STRING COMMENT 'Reference identifier or URI to the dashcam video footage captured during the safety event.',
    `driver_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the driver has acknowledged and reviewed the safety event.',
    `driver_acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the driver acknowledged the safety event in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `driver_comment` STRING COMMENT 'Optional comment or explanation provided by the driver regarding the safety event.',
    `event_duration_seconds` STRING COMMENT 'Duration of the safety event in seconds, applicable for sustained behaviors such as speeding or mobile phone use.',
    `event_severity` STRING COMMENT 'Severity classification of the safety event based on risk assessment criteria.. Valid values are `low|medium|high|critical`',
    `event_source` STRING COMMENT 'Source system or method that detected and reported the safety event.. Valid values are `telematics|dashcam|manual_report|adas|driver_app`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the safety event occurred in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_type` STRING COMMENT 'Type of safety behavior event detected. [ENUM-REF-CANDIDATE: harsh_braking|harsh_acceleration|speeding|sharp_cornering|mobile_phone_use|seatbelt_non_compliance|fatigue_alert|lane_departure|distracted_driving|following_too_close|unsafe_lane_change — promote to reference product]. Valid values are `harsh_braking|harsh_acceleration|speeding|sharp_cornering|mobile_phone_use|seatbelt_non_compliance`',
    `g_force_value` DECIMAL(18,2) COMMENT 'Measured gravitational force (g-force) during harsh braking, acceleration, or cornering events.',
    `incident_reported_flag` BOOLEAN COMMENT 'Indicates whether this safety event escalated to a formal safety incident report.',
    `latitude` DECIMAL(18,2) COMMENT 'GPS (Global Positioning System) latitude coordinate where the safety event occurred.',
    `location_description` STRING COMMENT 'Human-readable description of the location where the event occurred (street address, landmark, or route segment).',
    `longitude` DECIMAL(18,2) COMMENT 'GPS (Global Positioning System) longitude coordinate where the safety event occurred.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this safety event record was last modified in the system in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `posted_speed_limit_kph` DECIMAL(18,2) COMMENT 'Legal posted speed limit in kilometers per hour at the location where the event occurred.',
    `preventable_flag` BOOLEAN COMMENT 'Indicates whether the safety event was determined to be preventable by the driver.',
    `road_condition` STRING COMMENT 'Road surface condition at the time and location of the safety event. [ENUM-REF-CANDIDATE: dry|wet|icy|snow_covered|gravel|construction|pothole|debris — promote to reference product]. Valid values are `dry|wet|icy|snow_covered|gravel|construction`',
    `safety_score_impact` DECIMAL(18,2) COMMENT 'Numeric impact of this event on the drivers overall safety score, positive or negative.',
    `speed_over_limit_kph` DECIMAL(18,2) COMMENT 'Amount by which the vehicle speed exceeded the posted speed limit in kilometers per hour, if applicable.',
    `supervisor_comment` STRING COMMENT 'Comment or notes provided by the supervisor during review of the safety event.',
    `supervisor_review_status` STRING COMMENT 'Current status of the supervisors review of this safety event.. Valid values are `pending|reviewed|approved|disputed|closed`',
    `supervisor_review_timestamp` TIMESTAMP COMMENT 'Date and time when the supervisor completed their review of the safety event in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `traffic_condition` STRING COMMENT 'Traffic density condition at the time and location of the safety event.. Valid values are `light|moderate|heavy|congested|stopped`',
    `vehicle_speed_kph` DECIMAL(18,2) COMMENT 'Speed of the vehicle in kilometers per hour at the time of the safety event.',
    `violation_code` STRING COMMENT 'Code identifying the specific policy or regulatory violation associated with this safety event.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether the safety event constitutes a violation of company policy or regulatory requirements.',
    `weather_condition` STRING COMMENT 'Weather condition at the time and location of the safety event. [ENUM-REF-CANDIDATE: clear|rain|snow|fog|ice|wind|storm|hail|sleet — promote to reference product]',
    CONSTRAINT pk_driver_safety_event PRIMARY KEY(`driver_safety_event_id`)
) COMMENT 'Transactional record capturing individual driver safety behavior events detected via telematics, dashcam, or manual reporting. Captures event type (harsh braking, harsh acceleration, speeding, sharp cornering, mobile phone use, seatbelt non-compliance, fatigue alert, lane departure), event severity, GPS coordinates at time of event, vehicle speed, posted speed limit, event duration, dashcam footage reference, coaching required flag, and coaching completion status. Feeds driver safety scoring and behavioral coaching workflows. Distinct from fleet.telematics_event which captures raw IoT telemetry — this is the processed, business-meaningful safety behavior record.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`training` (
    `training_id` BIGINT COMMENT 'Unique identifier for the safety training course record. Primary key.',
    `prerequisite_training_id` BIGINT COMMENT 'Self-referencing FK on training (prerequisite_training_id)',
    `accreditation_body` STRING COMMENT 'Name of the regulatory or industry body that accredits or approves this training course (e.g., IATA, OSHA, National Safety Council).',
    `accreditation_number` STRING COMMENT 'Unique accreditation or approval number issued by the accreditation body for this training course.',
    `certification_issued` BOOLEAN COMMENT 'Indicates whether a formal certificate or credential is issued upon successful completion of this training course.',
    `certification_validity_months` STRING COMMENT 'Number of months the issued certification remains valid before recertification is required. Null if certification does not expire.',
    `competency_assessment_method` STRING COMMENT 'Method used to evaluate participant competency and determine successful completion of the training course. [ENUM-REF-CANDIDATE: written_exam|practical_demonstration|observation|simulation|oral_exam|portfolio|none — 7 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Additional notes regarding regulatory compliance requirements, audit findings, or special instructions related to this training course.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Standard cost per participant for delivering this training course. Includes instructor fees, materials, facility costs, and external vendor charges if applicable.',
    `course_code` STRING COMMENT 'Unique alphanumeric code identifying the training course within the safety management system. Used for course catalog lookups and employee training assignments.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed description of the training course content, learning objectives, and expected outcomes. Used for course catalog display and employee self-service portals.',
    `course_materials_location` STRING COMMENT 'File path, URL, or document management system reference where the training course materials, presentations, and resources are stored.',
    `course_owner` STRING COMMENT 'Name or identifier of the department, role, or individual responsible for maintaining and updating this training course.',
    `course_status` STRING COMMENT 'Current lifecycle status of the training course in the safety management system. Active courses are available for assignment and enrollment.. Valid values are `active|inactive|under_review|retired|draft`',
    `course_title` STRING COMMENT 'Full descriptive title of the safety training course as displayed in the learning management system and training certificates.',
    `course_version` STRING COMMENT 'Version number of the training course content. Incremented when course materials, assessments, or regulatory requirements are updated.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training course record was first created in the safety management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per participant (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Method by which the training course is delivered to participants. Determines scheduling, resource allocation, and completion tracking requirements.. Valid values are `classroom|e_learning|on_the_job|simulation|blended|virtual_instructor_led`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Standard duration of the training course in hours. Used for scheduling, resource planning, and compliance reporting.',
    `effective_date` DATE COMMENT 'Date from which this version of the training course becomes active and available for assignment to employees.',
    `expiration_date` DATE COMMENT 'Date after which this version of the training course is no longer valid and should not be assigned. Null if the course has no expiration.',
    `external_provider_name` STRING COMMENT 'Name of the external training provider or vendor if the course is delivered by a third party. Null if delivered internally.',
    `instructor_qualification_required` STRING COMMENT 'Description of the qualifications, certifications, or experience required for instructors authorized to deliver this training course.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this training is mandatory for specific roles or job functions. True if required by regulation or company policy, False if optional or recommended.',
    `language_offered` STRING COMMENT 'Primary language in which the training course is delivered. Multiple languages may be listed if the course is available in multiple versions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training course record was last updated in the safety management system.',
    `last_review_date` DATE COMMENT 'Date when the training course content was last reviewed for accuracy, regulatory compliance, and alignment with current business practices.',
    `learning_objectives` STRING COMMENT 'Specific, measurable learning objectives that participants will achieve upon successful completion of the training course.',
    `max_participants` STRING COMMENT 'Maximum number of participants allowed per training session. Used for scheduling and resource allocation. Null if no limit applies.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the training course content to ensure continued relevance and compliance.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum score percentage required to successfully complete the training course. Null if no scored assessment is used.',
    `prerequisites` STRING COMMENT 'Description of any prerequisite training courses, certifications, or qualifications required before enrolling in this course.',
    `refresher_frequency_months` STRING COMMENT 'Number of months after which the training must be repeated to maintain compliance and competency. Null if no refresher is required.',
    `regulatory_basis` STRING COMMENT 'Specific regulatory standard, law, or industry requirement that mandates or governs this training (e.g., OSHA 1910.178, IATA DGR Section 1.5, ADR Chapter 8.2, FMCSA Part 395).',
    `subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the training category (e.g., IATA DGR Class 3 Flammable Liquids under Dangerous Goods Handling).',
    `target_audience` STRING COMMENT 'Description of the intended participants for this training course (e.g., all warehouse staff, drivers handling hazardous materials, first-line supervisors, new hires).',
    `training_category` STRING COMMENT 'Primary classification of the training course type. [ENUM-REF-CANDIDATE: induction|dangerous_goods_handling|fire_safety|manual_handling|first_aid|emergency_response|fatigue_management|personal_protective_equipment|forklift_operation|hazmat_awareness|confined_space|fall_protection|lockout_tagout|defensive_driving|incident_investigation|environmental_compliance — promote to reference product]. Valid values are `induction|dangerous_goods_handling|fire_safety|manual_handling|first_aid|emergency_response`',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Master record for HSE safety training courses and programs defined within Transport Shippings safety management system. Captures training course code, course title, training category (induction, DG handling, fire safety, manual handling, first aid, emergency response, fatigue management, PPE), delivery mode (classroom, e-learning, on-the-job, simulation), duration, regulatory requirement basis (OSHA, IATA DGR, ADR, FMCSA), mandatory flag, refresher frequency, and competency assessment method. Distinct from workforce.training_record which tracks individual employee completions — this is the course catalog master.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` (
    `safety_training_completion_id` BIGINT COMMENT 'Unique identifier for the safety training completion record. Primary key for this entity.',
    `facility_id` BIGINT COMMENT 'Reference to the facility, warehouse, or training center where the training was conducted. Nullable for online or remote training.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who completed the training. Links to workforce domain employee master data.',
    `dg_certification_id` BIGINT COMMENT 'Foreign key linking to safety.dg_certification. Business justification: When an employee completes DG training, a dg_certification record is issued. This FK links the training completion event to the resulting certification, enabling audit trail from training → certificat',
    `tertiary_safety_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID or system account that last modified this training completion record. Audit trail field.',
    `training_id` BIGINT COMMENT 'Reference to the HSE safety training course that was completed. Links to safety domain training course catalog.',
    `training_provider_id` BIGINT COMMENT 'Reference to the organization or vendor that delivered the training. May be internal training department or external third-party provider.',
    `retake_safety_training_completion_id` BIGINT COMMENT 'Self-referencing FK on safety_training_completion (retake_safety_training_completion_id)',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the employee on the training assessment or examination, typically expressed as a percentage (0.00 to 100.00).',
    `attendance_hours` DECIMAL(18,2) COMMENT 'Actual hours attended by the employee. May differ from training duration if employee joined late or left early.',
    `certificate_expiry_date` DATE COMMENT 'Date on which the training certificate expires and recertification or refresher training is required. Nullable for non-expiring certifications.',
    `certificate_issue_date` DATE COMMENT 'Date on which the training certificate was officially issued to the employee.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion of the training. Used for audit and verification purposes.',
    `completion_date` DATE COMMENT 'The date on which the employee successfully completed the training course. This is the principal business event timestamp for this transaction.',
    `completion_status` STRING COMMENT 'Current lifecycle status of the training completion record indicating whether the employee passed, failed, did not complete, was granted a waiver, or the certification has expired.. Valid values are `passed|failed|incomplete|waived|expired`',
    `compliance_status` STRING COMMENT 'Current compliance state of the employee relative to this training requirement. Compliant indicates valid certification; overdue indicates expired or missing; expiring-soon indicates approaching expiry within the warning window.. Valid values are `compliant|overdue|expiring_soon|not_applicable`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this training completion, including course fees, materials, travel, and instructor costs. Expressed in the companys reporting currency.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was first created in the system. Audit trail field.',
    `dangerous_goods_category` STRING COMMENT 'Specific dangerous goods category or class covered by this training (e.g., Class 1 Explosives, Class 3 Flammable Liquids, Class 9 Miscellaneous). Applicable only to DG handling training.',
    `delivery_location_name` STRING COMMENT 'Name of the facility, warehouse, or training center where the training was conducted.',
    `delivery_method` STRING COMMENT 'Method by which the training was delivered to the employee (classroom instruction, online e-learning, blended approach, on-the-job training, or simulation-based training).. Valid values are `classroom|online|blended|on_the_job|simulation`',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who delivered the training session.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was last updated. Audit trail field.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or special circumstances related to this training completion (e.g., accommodations provided, remedial actions required, exceptional performance).',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment at the time of completion. Captured to preserve historical pass/fail criteria.',
    `recertification_interval_months` STRING COMMENT 'Number of months between required recertification or refresher training sessions. Nullable if recertification is not required.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether periodic recertification or refresher training is required (True) or if this is a one-time training (False).',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or governing body that mandates this training (e.g., OSHA, IATA, IMO, DOT). Nullable for non-regulatory training.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this training is mandated by regulatory or legal requirements (True) or is voluntary/recommended (False).',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training course in hours, including instruction, assessment, and practical exercises.',
    `training_language` STRING COMMENT 'Language in which the training was delivered, using ISO 639-1 two-letter language codes (e.g., EN for English, ES for Spanish, FR for French).',
    `training_start_date` DATE COMMENT 'Date on which the employee began the training course. May differ from completion date for multi-day or self-paced courses.',
    CONSTRAINT pk_safety_training_completion PRIMARY KEY(`safety_training_completion_id`)
) COMMENT 'Transactional record capturing individual employee completions of HSE safety training courses. Captures employee reference, training course reference, completion date, assessment score, pass/fail outcome, certificate number, certificate expiry date, training provider, delivery location, and compliance status (compliant, overdue, expiring-soon). Distinct from workforce.training_record which covers all workforce training broadly — this entity is owned by the safety domain and specifically tracks regulatory and HSE-mandated training compliance, including DG handling, emergency response, and OSHA-required programs.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` (
    `emergency_response_plan_id` BIGINT COMMENT 'Unique identifier for the emergency response plan record. Primary key.',
    `facility_id` BIGINT COMMENT 'Identifier of the Transport Shipping facility (warehouse, terminal, depot, office) covered by this emergency response plan.',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Service corridors crossing hazardous regions (conflict zones, extreme weather, hazmat routes, remote areas) require corridor-specific emergency response plans. Real business process: corridor risk man',
    `superseded_emergency_response_plan_id` BIGINT COMMENT 'Self-referencing FK on emergency_response_plan (superseded_emergency_response_plan_id)',
    `activation_trigger` STRING COMMENT 'Specific conditions or events that trigger the activation of this emergency response plan.',
    `approval_date` DATE COMMENT 'Date when the emergency response plan was officially approved by management or regulatory authority.',
    `approved_by_name` STRING COMMENT 'Full name of the manager or authority who officially approved this emergency response plan.',
    `approved_by_title` STRING COMMENT 'Job title or role of the person who approved this emergency response plan (e.g., Safety Director, Operations Manager).',
    `backup_coordinator_name` STRING COMMENT 'Full name of the backup or alternate emergency coordinator who assumes responsibility if the primary coordinator is unavailable.',
    `backup_coordinator_phone` STRING COMMENT 'Contact phone number for the backup emergency coordinator.',
    `communication_cascade_procedure` STRING COMMENT 'Documented procedure outlining the sequence and method for notifying personnel, management, and external agencies during an emergency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency response plan record was first created in the system.',
    `deactivation_criteria` STRING COMMENT 'Conditions or criteria that must be met before the emergency response plan can be deactivated and normal operations resumed.',
    `drill_frequency` STRING COMMENT 'Required frequency for conducting emergency drills to test and validate the effectiveness of this emergency response plan.. Valid values are `monthly|quarterly|semi_annual|annual|as_needed`',
    `effective_from_date` DATE COMMENT 'Date from which the emergency response plan becomes operationally active and enforceable.',
    `emergency_coordinator_email` STRING COMMENT 'Email address of the emergency coordinator for plan-related communications and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_coordinator_name` STRING COMMENT 'Full name of the designated emergency coordinator responsible for executing this emergency response plan.',
    `emergency_coordinator_phone` STRING COMMENT 'Primary contact phone number for the emergency coordinator, available 24/7 for emergency activation.',
    `evacuation_assembly_point` STRING COMMENT 'Designated safe location where personnel must assemble during an evacuation, including address or GPS coordinates.',
    `expiry_date` DATE COMMENT 'Date when the emergency response plan expires and must be renewed or replaced, if applicable.',
    `fire_brigade_contact` STRING COMMENT 'Contact details (name, phone, station) for the local fire brigade or fire department that responds to emergencies at this facility.',
    `geographic_scope` STRING COMMENT 'Geographic area or region covered by this emergency response plan (e.g., single facility, multi-site, regional corridor).',
    `hazmat_team_contact` STRING COMMENT 'Contact details for the specialized HAZMAT response team or contractor responsible for chemical spill and dangerous goods incidents.',
    `hospital_contact` STRING COMMENT 'Contact details (name, address, phone) for the nearest hospital or medical facility designated for emergency medical response.',
    `last_drill_date` DATE COMMENT 'Date when the most recent emergency drill or simulation exercise was conducted for this plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency response plan record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when the emergency response plan was last reviewed and validated by the safety team or management.',
    `next_drill_date` DATE COMMENT 'Scheduled date for the next emergency drill or simulation exercise to test this emergency response plan.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review and update of the emergency response plan to ensure continued compliance and relevance.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this emergency response plan.',
    `plan_document_url` STRING COMMENT 'URL or file path to the full emergency response plan document stored in the document management system.. Valid values are `^https?://.*$`',
    `plan_name` STRING COMMENT 'Descriptive name of the emergency response plan for identification and reference purposes.',
    `plan_number` STRING COMMENT 'Business identifier for the emergency response plan, externally referenced in safety documentation and regulatory filings.. Valid values are `^ERP-[A-Z0-9]{6,12}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the emergency response plan indicating its approval and operational state.. Valid values are `draft|under_review|approved|active|suspended|archived`',
    `plan_type` STRING COMMENT 'Classification of the emergency scenario covered by this plan: fire evacuation, chemical spill, dangerous goods (DG) incident, natural disaster, security threat, or pandemic response.. Valid values are `fire_evacuation|chemical_spill|dg_incident|natural_disaster|security_threat|pandemic`',
    `plan_version` STRING COMMENT 'Version number of the emergency response plan document, incremented with each revision or update.. Valid values are `^v?[0-9]+.[0-9]+(.[0-9]+)?$`',
    `police_contact` STRING COMMENT 'Contact details for local police or security authorities to be notified in case of security threats or criminal incidents.',
    `regulatory_compliance_basis` STRING COMMENT 'List of regulatory standards, codes, and legal requirements that this emergency response plan is designed to comply with (e.g., OSHA 29 CFR 1910.38, SEVESO III, local fire codes).',
    `risk_level` STRING COMMENT 'Assessed risk level of the emergency scenario covered by this plan, based on likelihood and potential impact.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Detailed description of the operational scope, geographic area, transport corridors, or business units covered by this emergency response plan.',
    `secondary_assembly_point` STRING COMMENT 'Alternate safe assembly location to be used if the primary evacuation assembly point is inaccessible or unsafe.',
    `special_equipment_required` STRING COMMENT 'List of specialized equipment, tools, or resources required to execute this emergency response plan (e.g., fire extinguishers, spill kits, personal protective equipment).',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether personnel training is mandatory for this emergency response plan (True) or not (False).',
    CONSTRAINT pk_emergency_response_plan PRIMARY KEY(`emergency_response_plan_id`)
) COMMENT 'Master record for emergency response plans (ERPs) maintained for Transport Shipping facilities, transport corridors, and operational scenarios. Captures plan type (fire evacuation, chemical spill, DG incident, natural disaster, security threat, pandemic), facility or scope covered, plan version, approval date, next review date, emergency coordinator, external agency contacts (fire brigade, HAZMAT team, hospital), evacuation assembly points, communication cascade procedure, and regulatory compliance basis (OSHA 29 CFR 1910.38, SEVESO III, local fire codes). Serves as the authoritative ERP register.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` (
    `emergency_drill_id` BIGINT COMMENT 'Unique identifier for the emergency drill record. Primary key.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to safety.emergency_response_plan. Business justification: Emergency drills test specific emergency response plans. This FK links each drill execution to the ERP being tested, enabling tracking of drill frequency per plan and verification of regulatory compli',
    `facility_id` BIGINT COMMENT 'Reference to the Transport Shipping facility where the emergency drill was conducted (warehouse, distribution center, terminal, office, or operational site).',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for planning, organizing, and executing the emergency drill. Typically a facility safety manager, HSE (Health, Safety, and Environment) coordinator, or designated emergency response team leader.',
    `tertiary_emergency_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the system user or employee who last modified this emergency drill record. Used for audit trail and accountability.',
    `followup_emergency_drill_id` BIGINT COMMENT 'Self-referencing FK on emergency_drill (followup_emergency_drill_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency drill record was first created in the system. Used for audit trail and data lineage.',
    `deficiencies_identified` STRING COMMENT 'Detailed list of deficiencies, gaps, or failures observed during the drill, such as blocked egress routes, malfunctioning alarms, inadequate communication, delayed response times, missing equipment, or personnel not following procedures.',
    `drill_announcement_type` STRING COMMENT 'Indicates whether participants were notified in advance of the drill (announced) or the drill was conducted without prior warning (unannounced). Unannounced drills provide a more realistic assessment of emergency preparedness.. Valid values are `announced|unannounced`',
    `drill_date` DATE COMMENT 'Calendar date on which the emergency drill was conducted. This is the principal business event date for the drill.',
    `drill_duration_minutes` STRING COMMENT 'Total elapsed time in minutes from drill start to drill end, calculated as the difference between drill_end_time and drill_start_time.',
    `drill_end_time` TIMESTAMP COMMENT 'Timestamp when the emergency drill scenario was concluded and all-clear was given.',
    `drill_number` STRING COMMENT 'Business identifier for the emergency drill, typically assigned by the facility safety coordinator or HSE (Health, Safety, and Environment) management system.',
    `drill_outcome` STRING COMMENT 'Overall assessment of the drill performance. Successful indicates all objectives were met without significant issues; successful with deficiencies indicates objectives were met but corrective actions are required; unsuccessful indicates critical failures or objectives not met; aborted indicates drill was terminated early due to safety concerns or operational issues.. Valid values are `successful|successful_with_deficiencies|unsuccessful|aborted`',
    `drill_report_document_url` STRING COMMENT 'URL or file path to the formal drill report document, which includes detailed observations, performance metrics, photographs, and recommendations. Used for audit trail and regulatory compliance documentation.',
    `drill_start_time` TIMESTAMP COMMENT 'Timestamp when the emergency drill scenario was initiated (e.g., alarm activation, announcement, or simulated incident trigger).',
    `drill_status` STRING COMMENT 'Current lifecycle state of the emergency drill event. Scheduled indicates planned but not yet executed; in progress indicates drill is actively underway; completed indicates drill has concluded and evaluation is finalized; cancelled indicates drill was called off; postponed indicates drill was rescheduled to a future date.. Valid values are `scheduled|in_progress|completed|cancelled|postponed`',
    `drill_type` STRING COMMENT 'Category of emergency scenario being drilled. Fire evacuation tests building egress procedures; DG (Dangerous Goods) spill response tests hazardous material containment; lockdown tests security protocols; medical emergency tests first aid and EMS (Emergency Medical Services) response; natural disaster tests earthquake, flood, or severe weather procedures; active shooter tests threat response; hazmat incident tests chemical or biological hazard protocols. [ENUM-REF-CANDIDATE: fire_evacuation|dg_spill_response|lockdown|medical_emergency|natural_disaster|active_shooter|hazmat_incident — 7 candidates stripped; promote to reference product]',
    `evacuation_time_achieved_minutes` DECIMAL(18,2) COMMENT 'Actual time in minutes required to evacuate all personnel from the facility or affected area to the designated assembly point. Applicable to fire evacuation and natural disaster drills.',
    `evacuation_time_target_minutes` DECIMAL(18,2) COMMENT 'Target or benchmark evacuation time in minutes established by facility safety plan, regulatory requirement, or industry best practice. Used to assess whether the drill met performance expectations.',
    `evacuation_time_variance_minutes` DECIMAL(18,2) COMMENT 'Difference between evacuation_time_achieved_minutes and evacuation_time_target_minutes. Positive values indicate the drill exceeded the target time; negative values indicate the drill was completed faster than the target.',
    `external_agency_name` STRING COMMENT 'Name of the external emergency response agency or agencies that participated in or observed the drill (e.g., local fire department, county EMS, police department, hazmat response team).',
    `external_agency_participation_flag` BOOLEAN COMMENT 'Indicates whether external emergency response agencies (fire department, EMS, police, hazmat team) participated in or observed the drill. True if external agencies were involved; false if drill was conducted internally only.',
    `follow_up_actions_required` STRING COMMENT 'List of corrective actions, remediation tasks, or process improvements that must be implemented as a result of the drill findings. May include equipment repairs, procedure updates, additional training, or facility modifications.',
    `follow_up_due_date` DATE COMMENT 'Target date by which all follow-up actions must be completed and verified. Used to track corrective action closure and ensure timely remediation of deficiencies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency drill record was last updated. Used for audit trail and change tracking.',
    `lessons_learned` STRING COMMENT 'Summary of key insights, best practices, and improvement opportunities identified from the drill. Used to inform future training, update emergency response plans, and enhance preparedness.',
    `next_drill_scheduled_date` DATE COMMENT 'Planned date for the next emergency drill of the same type at this facility. Used to ensure compliance with periodic drill frequency requirements (e.g., quarterly, semi-annual, annual).',
    `participant_count` STRING COMMENT 'Total number of employees, contractors, and visitors who participated in the emergency drill. Used to measure drill coverage and compliance with mandatory participation requirements.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the drill satisfies applicable regulatory requirements for periodic emergency preparedness testing (e.g., OSHA 29 CFR 1910.38, SEVESO III Directive, local fire authority mandates). True if compliant; false if non-compliant or additional drills are required.',
    `scenario_description` STRING COMMENT 'Detailed narrative of the simulated emergency scenario used for the drill, including the nature of the incident, location within the facility, and any special conditions or complications introduced to test response capabilities.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of the drill (e.g., clear, rain, snow, high wind, extreme heat, extreme cold). Weather can impact evacuation times and response effectiveness.',
    CONSTRAINT pk_emergency_drill PRIMARY KEY(`emergency_drill_id`)
) COMMENT 'Transactional record capturing emergency response drill and exercise events conducted at Transport Shipping facilities. Captures drill type (fire evacuation, DG spill response, lockdown, medical emergency), facility, drill date, duration, number of participants, scenario description, drill coordinator, observer/evaluator, evacuation time achieved vs. target, deficiencies identified, lessons learned, and follow-up actions raised. Supports regulatory compliance with OSHA, SEVESO III, and local fire authority requirements for periodic emergency preparedness testing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`hazard_register` (
    `hazard_register_id` BIGINT COMMENT 'Unique identifier for the hazard register entry. Primary key for the hazard register master record.',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Hazardous material storage (fuel depots, battery storage, refrigerants) requires emissions factors for quantitative risk assessment. Fire risk modeling, explosion consequence analysis, and environment',
    `facility_id` BIGINT COMMENT 'Identifier of the facility, warehouse, terminal, or operational site where the hazard is present.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager responsible for implementing and maintaining the control measures for this hazard.',
    `route_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to route.route_delivery_zone. Business justification: Delivery zones have inherent hazards: high-crime areas, difficult terrain, animal risks, extreme weather exposure. Hazard register must capture zone-level risks for last-mile driver safety, route plan',
    `tertiary_hazard_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified this hazard register entry.',
    `parent_hazard_register_id` BIGINT COMMENT 'Self-referencing FK on hazard_register (parent_hazard_register_id)',
    `activity_or_process` STRING COMMENT 'The specific operational activity, work process, or task during which the hazard exists or may be encountered by workers or the public.',
    `affected_worker_count` STRING COMMENT 'Estimated number of workers or personnel who may be exposed to this hazard during normal operations.',
    `control_effectiveness` STRING COMMENT 'Assessment of how effective the existing controls are in reducing the risk, rated from ineffective to highly effective.. Valid values are `ineffective|partially_effective|effective|highly_effective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hazard register record was first created in the system.',
    `dangerous_goods_related_flag` BOOLEAN COMMENT 'Boolean indicator of whether the hazard is related to the handling, storage, or transport of dangerous goods or hazardous materials.',
    `emergency_response_procedure` STRING COMMENT 'Reference to or description of the emergency response procedure to be followed if the hazard is realized or an incident occurs.',
    `existing_controls` STRING COMMENT 'Description of the current control measures, safeguards, or mitigation strategies in place to manage or reduce the hazard risk.',
    `hazard_category` STRING COMMENT 'Primary classification of the hazard type: physical (machinery, noise, temperature), chemical (substances, fumes), biological (pathogens, allergens), ergonomic (repetitive strain, manual handling), psychosocial (stress, violence), or environmental (pollution, emissions).. Valid values are `physical|chemical|biological|ergonomic|psychosocial|environmental`',
    `hazard_description` STRING COMMENT 'Detailed description of the hazard including the nature of the danger, potential harm, and circumstances under which the hazard may be realized.',
    `hazard_reference_number` STRING COMMENT 'Business-facing unique reference number for the hazard entry, used for tracking and communication across operational sites.. Valid values are `^HAZ-[A-Z0-9]{6,12}$`',
    `hazard_status` STRING COMMENT 'Current lifecycle status of the hazard register entry indicating whether the hazard is active, has been mitigated, closed, under review, or pending corrective action.. Valid values are `active|mitigated|closed|under_review|pending_action`',
    `hazard_subcategory` STRING COMMENT 'Secondary or more granular classification of the hazard within its primary category, providing additional specificity for risk management.',
    `hazard_title` STRING COMMENT 'Short descriptive title or name of the identified hazard for quick reference and reporting.',
    `identification_date` DATE COMMENT 'Date when the hazard was first identified and recorded in the register.',
    `incident_history_count` STRING COMMENT 'Number of recorded incidents or near-misses associated with this specific hazard, providing historical context for risk assessment.',
    `inherent_consequence` STRING COMMENT 'Severity rating of the potential consequence or impact if the hazard is realized without controls, ranging from insignificant to catastrophic.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `inherent_likelihood` STRING COMMENT 'Likelihood rating of the hazard occurring in the absence of any controls, using a qualitative scale from rare to almost certain.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `inherent_risk_rating` STRING COMMENT 'Overall inherent risk level calculated from likelihood and consequence before any controls are applied, categorized as low, medium, high, or extreme.. Valid values are `low|medium|high|extreme`',
    `inherent_risk_score` STRING COMMENT 'Numerical risk score representing the inherent risk level, typically calculated as likelihood multiplied by consequence on a defined scale.',
    `last_assessment_date` DATE COMMENT 'Date when the hazard risk assessment was most recently reviewed or updated.',
    `last_incident_date` DATE COMMENT 'Date of the most recent incident or near-miss event related to this hazard, if any have occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hazard register record was last updated or modified.',
    `location_description` STRING COMMENT 'Detailed description of the physical location within the facility or site where the hazard exists, including building, floor, zone, or equipment reference.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the hazard and its controls to ensure continued effectiveness and relevance.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the hazard, its assessment, or control measures.',
    `ppe_required` STRING COMMENT 'Description of the personal protective equipment required when working in the presence of this hazard, such as gloves, respirators, safety glasses, or protective clothing.',
    `public_exposure_flag` BOOLEAN COMMENT 'Boolean indicator of whether the hazard may also affect members of the public, customers, or visitors in addition to employees.',
    `recommended_actions` STRING COMMENT 'Description of recommended additional control measures, corrective actions, or risk treatment strategies to further reduce the residual risk.',
    `regulatory_requirement` STRING COMMENT 'Reference to specific regulatory requirements, OSHA standards, IATA regulations, IMO codes, or other legal obligations related to this hazard.',
    `residual_consequence` STRING COMMENT 'Severity rating of the potential consequence after existing controls have been applied, using the same scale as inherent consequence.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `residual_likelihood` STRING COMMENT 'Likelihood rating of the hazard occurring after existing controls have been applied, using the same qualitative scale as inherent likelihood.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `residual_risk_rating` STRING COMMENT 'Overall residual risk level after controls are applied, categorized as low, medium, high, or extreme, representing the remaining risk exposure.. Valid values are `low|medium|high|extreme`',
    `residual_risk_score` STRING COMMENT 'Numerical risk score representing the residual risk level after controls, calculated using the same methodology as inherent risk score.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of this hazard entry, based on risk level and organizational policy.',
    `risk_acceptability` STRING COMMENT 'Determination of whether the residual risk level is acceptable to the organization, tolerable with monitoring, or unacceptable requiring further action.. Valid values are `acceptable|tolerable|unacceptable`',
    `risk_treatment_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether additional risk treatment or control measures are required to bring the residual risk to an acceptable level.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the dangerous goods substance associated with this hazard, if applicable.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_hazard_register PRIMARY KEY(`hazard_register_id`)
) COMMENT 'Master record for the formal hazard and risk register maintained across Transport Shipping operational sites and activities. Captures hazard description, hazard category (physical, chemical, biological, ergonomic, psychosocial, environmental), activity or process where hazard exists, location, inherent risk rating (likelihood × consequence), existing controls in place, residual risk rating after controls, risk acceptability determination, control owner, and review date. Serves as the SSOT for operational risk identification under ISO 45001 Clause 6.1 hazard identification and risk assessment.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the risk assessment record. Primary key.',
    `facility_id` BIGINT COMMENT 'Identifier for the facility, warehouse, terminal, or operational site where the assessed activity takes place. Null if assessment is not facility-specific.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: High-value, hazmat, oversized, or complex freight requires pre-transport risk assessment for safety planning, routing decisions, and special handling procedures. Links risk assessment to specific ship',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Risk assessments are conducted to evaluate specific hazards identified in the hazard register. This FK links the formal risk assessment to the hazard register entry it evaluates, enabling traceability',
    `plan_id` BIGINT COMMENT 'Identifier for the transportation route being assessed. Applicable for route-specific risk assessments. Null if not route-related.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the individual who conducted the risk assessment. Links to workforce records.',
    `superseded_by_assessment_risk_assessment_id` BIGINT COMMENT 'Identifier of the risk assessment that supersedes this one. Used to track assessment lineage when a new assessment replaces an older one. Null if not superseded.',
    `transport_asset_id` BIGINT COMMENT 'Identifier for the vehicle or fleet asset involved in the assessed activity. Null if assessment is not vehicle-specific.',
    `superseded_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on risk_assessment (superseded_risk_assessment_id)',
    `approval_authority_name` STRING COMMENT 'Full name of the individual with authority to approve the risk assessment. Typically an HSE manager, operations manager, or senior leader.',
    `approval_date` DATE COMMENT 'Date when the risk assessment was formally approved by the designated authority. Null if not yet approved.',
    `assessment_date` DATE COMMENT 'Date when the formal risk assessment was conducted. Represents the point-in-time evaluation event.',
    `assessment_number` STRING COMMENT 'Business-facing unique identifier or reference number for the risk assessment, used for tracking and communication purposes.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment. Tracks progression from draft through review, approval, and eventual expiration or supersession.. Valid values are `draft|in_review|approved|rejected|expired|superseded`',
    `assessment_team_members` STRING COMMENT 'List or description of team members who participated in the risk assessment. May include subject matter experts, supervisors, and frontline workers.',
    `assessment_type` STRING COMMENT 'Category of risk assessment conducted. Defines the scope and methodology applied (e.g., Job Safety Analysis for specific tasks, Change Management Risk Assessment for operational changes, New Facility Risk Assessment for site evaluations).. Valid values are `job_safety_analysis|task_risk_assessment|change_management_risk_assessment|new_facility_risk_assessment|route_risk_assessment|hazmat_transport_risk_assessment`',
    `assessor_name` STRING COMMENT 'Full name of the individual who conducted or led the risk assessment. May be an HSE specialist, supervisor, or qualified team member.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations related to the risk assessment. Provides supplementary context or clarifications.',
    `consultation_with_workers_flag` BOOLEAN COMMENT 'Indicates whether workers or their representatives were consulted during the risk assessment process. Required by ISO 45001 and many jurisdictions. True if consultation occurred.',
    `control_hierarchy_applied` STRING COMMENT 'The level of the hierarchy of controls applied to mitigate the identified risk. Follows the standard hierarchy: Elimination, Substitution, Engineering Controls, Administrative Controls, Personal Protective Equipment (PPE).. Valid values are `elimination|substitution|engineering_controls|administrative_controls|ppe`',
    `control_measures_recommended` STRING COMMENT 'Detailed description of control measures, safeguards, or mitigation actions recommended to reduce risk. May include engineering controls, administrative controls, and personal protective equipment (PPE).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was first created in the system. Part of audit trail.',
    `dangerous_goods_involved_flag` BOOLEAN COMMENT 'Indicates whether the assessed activity involves handling, transporting, or storing dangerous goods or hazardous materials. True if dangerous goods are involved.',
    `emergency_response_plan_required_flag` BOOLEAN COMMENT 'Indicates whether the assessed activity requires a formal emergency response plan due to the nature or severity of identified risks. True if emergency response planning is required.',
    `environmental_impact_description` STRING COMMENT 'Description of potential environmental impacts identified during the risk assessment. Null if no environmental impacts are identified.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the assessed activity has potential environmental impacts (e.g., spills, emissions, waste generation). True if environmental impacts are identified.',
    `hazards_identified` STRING COMMENT 'Comprehensive list or description of all hazards identified during the risk assessment. May include physical, chemical, biological, ergonomic, and psychosocial hazards.',
    `hazmat_un_number` STRING COMMENT 'Four-digit UN number identifying the specific dangerous goods or hazardous material involved in the assessed activity. Null if no dangerous goods are involved.. Valid values are `^UN[0-9]{4}$`',
    `inherent_likelihood` STRING COMMENT 'Probability or frequency of the hazard occurring before controls are applied. Part of the inherent risk calculation.. Valid values are `almost_certain|likely|possible|unlikely|rare`',
    `inherent_risk_level` STRING COMMENT 'Risk level before any control measures are applied. Represents the raw or unmitigated risk exposure.. Valid values are `critical|high|medium|low|negligible`',
    `inherent_severity` STRING COMMENT 'Potential consequence or impact of the hazard before controls are applied. Part of the inherent risk calculation.. Valid values are `catastrophic|major|moderate|minor|insignificant`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was last modified. Part of audit trail.',
    `location_description` STRING COMMENT 'Free-text description of the specific location or area where the assessed activity occurs. Provides additional geographic or operational context beyond facility/route identifiers.',
    `ppe_required` STRING COMMENT 'Description of personal protective equipment required for the assessed activity. May include hard hats, safety glasses, gloves, respirators, high-visibility clothing, etc.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the risk assessment was conducted to meet specific regulatory or compliance requirements (e.g., OSHA, IMO, IATA). True if regulatory-driven.',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the specific regulation, standard, or compliance requirement that mandates or guides this risk assessment (e.g., OSHA 29 CFR 1910.119, ISO 45001).',
    `residual_likelihood` STRING COMMENT 'Probability or frequency of the hazard occurring after controls are applied. Part of the residual risk calculation.. Valid values are `almost_certain|likely|possible|unlikely|rare`',
    `residual_risk_level` STRING COMMENT 'Risk level after recommended control measures are implemented. Represents the mitigated or remaining risk exposure.. Valid values are `critical|high|medium|low|negligible`',
    `residual_severity` STRING COMMENT 'Potential consequence or impact of the hazard after controls are applied. Part of the residual risk calculation.. Valid values are `catastrophic|major|moderate|minor|insignificant`',
    `review_due_date` DATE COMMENT 'Scheduled date for the next review or re-assessment of this risk assessment. Ensures periodic validation and updates to reflect changing conditions.',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which this risk assessment should be reviewed. Common values include 6, 12, or 24 months depending on risk level and regulatory requirements.',
    `risk_acceptable_flag` BOOLEAN COMMENT 'Indicates whether the residual risk level is deemed acceptable according to organizational risk tolerance criteria. True if acceptable, False if further mitigation is required.',
    `risk_rating_methodology` STRING COMMENT 'The methodology or framework used to evaluate and rate risks. Common methods include risk matrices (likelihood x severity), Failure Mode and Effects Analysis (FMEA), Hazard and Operability Study (HAZOP), or Bow-Tie Analysis.. Valid values are `risk_matrix_5x5|risk_matrix_3x3|quantitative_analysis|bow_tie_analysis|fmea|hazop`',
    `scope_description` STRING COMMENT 'Detailed description of the task, activity, project, operational change, or facility being assessed. Defines boundaries and context for the risk evaluation.',
    `training_description` STRING COMMENT 'Description of the training required for personnel involved in the assessed activity. Null if no training is required.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether specific training is required for personnel involved in the assessed activity to mitigate identified risks. True if training is required.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Transactional record for formal risk assessments conducted for specific tasks, activities, projects, or operational changes at Transport Shipping. Captures assessment type (job safety analysis, task risk assessment, change management risk assessment, new facility risk assessment), scope description, assessment date, assessor, hazards identified, risk rating methodology, control measures recommended, residual risk level, approval authority, and approval date. Distinct from hazard_register which is the ongoing register — risk_assessment captures the formal point-in-time evaluation event.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` (
    `ppe_issuance_id` BIGINT COMMENT 'Unique identifier for the PPE issuance transaction record.',
    `facility_id` BIGINT COMMENT 'Identifier of the Transport Shipping facility where the PPE was issued.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: PPE issuance is driven by hazard register requirements (e.g., hazard requires respirator, so respirator is issued). This FK links PPE issuance to the specific hazard it protects against, supporting ha',
    `employee_id` BIGINT COMMENT 'Identifier of the Transport Shipping employee receiving the PPE.',
    `replacement_ppe_issuance_id` BIGINT COMMENT 'Self-referencing FK on ppe_issuance (replacement_ppe_issuance_id)',
    `acknowledgment_signature_flag` BOOLEAN COMMENT 'Indicates whether the receiving employee provided a signature or electronic acknowledgment confirming receipt of the PPE.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the employee acknowledged receipt of the PPE.',
    `certification_standard` STRING COMMENT 'Safety certification standard or regulatory compliance mark that the PPE item meets (e.g., ANSI Z87.1, EN 397, CSA Z94.1).',
    `compliance_requirement_met` BOOLEAN COMMENT 'Indicates whether this PPE issuance fulfills a mandatory safety compliance requirement for the employees role and work area.',
    `condition_at_issue` STRING COMMENT 'Physical condition of the PPE item at the time of issuance to the employee.. Valid values are `new|good|acceptable|refurbished`',
    `cost_center` STRING COMMENT 'Organizational cost center to which the PPE issuance cost is allocated.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the PPE cost amounts.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the PPE issuance record was first created in the system.',
    `employee_role` STRING COMMENT 'Job role or position of the employee at time of issuance, used to validate PPE requirement compliance.',
    `expected_replacement_date` DATE COMMENT 'Anticipated date when the PPE item should be replaced based on manufacturer guidelines, usage patterns, or regulatory requirements.',
    `expiration_date` DATE COMMENT 'Manufacturer-specified expiration or end-of-life date for the PPE item, after which it must not be used.',
    `fit_test_date` DATE COMMENT 'Date when the employee completed a fit test for the issued PPE, if required.',
    `fit_test_required_flag` BOOLEAN COMMENT 'Indicates whether the issued PPE (e.g., respirator) requires a fit test to ensure proper seal and protection.',
    `fit_test_result` STRING COMMENT 'Outcome of the fit test conducted for the issued PPE.. Valid values are `pass|fail|not_applicable`',
    `issuance_number` STRING COMMENT 'Business-readable unique reference number for the PPE issuance transaction, used for tracking and audit purposes.',
    `issuance_reason` STRING COMMENT 'Business reason or trigger for issuing the PPE to the employee.. Valid values are `new_hire|replacement|additional|seasonal|special_project|lost_damaged`',
    `issuance_status` STRING COMMENT 'Current lifecycle status of the PPE issuance record.. Valid values are `issued|returned|lost|damaged|expired`',
    `issue_date` DATE COMMENT 'Date when the PPE was issued to the employee.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise date and time when the PPE issuance transaction was completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the PPE issuance record was last updated in the system.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer or brand of the PPE item issued.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the PPE issuance, including special circumstances, damage reports, or employee feedback.',
    `ppe_item_code` STRING COMMENT 'Stock Keeping Unit (SKU) or catalog code identifying the specific PPE item issued from inventory.',
    `ppe_item_description` STRING COMMENT 'Detailed description of the PPE item including brand, model, size, and specifications.',
    `ppe_type` STRING COMMENT 'Category of PPE issued to the employee. [ENUM-REF-CANDIDATE: hard_hat|high_visibility_vest|safety_boots|gloves|respirator|hearing_protection|eye_protection|fall_arrest_harness|face_shield|protective_coverall — promote to reference product]. Valid values are `hard_hat|high_visibility_vest|safety_boots|gloves|respirator|hearing_protection`',
    `quantity_issued` STRING COMMENT 'Number of PPE units issued to the employee in this transaction.',
    `return_condition` STRING COMMENT 'Physical condition of the PPE item when returned by the employee.. Valid values are `good|worn|damaged|lost|destroyed`',
    `return_date` DATE COMMENT 'Date when the PPE item was returned by the employee, if applicable (e.g., upon role change, termination, or equipment replacement).',
    `serial_number` STRING COMMENT 'Unique serial number or asset tag of the individual PPE item for tracking and recall purposes.',
    `size` STRING COMMENT 'Size specification of the PPE item issued to ensure proper fit and protection.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the PPE issuance transaction (quantity issued multiplied by unit cost).',
    `training_completed_flag` BOOLEAN COMMENT 'Indicates whether the employee has completed required training on proper use, maintenance, and limitations of the issued PPE.',
    `training_completion_date` DATE COMMENT 'Date when the employee completed the required PPE training associated with this issuance.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the PPE item issued, used for inventory valuation and cost tracking.',
    `work_area` STRING COMMENT 'Primary work area or operational zone where the employee is assigned, determining PPE requirements.',
    CONSTRAINT pk_ppe_issuance PRIMARY KEY(`ppe_issuance_id`)
) COMMENT 'Transactional record tracking the issuance of Personal Protective Equipment (PPE) to Transport Shipping employees. Captures PPE type (hard hat, high-visibility vest, safety boots, gloves, respirator, hearing protection, eye protection, fall arrest harness), PPE item reference, employee recipient, issue date, quantity issued, condition at issue, expected replacement date, return date, and compliance with PPE requirement for the employees role and work area. Supports PPE inventory management and regulatory compliance with OSHA 29 CFR 1910.132 and equivalent standards.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`observation` (
    `observation_id` BIGINT COMMENT 'Unique identifier for the safety observation record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Safety observations during shipment handling (unsafe loading, improper DG labeling, PPE non-compliance) need shipment context for customer feedback, corrective action tracking, and trend analysis by c',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the observation occurred, if applicable. Links to the facility master in the warehouse domain. Null if observation was not at a fixed facility.',
    `hse_incident_id` BIGINT COMMENT 'Identifier of a related HSE incident record if this observation later resulted in an actual incident. Links to the hse_incident product in the safety domain. Null if no incident occurred.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned as the owner of the corrective action. Links to the employee master in the workforce domain. Null if no action is required or not yet assigned.',
    `observation_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified the observation record. Links to the employee master in the workforce domain. Used for audit trail.',
    `observation_observer_employee_id` BIGINT COMMENT 'Identifier of the employee who made the safety observation. Links to the employee master record in the workforce domain.',
    `observation_verified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who verified the completion and effectiveness of the corrective action, typically a safety officer or supervisor. Links to the employee master in the workforce domain.',
    `plan_id` BIGINT COMMENT 'Identifier of the delivery or transportation route where the observation was made, if applicable. Links to the route master in the route and network domain. Null if not route-specific.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Safety observations that identify new hazards result in hazard register entries. This FK links the observation to the hazard it identified, creating an audit trail from observation → hazard registrati',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.program. Business justification: Observations have a program_name text field indicating they are conducted under a specific safety program. Adding a proper FK to program normalizes this relationship, enabling reporting on observation',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Observations during specific transport legs (driver behavior, vehicle condition, loading practices) enable leg-specific coaching, carrier performance feedback, and route/mode-specific safety intervent',
    `transport_asset_id` BIGINT COMMENT 'Identifier of the vehicle involved in or associated with the observation, if applicable. Links to the vehicle master in the fleet domain. Null if no vehicle was involved.',
    `followup_observation_id` BIGINT COMMENT 'Self-referencing FK on observation (followup_observation_id)',
    `action_completed_date` DATE COMMENT 'Actual date when the corrective action was completed and verified. Null if action is still in progress or not yet started.',
    `action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed. Used to track action closure timeliness and ensure timely risk mitigation.',
    `action_verification_status` STRING COMMENT 'Status of the corrective action verification process: not started, in progress, completed (action done but not yet verified), verified (action confirmed effective), or rejected (action deemed insufficient, requires rework).. Valid values are `not_started|in_progress|completed|verified|rejected`',
    `anonymous_submission_flag` BOOLEAN COMMENT 'Indicates whether the observation was submitted anonymously (True) or with observer identification (False). Supports confidential reporting channels to encourage safety culture.',
    `closed_date` DATE COMMENT 'Date when the safety observation record was formally closed after all actions were completed and verified. Marks the end of the observation lifecycle.',
    `corrective_action_description` STRING COMMENT 'Description of the formal corrective action plan developed in response to the observation. Captures the planned remediation steps, responsible parties, and expected outcomes.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the safety observation record was first created in the database. Used for audit trail and data lineage.',
    `datetime` TIMESTAMP COMMENT 'Date and time when the safety observation was made in the field or workplace. This is the actual event timestamp, distinct from submission or record creation timestamps.',
    `escalated_flag` BOOLEAN COMMENT 'Indicates whether the observation was escalated to senior management or safety leadership due to severity or systemic risk (True) or handled at operational level (False).',
    `escalation_reason` STRING COMMENT 'Explanation of why the observation was escalated, if applicable. Captures the business justification for senior leadership involvement.',
    `follow_up_action_required_flag` BOOLEAN COMMENT 'Indicates whether formal follow-up corrective or preventive action is required (True) or not (False). Drives workflow routing to safety management for action assignment.',
    `immediate_action_flag` BOOLEAN COMMENT 'Indicates whether immediate action was taken at the time of observation (True) or not (False). Used to track proactive intervention rates.',
    `immediate_action_taken` STRING COMMENT 'Description of any immediate corrective or preventive action taken by the observer or on-site personnel at the time of observation. Captures real-time interventions to mitigate risk before formal investigation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the safety observation record was last updated. Used for audit trail and change tracking.',
    `location_description` STRING COMMENT 'Free-text description of the specific location where the observation was made. Includes details such as building name, floor, zone, dock number, street address, or GPS coordinates to enable precise location identification.',
    `location_type` STRING COMMENT 'Type of location where the observation was made: facility (Transport Shipping owned/operated site), vehicle (in-transit on company vehicle), route (specific delivery/pickup route), customer site (at customer premises), public road (general roadway), warehouse, terminal, office, or other. [ENUM-REF-CANDIDATE: facility|vehicle|route|customer_site|public_road|warehouse|terminal|office|other — 9 candidates stripped; promote to reference product]',
    `observation_category` STRING COMMENT 'Thematic category of the safety observation for classification and trend analysis: housekeeping (cleanliness, clutter), PPE usage (Personal Protective Equipment compliance), equipment condition (machinery, tools), ergonomics (lifting, posture), vehicle operation (driving behavior), loading/unloading (cargo handling), hazmat handling (dangerous goods), fall protection (working at height), lockout/tagout (energy isolation), or other. [ENUM-REF-CANDIDATE: housekeeping|ppe_usage|equipment_condition|ergonomics|vehicle_operation|loading_unloading|hazmat_handling|fall_protection|lockout_tagout|other — 10 candidates stripped; promote to reference product]',
    `observation_description` STRING COMMENT 'Detailed narrative description of what was observed. Captures the specific unsafe act, unsafe condition, near-miss event, or positive behavior in sufficient detail to enable investigation and corrective action.',
    `observation_number` STRING COMMENT 'Human-readable unique business identifier for the safety observation, typically system-generated following organizational numbering convention (e.g., OBS-20240115-A3F7G2).. Valid values are `^OBS-[0-9]{8}-[A-Z0-9]{6}$`',
    `observation_status` STRING COMMENT 'Current lifecycle status of the safety observation in the workflow: submitted (initial entry), under review (being evaluated by safety team), action assigned (corrective action owner designated), action in progress (remediation underway), resolved (action completed), closed (verified and archived), or cancelled (observation withdrawn or deemed invalid). [ENUM-REF-CANDIDATE: submitted|under_review|action_assigned|action_in_progress|resolved|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `observation_type` STRING COMMENT 'Classification of the safety observation: unsafe act (human behavior that could lead to incident), unsafe condition (environmental or equipment hazard), near-miss (incident that could have caused harm but did not), positive observation (safe behavior or condition to be reinforced), hazard identification (potential risk identified), or behavioral observation (general behavior-based safety observation).. Valid values are `unsafe_act|unsafe_condition|near_miss|positive_observation|hazard_identification|behavioral_observation`',
    `observer_name` STRING COMMENT 'Full name of the person who submitted the safety observation. Captured for reporting and recognition purposes in safety culture programs.',
    `observer_role` STRING COMMENT 'Functional role or job category of the observer at the time of observation: driver, warehouse worker, supervisor, safety officer, manager, contractor, visitor, or other. Used to analyze observation patterns by workforce segment. [ENUM-REF-CANDIDATE: driver|warehouse_worker|supervisor|safety_officer|manager|contractor|visitor|other — 8 candidates stripped; promote to reference product]',
    `photo_attached_flag` BOOLEAN COMMENT 'Indicates whether photographic evidence was attached to the observation record (True) or not (False). Photos support investigation and verification.',
    `photo_url` STRING COMMENT 'URL or file path to the photographic evidence attached to the observation. Null if no photo was attached.',
    `recognition_given_flag` BOOLEAN COMMENT 'Indicates whether the observer received formal recognition or reward for submitting the observation (True) or not (False). Used to track safety culture incentive programs.',
    `recognition_type` STRING COMMENT 'Type of recognition or reward given to the observer (e.g., safety award, certificate, monetary incentive, public acknowledgment). Null if no recognition was given.',
    `risk_level` STRING COMMENT 'Assessed severity or risk level of the observed condition or behavior: critical (imminent danger of serious injury or fatality), high (significant injury potential), medium (moderate injury potential), or low (minor injury potential or positive observation). Used to prioritize follow-up actions.. Valid values are `critical|high|medium|low`',
    `shift` STRING COMMENT 'Work shift during which the observation was made: day, evening, night, weekend, or rotating. Used to analyze safety patterns by time of day and workforce schedule.. Valid values are `day|evening|night|weekend|rotating`',
    `submitted_datetime` TIMESTAMP COMMENT 'Date and time when the observation was formally submitted into the safety observation system by the observer.',
    `verification_date` DATE COMMENT 'Date when the corrective action was formally verified as complete and effective. Null if verification has not yet occurred.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of observation, if relevant (e.g., rain, snow, ice, fog, extreme heat). Captured for outdoor observations to assess environmental contributing factors.',
    CONSTRAINT pk_observation PRIMARY KEY(`observation_id`)
) COMMENT 'Transactional record capturing safety observations and near-miss reports submitted by employees, supervisors, or safety officers through Transport Shippings safety observation program (e.g., STOP, BBS — Behavior-Based Safety). Captures observation type (unsafe act, unsafe condition, near-miss, positive observation), description, location, observer role, date/time, immediate action taken, risk level, and follow-up action required flag. Supports proactive safety culture by capturing leading indicators before incidents occur. Distinct from hse_incident which records actual harm events.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` (
    `regulatory_notification_id` BIGINT COMMENT 'Unique identifier for the regulatory notification record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Regulatory notifications for shipment-related incidents (DG releases, environmental spills, serious injuries) require shipment reference for DOT/EPA/OSHA reporting, customer notification, and complian',
    `facility_id` BIGINT COMMENT 'Reference to the facility where the incident occurred, if applicable.',
    `hse_incident_id` BIGINT COMMENT 'Reference to the HSE incident that triggered this regulatory notification.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to fleet.fleet_incident. Business justification: DOT-reportable fleet incidents (accidents with fatality, injury requiring immediate medical treatment, or vehicle towed from scene) trigger mandatory regulatory notifications within 24 hours. Real-wor',
    `employee_id` BIGINT COMMENT 'Reference to the employee who submitted the notification to the regulatory authority.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the vehicle involved in the incident, if applicable.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Regulatory notifications ARE transport documents submitted to authorities (DOT, EPA, OSHA). Direct regulatory process - every notification is a formal document with submission tracking, acknowledgment',
    `amended_regulatory_notification_id` BIGINT COMMENT 'Self-referencing FK on regulatory_notification (amended_regulatory_notification_id)',
    `approval_date` DATE COMMENT 'Date when the notification was approved for submission to the regulatory authority.',
    `authority_action_required` STRING COMMENT 'Description of any follow-up actions or corrective measures required by the regulatory authority.',
    `authority_reference_number` STRING COMMENT 'Unique reference or case number assigned by the regulatory authority to this notification.',
    `compliance_status` STRING COMMENT 'Assessment of whether the notification met statutory reporting requirements and timelines.. Valid values are `compliant|non-compliant|pending review|under investigation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory notification record was first created in the system.',
    `dangerous_goods_involved_flag` BOOLEAN COMMENT 'Indicates whether dangerous goods were involved in the incident requiring notification.',
    `days_overdue` STRING COMMENT 'Number of days the submission was overdue relative to the statutory deadline, if applicable.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the incident had environmental impact requiring regulatory notification.',
    `fatality_count` STRING COMMENT 'Number of fatalities resulting from the incident, if any.',
    `hospitalization_count` STRING COMMENT 'Number of individuals hospitalized as a result of the incident.',
    `incident_category` STRING COMMENT 'High-level classification of the incident type that triggered the notification (e.g., workplace injury, dangerous goods incident, environmental spill, vehicle accident).',
    `incident_datetime` TIMESTAMP COMMENT 'Date and time when the HSE incident or dangerous goods occurrence took place.',
    `incident_severity` STRING COMMENT 'Severity classification of the incident as reported to the regulatory authority.. Valid values are `minor|moderate|serious|critical|catastrophic`',
    `injury_count` STRING COMMENT 'Number of injuries resulting from the incident requiring regulatory notification.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction under which the notification is filed (country, state, or region).',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO country code for the jurisdiction where the notification is required.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory notification record was last updated.',
    `late_submission_flag` BOOLEAN COMMENT 'Indicates whether the notification was submitted after the statutory deadline.',
    `location_description` STRING COMMENT 'Textual description of the incident location as reported to the regulatory authority.',
    `notification_content_summary` STRING COMMENT 'High-level summary of the notification content, including key facts reported to the authority.',
    `notification_details` STRING COMMENT 'Detailed narrative or structured content of the notification as submitted to the regulatory authority.',
    `notification_number` STRING COMMENT 'Business identifier for the regulatory notification, used for tracking and reference purposes.',
    `notification_status` STRING COMMENT 'Current lifecycle status of the regulatory notification in the submission and review process.. Valid values are `draft|pending submission|submitted|acknowledged|under review|closed`',
    `notification_trigger` STRING COMMENT 'Specific regulatory requirement or threshold that triggered the mandatory notification (e.g., fatality, lost-time injury, dangerous goods release, environmental discharge).',
    `notification_type` STRING COMMENT 'Classification of the regulatory notification based on reporting stage and purpose.. Valid values are `initial notification|follow-up report|final report|supplemental report|corrective action report|closure notification`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary value of any penalty or fine assessed by the regulatory authority.',
    `penalty_assessed_flag` BOOLEAN COMMENT 'Indicates whether a penalty or fine was assessed by the regulatory authority for late or non-compliant notification.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `regulatory_authority` STRING COMMENT 'Name of the government or regulatory body to which the notification is submitted (e.g., OSHA, HSE UK, EPA, IATA, IMO, national transport authority).',
    `regulatory_authority_code` STRING COMMENT 'Standardized code or abbreviation for the regulatory authority (e.g., OSHA, EPA, IMO).',
    `response_received_date` DATE COMMENT 'Date when a response or acknowledgment was received from the regulatory authority.',
    `response_received_flag` BOOLEAN COMMENT 'Indicates whether a response or acknowledgment has been received from the regulatory authority.',
    `response_summary` STRING COMMENT 'Summary of the response or feedback received from the regulatory authority.',
    `statutory_deadline` DATE COMMENT 'Legal deadline by which the notification must be submitted to the regulatory authority.',
    `submission_confirmation_number` STRING COMMENT 'Confirmation or tracking number provided by the submission system upon successful filing.',
    `submission_date` DATE COMMENT 'Actual date when the notification was submitted to the regulatory authority.',
    `submission_method` STRING COMMENT 'Method or channel used to submit the notification to the regulatory authority. [ENUM-REF-CANDIDATE: online portal|email|fax|postal mail|phone|in-person|EDI — 7 candidates stripped; promote to reference product]',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the notification was submitted to the regulatory authority.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the dangerous goods substance involved in the incident.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_regulatory_notification PRIMARY KEY(`regulatory_notification_id`)
) COMMENT 'Transactional record managing mandatory regulatory notifications and reports submitted to government authorities following HSE incidents, DG occurrences, or environmental events. Captures regulatory body (OSHA, HSE UK, EPA, IATA, IMO, national transport authority), notification type (initial notification, follow-up report, final report), submission deadline, actual submission date, submission method, reference number assigned by authority, notification content summary, and response received from authority. Ensures Transport Shipping meets statutory reporting timelines across all operating jurisdictions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`permit` (
    `permit_id` BIGINT COMMENT 'Unique identifier for the safety permit record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Safety permits (hot work for container repair, confined space entry for tank cleaning, LOTO for equipment maintenance) issued during shipment handling operations. Permit-to-shipment linkage enables co',
    `facility_id` BIGINT COMMENT 'Reference to the facility where the permitted work will be performed. Links to the facility master data.',
    `employee_id` BIGINT COMMENT 'Reference to the senior manager or safety director who provided final approval for this permit. Links to employee master data.',
    `permit_closed_by_employee_id` BIGINT COMMENT 'Reference to the employee who closed the permit after verifying work completion and site restoration. Links to employee master data.',
    `permit_employee_id` BIGINT COMMENT 'Reference to the employee who has the authority to issue this permit (typically a safety officer, facility manager, or authorized supervisor). Links to employee master data.',
    `permit_holder_employee_id` BIGINT COMMENT 'Reference to the employee or contractor who is the primary permit holder responsible for executing the work under this permit. Links to employee or contractor master data.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: High-risk work permits (hot work, confined space, etc.) should reference the formal risk assessment that authorized the work. Links permit issuance to the risk analysis that justified it, supporting r',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Safety permits (hot work, confined space, lockout/tagout) are formal documents requiring issuance, approval signatures, and retention. Often part of transport documentation packages for facility opera',
    `renewed_permit_id` BIGINT COMMENT 'Self-referencing FK on permit (renewed_permit_id)',
    `approval_date` DATE COMMENT 'Date when final approval was granted for this permit.',
    `approved_by_name` STRING COMMENT 'Full name of the person who provided final approval. Denormalized for reporting and audit trail purposes.',
    `atmospheric_testing_required_flag` BOOLEAN COMMENT 'Indicates whether atmospheric testing (oxygen level, flammable gases, toxic gases) is required before and during the work. Typically true for confined space entry and hot work permits.',
    `audit_trail_notes` STRING COMMENT 'Comprehensive audit trail notes capturing all significant events, inspections, sign-offs, and changes throughout the permit lifecycle. Used for compliance documentation and incident investigation.',
    `closed_date` DATE COMMENT 'Date when the permit was formally closed after work completion. Represents the end of the permit lifecycle.',
    `confined_space_flag` BOOLEAN COMMENT 'Indicates whether this permit authorizes entry into a confined space. True if confined space entry is involved, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this permit record was first created in the system. Audit field for data lineage and compliance tracking.',
    `dangerous_goods_involved_flag` BOOLEAN COMMENT 'Indicates whether dangerous goods (hazardous materials) are involved in the work activity. True if dangerous goods handling is part of the permitted work, false otherwise.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the permit validity period in hours. Calculated from validity start and end date-times for reporting and compliance tracking.',
    `emergency_contact_name` STRING COMMENT 'Name of the designated emergency contact person for this permitted work activity.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the designated emergency contact person. Must be reachable during the entire permit validity period.. Valid values are `^+?[1-9]d{1,14}$`',
    `fire_watch_required_flag` BOOLEAN COMMENT 'Indicates whether a dedicated fire watch person must be present during and after the work. Typically required for hot work activities.',
    `hazards_identified` STRING COMMENT 'Detailed list of all hazards identified during the risk assessment for this work activity. May include physical, chemical, biological, ergonomic, and psychosocial hazards.',
    `hazmat_un_number` STRING COMMENT 'United Nations identification number for the hazardous material involved in the work, if applicable. Four-digit number preceded by UN (e.g., UN1203 for gasoline).. Valid values are `^UN[0-9]{4}$`',
    `holder_company` STRING COMMENT 'Name of the company employing the permit holder (Transport Shipping or external contractor company). Used to distinguish internal employees from third-party contractors.',
    `holder_name` STRING COMMENT 'Full name of the permit holder. Denormalized for reporting and audit trail purposes.',
    `hot_work_flag` BOOLEAN COMMENT 'Indicates whether this permit authorizes hot work activities (welding, cutting, grinding, or other spark-producing operations). True if hot work is involved, false otherwise.',
    `incident_occurred_flag` BOOLEAN COMMENT 'Indicates whether any safety incident occurred during the execution of work under this permit. True if an incident occurred, false otherwise.',
    `issued_date` DATE COMMENT 'Date when the permit was officially issued by the issuing authority. Represents the formal approval date.',
    `issued_timestamp` TIMESTAMP COMMENT 'Precise date and time when the permit was officially issued. Provides exact moment of permit approval for audit trail.',
    `issuing_authority_name` STRING COMMENT 'Full name of the person who issued this permit. Denormalized for reporting and audit trail purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this permit record was last modified. Audit field for tracking changes and maintaining data integrity.',
    `lockout_tagout_required_flag` BOOLEAN COMMENT 'Indicates whether lockout-tagout procedures must be applied to isolate energy sources before work begins. True if LOTO is required, false otherwise.',
    `permit_number` STRING COMMENT 'Externally-known unique permit number assigned to this permit-to-work. Business identifier for tracking and audit purposes.. Valid values are `^PTW-[A-Z0-9]{8,12}$`',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit: draft (being prepared), issued (approved but not yet active), active (work in progress), suspended (temporarily halted), closed (work completed), cancelled (permit voided), or expired (validity period lapsed). [ENUM-REF-CANDIDATE: draft|issued|active|suspended|closed|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `permit_type` STRING COMMENT 'Classification of the permit based on the nature of high-risk activity: hot work (welding, cutting, grinding), confined space entry, working at height, electrical isolation, excavation, or chemical handling.. Valid values are `hot_work|confined_space_entry|working_at_height|electrical_isolation|excavation|chemical_handling`',
    `ppe_requirements` STRING COMMENT 'Detailed list of personal protective equipment that must be worn by all personnel involved in the permitted work (e.g., hard hat, safety glasses, gloves, respirator, fall protection harness).',
    `precautions_required` STRING COMMENT 'Mandatory safety precautions and control measures that must be in place before and during the work. Includes personal protective equipment (PPE), engineering controls, administrative controls, and emergency procedures.',
    `regulatory_compliance_status` STRING COMMENT 'Overall regulatory compliance status of this permit with respect to OSHA, ISO 45001, and other applicable safety regulations. Indicates whether the permit meets all regulatory requirements.. Valid values are `compliant|non_compliant|under_review|exempted`',
    `rescue_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal rescue plan must be in place before work begins. Typically required for confined space entry and working at height.',
    `shift` STRING COMMENT 'The work shift during which the permitted work is scheduled to occur: day shift, night shift, swing shift, or rotating shift.. Valid values are `day|night|swing|rotating`',
    `validity_end_datetime` TIMESTAMP COMMENT 'Date and time when the permit expires and work must cease. Represents the end of the permits active period. Work continuing beyond this time requires permit renewal or new permit issuance.',
    `validity_start_datetime` TIMESTAMP COMMENT 'Date and time when the permit becomes valid and work may commence. Represents the beginning of the permits active period.',
    `violation_description` STRING COMMENT 'Detailed description of any permit violations that occurred, including nature of violation, corrective actions taken, and personnel involved.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether any violations of permit conditions were observed during the work. True if violations occurred, false otherwise.',
    `work_completion_verified_flag` BOOLEAN COMMENT 'Indicates whether the work completion has been verified and the work area has been inspected and deemed safe. True if verified, false otherwise.',
    `work_description` STRING COMMENT 'Comprehensive description of the work to be performed under this permit, including scope, methods, equipment to be used, and any special considerations.',
    `work_location_description` STRING COMMENT 'Detailed description of the specific work location within the facility (e.g., warehouse bay 3, loading dock A, maintenance shop floor 2). Provides granular location context beyond facility-level identification.',
    CONSTRAINT pk_permit PRIMARY KEY(`permit_id`)
) COMMENT 'Master record for safety permits-to-work (PTW) and operational safety permits issued for high-risk activities at Transport Shipping facilities. Captures permit type (hot work, confined space entry, working at height, electrical isolation, excavation, chemical handling), permit number, issuing authority (safety officer, facility manager), permit holder, work location, work description, hazards identified, precautions required, validity period (start/end date-time), permit status (issued, active, suspended, closed), and sign-off records. Supports OSHA and ISO 45001 permit-to-work system requirements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` (
    `occupational_health_case_id` BIGINT COMMENT 'Unique identifier for the occupational health case record. Primary key for the occupational health case entity.',
    `document_package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Occupational health cases generate document packages (medical records, workers compensation filings, return-to-work documentation, OSHA forms). Required for workers comp claims, regulatory compliance,',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Work-related injuries during shipment handling (lifting injuries, forklift accidents, slip/trip/fall) require shipment context for workers compensation claims, OSHA recordkeeping, and customer liabil',
    `facility_id` BIGINT COMMENT 'Reference to the Transport Shipping facility where the employee is assigned or where the health case originated.',
    `hse_incident_id` BIGINT COMMENT 'Reference to the originating HSE incident that triggered this occupational health case, if applicable. Nullable for cases not originating from a recorded incident.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to fleet.fleet_incident. Business justification: Occupational health cases arising from fleet incidents (driver injuries in vehicle accidents, loading/unloading injuries) require linkage for workers compensation claims, modified duty planning, and ',
    `employee_id` BIGINT COMMENT 'Reference to the Transport Shipping employee who is the subject of this occupational health case.',
    `tertiary_occupational_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the system user who last modified this occupational health case record.',
    `related_occupational_health_case_id` BIGINT COMMENT 'Self-referencing FK on occupational_health_case (related_occupational_health_case_id)',
    `accommodation_description` STRING COMMENT 'Description of workplace accommodations provided or planned to support the employee, such as ergonomic equipment, schedule modifications, or job restructuring.',
    `accommodation_required_flag` BOOLEAN COMMENT 'Indicates whether workplace accommodations are required to support the employees return to work or continued employment.',
    `actual_return_to_full_duty_date` DATE COMMENT 'Actual date when the employee was medically cleared and returned to full, unrestricted work duties.',
    `case_closed_date` DATE COMMENT 'Date when the occupational health case was officially closed after completion of all required interventions and clearances.',
    `case_closure_outcome` STRING COMMENT 'Final outcome classification of the occupational health case at the time of closure, indicating the employees work status resolution. [ENUM-REF-CANDIDATE: full_recovery|partial_recovery|permanent_restrictions|disability_retirement|resignation|termination|other — 7 candidates stripped; promote to reference product]',
    `case_manager_name` STRING COMMENT 'Name of the case manager responsible for coordinating the occupational health case and return-to-work process.',
    `case_notes` STRING COMMENT 'Confidential notes and observations related to the occupational health case management, treatment progress, and coordination activities.',
    `case_number` STRING COMMENT 'Business-facing unique case number assigned to the occupational health case for tracking and reference purposes.',
    `case_open_date` DATE COMMENT 'Date when the occupational health case was officially opened and case management began.',
    `case_open_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the occupational health case was opened in the system, including time zone information.',
    `case_status` STRING COMMENT 'Current lifecycle status of the occupational health case indicating its progression through the management workflow.. Valid values are `open|in_treatment|under_review|pending_clearance|closed|cancelled`',
    `case_type` STRING COMMENT 'Classification of the occupational health case indicating the nature of the health management intervention required. [ENUM-REF-CANDIDATE: occupational_illness|injury_rehabilitation|ergonomic_assessment|mental_health_referral|fitness_for_duty|medical_surveillance|return_to_work — 7 candidates stripped; promote to reference product]',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated case cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this occupational health case record was first created in the database.',
    `days_away_from_work` STRING COMMENT 'Total number of calendar days the employee was completely unable to work due to the occupational health condition.',
    `days_on_restricted_duty` STRING COMMENT 'Total number of calendar days the employee worked under modified or restricted duty arrangements.',
    `department_code` STRING COMMENT 'Code identifying the department or business unit to which the employee belongs for organizational tracking and reporting.',
    `diagnosis_category` STRING COMMENT 'High-level categorization of the medical diagnosis or health condition being managed, without detailed clinical information. Examples include musculoskeletal disorder, respiratory condition, hearing loss, stress-related condition.',
    `diagnosis_code` STRING COMMENT 'Standardized ICD-10 or ICD-11 code representing the medical diagnosis associated with this occupational health case.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Estimated total cost associated with managing this occupational health case, including medical expenses, lost time, and administrative costs.',
    `expected_return_to_full_duty_date` DATE COMMENT 'Anticipated date when the employee is expected to return to full, unrestricted work duties based on medical prognosis.',
    `fitness_clearance_date` DATE COMMENT 'Date when the employee received medical clearance confirming fitness to perform their job duties.',
    `fitness_for_duty_status` STRING COMMENT 'Current medical determination of the employees ability to safely perform their assigned job duties.. Valid values are `fit_for_duty|fit_with_restrictions|temporarily_unfit|permanently_unfit|pending_evaluation`',
    `follow_up_appointment_date` DATE COMMENT 'Date of the next scheduled follow-up appointment with the occupational health provider for case review and assessment.',
    `job_title` STRING COMMENT 'Job title or position of the employee at the time the occupational health case was opened.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this occupational health case record was last updated or modified.',
    `modified_duty_plan` STRING COMMENT 'Details of the modified duty or light duty work plan established to accommodate the employees restrictions while facilitating return to work.',
    `modified_duty_start_date` DATE COMMENT 'Date when the employee began working under modified duty or light duty arrangements.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether this occupational health case meets OSHA criteria for recordability on the OSHA 300 log.',
    `privacy_case_flag` BOOLEAN COMMENT 'Indicates whether this case qualifies as a privacy concern case under OSHA recordkeeping rules, requiring special handling of employee identity.',
    `treating_provider_facility` STRING COMMENT 'Name of the medical facility, clinic, or occupational health center where the employee is receiving treatment.',
    `treating_provider_name` STRING COMMENT 'Name of the occupational health physician, nurse practitioner, or medical professional managing the employees health case.',
    `work_restrictions_imposed` STRING COMMENT 'Description of any temporary or permanent work restrictions placed on the employee by the treating provider, such as lifting limits, no driving, reduced hours, or environmental restrictions.',
    `workers_compensation_carrier` STRING COMMENT 'Name of the insurance carrier handling the workers compensation claim associated with this case.',
    `workers_compensation_claim_number` STRING COMMENT 'Associated workers compensation insurance claim number if the occupational health case resulted in a compensable claim.',
    CONSTRAINT pk_occupational_health_case PRIMARY KEY(`occupational_health_case_id`)
) COMMENT 'Master record for occupational health cases managed for Transport Shipping employees, including work-related illness, injury rehabilitation, fitness-for-duty assessments, and return-to-work programs. Captures case type (occupational illness, injury rehabilitation, ergonomic assessment, mental health referral, fitness-for-duty), case open date, treating occupational health provider, diagnosis category, work restrictions imposed, modified duty plan, expected return-to-full-duty date, actual return date, and case closure outcome. Distinct from hse_incident (the safety event) — this tracks the medical and rehabilitation management of the affected worker.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the safety program. Primary key.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `owner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `program_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for overall program governance, performance, and compliance. Links to the employee master record.',
    `program_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified this safety program record. Links to the employee master record.',
    `parent_program_id` BIGINT COMMENT 'Self-referencing FK on program (parent_program_id)',
    `audit_frequency` STRING COMMENT 'Scheduled frequency for internal or external audits of this program.. Valid values are `Annual|Semi-Annual|Quarterly|Biennial|Triennial`',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Total budget allocated for the operation and administration of this safety program in the current fiscal period.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `business_unit_coverage` STRING COMMENT 'List or description of business units or divisions covered by this program (e.g., Express Parcel Delivery, Freight Forwarding, Warehouse Operations). Free text for flexibility.',
    `certification_body` STRING COMMENT 'Name of the external certification or accreditation body that audits or certifies this program (e.g., BSI, DNV, OSHA VPP Office). Null if the program is not externally certified.',
    `certification_expiry_date` DATE COMMENT 'Date on which the current certification expires and requires renewal or re-audit.',
    `certification_issue_date` DATE COMMENT 'Date on which the current certification was issued by the certification body.',
    `certification_number` STRING COMMENT 'Unique certificate or accreditation number issued by the certification body. Null if not applicable.',
    `certification_status` STRING COMMENT 'Current status of external certification for this program. Certified indicates active certification; in progress indicates certification audit underway; expired indicates lapsed certification; not applicable for non-certified programs; suspended for temporarily revoked certification.. Valid values are `Certified|In Progress|Expired|Not Applicable|Suspended`',
    `contact_email` STRING COMMENT 'Primary email address for inquiries, reporting, or escalations related to this safety program.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for inquiries or escalations related to this safety program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety program record was first created in the system.',
    `document_url` STRING COMMENT 'URL or file path to the formal program documentation, policy manual, or standard operating procedures (SOPs) for this safety program.',
    `effective_end_date` DATE COMMENT 'Date on which the safety program is scheduled to end or was terminated. Null for ongoing programs.',
    `effective_start_date` DATE COMMENT 'Date on which the safety program became or will become operational and binding.',
    `geographic_coverage` STRING COMMENT 'List or description of countries, regions, or facilities covered by this program (e.g., USA, CAN, MEX, EMEA Region, All North American Hubs). Free text for flexibility.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit of this program.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this safety program record was last updated in the system.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal management review of this program.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next internal or external audit of this program.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal management review of this program.',
    `notes` STRING COMMENT 'Free-text field for additional notes, context, or special instructions related to the program administration or scope.',
    `objectives` STRING COMMENT 'Detailed description of the strategic objectives and goals of the safety program, including target outcomes, risk reduction aims, and compliance milestones.',
    `participant_count` STRING COMMENT 'Total number of employees, contractors, or facilities currently enrolled or participating in this safety program. Updated periodically; detailed participation tracked in linked transactional entities.',
    `program_name` STRING COMMENT 'Full descriptive name of the safety program (e.g., Global Driver Safety Excellence Program, ISO 45001 Occupational Health & Safety Management System).',
    `program_number` STRING COMMENT 'Externally-known unique business identifier for the safety program, typically formatted as a code (e.g., HSE-001234, ISO-045001).. Valid values are `^[A-Z]{2,4}-[0-9]{4,6}$`',
    `program_scope` STRING COMMENT 'Geographic or organizational scope of the safety program. Indicates whether the program applies globally, to a specific region, business unit, individual facility, or fleet segment.. Valid values are `Global|Regional|Business Unit|Facility|Fleet`',
    `program_status` STRING COMMENT 'Current lifecycle status of the safety program. Active programs are operational; under review indicates evaluation or audit; suspended programs are temporarily halted; inactive programs are closed; planned programs are in development.. Valid values are `Active|Under Review|Suspended|Inactive|Planned`',
    `program_type` STRING COMMENT 'Classification of the safety program by its primary focus area. Includes ISO 45001 management system, OSHA Voluntary Protection Program (VPP), driver safety program, dangerous goods (DG) safety program, fatigue risk management, and contractor safety management.. Valid values are `ISO 45001 Management System|OSHA VPP|Driver Safety Program|Dangerous Goods Safety Program|Fatigue Risk Management|Contractor Safety Management`',
    `regulatory_basis` STRING COMMENT 'Primary regulatory framework, standard, or legal requirement that mandates or guides this program (e.g., OSHA 29 CFR 1910, ISO 45001:2018, IATA DGR, EU Directive 89/391/EEC).',
    `review_frequency` STRING COMMENT 'Scheduled frequency for formal management review of the program performance and compliance.. Valid values are `Annual|Semi-Annual|Quarterly|Monthly|Ad-Hoc`',
    `target_metrics` STRING COMMENT 'Key performance indicators (KPIs) and target metrics defined for this program (e.g., Zero fatalities, TRIR < 1.0, DART rate < 0.5, 100% DG certification compliance). Stored as free text; actual performance tracked in linked transactional entities.',
    `training_frequency` STRING COMMENT 'Required frequency for participant training or recertification under this program. Null if training is not required.. Valid values are `Annual|Biennial|Triennial|One-Time|As Needed`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training is required for participants in this program. True if training is mandatory; false otherwise.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record defining formal HSE safety programs and management system initiatives operated by Transport Shipping. Captures program name, program type (ISO 45001 management system, OSHA VPP, driver safety program, DG safety program, fatigue risk management, contractor safety management), program scope (global, regional, business unit, facility), program owner, regulatory or certification basis, program objectives, target metrics, program status (active, under review, suspended), and certification body where applicable. Serves as the program catalog — participation and performance are tracked in linked transactional entities.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` (
    `contractor_safety_prequal_id` BIGINT COMMENT 'Unique identifier for the contractor safety pre-qualification record.',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor or third-party service provider company being pre-qualified.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Safety prequalification is performed on network partners before service authorization. Links prequal to partner master record for onboarding workflow, contract activation, and ongoing compliance track',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_audit. Business justification: Contractor safety prequalification often includes a formal safety audit of the contractors operations. This FK links the prequal record to the audit that supported the approval decision, enabling aud',
    `employee_id` BIGINT COMMENT 'Reference to the Transport Shipping safety officer who reviewed and approved the pre-qualification.',
    `template_id` BIGINT COMMENT 'Reference to the safety questionnaire template used for the assessment.',
    `renewed_contractor_safety_prequal_id` BIGINT COMMENT 'Self-referencing FK on contractor_safety_prequal (renewed_contractor_safety_prequal_id)',
    `application_date` DATE COMMENT 'Date when the contractor submitted the safety pre-qualification application.',
    `approval_date` DATE COMMENT 'Date when the contractor was approved for safety pre-qualification.',
    `approval_notes` STRING COMMENT 'Notes and comments recorded by the reviewing safety officer regarding the approval decision.',
    `assessment_date` DATE COMMENT 'Date when the safety pre-qualification assessment was conducted.',
    `authorized_facilities` STRING COMMENT 'Comma-separated list of facility IDs or names where the contractor is authorized to work.',
    `compliance_framework` STRING COMMENT 'Primary safety compliance framework or standard the contractor is assessed against (e.g., ISO 28000, C-TPAT, AEO).',
    `conditional_approval_requirements` STRING COMMENT 'Specific requirements or conditions that must be met for conditional approvals.',
    `contractor_type` STRING COMMENT 'Classification of the contractor service type (e.g., Third-Party Logistics (3PL), freight forwarder, warehouse operator, maintenance provider, transport carrier, customs broker).. Valid values are `3pl|freight_forwarder|warehouse_operator|maintenance_provider|transport_carrier|customs_broker`',
    `coverage_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the liability coverage amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contractor safety pre-qualification record was first created in the system.',
    `dangerous_goods_certified` BOOLEAN COMMENT 'Indicates whether the contractor holds valid dangerous goods handling certifications required for Transport Shipping operations.',
    `dg_certification_expiry_date` DATE COMMENT 'Expiration date of the dangerous goods handling certification.',
    `dg_certification_number` STRING COMMENT 'Certification number for dangerous goods handling qualification.',
    `document_repository_url` STRING COMMENT 'URL or path to the document repository containing the contractors pre-qualification documentation.',
    `expiry_date` DATE COMMENT 'Date when the contractor safety pre-qualification expires and requires renewal.',
    `induction_completion_date` DATE COMMENT 'Date when all required safety inductions were completed.',
    `insurance_certificate_valid` BOOLEAN COMMENT 'Indicates whether the contractor has provided valid insurance certificates meeting Transport Shipping requirements.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the contractors insurance coverage.',
    `last_audit_date` DATE COMMENT 'Date of the most recent safety audit conducted on the contractor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the contractor safety pre-qualification record was last modified.',
    `liability_coverage_amount` DECIMAL(18,2) COMMENT 'Total liability insurance coverage amount provided by the contractor.',
    `ltir` DECIMAL(18,2) COMMENT 'Contractors Lost Time Incident Rate (LTIR) - number of lost time incidents per 200,000 work hours.',
    `minimum_passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the safety pre-qualification assessment.',
    `next_audit_scheduled_date` DATE COMMENT 'Date when the next safety audit is scheduled for the contractor.',
    `osha_violations_count` STRING COMMENT 'Number of OSHA violations recorded for the contractor in the review period.',
    `prequal_reference_number` STRING COMMENT 'Business-facing unique reference number for the pre-qualification application or assessment.',
    `prequal_status` STRING COMMENT 'Current status of the contractor safety pre-qualification (pending, approved, conditional, rejected, expired, suspended).. Valid values are `pending|approved|conditional|rejected|expired|suspended`',
    `rejection_reason` STRING COMMENT 'Detailed reason for rejection of the contractor safety pre-qualification application.',
    `renewal_required_date` DATE COMMENT 'Date by which the contractor must submit a renewal application to maintain pre-qualification status.',
    `reviewing_safety_officer_name` STRING COMMENT 'Name of the Transport Shipping safety officer who reviewed and approved the pre-qualification.',
    `safety_inductions_completed` BOOLEAN COMMENT 'Indicates whether all required safety inductions and training have been completed by the contractors personnel.',
    `safety_questionnaire_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the contractor on the safety questionnaire assessment (0-100 scale).',
    `safety_record_review_date` DATE COMMENT 'Date when the contractors safety record was reviewed.',
    `safety_record_review_outcome` STRING COMMENT 'Overall outcome of the contractors safety record review based on TRIR, LTIR, and historical incident analysis.. Valid values are `excellent|good|acceptable|marginal|unacceptable`',
    `serious_violations_count` STRING COMMENT 'Number of serious safety violations recorded for the contractor in the review period.',
    `site_access_authorization_level` STRING COMMENT 'Level of site access authorization granted to the contractor (unrestricted, restricted, escorted only, no access).. Valid values are `unrestricted|restricted|escorted_only|no_access`',
    `trir` DECIMAL(18,2) COMMENT 'Contractors Total Recordable Incident Rate (TRIR) - number of recordable incidents per 200,000 work hours.',
    `validity_period_months` STRING COMMENT 'Duration in months for which the pre-qualification approval is valid.',
    CONSTRAINT pk_contractor_safety_prequal PRIMARY KEY(`contractor_safety_prequal_id`)
) COMMENT 'Master record for the safety pre-qualification and approval of contractors and third-party service providers working at Transport Shipping facilities or on Transport Shipping operations. Captures contractor company reference, prequalification status (pending, approved, conditional, rejected, expired), safety questionnaire score, insurance certificate validity, safety record review outcome (TRIR, LTIR), required safety inductions completed flag, site access authorization level, prequalification expiry date, and reviewing safety officer. Ensures only safety-qualified contractors are permitted to work on Transport Shipping premises.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` (
    `environmental_incident_id` BIGINT COMMENT 'Unique identifier for the environmental incident record. Primary key.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to safety.emergency_response_plan. Business justification: Environmental incidents (spills, releases) trigger emergency response plans. This FK tracks which ERP was activated during the incident response, supporting post-incident review and ERP effectiveness ',
    `cfs_operation_id` BIGINT COMMENT 'Foreign key linking to freight.cfs_operation. Business justification: Warehouse operations environmental incidents (chemical spills, refrigerant leaks, waste releases) need linkage to specific CFS operations for investigation, facility environmental compliance tracking,',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with the environmental incident, if the incident occurred during transport operations.',
    `consolidation_id` BIGINT COMMENT 'Foreign key linking to freight.consolidation. Business justification: CFS and consolidation operations have environmental incident risk (chemical spills, refrigerant leaks, waste releases). Linking enables facility environmental compliance tracking, NVOCC liability asse',
    `facility_id` BIGINT COMMENT 'Reference to the facility where the environmental incident occurred, if applicable.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Freight operations can cause environmental incidents (fuel spills, hazmat releases, refrigerant leaks). Linking to freight order enables customer notification, shipper liability determination, insuran',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: An environmental incident (spill, chemical release) is frequently also recorded as a general HSE incident. The environmental_incident captures remediation-specific details while hse_incident captures ',
    `intermodal_transfer_id` BIGINT COMMENT 'Foreign key linking to freight.intermodal_transfer. Business justification: Transfer operations can cause environmental incidents (fuel spills during equipment operation, cargo releases during handling). Linking enables transfer facility environmental compliance tracking and ',
    `employee_id` BIGINT COMMENT 'Reference to the employee who initially reported the environmental incident.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Environmental incidents during carrier transport require tracking responsible carrier for regulatory notification, remediation cost allocation, insurance claims, and environmental compliance reporting',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Environmental incidents during shipment (fuel spills, refrigerant leaks, hazmat releases) require emissions recalculation and separate GHG inventory reporting. Regulatory disclosure under Scope 1 dire',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Environmental releases (fuel spills, refrigerant leaks, hazmat spills) during specific transport segments require leg-level attribution for carrier liability determination, EPA reporting with precise ',
    `transport_asset_id` BIGINT COMMENT 'Reference to the vehicle involved in the environmental incident, if applicable.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Environmental incidents (spills, releases) require formal documentation for EPA/environmental authority reporting, remediation tracking, and insurance claims. Mandatory regulatory requirement under en',
    `related_environmental_incident_id` BIGINT COMMENT 'Self-referencing FK on environmental_incident (related_environmental_incident_id)',
    `actual_remediation_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for environmental remediation, cleanup, and restoration activities in the currency specified by cost_currency_code.',
    `cas_number` STRING COMMENT 'Unique CAS registry number identifying the chemical substance involved in the environmental incident, if applicable.',
    `cleanup_contractor_engaged_flag` BOOLEAN COMMENT 'Indicates whether an external cleanup or remediation contractor was engaged to respond to the environmental incident (True) or not (False).',
    `cleanup_contractor_name` STRING COMMENT 'Name of the external contractor or remediation firm engaged to perform environmental cleanup and remediation activities.',
    `containment_actions_taken` STRING COMMENT 'Description of immediate containment actions taken to prevent further environmental release or spread of contamination.',
    `containment_datetime` TIMESTAMP COMMENT 'The date and time when the environmental incident was successfully contained and further release was stopped.',
    `corrective_actions_completed_flag` BOOLEAN COMMENT 'Indicates whether all required corrective actions have been completed (True) or are still pending (False).',
    `corrective_actions_required` STRING COMMENT 'Description of corrective and preventive actions required to address root causes and prevent recurrence of similar environmental incidents.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for remediation cost amounts.. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the environmental incident occurred.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this environmental incident record was first created in the system. Audit trail field.',
    `discovery_method` STRING COMMENT 'The method by which the environmental incident was discovered: routine inspection, employee report, customer complaint, sensor alarm, third party notification, or regulatory inspection.. Valid values are `routine_inspection|employee_report|customer_complaint|sensor_alarm|third_party_notification|regulatory_inspection`',
    `environmental_media_affected` STRING COMMENT 'The environmental medium or media impacted by the incident: soil, water (surface or groundwater), air, or multiple media.. Valid values are `soil|water|air|multiple`',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of environmental remediation, cleanup, and restoration activities in the currency specified by cost_currency_code.',
    `immediate_cause` STRING COMMENT 'The direct, proximate cause that triggered the environmental incident (e.g., equipment failure, human error, external event).',
    `incident_closed_date` DATE COMMENT 'The date when the environmental incident was officially closed after all remediation, corrective actions, and regulatory requirements were completed.',
    `incident_datetime` TIMESTAMP COMMENT 'The date and time when the environmental incident occurred or was first detected. Principal business event timestamp for the incident.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the environmental incident, including circumstances, sequence of events, and immediate observations.',
    `incident_number` STRING COMMENT 'Business-facing unique reference number assigned to the environmental incident for tracking and reporting purposes.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the environmental incident: reported, under investigation, containment in progress, remediation in progress, closed, or regulatory review.. Valid values are `reported|under_investigation|containment_in_progress|remediation_in_progress|closed|regulatory_review`',
    `incident_type` STRING COMMENT 'Classification of the environmental incident by nature of the event: fuel spill, chemical release, dangerous goods (DG) leakage, wastewater discharge, air emission exceedance, or soil contamination.. Valid values are `fuel_spill|chemical_release|dg_leakage|wastewater_discharge|air_emission_exceedance|soil_contamination`',
    `insurance_claim_filed_flag` BOOLEAN COMMENT 'Indicates whether an insurance claim was filed for the environmental incident and associated remediation costs (True) or not (False).',
    `insurance_claim_number` STRING COMMENT 'Reference number of the insurance claim filed for the environmental incident, if applicable.',
    `investigation_completed_date` DATE COMMENT 'The date when the formal environmental incident investigation was completed and findings were documented.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether a formal environmental incident investigation is required (True) or not (False) based on severity and regulatory requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this environmental incident record was last updated or modified. Audit trail field.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the environmental incident location in decimal degrees.',
    `location_description` STRING COMMENT 'Detailed textual description of the specific location where the environmental incident occurred, including address, coordinates, or facility area.',
    `location_type` STRING COMMENT 'Type of location where the environmental incident occurred: facility, vehicle, vessel, aircraft, warehouse, terminal, depot, customer site, or public area. [ENUM-REF-CANDIDATE: facility|vehicle|vessel|aircraft|warehouse|terminal|depot|customer_site|public_area — 9 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the environmental incident location in decimal degrees.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Total monetary value of regulatory penalties or fines assessed for the environmental incident, in the currency specified by cost_currency_code.',
    `penalty_assessed_flag` BOOLEAN COMMENT 'Indicates whether regulatory penalties or fines were assessed against Transport Shipping for the environmental incident (True) or not (False).',
    `quantity_released` DECIMAL(18,2) COMMENT 'The quantity or volume of substance released into the environment during the incident, measured in the unit specified in release_unit_of_measure.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or environmental agency to which the incident was or must be reported (e.g., EPA, local environmental protection bureau).',
    `regulatory_case_number` STRING COMMENT 'Case or reference number assigned by the regulatory authority for tracking the environmental incident investigation and compliance.',
    `regulatory_notification_date` DATE COMMENT 'The date on which the environmental incident was officially reported to the regulatory authority.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the environmental incident meets thresholds requiring mandatory notification to regulatory authorities (True) or not (False).',
    `release_unit_of_measure` STRING COMMENT 'Unit of measure for the quantity released: liters, gallons, kilograms, pounds, cubic meters, or tons.. Valid values are `liters|gallons|kilograms|pounds|cubic_meters|tons`',
    `remediation_completion_date` DATE COMMENT 'The date when environmental remediation and cleanup activities were completed and the site was restored.',
    `remediation_start_date` DATE COMMENT 'The date when environmental remediation and cleanup activities commenced.',
    `remediation_status` STRING COMMENT 'Current status of environmental remediation and cleanup activities: not started, in progress, completed, ongoing monitoring, or verified complete.. Valid values are `not_started|in_progress|completed|ongoing_monitoring|verified_complete`',
    `reported_datetime` TIMESTAMP COMMENT 'The date and time when the environmental incident was officially reported to internal management or authorities.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the underlying root cause of the environmental incident: equipment failure, human error, process deficiency, external event, design flaw, or maintenance lapse.. Valid values are `equipment_failure|human_error|process_deficiency|external_event|design_flaw|maintenance_lapse`',
    `severity_classification` STRING COMMENT 'Severity rating of the environmental incident based on environmental impact, regulatory implications, and remediation complexity: minor, moderate, major, critical, or catastrophic.. Valid values are `minor|moderate|major|critical|catastrophic`',
    `substance_involved` STRING COMMENT 'Name or description of the hazardous substance, chemical, fuel, or material involved in the environmental incident.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the hazardous material involved in the incident, if applicable. Used for dangerous goods classification per IMDG and IATA standards.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_environmental_incident PRIMARY KEY(`environmental_incident_id`)
) COMMENT 'Transactional record capturing environmental incidents and spill events at Transport Shipping facilities and during transport operations. Captures incident type (fuel spill, chemical release, DG leakage, wastewater discharge, air emission exceedance, soil contamination), substance involved, quantity released, environmental media affected (soil, water, air), containment actions taken, regulatory notification required flag, clean-up contractor engaged, remediation cost estimate, and regulatory authority response. Distinct from dg_incident (which focuses on DG transport regulatory obligations) and hse_incident (which focuses on worker safety) — this entity owns the environmental impact and remediation lifecycle.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`alert` (
    `alert_id` BIGINT COMMENT 'Unique identifier for the safety alert record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the HSE manager or authorized personnel who approved the safety alert for publication.',
    `alert_issuing_employee_id` BIGINT COMMENT 'Identifier of the HSE employee who authored or issued the safety alert.',
    `alert_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified the safety alert record.',
    `facility_id` BIGINT COMMENT 'Identifier of the specific facility to which the alert applies, if the alert is facility-specific. Null for broader-scope alerts.',
    `hse_incident_id` BIGINT COMMENT 'Reference to the HSE incident record that triggered this safety alert, if the alert is a lessons-learned notice derived from a specific incident investigation.',
    `supersedes_alert_id` BIGINT COMMENT 'Identifier of the previous safety alert that this alert replaces or supersedes. Used to maintain alert version history and ensure outdated information is retired.',
    `training_id` BIGINT COMMENT 'Identifier of the training course that recipients must complete in response to this alert, if training is required.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Safety alerts often reference specific transport documents that triggered the alert (DG declarations with errors, shipping papers with violations). Enables traceability from alert to source document f',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Safety alerts triggered by specific shipment incidents (DG packaging failure, temperature excursion, security breach) require shipment reference for targeted distribution to affected stakeholders, cor',
    `observation_id` BIGINT COMMENT 'Foreign key linking to safety.safety_observation. Business justification: Safety alerts may be issued based on specific safety observations or observation trends. This FK links the alert to the observation that triggered it, supporting alert effectiveness tracking and obser',
    `superseded_alert_id` BIGINT COMMENT 'Self-referencing FK on alert (superseded_alert_id)',
    `acknowledgement_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of recipients who have acknowledged the alert, calculated as (acknowledgements_received / total_recipients) * 100. Used to track compliance with acknowledgement requirements.',
    `acknowledgement_deadline` DATE COMMENT 'Target date by which all recipients should acknowledge the safety alert. Applicable only when acknowledgement is required.',
    `acknowledgement_required_flag` BOOLEAN COMMENT 'Indicates whether recipients are required to formally acknowledge receipt and understanding of the safety alert. True if acknowledgement is mandatory, false otherwise.',
    `acknowledgements_received` STRING COMMENT 'Number of recipients who have formally acknowledged receipt and understanding of the safety alert.',
    `alert_description` STRING COMMENT 'Detailed narrative describing the safety-critical information, hazard details, regulatory changes, lessons learned, or recommended actions. Provides full context for the alert.',
    `alert_number` STRING COMMENT 'Business-facing unique reference number for the safety alert, used for external communication and tracking (e.g., SA-2024-001).',
    `alert_status` STRING COMMENT 'Current lifecycle status of the safety alert: draft for initial creation, pending approval for review stage, active for published and in-effect alerts, superseded when replaced by newer alert, archived for historical reference, or cancelled if withdrawn.. Valid values are `draft|pending approval|active|superseded|archived|cancelled`',
    `alert_type` STRING COMMENT 'Classification of the safety alert indicating the nature of the communication: safety bulletin for general safety information, lessons learned notice for incident-derived insights, regulatory update for compliance changes, dangerous goods (DG) advisory for hazmat handling updates, weather advisory for environmental hazards, or environmental advisory for ecological concerns.. Valid values are `safety bulletin|lessons learned notice|regulatory update|dangerous goods advisory|weather advisory|environmental advisory`',
    `approval_date` DATE COMMENT 'Date when the safety alert was formally approved for distribution.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, images, or files attached to the safety alert (e.g., photos, diagrams, procedure documents).',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for country-specific alerts (e.g., USA, GBR, DEU). Null for global or regional alerts.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the safety alert record was first created in the system.',
    `dangerous_goods_un_number` STRING COMMENT 'UN number of the dangerous goods substance addressed in the alert, if the alert pertains to hazardous materials handling (e.g., UN1203 for gasoline).',
    `distribution_method` STRING COMMENT 'Primary communication channel used to distribute the safety alert to the target audience: email for electronic distribution, intranet for portal posting, mobile app for push notifications, printed notice for physical postings, toolbox talk for in-person briefings, or all channels for critical alerts requiring multi-channel distribution.. Valid values are `email|intranet|mobile app|printed notice|toolbox talk|all channels`',
    `document_url` STRING COMMENT 'URL or file path to the full safety alert document or supporting materials stored in the document management system.',
    `effective_date` DATE COMMENT 'Date from which the safety alert becomes effective and applicable to operations. May differ from issue date to allow preparation time.',
    `expiration_date` DATE COMMENT 'Date when the safety alert is no longer applicable or has been superseded. Null for alerts with indefinite validity.',
    `geographic_scope` STRING COMMENT 'Geographic applicability of the safety alert: global for all Transport Shipping operations worldwide, regional for specific regions, country for single-country operations, or facility for location-specific alerts.. Valid values are `global|regional|country|facility`',
    `hazard_category` STRING COMMENT 'Classification of the hazard or risk addressed by the alert (e.g., slip/trip/fall, vehicle collision, dangerous goods exposure, ergonomic, environmental spill, weather-related). [ENUM-REF-CANDIDATE: slip trip fall|vehicle collision|dangerous goods exposure|ergonomic|environmental spill|weather related|fire|electrical|confined space|working at height|manual handling — promote to reference product]',
    `issue_date` DATE COMMENT 'Date when the safety alert was officially issued and published to the target audience.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise date and time when the safety alert was published, supporting time-sensitive communication tracking.',
    `issuing_authority` STRING COMMENT 'Name of the department, team, or individual within Transport Shippings Health, Safety, and Environment (HSE) function responsible for issuing this alert.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the alert content (e.g., EN for English, ES for Spanish, DE for German). Supports multi-language safety communication.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the safety alert record was last updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or internal remarks related to the safety alert for HSE team reference.',
    `priority_level` STRING COMMENT 'Urgency classification of the safety alert indicating the severity of the hazard or importance of the information: critical for immediate life-safety threats, high for significant hazards requiring prompt action, medium for important but non-urgent information, low for general awareness.. Valid values are `critical|high|medium|low`',
    `recommended_actions` STRING COMMENT 'Specific actions, controls, or behaviors recommended for recipients to mitigate the hazard or comply with the alert guidance.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or governing organization that issued the regulation or guidance prompting this alert (e.g., OSHA, IMO, IATA, DOT, WCO). Applicable for regulatory update alerts.',
    `regulatory_reference` STRING COMMENT 'Citation or reference number of the regulation, standard, or guidance document that is the subject of the alert (e.g., 29 CFR 1910.134, IMDG Code Amendment 40-20).',
    `review_date` DATE COMMENT 'Scheduled date for periodic review of the alert to assess continued relevance and accuracy. Supports ongoing alert lifecycle management.',
    `subject` STRING COMMENT 'Concise subject line or title of the safety alert summarizing the key message or hazard being communicated.',
    `target_audience` STRING COMMENT 'Intended recipient groups for the safety alert (e.g., all staff, drivers, warehouse personnel, dangerous goods handlers, management, specific facilities). May be comma-separated list for multiple audiences. [ENUM-REF-CANDIDATE: all staff|drivers|warehouse|dangerous goods handlers|management|facility managers|fleet operators|customs brokers|customer service|maintenance|security — promote to reference product]',
    `total_recipients` STRING COMMENT 'Total number of employees or personnel to whom the safety alert was distributed.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether the alert requires recipients to complete specific training or refresher courses. True if training is mandated, false otherwise.',
    `translation_available_flag` BOOLEAN COMMENT 'Indicates whether the safety alert has been translated into additional languages for multi-lingual workforce communication. True if translations exist, false otherwise.',
    CONSTRAINT pk_alert PRIMARY KEY(`alert_id`)
) COMMENT 'Master record for safety alerts and safety bulletins issued by Transport Shippings HSE function to communicate safety-critical information, lessons learned from incidents, regulatory changes, or emerging hazards to operational teams. Captures alert reference number, alert type (safety bulletin, lessons-learned notice, regulatory update, DG advisory, weather/environmental advisory), subject, issuing authority, issue date, target audience (all staff, drivers, warehouse, DG handlers), distribution method, acknowledgement required flag, and acknowledgement completion rate. Supports proactive safety communication and regulatory awareness.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` (
    `fatigue_risk_assessment_id` BIGINT COMMENT 'Unique identifier for the fatigue risk assessment record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Reference to the specific shipment or freight order associated with the duty assignment being assessed, if applicable.',
    `driver_safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.driver_safety_program. Business justification: Fatigue risk assessments are conducted as part of driver safety programs (e.g., Hours of Service compliance program). This FK links assessments to the program they support, enabling program effectiven',
    `facility_id` BIGINT COMMENT 'Reference to the facility, depot, or operational base where the assessment was conducted or where the employee is based.',
    `plan_id` BIGINT COMMENT 'Reference to the route or duty assignment associated with this fatigue risk assessment, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the driver or operational crew member being assessed for fatigue risk.',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Fatigue assessments conducted during specific transport legs (long-haul, night shifts) enable leg-specific duty hour compliance (HOS), route modification decisions, and relief driver assignment. Criti',
    `tertiary_fatigue_assessor_employee_id` BIGINT COMMENT 'Reference to the employee (supervisor, safety officer, or medical professional) who conducted the fatigue risk assessment.',
    `transport_asset_id` BIGINT COMMENT 'Reference to the vehicle or equipment unit assigned to the crew member for the duty period under assessment.',
    `followup_fatigue_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on fatigue_risk_assessment (followup_fatigue_risk_assessment_id)',
    `assessed_fatigue_risk_level` STRING COMMENT 'The overall fatigue risk level determined by the assessment. Low indicates minimal risk; medium indicates moderate risk requiring monitoring; high indicates significant risk requiring intervention; critical indicates immediate safety concern.. Valid values are `low|medium|high|critical`',
    `assessment_datetime` TIMESTAMP COMMENT 'The date and time when the fatigue risk assessment was conducted. This is the principal business event timestamp for the assessment.',
    `assessment_location` STRING COMMENT 'Description of the physical location where the fatigue risk assessment was conducted (e.g., terminal office, roadside inspection point, crew rest facility).',
    `assessment_method` STRING COMMENT 'The methodology or tool used to conduct the fatigue risk assessment (e.g., FAID score, Samn-Perelli scale, biomathematical model, structured interview, performance testing).',
    `assessment_number` STRING COMMENT 'Business-facing unique reference number for the fatigue risk assessment, used for tracking and reporting purposes.',
    `assessment_outcome` STRING COMMENT 'The final outcome or decision resulting from the fatigue risk assessment. Cleared indicates the employee is fit for duty; modified duty indicates restrictions or adjustments were applied; stood down indicates the employee was removed from duty; referred medical indicates further medical evaluation is required.. Valid values are `cleared|modified_duty|stood_down|referred_medical|pending_review`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the fatigue risk assessment process.. Valid values are `initiated|in_progress|completed|cancelled|under_review`',
    `assessment_trigger` STRING COMMENT 'The event or condition that initiated this fatigue risk assessment. Scheduled assessments are routine; post-incident assessments follow safety events; regulatory assessments are mandated by compliance requirements; operational change assessments occur when duty assignments are modified; supervisor request and self-report are initiated by management or the crew member.. Valid values are `scheduled|post_incident|regulatory|operational_change|supervisor_request|self_report`',
    `assessor_name` STRING COMMENT 'Full name of the individual who conducted the fatigue risk assessment.',
    `assessor_role` STRING COMMENT 'The role or title of the assessor (e.g., operations supervisor, safety manager, occupational health physician, FRMS coordinator).',
    `countermeasures_applied` STRING COMMENT 'Description of fatigue mitigation countermeasures applied or recommended, such as rest break scheduling, route splitting, relief driver assignment, duty reassignment, or operational delay.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fatigue risk assessment record was first created in the system.',
    `duty_end_datetime` TIMESTAMP COMMENT 'The scheduled or actual date and time when the duty period or shift is expected to end.',
    `duty_restriction_description` STRING COMMENT 'Detailed description of any duty restrictions or modifications imposed as a result of the assessment (e.g., no night driving, reduced hours, local routes only).',
    `duty_start_datetime` TIMESTAMP COMMENT 'The date and time when the current duty period or shift began for the assessed employee.',
    `employee_role` STRING COMMENT 'The operational role of the employee at the time of assessment (e.g., long-haul driver, local delivery driver, flight crew, warehouse operator).',
    `fatigue_score` STRING COMMENT 'Numerical score representing the quantified fatigue risk level, typically on a standardized scale (e.g., 0-100), where higher scores indicate greater fatigue risk.',
    `follow_up_date` DATE COMMENT 'The scheduled date for the follow-up fatigue risk assessment, if required.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up assessment or monitoring is required for this employee.',
    `hos_compliance_status` STRING COMMENT 'Indicates whether the employee is in compliance with applicable hours-of-service regulations at the time of assessment. HOS refers to Hours of Service regulations governing maximum driving and duty hours.. Valid values are `compliant|approaching_limit|violation|exemption_applied`',
    `hos_violation_type` STRING COMMENT 'Description of the specific hours-of-service regulation that has been violated or is at risk of violation, if applicable.',
    `hours_driving` DECIMAL(18,2) COMMENT 'Total number of hours the employee has spent actively driving at the time of assessment.',
    `hours_on_duty` DECIMAL(18,2) COMMENT 'Total number of hours the employee has been on duty at the time of assessment, including driving and non-driving work time.',
    `hours_since_last_rest` DECIMAL(18,2) COMMENT 'Number of hours elapsed since the employees last qualifying rest or sleep period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fatigue risk assessment record was last updated or modified.',
    `last_rest_duration_hours` DECIMAL(18,2) COMMENT 'Duration in hours of the employees most recent rest or sleep period.',
    `notes` STRING COMMENT 'Additional free-text notes or observations recorded by the assessor during the fatigue risk assessment.',
    `objective_fatigue_indicators` STRING COMMENT 'Observable or measurable indicators of fatigue identified during the assessment (e.g., reaction time test results, eye tracking data, behavioral observations).',
    `regulatory_framework` STRING COMMENT 'The specific regulatory framework or standard under which this assessment was conducted (e.g., FMCSA Part 395, EU Regulation 561/2006, ICAO Annex 6, national aviation authority FRMS requirements).',
    `regulatory_report_submitted_date` DATE COMMENT 'The date on which the fatigue risk assessment was reported to the relevant regulatory authority, if applicable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this fatigue risk assessment or its outcome must be reported to a regulatory authority.',
    `relief_driver_assigned` BOOLEAN COMMENT 'Indicates whether a relief driver was assigned to take over the duty assignment due to fatigue risk.',
    `rest_break_duration_minutes` STRING COMMENT 'Duration in minutes of the scheduled rest break, if applicable.',
    `rest_break_scheduled` BOOLEAN COMMENT 'Indicates whether a mandatory or recommended rest break was scheduled as a result of this assessment.',
    `route_modified` BOOLEAN COMMENT 'Indicates whether the route or duty assignment was modified (e.g., shortened, split, or rescheduled) as a result of the fatigue assessment.',
    `sleep_opportunity_adequacy` STRING COMMENT 'Assessment of whether the employee had adequate opportunity for restorative sleep prior to the current duty period.. Valid values are `adequate|marginal|inadequate|unknown`',
    `subjective_fatigue_rating` STRING COMMENT 'Self-reported fatigue level provided by the employee, typically on a standardized scale (e.g., 1-10 or Karolinska Sleepiness Scale).',
    CONSTRAINT pk_fatigue_risk_assessment PRIMARY KEY(`fatigue_risk_assessment_id`)
) COMMENT 'Transactional record capturing fatigue risk assessments for Transport Shipping drivers and operational crew on high-risk routes or extended duty periods. Captures assessment trigger (scheduled, post-incident, regulatory, operational change), driver or crew reference, route or duty assignment reference, assessed fatigue risk level (low, medium, high, critical), hours-of-service compliance status, sleep opportunity adequacy, countermeasures applied (rest break scheduling, route splitting, relief driver), assessment outcome (cleared, modified duty, stood down), and assessor identity. Supports FMCSA fatigue management, EU Regulation 561/2006, and ICAO fatigue risk management system (FRMS) compliance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` (
    `hse_legal_register_id` BIGINT COMMENT 'Unique identifier for the HSE legal register entry. Primary key for the HSE legal and regulatory obligations register.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key reference to the corrective action record tracking remediation activities for compliance gaps. Null if no action required.',
    `facility_id` BIGINT COMMENT 'Foreign key reference to the specific facility or site where this regulation applies. Null if regulation applies enterprise-wide or to multiple facilities.',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Legal obligations in the HSE legal register drive the creation and operation of safety programs (e.g., OSHA 1910.134 respiratory protection standard → Respiratory Protection Program). This FK links ea',
    `employee_id` BIGINT COMMENT 'Employee identifier of the individual accountable for ensuring compliance with this regulation within Transport Shipping (typically HSE manager, compliance officer, or department head).',
    `quaternary_hse_responsible_owner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `superseded_by_regulation_hse_legal_register_id` BIGINT COMMENT 'Foreign key reference to the newer regulation that supersedes this entry. Null if not superseded.',
    `tertiary_hse_last_modified_by_user_employee_id` BIGINT COMMENT 'Employee identifier of the user who last modified this register entry.',
    `superseded_hse_legal_register_id` BIGINT COMMENT 'Self-referencing FK on hse_legal_register (superseded_hse_legal_register_id)',
    `amendment_date` DATE COMMENT 'Date of the most recent amendment, revision, or update to the regulation. Null if no amendments since original effective date.',
    `applicability_to_operations` STRING COMMENT 'Detailed description of how and where the regulation applies to Transport Shipping operations, including specific business units, facilities, activities, or processes covered.',
    `compliance_gap_description` STRING COMMENT 'Detailed description of any identified compliance gaps, deficiencies, or non-conformances. Null if status is compliant or not_applicable.',
    `compliance_obligation_detail` STRING COMMENT 'Comprehensive detailed description of all specific compliance obligations, including reporting requirements, operational controls, training mandates, record-keeping duties, and performance standards.',
    `compliance_obligation_summary` STRING COMMENT 'Concise summary of the key compliance requirements, duties, and obligations imposed by the regulation on Transport Shipping.',
    `compliance_status` STRING COMMENT 'Current compliance status: compliant (fully meeting requirements), gap_identified (deficiency found but not critical), action_required (corrective action in progress), not_applicable (regulation does not apply), under_review (assessment in progress), or non_compliant (material breach).. Valid values are `compliant|gap_identified|action_required|not_applicable|under_review|non_compliant`',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator whether corrective action is required to achieve or maintain compliance. True if action needed, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this register entry was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the regulation came into force or became legally binding.',
    `expiration_date` DATE COMMENT 'Date when the regulation ceases to be in force or is superseded. Null for regulations with no defined end date.',
    `hse_domain` STRING COMMENT 'Primary HSE domain category that the regulation addresses: occupational health, workplace safety, environmental protection, dangerous goods handling, emergency response, or process safety management.. Valid values are `occupational_health|workplace_safety|environmental|dangerous_goods|emergency_response|process_safety`',
    `internal_document_reference` STRING COMMENT 'Reference to internal Transport Shipping policy, procedure, or compliance document that implements this regulation (e.g., document management system reference, SharePoint path).',
    `iso_45001_clause_reference` STRING COMMENT 'Reference to the specific ISO 45001:2018 clause(s) that this regulation supports or relates to (e.g., 6.1.3 Legal requirements and other requirements).',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code identifying the country where the regulation applies (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_scope` STRING COMMENT 'Geographic scope of the regulations applicability: international (multi-country treaty), national (country-wide), state (state/province), local (city/municipality), or facility (site-specific permit).. Valid values are `international|national|state|local|facility`',
    `jurisdiction_state_province` STRING COMMENT 'State, province, or regional subdivision within the country where the regulation applies (e.g., California, Ontario, Bavaria). Null for national-level regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this register entry was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when Transport Shipping last reviewed this regulation for applicability, compliance status, and obligation updates.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this regulations applicability and compliance status.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the regulation, its interpretation, or compliance approach.',
    `penalty_for_non_compliance` STRING COMMENT 'Description of potential penalties, fines, sanctions, or legal consequences for non-compliance with the regulation.',
    `record_retention_years` STRING COMMENT 'Minimum number of years that compliance records, documentation, and evidence must be retained as mandated by the regulation. Null if no specific retention requirement.',
    `register_entry_number` STRING COMMENT 'Business-assigned unique reference number for the legal register entry, used for tracking and audit purposes.',
    `register_status` STRING COMMENT 'Lifecycle status of this register entry: active (current and applicable), superseded (replaced by newer regulation), archived (no longer applicable), or under_review (applicability being assessed).. Valid values are `active|superseded|archived|under_review`',
    `regulation_name` STRING COMMENT 'Full official name or title of the health, safety, or environmental legislation, regulation, standard, or code of practice.',
    `regulation_reference_number` STRING COMMENT 'Official citation, act number, or reference code assigned by the regulatory authority (e.g., 29 CFR 1910, ISO 45001:2018).',
    `regulation_source_url` STRING COMMENT 'Web URL or hyperlink to the official source document, regulatory authority website, or legal database where the full regulation text can be accessed.',
    `regulation_type` STRING COMMENT 'Classification of the legal obligation: legislation (primary law), regulation (statutory instrument), standard (ISO/industry standard), code of practice (approved code), permit condition (site-specific requirement), or guideline (non-binding best practice).. Valid values are `legislation|regulation|standard|code_of_practice|permit_condition|guideline`',
    `regulatory_body` STRING COMMENT 'Name of the government agency, international organization, or standards body that issued or enforces the regulation (e.g., OSHA, IMO, IATA, WCO, ISO).',
    `reporting_frequency` STRING COMMENT 'Frequency of mandatory regulatory reporting: annual, quarterly, monthly, event_driven (triggered by incidents), as_required (ad-hoc), or none (no reporting requirement).. Valid values are `annual|quarterly|monthly|event_driven|as_required|none`',
    `reporting_requirement_flag` BOOLEAN COMMENT 'Boolean indicator whether the regulation mandates periodic or event-driven reporting to regulatory authorities. True if reporting required, False otherwise.',
    `responsible_department` STRING COMMENT 'Department or business unit with primary responsibility for managing compliance with this regulation (e.g., HSE, Operations, Fleet Management, Warehouse Operations).',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between periodic reviews of this regulation (e.g., 12 for annual review, 24 for biennial).',
    `training_requirement_description` STRING COMMENT 'Description of mandatory training, certification, or competency requirements specified by the regulation. Null if no training requirement.',
    `training_requirement_flag` BOOLEAN COMMENT 'Boolean indicator whether the regulation mandates specific training or competency requirements for employees. True if training required, False otherwise.',
    CONSTRAINT pk_hse_legal_register PRIMARY KEY(`hse_legal_register_id`)
) COMMENT 'Master record for Transport Shippings HSE legal and regulatory obligations register, tracking all applicable health, safety, and environmental legislation, regulations, standards, and codes of practice across operating jurisdictions. Captures regulation name, regulatory body, jurisdiction (country/state), regulation type (legislation, regulation, standard, code of practice, permit condition), applicability to Transport Shipping operations, compliance obligation description, responsible owner, compliance status (compliant, gap identified, not applicable), last review date, and next review date. Serves as the SSOT for HSE regulatory compliance obligations management under ISO 45001 Clause 6.1.3.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` (
    `program_training_requirement_id` BIGINT COMMENT 'Unique identifier for this program-training requirement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who created this training requirement for the program.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified this requirement record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to the safety program that requires this training',
    `safety_program_id` BIGINT COMMENT 'Foreign key to safety_program',
    `safety_training_id` BIGINT COMMENT 'Foreign key to safety_training',
    `training_id` BIGINT COMMENT 'Foreign key linking to the safety training course required by this program',
    `completion_deadline_days` STRING COMMENT 'Number of days from program enrollment or effective date by which this training must be completed. Used for compliance tracking and scheduling.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this program-training requirement record was created in the system.',
    `effective_date` DATE COMMENT 'Date from which this training requirement becomes effective for this program. Allows phased rollout of training requirements.',
    `exemption_criteria` STRING COMMENT 'Description of conditions under which a program participant may be exempted from this training requirement (e.g., holds equivalent external certification, completed equivalent training within 12 months, role does not involve DG handling).',
    `expiration_date` DATE COMMENT 'Date after which this training is no longer required for this program. Null indicates ongoing requirement.',
    `frequency_months` STRING COMMENT 'Number of months between required completions or refreshers for this training within this program. Null indicates one-time requirement with no refresher.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this training is mandatory for participants in this specific program. Complements requirement_type with a simple boolean flag for compliance reporting.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this requirement record.',
    `regulatory_basis` STRING COMMENT 'Specific regulatory standard, law, or certification requirement that mandates this training for this program (e.g., ISO 45001 clause 7.2, OSHA 1910.178, IATA DGR 1.5). May differ from the training courses general regulatory basis.',
    `requirement_status` STRING COMMENT 'Current lifecycle status of this training requirement within the program. Active requirements are enforced; suspended are temporarily not enforced; under review are being evaluated; retired are no longer applicable.',
    `requirement_type` STRING COMMENT 'Classification of the requirement level for this training within this program. Mandatory training must be completed by all program participants; recommended is strongly advised; conditional depends on role or risk exposure; optional is available but not required.',
    `target_audience_role` STRING COMMENT 'Specific role, job function, or participant category within the program for which this training is required (e.g., all drivers, warehouse supervisors, DG handlers, program coordinators). Allows role-specific training requirements within a program.',
    CONSTRAINT pk_program_training_requirement PRIMARY KEY(`program_training_requirement_id`)
) COMMENT 'This association product represents the training curriculum requirements between safety programs and safety training courses. It captures which training courses are required for each safety program, the nature of that requirement (mandatory vs recommended), frequency of completion or refresher, and target audience within the program. Each record links one safety program to one training course with attributes that exist only in the context of this program-training relationship.. Existence Justification: Safety programs define comprehensive HSE management systems (ISO 45001, OSHA VPP, driver safety, DG safety) that each require multiple training courses as part of their curriculum. Training courses are designed as reusable learning modules that support multiple programs across the organization. The business actively manages program training requirements as a distinct operational entity with attributes like requirement type, frequency, mandatory status, deadlines, and target audience roles that exist only in the context of a specific program-training pairing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` (
    `hub_emergency_plan_id` BIGINT COMMENT 'Primary key for the hub_emergency_plan association',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to the emergency response plan master record',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to the hub or gateway facility master record',
    `assignment_date` DATE COMMENT 'Date when this emergency response plan was assigned to this hub/gateway facility for operational implementation',
    `assignment_status` STRING COMMENT 'Current operational status of this plan assignment at this hub (active, inactive, suspended, under_review)',
    `communication_cascade` STRING COMMENT 'Hub-specific communication cascade procedure outlining notification sequence for personnel at this facility when this emergency plan is activated',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of this emergency response plan at this hub/gateway, indicating whether the facility meets all requirements for this plan type (compliant, non_compliant, pending_review, exempted, overdue)',
    `coordination_protocol` STRING COMMENT 'Documented procedure for coordinating emergency response between the hub facility and the plans emergency coordinator, including escalation paths and communication channels specific to this hub-plan combination',
    `facility_specific_notes` STRING COMMENT 'Free-text notes capturing facility-specific considerations, adaptations, or constraints for implementing this emergency plan at this hub/gateway',
    `last_drill_date` DATE COMMENT 'Date when the most recent emergency drill or simulation exercise was conducted for this plan at this specific hub/gateway facility',
    `local_emergency_contact` STRING COMMENT 'Hub-specific emergency contact person and phone number for this plan, may differ from the plans global emergency coordinator',
    `next_drill_date` DATE COMMENT 'Scheduled date for the next emergency drill or simulation exercise to test this plan at this specific hub/gateway facility',
    `plan_activation_authority` STRING COMMENT 'Designated authority or role responsible for activating this specific emergency response plan at this hub/gateway facility (e.g., Hub Manager, Safety Officer, Regional Emergency Coordinator)',
    CONSTRAINT pk_hub_emergency_plan PRIMARY KEY(`hub_emergency_plan_id`)
) COMMENT 'This association product represents the assignment of emergency response plans to hub and gateway facilities. It captures the operational readiness, compliance status, and drill execution for each plan-hub combination. Each record links one emergency response plan to one hub/gateway with attributes that track activation authority, coordination protocols, drill history, and regulatory compliance specific to that facility-plan pairing.. Existence Justification: In Transport Shipping logistics operations, major hub and gateway facilities require multiple emergency response plans covering different scenarios (fire, hazmat spill, dangerous goods incident, natural disaster, security threat), and each emergency response plan must be deployed across multiple hub locations where those scenarios could occur. The business actively manages the assignment of plans to hubs, tracking facility-specific activation protocols, drill schedules, compliance status, and coordination procedures for each hub-plan pairing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`safety`.`coaching_session` (
    `coaching_session_id` BIGINT COMMENT 'Primary key for coaching_session',
    `followup_coaching_session_id` BIGINT COMMENT 'Self-referencing FK on coaching_session (followup_coaching_session_id)',
    CONSTRAINT pk_coaching_session PRIMARY KEY(`coaching_session_id`)
) COMMENT 'Master reference table for coaching_session. Referenced by coaching_session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ADD CONSTRAINT `fk_safety_hse_incident_related_hse_incident_id` FOREIGN KEY (`related_hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_reopened_incident_investigation_id` FOREIGN KEY (`reopened_incident_investigation_id`) REFERENCES `transport_shipping_ecm`.`safety`.`incident_investigation`(`incident_investigation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `transport_shipping_ecm`.`safety`.`observation`(`observation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_parent_corrective_action_id` FOREIGN KEY (`parent_corrective_action_id`) REFERENCES `transport_shipping_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ADD CONSTRAINT `fk_safety_osha_recordable_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ADD CONSTRAINT `fk_safety_osha_recordable_related_osha_recordable_id` FOREIGN KEY (`related_osha_recordable_id`) REFERENCES `transport_shipping_ecm`.`safety`.`osha_recordable`(`osha_recordable_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_previous_audit_id` FOREIGN KEY (`previous_audit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ADD CONSTRAINT `fk_safety_audit_followup_audit_id` FOREIGN KEY (`followup_audit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ADD CONSTRAINT `fk_safety_safety_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ADD CONSTRAINT `fk_safety_safety_audit_finding_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `transport_shipping_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ADD CONSTRAINT `fk_safety_safety_audit_finding_previous_finding_safety_audit_finding_id` FOREIGN KEY (`previous_finding_safety_audit_finding_id`) REFERENCES `transport_shipping_ecm`.`safety`.`safety_audit_finding`(`safety_audit_finding_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ADD CONSTRAINT `fk_safety_safety_audit_finding_related_safety_audit_finding_id` FOREIGN KEY (`related_safety_audit_finding_id`) REFERENCES `transport_shipping_ecm`.`safety`.`safety_audit_finding`(`safety_audit_finding_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ADD CONSTRAINT `fk_safety_facility_inspection_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `transport_shipping_ecm`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ADD CONSTRAINT `fk_safety_facility_inspection_followup_facility_inspection_id` FOREIGN KEY (`followup_facility_inspection_id`) REFERENCES `transport_shipping_ecm`.`safety`.`facility_inspection`(`facility_inspection_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ADD CONSTRAINT `fk_safety_dg_certification_renewed_dg_certification_id` FOREIGN KEY (`renewed_dg_certification_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_certification`(`dg_certification_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_dg_certification_id` FOREIGN KEY (`dg_certification_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_certification`(`dg_certification_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ADD CONSTRAINT `fk_safety_dg_incident_related_dg_incident_id` FOREIGN KEY (`related_dg_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_incident`(`dg_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ADD CONSTRAINT `fk_safety_driver_safety_program_superseded_driver_safety_program_id` FOREIGN KEY (`superseded_driver_safety_program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_program`(`driver_safety_program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_coaching_session_id` FOREIGN KEY (`coaching_session_id`) REFERENCES `transport_shipping_ecm`.`safety`.`coaching_session`(`coaching_session_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_driver_safety_program_id` FOREIGN KEY (`driver_safety_program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_program`(`driver_safety_program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ADD CONSTRAINT `fk_safety_driver_safety_event_related_driver_safety_event_id` FOREIGN KEY (`related_driver_safety_event_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_event`(`driver_safety_event_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_prerequisite_training_id` FOREIGN KEY (`prerequisite_training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ADD CONSTRAINT `fk_safety_safety_training_completion_dg_certification_id` FOREIGN KEY (`dg_certification_id`) REFERENCES `transport_shipping_ecm`.`safety`.`dg_certification`(`dg_certification_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ADD CONSTRAINT `fk_safety_safety_training_completion_training_id` FOREIGN KEY (`training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ADD CONSTRAINT `fk_safety_safety_training_completion_retake_safety_training_completion_id` FOREIGN KEY (`retake_safety_training_completion_id`) REFERENCES `transport_shipping_ecm`.`safety`.`safety_training_completion`(`safety_training_completion_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ADD CONSTRAINT `fk_safety_emergency_response_plan_superseded_emergency_response_plan_id` FOREIGN KEY (`superseded_emergency_response_plan_id`) REFERENCES `transport_shipping_ecm`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `transport_shipping_ecm`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_followup_emergency_drill_id` FOREIGN KEY (`followup_emergency_drill_id`) REFERENCES `transport_shipping_ecm`.`safety`.`emergency_drill`(`emergency_drill_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_parent_hazard_register_id` FOREIGN KEY (`parent_hazard_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_superseded_by_assessment_risk_assessment_id` FOREIGN KEY (`superseded_by_assessment_risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_superseded_risk_assessment_id` FOREIGN KEY (`superseded_risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ADD CONSTRAINT `fk_safety_ppe_issuance_replacement_ppe_issuance_id` FOREIGN KEY (`replacement_ppe_issuance_id`) REFERENCES `transport_shipping_ecm`.`safety`.`ppe_issuance`(`ppe_issuance_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_followup_observation_id` FOREIGN KEY (`followup_observation_id`) REFERENCES `transport_shipping_ecm`.`safety`.`observation`(`observation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ADD CONSTRAINT `fk_safety_regulatory_notification_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ADD CONSTRAINT `fk_safety_regulatory_notification_amended_regulatory_notification_id` FOREIGN KEY (`amended_regulatory_notification_id`) REFERENCES `transport_shipping_ecm`.`safety`.`regulatory_notification`(`regulatory_notification_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ADD CONSTRAINT `fk_safety_permit_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ADD CONSTRAINT `fk_safety_permit_renewed_permit_id` FOREIGN KEY (`renewed_permit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`permit`(`permit_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ADD CONSTRAINT `fk_safety_occupational_health_case_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ADD CONSTRAINT `fk_safety_occupational_health_case_related_occupational_health_case_id` FOREIGN KEY (`related_occupational_health_case_id`) REFERENCES `transport_shipping_ecm`.`safety`.`occupational_health_case`(`occupational_health_case_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ADD CONSTRAINT `fk_safety_program_parent_program_id` FOREIGN KEY (`parent_program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ADD CONSTRAINT `fk_safety_contractor_safety_prequal_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `transport_shipping_ecm`.`safety`.`audit`(`audit_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ADD CONSTRAINT `fk_safety_contractor_safety_prequal_renewed_contractor_safety_prequal_id` FOREIGN KEY (`renewed_contractor_safety_prequal_id`) REFERENCES `transport_shipping_ecm`.`safety`.`contractor_safety_prequal`(`contractor_safety_prequal_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `transport_shipping_ecm`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ADD CONSTRAINT `fk_safety_environmental_incident_related_environmental_incident_id` FOREIGN KEY (`related_environmental_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_hse_incident_id` FOREIGN KEY (`hse_incident_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_incident`(`hse_incident_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_supersedes_alert_id` FOREIGN KEY (`supersedes_alert_id`) REFERENCES `transport_shipping_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_training_id` FOREIGN KEY (`training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `transport_shipping_ecm`.`safety`.`observation`(`observation_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ADD CONSTRAINT `fk_safety_alert_superseded_alert_id` FOREIGN KEY (`superseded_alert_id`) REFERENCES `transport_shipping_ecm`.`safety`.`alert`(`alert_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ADD CONSTRAINT `fk_safety_fatigue_risk_assessment_driver_safety_program_id` FOREIGN KEY (`driver_safety_program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`driver_safety_program`(`driver_safety_program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ADD CONSTRAINT `fk_safety_fatigue_risk_assessment_followup_fatigue_risk_assessment_id` FOREIGN KEY (`followup_fatigue_risk_assessment_id`) REFERENCES `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment`(`fatigue_risk_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ADD CONSTRAINT `fk_safety_hse_legal_register_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `transport_shipping_ecm`.`safety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ADD CONSTRAINT `fk_safety_hse_legal_register_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ADD CONSTRAINT `fk_safety_hse_legal_register_superseded_by_regulation_hse_legal_register_id` FOREIGN KEY (`superseded_by_regulation_hse_legal_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_legal_register`(`hse_legal_register_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ADD CONSTRAINT `fk_safety_hse_legal_register_superseded_hse_legal_register_id` FOREIGN KEY (`superseded_hse_legal_register_id`) REFERENCES `transport_shipping_ecm`.`safety`.`hse_legal_register`(`hse_legal_register_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ADD CONSTRAINT `fk_safety_program_training_requirement_program_id` FOREIGN KEY (`program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ADD CONSTRAINT `fk_safety_program_training_requirement_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `transport_shipping_ecm`.`safety`.`program`(`program_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ADD CONSTRAINT `fk_safety_program_training_requirement_safety_training_id` FOREIGN KEY (`safety_training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ADD CONSTRAINT `fk_safety_program_training_requirement_training_id` FOREIGN KEY (`training_id`) REFERENCES `transport_shipping_ecm`.`safety`.`training`(`training_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ADD CONSTRAINT `fk_safety_hub_emergency_plan_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `transport_shipping_ecm`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `transport_shipping_ecm`.`safety`.`coaching_session` ADD CONSTRAINT `fk_safety_coaching_session_followup_coaching_session_id` FOREIGN KEY (`followup_coaching_session_id`) REFERENCES `transport_shipping_ecm`.`safety`.`coaching_session`(`coaching_session_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`safety` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `transport_shipping_ecm`.`safety` SET TAGS ('dbx_domain' = 'safety');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health, Safety, and Environmental (HSE) Incident ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `cfs_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Cfs Operation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `corridor_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Corridor Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `intermodal_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Intermodal Transfer Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `related_hse_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Closed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `corrective_actions_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Completed Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `dangerous_goods_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Involved Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `days_restricted_duty` SET TAGS ('dbx_business_glossary_term' = 'Days on Restricted Duty');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `estimated_damage_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Property Damage Cost');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `estimated_damage_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Hazmat Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `immediate_cause` SET TAGS ('dbx_business_glossary_term' = 'Immediate Cause of Incident');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `incident_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Event Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Lifecycle Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_review|closed|reopened');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type Classification');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'injury|near_miss|property_damage|environmental_spill|vehicle_accident|hazmat_exposure');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Full Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `injured_party_type` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `injured_party_type` SET TAGS ('dbx_value_regex' = 'employee|contractor|third_party|public|none');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `investigation_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assigned To');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `property_damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `regulatory_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `reported_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Details');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'human_factors|equipment_failure|process_deficiency|environmental_conditions|training_gap|supervision_inadequate');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity Classification');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'fatality|lost_time_injury|recordable|medical_treatment|first_aid|near_miss');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|evening|rotating');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `spill_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Spill Volume in Liters');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions at Time of Incident');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_incident` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Report Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `reopened_incident_investigation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `corrective_actions_recommended` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Recommended');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `environmental_factors_identified` SET TAGS ('dbx_business_glossary_term' = 'Environmental Factors Identified');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `equipment_factors_identified` SET TAGS ('dbx_business_glossary_term' = 'Equipment Factors Identified');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `evidence_collected` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `external_investigator_engaged` SET TAGS ('dbx_business_glossary_term' = 'External Investigator Engaged');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `external_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'External Investigator Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `human_factors_identified` SET TAGS ('dbx_business_glossary_term' = 'Human Factors Identified');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `immediate_cause` SET TAGS ('dbx_business_glossary_term' = 'Immediate Cause');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `incident_scene_preserved` SET TAGS ('dbx_business_glossary_term' = 'Incident Scene Preserved');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Closed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Investigation Cost Currency');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Investigation Cost Estimate');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Investigation Duration Days');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Initiated Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Initiated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Investigation Methodology');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `investigation_team_members` SET TAGS ('dbx_business_glossary_term' = 'Investigation Team Members');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `lead_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `organizational_factors_identified` SET TAGS ('dbx_business_glossary_term' = 'Organizational Factors Identified');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `preventive_actions_recommended` SET TAGS ('dbx_business_glossary_term' = 'Preventive Actions Recommended');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `root_cause_determination` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Determination');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `witness_statements_summary` SET TAGS ('dbx_business_glossary_term' = 'Witness Statements Summary');
ALTER TABLE `transport_shipping_ecm`.`safety`.`incident_investigation` ALTER COLUMN `witness_statements_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Near Miss ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Related Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `quaternary_corrective_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `quaternary_corrective_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `quaternary_corrective_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `tertiary_corrective_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `tertiary_corrective_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `tertiary_corrective_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Completion Evidence Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `parent_corrective_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|improvement');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `assigned_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Outcome');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|pending_review');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `recurrence_prevention_measures` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Prevention Measures');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `regulatory_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Finding ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Action Title');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'inspection|audit|testing|documentation_review|observation|measurement');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed|reopen_required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `osha_recordable_id` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `related_osha_recordable_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `amputation_flag` SET TAGS ('dbx_business_glossary_term' = 'Amputation Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_classification` SET TAGS ('dbx_business_glossary_term' = 'OSHA Case Classification');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_classification` SET TAGS ('dbx_value_regex' = 'death|days_away_from_work|job_transfer_restriction|other_recordable');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA Case Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|closed|under_review|appealed');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `days_on_job_transfer_restriction` SET TAGS ('dbx_business_glossary_term' = 'Days on Job Transfer or Restriction');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `death_date` SET TAGS ('dbx_business_glossary_term' = 'Death Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `death_flag` SET TAGS ('dbx_business_glossary_term' = 'Death Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Event Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `eye_loss_flag` SET TAGS ('dbx_business_glossary_term' = 'Eye Loss Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Hire Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `hospitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospitalization Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `injury_illness_type` SET TAGS ('dbx_business_glossary_term' = 'Injury or Illness Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `injury_illness_type` SET TAGS ('dbx_value_regex' = 'injury|skin_disorder|respiratory_condition|poisoning|hearing_loss|other_illness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Employee Job Title');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `nature_of_injury_illness` SET TAGS ('dbx_business_glossary_term' = 'Nature of Injury or Illness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `osha_300a_included_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA 300A Annual Summary Included Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `physician_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Physician Diagnosis');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `physician_diagnosis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `privacy_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Case Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `recordable_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Recordable Determination Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'OSHA|RIDDOR|Safe_Work_Australia|EU_OSH_Directive');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `regulatory_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `regulatory_submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|phone|not_submitted');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'OSHA Reporting Year');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Facility Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `treatment_type` SET TAGS ('dbx_value_regex' = 'first_aid|medical_treatment|hospitalization|emergency_care');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `work_related_determination` SET TAGS ('dbx_business_glossary_term' = 'Work-Related Determination');
ALTER TABLE `transport_shipping_ecm`.`safety`.`osha_recordable` ALTER COLUMN `work_related_determination` SET TAGS ('dbx_value_regex' = 'work_related|not_work_related|under_review');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `previous_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Audit ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `followup_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `areas_audited` SET TAGS ('dbx_business_glossary_term' = 'Areas or Processes Audited');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_value_regex' = 'facility_wide|department_specific|process_specific|system_specific|multi_site|limited_scope');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory|third_party|certification|surveillance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `criteria` SET TAGS ('dbx_business_glossary_term' = 'Audit Criteria');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department or Business Unit');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `documents_reviewed_count` SET TAGS ('dbx_business_glossary_term' = 'Documents Reviewed Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration (Hours)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `employees_interviewed_count` SET TAGS ('dbx_business_glossary_term' = 'Employees Interviewed Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `follow_up_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `follow_up_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Scheduled Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `next_scheduled_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Audit Objective');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `observations_count` SET TAGS ('dbx_business_glossary_term' = 'Observations Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `overall_audit_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Rating');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `overall_audit_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory|critical');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `positive_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Positive Findings Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body or Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score (Percentage)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Audit Standard or Framework');
ALTER TABLE `transport_shipping_ecm`.`safety`.`audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `safety_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Finding ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action (CA) ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `previous_finding_safety_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `quaternary_safety_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `quaternary_safety_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `quaternary_safety_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `tertiary_safety_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `tertiary_safety_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `tertiary_safety_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `related_safety_audit_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `audit_program_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `cost_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Estimate');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `cost_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `evidence_collected` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'major_non_conformance|minor_non_conformance|observation|opportunity_for_improvement|positive_finding|critical_non_conformance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `likelihood_score` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `root_cause_analysis_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `standard_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Clause Reference');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `facility_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Template Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `followup_facility_inspection_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `checklist_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Checklist Completion Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `checklist_completion_status` SET TAGS ('dbx_value_regex' = 'not_started|partial|complete');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `critical_deficiencies` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiencies');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `deficiencies_found` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Found');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `deficiency_summary` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Summary');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `follow_up_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `follow_up_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `immediate_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Actions Taken');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|overdue');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'fire_safety|housekeeping|equipment|emergency_egress|hazmat_storage|electrical');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `items_inspected` SET TAGS ('dbx_business_glossary_term' = 'Items Inspected');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `major_deficiencies` SET TAGS ('dbx_business_glossary_term' = 'Major Deficiencies');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `minor_deficiencies` SET TAGS ('dbx_business_glossary_term' = 'Minor Deficiencies');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `overall_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Result');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `overall_inspection_result` SET TAGS ('dbx_value_regex' = 'pass|pass_with_observations|fail|incomplete');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Report Document Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `total_checklist_items` SET TAGS ('dbx_business_glossary_term' = 'Total Checklist Items');
ALTER TABLE `transport_shipping_ecm`.`safety`.`facility_inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `dg_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Certification ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `holder_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Holder ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `renewed_dg_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|cancelled');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `competency_level` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced|specialist|instructor');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `compliance_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Result');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `compliance_audit_result` SET TAGS ('dbx_value_regex' = 'pass|pass_with_observations|fail|not_audited');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `dg_class_coverage` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Class Coverage');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Holder Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `holder_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Holder Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `holder_type` SET TAGS ('dbx_value_regex' = 'employee|facility|vehicle|equipment|organizational_unit');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `issuing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_business_glossary_term' = 'Mode of Transport');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `mode_of_transport` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `next_recurrent_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recurrent Training Due Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `pass_threshold` SET TAGS ('dbx_business_glossary_term' = 'Pass Threshold');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `recurrent_training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recurrent Training Frequency (Months)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `regulatory_version` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Version');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `training_course_reference` SET TAGS ('dbx_business_glossary_term' = 'Training Course Reference');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|verification_failed|not_verified');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `dg_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Incident ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `air_waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `cfs_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Cfs Operation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `dg_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Handler Dg Certification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `environmental_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Environmental Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `related_dg_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Closure Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Implemented');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Incident Country Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `emergency_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Actions Taken');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `environmental_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Release Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Incident Cost');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `fatalities_reported` SET TAGS ('dbx_business_glossary_term' = 'Number of Fatalities Reported');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-6])?$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Incident Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^DGI-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|contained|resolved|closed');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'spillage|leakage|fire|explosion|contamination|mislabelling');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `injuries_reported` SET TAGS ('dbx_business_glossary_term' = 'Number of Injuries Reported');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `investigation_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Incident Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Sent Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `notified_authority` SET TAGS ('dbx_business_glossary_term' = 'Notified Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group (PG)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name (PSN)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `quantity_involved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Involved');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|liter|cubic_meter|piece');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'IATA_DGR|IMDG|ADR|RID|49CFR');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode at Incident');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|warehouse|terminal');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`dg_incident` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `driver_safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Program ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `superseded_driver_safety_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `actual_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Enrollment Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `applicable_driver_population` SET TAGS ('dbx_business_glossary_term' = 'Applicable Driver Population');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `applicable_driver_population` SET TAGS ('dbx_value_regex' = 'long_haul|last_mile|hazmat|all_drivers|regional|urban');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'written_exam|practical_test|observation|self_assessment|combined');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `certification_validity_days` SET TAGS ('dbx_business_glossary_term' = 'Certification Validity Days');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `completion_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Completion Rate Target');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'classroom|online|blended|on_the_job|simulator');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `enrollment_criteria` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Criteria');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `harsh_braking_rate_threshold` SET TAGS ('dbx_business_glossary_term' = 'Harsh Braking Rate Threshold');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `language_availability` SET TAGS ('dbx_business_glossary_term' = 'Language Availability');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_cost_per_driver` SET TAGS ('dbx_business_glossary_term' = 'Program Cost Per Driver');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_cost_per_driver` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Program Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Program Duration Days');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_objectives` SET TAGS ('dbx_business_glossary_term' = 'Program Objectives');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|completed|archived');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'defensive_driving|fatigue_management|distracted_driving|speed_compliance|load_securing|hazmat_safety');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'Program Version');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `program_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `regulatory_alignment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Alignment');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `seatbelt_compliance_rate_threshold` SET TAGS ('dbx_business_glossary_term' = 'Seatbelt Compliance Rate Threshold');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `speeding_events_threshold` SET TAGS ('dbx_business_glossary_term' = 'Speeding Events Threshold');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `target_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Target Enrollment Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'per_trip|per_100_miles|per_month|per_quarter');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `driver_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Event ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `coaching_session_id` SET TAGS ('dbx_business_glossary_term' = 'Coaching Session ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `driver_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `driver_safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `plan_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `telematics_event_id` SET TAGS ('dbx_business_glossary_term' = 'Telematics Event ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `related_driver_safety_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `coaching_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Coaching Completed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `coaching_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Coaching Completed Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `coaching_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Coaching Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `dashcam_footage_reference` SET TAGS ('dbx_business_glossary_term' = 'Dashcam Footage Reference');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `driver_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Driver Acknowledgment Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `driver_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Driver Acknowledgment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `driver_comment` SET TAGS ('dbx_business_glossary_term' = 'Driver Comment');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `event_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Event Duration (Seconds)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `event_source` SET TAGS ('dbx_value_regex' = 'telematics|dashcam|manual_report|adas|driver_app');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'harsh_braking|harsh_acceleration|speeding|sharp_cornering|mobile_phone_use|seatbelt_non_compliance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `g_force_value` SET TAGS ('dbx_business_glossary_term' = 'G-Force Value');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `incident_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `posted_speed_limit_kph` SET TAGS ('dbx_business_glossary_term' = 'Posted Speed Limit (KPH)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventable Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `road_condition` SET TAGS ('dbx_business_glossary_term' = 'Road Condition');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `road_condition` SET TAGS ('dbx_value_regex' = 'dry|wet|icy|snow_covered|gravel|construction');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `safety_score_impact` SET TAGS ('dbx_business_glossary_term' = 'Safety Score Impact');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `speed_over_limit_kph` SET TAGS ('dbx_business_glossary_term' = 'Speed Over Limit (KPH)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `supervisor_comment` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Comment');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `supervisor_review_status` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Review Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `supervisor_review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|approved|disputed|closed');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `supervisor_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Review Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `traffic_condition` SET TAGS ('dbx_business_glossary_term' = 'Traffic Condition');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `traffic_condition` SET TAGS ('dbx_value_regex' = 'light|moderate|heavy|congested|stopped');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `vehicle_speed_kph` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Speed (KPH)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`driver_safety_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Training ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `prerequisite_training_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `certification_validity_months` SET TAGS ('dbx_business_glossary_term' = 'Certification Validity Period (Months)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `competency_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_materials_location` SET TAGS ('dbx_business_glossary_term' = 'Course Materials Location');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_owner` SET TAGS ('dbx_business_glossary_term' = 'Course Owner');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|retired|draft');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Training Course Title');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_version` SET TAGS ('dbx_business_glossary_term' = 'Course Version');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `course_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Mode');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'classroom|e_learning|on_the_job|simulation|blended|virtual_instructor_led');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Hours)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Course Effective Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Course Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `external_provider_name` SET TAGS ('dbx_business_glossary_term' = 'External Training Provider Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `instructor_qualification_required` SET TAGS ('dbx_business_glossary_term' = 'Instructor Qualification Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `language_offered` SET TAGS ('dbx_business_glossary_term' = 'Language Offered');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `max_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `prerequisites` SET TAGS ('dbx_business_glossary_term' = 'Course Prerequisites');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `refresher_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Refresher Training Frequency (Months)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Basis');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Training Subcategory');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'induction|dangerous_goods_handling|fire_safety|manual_handling|first_aid|emergency_response');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `safety_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Completion ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Location ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `dg_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Dg Certification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `tertiary_safety_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `tertiary_safety_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `tertiary_safety_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `training_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Training Provider ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `retake_safety_training_completion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `attendance_hours` SET TAGS ('dbx_business_glossary_term' = 'Attendance Hours');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'passed|failed|incomplete|waived|expired');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Training Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|overdue|expiring_soon|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `dangerous_goods_category` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `delivery_location_name` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Location Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|blended|on_the_job|simulation');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Training Instructor Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `recertification_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Interval Months');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `training_language` SET TAGS ('dbx_business_glossary_term' = 'Training Language');
ALTER TABLE `transport_shipping_ecm`.`safety`.`safety_training_completion` ALTER COLUMN `training_start_date` SET TAGS ('dbx_business_glossary_term' = 'Training Start Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` SET TAGS ('dbx_subdomain' = 'risk_prevention');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `superseded_emergency_response_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `activation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Activation Trigger');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Approval Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `backup_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Backup Emergency Coordinator Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `backup_coordinator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `backup_coordinator_phone` SET TAGS ('dbx_business_glossary_term' = 'Backup Emergency Coordinator Phone Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `backup_coordinator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `backup_coordinator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `communication_cascade_procedure` SET TAGS ('dbx_business_glossary_term' = 'Communication Cascade Procedure');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `deactivation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Deactivation Criteria');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `drill_frequency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Frequency');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `drill_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|as_needed');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_email` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator Email Address');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Coordinator Phone Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_coordinator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `evacuation_assembly_point` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Assembly Point Location');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `fire_brigade_contact` SET TAGS ('dbx_business_glossary_term' = 'Fire Brigade Contact Information');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `fire_brigade_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `hazmat_team_contact` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Team Contact Information');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `hazmat_team_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `hospital_contact` SET TAGS ('dbx_business_glossary_term' = 'Hospital or Medical Facility Contact Information');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `hospital_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `last_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Emergency Drill Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `next_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Next Emergency Drill Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Document URL');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan (ERP) Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^ERP-[A-Z0-9]{6,12}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|suspended|archived');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'fire_evacuation|chemical_spill|dg_incident|natural_disaster|security_threat|pandemic');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Version');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `police_contact` SET TAGS ('dbx_business_glossary_term' = 'Police or Security Authority Contact Information');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `police_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `regulatory_compliance_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Basis');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Emergency Risk Level');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Scope Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `secondary_assembly_point` SET TAGS ('dbx_business_glossary_term' = 'Secondary Evacuation Assembly Point Location');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `special_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_response_plan` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` SET TAGS ('dbx_subdomain' = 'risk_prevention');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `emergency_drill_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Coordinator ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `tertiary_emergency_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `tertiary_emergency_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `tertiary_emergency_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `followup_emergency_drill_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `deficiencies_identified` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Identified');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_announcement_type` SET TAGS ('dbx_business_glossary_term' = 'Drill Announcement Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_announcement_type` SET TAGS ('dbx_value_regex' = 'announced|unannounced');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_date` SET TAGS ('dbx_business_glossary_term' = 'Drill Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Drill Duration (Minutes)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_end_time` SET TAGS ('dbx_business_glossary_term' = 'Drill End Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_number` SET TAGS ('dbx_business_glossary_term' = 'Drill Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_outcome` SET TAGS ('dbx_business_glossary_term' = 'Drill Outcome');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_outcome` SET TAGS ('dbx_value_regex' = 'successful|successful_with_deficiencies|unsuccessful|aborted');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Drill Report Document URL');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_start_time` SET TAGS ('dbx_business_glossary_term' = 'Drill Start Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_status` SET TAGS ('dbx_business_glossary_term' = 'Drill Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `drill_type` SET TAGS ('dbx_business_glossary_term' = 'Drill Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `evacuation_time_achieved_minutes` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Time Achieved (Minutes)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `evacuation_time_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Time Target (Minutes)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `evacuation_time_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Evacuation Time Variance (Minutes)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `external_agency_name` SET TAGS ('dbx_business_glossary_term' = 'External Agency Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `external_agency_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'External Agency Participation Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `follow_up_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Actions Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `next_drill_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Drill Scheduled Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`emergency_drill` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` SET TAGS ('dbx_subdomain' = 'risk_prevention');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `route_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Route Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `tertiary_hazard_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `tertiary_hazard_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `tertiary_hazard_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `parent_hazard_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `activity_or_process` SET TAGS ('dbx_business_glossary_term' = 'Activity or Process');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `affected_worker_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Worker Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `control_effectiveness` SET TAGS ('dbx_value_regex' = 'ineffective|partially_effective|effective|highly_effective');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `dangerous_goods_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Related Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `emergency_response_procedure` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Procedure');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `existing_controls` SET TAGS ('dbx_business_glossary_term' = 'Existing Controls');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_category` SET TAGS ('dbx_value_regex' = 'physical|chemical|biological|ergonomic|psychosocial|environmental');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Hazard Reference Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_reference_number` SET TAGS ('dbx_value_regex' = '^HAZ-[A-Z0-9]{6,12}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_status` SET TAGS ('dbx_business_glossary_term' = 'Hazard Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_status` SET TAGS ('dbx_value_regex' = 'active|mitigated|closed|under_review|pending_action');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Hazard Subcategory');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `hazard_title` SET TAGS ('dbx_business_glossary_term' = 'Hazard Title');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `incident_history_count` SET TAGS ('dbx_business_glossary_term' = 'Incident History Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_consequence` SET TAGS ('dbx_business_glossary_term' = 'Inherent Consequence');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_consequence` SET TAGS ('dbx_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Inherent Likelihood');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_likelihood` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Incident Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `public_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Exposure Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Actions');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_consequence` SET TAGS ('dbx_business_glossary_term' = 'Residual Consequence');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_consequence` SET TAGS ('dbx_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_likelihood` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `risk_acceptability` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptability');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `risk_acceptability` SET TAGS ('dbx_value_regex' = 'acceptable|tolerable|unacceptable');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `risk_treatment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Treatment Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `risk_treatment_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `risk_treatment_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hazard_register` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'risk_prevention');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessor Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `superseded_by_assessment_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Risk Assessment ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `superseded_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `approval_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `approval_authority_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `approval_authority_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Approval Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|expired|superseded');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_team_members` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Team Members');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'job_safety_analysis|task_risk_assessment|change_management_risk_assessment|new_facility_risk_assessment|route_risk_assessment|hazmat_transport_risk_assessment');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessor Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Comments');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `consultation_with_workers_flag` SET TAGS ('dbx_business_glossary_term' = 'Consultation with Workers Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `control_hierarchy_applied` SET TAGS ('dbx_business_glossary_term' = 'Control Hierarchy Applied');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `control_hierarchy_applied` SET TAGS ('dbx_value_regex' = 'elimination|substitution|engineering_controls|administrative_controls|ppe');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `control_measures_recommended` SET TAGS ('dbx_business_glossary_term' = 'Control Measures Recommended');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `dangerous_goods_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Involved Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `emergency_response_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `environmental_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `hazards_identified` SET TAGS ('dbx_business_glossary_term' = 'Hazards Identified');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `inherent_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Inherent Likelihood');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `inherent_likelihood` SET TAGS ('dbx_value_regex' = 'almost_certain|likely|possible|unlikely|rare');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `inherent_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Level');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `inherent_risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `inherent_severity` SET TAGS ('dbx_business_glossary_term' = 'Inherent Severity');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `inherent_severity` SET TAGS ('dbx_value_regex' = 'catastrophic|major|moderate|minor|insignificant');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `residual_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Residual Likelihood');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `residual_likelihood` SET TAGS ('dbx_value_regex' = 'almost_certain|likely|possible|unlikely|rare');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `residual_severity` SET TAGS ('dbx_business_glossary_term' = 'Residual Severity');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `residual_severity` SET TAGS ('dbx_value_regex' = 'catastrophic|major|moderate|minor|insignificant');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Review Due Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Review Frequency (Months)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_acceptable_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptable Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Methodology');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `risk_rating_methodology` SET TAGS ('dbx_value_regex' = 'risk_matrix_5x5|risk_matrix_3x3|quantitative_analysis|bow_tie_analysis|fmea|hazop');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Scope Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `training_description` SET TAGS ('dbx_business_glossary_term' = 'Training Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`risk_assessment` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `ppe_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Issuance ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `replacement_ppe_issuance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `acknowledgment_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Signature Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'PPE Certification Standard');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `compliance_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Met Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `condition_at_issue` SET TAGS ('dbx_business_glossary_term' = 'Condition at Issue');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `condition_at_issue` SET TAGS ('dbx_value_regex' = 'new|good|acceptable|refurbished');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `employee_role` SET TAGS ('dbx_business_glossary_term' = 'Employee Role');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `expected_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Replacement Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'PPE Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `fit_test_date` SET TAGS ('dbx_business_glossary_term' = 'Fit Test Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `fit_test_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Fit Test Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `fit_test_result` SET TAGS ('dbx_business_glossary_term' = 'Fit Test Result');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `fit_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_number` SET TAGS ('dbx_business_glossary_term' = 'PPE Issuance Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_reason` SET TAGS ('dbx_business_glossary_term' = 'Issuance Reason');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_reason` SET TAGS ('dbx_value_regex' = 'new_hire|replacement|additional|seasonal|special_project|lost_damaged');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_status` SET TAGS ('dbx_business_glossary_term' = 'Issuance Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issuance_status` SET TAGS ('dbx_value_regex' = 'issued|returned|lost|damaged|expired');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'PPE Issue Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PPE Issue Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'PPE Manufacturer');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Issuance Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `ppe_item_code` SET TAGS ('dbx_business_glossary_term' = 'PPE Item Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `ppe_item_description` SET TAGS ('dbx_business_glossary_term' = 'PPE Item Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `ppe_type` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `ppe_type` SET TAGS ('dbx_value_regex' = 'hard_hat|high_visibility_vest|safety_boots|gloves|respirator|hearing_protection');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `quantity_issued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `return_condition` SET TAGS ('dbx_business_glossary_term' = 'Return Condition');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `return_condition` SET TAGS ('dbx_value_regex' = 'good|worn|damaged|lost|destroyed');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'PPE Return Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'PPE Serial Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'PPE Size');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Issuance Cost');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'PPE Training Completed Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'PPE Training Completion Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'PPE Unit Cost');
ALTER TABLE `transport_shipping_ecm`.`safety`.`ppe_issuance` ALTER COLUMN `work_area` SET TAGS ('dbx_business_glossary_term' = 'Work Area');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Incident ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_observer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Observer Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_observer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_observer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Hazard Register Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `followup_observation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Action Completed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `action_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Action Verification Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `action_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|rejected');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `anonymous_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Submission Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Observation Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `follow_up_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `immediate_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_category` SET TAGS ('dbx_business_glossary_term' = 'Observation Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_description` SET TAGS ('dbx_business_glossary_term' = 'Observation Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_number` SET TAGS ('dbx_business_glossary_term' = 'Observation Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_number` SET TAGS ('dbx_value_regex' = '^OBS-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_business_glossary_term' = 'Observation Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_value_regex' = 'unsafe_act|unsafe_condition|near_miss|positive_observation|hazard_identification|behavioral_observation');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_business_glossary_term' = 'Observer Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `observer_role` SET TAGS ('dbx_business_glossary_term' = 'Observer Role');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `photo_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Attached Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `photo_url` SET TAGS ('dbx_business_glossary_term' = 'Photo URL');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `recognition_given_flag` SET TAGS ('dbx_business_glossary_term' = 'Recognition Given Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `recognition_type` SET TAGS ('dbx_business_glossary_term' = 'Recognition Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|evening|night|weekend|rotating');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `submitted_datetime` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`observation` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `regulatory_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `amended_regulatory_notification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `authority_action_required` SET TAGS ('dbx_business_glossary_term' = 'Authority Action Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `authority_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Authority Reference Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending review|under investigation');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `dangerous_goods_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Involved Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `fatality_count` SET TAGS ('dbx_business_glossary_term' = 'Fatality Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `hospitalization_count` SET TAGS ('dbx_business_glossary_term' = 'Hospitalization Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `incident_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incident Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `incident_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|serious|critical|catastrophic');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `injury_count` SET TAGS ('dbx_business_glossary_term' = 'Injury Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `late_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `notification_content_summary` SET TAGS ('dbx_business_glossary_term' = 'Notification Content Summary');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `notification_details` SET TAGS ('dbx_business_glossary_term' = 'Notification Details');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'draft|pending submission|submitted|acknowledged|under review|closed');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `notification_trigger` SET TAGS ('dbx_business_glossary_term' = 'Notification Trigger');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'initial notification|follow-up report|final report|supplemental report|corrective action report|closure notification');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `penalty_assessed_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Assessed Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `regulatory_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Response Received Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `response_summary` SET TAGS ('dbx_business_glossary_term' = 'Response Summary');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `statutory_deadline` SET TAGS ('dbx_business_glossary_term' = 'Statutory Deadline');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `submission_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Confirmation Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`regulatory_notification` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_closed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_closed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_closed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_holder_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_holder_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_holder_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `renewed_permit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `atmospheric_testing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Atmospheric Testing Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Closed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `confined_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `dangerous_goods_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Involved Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Permit Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `fire_watch_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Watch Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `hazards_identified` SET TAGS ('dbx_business_glossary_term' = 'Hazards Identified');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `holder_company` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Company');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `hot_work_flag` SET TAGS ('dbx_business_glossary_term' = 'Hot Work Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `incident_occurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurred Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issued Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Issued Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `lockout_tagout_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lockout-Tagout (LOTO) Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit-to-Work (PTW) Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_value_regex' = '^PTW-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'hot_work|confined_space_entry|working_at_height|electrical_isolation|excavation|chemical_handling');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `precautions_required` SET TAGS ('dbx_business_glossary_term' = 'Precautions Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempted');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `rescue_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Rescue Plan Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotating');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `validity_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date-Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `validity_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date-Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Violation Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `work_completion_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Completion Verified Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`permit` ALTER COLUMN `work_location_description` SET TAGS ('dbx_business_glossary_term' = 'Work Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `occupational_health_case_id` SET TAGS ('dbx_business_glossary_term' = 'Occupational Health Case Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `occupational_health_case_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `occupational_health_case_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Case Document Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Incident Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `tertiary_occupational_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `tertiary_occupational_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `tertiary_occupational_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `related_occupational_health_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_business_glossary_term' = 'Workplace Accommodation Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `accommodation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `actual_return_to_full_duty_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return to Full Duty Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_closure_outcome` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Outcome');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Case Manager Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Occupational Health Case Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Occupational Health Case Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Open Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Occupational Health Case Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_treatment|under_review|pending_clearance|closed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Occupational Health Case Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `days_on_restricted_duty` SET TAGS ('dbx_business_glossary_term' = 'Days on Restricted Duty');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_business_glossary_term' = 'Occupational Health Diagnosis Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `diagnosis_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Diagnosis Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Case Cost');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `expected_return_to_full_duty_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return to Full Duty Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `fitness_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Fitness for Duty Clearance Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `fitness_for_duty_status` SET TAGS ('dbx_business_glossary_term' = 'Fitness for Duty Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `fitness_for_duty_status` SET TAGS ('dbx_value_regex' = 'fit_for_duty|fit_with_restrictions|temporarily_unfit|permanently_unfit|pending_evaluation');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `fitness_for_duty_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `fitness_for_duty_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `follow_up_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Appointment Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Employee Job Title');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `modified_duty_plan` SET TAGS ('dbx_business_glossary_term' = 'Modified Duty Plan Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `modified_duty_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `modified_duty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Modified Duty Start Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `privacy_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Case Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `treating_provider_facility` SET TAGS ('dbx_business_glossary_term' = 'Treating Provider Facility Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `treating_provider_facility` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `treating_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Treating Occupational Health Provider Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `treating_provider_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `work_restrictions_imposed` SET TAGS ('dbx_business_glossary_term' = 'Work Restrictions Imposed');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `work_restrictions_imposed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `work_restrictions_imposed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `workers_compensation_carrier` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Insurance Carrier');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `workers_compensation_carrier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `workers_compensation_carrier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `workers_compensation_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`occupational_health_case` ALTER COLUMN `workers_compensation_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `parent_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Semi-Annual|Quarterly|Biennial|Triennial');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `business_unit_coverage` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Coverage');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `certification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Certified|In Progress|Expired|Not Applicable|Suspended');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Program Document Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `objectives` SET TAGS ('dbx_business_glossary_term' = 'Program Objectives');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Program Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,6}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_scope` SET TAGS ('dbx_value_regex' = 'Global|Regional|Business Unit|Facility|Fleet');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Under Review|Suspended|Inactive|Planned');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'ISO 45001 Management System|OSHA VPP|Driver Safety Program|Dangerous Goods Safety Program|Fatigue Risk Management|Contractor Safety Management');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Semi-Annual|Quarterly|Monthly|Ad-Hoc');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `target_metrics` SET TAGS ('dbx_business_glossary_term' = 'Target Metrics');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `training_frequency` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `training_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Biennial|Triennial|One-Time|As Needed');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `contractor_safety_prequal_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Safety Pre-Qualification ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Audit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Safety Officer ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Template ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `renewed_contractor_safety_prequal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `authorized_facilities` SET TAGS ('dbx_business_glossary_term' = 'Authorized Facilities');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `conditional_approval_requirements` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Requirements');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `contractor_type` SET TAGS ('dbx_business_glossary_term' = 'Contractor Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `contractor_type` SET TAGS ('dbx_value_regex' = '3pl|freight_forwarder|warehouse_operator|maintenance_provider|transport_carrier|customs_broker');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `coverage_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `coverage_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `dangerous_goods_certified` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Certified Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `dg_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Certification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `dg_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Certification Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `document_repository_url` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Qualification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `induction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Induction Completion Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `insurance_certificate_valid` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Valid Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `liability_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `ltir` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Incident Rate (LTIR)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `minimum_passing_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Passing Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `next_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Scheduled Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `osha_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Violations Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `prequal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Pre-Qualification Reference Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `prequal_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Qualification Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `prequal_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditional|rejected|expired|suspended');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `renewal_required_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `reviewing_safety_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Safety Officer Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `safety_inductions_completed` SET TAGS ('dbx_business_glossary_term' = 'Safety Inductions Completed Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `safety_questionnaire_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Questionnaire Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `safety_record_review_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Record Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `safety_record_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Safety Record Review Outcome');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `safety_record_review_outcome` SET TAGS ('dbx_value_regex' = 'excellent|good|acceptable|marginal|unacceptable');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `serious_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Violations Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `site_access_authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Site Access Authorization Level');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `site_access_authorization_level` SET TAGS ('dbx_value_regex' = 'unrestricted|restricted|escorted_only|no_access');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `trir` SET TAGS ('dbx_business_glossary_term' = 'Total Recordable Incident Rate (TRIR)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`contractor_safety_prequal` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` SET TAGS ('dbx_subdomain' = 'incident_management');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `environmental_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Activated Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `cfs_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Cfs Operation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `consolidation_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `intermodal_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Intermodal Transfer Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `related_environmental_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `actual_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Remediation Cost');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `cleanup_contractor_engaged_flag` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Contractor Engaged Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `cleanup_contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Contractor Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `cleanup_contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `cleanup_contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `containment_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Containment Actions Taken');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `containment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Containment Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `corrective_actions_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Completed Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Discovery Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `discovery_method` SET TAGS ('dbx_value_regex' = 'routine_inspection|employee_report|customer_complaint|sensor_alarm|third_party_notification|regulatory_inspection');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `environmental_media_affected` SET TAGS ('dbx_business_glossary_term' = 'Environmental Media Affected');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `environmental_media_affected` SET TAGS ('dbx_value_regex' = 'soil|water|air|multiple');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `immediate_cause` SET TAGS ('dbx_business_glossary_term' = 'Immediate Cause of Environmental Incident');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `incident_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Closed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `incident_datetime` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|containment_in_progress|remediation_in_progress|closed|regulatory_review');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'fuel_spill|chemical_release|dg_leakage|wastewater_discharge|air_emission_exceedance|soil_contamination');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `insurance_claim_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Filed Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Location Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Location Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `penalty_assessed_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Assessed Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `quantity_released` SET TAGS ('dbx_business_glossary_term' = 'Quantity Released');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `release_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Release Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `release_unit_of_measure` SET TAGS ('dbx_value_regex' = 'liters|gallons|kilograms|pounds|cubic_meters|tons');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `remediation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Start Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|ongoing_monitoring|verified_complete');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `reported_datetime` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Reported Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment_failure|human_error|process_deficiency|external_event|design_flaw|maintenance_lapse');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Severity Classification');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical|catastrophic');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `substance_involved` SET TAGS ('dbx_business_glossary_term' = 'Substance Involved in Environmental Incident');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`environmental_incident` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` SET TAGS ('dbx_subdomain' = 'risk_prevention');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Alert ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_issuing_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_issuing_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_issuing_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Health, Safety, and Environment (HSE) Incident ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `supersedes_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Alert ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Referenced Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Safety Observation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `superseded_alert_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `acknowledgement_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Completion Rate');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `acknowledgement_deadline` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Deadline');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `acknowledgement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `acknowledgements_received` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgements Received');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_description` SET TAGS ('dbx_business_glossary_term' = 'Alert Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Alert Reference Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_value_regex' = 'draft|pending approval|active|superseded|archived|cancelled');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'safety bulletin|lessons learned notice|regulatory update|dangerous goods advisory|weather advisory|environmental advisory');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `dangerous_goods_un_number` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'email|intranet|mobile app|printed notice|toolbox talk|all channels');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country|facility');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Actions');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Alert Subject');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `total_recipients` SET TAGS ('dbx_business_glossary_term' = 'Total Recipients');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`alert` ALTER COLUMN `translation_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Translation Available Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `fatigue_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Assessment ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `driver_safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `tertiary_fatigue_assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `tertiary_fatigue_assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `tertiary_fatigue_assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `transport_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `followup_fatigue_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessed_fatigue_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Assessed Fatigue Risk Level');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessed_fatigue_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_datetime` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_location` SET TAGS ('dbx_business_glossary_term' = 'Assessment Location');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'cleared|modified_duty|stood_down|referred_medical|pending_review');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|completed|cancelled|under_review');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Assessment Trigger Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessment_trigger` SET TAGS ('dbx_value_regex' = 'scheduled|post_incident|regulatory|operational_change|supervisor_request|self_report');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `assessor_role` SET TAGS ('dbx_business_glossary_term' = 'Assessor Role');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `countermeasures_applied` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Countermeasures Applied');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `duty_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Duty End Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `duty_restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Duty Restriction Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `duty_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Duty Start Date and Time');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `employee_role` SET TAGS ('dbx_business_glossary_term' = 'Employee Role');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `fatigue_score` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Score');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `hos_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `hos_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|approaching_limit|violation|exemption_applied');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `hos_violation_type` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Violation Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `hours_driving` SET TAGS ('dbx_business_glossary_term' = 'Hours Driving');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `hours_on_duty` SET TAGS ('dbx_business_glossary_term' = 'Hours on Duty');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `hours_since_last_rest` SET TAGS ('dbx_business_glossary_term' = 'Hours Since Last Rest Period');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `last_rest_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Last Rest Duration (Hours)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `objective_fatigue_indicators` SET TAGS ('dbx_business_glossary_term' = 'Objective Fatigue Indicators');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `regulatory_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `relief_driver_assigned` SET TAGS ('dbx_business_glossary_term' = 'Relief Driver Assigned Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `rest_break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Rest Break Duration (Minutes)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `rest_break_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Rest Break Scheduled Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `route_modified` SET TAGS ('dbx_business_glossary_term' = 'Route Modified Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `sleep_opportunity_adequacy` SET TAGS ('dbx_business_glossary_term' = 'Sleep Opportunity Adequacy');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `sleep_opportunity_adequacy` SET TAGS ('dbx_value_regex' = 'adequate|marginal|inadequate|unknown');
ALTER TABLE `transport_shipping_ecm`.`safety`.`fatigue_risk_assessment` ALTER COLUMN `subjective_fatigue_rating` SET TAGS ('dbx_business_glossary_term' = 'Subjective Fatigue Rating');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `hse_legal_register_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environmental (HSE) Legal Register ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `quaternary_hse_responsible_owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `superseded_by_regulation_hse_legal_register_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Regulation ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `tertiary_hse_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `tertiary_hse_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `tertiary_hse_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `superseded_hse_legal_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `applicability_to_operations` SET TAGS ('dbx_business_glossary_term' = 'Applicability to Operations');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `compliance_gap_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gap Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `compliance_obligation_detail` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Detail');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `compliance_obligation_summary` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Summary');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|gap_identified|action_required|not_applicable|under_review|non_compliant');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Regulation Effective Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Regulation Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `hse_domain` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environmental (HSE) Domain');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `hse_domain` SET TAGS ('dbx_value_regex' = 'occupational_health|workplace_safety|environmental|dangerous_goods|emergency_response|process_safety');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `internal_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Document Reference');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `iso_45001_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Clause Reference');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_value_regex' = 'international|national|state|local|facility');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `jurisdiction_state_province` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State or Province');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `record_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Period in Years');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `register_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Register Entry Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `register_status` SET TAGS ('dbx_business_glossary_term' = 'Register Entry Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `register_status` SET TAGS ('dbx_value_regex' = 'active|superseded|archived|under_review');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `regulation_name` SET TAGS ('dbx_business_glossary_term' = 'Regulation Name');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `regulation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference Number');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `regulation_source_url` SET TAGS ('dbx_business_glossary_term' = 'Regulation Source Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `regulation_type` SET TAGS ('dbx_business_glossary_term' = 'Regulation Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `regulation_type` SET TAGS ('dbx_value_regex' = 'legislation|regulation|standard|code_of_practice|permit_condition|guideline');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|event_driven|as_required|none');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `reporting_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `training_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Description');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hse_legal_register` ALTER COLUMN `training_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` SET TAGS ('dbx_association_edges' = 'safety.safety_program,safety.safety_training');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `program_training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Program Training Requirement ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Training Requirement - Safety Program Id');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `safety_training_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Training ID');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Program Training Requirement - Safety Training Id');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `completion_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Completion Deadline');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Created Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `exemption_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exemption Criteria');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Requirement Frequency');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Requirement Flag');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Last Modified Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis for Requirement');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Type');
ALTER TABLE `transport_shipping_ecm`.`safety`.`program_training_requirement` ALTER COLUMN `target_audience_role` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Role');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` SET TAGS ('dbx_subdomain' = 'risk_prevention');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` SET TAGS ('dbx_association_edges' = 'safety.emergency_response_plan,network.hub_gateway');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `hub_emergency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Emergency Plan - Hub Emergency Plan Id');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Emergency Plan - Emergency Response Plan Id');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Emergency Plan - Hub Gateway Id');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `communication_cascade` SET TAGS ('dbx_business_glossary_term' = 'Communication Cascade');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `coordination_protocol` SET TAGS ('dbx_business_glossary_term' = 'Coordination Protocol');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `facility_specific_notes` SET TAGS ('dbx_business_glossary_term' = 'Facility Specific Notes');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `last_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drill Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `local_emergency_contact` SET TAGS ('dbx_business_glossary_term' = 'Local Emergency Contact');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `next_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Next Drill Date');
ALTER TABLE `transport_shipping_ecm`.`safety`.`hub_emergency_plan` ALTER COLUMN `plan_activation_authority` SET TAGS ('dbx_business_glossary_term' = 'Plan Activation Authority');
ALTER TABLE `transport_shipping_ecm`.`safety`.`coaching_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`safety`.`coaching_session` SET TAGS ('dbx_subdomain' = 'workforce_readiness');
ALTER TABLE `transport_shipping_ecm`.`safety`.`coaching_session` ALTER COLUMN `coaching_session_id` SET TAGS ('dbx_business_glossary_term' = 'Coaching Session Identifier');
ALTER TABLE `transport_shipping_ecm`.`safety`.`coaching_session` ALTER COLUMN `followup_coaching_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
