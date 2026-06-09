-- Schema for Domain: workforce | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`workforce` COMMENT 'SSOT for field and technical workforce operations — technician scheduling, dispatch, route optimization, work order execution, skill/certification tracking, and mobile workforce coordination for network installation, maintenance, and repair. Managed via Granite Telecommunications WFM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`technician` (
    `technician_id` BIGINT COMMENT 'Unique identifier for the field or technical workforce personnel. Primary key for the technician master record.',
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: Technician has a home_depot_code (STRING) that denotes their base depot for dispatch and staging. Normalizing this to a FK home_depot_id -> workforce.depot.depot_id eliminates the string code and esta',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Telecom field workforces routinely include subcontracted technicians from partner companies. Linking technician to the supplying partner is essential for subcontractor billing reconciliation, complian',
    `supervisor_technician_id` BIGINT COMMENT 'Identifier of the direct supervisor or field manager responsible for this technicians performance management and work assignment.',
    `attendance_rate` DECIMAL(18,2) COMMENT 'Percentage of scheduled work days attended. Used for reliability assessment and workforce planning.',
    `background_check_date` DATE COMMENT 'Date of the most recent background check or security clearance verification. Required for access to customer premises and sensitive network infrastructure.',
    `certification_status` STRING COMMENT 'Aggregate status of required industry certifications (e.g., fiber optic, electrical safety, tower climbing). Drives dispatch eligibility and compliance reporting.. Valid values are `current|expiring_soon|expired|pending|not_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the technician master record was first created in the system. Used for data lineage and audit trail.',
    `current_performance_rating` STRING COMMENT 'Most recent overall performance evaluation rating from the latest review cycle. Used for promotion decisions and workforce optimization.. Valid values are `exceeds|meets|needs_improvement|unsatisfactory|not_rated`',
    `customer_satisfaction_score` DECIMAL(18,2) COMMENT 'Average customer satisfaction rating (0-100 scale) from post-service surveys. Key indicator of service quality and technician soft skills.',
    `data_source_system` STRING COMMENT 'Identifies the operational system of record that provided this technician data: Granite Telecommunications Workforce Management (WFM), SAP S/4HANA Human Capital Management (HCM), manual entry, or integration feed.. Valid values are `granite_wfm|sap_hcm|manual_entry|integration`',
    `drug_test_date` DATE COMMENT 'Date of the most recent drug screening test. Required for safety-sensitive positions and compliance with Department of Transportation (DOT) regulations for commercial drivers.',
    `emergency_contact_name` STRING COMMENT 'Full name of the designated emergency contact person for field safety incidents and urgent notifications.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the designated emergency contact for field safety incidents and urgent notifications.. Valid values are `^+?[1-9]d{1,14}$`',
    `employment_status` STRING COMMENT 'Current employment lifecycle status indicating availability for work assignment and dispatch.. Valid values are `active|inactive|suspended|leave|terminated`',
    `employment_type` STRING COMMENT 'Classification of employment relationship: full-time employee, part-time employee, contractor, Mobile Virtual Network Operator (MVNO) partner technician, or temporary worker.. Valid values are `full_time|part_time|contractor|mvno_partner|temporary`',
    `first_time_fix_rate` DECIMAL(18,2) COMMENT 'Percentage of work orders resolved on the first visit without requiring return trips. Key performance indicator (KPI) for technician efficiency and customer satisfaction.',
    `improvement_plan_flag` BOOLEAN COMMENT 'Indicates whether the technician is currently on a formal performance improvement plan. Used for HR compliance and management escalation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the technician master record. Used for change tracking and data synchronization.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal performance review. Used to schedule upcoming reviews and ensure compliance with review frequency policies.',
    `mean_time_to_repair` DECIMAL(18,2) COMMENT 'Average time in minutes to complete repair work orders. Critical KPI for workforce productivity and Service Level Agreement (SLA) compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal performance review. Drives manager notifications and review preparation workflows.',
    `safety_compliance_score` DECIMAL(18,2) COMMENT 'Percentage score (0-100) representing adherence to safety protocols, personal protective equipment (PPE) usage, and incident-free work history. Critical for field workforce risk management.',
    `service_zone` STRING COMMENT 'Geographic service zone or territory assignment for dispatch optimization and workload balancing.. Valid values are `^[A-Z0-9]{3,10}$`',
    `skill_level` STRING COMMENT 'Overall technical proficiency level used for work order assignment complexity matching and career progression tracking.. Valid values are `entry|intermediate|advanced|expert|master`',
    `sla_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of work orders completed within committed SLA timeframes. Critical for customer satisfaction and penalty avoidance.',
    `tools_kit_code` STRING COMMENT 'Identifier of the standard tools and equipment kit assigned to the technician. Used for inventory tracking and maintenance scheduling.. Valid values are `^TK[A-Z0-9]{6,10}$`',
    `training_hours_ytd` DECIMAL(18,2) COMMENT 'Total training and professional development hours completed in the current calendar year. Used for compliance reporting and skill development tracking.',
    `union_member_flag` BOOLEAN COMMENT 'Indicates whether the technician is a member of a labor union. Affects scheduling rules, overtime policies, and grievance procedures.',
    `vehicle_assigned` STRING COMMENT 'Identifier of the company vehicle or fleet unit assigned to this technician for field operations and equipment transport.. Valid values are `^[A-Z0-9]{6,15}$`',
    `work_orders_per_day` DECIMAL(18,2) COMMENT 'Average number of work orders completed per working day. Productivity metric used for capacity planning and workload balancing.',
    `workforce_classification` STRING COMMENT 'Technical specialization area: Radio Access Network (RAN), Fiber to the Home (FTTH), Gigabit Passive Optical Network (GPON), Customer Premises Equipment (CPE), fiber splicing, transport network, core network, or hybrid multi-skill. [ENUM-REF-CANDIDATE: ran|ftth|gpon|cpe|splicing|transport|core|hybrid — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_technician PRIMARY KEY(`technician_id`)
) COMMENT 'Master record for field and technical workforce personnel with periodic performance evaluation history. Identity and employment: technician ID, name, employment status, home depot/zone assignment, employment type (full-time, contractor, MVNO partner), contact details, hire/termination dates, workforce classification (RAN, FTTH, GPON, CPE, splicing). Performance history: quarterly/annual review records with KPIs (first-time fix rate, MTTR, work orders/day, SLA compliance, CSAT, safety compliance, attendance), review period, reviewer (supervisor), overall rating, individual KPI scores, development goals, acknowledgement status, and improvement plan references. SSOT for individual workforce identity and performance within the workforce domain. Sourced from Granite Telecommunications WFM and SAP S/4HANA HCM.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`skill` (
    `skill_id` BIGINT COMMENT 'Unique identifier for the technical skill in the workforce skill taxonomy. Primary key.',
    `certification_body` STRING COMMENT 'Name of the external certification authority or vendor (e.g., Ericsson, Nokia, Fiber Optic Association, OSHA) if certification_required_flag is true.',
    `certification_name` STRING COMMENT 'Official name of the required certification (e.g., Ericsson Certified RAN Expert, Nokia NetAct Administrator, FOA CFOT).',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether formal external certification is required to hold this skill (e.g., vendor certification for Ericsson RAN, Nokia NetAct, safety certifications).',
    `created_by_user` STRING COMMENT 'Username or identifier of the workforce administrator who created this skill record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this skill record was first created in the Granite WFM skills module.',
    `dispatch_priority_weight` STRING COMMENT 'Numeric weight used in Granite WFM dispatch algorithm to prioritize technicians with this skill for matching work orders (higher weight = higher priority).',
    `effective_end_date` DATE COMMENT 'Date when this skill was deprecated or made obsolete. Null if skill is still active.',
    `effective_start_date` DATE COMMENT 'Date when this skill became active in the workforce skill taxonomy and available for assignment.',
    `equipment_type` STRING COMMENT 'Type of equipment or system this skill applies to (e.g., RAN Base Station, OLT, ONT, BNG, BRAS, IMS Core, HSS, CPE Router).',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the workforce administrator who last modified this skill record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this skill record was last updated in the Granite WFM skills module.',
    `prerequisite_skills` STRING COMMENT 'Comma-separated list of skill codes that must be held before this skill can be acquired (e.g., basic safety certification required before advanced RAN work).',
    `proficiency_level_competent_definition` STRING COMMENT 'Definition of competent proficiency level for this skill: ability to perform tasks independently with standard supervision and quality expectations.',
    `proficiency_level_expert_definition` STRING COMMENT 'Definition of expert proficiency level for this skill: advanced capabilities, ability to handle complex scenarios, mentor others, and perform quality assurance.',
    `proficiency_level_trainee_definition` STRING COMMENT 'Definition of trainee proficiency level for this skill: expected capabilities, supervision requirements, and task limitations.',
    `recertification_frequency_months` STRING COMMENT 'Number of months between required recertification events if recertification_required_flag is true.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether periodic recertification or reassessment is mandatory to maintain this skill.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this skill is subject to regulatory compliance requirements (e.g., FCC licensing, OSHA certification, state/local permits).',
    `replacement_skill_code` STRING COMMENT 'Skill code of the replacement skill if this skill has been deprecated or obsoleted (e.g., LTE skill replaced by 5G NR skill).',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this skill involves safety-critical work (e.g., tower climbing, high-voltage work, confined space entry) requiring additional safety protocols.',
    `skill_category` STRING COMMENT 'High-level classification of the skill domain: RAN (Radio Access Network), Transport (MPLS, SD-WAN), Access (FTTH, GPON, DSLAM), Core (IMS, HSS, UDM), CPE (Customer Premises Equipment), Safety, Compliance, or Other. [ENUM-REF-CANDIDATE: RAN|Transport|Access|Core|CPE|Safety|Compliance|Other — 8 candidates stripped; promote to reference product]',
    `skill_code` STRING COMMENT 'Externally-known unique alphanumeric code for the skill, used in Granite WFM dispatch matching and work order assignment (e.g., FIBER-SPLICE, 5G-RAN-COMM, GPON-OLT-CFG).. Valid values are `^[A-Z0-9]{4,12}$`',
    `skill_description` STRING COMMENT 'Detailed description of the skill, including technical scope, typical tasks, and application context (e.g., Ability to perform single-mode and multi-mode fiber splicing, OTDR testing, and loss certification for trunk and distribution fiber networks).',
    `skill_name` STRING COMMENT 'Human-readable name of the technical skill (e.g., Fiber Splicing, 5G NR RAN Commissioning, GPON OLT Configuration, VoLTE IMS Troubleshooting).',
    `skill_status` STRING COMMENT 'Current lifecycle status of the skill in the taxonomy: Active (in use), Deprecated (being phased out), Obsolete (no longer used), Planned (future skill).. Valid values are `Active|Deprecated|Obsolete|Planned`',
    `source_system` STRING COMMENT 'Name of the source system where this skill record originated (e.g., Granite WFM, HR System, Training Management System).',
    `source_system_code` STRING COMMENT 'Unique identifier of this skill record in the source system (e.g., Granite WFM skill ID).',
    `subcategory` STRING COMMENT 'Detailed sub-classification within the skill category (e.g., Fiber Optics, 5G NR, LTE, VoLTE, IPTV, Broadband Gateway).',
    `technology_domain` STRING COMMENT 'Specific technology or standard the skill applies to (e.g., 5G NR, LTE, VoLTE, GPON, FTTH, MPLS, SD-WAN, IMS, NFV, SDN).',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Estimated number of training hours required to achieve competent proficiency level for this skill.',
    `validity_period_months` STRING COMMENT 'Number of months this skill remains valid before recertification or reassessment is required. Null if skill does not expire.',
    `vendor_name` STRING COMMENT 'Name of the equipment or software vendor if vendor_specific_flag is true (e.g., Ericsson, Nokia, Huawei, Cisco, Juniper).',
    `vendor_specific_flag` BOOLEAN COMMENT 'Indicates whether this skill is specific to a particular equipment vendor (e.g., Ericsson RAN, Nokia NetAct, Huawei Transport) versus vendor-agnostic.',
    `work_order_type_applicability` STRING COMMENT 'Comma-separated list of work order types this skill is applicable to (e.g., Installation, Maintenance, Repair, Commissioning, Decommissioning, Troubleshooting, Upgrade).',
    CONSTRAINT pk_skill PRIMARY KEY(`skill_id`)
) COMMENT 'SSOT for the technical skill taxonomy and individual technician skill proficiency holdings. Catalog section: skill code, name, category (RAN, transport, access, CPE, safety), proficiency level definitions (trainee/competent/expert), prerequisite skills, and validity period — e.g., fiber splicing, 5G NR RAN commissioning, GPON/OLT configuration, VoLTE IMS troubleshooting. Technician-skill section: which skills each technician holds, current proficiency level, assessment date, assessor, expiry date, recertification requirements, and active status. Enables skill-based dispatch matching in Granite WFM — ensures only appropriately skilled technicians are assigned to specialized work orders (e.g., only fiber-splicing-expert for trunk splice jobs). Sourced from Granite WFM skills module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the workforce certification record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Telecom compliance audits (ISO, FCC, OSHA) formally verify technician certifications. Linking workforce_certification to the audit that verified or flagged it enables audit trail reporting and regulat',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Telecom technician certifications are frequently device-model-specific (e.g., certified to install a Nokia G-240 ONT or Cisco ASR router). Linking workforce_certification to device_model enables compl',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Specific workforce certifications are mandated by regulatory obligations (FCC tower climbing safety certification, state electrical licenses for fiber splicing, OSHA confined space entry certification',
    `skill_id` BIGINT COMMENT 'Foreign key linking to workforce.skill. Business justification: Certifications validate specific technical skills. Each certification holding (workforce_certification record) validates proficiency in a specific skill from the skill taxonomy. The technology_domain ',
    `technician_id` BIGINT COMMENT 'Reference to the technician who holds this certification. Links to the workforce technician master record.',
    `attachment_url` STRING COMMENT 'URL or file path to the scanned certificate document, digital badge, or credential stored in the document management system. Used for audit and verification purposes.',
    `certificate_number` STRING COMMENT 'Unique certificate number or credential identifier issued by the certifying authority. This is the externally-known identifier for this specific certification instance.',
    `certification_level` STRING COMMENT 'Level or grade of the certification indicating proficiency or seniority. Examples include Basic, Intermediate, Advanced, Expert, Level 1, Level 2, Journeyman, Master, or vendor-specific tier designations.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification holding. Active indicates the certification is valid and in good standing; expired indicates the validity period has lapsed; suspended indicates temporary hold; pending_renewal indicates renewal process initiated; revoked indicates certification withdrawn by authority; in_progress indicates certification process underway but not yet completed.. Valid values are `active|expired|suspended|pending_renewal|revoked|in_progress`',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the certification is currently in compliance with all regulatory and company requirements. True indicates compliant; False indicates non-compliant (expired, suspended, or missing required renewals).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to obtain or renew the certification, including exam fees, training fees, and administrative costs. Used for workforce development budget tracking and ROI (Return on Investment) analysis.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount. Examples include USD, EUR, GBP, CAD.. Valid values are `^[A-Z]{3}$`',
    `cpd_hours_earned` DECIMAL(18,2) COMMENT 'Number of Continuing Professional Development hours or Continuing Education Units (CEUs) earned through the training or certification process. Used for tracking professional development requirements and renewal eligibility.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Used for audit trail and data lineage tracking.',
    `expiry_date` DATE COMMENT 'Date on which the certification expires and is no longer valid unless renewed. Null for certifications with no expiration (lifetime certifications).',
    `issue_date` DATE COMMENT 'Date on which the certification was originally issued to the technician by the certifying authority. Represents the start of the certification validity period.',
    `issuing_authority` STRING COMMENT 'Name of the organization, regulatory body, or vendor that issued the certification. Examples include OSHA, BICSI, Ericsson, Nokia, FCC, NATE, or internal training departments.',
    `issuing_authority_code` STRING COMMENT 'Standardized code or abbreviation for the issuing authority. Used for grouping and reporting by certifying body.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal or recertification event. Null if the certification has never been renewed.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the certification must be renewed to maintain active status. Used for proactive renewal tracking and compliance monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, restrictions, or comments related to the certification holding. Examples include conditional approval notes, remediation requirements, or special endorsements.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Boolean indicator of whether this certification is mandated by federal, state, or local regulation (e.g., FCC General Radiotelephone Operator License, OSHA safety certifications). True indicates regulatory requirement; False indicates voluntary or company-preferred certification.',
    `reimbursement_status` STRING COMMENT 'Status of cost reimbursement to the technician or training provider. Not_applicable indicates company-paid certification; pending indicates reimbursement request submitted; approved indicates reimbursement authorized; reimbursed indicates payment completed; denied indicates reimbursement request rejected.. Valid values are `not_applicable|pending|approved|reimbursed|denied`',
    `vendor_name` STRING COMMENT 'Name of the equipment or software vendor for vendor-specific certifications. Examples include Ericsson, Nokia, Huawei, Cisco, Ciena. Null for vendor-neutral certifications.',
    `vendor_specific_flag` BOOLEAN COMMENT 'Boolean indicator of whether the certification is vendor-specific (e.g., Ericsson RAN Certified, Nokia NetAct Operator) or vendor-neutral (e.g., BICSI RCDD, OSHA safety). True indicates vendor-specific; False indicates vendor-neutral or industry-standard certification.',
    `verification_date` DATE COMMENT 'Date on which the certification was last verified with the issuing authority. Used for audit trail and compliance reporting.',
    `verification_method` STRING COMMENT 'Method used to verify the authenticity of the certification with the issuing authority. Examples include online registry lookup, phone verification, email confirmation, document review, third-party verification service, or self-attestation.. Valid values are `online_registry|phone_verification|email_confirmation|document_review|third_party_service|self_attestation`',
    `verification_status` STRING COMMENT 'Status of the certification verification process with the issuing authority. Verified indicates the certification has been confirmed with the issuing body; pending_verification indicates verification in progress; unverified indicates not yet verified; verification_failed indicates the certification could not be confirmed.. Valid values are `verified|pending_verification|unverified|verification_failed`',
    `work_type_eligibility` STRING COMMENT 'Comma-separated list or coded representation of work order types or service categories that this certification qualifies the technician to perform. Examples include tower_climbing, confined_space_entry, fiber_splicing, RAN_installation, 5G_NR_deployment, FTTH_installation. Used for dispatch eligibility and work assignment rules.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'SSOT for workforce qualifications, certifications, technician certification holdings, and training activity records. (1) Certification catalog: formal certifications and regulatory qualifications — OSHA safety, BICSI RCDD, Ericsson RAN certified, Nokia NetAct operator, FCC General Radiotelephone Operator License, NATE tower climbing, confined space entry — with issuing body, validity duration, renewal requirements, and regulatory mandate flag. (2) Technician-certification holdings: certificate number, issue date, expiry date, issuing authority, renewal status, compliance flag, and technician reference. (3) Training activities: course completions, delivery method (classroom/e-learning/OJT/vendor-led), provider, completion date, score/grade, pass/fail, CPD hours earned, and link to resulting certification. Supports FCC/OSHA mandatory compliance reporting, technician upskilling tracking for 5G NR and FTTH rollouts, and ensures only qualified technicians are dispatched to regulated work types. Sourced from Granite WFM certification module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`depot` (
    `depot_id` BIGINT COMMENT 'Unique identifier for the field workforce depot, staging yard, or dispatch center. Primary key.',
    `activation_date` DATE COMMENT 'Date when the depot facility became operational and began dispatching technicians. Effective-from date for depot lifecycle.',
    `address_line_1` STRING COMMENT 'Primary street address line of the depot facility including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as building, suite, or unit number.',
    `city` STRING COMMENT 'City or municipality where the depot is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the depot is located (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this depot record was first created in the system. Audit trail for record creation.',
    `deactivation_date` DATE COMMENT 'Date when the depot facility ceased operations or was decommissioned. Null for active depots. Effective-until date for depot lifecycle.',
    `depot_code` STRING COMMENT 'Business identifier code for the depot used in workforce management systems and route optimization. Externally-known unique code for operational reference.. Valid values are `^[A-Z0-9]{3,12}$`',
    `depot_name` STRING COMMENT 'Human-readable name of the depot facility (e.g., North Regional Dispatch Center, Downtown Service Yard).',
    `depot_type` STRING COMMENT 'Classification of the depot facility based on its operational role and capacity. Central warehouse serves as primary distribution hub, satellite yard provides local staging, NOC (Network Operations Center) dispatch center handles network emergency response, mobile hub supports temporary deployments, regional staging consolidates area operations, field office provides administrative support.. Valid values are `central_warehouse|satellite_yard|noc_dispatch_center|mobile_hub|regional_staging|field_office`',
    `email` STRING COMMENT 'Primary email address for the depot facility for administrative communication and work order coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `facility_ownership_type` STRING COMMENT 'Classification of how the depot facility is controlled. Owned indicates company property, leased for rental agreement, shared for co-location with partners, temporary for short-term arrangements.. Valid values are `owned|leased|shared|temporary`',
    `holiday_availability_flag` BOOLEAN COMMENT 'Indicates whether the depot operates on public holidays. True if depot maintains operations during holidays, False if closed.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent facility safety or compliance inspection. Used for regulatory compliance tracking and facility maintenance scheduling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this depot record was last updated. Audit trail for record changes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the depot in decimal degrees format. Used as route optimization start/end point and for geographic analysis.',
    `lease_expiration_date` DATE COMMENT 'Date when the facility lease or rental agreement expires. Used for facility planning and renewal tracking. Null if facility is owned.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the depot in decimal degrees format. Used as route optimization start/end point and for geographic analysis.',
    `noc_integration_flag` BOOLEAN COMMENT 'Indicates whether this depot is integrated with or co-located with a Network Operations Center for real-time network fault response and emergency dispatch.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special instructions, or facility-specific information relevant to workforce coordination and dispatch planning.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for the depot on weekdays (Monday-Friday) in format HH:MM-HH:MM (e.g., 06:00-18:00). Used for dispatch scheduling and technician availability planning.',
    `operating_hours_weekend` STRING COMMENT 'Operating hours for the depot on weekends (Saturday-Sunday) in format HH:MM-HH:MM. May differ from weekday hours or be closed.',
    `operational_status` STRING COMMENT 'Current operational state of the depot facility in its lifecycle. Active indicates full operations, inactive means not currently in use, temporarily closed for short-term closure, under maintenance during facility upgrades, decommissioned for permanent closure, planned for future activation.. Valid values are `active|inactive|temporarily_closed|under_maintenance|decommissioned|planned`',
    `parts_inventory_flag` BOOLEAN COMMENT 'Indicates whether this depot maintains an inventory of network equipment parts and Customer Premises Equipment (CPE) for technician provisioning. True if inventory is stocked, False if technicians source parts elsewhere.',
    `phone` STRING COMMENT 'Primary contact phone number for the depot facility for operational coordination and technician communication.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the depot location used for mail delivery and geographic sorting.',
    `primary_depot_flag` BOOLEAN COMMENT 'Indicates whether this is the primary depot for its service territory. True if primary hub, False if satellite or secondary facility.',
    `regional_manager_email` STRING COMMENT 'Email address of the regional manager for operational communication and escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regional_manager_name` STRING COMMENT 'Full name of the regional manager responsible for overseeing depot operations and workforce coordination.',
    `regional_manager_phone` STRING COMMENT 'Contact phone number for the regional manager responsible for this depot.',
    `security_level` STRING COMMENT 'Physical security classification of the depot facility. Standard for basic access control, enhanced for monitored entry, high security for critical infrastructure protection, restricted access for sensitive equipment storage.. Valid values are `standard|enhanced|high_security|restricted_access`',
    `service_zone_polygon` STRING COMMENT 'Geographic boundary polygon defining the service coverage area assigned to this depot, stored as Well-Known Text (WKT) or GeoJSON format. Used for territory assignment and technician dispatch optimization.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the depot is located.',
    `technician_headcount_capacity` STRING COMMENT 'Maximum number of field technicians that can be assigned to and dispatched from this depot as their home base.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the depot location (e.g., America/New_York, Europe/London). Critical for accurate scheduling and dispatch timing across regions.',
    `tool_storage_capacity_sqft` DECIMAL(18,2) COMMENT 'Total tool and equipment storage capacity at the depot measured in square feet. Used for inventory planning and space utilization analysis.',
    `vehicle_bay_capacity` STRING COMMENT 'Maximum number of service vehicles that can be parked and maintained at the depot facility simultaneously.',
    `weekend_availability_flag` BOOLEAN COMMENT 'Indicates whether the depot operates on weekends. True if depot is open Saturday or Sunday, False if closed all weekend.',
    `wfm_system_code` STRING COMMENT 'External identifier for this depot in the Granite Telecommunications Workforce Management system. Used for system integration and data reconciliation.',
    CONSTRAINT pk_depot PRIMARY KEY(`depot_id`)
) COMMENT 'Master record for field workforce depots, staging yards, and dispatch centers from which technicians and vehicles are deployed. Captures depot name, full address, geographic coordinates (lat/long), service zone coverage polygon, depot type (central warehouse, satellite yard, NOC-attached dispatch center), capacity metrics (vehicle bays, technician headcount, tool storage), operating hours, weekend/holiday availability, and assigned regional manager. Primary organizational unit for route optimization start/end points and technician home-base assignment in Granite WFM. Links to service_territory for zone coverage mapping.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` (
    `technician_schedule_id` BIGINT COMMENT 'Unique identifier for the technician schedule record. Primary key for the technician_schedule data product.',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Preventive maintenance schedules assign technicians to specific network elements for routine inspections and maintenance. Enables proactive maintenance planning, ensures critical infrastructure receiv',
    `depot_id` BIGINT COMMENT 'Identifier of the depot or field office from which the technician operates during this shift. Represents the starting and ending location for the technicians route.',
    `technician_id` BIGINT COMMENT 'Identifier of the technician to whom this schedule applies. Links to the technician master record in the workforce domain.',
    `team_id` BIGINT COMMENT 'Foreign key linking to workforce.team. Business justification: Technician schedules can be team-level (crew shifts, joint dispatch windows). Adding team_id -> workforce.team.team_id allows team-based scheduling queries and enables the WFM system to plan crew avai',
    `actual_overtime_hours` DECIMAL(18,2) COMMENT 'Actual overtime hours worked during this shift, including both planned and emergency overtime. Captured from time tracking systems and used for payroll processing.',
    `actual_work_hours` DECIMAL(18,2) COMMENT 'Total hours the technician actually worked during this shift, captured from time tracking or mobile workforce systems. Used for payroll and productivity analysis.',
    `break_duration_minutes` STRING COMMENT 'Total allocated break time within the shift, measured in minutes. Includes lunch breaks and rest periods as per labor regulations and company policy.',
    `cancellation_reason` STRING COMMENT 'Business reason for schedule cancellation. Captures context such as approved leave, emergency absence, workforce reduction, or operational priority change.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule was cancelled. Populated when a shift is removed due to leave, operational changes, or workforce reallocation.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the technician confirmed receipt and acceptance of this schedule assignment. Used to track acknowledgment compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was first created in the system. Represents the initial generation of the schedule assignment.',
    `dispatch_system_sync_flag` BOOLEAN COMMENT 'Indicates whether this schedule record has been successfully synchronized to the Granite Telecommunications WFM dispatch optimization system. Used for integration monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was most recently updated. Used for change tracking and audit trail.',
    `leave_approval_date` DATE COMMENT 'Date when the leave request was approved by the manager. Used for audit trail and to measure approval cycle time.',
    `leave_request_date` DATE COMMENT 'Date when the leave request was submitted by the technician. Used to track request-to-approval workflow timing and compliance with notice requirements.',
    `leave_type` STRING COMMENT 'Classification of absence or leave taken during this scheduled period. Null if the technician is working; populated when the schedule represents a leave block. [ENUM-REF-CANDIDATE: annual_leave|sick_leave|fmla|training_leave|emergency_absence|bereavement|jury_duty — 7 candidates stripped; promote to reference product]',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether the technician is eligible for overtime compensation during this shift. Determined by labor classification, union rules, and shift type.',
    `overtime_pay_classification` STRING COMMENT 'Pay rate multiplier applied to overtime hours. Determined by labor agreements, shift timing (weekday vs weekend vs holiday), and overtime duration.. Valid values are `straight_time|time_and_half|double_time|premium_rate`',
    `overtime_reason_code` STRING COMMENT 'Classification code indicating the business reason for overtime work. Used for cost allocation, workforce planning, and operational analysis.. Valid values are `planned_rollout|emergency_outage|noc_callout|maintenance_window|customer_escalation|backlog_clearance`',
    `payroll_system_sync_flag` BOOLEAN COMMENT 'Indicates whether this schedule record and associated hours have been successfully synchronized to SAP S/4HANA payroll. Used for integration monitoring and payroll reconciliation.',
    `planned_overtime_hours` DECIMAL(18,2) COMMENT 'Pre-approved overtime hours scheduled for this shift. Typically used for planned network rollout surges, maintenance windows, or outage response preparation.',
    `planned_work_hours` DECIMAL(18,2) COMMENT 'Total hours the technician was scheduled to work during this shift, excluding breaks. Used for capacity planning and utilization analysis.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule was published to the technician. Marks the transition from draft to active schedule and starts the confirmation window.',
    `schedule_change_reason` STRING COMMENT 'Free-text description of the reason for any schedule modification after initial publication. Captures business context for audit and operational review.',
    `schedule_date` DATE COMMENT 'The calendar date for which this schedule assignment applies. Represents the business day of the scheduled work.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the schedule assignment. Tracks progression from draft creation through publication, technician confirmation, execution, and completion or cancellation.. Valid values are `draft|published|confirmed|in_progress|completed|cancelled`',
    `schedule_version` STRING COMMENT 'Version number of this schedule record. Incremented each time the schedule is modified, supporting change audit trail and historical analysis.',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the shift in hours, including break time. Standard shifts are typically 8 or 10 hours; on-call shifts may vary.',
    `shift_end_time` TIMESTAMP COMMENT 'The precise date and time when the technicians shift ends. Used to calculate shift duration and availability windows.',
    `shift_start_time` TIMESTAMP COMMENT 'The precise date and time when the technicians shift begins. Used for dispatch optimization and field coordination.',
    `shift_type` STRING COMMENT 'Classification of the shift pattern. Indicates whether the shift is a standard day shift, evening shift, night shift, on-call rotation, weekend rotation, or holiday coverage.. Valid values are `day|evening|night|on_call|weekend|holiday`',
    `work_order_impact_count` STRING COMMENT 'Number of work orders originally assigned to this technician for this shift that were impacted by leave or schedule changes. Used to assess operational disruption.',
    CONSTRAINT pk_technician_schedule PRIMARY KEY(`technician_schedule_id`)
) COMMENT 'SSOT for all technician time allocation, availability, and shift management. Encompasses: (1) Shift templates — standard shift patterns (day/evening/on-call/weekend rotation) with start/end times, duration, break rules, overtime eligibility, and applicable days. (2) Individual shift assignments — generated from templates, capturing shift type, assigned territory, depot, status (draft/published/confirmed/cancelled), and schedule change audit trail. (3) Overtime records — planned overtime (pre-approved for outage response, rollout surge) and emergency overtime (unplanned NOC callout), with hours, reason code, approving manager, pay classification (straight-time/time-and-a-half/double-time), and payroll period. (4) Leave/absence blocks — annual leave, sick leave, FMLA, training leave, emergency absence, with request/approval workflow, coverage plan (replacement technician), and impact on scheduled work orders. Includes planned vs. actual hours and payroll period references. Feeds dispatch optimization (Granite WFM) and SAP S/4HANA payroll.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order. Primary key for the work order entity.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Add-on services (premium channels, speed boosts, static IP) often require field technician provisioning or equipment configuration. Links work orders to specific add-ons for fulfillment tracking, tech',
    `alarm_event_id` BIGINT COMMENT 'Foreign key linking to assurance.alarm_event. Business justification: Alarm-driven field dispatch: network alarms directly trigger work orders for field remediation without requiring a full NOC incident. Telecom operations teams expect work orders to reference the origi',
    `team_id` BIGINT COMMENT 'Reference to the field service team or crew assigned to this work order, used when multiple technicians are required.',
    `technician_id` BIGINT COMMENT 'Reference to the field technician or workforce resource assigned to execute this work order.',
    `case_id` BIGINT COMMENT 'Foreign key linking to customer.case. Business justification: Work orders generated from customer service cases (trouble tickets, service requests, retention offers requiring site visits) need case linkage for closed-loop resolution tracking, first-call resoluti',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Installation, repair, and upgrade work orders must reference the specific catalog_item (broadband plan, fiber service, TV package) being provisioned or serviced. Critical for parts planning, skill mat',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise B2B work orders (site installations, circuit provisioning, CPE swaps, managed service maintenance) must track which corporate account is served for billing reconciliation, SLA measurement, ',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this work order, linking field work to the billing and service relationship.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Telecom field dispatch requires knowing the on-site contact person for technician arrival coordination, access authorization, and signature capture. The customer_contact record holds the authorized co',
    `dealer_id` BIGINT COMMENT 'Foreign key linking to partner.dealer. Business justification: Dealer-originated installations require work orders to reference the originating dealer for commission tracking, dealer SLA accountability, and dealer performance reporting. Telecom domain experts uni',
    `depot_id` BIGINT COMMENT 'Reference to the field service depot or warehouse from which the technician was dispatched and materials were sourced.',
    `device_model_id` BIGINT COMMENT 'Foreign key linking to product.device_model. Business justification: Work orders for device installation, swap, or repair must reference the product catalog device model to determine required tools, compatible parts, and technician certification requirements. Distinct ',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to customer.device_registration. Business justification: Installation and repair work orders reference specific registered customer devices (CPE, set-top boxes, routers, ONTs) for equipment swap, firmware updates, and warranty service tracking. Links work o',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Contract-governed field work: enterprise installations, upgrades, and maintenance are executed under specific enterprise contracts with defined scope and SLAs. Direct FK enables contract compliance re',
    `fulfillment_order_id` BIGINT COMMENT 'External identifier from the originating order management system that triggered this work order, enabling traceability to customer orders.',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to customer.customer_interaction. Business justification: Telecom field dispatch is frequently triggered by a specific customer interaction (complaint call, fault report). Linking work_order directly to customer_interaction enables interaction-to-resolution ',
    `iot_deployment_id` BIGINT COMMENT 'Foreign key linking to enterprise.iot_deployment. Business justification: IoT deployment field operations: technicians physically install, maintain, and decommission IoT device deployments at enterprise sites. Work orders for IoT device activation or repair must reference t',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Lawful intercept orders require physical field work to install monitoring equipment, configure network taps, or provision intercept capabilities. Work orders execute these court-mandated technical imp',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Managed service field operations: work orders are raised to install, repair, or modify enterprise managed services. Direct FK enables managed service SLA breach root-cause analysis, field KPI reportin',
    `element_id` BIGINT COMMENT 'Reference to the network infrastructure element (OLT, ONT, DSLAM, BNG, cell site) that is the target of this work order.',
    `noc_incident_id` BIGINT COMMENT 'Foreign key linking to assurance.noc_incident. Business justification: Major network incidents spawn multiple field work orders for restoration (fiber cuts, equipment failures). Core incident management process linking NOC command center to field execution teams.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Work orders are raised to fulfill specific product offerings (fiber activation, broadband install, TV setup). Linking work_order to offering enables offering-level SLA tracking, technician skill requi',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Enterprise service installations are traceable to the originating sales opportunity. This FK supports opportunity-to-fulfillment tracking, sales revenue attribution, and sales-to-delivery cycle time r',
    `outage_record_id` BIGINT COMMENT 'Foreign key linking to assurance.outage_record. Business justification: Outage restoration dispatch: outage records directly drive field work orders for physical restoration (e.g., fibre cut repair, equipment replacement). Telecom operations require linking restoration wo',
    `parent_work_order_id` BIGINT COMMENT 'Reference to the parent work order if this is a follow-up or child work order, enabling tracking of multi-visit resolution chains.',
    `problem_record_id` BIGINT COMMENT 'Foreign key linking to assurance.problem_record. Business justification: Problem-to-field-fix process (ITIL): problem records for known infrastructure faults spawn field work orders for permanent fix implementation (e.g., hardware replacement). Telecom problem managers exp',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to product.promo_offer. Business justification: Promotional offers (free installation, waived activation fees, bonus equipment) trigger field work orders with special handling. Links work orders to promo_offer for validating promo eligibility at se',
    `provisioning_order_id` BIGINT COMMENT 'Foreign key linking to service.provisioning_order. Business justification: OSS/BSS field execution reconciliation: provisioning orders trigger field work orders for physical activation (CPE installation, line connection). Direct FK enables provisioning SLA tracking, fallout ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Telecom work orders are frequently mandated by regulatory obligations (E911 infrastructure, accessibility compliance, mandatory network upgrades). Linking work_order to the triggering regulatory_oblig',
    `retention_offer_id` BIGINT COMMENT 'Foreign key linking to sales.retention_offer. Business justification: Telecom field technicians present retention offers during service visits to at-risk customers. This FK links the work order execution to the retention offer presented, enabling field-retention program',
    `route_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.route_plan. Business justification: A work order is a stop on a technicians daily route plan. Linking work_order.route_plan_id -> workforce.route_plan.route_plan_id enables route-level analytics (completion rates per route, SLA complia',
    `sdwan_topology_id` BIGINT COMMENT 'Foreign key linking to enterprise.sdwan_topology. Business justification: SD-WAN CPE field installation: technicians install and configure SD-WAN CPE devices at enterprise sites as part of SD-WAN topology deployments. Work orders for SD-WAN site activation, CPE replacement,',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: Technicians dispatched to specific enterprise customer sites need site-specific access instructions, contact info, service hours, security requirements. Essential for routing optimization, on-site coo',
    `sla_breach_event_id` BIGINT COMMENT 'Foreign key linking to assurance.sla_breach_event. Business justification: SLA breach remediation dispatch: when an SLA breach is detected, a field work order is created to restore service and halt the breach. Telecom SLA management requires linking the remediation work orde',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to partner.sla_definition. Business justification: Work orders executed for wholesale/MVNO partners must reference the governing partner SLA definition for breach detection, penalty calculation, and SLA compliance reporting. Telecom operations teams r',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Telecom field work orders for antenna commissioning, frequency testing, and spectrum equipment installation must reference the authorizing spectrum license. Regulators require evidence that field work',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Field work orders for subscriber-specific services (SIM swap, device troubleshooting, IMEI registration, service activation/deactivation) require direct subscriber reference beyond account level for t',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to customer.customer_subscription. Business justification: Telecom field work orders for installation, upgrade, or disconnection are executed against a specific subscription (e.g., broadband or TV addon activation). Technicians and dispatch systems need to kn',
    `svc_instance_id` BIGINT COMMENT 'Reference to the specific service instance being installed, repaired, or maintained by this work order.',
    `svc_location_id` BIGINT COMMENT 'Foreign key linking to service.svc_location. Business justification: Work orders are dispatched to service locations. Current site_latitude/site_longitude are denormalized from svc_location. Proper FK enables depot-to-location dispatch optimization, serviceability repo',
    `technician_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.technician_schedule. Business justification: A work order is executed within a technicians scheduled shift. Linking work_order.technician_schedule_id -> workforce.technician_schedule.technician_schedule_id enables schedule-to-execution reconcil',
    `uc_subscription_id` BIGINT COMMENT 'Foreign key linking to enterprise.uc_subscription. Business justification: UC provisioning field work: technicians install and configure UC equipment (IP phones, SIP trunks, on-premise UC hardware) under UC subscriptions. Work orders for UC provisioning, moves, adds, and cha',
    `arrival_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the technician arrived at the work site, captured via mobile device check-in.',
    `completion_timestamp` TIMESTAMP COMMENT 'Timestamp when all field work activities were completed and the technician closed the work order in the mobile system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order record was first created in the system, marking the start of the work order lifecycle.',
    `customer_satisfaction_rating` STRING COMMENT 'Immediate customer satisfaction rating provided at work completion, typically on a 1-5 scale, used for technician performance evaluation.',
    `customer_signature_captured` BOOLEAN COMMENT 'Boolean indicator whether customer sign-off was obtained via digital signature on the mobile device, confirming work completion and acceptance.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order was dispatched to the field technician through the mobile workforce management system.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator whether the work order was escalated to higher-level support or management due to complexity, delays, or customer complaints.',
    `escalation_reason` STRING COMMENT 'Description of why the work order was escalated, including technical complexity, customer dissatisfaction, or resource constraints.',
    `first_time_fix_flag` BOOLEAN COMMENT 'Boolean indicator whether the work order was completed successfully on the first visit without requiring follow-up, a key operational KPI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the work order record, used for change tracking and audit trail.',
    `priority` STRING COMMENT 'Business priority level assigned to the work order. P1 indicates critical/emergency (service down), P2 high priority (service degraded), P3 normal priority (planned work), P4 low priority (non-urgent maintenance).. Valid values are `P1|P2|P3|P4`',
    `repeat_visit_flag` BOOLEAN COMMENT 'Boolean indicator whether this work order is a repeat visit to the same site for the same issue, indicating initial resolution failure.',
    `resolution_code` STRING COMMENT 'Standardized outcome code indicating how the work order was resolved, used for first-time-fix rate analysis and operational reporting. [ENUM-REF-CANDIDATE: completed_successfully|completed_with_issues|customer_not_available|site_not_ready|parts_unavailable|escalated|cancelled_by_customer — 7 candidates stripped; promote to reference product]',
    `resolution_notes` STRING COMMENT 'Free-text notes entered by the technician describing work performed, issues encountered, and final resolution details.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned timestamp for completion of field work, defining the appointment window end and resource allocation duration.',
    `scheduled_start_date` DATE COMMENT 'Planned date when the field work is scheduled to begin, used for appointment booking and customer communication.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise timestamp when the field technician is scheduled to begin work at the site, defining the appointment window start.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator whether the work order completion exceeded the SLA target time, triggering potential customer credits or penalties.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target time in hours for work order completion as defined by the service level agreement, measured from dispatch to completion.',
    `source_system` STRING COMMENT 'Operational system that originated this work order record, typically Oracle Communications OSM for service fulfillment orders or Granite WFM for field dispatch.. Valid values are `oracle_osm|granite_wfm|servicenow|netcracker`',
    `total_labor_hours` DECIMAL(18,2) COMMENT 'Total hours of labor expended on this work order across all technicians and activities, used for cost allocation and productivity analysis.',
    `total_material_cost` DECIMAL(18,2) COMMENT 'Total cost of all materials and parts consumed during work order execution, aggregated from material line items.',
    `work_order_number` STRING COMMENT 'Externally visible business identifier for the work order, used for tracking and reference by field technicians and customers.. Valid values are `^WO[0-9]{8,12}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle state of the work order in the field service workflow, from initial creation through completion or cancellation. [ENUM-REF-CANDIDATE: draft|scheduled|dispatched|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the work order based on the nature of field activity: installation of new service, repair of existing service, preventive maintenance, site survey, network upgrade, or equipment decommissioning.. Valid values are `install|repair|maintenance|survey|upgrade|decommission`',
    `work_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the technician began actual field work activities, distinct from arrival time which may include site assessment.',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core transactional entity representing field work assignments dispatched to technicians, with activity-level execution detail and materials consumed. Header: work order number, type (install/repair/maintenance/survey), priority (P1–P4), customer reference, network element reference, site address, scheduled window, assigned technician, dispatch/arrival/completion times, resolution code, SLA target and breach flag, escalation flag. Activity lines: individual tasks performed (site survey, cable pull, fiber splice, ONT power-up, signal test, CPE config, safety check, customer sign-off) with sequence, activity type, technician performing, start/end timestamps, outcome (pass/fail/deferred), and notes. Material lines: parts consumed (fiber cable, connectors, ONT units, CPE devices, splice trays, patch panels) with material code, quantity planned vs. used, unit of measure, serial number (for serialized assets), source depot, and cost. SSOT for field work execution, MTTR analysis, first-time-fix tracking, and inventory consumption. Sourced from Oracle Communications OSM and Granite WFM.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` (
    `dispatch_event_id` BIGINT COMMENT 'Unique identifier for the dispatch event record. Primary key for the dispatch event transaction.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to order.appointment. Business justification: Dispatch events assign technicians to customer appointments for installation/repair. Critical operational link for field service coordination, customer ETA management, real-time status updates, and tr',
    `field_vehicle_id` BIGINT COMMENT 'Reference to the service vehicle assigned to the technician for this dispatch event. Used for fleet management, route optimization, and asset utilization analysis.',
    `technician_id` BIGINT COMMENT 'Reference to the field technician assigned to this dispatch event. Represents the current technician responsible for executing the work order.',
    `skill_id` BIGINT COMMENT 'Foreign key linking to workforce.skill. Business justification: dispatch_event has skill_requirement_code (STRING) which is a denormalized reference to the skill taxonomy. Normalizing this to required_skill_id -> workforce.skill.skill_id establishes proper referen',
    `route_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.route_plan. Business justification: A dispatch event occurs within the context of a daily route plan. Linking dispatch_event.route_plan_id -> workforce.route_plan.route_plan_id allows the WFM system to track which dispatches were planne',
    `task_id` BIGINT COMMENT 'Foreign key linking to order.order_task. Business justification: Dispatch events execute specific order tasks (provision MSISDN, install ONT, configure CPE). Critical for task-level execution tracking, fallout resolution, and linking workforce dispatch actions to g',
    `technician_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.technician_schedule. Business justification: A dispatch event is triggered within the context of a technicians scheduled shift. Linking dispatch_event.technician_schedule_id -> workforce.technician_schedule.technician_schedule_id enables operat',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Trouble ticket escalation dispatch: P1/P2 trouble tickets trigger direct emergency dispatch events in telecom NOC operations. Linking dispatch_event to trouble_ticket enables SLA breach tracking at di',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that this dispatch event is associated with. Links dispatch action to the underlying service request or maintenance task.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the assigned technician acknowledged receipt of the dispatch instruction via mobile app or other communication channel. Null if not yet acknowledged.',
    `after_hours_flag` BOOLEAN COMMENT 'Boolean indicator of whether the dispatch occurred outside of standard business hours (evenings, weekends, holidays). True indicates after-hours dispatch, which may incur premium labor costs and affect OPEX (Operational Expenditure) analysis.',
    `arrival_timestamp` TIMESTAMP COMMENT 'Date and time when the technician arrived at the customer premises or network site, as recorded by the mobile workforce application or GPS tracking. Used for SLA compliance verification.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatch event was cancelled. Applicable only for dispatch_type = cancellation. Used for cancellation rate analysis and operational efficiency metrics.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatch event was marked as completed, indicating the technician has finished the assigned work and closed the dispatch lifecycle. Null for cancelled or failed dispatches.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this dispatch event record was first created in the workforce management system. Used for data lineage and audit trail purposes.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether an automated customer notification (SMS, email, or mobile app push) was sent informing the customer of the technician dispatch and estimated arrival time. True indicates notification sent.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer notification was sent. Null if no notification was sent. Used for customer communication audit and CSAT (Customer Satisfaction Score) correlation analysis.',
    `dispatch_channel` STRING COMMENT 'The communication channel or interface through which the dispatch instruction was transmitted to the technician: mobile workforce app, two-way radio, manual entry in WFM (Workforce Management) system, automated WFM routing engine, voice call, or SMS notification.. Valid values are `mobile_app|radio|manual_system|automated_wfm|voice_call|sms`',
    `dispatch_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84) of the technicians location at the moment of dispatch event creation. Used for route optimization analysis and dispatch efficiency metrics.',
    `dispatch_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84) of the technicians location at the moment of dispatch event creation. Used for route optimization analysis and dispatch efficiency metrics.',
    `dispatch_notes` STRING COMMENT 'Free-text operational notes entered by the dispatcher or system, providing additional instructions, site access information, safety warnings, or special handling requirements for the technician.',
    `dispatch_number` STRING COMMENT 'Human-readable business identifier for the dispatch event, used for tracking and audit purposes in field operations and NOC (Network Operations Center) systems.. Valid values are `^DSP-[0-9]{10}$`',
    `dispatch_priority` STRING COMMENT 'Urgency classification of the dispatch event: critical for network outages affecting multiple customers, high for SLA-sensitive installations, medium for standard service requests, low for routine maintenance.. Valid values are `critical|high|medium|low`',
    `dispatch_reason_code` STRING COMMENT 'Standardized code indicating the reason for the dispatch action. For initial dispatch: work order type. For reassignment: reason for reassignment (skill mismatch, technician unavailable, workload balancing). For escalation: complexity escalation, SLA breach risk. For cancellation: customer cancellation, duplicate order, resolved remotely.. Valid values are `^[A-Z]{3}-[0-9]{3}$`',
    `dispatch_reason_description` STRING COMMENT 'Free-text explanation providing additional context for the dispatch action, supplementing the standardized reason code. Used for root-cause analysis and operational improvement.',
    `dispatch_source_system` STRING COMMENT 'The originating system or module that created the dispatch event: Granite Telecommunications WFM automated routing, manual NOC dispatcher entry, automated OSS (Operations Support Systems) integration, CRM-triggered dispatch, or emergency dispatch system.. Valid values are `granite_wfm|noc_manual|automated_oss|crm_integration|emergency_dispatch`',
    `dispatch_status` STRING COMMENT 'Current lifecycle status of the dispatch event: pending technician acknowledgment, acknowledged by technician, technician en route to site, technician arrived on site, dispatch completed, dispatch failed, or dispatch cancelled. [ENUM-REF-CANDIDATE: pending|acknowledged|en_route|arrived|completed|failed|cancelled — 7 candidates stripped; promote to reference product]',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Precise date and time when the dispatch action was initiated by the dispatching system or supervisor. This is the principal business event timestamp for SLA (Service Level Agreement) tracking and NOC audit trails.',
    `dispatch_type` STRING COMMENT 'Classification of the dispatch action: initial assignment to technician, reassignment to different technician, escalation to senior technician, cancellation of dispatch, return-to-depot instruction, or emergency dispatch for critical network outages.. Valid values are `initial_dispatch|reassignment|escalation|cancellation|return_to_depot|emergency_dispatch`',
    `dispatch_zone_code` STRING COMMENT 'Geographic service zone or territory code where the dispatch event occurs. Used for workload balancing, regional performance analysis, and territory management.. Valid values are `^[A-Z]{3}-[0-9]{3}$`',
    `emergency_flag` BOOLEAN COMMENT 'Boolean indicator of whether this dispatch is classified as an emergency response (e.g., critical network outage, service-affecting fault, safety hazard). True indicates emergency dispatch requiring immediate response.',
    `en_route_timestamp` TIMESTAMP COMMENT 'Date and time when the technician marked themselves as en route to the target site in the mobile workforce application. Used for real-time tracking and customer ETA updates.',
    `estimated_arrival_timestamp` TIMESTAMP COMMENT 'Projected date and time when the technician is expected to arrive at the target site, calculated at dispatch time. Used for customer communication and SLA monitoring.',
    `estimated_travel_time_minutes` STRING COMMENT 'Calculated travel time in minutes from the technicians dispatch location to the target site, based on route optimization algorithms and real-time traffic data at dispatch time.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this dispatch event record was last updated. Used for change tracking, audit trails, and data synchronization across systems.',
    `reassignment_count` STRING COMMENT 'Cumulative count of how many times the underlying work order has been reassigned to different technicians. Incremented with each reassignment dispatch event. Used for operational efficiency analysis and first-time-fix rate calculation.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'The originally scheduled start time for the work order appointment. Used to measure dispatch timeliness and adherence to customer appointment windows.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the dispatch event resulted in an SLA breach (technician arrival exceeded the SLA target arrival time). True indicates breach occurred, False indicates SLA met.',
    `sla_target_arrival_minutes` STRING COMMENT 'The contractual SLA target for technician arrival time in minutes from dispatch timestamp, based on work order priority and customer service tier. Used for SLA breach detection and root-cause analysis.',
    `target_site_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84) of the customer premises or network site where the technician is being dispatched. Used for travel time estimation and route planning.',
    `target_site_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84) of the customer premises or network site where the technician is being dispatched. Used for travel time estimation and route planning.',
    CONSTRAINT pk_dispatch_event PRIMARY KEY(`dispatch_event_id`)
) COMMENT 'Transactional record capturing each dispatch action in the field workforce lifecycle — initial dispatch, reassignment, escalation, cancellation, and return-to-depot events. Captures dispatch timestamp, dispatching supervisor/system, technician assigned, prior technician (for reassignments), dispatch channel (mobile app, radio, manual), reason code, and GPS coordinates at dispatch time. Supports NOC dispatch audit trails and SLA breach root-cause analysis.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`route_plan` (
    `route_plan_id` BIGINT COMMENT 'Unique identifier for the route plan record. Primary key for the route plan entity.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to order.appointment. Business justification: Route plans sequence multiple appointments for technician daily schedules. Essential for route optimization, customer time-slot management, travel time estimation, and daily capacity utilization track',
    `depot_id` BIGINT COMMENT 'Identifier of the depot or service center from which the technician starts and ends their route.',
    `field_vehicle_id` BIGINT COMMENT 'Identifier of the vehicle assigned to the technician for this route plan.',
    `technician_id` BIGINT COMMENT 'Identifier of the field technician assigned to execute this route plan.',
    `technician_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.technician_schedule. Business justification: A route plan is generated for a technician on a specific date, which directly corresponds to a technician_schedule record (shift assignment for that date). Linking route_plan.technician_schedule_id ->',
    `actual_distance_km` DECIMAL(18,2) COMMENT 'Actual travel distance covered by the technician in kilometers, captured from GPS tracking or vehicle telematics.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual return time to the depot when the technician completed the route, captured from GPS or mobile app check-out.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual departure time from the depot when the technician began the route, captured from GPS or mobile app check-in.',
    `actual_travel_time_minutes` STRING COMMENT 'Actual total travel time in minutes spent by the technician moving between stops, captured from GPS tracking.',
    `actual_work_time_minutes` STRING COMMENT 'Actual total on-site work time in minutes spent by the technician across all stops.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the route plan was approved by a dispatcher or supervisor and transitioned from draft to active status.',
    `cancellation_reason` STRING COMMENT 'Reason for route plan cancellation, such as technician unavailability, weather emergency, or operational priority change.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Timestamp when the route plan was cancelled, if applicable.',
    `completed_stops` STRING COMMENT 'Number of stops that have been completed by the technician as of the current time.',
    `completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the route plan was marked as completed, indicating all stops have been processed and the technician has returned to depot.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the route plan record was first created in the Granite WFM system.',
    `customer_eta_notifications_sent` STRING COMMENT 'Count of customer ETA notifications sent for stops in this route plan, supporting customer experience and SLA compliance.',
    `deviation_percentage` DECIMAL(18,2) COMMENT 'Percentage deviation between planned and actual route execution metrics (time, distance, or stops), used for OPEX efficiency tracking.',
    `estimated_travel_time_minutes` STRING COMMENT 'Total estimated inter-stop travel time in minutes for the entire route, calculated by the optimization engine.',
    `estimated_work_time_minutes` STRING COMMENT 'Total estimated on-site work time in minutes across all stops, based on work order type and historical averages.',
    `fuel_estimate_liters` DECIMAL(18,2) COMMENT 'Estimated fuel consumption in liters for the route, calculated based on distance and vehicle fuel efficiency profile.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the route plan record was last updated, reflecting any changes to stops, sequence, or status.',
    `optimization_algorithm` STRING COMMENT 'The route optimization algorithm used by Granite WFM to generate this plan (e.g., time-window constrained, priority-weighted, fuel-optimized).. Valid values are `time_window|priority_weighted|fuel_optimized|distance_minimized|hybrid`',
    `optimization_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) representing the quality of the route optimization, calculated by the WFM engine based on efficiency metrics.',
    `plan_date` DATE COMMENT 'The calendar date for which this route plan was generated and is scheduled to be executed.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the route plan indicating its execution state.. Valid values are `draft|active|in_progress|completed|cancelled|suspended`',
    `planned_end_time` TIMESTAMP COMMENT 'Scheduled return time to the depot after completing all stops, as planned by the optimization engine.',
    `planned_start_time` TIMESTAMP COMMENT 'Scheduled departure time from the depot to begin the route, as planned by the optimization engine.',
    `route_notes` STRING COMMENT 'Free-text notes or special instructions related to the route plan, such as road closures, access restrictions, or coordination requirements.',
    `route_plan_number` STRING COMMENT 'Human-readable business identifier for the route plan, typically formatted as RP-YYYYMMDD-NNNN.. Valid values are `^RP-[0-9]{8}-[0-9]{4}$`',
    `route_priority` STRING COMMENT 'Overall priority level of the route plan, typically derived from the highest priority work order included in the route.. Valid values are `low|normal|high|urgent|critical`',
    `service_region_code` STRING COMMENT 'Geographic service region code where this route plan operates, used for regional workforce analytics and capacity planning.. Valid values are `^[A-Z]{2,3}-[A-Z0-9]{3,6}$`',
    `shift_type` STRING COMMENT 'Type of work shift during which this route plan is scheduled to be executed.. Valid values are `day|evening|night|weekend|on_call`',
    `skipped_stops` STRING COMMENT 'Number of stops that were skipped or not completed during route execution.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the route plan execution met all applicable SLA commitments for customer appointment windows and response times.',
    `source_system` STRING COMMENT 'Name of the source system from which this route plan record originated, typically Granite Telecommunications WFM.',
    `source_system_code` STRING COMMENT 'Unique identifier of this route plan in the source system (Granite WFM), used for data lineage and reconciliation.',
    `total_distance_km` DECIMAL(18,2) COMMENT 'Total planned travel distance for the entire route in kilometers, calculated by the optimization engine.',
    `total_stops` STRING COMMENT 'Total number of stops (work order sites) included in this route plan.',
    `traffic_conditions_considered` BOOLEAN COMMENT 'Indicates whether real-time or historical traffic conditions were factored into the route optimization algorithm.',
    `weather_conditions_considered` BOOLEAN COMMENT 'Indicates whether weather forecast data was factored into the route planning and time estimates.',
    CONSTRAINT pk_route_plan PRIMARY KEY(`route_plan_id`)
) COMMENT 'Transactional record of optimized daily route plans generated for technicians by Granite WFM route optimization engine, including ordered stop-level detail. Captures plan date, technician, depot start/end, and for each stop: sequence number, work order reference, site address, GPS coordinates, estimated/actual arrival and departure times, stop status (pending/arrived/completed/skipped), and inter-stop travel time. At plan level captures total estimated travel time, total distance (km/miles), optimization algorithm used (time-window, priority-weighted, fuel-optimized), plan status (draft/active/completed), and actual vs. planned deviation metrics. Supports OPEX reduction through fuel and time efficiency, real-time route tracking, and customer ETA updates.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` (
    `field_vehicle_id` BIGINT COMMENT 'Unique identifier for the field service vehicle. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Telecom fleet vehicles are subject to formal compliance audits (emissions, safety, load regulations). Linking field_vehicle to its most recent compliance audit record enables fleet compliance tracking',
    `technician_id` BIGINT COMMENT 'Identifier of the technician currently assigned to this vehicle. Null if vehicle is unassigned. Reflects the most recent assignment record.',
    `depot_id` BIGINT COMMENT 'Identifier of the depot or garage where the vehicle is based. Used for route optimization and regional fleet management.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the vehicle, including purchase price, taxes, and initial outfitting. Used for asset valuation and ROI analysis.',
    `acquisition_date` DATE COMMENT 'Date when the vehicle was acquired by the organization (purchase or lease start date). Used for CAPEX tracking and depreciation.',
    `average_fuel_consumption_per_100km` DECIMAL(18,2) COMMENT 'Rolling average fuel consumption rate in liters (or kWh for electric) per 100 kilometers. Used for cost forecasting and environmental reporting.',
    `color` STRING COMMENT 'Primary exterior color of the vehicle. Used for visual identification and branding compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle record was first created in the system. Used for audit trail and data lineage.',
    `current_assignment_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the current technician assignment began. Null if vehicle is unassigned. Used for utilization tracking.',
    `current_assignment_type` STRING COMMENT 'Type of the current assignment. Permanent assignments are long-term; daily and emergency are short-term. Affects dispatch planning.. Valid values are `permanent|daily|emergency|temporary`',
    `equipment_fitted` STRING COMMENT 'Comma-separated list of specialized equipment installed on the vehicle (e.g., aerial lift, cable drum, OTDR, fusion splicer, ladder rack). Determines work order eligibility.',
    `fuel_type` STRING COMMENT 'Type of fuel or energy source the vehicle uses. Critical for fuel cost allocation and environmental reporting.. Valid values are `gasoline|diesel|electric|hybrid|compressed_natural_gas|propane`',
    `gps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether the vehicle is equipped with active GPS tracking. Used for real-time fleet visibility and route optimization.',
    `gross_vehicle_weight_kg` DECIMAL(18,2) COMMENT 'Maximum allowable total weight of the vehicle including cargo and passengers. Used for regulatory compliance and route planning.',
    `inspection_due_date` DATE COMMENT 'Date when the next mandatory safety inspection is due. Required for regulatory compliance and dispatch eligibility.',
    `insurance_expiry_date` DATE COMMENT 'Date when the current insurance policy expires. Vehicles cannot be dispatched without valid insurance.',
    `insurance_policy_number` STRING COMMENT 'Policy number for the vehicles commercial insurance coverage. Required for compliance and incident management.',
    `last_inspection_date` DATE COMMENT 'Date when the most recent safety inspection was completed. Used to calculate next inspection interval.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance service was completed. Used to calculate next maintenance interval.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vehicle record was most recently modified. Used for audit trail and change tracking.',
    `lease_expiry_date` DATE COMMENT 'Date when the vehicle lease agreement expires. Null for owned vehicles. Used for fleet renewal planning.',
    `load_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum payload capacity of the vehicle in kilograms. Used for equipment assignment and safety compliance.',
    `maintenance_due_date` DATE COMMENT 'Date when the next scheduled preventive maintenance is due. Calculated based on odometer and time intervals per manufacturer specifications.',
    `make` STRING COMMENT 'Manufacturer or brand of the vehicle (e.g., Ford, Chevrolet, Mercedes-Benz).',
    `model` STRING COMMENT 'Specific model designation of the vehicle (e.g., Transit, Silverado, Sprinter).',
    `model_year` STRING COMMENT 'Year the vehicle model was manufactured. Used for depreciation calculation and maintenance scheduling.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special handling instructions, or operational remarks about the vehicle.',
    `odometer_reading` DECIMAL(18,2) COMMENT 'Current odometer reading in kilometers. Updated at each assignment return. Used for maintenance scheduling and lifecycle management.',
    `ownership_type` STRING COMMENT 'Indicates whether the vehicle is owned outright, leased long-term, or rented short-term. Affects CAPEX vs OPEX classification.. Valid values are `owned|leased|rented`',
    `registration_plate` STRING COMMENT 'License plate number assigned to the vehicle by the motor vehicle authority. Unique identifier for legal and operational tracking.. Valid values are `^[A-Z0-9]{2,10}$`',
    `seating_capacity` STRING COMMENT 'Number of passenger seats in the vehicle. Used for crew assignment and safety compliance.',
    `telematics_device_code` STRING COMMENT 'Unique identifier of the telematics device installed in the vehicle. Used to link vehicle data with real-time telemetry streams.',
    `total_maintenance_cost` DECIMAL(18,2) COMMENT 'Cumulative maintenance and repair costs incurred over the vehicles lifetime. Used for total cost of ownership (TCO) analysis.',
    `vehicle_identification_number` STRING COMMENT '17-character unique identifier assigned by the manufacturer. Used for warranty, recall, theft tracking, and asset verification.. Valid values are `^[A-HJ-NPR-Z0-9]{17}$`',
    `vehicle_status` STRING COMMENT 'Current operational status of the vehicle. Determines dispatch eligibility and fleet utilization metrics.. Valid values are `available|assigned|in_maintenance|out_of_service|retired|reserved`',
    `vehicle_type` STRING COMMENT 'Functional classification of the vehicle based on its primary use in field operations. Determines equipment compatibility and dispatch eligibility. [ENUM-REF-CANDIDATE: van|bucket_truck|cable_laying_truck|fiber_splicing_unit|pickup_truck|utility_vehicle|heavy_equipment — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_field_vehicle PRIMARY KEY(`field_vehicle_id`)
) COMMENT 'Master record for field service vehicles in the telecom workforce fleet with full assignment history. Vehicle attributes: registration plate, make/model/year, vehicle type (van, bucket truck, cable-laying, fiber splicing unit), assigned depot, fuel type, load capacity, equipment fitted (aerial lift, cable drum, OTDR, fusion splicer), odometer, insurance expiry, maintenance due date, and current status. Assignment history: technician, assignment date/time, return date/time, assignment type (permanent/daily/emergency), odometer at start/end, fuel level at start/end, return condition flag, and depot. Supports fleet dispatch, utilization tracking, fuel cost allocation, vehicle maintenance scheduling, and CAPEX/OPEX asset management. Sourced from Granite WFM fleet module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`workforce`.`team` (
    `team_id` BIGINT COMMENT 'Unique identifier for the field workforce team or crew grouping. Primary key.',
    `depot_id` BIGINT COMMENT 'Reference to the depot or service center where the team is based. Defines the home location for team dispatch and resource allocation.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Named account team assignment: telecom enterprise operations assign dedicated field teams to major corporate accounts for managed service delivery. Enables account-level team performance reporting, cu',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Contract-dedicated team assignment: enterprise contracts in telecom often specify dedicated field teams as part of SLA commitments. Links team resources to contractual obligations, enabling contract c',
    `technician_id` BIGINT COMMENT 'Reference to the technician who serves as the team lead or supervisor. Responsible for team coordination and work order execution oversight.',
    `site_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_site. Business justification: Enterprise field service delivery: telecom operators assign dedicated field teams to specific enterprise sites (e.g., corporate campus on-site support). This link enables site-level team performance r',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Entire field teams are subcontracted from managed services or infrastructure partners for network rollouts. Team-level partner reference enables subcontractor billing, SLA accountability per team, and',
    `average_completion_rate_pct` DECIMAL(18,2) COMMENT 'Historical average percentage of work orders completed successfully by the team on first visit. Key Performance Indicator (KPI) for team effectiveness.',
    `average_response_time_minutes` STRING COMMENT 'Historical average time in minutes from work order dispatch to team arrival at site. Key Performance Indicator (KPI) for team responsiveness.',
    `cost_center_code` STRING COMMENT 'Financial cost center code for team expense allocation and budget tracking. Links to enterprise resource planning (ERP) system.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this team record was first created in the workforce management system. Audit trail field in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `disbandment_date` DATE COMMENT 'Date when the team was disbanded or deactivated. Null for active teams. Used for historical workforce analysis.',
    `disbandment_reason` STRING COMMENT 'Business reason for team disbandment. Examples: project_completion, reorganization, budget_reduction, skill_consolidation. Null for active teams.',
    `emergency_response_capable` BOOLEAN COMMENT 'Indicates whether the team is trained and equipped for emergency response and network outage restoration. True if the team can be mobilized for critical incidents.',
    `formation_date` DATE COMMENT 'Date when the team was originally formed and activated in the workforce management system. Used for team lifecycle tracking.',
    `headcount` STRING COMMENT 'Current number of active technicians assigned to the team. Used for capacity planning and resource allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this team record was last updated in the workforce management system. Audit trail field in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `last_safety_training_date` DATE COMMENT 'Date when the team last completed mandatory safety training. Used for compliance tracking and certification management.',
    `max_capacity` STRING COMMENT 'Maximum number of technicians that can be assigned to this team based on operational design and resource constraints.',
    `mobile_equipped` BOOLEAN COMMENT 'Indicates whether the team has mobile workforce management devices and real-time connectivity for field operations. True if equipped with mobile WFM (Workforce Management) tools.',
    `next_certification_review_date` DATE COMMENT 'Scheduled date for the next team certification review or skills assessment. Used for workforce development planning.',
    `notes` STRING COMMENT 'Free-text notes and comments about the team. Used for operational context, special instructions, and historical annotations.',
    `operational_hours_end` STRING COMMENT 'Standard daily end time for team operations in HH:MM format (24-hour). Used for dispatch scheduling and route optimization.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `operational_hours_start` STRING COMMENT 'Standard daily start time for team operations in HH:MM format (24-hour). Used for dispatch scheduling and route optimization.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `primary_skill_category` STRING COMMENT 'Primary technical skill domain of the team. Defines the main area of expertise for work order assignment and capacity planning.. Valid values are `fiber_optics|wireless_ran|core_network|customer_premises|transport_network|power_systems`',
    `safety_incident_count` STRING COMMENT 'Cumulative count of safety incidents reported for this team. Used for safety performance tracking and compliance reporting.',
    `shift_pattern` STRING COMMENT 'Standard work schedule pattern for the team. Defines availability windows for dispatch and work order scheduling.. Valid values are `day_shift|night_shift|rotating|24x7_on_call|flexible`',
    `source_system` STRING COMMENT 'Name of the operational system of record that originated this team record. Typically Granite Telecommunications Workforce Management (WFM) for field workforce teams.',
    `source_system_code` STRING COMMENT 'Unique identifier for this team in the source operational system. Used for data lineage and reconciliation with Granite WFM.',
    `specialization_tags` STRING COMMENT 'Comma-separated list of technical specializations and certifications held by the team. Examples: fiber_splicing, 5G_NR_rollout, GPON_activation, FTTH_installation, CPE_configuration, OLT_maintenance. Used for skill-based dispatch and work order matching.',
    `team_code` STRING COMMENT 'Business identifier for the team, used in dispatch systems and field operations. Externally-known unique code for the team.. Valid values are `^[A-Z0-9]{4,12}$`',
    `team_name` STRING COMMENT 'Human-readable name of the field workforce team or crew.',
    `team_status` STRING COMMENT 'Current operational status of the team in the workforce management system. Indicates whether the team is available for dispatch and work order assignment.. Valid values are `active|inactive|suspended|on_leave|disbanded`',
    `team_type` STRING COMMENT 'Classification of the team based on primary function and specialization. Defines the operational role of the team within the workforce structure. [ENUM-REF-CANDIDATE: installation_crew|maintenance_gang|emergency_response|specialized_squad|fiber_splicing|5g_rollout|gpon_activation — 7 candidates stripped; promote to reference product]',
    `vehicle_count` STRING COMMENT 'Number of service vehicles assigned to the team for field operations and equipment transport.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Master record for field workforce teams and crew groupings with full membership roster. Team attributes: team code, name, type (installation crew, maintenance gang, emergency response, specialized squad), lead technician, assigned depot, service territory, headcount, active status, and specialization tags (fiber splicing, 5G NR rollout, GPON activation). Membership roster: each members technician reference, role within team (lead/member/trainee), assignment start/end dates, active flag, and reason for change. Supports dynamic team composition for network rollout projects and emergency response mobilization. Enables team-level dispatch, capacity planning, skill coverage queries, and performance tracking in Granite WFM.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_supervisor_technician_id` FOREIGN KEY (`supervisor_technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `telecommunication_ecm`.`workforce`.`skill`(`skill_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ADD CONSTRAINT `fk_workforce_technician_schedule_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_team_id` FOREIGN KEY (`team_id`) REFERENCES `telecommunication_ecm`.`workforce`.`team`(`team_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_parent_work_order_id` FOREIGN KEY (`parent_work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_route_plan_id` FOREIGN KEY (`route_plan_id`) REFERENCES `telecommunication_ecm`.`workforce`.`route_plan`(`route_plan_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ADD CONSTRAINT `fk_workforce_work_order_technician_schedule_id` FOREIGN KEY (`technician_schedule_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician_schedule`(`technician_schedule_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_field_vehicle_id` FOREIGN KEY (`field_vehicle_id`) REFERENCES `telecommunication_ecm`.`workforce`.`field_vehicle`(`field_vehicle_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `telecommunication_ecm`.`workforce`.`skill`(`skill_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_route_plan_id` FOREIGN KEY (`route_plan_id`) REFERENCES `telecommunication_ecm`.`workforce`.`route_plan`(`route_plan_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_technician_schedule_id` FOREIGN KEY (`technician_schedule_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician_schedule`(`technician_schedule_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ADD CONSTRAINT `fk_workforce_dispatch_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `telecommunication_ecm`.`workforce`.`work_order`(`work_order_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ADD CONSTRAINT `fk_workforce_route_plan_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ADD CONSTRAINT `fk_workforce_route_plan_field_vehicle_id` FOREIGN KEY (`field_vehicle_id`) REFERENCES `telecommunication_ecm`.`workforce`.`field_vehicle`(`field_vehicle_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ADD CONSTRAINT `fk_workforce_route_plan_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ADD CONSTRAINT `fk_workforce_route_plan_technician_schedule_id` FOREIGN KEY (`technician_schedule_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician_schedule`(`technician_schedule_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ADD CONSTRAINT `fk_workforce_field_vehicle_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ADD CONSTRAINT `fk_workforce_field_vehicle_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `telecommunication_ecm`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ADD CONSTRAINT `fk_workforce_team_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `telecommunication_ecm`.`workforce`.`technician`(`technician_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`workforce` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `telecommunication_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Home Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontracting Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `supervisor_technician_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Identifier');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `attendance_rate` SET TAGS ('dbx_business_glossary_term' = 'Attendance Rate');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'current|expiring_soon|expired|pending|not_required');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `current_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Current Performance Rating');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `current_performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score (CSAT)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'granite_wfm|sap_hcm|manual_entry|integration');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `drug_test_date` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|leave|terminated');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|mvno_partner|temporary');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `first_time_fix_rate` SET TAGS ('dbx_business_glossary_term' = 'First-Time Fix Rate (FCR)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `improvement_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `mean_time_to_repair` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `safety_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Compliance Score');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `service_zone` SET TAGS ('dbx_business_glossary_term' = 'Service Zone');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `service_zone` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|expert|master');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `sla_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Rate');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `tools_kit_code` SET TAGS ('dbx_business_glossary_term' = 'Tools Kit Identifier');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `tools_kit_code` SET TAGS ('dbx_value_regex' = '^TK[A-Z0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `training_hours_ytd` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Year-to-Date (YTD)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Member Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `vehicle_assigned` SET TAGS ('dbx_business_glossary_term' = 'Assigned Vehicle Identifier');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `vehicle_assigned` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `work_orders_per_day` SET TAGS ('dbx_business_glossary_term' = 'Work Orders Per Day');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician` ALTER COLUMN `workforce_classification` SET TAGS ('dbx_business_glossary_term' = 'Workforce Classification');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `skill_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `dispatch_priority_weight` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Priority Weight');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `prerequisite_skills` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Skills');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `proficiency_level_competent_definition` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level Competent Definition');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `proficiency_level_expert_definition` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level Expert Definition');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `proficiency_level_trainee_definition` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level Trainee Definition');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency (Months)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `replacement_skill_code` SET TAGS ('dbx_business_glossary_term' = 'Replacement Skill Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `skill_code` SET TAGS ('dbx_business_glossary_term' = 'Skill Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `skill_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `skill_description` SET TAGS ('dbx_business_glossary_term' = 'Skill Description');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `skill_name` SET TAGS ('dbx_business_glossary_term' = 'Skill Name');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `skill_status` SET TAGS ('dbx_business_glossary_term' = 'Skill Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `skill_status` SET TAGS ('dbx_value_regex' = 'Active|Deprecated|Obsolete|Planned');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Skill Subcategory');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `technology_domain` SET TAGS ('dbx_business_glossary_term' = 'Technology Domain');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Hours)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `vendor_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Specific Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`skill` ALTER COLUMN `work_order_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type Applicability');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Certification ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Mandating Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `skill_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal|revoked|in_progress');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `cpd_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Hours Earned');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|approved|reimbursed|denied');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `vendor_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Specific Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'online_registry|phone_verification|email_confirmation|document_review|third_party_service|self_attestation');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|unverified|verification_failed');
ALTER TABLE `telecommunication_ecm`.`workforce`.`certification` ALTER COLUMN `work_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Work Type Eligibility');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `depot_code` SET TAGS ('dbx_business_glossary_term' = 'Depot Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `depot_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `depot_name` SET TAGS ('dbx_business_glossary_term' = 'Depot Name');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `depot_type` SET TAGS ('dbx_business_glossary_term' = 'Depot Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `depot_type` SET TAGS ('dbx_value_regex' = 'central_warehouse|satellite_yard|noc_dispatch_center|mobile_hub|regional_staging|field_office');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Depot Email Address');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `facility_ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Ownership Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `facility_ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|shared|temporary');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `holiday_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Availability Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `noc_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Operations Center (NOC) Integration Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|temporarily_closed|under_maintenance|decommissioned|planned');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `parts_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts Inventory Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Depot Phone Number');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `primary_depot_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Depot Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `regional_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Regional Manager Email');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `regional_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `regional_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `regional_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `regional_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Regional Manager Name');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `regional_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Regional Manager Phone');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `regional_manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `regional_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|high_security|restricted_access');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `service_zone_polygon` SET TAGS ('dbx_business_glossary_term' = 'Service Zone Coverage Polygon');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `technician_headcount_capacity` SET TAGS ('dbx_business_glossary_term' = 'Technician Headcount Capacity');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `tool_storage_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Tool Storage Capacity (Square Feet)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `vehicle_bay_capacity` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Bay Capacity');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `weekend_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Availability Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`depot` ALTER COLUMN `wfm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Workforce Management (WFM) System Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` SET TAGS ('dbx_subdomain' = 'operations_execution');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `technician_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Schedule ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `actual_overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Overtime Hours');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `actual_work_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Work Hours');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `dispatch_system_sync_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispatch System Sync Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `leave_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `leave_request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `overtime_pay_classification` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Classification');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `overtime_pay_classification` SET TAGS ('dbx_value_regex' = 'straight_time|time_and_half|double_time|premium_rate');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `overtime_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Overtime Reason Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `overtime_reason_code` SET TAGS ('dbx_value_regex' = 'planned_rollout|emergency_outage|noc_callout|maintenance_window|customer_escalation|backlog_clearance');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `payroll_system_sync_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll System Sync Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `planned_overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Overtime Hours');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `planned_work_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Work Hours');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `schedule_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Schedule Change Reason');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|confirmed|in_progress|completed|cancelled');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `shift_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration Hours');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|on_call|weekend|holiday');
ALTER TABLE `telecommunication_ecm`.`workforce`.`technician_schedule` ALTER COLUMN `work_order_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Work Order Impact Count');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` SET TAGS ('dbx_subdomain' = 'operations_execution');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `dealer_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Location ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `device_model_id` SET TAGS ('dbx_business_glossary_term' = 'Device Model Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source Order ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Interaction Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `iot_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Iot Deployment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `noc_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Noc Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `outage_record_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `parent_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Order ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `problem_record_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `provisioning_order_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `retention_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Offer Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `route_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `sdwan_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Sdwan Topology Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `sla_breach_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Breach Event Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Subscription Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `svc_location_id` SET TAGS ('dbx_business_glossary_term' = 'Svc Location Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `technician_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Schedule Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `uc_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Uc Subscription Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Arrival Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Rating');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `customer_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Captured');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `first_time_fix_flag` SET TAGS ('dbx_business_glossary_term' = 'First Time Fix (FTF) Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `repeat_visit_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Visit Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'oracle_osm|granite_wfm|servicenow|netcracker');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `total_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Hours');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Material Cost');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO[0-9]{8,12}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'install|repair|maintenance|survey|upgrade|decommission');
ALTER TABLE `telecommunication_ecm`.`workforce`.`work_order` ALTER COLUMN `work_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Work Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` SET TAGS ('dbx_subdomain' = 'operations_execution');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `field_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Vehicle Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `skill_id` SET TAGS ('dbx_business_glossary_term' = 'Required Skill Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `route_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Order Task Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `technician_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Schedule Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Technician Acknowledgment Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `after_hours_flag` SET TAGS ('dbx_business_glossary_term' = 'After Hours Dispatch Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Site Arrival Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Cancellation Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_channel` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Communication Channel');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|radio|manual_system|automated_wfm|voice_call|sms');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_latitude` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Location Latitude');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_longitude` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Location Longitude');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Event Notes');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Event Number');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_priority` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Priority Level');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Reason Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{3}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Reason Description');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_source_system` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Source System');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_source_system` SET TAGS ('dbx_value_regex' = 'granite_wfm|noc_manual|automated_oss|crm_integration|emergency_dispatch');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Event Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Event Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_type` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Event Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_type` SET TAGS ('dbx_value_regex' = 'initial_dispatch|reassignment|escalation|cancellation|return_to_depot|emergency_dispatch');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Zone Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `dispatch_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{3}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `emergency_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Dispatch Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `en_route_timestamp` SET TAGS ('dbx_business_glossary_term' = 'En Route Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `estimated_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `estimated_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Travel Time (Minutes)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Count');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `sla_target_arrival_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Arrival (Minutes)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `target_site_latitude` SET TAGS ('dbx_business_glossary_term' = 'Target Site Latitude');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `target_site_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `target_site_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `target_site_longitude` SET TAGS ('dbx_business_glossary_term' = 'Target Site Longitude');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `target_site_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`dispatch_event` ALTER COLUMN `target_site_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` SET TAGS ('dbx_subdomain' = 'operations_execution');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `route_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `field_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `technician_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Schedule Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `actual_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Actual Distance (Kilometers)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `actual_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Travel Time (Minutes)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `actual_work_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Work Time (Minutes)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `completed_stops` SET TAGS ('dbx_business_glossary_term' = 'Completed Stops');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `customer_eta_notifications_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer ETA (Estimated Time of Arrival) Notifications Sent');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `estimated_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Travel Time (Minutes)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `estimated_work_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Work Time (Minutes)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `fuel_estimate_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Estimate (Liters)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `optimization_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Optimization Algorithm');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `optimization_algorithm` SET TAGS ('dbx_value_regex' = 'time_window|priority_weighted|fuel_optimized|distance_minimized|hybrid');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `optimization_score` SET TAGS ('dbx_business_glossary_term' = 'Optimization Score');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `plan_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|in_progress|completed|cancelled|suspended');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_business_glossary_term' = 'Planned End Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `route_notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `route_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Number');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `route_plan_number` SET TAGS ('dbx_value_regex' = '^RP-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `route_priority` SET TAGS ('dbx_business_glossary_term' = 'Route Priority');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `route_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `service_region_code` SET TAGS ('dbx_business_glossary_term' = 'Service Region Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `service_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[A-Z0-9]{3,6}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|weekend|on_call');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `skipped_stops` SET TAGS ('dbx_business_glossary_term' = 'Skipped Stops');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `total_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Total Distance (Kilometers)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `total_stops` SET TAGS ('dbx_business_glossary_term' = 'Total Stops');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `traffic_conditions_considered` SET TAGS ('dbx_business_glossary_term' = 'Traffic Conditions Considered');
ALTER TABLE `telecommunication_ecm`.`workforce`.`route_plan` ALTER COLUMN `weather_conditions_considered` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions Considered');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `field_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Field Vehicle ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Currently Assigned Technician ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Depot ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Acquisition Cost');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Acquisition Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `average_fuel_consumption_per_100km` SET TAGS ('dbx_business_glossary_term' = 'Average Fuel Consumption per 100 Kilometers');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Exterior Color');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `current_assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Current Assignment Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `current_assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Current Assignment Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `current_assignment_type` SET TAGS ('dbx_value_regex' = 'permanent|daily|emergency|temporary');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `equipment_fitted` SET TAGS ('dbx_business_glossary_term' = 'Fitted Equipment List');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'gasoline|diesel|electric|hybrid|compressed_natural_gas|propane');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'GPS Tracking Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `gross_vehicle_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Vehicle Weight (Kilograms)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Safety Inspection Due Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Inspection Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Completion Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `load_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Load Capacity (Kilograms)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Due Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `make` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Make');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Year');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Notes');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Current Odometer Reading (Kilometers)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Ownership Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|rented');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `registration_plate` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration Plate Number');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `registration_plate` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_business_glossary_term' = 'Telematics Device Identifier');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `telematics_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `total_maintenance_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Maintenance Cost');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `total_maintenance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `vehicle_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `vehicle_identification_number` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `vehicle_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `vehicle_status` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Operational Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `vehicle_status` SET TAGS ('dbx_value_regex' = 'available|assigned|in_maintenance|out_of_service|retired|reserved');
ALTER TABLE `telecommunication_ecm`.`workforce`.`field_vehicle` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type Classification');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Depot ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Technician ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontracting Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `average_completion_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Work Order Completion Rate Percentage');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `average_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time in Minutes');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `disbandment_date` SET TAGS ('dbx_business_glossary_term' = 'Team Disbandment Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `disbandment_reason` SET TAGS ('dbx_business_glossary_term' = 'Team Disbandment Reason');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `emergency_response_capable` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Capable Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Team Formation Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `headcount` SET TAGS ('dbx_business_glossary_term' = 'Team Headcount');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `last_safety_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Training Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `max_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Team Capacity');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `mobile_equipped` SET TAGS ('dbx_business_glossary_term' = 'Mobile Equipped Flag');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `mobile_equipped` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `mobile_equipped` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `next_certification_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Certification Review Date');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Team Notes');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `operational_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours End Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `operational_hours_end` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `operational_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours Start Time');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `operational_hours_start` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `primary_skill_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Skill Category');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `primary_skill_category` SET TAGS ('dbx_value_regex' = 'fiber_optics|wireless_ran|core_network|customer_premises|transport_network|power_systems');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Team Shift Pattern');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'day_shift|night_shift|rotating|24x7_on_call|flexible');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `specialization_tags` SET TAGS ('dbx_business_glossary_term' = 'Team Specialization Tags');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Team Status');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|on_leave|disbanded');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `telecommunication_ecm`.`workforce`.`team` ALTER COLUMN `vehicle_count` SET TAGS ('dbx_business_glossary_term' = 'Team Vehicle Count');
