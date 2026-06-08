-- Schema for Domain: security | Business: Shipping Ports | Version: v1_mvm
-- Generated on: 2026-05-10 06:53:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `shipping_ports_ecm`.`security` COMMENT 'Manages port facility security operations including ISPS Code compliance, access control systems, CCTV surveillance, security patrols, threat assessments, maritime domain awareness, and cybersecurity incident management for port IT/OT systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` (
    `facility_security_plan_id` BIGINT COMMENT 'Unique identifier for the Port Facility Security Plan (PFSP) record. Primary key for this entity.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: FSP implementation, upgrades, and ISPS compliance activities are funded via dedicated internal orders. Port finance teams require this link to track FSP-related capital and operational expenditure aga',
    `isps_facility_record_id` BIGINT COMMENT 'Reference to the port facility covered by this security plan.',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Each port location (berth, terminal, facility) requires its own approved FSP under ISPS Code. FSPs are location-specific with unique approval certificates, PFSO assignments, and security measures tail',
    `superseded_facility_security_plan_id` BIGINT COMMENT 'Self-referencing FK on facility_security_plan (superseded_facility_security_plan_id)',
    `vessel_type_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_type. Business justification: FSPs define security measures by vessel type per ISPS Code. Tankers, container ships, and passenger vessels require different security protocols (MARSEC level measures, screening requirements, access ',
    `access_control_system_type` STRING COMMENT 'Type or model of the access control system specified in the Port Facility Security Plan (e.g., RFID, biometric, card-based).',
    `amendment_count` STRING COMMENT 'Total number of amendments or revisions made to the Port Facility Security Plan since initial approval.',
    `approval_authority` STRING COMMENT 'Name of the flag state administration or Recognized Security Organization (RSO) that approved the PFSP.',
    `approval_certificate_number` STRING COMMENT 'Certificate reference number issued by the approval authority upon PFSP approval.',
    `approval_date` DATE COMMENT 'Date when the Port Facility Security Plan was officially approved by the designated authority.',
    `cctv_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the port facility area covered by CCTV surveillance systems as specified in the security plan.',
    `compliance_certificate_expiry` DATE COMMENT 'Expiry date of the ISPS Code compliance certificate associated with this Port Facility Security Plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this Port Facility Security Plan record was first created in the system.',
    `cybersecurity_measures_included` BOOLEAN COMMENT 'Indicates whether the Port Facility Security Plan includes specific cybersecurity measures for IT/OT systems protection.',
    `document_classification` STRING COMMENT 'Security classification level assigned to the Port Facility Security Plan document itself.. Valid values are `restricted|confidential|internal`',
    `document_storage_location` STRING COMMENT 'Physical or digital location where the official Port Facility Security Plan document is securely stored.',
    `drill_frequency_months` STRING COMMENT 'Frequency in months at which security drills and exercises must be conducted as specified in the plan.',
    `effective_from_date` DATE COMMENT 'Date from which the approved Port Facility Security Plan becomes operationally effective and binding.',
    `expiry_date` DATE COMMENT 'Date when the current Port Facility Security Plan expires and requires renewal or reapproval. Nullable for plans with indefinite validity subject to periodic review.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or revision to the Port Facility Security Plan.',
    `last_amendment_description` STRING COMMENT 'Brief description of the changes made in the most recent amendment to the Port Facility Security Plan.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit conducted on the Port Facility Security Plan implementation.',
    `last_audit_outcome` STRING COMMENT 'Result or finding of the most recent audit of the Port Facility Security Plan.. Valid values are `compliant|non_compliant|conditional|not_audited`',
    `last_drill_date` DATE COMMENT 'Date of the most recent security drill or exercise conducted under this Port Facility Security Plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this Port Facility Security Plan record was last updated or modified in the system.',
    `marsec_level_1_measures` STRING COMMENT 'Summary of security measures and procedures defined in the plan for Maritime Security (MARSEC) Level 1 (normal operations).',
    `marsec_level_2_measures` STRING COMMENT 'Summary of heightened security measures and procedures defined in the plan for Maritime Security (MARSEC) Level 2 (heightened risk).',
    `marsec_level_3_measures` STRING COMMENT 'Summary of exceptional security measures and procedures defined in the plan for Maritime Security (MARSEC) Level 3 (probable or imminent security incident).',
    `next_drill_date` DATE COMMENT 'Scheduled date for the next mandatory security drill or exercise.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review or revalidation of the Port Facility Security Plan.',
    `patrol_frequency_hours` DECIMAL(18,2) COMMENT 'Frequency in hours at which security patrols must be conducted as specified in the Port Facility Security Plan.',
    `pfso_contact_number` STRING COMMENT 'Primary contact telephone number for the designated Port Facility Security Officer.',
    `pfso_email_address` STRING COMMENT 'Official email address for the designated Port Facility Security Officer.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `pfso_name` STRING COMMENT 'Full name of the designated Port Facility Security Officer at the time of plan approval.',
    `plan_reference_number` STRING COMMENT 'Official reference number assigned to the Port Facility Security Plan by the approval authority. Externally-known unique identifier for the plan.. Valid values are `^PFSP-[A-Z0-9]{6,12}$`',
    `plan_scope_description` STRING COMMENT 'Detailed description of the scope and coverage of the Port Facility Security Plan, including physical boundaries, operations covered, and exclusions.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the Port Facility Security Plan. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|under_review|suspended|expired — 7 candidates stripped; promote to reference product]',
    `plan_version` STRING COMMENT 'Version number of the approved Port Facility Security Plan following major.minor format (e.g., 2.1, 3.0).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `remarks` STRING COMMENT 'Additional notes, comments, or special conditions related to the Port Facility Security Plan.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the Port Facility Security Plan must be reviewed and updated (e.g., 12, 24, 36 months).',
    `security_assessment_reference` STRING COMMENT 'Reference number or identifier of the Port Facility Security Assessment (PFSA) upon which this plan is based.',
    `threat_assessment_date` DATE COMMENT 'Date of the most recent threat assessment conducted for the port facility as part of the security plan maintenance.',
    `training_program_reference` STRING COMMENT 'Reference to the security training and drill program defined in the Port Facility Security Plan.',
    CONSTRAINT pk_facility_security_plan PRIMARY KEY(`facility_security_plan_id`)
) COMMENT 'Master record for the Port Facility Security Plan (PFSP) as mandated by ISPS Code Part B. Captures the approved plan version, approval authority (flag state / RSO), plan scope covering all MARSEC levels (1, 2, 3), designated Port Facility Security Officer (PFSO), plan review cycle, last audit date, next review date, approval certificate reference, and amendment history. This is the foundational ISPS compliance document for each port facility.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`security`.`zone` (
    `zone_id` BIGINT COMMENT 'Unique identifier for the security zone within the port facility. Primary key for the security zone registry.',
    `facility_security_plan_id` BIGINT COMMENT 'Foreign key linking to security.facility_security_plan. Business justification: Each security zone is defined and governed by a specific Port Facility Security Plan (PFSP) as mandated by ISPS Code. The zone table currently holds pfsp_reference_section (STRING) as a free-text refe',
    `isps_facility_record_id` BIGINT COMMENT 'Foreign key linking to compliance.isps_facility_record. Business justification: Security zones are defined within ISPS-regulated port facilities and their security requirements (access controls, patrol frequencies, MARSEC measures) are governed by the facilitys ISPS record. ISPS',
    `parent_zone_id` BIGINT COMMENT 'Self-referencing FK on zone (parent_zone_id)',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Security zones are physical subdivisions of port locations (restricted areas, public areas, cargo zones). Each zone maps to a specific berth, terminal, or yard location for access control, patrol rout',
    `access_control_requirement_marsec1` STRING COMMENT 'Detailed description of access control measures required for this zone when operating at MARSEC Level 1 (normal security). Includes badge requirements, escort policies, vehicle inspection protocols, and entry authorization procedures.',
    `access_control_requirement_marsec2` STRING COMMENT 'Enhanced access control measures required for this zone when operating at MARSEC Level 2 (heightened security threat). Typically includes additional screening, reduced access lists, mandatory escorts, and enhanced vehicle searches.',
    `access_control_requirement_marsec3` STRING COMMENT 'Maximum security access control measures required for this zone when operating at MARSEC Level 3 (imminent security threat). May include zone closure, armed security, biometric verification, and complete lockdown procedures.',
    `access_point_count` STRING COMMENT 'Number of controlled access points (gates, doors, turnstiles) into the security zone. Used for access control planning and security resource allocation.',
    `area_square_meters` DECIMAL(18,2) COMMENT 'Total area of the security zone measured in square meters. Used for resource allocation, patrol planning, and CCTV coverage calculations.',
    `boundary_description` STRING COMMENT 'Textual description of the physical boundaries of the security zone. Includes landmarks, fence lines, berth numbers, building identifiers, and geographic references for operational clarity.',
    `boundary_gis_polygon` STRING COMMENT 'GIS polygon coordinates defining the precise geographic boundaries of the security zone in WKT (Well-Known Text) format. Used for spatial analysis, mapping, and automated geofencing in access control systems.',
    `cctv_camera_count` STRING COMMENT 'Number of CCTV cameras actively monitoring this security zone. Used for surveillance coverage assessment and maintenance planning.',
    `cctv_coverage_flag` BOOLEAN COMMENT 'Indicates whether the security zone is covered by CCTV surveillance systems. True if cameras monitor the zone, false if no camera coverage exists.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this security zone record was first created in the system. Used for audit trail and data lineage.',
    `critical_infrastructure_flag` BOOLEAN COMMENT 'Indicates whether this security zone contains critical infrastructure as defined by national security regulations. True for zones containing fuel storage, power generation, control centers, or other critical assets.',
    `cybersecurity_zone_flag` BOOLEAN COMMENT 'Indicates whether this zone includes IT/OT (Information Technology/Operational Technology) systems requiring cybersecurity controls. True for zones with control rooms, server facilities, or networked operational systems.',
    `effective_from_date` DATE COMMENT 'Date when this security zone designation became effective. Used for historical tracking and compliance documentation.',
    `effective_to_date` DATE COMMENT 'Date when this security zone designation expires or is scheduled for review. Null for indefinite zones. Used for temporary security zones or zones under periodic review.',
    `emergency_assembly_point` STRING COMMENT 'Designated emergency assembly point location for personnel evacuating from this security zone. Used for emergency response planning and safety drills.',
    `incident_count_ytd` STRING COMMENT 'Total number of security incidents recorded in this zone during the current calendar year. Used for security performance monitoring and resource allocation.',
    `last_incident_date` DATE COMMENT 'Date of the most recent security incident recorded in this zone. Used for risk assessment and security effectiveness analysis. Null if no incidents have occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this security zone record was last updated. Used for change tracking and audit compliance.',
    `last_risk_assessment_date` DATE COMMENT 'Date when the most recent security risk assessment was conducted for this zone. ISPS Code requires periodic reassessment of security zones.',
    `lighting_adequacy_flag` BOOLEAN COMMENT 'Indicates whether the security zone has adequate lighting for security purposes as per ISPS Code requirements. True if lighting meets standards, false if lighting is insufficient or requires upgrade.',
    `marsec_level_applicability` STRING COMMENT 'Indicates which MARSEC security levels this zone designation applies to. MARSEC 1 is normal operations, MARSEC 2 is heightened threat, MARSEC 3 is imminent threat. Some zones may only be activated at higher MARSEC levels.. Valid values are `marsec_1|marsec_2|marsec_3|all_levels`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this security zone record. Used for accountability and audit trail.',
    `next_risk_assessment_due_date` DATE COMMENT 'Scheduled date for the next mandatory security risk assessment of this zone. Used for compliance tracking and audit preparation.',
    `operational_hours` STRING COMMENT 'Standard operational hours for this security zone. Format examples: 24/7, 0600-2200, Business Hours Only. Affects access control and patrol scheduling.',
    `patrol_frequency_hours` DECIMAL(18,2) COMMENT 'Required frequency of security patrols for this zone measured in hours. For example, 2.0 indicates patrols every 2 hours, 0.5 indicates patrols every 30 minutes. Used for patrol scheduling and compliance verification.',
    `patrol_type` STRING COMMENT 'Primary method of security patrol used for this zone. Foot patrols for pedestrian areas, vehicle patrols for large zones, marine patrols for waterside zones, combined for multi-modal, remote monitoring for camera-only surveillance.. Valid values are `foot_patrol|vehicle_patrol|marine_patrol|combined_patrol|remote_monitoring`',
    `perimeter_fencing_type` STRING COMMENT 'Type of physical barrier securing the perimeter of the security zone. Chain link for standard fencing, concrete wall for high-security areas, steel barrier for vehicle protection, water barrier for waterside zones, none for open zones.. Valid values are `chain_link|concrete_wall|steel_barrier|water_barrier|none|mixed`',
    `remarks` STRING COMMENT 'Additional notes, special instructions, or operational considerations for this security zone. May include seasonal variations, temporary restrictions, or coordination requirements with other zones.',
    `restricted_cargo_types` STRING COMMENT 'Types of cargo that are restricted or prohibited within this security zone. Examples: IMDG Class 1 explosives, radioactive materials, high-value cargo. Pipe-separated list for multiple restrictions.',
    `threat_level` STRING COMMENT 'Current assessed threat level for this specific security zone based on intelligence, historical incidents, and risk assessments. May differ from overall port MARSEC level for high-value or vulnerable zones.. Valid values are `low|moderate|elevated|high|critical`',
    `zone_code` STRING COMMENT 'Unique alphanumeric code assigned to the security zone for operational reference and access control system integration. Used in gate systems and patrol logs.. Valid values are `^[A-Z0-9]{3,10}$`',
    `zone_status` STRING COMMENT 'Current operational status of the security zone. Active zones are enforced, inactive zones are not currently monitored, suspended zones are temporarily disabled, under review zones are being reassessed.. Valid values are `active|inactive|suspended|under_review|decommissioned`',
    `zone_type` STRING COMMENT 'Classification of the security zone based on access restrictions and security requirements. Restricted areas require highest clearance, controlled areas require authorization, public areas allow general access with monitoring.. Valid values are `restricted_area|controlled_area|public_area|exclusion_zone|buffer_zone|critical_infrastructure_zone`',
    CONSTRAINT pk_zone PRIMARY KEY(`zone_id`)
) COMMENT 'Master registry of all designated security zones within the port facility as defined under ISPS Code requirements. Captures zone identifier, zone name, zone type (restricted area, controlled area, public area), MARSEC level applicability, physical boundaries (GIS polygon or textual description), access control requirements per MARSEC level, CCTV coverage flag, patrol frequency, and zone manager. Supports access control enforcement and security patrol planning.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`security`.`access_credential` (
    `access_credential_id` BIGINT COMMENT 'Unique identifier for the access credential record. Primary key for the access credential entity.',
    `contact_person_id` BIGINT COMMENT 'Foreign key linking to customer.contact_person. Business justification: Access credentials are issued to individual persons (contact_person) representing port community participants. This FK normalizes denormalized holder fields and enables personnel onboarding/offboardin',
    `customs_broker_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_broker. Business justification: Customs brokers require facility access credentials to operate in restricted port areas for cargo clearance and documentation. Essential for access control management, broker authorization tracking, a',
    `isps_facility_record_id` BIGINT COMMENT 'Foreign key linking to compliance.isps_facility_record. Business justification: Port facility access credentials are issued under the authority of a specific ISPS facility security framework. Port security managers must reference the ISPS facility record when issuing credentials ',
    `port_community_participant_id` BIGINT COMMENT 'Foreign key linking to customer.port_community_participant. Business justification: Access credentials for organizational representatives (not individual employees) link to port community participants. This FK enables tracking which participant organization a credential holder repres',
    `replaced_access_credential_id` BIGINT COMMENT 'Self-referencing FK on access_credential (replaced_access_credential_id)',
    `access_attempt_count` STRING COMMENT 'Total number of access attempts (successful and failed) recorded for this credential. Used for usage analytics and anomaly detection.',
    `access_time_restrictions` STRING COMMENT 'Description of temporal access restrictions for this credential, such as specific days of the week, time windows, or shift-based access. Free-text or structured time range specification.',
    `background_check_date` DATE COMMENT 'Date on which the most recent background check or security vetting was completed for the credential holder.',
    `background_check_status` STRING COMMENT 'Status of the security background check or vetting process for the credential holder. Required for certain credential types and access levels.. Valid values are `pending|cleared|failed|expired|not_required`',
    `biometric_enrolled` BOOLEAN COMMENT 'Indicates whether the credential holder has completed biometric enrollment (fingerprint, facial recognition, iris scan) for enhanced access control verification.',
    `biometric_modality` STRING COMMENT 'Type of biometric authentication method enrolled for this credential. None indicates no biometric enrollment.. Valid values are `fingerprint|facial_recognition|iris_scan|palm_vein|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credential record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `credential_number` STRING COMMENT 'Unique externally-visible credential number or badge number printed on the physical credential. This is the business identifier used for access control system lookups and audit trails.. Valid values are `^[A-Z0-9]{8,20}$`',
    `credential_status` STRING COMMENT 'Current lifecycle status of the credential. Controls whether the credential is valid for access control system authorization. [ENUM-REF-CANDIDATE: active|suspended|revoked|expired|pending_activation|lost|stolen — 7 candidates stripped; promote to reference product]',
    `credential_type` STRING COMMENT 'Classification of the credential based on its purpose and holder category. Determines access privileges and validation requirements.. Valid values are `port_id_card|vehicle_pass|visitor_pass|contractor_badge|biometric_token|temporary_pass`',
    `escort_required` BOOLEAN COMMENT 'Indicates whether the credential holder must be accompanied by an authorized escort when accessing restricted areas. Typically true for visitors and contractors with limited clearance.',
    `expiry_date` DATE COMMENT 'Date on which the credential expires and is no longer valid for access authorization. Nullable for credentials with indefinite validity subject to periodic review.',
    `failed_access_count` STRING COMMENT 'Total number of failed or denied access attempts for this credential. High counts may indicate lost credentials, unauthorized use, or system issues.',
    `holder_national_identifier` STRING COMMENT 'Government-issued national identification number of the credential holder. Required for background checks and compliance with maritime security regulations.',
    `holder_phone` STRING COMMENT 'Primary contact phone number of the credential holder for emergency contact and verification purposes.',
    `holder_type` STRING COMMENT 'Category of the individual or entity to whom this credential is issued. Used for access policy enforcement and reporting segmentation.. Valid values are `employee|contractor|visitor|vendor|government_official|service_provider`',
    `issue_date` DATE COMMENT 'Date on which the credential was officially issued to the holder. Marks the start of the credential validity period.',
    `issuing_authority` STRING COMMENT 'Name of the port security department, office, or authorized personnel who issued the credential. Used for accountability and audit trail.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful use of this credential at any port access control point. Used for activity monitoring and dormant credential identification.',
    `marsec_level_access` STRING COMMENT 'Maximum MARSEC security level at which this credential remains valid. MARSEC 1 is normal, MARSEC 2 is heightened, MARSEC 3 is exceptional threat. Credentials may be restricted at higher threat levels.. Valid values are `marsec_1|marsec_2|marsec_3`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this credential record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional remarks, special instructions, or contextual information about the credential or holder. Used by security personnel for operational notes.',
    `photo_reference` STRING COMMENT 'File path, URL, or document management system reference to the credential holder photograph. Used for visual identity verification at access points.',
    `renewal_notification_sent` BOOLEAN COMMENT 'Indicates whether an automated renewal reminder notification has been sent to the credential holder prior to expiry.',
    `revocation_date` DATE COMMENT 'Date on which the credential was revoked or permanently invalidated. Nullable if the credential has never been revoked.',
    `revocation_reason` STRING COMMENT 'Explanation or justification for why the credential was revoked. Examples include employment termination, security breach, policy violation, or credential compromise.',
    `revoked_by` STRING COMMENT 'Name or identifier of the security officer or authorized personnel who revoked the credential. Used for accountability and audit purposes.',
    `rfid_tag_number` STRING COMMENT 'Unique RFID chip identifier embedded in the credential card for contactless access control system integration. Hexadecimal format.. Valid values are `^[A-F0-9]{16,24}$`',
    `sponsor_contact` STRING COMMENT 'Contact phone number or email of the sponsor for verification and emergency contact purposes.',
    `sponsor_name` STRING COMMENT 'Name of the internal port employee or department who sponsors or vouches for the credential holder. Applicable for visitor and contractor credentials.',
    `training_completion_date` DATE COMMENT 'Date on which the credential holder completed mandatory port security awareness training or ISPS Code familiarization. Required for certain credential types.',
    `vehicle_registration_number` STRING COMMENT 'License plate or registration number of the vehicle associated with this credential. Applicable for vehicle pass credential types.',
    CONSTRAINT pk_access_credential PRIMARY KEY(`access_credential_id`)
) COMMENT 'Master record for all port access credentials issued to personnel, vehicles, and contractors. Captures credential number, credential type (port ID card, vehicle pass, visitor pass, contractor badge, biometric token), holder identity reference, issuing authority, issue date, expiry date, MARSEC level access permissions, zone access entitlements, biometric enrolment status, and revocation details. SSOT for all physical access authorisation within the port precinct.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`security`.`access_event` (
    `access_event_id` BIGINT COMMENT 'Unique identifier for the physical access event record. Primary key for the access event log.',
    `access_credential_id` BIGINT COMMENT 'Identifier of the access credential presented during the event (badge, card, biometric token).',
    `access_point_id` BIGINT COMMENT 'Identifier of the physical access control point where the event occurred (gate, turnstile, door, vehicle barrier).',
    `correlated_access_event_id` BIGINT COMMENT 'Self-referencing FK on access_event (correlated_access_event_id)',
    `security_incident_id` BIGINT COMMENT 'Identifier of the security incident record created as a result of this access event, if the event triggered an incident investigation. Null if no incident was created.',
    `zone_id` BIGINT COMMENT 'Identifier of the restricted security zone that was accessed or attempted to be accessed.',
    `access_control_system_code` STRING COMMENT 'Identifier of the physical access control system (hardware/software platform) that recorded this event.',
    `access_decision` STRING COMMENT 'The access control system decision outcome for this event indicating whether access was granted, denied, or triggered an alarm.. Valid values are `granted|denied|alarm|forced|tailgate|override`',
    `access_duration_minutes` STRING COMMENT 'Duration in minutes that the person remained in the zone, calculated from entry to exit events. Null if exit event not yet recorded or for single-point events.',
    `access_point_type` STRING COMMENT 'Classification of the physical access control point type (vehicle gate, pedestrian gate, turnstile, door, barrier, bollard).. Valid values are `vehicle_gate|pedestrian_gate|turnstile|door|barrier|bollard`',
    `access_purpose` STRING COMMENT 'Stated business purpose or reason for the access (e.g., cargo operations, maintenance, delivery, inspection, meeting).',
    `alarm_triggered_flag` BOOLEAN COMMENT 'Indicates whether this access event triggered a security alarm condition. True if alarm was triggered, False otherwise.',
    `alarm_type` STRING COMMENT 'Classification of the security alarm that was triggered, if applicable. Null if no alarm was triggered.. Valid values are `forced_entry|tailgating|invalid_credential|unauthorized_zone|duress|system_tamper`',
    `anti_passback_violation_flag` BOOLEAN COMMENT 'Indicates whether this event violated anti-passback rules (attempting to enter without a prior exit, or vice versa). True if violation detected, False otherwise.',
    `audit_trail_hash` STRING COMMENT 'Cryptographic hash of the event record to ensure data integrity and prevent tampering for compliance and forensic purposes.',
    `biometric_match_score` DECIMAL(18,2) COMMENT 'Confidence score (0.00 to 100.00) of the biometric authentication match, if biometric credential was used. Null for non-biometric credentials.',
    `cctv_clip_reference` STRING COMMENT 'Reference identifier or file path to the CCTV video clip capturing this access event for forensic review and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this access event record was first created in the database. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `credential_number` STRING COMMENT 'The unique number or identifier encoded on the physical credential presented during the access event.',
    `credential_type` STRING COMMENT 'Type of credential technology used for the access attempt (RFID card, biometric scan, PIN code, QR code, vehicle RFID tag, visitor pass).. Valid values are `rfid_card|biometric|pin|qr_code|vehicle_tag|visitor_pass`',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason why access was denied, if applicable. Null for granted access events. [ENUM-REF-CANDIDATE: invalid_credential|expired_credential|unauthorized_zone|time_restriction|revoked_access|blacklisted|system_error|unknown — 8 candidates stripped; promote to reference product]',
    `device_serial_number` STRING COMMENT 'Serial number of the physical access control device (card reader, biometric scanner, barrier controller) that captured the event.',
    `direction` STRING COMMENT 'Direction of movement through the access point: inbound (entering the zone) or outbound (exiting the zone).. Valid values are `inbound|outbound`',
    `escort_required_flag` BOOLEAN COMMENT 'Indicates whether the person was required to be escorted while in the accessed zone per security policy. True if escort required, False otherwise.',
    `event_source_ip_address` STRING COMMENT 'IP address of the access control device or system that generated this event record.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the access event occurred at the access control point. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `event_type` STRING COMMENT 'Classification of the access event indicating whether it was an entry, exit, attempted access, or alarm condition.. Valid values are `entry|exit|entry_attempt|exit_attempt|alarm|override`',
    `marsec_level` STRING COMMENT 'The MARSEC security level in effect at the port facility at the time of the access event (1=normal, 2=heightened, 3=exceptional). MARSEC levels are defined by ISPS Code to indicate threat conditions.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by security personnel regarding this access event, if applicable.',
    `organization_name` STRING COMMENT 'Name of the company or organization that the person represents (e.g., port operator, shipping line, customs, contractor).',
    `override_authorized_by` STRING COMMENT 'Name or identifier of the security supervisor who authorized a manual override of the access control decision. Null for standard automated decisions.',
    `override_reason` STRING COMMENT 'Free-text explanation for why a manual override was authorized, if applicable. Null for standard automated decisions.',
    `person_name` STRING COMMENT 'Full name of the individual associated with the credential at the time of the access event.',
    `temperature_reading_celsius` DECIMAL(18,2) COMMENT 'Body temperature reading in Celsius captured at the access point for health screening purposes. Null if temperature screening not performed.',
    `time_zone_restriction_violated_flag` BOOLEAN COMMENT 'Indicates whether the access attempt violated time-based access restrictions for the credential or zone. True if violation, False otherwise.',
    `vehicle_registration` STRING COMMENT 'License plate or registration number of the vehicle involved in the access event, if applicable. Null for pedestrian access.',
    `visitor_flag` BOOLEAN COMMENT 'Indicates whether the person was a visitor (temporary access) rather than a regular employee or contractor. True if visitor, False if regular personnel.',
    `zone_classification` STRING COMMENT 'Security classification level of the zone: public (open access), restricted (controlled access), high security (limited personnel), or critical infrastructure (essential operations).. Valid values are `public|restricted|high_security|critical_infrastructure`',
    CONSTRAINT pk_access_event PRIMARY KEY(`access_event_id`)
) COMMENT 'Transactional record of every physical access attempt and entry/exit event at port access control points including gates, turnstiles, restricted area doors, and vehicle barriers. Captures event timestamp, access point identifier, credential presented, holder identity, zone accessed, access decision (granted/denied/alarm), denial reason code, MARSEC level at time of event, and CCTV clip reference. Provides the complete audit trail for port access control compliance and forensic investigation.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`security`.`access_point` (
    `access_point_id` BIGINT COMMENT 'Unique identifier for the physical access control point within the port facility security infrastructure.',
    `equipment_type_id` BIGINT COMMENT 'Foreign key linking to masterdata.equipment_type. Business justification: Port access control equipment (barriers, turnstiles, ANPR systems) must be linked to equipment_type for maintenance scheduling, certification interval tracking, and compliance audits. Port operations ',
    `parent_access_point_id` BIGINT COMMENT 'Self-referencing FK on access_point (parent_access_point_id)',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Access points (gates, turnstiles, vehicle barriers) are physical entry/exit locations within port infrastructure. Each access point belongs to a specific port location for access control system config',
    `zone_id` BIGINT COMMENT 'Reference to the security zone classification that this access point controls entry to, supporting ISPS Code restricted area management.',
    `access_level_required` STRING COMMENT 'Minimum security clearance or authorization level required to pass through this access control point.. Valid values are `public|restricted|confidential|high_security`',
    `access_point_code` STRING COMMENT 'Business identifier code assigned to the access control point for operational reference and security system integration.. Valid values are `^AP-[A-Z0-9]{6,12}$`',
    `access_point_name` STRING COMMENT 'Descriptive name of the access control point for human-readable identification (e.g., Main Gate North, Terminal 3 Pedestrian Entry).',
    `access_point_type` STRING COMMENT 'Classification of the physical access control point based on its primary function and entry mode.. Valid values are `pedestrian_gate|vehicle_gate|turnstile|restricted_area_door|waterside_access|rail_access`',
    `alarm_integration_flag` BOOLEAN COMMENT 'Indicates whether the access point is integrated with the port facility alarm and intrusion detection system.',
    `anti_tailgating_enabled_flag` BOOLEAN COMMENT 'Indicates whether anti-tailgating or anti-passback technology is enabled to prevent unauthorized persons from following authorized users through the access point.',
    `automation_level` STRING COMMENT 'Degree of automation in the access control process, ranging from fully automated self-service to manual guard-operated.. Valid values are `fully_automated|semi_automated|manual`',
    `barrier_type` STRING COMMENT 'Type of physical barrier mechanism installed at the access point to control passage. [ENUM-REF-CANDIDATE: swing_gate|sliding_gate|boom_barrier|bollard|turnstile|door|none — 7 candidates stripped; promote to reference product]',
    `cctv_camera_ids` STRING COMMENT 'Comma-separated list of CCTV camera identifiers that provide surveillance coverage of this access point.',
    `cctv_coverage_flag` BOOLEAN COMMENT 'Indicates whether the access point is covered by CCTV surveillance cameras for security monitoring and incident investigation.',
    `certification_expiry_date` DATE COMMENT 'Expiration date of the compliance certification, after which re-certification or audit is required.',
    `compliance_certification_number` STRING COMMENT 'Certification or approval number indicating that the access control point meets ISPS Code and national security standards.',
    `control_technology_type` STRING COMMENT 'Primary access control technology deployed at this point for identity verification and authorization (ANPR = Automatic Number Plate Recognition, RFID = Radio Frequency Identification). [ENUM-REF-CANDIDATE: card_reader|biometric_fingerprint|biometric_facial|anpr|manual_guard|rfid|pin_keypad|multi_factor — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this access point record was first created in the security management system.',
    `direction_control` STRING COMMENT 'Indicates whether the access point controls entry, exit, or both directions of movement through the control point.. Valid values are `entry_only|exit_only|bidirectional`',
    `emergency_exit_flag` BOOLEAN COMMENT 'Indicates whether this access point is designated as an emergency exit route for evacuation purposes.',
    `installation_date` DATE COMMENT 'Date when the access control point was originally installed and commissioned for operational use.',
    `integration_system_code` STRING COMMENT 'Identifier of the access control system or security management platform that this access point is integrated with for centralized monitoring.',
    `intercom_available_flag` BOOLEAN COMMENT 'Indicates whether an intercom or two-way communication system is available at this access point for visitor communication with security personnel.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance performed on the access control equipment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this access point record was most recently modified or updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the access point location in decimal degrees for mapping and spatial analysis.',
    `location_description` STRING COMMENT 'Detailed textual description of the access point physical location within the port facility including landmarks and directional references.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the access point location in decimal degrees for mapping and spatial analysis.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance inspection or service of the access control equipment.',
    `operating_hours` STRING COMMENT 'Standard operating hours for this access point (e.g., 24/7, 0600-1800, business hours only).',
    `operational_status` STRING COMMENT 'Current operational state of the access control point indicating availability for security operations.. Valid values are `active|inactive|maintenance|suspended|decommissioned`',
    `remarks` STRING COMMENT 'Additional notes, special instructions, or operational considerations related to the access control point.',
    `throughput_capacity_per_hour` STRING COMMENT 'Maximum number of persons or vehicles that can be processed through this access point per hour under normal operating conditions.',
    `vendor_name` STRING COMMENT 'Name of the vendor or manufacturer that supplied the access control technology and equipment.',
    `visitor_management_integration_flag` BOOLEAN COMMENT 'Indicates whether the access point is integrated with the port visitor management system for pre-registration and visitor tracking.',
    CONSTRAINT pk_access_point PRIMARY KEY(`access_point_id`)
) COMMENT 'Master registry of all physical access control points deployed across the port facility including pedestrian gates, vehicle barriers, turnstiles, restricted area entry doors, and waterside access points. Captures access point identifier, location description, zone association, control technology type (card reader, biometric, ANPR, manual), operational status, CCTV camera coverage, and responsible security post. Supports access event logging and security infrastructure management.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`security`.`security_incident` (
    `security_incident_id` BIGINT COMMENT 'Unique identifier for the security incident record. Primary key for the security incident entity.',
    `access_point_id` BIGINT COMMENT 'Foreign key linking to security.access_point. Business justification: Security incidents frequently occur at or involve specific physical access control points (gate breaches, tailgating, unauthorized entry attempts, alarm activations). The security_incident table curre',
    `marsec_level_change_id` BIGINT COMMENT 'Foreign key linking to security.marsec_level_change. Business justification: Security incidents occur under a specific MARSEC level declaration. Linking security_incident to the active marsec_level_change record at the time of the incident is critical for ISPS compliance repor',
    `escalated_security_incident_id` BIGINT COMMENT 'Self-referencing FK on security_incident (escalated_security_incident_id)',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Port security incidents trigger remediation internal orders to fund investigations, repairs, and additional security deployment. Finance teams require this link to track incident-driven expenditure ag',
    `isps_facility_record_id` BIGINT COMMENT 'Foreign key linking to compliance.isps_facility_record. Business justification: ISPS Code requires security incidents to be logged against the facilitys ISPS record for regulatory reporting to national maritime authorities. Port security officers and PSC inspectors review incide',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: ISPS Code and PSC reporting require linking security incidents to the vessel master record. Port security officers escalate incidents to flag states and record PSC deficiencies per vessel. Denormalize',
    `zone_id` BIGINT COMMENT 'Foreign key linking to security.security_zone. Business justification: Security incidents occur within specific security zones. The incident currently has location_zone as STRING attribute. This should be normalized to security_zone_id FK to security_zone.security_zone_i',
    `access_control_logs_reference` STRING COMMENT 'Reference identifier for access control system logs relevant to the incident (badge swipes, gate entries, biometric records).',
    `cargo_description` STRING COMMENT 'Description of cargo involved in the incident including container numbers, commodity type, and quantity if applicable.',
    `cargo_involved_flag` BOOLEAN COMMENT 'Boolean flag indicating whether cargo was involved in or affected by the security incident.',
    `cctv_footage_available_flag` BOOLEAN COMMENT 'Boolean flag indicating whether CCTV surveillance footage of the incident is available for review.',
    `cctv_footage_reference` STRING COMMENT 'Reference identifier or storage location for CCTV footage related to the incident.',
    `closed_datetime` TIMESTAMP COMMENT 'Date and time when the security incident was officially closed after resolution and completion of all follow-up actions.',
    `corrective_actions` STRING COMMENT 'Description of corrective actions implemented or planned to prevent recurrence of similar security incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this security incident record was first created in the port security management system.',
    `datetime` TIMESTAMP COMMENT 'Date and time when the security incident occurred or was first detected. This is the principal business event timestamp for the incident.',
    `detected_by` STRING COMMENT 'Method or source through which the security incident was initially detected. [ENUM-REF-CANDIDATE: cctv_surveillance|security_patrol|access_control_system|vessel_crew|port_staff|third_party|automated_sensor — 7 candidates stripped; promote to reference product]',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the security incident including property damage, theft losses, operational disruption costs, and response expenses in USD.',
    `immediate_response_actions` STRING COMMENT 'Detailed description of immediate response actions taken by security personnel, PFSO, or emergency responders to contain and address the incident.',
    `incident_number` STRING COMMENT 'Externally-known unique business identifier for the security incident, formatted as SI-YYYY-NNNNNN for tracking and reporting purposes.. Valid values are `^SI-[0-9]{4}-[0-9]{6}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the security incident in the response and investigation workflow.. Valid values are `reported|under_investigation|contained|resolved|closed`',
    `incident_type` STRING COMMENT 'Classification of the security incident. Additional types include bomb threat, piracy attempt, cyber incident, and other security events as defined by ISPS Code and port security protocols.. Valid values are `unauthorised_access|perimeter_breach|theft|sabotage|stowaways|suspicious_behaviour`',
    `investigation_status` STRING COMMENT 'Current status of the security investigation into the incident.. Valid values are `not_started|in_progress|completed|closed_unresolved`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this security incident record was last updated or modified.',
    `law_enforcement_case_number` STRING COMMENT 'Case or reference number assigned by law enforcement agency if the incident was reported to police or other authorities.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether local or national law enforcement agencies were notified of the incident.',
    `lessons_learned` STRING COMMENT 'Summary of lessons learned from the incident for knowledge sharing and continuous improvement of security protocols.',
    `location_berth` STRING COMMENT 'Specific berth identifier where the incident occurred, if applicable. Null if incident did not occur at a berth.',
    `location_coordinates` STRING COMMENT 'Geographic coordinates (latitude, longitude) of the incident location for precise mapping and spatial analysis.. Valid values are `^-?[0-9]{1,3}.[0-9]+,-?[0-9]{1,3}.[0-9]+$`',
    `national_authority_escalated_datetime` TIMESTAMP COMMENT 'Date and time when the incident was escalated to the national maritime security authority.',
    `national_authority_escalated_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the incident was escalated to the national maritime security authority or designated security agency.',
    `operational_impact_description` STRING COMMENT 'Description of the impact of the security incident on port operations including delays, berth closures, cargo holds, or service disruptions.',
    `persons_involved_count` STRING COMMENT 'Number of persons directly involved in or associated with the security incident (perpetrators, suspects, witnesses).',
    `persons_involved_description` STRING COMMENT 'Detailed description of persons involved in the incident including physical descriptions, identification details, and roles. Confidential for security purposes.',
    `pfso_notified_datetime` TIMESTAMP COMMENT 'Date and time when the PFSO was notified of the security incident.',
    `pfso_notified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the Port Facility Security Officer was notified of the incident as required by ISPS Code.',
    `port_authority_notified_datetime` TIMESTAMP COMMENT 'Date and time when the port authority was notified of the security incident.',
    `port_authority_notified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the port authority was notified of the incident.',
    `report_document_reference` STRING COMMENT 'Reference identifier or storage location for the formal written incident report document.',
    `reported_datetime` TIMESTAMP COMMENT 'Date and time when the security incident was officially reported to the Port Facility Security Officer (PFSO) or security operations center.',
    `reporting_officer_name` STRING COMMENT 'Full name of the security officer or staff member who filed the initial incident report.',
    `root_cause_analysis` STRING COMMENT 'Detailed root cause analysis findings identifying underlying factors that contributed to the security incident.',
    `severity_level` STRING COMMENT 'Assessed severity level of the security incident based on potential impact to port operations, safety, and security.. Valid values are `low|medium|high|critical`',
    `subtype` STRING COMMENT 'Detailed sub-classification of the incident type providing additional granularity for analysis and reporting (e.g., vehicle intrusion, gate breach, cargo tampering).',
    `threat_level` STRING COMMENT 'Assessed threat level associated with the incident based on intelligence and risk analysis.. Valid values are `minimal|moderate|substantial|severe`',
    CONSTRAINT pk_security_incident PRIMARY KEY(`security_incident_id`)
) COMMENT 'Core transactional record of all security incidents occurring within the port facility or port waters. Captures incident number, incident type (unauthorised access, perimeter breach, theft, sabotage, stowaways, suspicious behaviour, bomb threat, piracy attempt, cyber incident), date and time, location (zone, berth, gate), MARSEC level at time, persons involved, vessels involved, immediate response actions taken, reporting officer, notification to port authority and PFSO, and escalation to national maritime security authority. SSOT for port security incident management.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` (
    `marsec_level_change_id` BIGINT COMMENT 'Unique identifier for the MARSEC level change record. Primary key.',
    `facility_security_plan_id` BIGINT COMMENT 'Foreign key linking to security.facility_security_plan. Business justification: MARSEC level changes are executed under a specific version of the Port Facility Security Plan. The change record currently has security_plan_version as STRING. This should be normalized to facility_se',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Under ISPS Code, MARSEC level declarations are facility-specific. Port security operations require linking each MARSEC change to a specific port location for facility-level compliance tracking, regula',
    `primary_superseded_by_change_marsec_level_change_id` BIGINT COMMENT 'Reference to the subsequent MARSEC level change that superseded this one. Null if this is the current active change.',
    `access_control_measures` STRING COMMENT 'Description of the access control measures to be implemented at this MARSEC level (e.g., enhanced ID checks, escort requirements, restricted access zones).',
    `cargo_screening_requirement` STRING COMMENT 'The level of cargo screening required at this MARSEC level.. Valid values are `standard|enhanced|100_percent_screening|random_sampling|risk_based`',
    `change_number` STRING COMMENT 'Business identifier for the MARSEC level change event, formatted as MARSEC-YYYY-NNNNNN.. Valid values are `^MARSEC-[0-9]{4}-[0-9]{6}$`',
    `change_reason_code` STRING COMMENT 'Coded reason category for the MARSEC level change. [ENUM-REF-CANDIDATE: threat_intelligence|security_incident|regional_conflict|terrorist_activity|piracy_alert|cyber_threat|drill_exercise — 7 candidates stripped; promote to reference product]',
    `change_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for the MARSEC level change, including threat assessment details and intelligence briefing summary.',
    `communication_protocol` STRING COMMENT 'The communication protocol and procedures to be followed by vessels and port users during this MARSEC level.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this MARSEC level change record was first created in the system.',
    `cybersecurity_posture` STRING COMMENT 'The cybersecurity posture level for port IT/OT systems corresponding to this MARSEC level.. Valid values are `normal|elevated|high_alert|lockdown`',
    `declaration_timestamp` TIMESTAMP COMMENT 'The date and time when the MARSEC level change was officially declared by the issuing authority.',
    `drill_exercise_flag` BOOLEAN COMMENT 'Indicates whether this MARSEC level change is part of a planned security drill or exercise rather than a real threat response.',
    `duration_type` STRING COMMENT 'Indicates whether the MARSEC level change is indefinite, temporary, or time-limited.. Valid values are `indefinite|temporary|time_limited|until_further_notice`',
    `effective_timestamp` TIMESTAMP COMMENT 'The date and time when the new MARSEC level becomes effective and operational security posture changes must be implemented.',
    `geographic_scope` STRING COMMENT 'The geographic area or zone within the port facility to which this MARSEC level change applies.. Valid values are `entire_port|specific_terminal|specific_berth|anchorage_area|port_waters|restricted_zone`',
    `issuing_authority_name` STRING COMMENT 'The name of the national maritime security authority or port authority that issued the MARSEC level change declaration.',
    `issuing_authority_type` STRING COMMENT 'The type or classification of the authority that issued the MARSEC level change.. Valid values are `national_maritime_security_authority|port_authority|coast_guard|navy|ministry_of_transport|other`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this MARSEC level change record was last modified.',
    `marsec_level_change_status` STRING COMMENT 'Current lifecycle status of the MARSEC level change record.. Valid values are `declared|active|superseded|cancelled|expired`',
    `new_marsec_level` STRING COMMENT 'The MARSEC level declared by this change. 1=Normal (minimum security measures), 2=Heightened (additional protective measures), 3=Exceptional (further specific protective measures).',
    `notification_method` STRING COMMENT 'The primary method or channel used to notify stakeholders of the MARSEC level change. [ENUM-REF-CANDIDATE: port_community_system|email|vts_broadcast|edi_message|secure_portal|phone|fax — 7 candidates stripped; promote to reference product]',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'The date and time when notifications were sent to all required recipients (shipping lines, vessel masters, agents, Port Facility Security Officer).',
    `operational_impact_description` STRING COMMENT 'Description of the expected operational impacts on port operations, vessel turnaround times, and cargo handling due to this MARSEC level change.',
    `patrol_frequency_change` STRING COMMENT 'Description of changes to security patrol frequency and coverage required by this MARSEC level change.',
    `pfso_acknowledged_flag` BOOLEAN COMMENT 'Indicates whether the Port Facility Security Officer has acknowledged receipt and understanding of the MARSEC level change.',
    `pfso_acknowledged_timestamp` TIMESTAMP COMMENT 'The date and time when the PFSO acknowledged the MARSEC level change.',
    `pfso_name` STRING COMMENT 'The full name of the Port Facility Security Officer who acknowledged the MARSEC level change.',
    `planned_end_timestamp` TIMESTAMP COMMENT 'The planned date and time when the MARSEC level is expected to revert or change again. Null for indefinite changes.',
    `previous_marsec_level` STRING COMMENT 'The MARSEC level in effect before this change. 1=Normal (minimum security measures), 2=Heightened (additional protective measures), 3=Exceptional (further specific protective measures).',
    `surveillance_enhancement` STRING COMMENT 'Description of enhancements to CCTV surveillance and monitoring required by this MARSEC level change.',
    `threat_assessment_reference` STRING COMMENT 'Reference number or identifier of the threat assessment report that triggered the MARSEC level change.',
    `vessel_screening_requirement` STRING COMMENT 'The level of vessel security screening required at this MARSEC level.. Valid values are `standard|enhanced|pre_arrival_security_check|underwater_hull_inspection|mandatory_security_declaration`',
    CONSTRAINT pk_marsec_level_change PRIMARY KEY(`marsec_level_change_id`)
) COMMENT 'Transactional record of Maritime Security (MARSEC) level declarations and changes at the port facility. Captures change identifier, previous MARSEC level, new MARSEC level (1=normal, 2=heightened, 3=exceptional), effective date and time, issuing authority (national maritime security authority or port authority), reason for change, notification recipients (shipping lines, vessel masters, agents, PFSO), and acknowledgement records. Drives access control, patrol frequency, and operational security posture changes.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` (
    `zone_access_authorization_id` BIGINT COMMENT 'Unique identifier for this zone access authorization record. Primary key.',
    `access_credential_id` BIGINT COMMENT 'Foreign key linking to the access credential that is authorized for zone access',
    `zone_id` BIGINT COMMENT 'Foreign key linking to the security zone for which access is authorized',
    `access_count` STRING COMMENT 'Total number of times this credential has been used to access this zone. Used for usage analytics and audit.',
    `access_level` STRING COMMENT 'Level of access granted to the credential holder within this specific zone. Determines what activities are permitted.',
    `authorization_date` DATE COMMENT 'Date on which this zone access authorization was officially granted and recorded in the system.',
    `authorization_granted_by` STRING COMMENT 'Name or identifier of the security officer or zone manager who granted this specific zone access authorization.',
    `authorization_status` STRING COMMENT 'Current lifecycle status of this zone access authorization. Controls whether access control systems enforce this authorization.',
    `business_justification` STRING COMMENT 'Business reason or operational justification for granting this zone access authorization. Examples: assigned_to_zone, project_requirement, maintenance_contract, emergency_response_team.',
    `effective_from_date` DATE COMMENT 'Date from which this zone access authorization becomes active and enforceable.',
    `effective_to_date` DATE COMMENT 'Date on which this zone access authorization expires or is scheduled for review. Nullable for indefinite authorizations subject to credential expiry.',
    `escort_required_flag` BOOLEAN COMMENT 'Indicates whether the credential holder must be accompanied by an authorized escort when accessing this specific zone. Zone-specific override of credential-level escort requirement.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful access to this zone using this credential. Used for audit and anomaly detection.',
    `marsec_level_override` STRING COMMENT 'Zone-specific MARSEC level override for this credential. If set, this authorization is only valid at the specified MARSEC level, overriding the credentials general marsec_level_access.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next mandatory review of this zone access authorization. Used for compliance with periodic access recertification requirements.',
    `review_date` DATE COMMENT 'Date when this zone access authorization was last reviewed for continued necessity and appropriateness. Used for periodic access recertification.',
    `revocation_date` DATE COMMENT 'Date on which this zone access authorization was permanently revoked. Nullable if never revoked.',
    `revocation_reason` STRING COMMENT 'Explanation for why this zone access authorization was revoked. Examples: security_breach, role_change, project_completion, credential_revoked.',
    `suspension_date` DATE COMMENT 'Date on which this zone access authorization was temporarily suspended. Nullable if never suspended.',
    `suspension_reason` STRING COMMENT 'Explanation for why this zone access authorization was suspended. Examples: security_incident, zone_maintenance, credential_under_review.',
    `time_restrictions` STRING COMMENT 'Temporal restrictions on when this credential can access this zone. Examples: 24/7, business_hours_only, 0600-1800, weekdays_only.',
    `zone_access_entitlements` STRING COMMENT 'Comma-separated list of port security zone codes or identifiers that this credential authorizes access to. Examples include restricted areas, cargo handling zones, vessel berths, and administrative buildings. [Moved from access_credential: This comma-separated list of zone codes in access_credential is a denormalized representation of the many-to-many relationship. Each zone entitlement should be a separate record in zone_access_authorization with its own access_level, time_restrictions, and lifecycle attributes. The current attribute conflates multiple authorizations into a single string, preventing proper tracking of zone-specific access rules and authorization history.]',
    CONSTRAINT pk_zone_access_authorization PRIMARY KEY(`zone_access_authorization_id`)
) COMMENT 'This association product represents the authorization relationship between access credentials and security zones within the port facility. It captures the specific access permissions granted to each credential for each zone, including access level, temporal restrictions, escort requirements, and authorization lifecycle. Each record links one access credential to one security zone with attributes that exist only in the context of this specific authorization. This is a core operational entity for ISPS Code compliance and access control enforcement.. Existence Justification: Port security operations explicitly manage which credentials are authorized to access which zones, with each authorization having zone-specific rules (access level, time restrictions, escort requirements) and its own lifecycle (granted, active, suspended, revoked). A single credential can be authorized for multiple zones (e.g., a port employee with access to terminal area, cargo storage, and administration building), and each zone has multiple authorized credentials (all personnel assigned to that zone). Security officers actively create, review, suspend, and revoke these authorizations as part of ISPS Code compliance and operational access control.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ADD CONSTRAINT `fk_security_facility_security_plan_superseded_facility_security_plan_id` FOREIGN KEY (`superseded_facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ADD CONSTRAINT `fk_security_zone_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ADD CONSTRAINT `fk_security_zone_parent_zone_id` FOREIGN KEY (`parent_zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ADD CONSTRAINT `fk_security_access_credential_replaced_access_credential_id` FOREIGN KEY (`replaced_access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_correlated_access_event_id` FOREIGN KEY (`correlated_access_event_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_event`(`access_event_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_security_incident_id` FOREIGN KEY (`security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ADD CONSTRAINT `fk_security_access_event_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ADD CONSTRAINT `fk_security_access_point_parent_access_point_id` FOREIGN KEY (`parent_access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ADD CONSTRAINT `fk_security_access_point_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_point`(`access_point_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_marsec_level_change_id` FOREIGN KEY (`marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_escalated_security_incident_id` FOREIGN KEY (`escalated_security_incident_id`) REFERENCES `shipping_ports_ecm`.`security`.`security_incident`(`security_incident_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ADD CONSTRAINT `fk_security_security_incident_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ADD CONSTRAINT `fk_security_marsec_level_change_facility_security_plan_id` FOREIGN KEY (`facility_security_plan_id`) REFERENCES `shipping_ports_ecm`.`security`.`facility_security_plan`(`facility_security_plan_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ADD CONSTRAINT `fk_security_marsec_level_change_primary_superseded_by_change_marsec_level_change_id` FOREIGN KEY (`primary_superseded_by_change_marsec_level_change_id`) REFERENCES `shipping_ports_ecm`.`security`.`marsec_level_change`(`marsec_level_change_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ADD CONSTRAINT `fk_security_zone_access_authorization_access_credential_id` FOREIGN KEY (`access_credential_id`) REFERENCES `shipping_ports_ecm`.`security`.`access_credential`(`access_credential_id`);
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ADD CONSTRAINT `fk_security_zone_access_authorization_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `shipping_ports_ecm`.`security`.`zone`(`zone_id`);

-- ========= TAGS =========
ALTER SCHEMA `shipping_ports_ecm`.`security` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `shipping_ports_ecm`.`security` SET TAGS ('dbx_domain' = 'security');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` SET TAGS ('dbx_subdomain' = 'facility_compliance');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `facility_security_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Security Plan ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `isps_facility_record_id` SET TAGS ('dbx_business_glossary_term' = 'Port Facility ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Port Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `superseded_facility_security_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `vessel_type_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Type Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `access_control_system_type` SET TAGS ('dbx_business_glossary_term' = 'Access Control System Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `approval_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Certificate Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `cctv_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'CCTV Coverage Percentage');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `compliance_certificate_expiry` SET TAGS ('dbx_business_glossary_term' = 'ISPS Compliance Certificate Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `cybersecurity_measures_included` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Measures Included Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `document_classification` SET TAGS ('dbx_business_glossary_term' = 'Document Classification Level');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `document_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `drill_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Security Drill Frequency (Months)');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `last_amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Description');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `last_audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Outcome');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `last_audit_outcome` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|not_audited');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `last_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Security Drill Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `marsec_level_1_measures` SET TAGS ('dbx_business_glossary_term' = 'MARSEC Level 1 Security Measures');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `marsec_level_1_measures` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `marsec_level_2_measures` SET TAGS ('dbx_business_glossary_term' = 'MARSEC Level 2 Security Measures');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `marsec_level_2_measures` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `marsec_level_3_measures` SET TAGS ('dbx_business_glossary_term' = 'MARSEC Level 3 Security Measures');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `marsec_level_3_measures` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `next_drill_date` SET TAGS ('dbx_business_glossary_term' = 'Next Security Drill Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `patrol_frequency_hours` SET TAGS ('dbx_business_glossary_term' = 'Security Patrol Frequency (Hours)');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `pfso_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Contact Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `pfso_contact_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `pfso_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `pfso_email_address` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Email Address');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `pfso_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `pfso_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `pfso_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `pfso_name` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Name');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `pfso_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `plan_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Reference Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `plan_reference_number` SET TAGS ('dbx_value_regex' = '^PFSP-[A-Z0-9]{6,12}$');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `plan_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Scope Description');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Plan Remarks');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Period (Months)');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `security_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Assessment (PFSA) Reference');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `security_assessment_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `threat_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Threat Assessment Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`facility_security_plan` ALTER COLUMN `training_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Security Training Program Reference');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` SET TAGS ('dbx_subdomain' = 'access_control');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Security Zone ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `facility_security_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Security Plan Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `isps_facility_record_id` SET TAGS ('dbx_business_glossary_term' = 'Isps Facility Record Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `parent_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Port Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `access_control_requirement_marsec1` SET TAGS ('dbx_business_glossary_term' = 'Access Control Requirement at Maritime Security (MARSEC) Level 1');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `access_control_requirement_marsec2` SET TAGS ('dbx_business_glossary_term' = 'Access Control Requirement at Maritime Security (MARSEC) Level 2');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `access_control_requirement_marsec3` SET TAGS ('dbx_business_glossary_term' = 'Access Control Requirement at Maritime Security (MARSEC) Level 3');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `access_point_count` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Access Point Count');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `area_square_meters` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Area in Square Meters');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Boundary Description');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `boundary_gis_polygon` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Boundary Geographic Information System (GIS) Polygon');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `cctv_camera_count` SET TAGS ('dbx_business_glossary_term' = 'Closed-Circuit Television (CCTV) Camera Count');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `cctv_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed-Circuit Television (CCTV) Coverage Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `critical_infrastructure_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `cybersecurity_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Zone Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Effective From Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Effective To Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `emergency_assembly_point` SET TAGS ('dbx_business_glossary_term' = 'Emergency Assembly Point Location');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `incident_count_ytd` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Count Year-to-Date (YTD)');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `incident_count_ytd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Security Incident Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `last_incident_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `last_risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Security Risk Assessment Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `lighting_adequacy_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Lighting Adequacy Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `marsec_level_applicability` SET TAGS ('dbx_business_glossary_term' = 'Maritime Security (MARSEC) Level Applicability');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `marsec_level_applicability` SET TAGS ('dbx_value_regex' = 'marsec_1|marsec_2|marsec_3|all_levels');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `next_risk_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Security Risk Assessment Due Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Operational Hours');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `patrol_frequency_hours` SET TAGS ('dbx_business_glossary_term' = 'Security Patrol Frequency in Hours');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `patrol_type` SET TAGS ('dbx_business_glossary_term' = 'Security Patrol Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `patrol_type` SET TAGS ('dbx_value_regex' = 'foot_patrol|vehicle_patrol|marine_patrol|combined_patrol|remote_monitoring');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `perimeter_fencing_type` SET TAGS ('dbx_business_glossary_term' = 'Perimeter Fencing Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `perimeter_fencing_type` SET TAGS ('dbx_value_regex' = 'chain_link|concrete_wall|steel_barrier|water_barrier|none|mixed');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Remarks');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `restricted_cargo_types` SET TAGS ('dbx_business_glossary_term' = 'Restricted Cargo Types');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `threat_level` SET TAGS ('dbx_business_glossary_term' = 'Security Threat Level');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `threat_level` SET TAGS ('dbx_value_regex' = 'low|moderate|elevated|high|critical');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `threat_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Code');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Status');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|decommissioned');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'restricted_area|controlled_area|public_area|exclusion_zone|buffer_zone|critical_infrastructure_zone');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` SET TAGS ('dbx_subdomain' = 'access_control');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `access_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Access Credential Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `contact_person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `isps_facility_record_id` SET TAGS ('dbx_business_glossary_term' = 'Isps Facility Record Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Port Community Participant Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `replaced_access_credential_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `access_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Access Attempt Count');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `access_time_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Time Restrictions');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|failed|expired|not_required');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `biometric_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Biometric Enrolled Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `biometric_enrolled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `biometric_enrolled` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `biometric_modality` SET TAGS ('dbx_business_glossary_term' = 'Biometric Modality');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `biometric_modality` SET TAGS ('dbx_value_regex' = 'fingerprint|facial_recognition|iris_scan|palm_vein|none');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `biometric_modality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `biometric_modality` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `credential_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'port_id_card|vehicle_pass|visitor_pass|contractor_badge|biometric_token|temporary_pass');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `escort_required` SET TAGS ('dbx_business_glossary_term' = 'Escort Required Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `failed_access_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Access Count');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `holder_national_identifier` SET TAGS ('dbx_business_glossary_term' = 'Holder National Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `holder_national_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `holder_national_identifier` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `holder_phone` SET TAGS ('dbx_business_glossary_term' = 'Holder Phone Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `holder_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `holder_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `holder_type` SET TAGS ('dbx_business_glossary_term' = 'Holder Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `holder_type` SET TAGS ('dbx_value_regex' = 'employee|contractor|visitor|vendor|government_official|service_provider');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `marsec_level_access` SET TAGS ('dbx_business_glossary_term' = 'Maritime Security (MARSEC) Level Access');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `marsec_level_access` SET TAGS ('dbx_value_regex' = 'marsec_1|marsec_2|marsec_3');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `photo_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Reference');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `renewal_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Sent Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `revoked_by` SET TAGS ('dbx_business_glossary_term' = 'Revoked By');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `rfid_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `rfid_tag_number` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{16,24}$');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `sponsor_contact` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `sponsor_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `sponsor_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_credential` ALTER COLUMN `vehicle_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` SET TAGS ('dbx_subdomain' = 'access_control');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_event_id` SET TAGS ('dbx_business_glossary_term' = 'Access Event ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Credential ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_point_id` SET TAGS ('dbx_business_glossary_term' = 'Access Point ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `correlated_access_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Security Zone ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_control_system_code` SET TAGS ('dbx_business_glossary_term' = 'Access Control System ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_decision` SET TAGS ('dbx_business_glossary_term' = 'Access Decision');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_decision` SET TAGS ('dbx_value_regex' = 'granted|denied|alarm|forced|tailgate|override');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Access Duration Minutes');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_point_type` SET TAGS ('dbx_business_glossary_term' = 'Access Point Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_point_type` SET TAGS ('dbx_value_regex' = 'vehicle_gate|pedestrian_gate|turnstile|door|barrier|bollard');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `access_purpose` SET TAGS ('dbx_business_glossary_term' = 'Access Purpose');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `alarm_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Triggered Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'forced_entry|tailgating|invalid_credential|unauthorized_zone|duress|system_tamper');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `anti_passback_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Passback Violation Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `audit_trail_hash` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Hash');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `biometric_match_score` SET TAGS ('dbx_business_glossary_term' = 'Biometric Match Score');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `biometric_match_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `biometric_match_score` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `cctv_clip_reference` SET TAGS ('dbx_business_glossary_term' = 'Closed-Circuit Television (CCTV) Clip Reference');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `credential_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `credential_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'rfid_card|biometric|pin|qr_code|vehicle_tag|visitor_pass');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Access Direction');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `escort_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escort Required Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `event_source_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Event Source Internet Protocol (IP) Address');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `event_source_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'entry|exit|entry_attempt|exit_attempt|alarm|override');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `marsec_level` SET TAGS ('dbx_business_glossary_term' = 'Maritime Security (MARSEC) Level');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Name');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `override_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Override Authorized By');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `person_name` SET TAGS ('dbx_business_glossary_term' = 'Person Name');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `temperature_reading_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading Celsius');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `time_zone_restriction_violated_flag` SET TAGS ('dbx_business_glossary_term' = 'Time Zone Restriction Violated Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `vehicle_registration` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `vehicle_registration` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `vehicle_registration` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `visitor_flag` SET TAGS ('dbx_business_glossary_term' = 'Visitor Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Zone Classification');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_event` ALTER COLUMN `zone_classification` SET TAGS ('dbx_value_regex' = 'public|restricted|high_security|critical_infrastructure');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` SET TAGS ('dbx_subdomain' = 'access_control');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `access_point_id` SET TAGS ('dbx_business_glossary_term' = 'Access Point Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `equipment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `parent_access_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Port Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `access_level_required` SET TAGS ('dbx_business_glossary_term' = 'Access Level Required');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `access_level_required` SET TAGS ('dbx_value_regex' = 'public|restricted|confidential|high_security');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `access_point_code` SET TAGS ('dbx_business_glossary_term' = 'Access Point Code');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `access_point_code` SET TAGS ('dbx_value_regex' = '^AP-[A-Z0-9]{6,12}$');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `access_point_name` SET TAGS ('dbx_business_glossary_term' = 'Access Point Name');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `access_point_type` SET TAGS ('dbx_business_glossary_term' = 'Access Point Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `access_point_type` SET TAGS ('dbx_value_regex' = 'pedestrian_gate|vehicle_gate|turnstile|restricted_area_door|waterside_access|rail_access');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `alarm_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Integration Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `anti_tailgating_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Tailgating Enabled Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'fully_automated|semi_automated|manual');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `barrier_type` SET TAGS ('dbx_business_glossary_term' = 'Barrier Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `cctv_camera_ids` SET TAGS ('dbx_business_glossary_term' = 'Closed-Circuit Television (CCTV) Camera Identifiers (IDs)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `cctv_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed-Circuit Television (CCTV) Coverage Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `compliance_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `control_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Control Technology Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `direction_control` SET TAGS ('dbx_business_glossary_term' = 'Direction Control');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `direction_control` SET TAGS ('dbx_value_regex' = 'entry_only|exit_only|bidirectional');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `emergency_exit_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Exit Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `integration_system_code` SET TAGS ('dbx_business_glossary_term' = 'Integration System Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `intercom_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercom Available Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|suspended|decommissioned');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `throughput_capacity_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity Per Hour');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `shipping_ports_ecm`.`security`.`access_point` ALTER COLUMN `visitor_management_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Visitor Management Integration Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `access_point_id` SET TAGS ('dbx_business_glossary_term' = 'Access Point Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `marsec_level_change_id` SET TAGS ('dbx_business_glossary_term' = 'Active Marsec Level Change Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `escalated_security_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `isps_facility_record_id` SET TAGS ('dbx_business_glossary_term' = 'Isps Facility Record Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `access_control_logs_reference` SET TAGS ('dbx_business_glossary_term' = 'Access Control Logs Reference');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `cargo_description` SET TAGS ('dbx_business_glossary_term' = 'Cargo Description');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `cargo_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Cargo Involved Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `cctv_footage_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed-Circuit Television (CCTV) Footage Available Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `cctv_footage_reference` SET TAGS ('dbx_business_glossary_term' = 'Closed-Circuit Television (CCTV) Footage Reference');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `closed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Closed Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `detected_by` SET TAGS ('dbx_business_glossary_term' = 'Detected By Method');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `immediate_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Immediate Response Actions');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^SI-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Status');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|contained|resolved|closed');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'unauthorised_access|perimeter_breach|theft|sabotage|stowaways|suspicious_behaviour');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|closed_unresolved');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `location_berth` SET TAGS ('dbx_business_glossary_term' = 'Location Berth');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `location_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Location Coordinates');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `location_coordinates` SET TAGS ('dbx_value_regex' = '^-?[0-9]{1,3}.[0-9]+,-?[0-9]{1,3}.[0-9]+$');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `national_authority_escalated_datetime` SET TAGS ('dbx_business_glossary_term' = 'National Maritime Security Authority Escalated Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `national_authority_escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'National Maritime Security Authority Escalated Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `operational_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Operational Impact Description');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `persons_involved_count` SET TAGS ('dbx_business_glossary_term' = 'Persons Involved Count');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `persons_involved_description` SET TAGS ('dbx_business_glossary_term' = 'Persons Involved Description');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `persons_involved_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `pfso_notified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Notified Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `pfso_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Notified Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `port_authority_notified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Port Authority Notified Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `port_authority_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Port Authority Notified Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Document Reference');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `reported_datetime` SET TAGS ('dbx_business_glossary_term' = 'Reported Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `reporting_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Officer Name');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Subtype');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `threat_level` SET TAGS ('dbx_business_glossary_term' = 'Threat Level');
ALTER TABLE `shipping_ports_ecm`.`security`.`security_incident` ALTER COLUMN `threat_level` SET TAGS ('dbx_value_regex' = 'minimal|moderate|substantial|severe');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `marsec_level_change_id` SET TAGS ('dbx_business_glossary_term' = 'Maritime Security (MARSEC) Level Change ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `facility_security_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Security Plan Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Port Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `primary_superseded_by_change_marsec_level_change_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Change ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `access_control_measures` SET TAGS ('dbx_business_glossary_term' = 'Access Control Measures');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `cargo_screening_requirement` SET TAGS ('dbx_business_glossary_term' = 'Cargo Screening Requirement');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `cargo_screening_requirement` SET TAGS ('dbx_value_regex' = 'standard|enhanced|100_percent_screening|random_sampling|risk_based');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'MARSEC Change Number');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `change_number` SET TAGS ('dbx_value_regex' = '^MARSEC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `cybersecurity_posture` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Posture');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `cybersecurity_posture` SET TAGS ('dbx_value_regex' = 'normal|elevated|high_alert|lockdown');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `declaration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `drill_exercise_flag` SET TAGS ('dbx_business_glossary_term' = 'Drill or Exercise Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `duration_type` SET TAGS ('dbx_business_glossary_term' = 'Duration Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `duration_type` SET TAGS ('dbx_value_regex' = 'indefinite|temporary|time_limited|until_further_notice');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'entire_port|specific_terminal|specific_berth|anchorage_area|port_waters|restricted_zone');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `issuing_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Type');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `issuing_authority_type` SET TAGS ('dbx_value_regex' = 'national_maritime_security_authority|port_authority|coast_guard|navy|ministry_of_transport|other');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `marsec_level_change_status` SET TAGS ('dbx_business_glossary_term' = 'MARSEC Level Change Status');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `marsec_level_change_status` SET TAGS ('dbx_value_regex' = 'declared|active|superseded|cancelled|expired');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `new_marsec_level` SET TAGS ('dbx_business_glossary_term' = 'New Maritime Security (MARSEC) Level');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `operational_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Operational Impact Description');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `patrol_frequency_change` SET TAGS ('dbx_business_glossary_term' = 'Patrol Frequency Change');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `pfso_acknowledged_flag` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Acknowledged Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `pfso_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Acknowledged Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `pfso_name` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Name');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `pfso_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `pfso_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `planned_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date and Time');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `previous_marsec_level` SET TAGS ('dbx_business_glossary_term' = 'Previous Maritime Security (MARSEC) Level');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `surveillance_enhancement` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Enhancement');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `threat_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Threat Assessment Reference');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `threat_assessment_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `vessel_screening_requirement` SET TAGS ('dbx_business_glossary_term' = 'Vessel Screening Requirement');
ALTER TABLE `shipping_ports_ecm`.`security`.`marsec_level_change` ALTER COLUMN `vessel_screening_requirement` SET TAGS ('dbx_value_regex' = 'standard|enhanced|pre_arrival_security_check|underwater_hull_inspection|mandatory_security_declaration');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` SET TAGS ('dbx_subdomain' = 'facility_compliance');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `zone_access_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Access Authorization ID');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `access_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Access Authorization - Access Credential Id');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Access Authorization - Security Zone Id');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `access_count` SET TAGS ('dbx_business_glossary_term' = 'Access Count');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `authorization_granted_by` SET TAGS ('dbx_business_glossary_term' = 'Authorization Granted By');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `escort_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escort Required Flag');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `marsec_level_override` SET TAGS ('dbx_business_glossary_term' = 'MARSEC Level Override');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `time_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Time Restrictions');
ALTER TABLE `shipping_ports_ecm`.`security`.`zone_access_authorization` ALTER COLUMN `zone_access_entitlements` SET TAGS ('dbx_business_glossary_term' = 'Zone Access Entitlements');
