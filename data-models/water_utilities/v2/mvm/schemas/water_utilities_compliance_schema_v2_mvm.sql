-- Schema for Domain: compliance | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-06-22 20:12:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`compliance` COMMENT 'Regulatory compliance management including permit tracking (NPDES, IUP, state primacy agency permits), MOR/DMR preparation and submission, violation management, enforcement action tracking, audit trails, environmental reporting, SDWA and CWA compliance, CCR publication tracking, and regulatory correspondence. Ensures adherence to all federal, state, and local water and wastewater regulations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` (
    `compliance_permit_id` BIGINT COMMENT 'Primary key for the compliance permit record.',
    `facility_id` BIGINT COMMENT 'FK to the treatment facility covered by this permit.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to regulatory agency',
    `regulatory_requirement_id` BIGINT COMMENT 'FK to the governing regulatory requirement, providing the parallel US/EU/other reference path.',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: Compliance permits (source water withdrawal permits, NPDES permits) are issued for specific water sources/water bodies. The permit governs what may be withdrawn from a named source. Water utility regu',
    `water_system_id` BIGINT COMMENT 'Public Water System identifier.',
    `administrative_record_url` STRING COMMENT 'URL to the administrative record for this permit.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual permit fee amount.',
    `compliance_schedule_flag` BOOLEAN COMMENT 'Whether permit includes a compliance schedule',
    `compliance_status` STRING COMMENT 'Overall compliance status (Compliant, Non-Compliant, Under Review).',
    `contact_email` STRING COMMENT 'Contact email for permit correspondence',
    `contact_person_name` STRING COMMENT 'Primary contact person for the permit',
    `contact_phone` STRING COMMENT 'Contact phone for permit correspondence',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `effective_date` DATE COMMENT 'Date the permit becomes effective.',
    `eu_directive_basis` STRING COMMENT 'EU directive forming the legal basis for this permit (e.g. DWD 2020/2184 Article 11, WFD 2000/60/EC Article 11, UWWTD 91/271/EEC Article 4).',
    `eu_reference_path` STRING COMMENT 'EU reference path: Drinking Water Directive 2020/2184; REACH; WFD; UWWTD citation chain.',
    `expiration_date` DATE COMMENT 'Date the permit expires.',
    `fee_due_date` DATE COMMENT 'Due date for the annual permit fee.',
    `holder` STRING COMMENT '',
    `issue_date` DATE COMMENT '',
    `issuing_agency` STRING COMMENT 'Name of the regulatory agency that issued the permit.',
    `issuing_authority` STRING COMMENT 'Agency that issued the permit.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction (Federal, State, EU, Regional). Allowed regions: US,EU,OTHER.',
    `jurisdiction_code` STRING COMMENT 'Regulatory jurisdiction under which this permit is issued (US_FEDERAL, US_STATE, EU_MEMBER_STATE, EU_COMMISSION, OTHER). Enables multi-jurisdictional permit tracking.',
    `jurisdiction_permit_type` STRING COMMENT 'Jurisdiction-specific permit type classification (e.g. US: Individual/General NPDES; EU: Environmental Permit / Abstraction License).',
    `jurisdiction_region` STRING COMMENT 'Regulatory region code (US, EU, OTHER) under which this permit was issued. Enables multi-jurisdictional permit tracking for US EPA/state permits and EU Water Framework Directive authorizations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `latitude` DECIMAL(18,2) COMMENT '',
    `longitude` DECIMAL(18,2) COMMENT '',
    `major_minor_classification` STRING COMMENT '',
    `major_minor_flag` BOOLEAN COMMENT 'Whether classified as major or minor permit',
    `modification_date` DATE COMMENT 'Date of the most recent permit modification.',
    `modification_reason` STRING COMMENT 'Reason for the most recent permit modification.',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next regulatory inspection.',
    `notes` STRING COMMENT 'Additional notes about the permit.',
    `permit_description` STRING COMMENT 'Detailed description of the permit scope and coverage.',
    `permit_number` STRING COMMENT 'Official permit number assigned by the regulatory agency.',
    `permit_status` STRING COMMENT 'Current status of the permit (Active, Expired, Pending Renewal, Revoked).',
    `permit_type` STRING COMMENT 'Type of permit (NPDES, SDWA, Air, Stormwater, Pretreatment).',
    `permitted_flow_mgd` DECIMAL(18,2) COMMENT 'Maximum permitted flow in million gallons per day.',
    `permittee_name` STRING COMMENT '',
    `population_served` STRING COMMENT 'Population served under this permit.',
    `program` STRING COMMENT '',
    `public_notification_required_flag` BOOLEAN COMMENT '',
    `receiving_water_body` STRING COMMENT 'Name of the receiving water body for discharge permits.',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework for the region (US=EPA/AWWA/NPDWR/UCMR/NPDES; EU=Drinking Water Directive 2020/2184; REACH; Water Framework Directive; Urban Wastewater Treatment Directive; OTHER=Other national/regional frameworks).',
    `regulatory_program` STRING COMMENT 'Regulatory program under which permit is issued',
    `regulatory_region` STRING COMMENT 'Allowed regions: US,EU,OTHER.',
    `regulatory_region_code` STRING COMMENT 'ISO region code identifying the jurisdiction under which this permit was issued (US, EU, OTHER). Supports parallel US NPDES / EU UWWTD permit structures.',
    `renewal_application_date` DATE COMMENT 'Date the renewal application was submitted.',
    `renewal_date` DATE COMMENT '',
    `renewal_due_date` DATE COMMENT 'Deadline for submitting the renewal application.',
    `special_conditions_description` STRING COMMENT 'Description of any special conditions attached to the permit.',
    `special_conditions_flag` BOOLEAN COMMENT 'Indicates whether the permit has special conditions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `us_reference_path` STRING COMMENT 'US reference path: EPA/AWWA/NPDWR/UCMR/NPDES citation chain.',
    `watershed_name` STRING COMMENT 'Name of the watershed associated with this permit.',
    CONSTRAINT pk_compliance_permit PRIMARY KEY(`compliance_permit_id`)
) COMMENT 'Master record for all regulatory permits held by the utility including NPDES, SDWA, air quality, and state-level permits with full lifecycle tracking. [SSOT: Canonical permit record; project.project_permit and treatment.treatment_permit reference this as SSOT]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` (
    `permit_condition_id` BIGINT COMMENT 'Primary key for the permit condition record.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Permit parameter normalization: permit_conditions specify numeric limits for specific contaminants (NPDES effluent parameters, SDWA monitoring conditions). This FK normalizes the denormalized paramete',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Permit conditions are derived from and must comply with specific regulatory requirements — an NPDES effluent limit condition is based on a specific CWA regulatory requirement, a monitoring condition i',
    `treatment_permit_id` BIGINT COMMENT 'FK to the treatment permit this condition belongs to.',
    `analytical_method` STRING COMMENT 'Required analytical method for compliance monitoring.',
    `compliance_due_date` DATE COMMENT 'Due date',
    `compliance_evaluation_method` STRING COMMENT 'Method used to evaluate compliance with this condition.',
    `compliance_schedule_flag` BOOLEAN COMMENT 'Indicates if a compliance schedule applies to this condition.',
    `compliance_schedule_milestone` STRING COMMENT 'Milestone description for compliance schedule.',
    `compliance_status` STRING COMMENT 'Status',
    `condition_number` STRING COMMENT 'Unique condition number within the permit.',
    `condition_status` STRING COMMENT 'Current status of the condition (Active, Superseded, Expired).',
    `condition_text` STRING COMMENT 'Full text of the permit condition.',
    `condition_type` STRING COMMENT 'Type of condition (Effluent Limit, Monitoring, Reporting, Narrative).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `detection_limit_requirement` DECIMAL(18,2) COMMENT 'Required method detection limit for the parameter.',
    `effective_date` DATE COMMENT 'Date the condition becomes effective.',
    `enforcement_priority` STRING COMMENT 'Priority level for enforcement of this condition.',
    `expiration_date` DATE COMMENT 'Date the condition expires.',
    `limit_type` STRING COMMENT 'Type of limit (Daily Max, Monthly Avg, Instantaneous Max).',
    `mixing_zone_allowed_flag` BOOLEAN COMMENT 'Indicates if a mixing zone is allowed for this parameter.',
    `mixing_zone_description` STRING COMMENT 'Description of the allowed mixing zone.',
    `modification_date` DATE COMMENT 'Date of the most recent modification.',
    `modification_reason` STRING COMMENT 'Reason for the modification.',
    `monitoring_frequency` STRING COMMENT 'Required monitoring frequency (Daily, Weekly, Monthly, Quarterly).',
    `monitoring_location` STRING COMMENT 'Required monitoring location for this condition.',
    `notes` STRING COMMENT 'Additional notes about the condition.',
    `numeric_limit` DECIMAL(18,2) COMMENT 'Numeric limit value for the parameter.',
    `public_notification_required_flag` BOOLEAN COMMENT 'Indicates if public notification is required upon violation.',
    `quality_assurance_requirement` STRING COMMENT 'Quality assurance requirements for monitoring.',
    `receiving_water_body` STRING COMMENT 'Receiving water body for this condition.',
    `record_retention_period_days` STRING COMMENT 'Required record retention period in days.',
    `reporting_frequency` STRING COMMENT 'Required reporting frequency.',
    `sample_type` STRING COMMENT 'Required sample type (Grab, Composite, Continuous).',
    `seasonal_period` STRING COMMENT 'Seasonal period if limits vary by season.',
    `seasonal_variation_flag` BOOLEAN COMMENT 'Indicates if limits vary by season.',
    `technology_requirement` STRING COMMENT 'Required treatment technology for this condition.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the numeric limit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `violation_threshold` DECIMAL(18,2) COMMENT 'Threshold value that triggers a violation.',
    `water_quality_standard_basis` STRING COMMENT 'Water quality standard basis for the limit.',
    CONSTRAINT pk_permit_condition PRIMARY KEY(`permit_condition_id`)
) COMMENT 'Individual conditions, limits, and monitoring requirements attached to a compliance permit including numeric limits, monitoring frequencies, and reporting requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Primary key.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to agency',
    `applicable_facility_type` STRING COMMENT 'Facility types to which this requirement applies.',
    `applicable_system_size` STRING COMMENT 'System size categories to which this applies.',
    `ccr_reporting_required` BOOLEAN COMMENT 'Whether CCR reporting is required.',
    `compliance_deadline` DATE COMMENT 'Deadline for achieving compliance.',
    `compliance_status` STRING COMMENT 'Current compliance status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Date the requirement becomes effective.',
    `enforcement_priority` STRING COMMENT 'Priority level for enforcement.',
    `eu_directive_reference` STRING COMMENT 'Reference to applicable EU directive (e.g. Drinking Water Directive 2020/2184, REACH Regulation EC 1907/2006, Water Framework Directive 2000/60/EC, Urban Wastewater Treatment Directive 91/271/EEC).',
    `eu_parametric_value` DECIMAL(18,2) COMMENT 'EU parametric value (equivalent to US MCL) as defined in DWD 2020/2184 Annex I for drinking water parameters.',
    `eu_parametric_value_unit` STRING COMMENT 'Unit of measure for the EU parametric value (e.g. ug/L, mg/L, Bq/L).',
    `eu_reference_path` STRING COMMENT 'EU reference path: Drinking Water Directive 2020/2184; REACH; WFD; UWWTD citation chain.',
    `eu_regulatory_framework` STRING COMMENT 'EU framework reference path (e.g. Drinking Water Directive 2020/2184,REACH,Water Framework Directive,Urban Wastewater Treatment Directive). REACH restriction targets broader PFAS class, not individual compounds; WFD defines surface-water status differently',
    `internal_policy_reference` STRING COMMENT 'Reference to internal policy implementing this requirement.',
    `international_standard_reference` STRING COMMENT 'Reference to WHO guidelines or other international standards applicable beyond US/EU jurisdictions.',
    `is_active` BOOLEAN COMMENT 'Whether the requirement is currently active.',
    `issuing_authority` STRING COMMENT 'Authority that issued the requirement.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction (US-Federal, US-State, EU, UK, other). Allowed regions: US,EU,OTHER.',
    `jurisdiction_code` STRING COMMENT '',
    `jurisdiction_country_code` STRING COMMENT 'Country code for the jurisdiction (US, EU, FR, UK, DE).',
    `jurisdiction_effective_date` DATE COMMENT 'Date from which this regulatory requirement becomes effective in the specified jurisdiction, supporting phased international rollouts.',
    `last_compliance_assessment_date` DATE COMMENT 'Date of last compliance assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `mcl_unit` STRING COMMENT 'Unit of measure for the MCL value.',
    `mcl_value` DECIMAL(18,2) COMMENT 'Maximum Contaminant Level value.',
    `mclg_unit` STRING COMMENT 'Unit of measure for the MCLG value.',
    `mclg_value` DECIMAL(18,2) COMMENT 'Maximum Contaminant Level Goal value.',
    `monitoring_frequency` STRING COMMENT 'Required monitoring frequency.',
    `next_compliance_review_date` DATE COMMENT 'Date of next scheduled compliance review.',
    `notes` STRING COMMENT 'Additional notes.',
    `penalty_description` STRING COMMENT 'Description of penalties for non-compliance.',
    `public_notification_required` BOOLEAN COMMENT 'Whether public notification is required upon violation.',
    `reach_pfas_class_scope_flag` BOOLEAN COMMENT 'True when requirement reflects REACH restriction of the broader PFAS class rather than individual compounds.',
    `region_code` STRING COMMENT 'ISO-style region code: US|EU|FR|UK|DE',
    `regulation_url` STRING COMMENT 'URL to the regulation text.',
    `regulatory_citation` STRING COMMENT 'Formal citation of the regulation.',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework for the region (US=EPA/AWWA/NPDWR/UCMR/NPDES; EU=Drinking Water Directive 2020/2184; REACH; Water Framework Directive; Urban Wastewater Treatment Directive; OTHER=Other national/regional frameworks).',
    `regulatory_program` STRING COMMENT 'Regulatory program (NPDWR, NPDES, UCMR, EU-DWD, REACH).',
    `regulatory_region` STRING COMMENT 'Allowed regions: US,EU,OTHER.',
    `regulatory_region_code` STRING COMMENT 'ISO region code identifying the regulatory jurisdiction (US, EU, OTHER) under which this requirement applies. Enables parallel US/EU/other regulatory reference paths.',
    `reporting_frequency` STRING COMMENT 'Required reporting frequency.',
    `requirement_category` STRING COMMENT 'Category of the requirement.',
    `requirement_code` STRING COMMENT 'Unique code for the requirement.',
    `requirement_description` STRING COMMENT 'Detailed description of the requirement.',
    `requirement_name` STRING COMMENT 'Requirement name',
    `requirement_text` STRING COMMENT 'Full text',
    `requirement_title` STRING COMMENT 'Title of the requirement.',
    `responsible_department` STRING COMMENT 'Department responsible for compliance.',
    `revision_date` DATE COMMENT 'Date of the most recent revision.',
    `superseded_requirement_code` STRING COMMENT 'Code of the requirement this supersedes.',
    `treatment_technique_description` STRING COMMENT 'Description of required treatment technique.',
    `us_reference_path` STRING COMMENT 'US reference path: EPA/AWWA/NPDWR/UCMR/NPDES citation chain.',
    `us_regulatory_framework` STRING COMMENT 'US framework reference path (e.g. EPA,AWWA,NPDWR,UCMR,NPDES).',
    `wfd_surface_water_status_basis` STRING COMMENT 'Water Framework Directive surface-water status classification basis (differs from US determination).',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Master catalog of regulatory requirements from federal, state, and international authorities including SDWA NPDWR, NPDES, EU DWD 2020/2184, and state primacy rules with jurisdiction dimension for multi-region support.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Primary key.',
    `compliance_permit_id` BIGINT COMMENT 'FK to the compliance permit.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Enforcement actions generate specific, trackable obligations — penalty payment deadlines, compliance schedule milestones, corrective action plan submissions, and SEP (Supplemental Environmental Projec',
    `facility_id` BIGINT COMMENT 'FK to facility.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Compliance obligations (treatment technique requirements, upgrade orders, consent decree milestones) are frequently assigned to specific process units (e.g., upgrade GAC unit 3, replace filter medi',
    `regulatory_requirement_id` BIGINT COMMENT 'FK to regulatory requirement.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Many compliance obligations are fulfilled by making a specific regulatory submission — a reporting obligation is fulfilled when the DMR is submitted, a notification obligation is fulfilled when the pu',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Compliance obligations are frequently derived from specific violations — corrective action obligations, public notification obligations, and return-to-compliance obligations all originate from a detec',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: WWTPs carry compliance obligations under NPDES permits (e.g., capital improvement schedules, technology upgrades, monitoring requirements). Direct FK enables obligation tracking per WWTP, due-date man',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual effort in hours.',
    `completed_by` STRING COMMENT 'Person who completed the obligation.',
    `completion_date` DATE COMMENT 'Date the obligation was completed.',
    `completion_timestamp` TIMESTAMP COMMENT 'Timestamp of completion.',
    `contact_email` STRING COMMENT 'Contact email for the obligation.',
    `contact_person` STRING COMMENT 'Contact person name.',
    `contact_phone` STRING COMMENT 'Contact phone number.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `obligation_description` STRING COMMENT 'Detailed description.',
    `due_date` DATE COMMENT 'Due date for the obligation.',
    `effective_end_date` DATE COMMENT 'End of effective period.',
    `effective_start_date` DATE COMMENT 'Start of effective period.',
    `escalation_required` BOOLEAN COMMENT 'Whether escalation is required.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated effort in hours.',
    `evidence_of_fulfillment` STRING COMMENT 'Evidence that the obligation was fulfilled.',
    `is_critical_path` BOOLEAN COMMENT 'Whether this is on the critical path.',
    `last_modified_by` STRING COMMENT 'User who last modified.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `notes` STRING COMMENT 'Additional notes.',
    `obligation_number` STRING COMMENT 'Unique obligation number.',
    `obligation_status` STRING COMMENT 'Current status.',
    `obligation_type` STRING COMMENT 'Type of obligation.',
    `priority_level` STRING COMMENT 'Priority level.',
    `recurrence_interval` STRING COMMENT 'Recurrence interval in days.',
    `recurrence_pattern` STRING COMMENT 'Recurrence pattern description.',
    `regulatory_authority` STRING COMMENT 'Regulatory authority.',
    `regulatory_citation` STRING COMMENT 'Regulatory citation.',
    `responsible_department` STRING COMMENT 'Responsible department.',
    `responsible_party` STRING COMMENT 'Responsible party.',
    `risk_category` STRING COMMENT 'Risk category.',
    `submission_method` STRING COMMENT 'Method of submission.',
    `text` STRING COMMENT 'Obligation text',
    `title` STRING COMMENT 'Obligation title.',
    `created_by` STRING COMMENT 'User who created the record.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Trackable compliance obligations derived from permits, regulations, and enforcement actions with due dates, responsible parties, and fulfillment evidence.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`violation` (
    `violation_id` BIGINT COMMENT 'Primary key.',
    `chemical_id` BIGINT COMMENT 'Foreign key linking to treatment.chemical. Business justification: MCL violations and PFAS exceedances are chemical-specific. compliance_violation has denormalized contaminant_name and contaminant_code that should resolve to the chemical catalog. Enables chemical-spe',
    `compliance_permit_id` BIGINT COMMENT 'FK to the permit that was violated.',
    `facility_id` BIGINT COMMENT 'FK to the facility where the violation occurred.',
    `organization_id` BIGINT COMMENT 'Foreign key linking to customer.organization. Business justification: Industrial pretreatment violations are issued against specific industrial user organizations. Linking compliance_violation to the responsible organization enables industrial pretreatment enforcement r',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: A compliance violation is typically a breach of a specific permit condition — exceeding the numeric limit in a permit condition, failing to meet the monitoring frequency specified in a condition, or v',
    `process_reading_id` BIGINT COMMENT 'Foreign key linking to treatment.process_reading. Business justification: A compliance violation is triggered by a specific process reading that exceeded a regulatory limit. process_reading.is_regulatory_exceedance flag confirms this link exists operationally. Linking viola',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Violations are traced to specific process units (e.g., filter failing turbidity, disinfection unit failing CT). Root cause analysis, corrective action tracking, and regulatory reporting all require kn',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: A compliance violation is reported to and tracked by a specific regulatory agency (EPA, state primacy agency). The existing primacy_agency_code STRING column is a denormalized reference to the regulat',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Many compliance violations are discovered during regulatory inspections — an inspector identifies an MCL exceedance, a monitoring gap, or a treatment technique failure during a site visit. Linking com',
    `regulatory_requirement_id` BIGINT COMMENT 'FK to the regulatory requirement violated.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: A compliance violation is formally reported to the regulatory agency via a regulatory submission (e.g., DMR exceedance report, SDWIS violation report, public notification submission). Linking complian',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: Sanitary Sewer Overflow (SSO) violations under NPDES are attributed to specific collection system segments. Regulators require SSO reporting by location/segment. Direct FK enables SSO violation histor',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: PWSID-based violation tracking: SDWA compliance violations are reported by PWSID (water system identifier). This FK normalizes the denormalized pwsid text field on compliance_violation, enabling syste',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: NPDES violations (effluent exceedances, permit limit breaches) are directly attributed to specific WWTPs. Compliance officers must query all violations per WWTP for enforcement response, return-to-com',
    `affected_population` STRING COMMENT 'Estimated population affected by the violation',
    `agency_notification_date` DATE COMMENT 'Date agency was notified.',
    `begin_date` DATE COMMENT 'Date the violation period began',
    `violation_category` STRING COMMENT 'Category of violation.',
    `compliance_period_begin` DATE COMMENT 'Start of the compliance monitoring period',
    `compliance_period_begin_date` DATE COMMENT 'Start of the compliance monitoring period',
    `compliance_period_end` DATE COMMENT 'End of the compliance monitoring period',
    `compliance_period_end_date` DATE COMMENT 'End of the compliance monitoring period',
    `compliance_violation_description` STRING COMMENT 'Narrative description of the violation.',
    `corrective_action_completed_date` DATE COMMENT 'Date corrective action was completed',
    `corrective_action_description` STRING COMMENT 'Description of corrective action taken.',
    `corrective_action_due_date` DATE COMMENT 'Deadline for completing corrective action',
    `corrective_action_required` STRING COMMENT 'Whether corrective action is required',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `violation_description` STRING COMMENT '',
    `detection_date` DATE COMMENT 'Date the violation was detected',
    `discovered_date` DATE COMMENT '',
    `discovery_date` DATE COMMENT 'Date the violation was discovered.',
    `end_date` DATE COMMENT 'Date the violation period ended',
    `enforcement_action_flag` BOOLEAN COMMENT 'Whether enforcement action was taken.',
    `enforcement_action_pending` BOOLEAN COMMENT 'Whether enforcement action is pending',
    `enforcement_action_required` BOOLEAN COMMENT 'Enforcement required',
    `enforcement_action_taken` BOOLEAN COMMENT 'Whether formal enforcement action was taken',
    `health_based_flag` BOOLEAN COMMENT 'Whether this is a health-based violation',
    `health_effects_statement` STRING COMMENT 'Health effects statement.',
    `is_health_based` BOOLEAN COMMENT 'Whether the violation is health-based (vs. non-health-based).',
    `is_public_notification_required` BOOLEAN COMMENT 'Whether public notification is required.',
    `jurisdiction` STRING COMMENT 'Jurisdiction',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `limit_value` DECIMAL(18,2) COMMENT 'Regulatory limit value.',
    `mcl_value` DECIMAL(18,2) COMMENT 'Maximum Contaminant Level that was exceeded',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value that triggered the violation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Record last modification timestamp',
    `notes` STRING COMMENT 'Additional notes.',
    `notification_tier` STRING COMMENT '',
    `parameter_name` STRING COMMENT '',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount assessed.',
    `penalty_amount_usd` DECIMAL(18,2) COMMENT 'Monetary penalty assessed in USD',
    `population_affected` STRING COMMENT 'Number of people affected.',
    `public_notification_date` DATE COMMENT 'Date public notification was issued.',
    `public_notification_issued_date` DATE COMMENT 'Date public notification was issued',
    `public_notification_required` BOOLEAN COMMENT 'Whether public notification is required.',
    `public_notification_required_flag` BOOLEAN COMMENT '',
    `regulation_citation` STRING COMMENT 'Regulatory citation breached.',
    `regulatory_agency_notified_date` DATE COMMENT 'Date the regulatory agency was notified',
    `regulatory_citation` STRING COMMENT 'Regulatory citation.',
    `regulatory_limit` DECIMAL(18,2) COMMENT '',
    `regulatory_limit_value` DECIMAL(18,2) COMMENT 'The applicable regulatory limit that was exceeded',
    `regulatory_standard` STRING COMMENT '',
    `reported_date` DATE COMMENT '',
    `reported_to_epa_date` DATE COMMENT 'Date violation was reported to EPA',
    `reported_to_state_date` DATE COMMENT 'Date violation was reported to the state primacy agency',
    `resolution_date` DATE COMMENT 'Date the violation was resolved.',
    `resolution_status` STRING COMMENT 'Current resolution status.',
    `resolved_date` DATE COMMENT 'Date the violation was resolved.',
    `return_to_compliance_date` DATE COMMENT 'Date returned to compliance.',
    `root_cause` STRING COMMENT 'Root cause analysis.',
    `rtc_date` DATE COMMENT 'Date the system returned to compliance',
    `rule_code` STRING COMMENT 'Regulatory rule code (e.g., SWTR, LCR, TCR, DBP)',
    `rule_name` STRING COMMENT 'Full name of the regulatory rule violated.',
    `sdwis_violation_number` STRING COMMENT 'Violation ID in the Safe Drinking Water Information System.',
    `severity` STRING COMMENT 'Severity classification of the violation.',
    `severity_level` STRING COMMENT 'Severity level (Tier 1, Tier 2, Tier 3).',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `violation_date` DATE COMMENT 'Date the violation occurred.',
    `violation_number` STRING COMMENT 'Unique violation tracking number.',
    `violation_status` STRING COMMENT 'Current status (Open, Resolved, Under Review).',
    `violation_type` STRING COMMENT 'Type of violation (MCL, Monitoring, Treatment Technique, Reporting).',
    CONSTRAINT pk_violation PRIMARY KEY(`violation_id`)
) COMMENT 'Records of regulatory violations including MCL exceedances, monitoring violations, treatment technique violations, and reporting violations with severity, root cause, and resolution tracking. [SSOT: Canonical violation record; treatment.treatment_violation references this as SSOT]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` (
    `enforcement_action_id` BIGINT COMMENT 'Unique identifier for the enforcement action record. Primary key.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the permit under which the violation and enforcement action occurred (NPDES permit, drinking water permit, IUP, etc.).',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility subject to the enforcement action.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to agency',
    `violation_id` BIGINT COMMENT 'Reference to the primary violation record that triggered this enforcement action. Links to the violation tracking system.',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: System-level enforcement tracking: EPA and state enforcement actions under SDWA are taken against water_systems (by PWSID). This FK enables system-level enforcement history, compliance status assessme',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: Enforcement actions (NOVs, consent orders, civil penalties) are issued against specific WWTPs for NPDES violations. Direct FK enables enforcement history per WWTP, penalty tracking, and legal response',
    `action_date` DATE COMMENT 'Action date',
    `action_number` STRING COMMENT 'Official enforcement action number or case number assigned by the regulatory agency (EPA, state primacy agency, NPDES authority). This is the externally-known identifier used in all regulatory correspondence and legal documents.',
    `action_status` STRING COMMENT 'Current lifecycle status of the enforcement action. Tracks progression from issuance through utility response, negotiation, and final resolution.. Valid values are `issued|under_review|response_submitted|in_negotiation|resolved|closed`',
    `action_summary` STRING COMMENT 'Brief summary of the enforcement action, including the nature of the violation, regulatory basis, and key requirements. Provides context for reporting and management review.',
    `action_type` STRING COMMENT 'Type of formal enforcement action initiated by the regulatory agency. Includes Notice of Violation (NOV), Administrative Order (AO), Consent Order, Compliance Schedule, civil penalty assessment, or criminal referral.. Valid values are `notice_of_violation|administrative_order|consent_order|compliance_schedule|civil_penalty|criminal_referral`',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the utility filed a formal appeal or contested the enforcement action through administrative or judicial proceedings.',
    `appeal_filing_date` DATE COMMENT 'Date the utility filed its appeal or petition for review. Null if no appeal was filed.',
    `board_notification_date` DATE COMMENT 'Date the utilitys Board of Directors or governing body was notified of the enforcement action. Tracks governance and executive oversight requirements.',
    `civil_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed by the regulatory agency in U.S. dollars. Null if no civil penalty was imposed.',
    `compliance_schedule_final_deadline` DATE COMMENT 'Final deadline by which all corrective actions and compliance milestones must be completed. Null if no compliance schedule is required.',
    `compliance_schedule_required_flag` BOOLEAN COMMENT 'Indicates whether the enforcement action includes a formal compliance schedule with milestones and deadlines for corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Description of the corrective actions required by the enforcement action. May include operational changes, infrastructure upgrades, process improvements, or enhanced monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was first created in the system. Audit trail for data lineage.',
    `document_reference_number` STRING COMMENT 'Internal document management system reference number for the enforcement action file. Links to stored correspondence, legal documents, and supporting materials.',
    `issue_date` DATE COMMENT 'Date the enforcement action was officially issued or signed by the regulatory agency. This is the principal business event timestamp for the enforcement action lifecycle.',
    `issuing_agency` STRING COMMENT 'Name of the regulatory agency that issued the enforcement action (e.g., U.S. Environmental Protection Agency, State Department of Environmental Quality, Regional Water Quality Control Board).',
    `issuing_agency_region` STRING COMMENT 'Regional office, district, or jurisdiction of the issuing agency (e.g., EPA Region 5, Northwest Regional Office). Identifies the specific regulatory authority within the agency structure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was last updated. Audit trail for change tracking.',
    `legal_counsel_assigned` STRING COMMENT 'Name of the internal or external legal counsel assigned to manage the utilitys response to the enforcement action. Business-confidential information.',
    `legal_firm_name` STRING COMMENT 'Name of the external law firm representing the utility, if external counsel is engaged. Null if handled internally.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this enforcement action record. Audit trail for accountability.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, internal discussions, negotiation history, or other relevant information not captured in structured fields.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount',
    `penalty_paid_amount` DECIMAL(18,2) COMMENT 'Actual amount paid by the utility toward the civil penalty. May differ from assessed amount due to negotiated settlements or payment plans.',
    `penalty_payment_date` DATE COMMENT 'Date the civil penalty payment was made to the regulatory agency. Tracks compliance with payment deadlines.',
    `public_notice_date` DATE COMMENT 'Date public notice of the enforcement action was issued. Null if public notice is not required.',
    `public_notice_required_flag` BOOLEAN COMMENT 'Indicates whether the enforcement action requires public notification under regulatory or consent order terms. Drives public communication and transparency obligations.',
    `received_date` DATE COMMENT 'Date the utility officially received the enforcement action notice. Used to calculate response deadlines and compliance timelines.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory statute, rule, or permit condition cited in the enforcement action (e.g., Clean Water Act Section 301, 40 CFR 122.41, NPDES Permit Condition III.A.1). Identifies the legal basis for the enforcement.',
    `resolution_date` DATE COMMENT 'Date the enforcement action was formally resolved or closed. Indicates completion of all required corrective actions, penalty payments, and regulatory obligations.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the enforcement action. Indicates how the action was resolved (compliance achieved, consent order executed, penalty paid, dismissed, or under appeal).. Valid values are `compliance_achieved|consent_order_executed|penalty_paid|dismissed|under_appeal`',
    `response_due_date` DATE COMMENT 'Deadline by which the utility must submit a formal response to the enforcement action. Typically specified in the enforcement notice or calculated based on regulatory timelines.',
    `response_submitted_date` DATE COMMENT 'Date the utility submitted its formal response to the enforcement action. Tracks compliance with response deadlines.',
    `sep_description` STRING COMMENT 'Description of the Supplemental Environmental Project (SEP) agreed to as part of the enforcement settlement. Null if no SEP is included.',
    `sep_estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost of the Supplemental Environmental Project (SEP) in U.S. dollars. Used to calculate penalty offsets and track SEP investment.',
    `supplemental_environmental_project_flag` BOOLEAN COMMENT 'Indicates whether the enforcement action includes a Supplemental Environmental Project (SEP) as part of the settlement. SEPs are environmentally beneficial projects that go beyond compliance requirements and may offset civil penalties.',
    CONSTRAINT pk_enforcement_action PRIMARY KEY(`enforcement_action_id`)
) COMMENT 'Formal enforcement action initiated by a regulatory agency (EPA, state primacy agency, NPDES authority) against the utility in response to violations, including Notices of Violation (NOVs), Administrative Orders (AOs), Consent Orders, Compliance Schedules, civil penalties, and criminal referrals. Tracks the issuing agency, action type, associated violations, compliance schedule milestones, penalty amounts, response deadlines, legal counsel assigned, and resolution outcome. Drives the utilitys formal regulatory response process.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` (
    `regulatory_inspection_id` BIGINT COMMENT 'Unique identifier for the regulatory inspection record. Primary key.',
    `compliance_permit_id` BIGINT COMMENT 'Identifier of the permit under which the inspection was conducted (NPDES, IUP, state primacy permit).',
    `facility_id` BIGINT COMMENT 'Identifier of the water or wastewater facility that was inspected (WTP, WWTP, pumping station, etc.).',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Sanitary surveys and compliance inspections evaluate specific treatment process units for regulatory compliance. Business process: regulatory inspections where state inspectors assess individual treat',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Sanitary surveys and state regulatory inspections explicitly cover distribution pump stations (pressure adequacy, backflow prevention, emergency power). Regulatory inspectors visit and document findin',
    `regulatory_agency_id` BIGINT COMMENT 'FK to agency',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Storage tanks are primary targets of regulatory inspections (state sanitary surveys, AWWA/ANSI inspection programs). Regulators inspect tanks for structural integrity, disinfection residuals, and secu',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: Sanitary survey / system inspection: SDWA sanitary surveys and regulatory inspections are conducted at the water_system level (by PWSID). This FK enables tracking inspection history per water system, ',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: Regulatory agencies conduct compliance inspections at WWTPs under NPDES and pretreatment programs. A direct FK enables inspection history per WWTP, deficiency tracking, and follow-up scheduling — stan',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which all required corrective actions must be completed and verified.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required by the utility in response to inspection findings.',
    `corrective_action_summary` STRING COMMENT 'Summary of the corrective actions required to address deficiencies and achieve compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the compliance management system.',
    `deficiency_count` STRING COMMENT 'Total number of deficiencies or non-compliance items identified during the inspection.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether formal enforcement action (administrative order, consent decree, penalty) was initiated as a result of this inspection.',
    `findings_summary` STRING COMMENT 'High-level summary of the inspection findings, deficiencies identified, and overall compliance status.',
    `follow_up_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up inspection by the regulatory agency is required to verify corrective action completion.',
    `follow_up_inspection_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up inspection if required.',
    `inspecting_agency` STRING COMMENT 'Name of the regulatory body or agency that conducted the inspection (EPA, state primacy agency, local health department, etc.).',
    `inspection_date` DATE COMMENT 'Date on which the regulatory inspection was conducted at the facility.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the on-site inspection activity concluded.',
    `inspection_notes` STRING COMMENT 'Internal notes and observations recorded by utility staff during or after the inspection for follow-up and documentation purposes.',
    `inspection_number` STRING COMMENT 'Externally-known unique identifier or reference number assigned by the regulatory agency for this inspection.',
    `inspection_report_received_date` DATE COMMENT 'Date on which the utility received the official inspection report from the regulatory agency.',
    `inspection_report_status` STRING COMMENT 'Current status of the official inspection report (draft, final, under review, accepted, disputed).. Valid values are `draft|final|under_review|accepted|disputed`',
    `inspection_scope` STRING COMMENT 'Description of the areas, processes, or systems covered during the inspection (e.g., treatment processes, discharge monitoring, pretreatment program, laboratory practices).',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the on-site inspection activity began.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection (scheduled, in progress, completed, report pending, closed, cancelled).. Valid values are `scheduled|in_progress|completed|report_pending|closed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity (sanitary survey, compliance inspection, pretreatment audit, NPDES inspection, routine inspection, follow-up inspection, complaint investigation). [ENUM-REF-CANDIDATE: sanitary_survey|compliance_inspection|pretreatment_audit|npdes_inspection|routine_inspection|follow_up_inspection|complaint_investigation — 7 candidates stripped; promote to reference product]',
    `inspector_contact_email` STRING COMMENT 'Email address of the lead inspector for official correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `inspector_contact_phone` STRING COMMENT 'Phone number of the lead inspector for follow-up communication.',
    `inspector_name` STRING COMMENT 'Full name of the lead inspector or compliance officer who conducted the inspection.',
    `inspector_title` STRING COMMENT 'Job title or role of the lead inspector (e.g., Environmental Compliance Officer, Sanitary Survey Specialist).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last updated or modified.',
    `response_due_date` DATE COMMENT 'Deadline by which the utility must submit a formal response or corrective action plan to the regulatory agency.',
    `significant_deficiency_classification` STRING COMMENT 'Classification or category of the significant deficiency if identified (e.g., treatment process failure, monitoring inadequacy, operational deficiency).',
    `significant_deficiency_flag` BOOLEAN COMMENT 'Indicates whether any significant deficiencies (as defined by SDWA) were identified that could affect water quality or public health.',
    `utility_representative_title` STRING COMMENT 'Job title of the utility representative who coordinated the inspection (e.g., Compliance Manager, Plant Superintendent).',
    `violation_identified_flag` BOOLEAN COMMENT 'Indicates whether any regulatory violations (SDWA, CWA, NPDES permit) were formally identified during the inspection.',
    CONSTRAINT pk_regulatory_inspection PRIMARY KEY(`regulatory_inspection_id`)
) COMMENT 'Record of regulatory inspections and audits conducted by EPA, state primacy agencies, or other regulatory bodies at utility facilities. Tracks the inspection type (sanitary survey, compliance inspection, pretreatment audit, NPDES inspection), inspecting agency, facility inspected, inspection date, inspector name, findings and deficiencies identified, significant deficiency classifications, required corrective actions, response deadlines, and final inspection report status. Drives post-inspection corrective action tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the permit under which this submission is being made (NPDES permit, IUP, state discharge permit, etc.).',
    `facility_id` BIGINT COMMENT 'Reference to the water or wastewater facility (WTP, WWTP, pumping station, etc.) that this submission pertains to.',
    `original_submission_regulatory_submission_id` BIGINT COMMENT 'Reference to the original submission record if this submission is a correction, amendment, or resubmission.',
    `regulatory_agency_id` BIGINT COMMENT 'Reference to the regulatory agency receiving this submission (EPA, state primacy agency, local health department, etc.).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Every regulatory submission is made to fulfill a specific regulatory requirement — monthly DMRs fulfill NPDES monitoring requirements, annual CCRs fulfill SDWA consumer confidence report requirements,',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: PWSID-based submission tracking: regulatory submissions (DMRs, CCRs, annual reports) are filed for specific water_systems identified by PWSID. This FK enables tracking all submissions per water system',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: WWTPs submit Discharge Monitoring Reports (DMRs) and other NPDES regulatory submissions. Direct FK enables DMR submission history per WWTP, late submission tracking, and agency acknowledgment manageme',
    `acknowledgment_received_date` DATE COMMENT 'The date on which the regulatory agency acknowledged receipt of the submission (via NetDMR confirmation, email reply, or other means).',
    `acknowledgment_reference_number` STRING COMMENT 'The confirmation or tracking number provided by the regulatory agency upon receipt of the submission.',
    `agency_comments` STRING COMMENT 'Comments, feedback, or instructions provided by the regulatory agency regarding the submission.',
    `agency_response_date` DATE COMMENT 'The date on which the regulatory agency provided a formal response, feedback, or determination regarding the submission.',
    `agency_response_type` STRING COMMENT 'The type of response or action taken by the regulatory agency in response to the submission.. Valid values are `accepted|rejected|request_for_information|notice_of_violation|enforcement_action|no_response`',
    `amendment_reason` STRING COMMENT 'Explanation of why the submission was amended or corrected, including the nature of the error or omission in the original submission.',
    `certification_date` DATE COMMENT 'The date on which the certifying official signed and certified the submission.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory submission record was first created in the system.',
    `due_date` DATE COMMENT 'The regulatory deadline by which this submission must be filed to remain in compliance.',
    `exceedance_count` STRING COMMENT 'The number of parameter exceedances (values above permit limits but not necessarily violations) reported in this submission.',
    `is_amendment` BOOLEAN COMMENT 'Indicates whether this submission is an amendment or correction to a previously submitted report.',
    `is_late_submission` BOOLEAN COMMENT 'Indicates whether the submission was filed after the regulatory due date, which may trigger enforcement action or violation notices.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory submission record was last updated or modified.',
    `noncompliance_explanation` STRING COMMENT 'Narrative explanation provided by the utility for any violations, exceedances, or non-compliance events reported in the submission, including corrective actions taken or planned.',
    `public_notice_date` DATE COMMENT 'The date on which public notification was issued, if required.',
    `public_notice_required` BOOLEAN COMMENT 'Indicates whether this submission requires public notification (e.g., CCR publication, SSO public notice, boil water advisory).',
    `reporting_period_end_date` DATE COMMENT 'The ending date of the time period covered by this regulatory submission.',
    `reporting_period_start_date` DATE COMMENT 'The beginning date of the time period covered by this regulatory submission.',
    `resubmission_required` BOOLEAN COMMENT 'Indicates whether the regulatory agency has requested a corrected or amended resubmission of the report.',
    `submission_date` DATE COMMENT 'The date on which the regulatory submission was formally submitted to the regulatory agency. This is the principal business event timestamp for the submission.',
    `submission_file_format` STRING COMMENT 'The file format or media type of the submitted report.. Valid values are `PDF|XML|CSV|Excel|paper|other`',
    `submission_file_path` STRING COMMENT 'The file system path or document management system reference to the submitted report document (PDF, XML, CSV, etc.).',
    `submission_method` STRING COMMENT 'The method or channel used to submit the report to the regulatory agency. NetDMR is the EPA electronic discharge monitoring reporting system.. Valid values are `NetDMR|state_portal|email|paper|fax|hand_delivery`',
    `submission_notes` STRING COMMENT 'Internal notes, comments, or additional context regarding the preparation, submission, or follow-up actions for this regulatory submission.',
    `submission_number` STRING COMMENT 'Business identifier or tracking number assigned to the regulatory submission, often used for external reference and correspondence with regulatory agencies.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission indicating its progress through the submission and review workflow.. Valid values are `draft|submitted|acknowledged|accepted|rejected|under_review`',
    `submission_type` STRING COMMENT 'Category of regulatory submission. DMR = Discharge Monitoring Report, MOR = Monthly Operating Report, CCR = Consumer Confidence Report, SSO = Sanitary Sewer Overflow, CSO = Combined Sewer Overflow, PFAS = Per- and Polyfluoroalkyl Substances, LCRR = Lead and Copper Rule Revisions. [ENUM-REF-CANDIDATE: DMR|MOR|CCR|SSO_notification|CSO_notification|pretreatment_report|annual_report|PFAS_report|LCRR_inventory|permit_application|variance_request|other — promote to reference product]',
    `violation_count` STRING COMMENT 'The number of permit limit violations or non-compliance events reported in this submission.',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Master record of all formal regulatory submissions made by the utility to regulatory agencies, serving as the single audit trail for submission compliance. Covers DMR submissions (via NetDMR), MOR submissions, CCR certifications, annual compliance reports, pretreatment program reports, SSO/CSO notifications, PFAS reporting, LCRR service line inventory submissions, and Lead Service Line Replacement (LSLR) progress reports. Tracks submission type, receiving agency, submission date, submission method (NetDMR, state portal, paper, email), reporting period, submitter, certifying official, certification status, acknowledgment receipt, late submission flags, and resubmission history. Enables monitoring of submission timeliness — a key compliance metric tracked by state primacy agencies.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` (
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the regulatory agency record. Primary key.',
    `parent_regulatory_agency_id` BIGINT COMMENT 'Self-referencing FK on regulatory_agency (parent_regulatory_agency_id)',
    `address_line1` STRING COMMENT 'Primary street address line for the regulatory agency headquarters or regional office.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, floor, or building information.',
    `address_line_1` STRING COMMENT 'First line of the agencys physical mailing address (street number and name).',
    `address_line_2` STRING COMMENT 'Second line of the agencys physical mailing address (suite, floor, building, etc.). Nullable.',
    `agency_acronym` STRING COMMENT '',
    `agency_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the regulatory agency within the utilitys systems (e.g., EPA_R5, STATE_DNR, PUC_WI).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `agency_level` STRING COMMENT '',
    `agency_main_email` STRING COMMENT 'General inquiry or main email address for the regulatory agency.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_main_phone` STRING COMMENT 'Main switchboard or general inquiry phone number for the regulatory agency.. Valid values are `^+?[0-9s-()]{10,20}$`',
    `agency_name` STRING COMMENT 'Full legal name of the regulatory agency or governing body (e.g., U.S. Environmental Protection Agency Region 5, Wisconsin Department of Natural Resources).',
    `agency_short_name` STRING COMMENT 'Abbreviated or commonly used name for the agency (e.g., EPA Region 5, WI DNR, OSHA).',
    `agency_status` STRING COMMENT 'Current operational status of the regulatory agency (active, inactive, merged, dissolved).. Valid values are `active|inactive|merged|dissolved`',
    `agency_type` STRING COMMENT 'Classification of the regulatory agency by its primary regulatory focus (environmental, health, safety, rate regulatory, labor, quality standards, other). [ENUM-REF-CANDIDATE: environmental|health|safety|rate_regulatory|labor|quality_standards|other — 7 candidates stripped; promote to reference product]',
    `agency_website_url` STRING COMMENT 'Official website URL for the regulatory agency.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    `business_hours` STRING COMMENT 'Standard business hours of operation for the regulatory agency office (e.g., Monday-Friday 8:00 AM - 5:00 PM PST).',
    `city` STRING COMMENT 'City name for the agencys physical mailing address.',
    `contact_email` STRING COMMENT '',
    `contact_name` STRING COMMENT 'Contact name',
    `contact_phone` STRING COMMENT '',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the agencys physical mailing address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory agency record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this agencys jurisdiction or regulatory authority over the utility became effective.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency contact phone number for reporting spills, violations, or urgent compliance matters.',
    `enforcement_authority_level` STRING COMMENT 'Level of enforcement authority this agency holds over the utility (primary, delegated, advisory, none). Primary indicates direct enforcement power; delegated indicates authority granted by a higher-level agency; advisory indicates no direct enforcement.. Valid values are `primary|delegated|advisory|none`',
    `eu_directive_scope` STRING COMMENT 'Comma-separated list of EU directives this agency administers (DWD_2020_2184, REACH, WFD_2000_60, UWWTD_91_271).',
    `eu_member_state` STRING COMMENT 'For EU-region agencies, the EU member state code (e.g. DE, FR, NL). NULL for non-EU agencies.',
    `eu_member_state_code` STRING COMMENT 'ISO 3166-1 alpha-2 code for EU member state where this agency has competent authority (e.g. DE, FR, NL). NULL for non-EU agencies.',
    `eu_reference_path` STRING COMMENT 'EU reference path: Drinking Water Directive 2020/2184; REACH; WFD; UWWTD citation chain.',
    `eu_regulatory_framework` STRING COMMENT 'EU directives administered (e.g. Drinking Water Directive 2020/2184,REACH,Water Framework Directive,Urban Wastewater Treatment Directive). REACH restriction targets broader PFAS class, not individual compounds; WFD defines surface-water status differently',
    `fax_number` STRING COMMENT 'Fax number for document submission to the regulatory agency, if applicable.',
    `inspection_frequency_months` STRING COMMENT 'Typical frequency in months at which this regulatory agency conducts inspections of utility facilities under its jurisdiction.',
    `inspection_frequency_typical` STRING COMMENT 'Typical frequency at which this agency conducts inspections or audits of utility facilities (annual, biennial, triennial, as-needed, risk-based).. Valid values are `annual|biennial|triennial|as_needed|risk_based`',
    `international_agency_flag` BOOLEAN COMMENT 'True for non-US (EU/FR/UK/DE) regulatory agencies.',
    `is_active` BOOLEAN COMMENT '',
    `jurisdiction` STRING COMMENT 'Geographic or administrative jurisdiction of the regulatory agency (e.g., United States, California, Los Angeles County).',
    `jurisdiction_code` STRING COMMENT 'Jurisdiction code',
    `jurisdiction_geographic_area` STRING COMMENT 'Geographic area or service territory over which the agency has regulatory authority (e.g., EPA Region 5 covers IL, IN, MI, MN, OH, WI; or specific county/municipality names).',
    `jurisdiction_level` STRING COMMENT 'The governmental level at which the agency operates (federal, state, regional, local, international).. Valid values are `federal|state|regional|local|international`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection conducted by this regulatory agency at any utility facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory agency record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the regulatory agency relationship.',
    `notification_deadline_hours` STRING COMMENT 'Standard number of hours within which the utility must notify this agency of reportable incidents or violations (e.g., 24 hours for SSO events).',
    `npdes_authority_flag` BOOLEAN COMMENT 'Indicates whether this agency has authority to issue and enforce NPDES permits under the Clean Water Act. True if authorized, False otherwise.',
    `parent_regulatory_agency_id_legacy` BIGINT COMMENT 'Reference to the parent or umbrella agency if this agency is a regional office, division, or sub-agency (e.g., EPA Region 5 parent is EPA). Null if this is a top-level agency.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the agencys physical mailing address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `pretreatment_authority_flag` BOOLEAN COMMENT 'Indicates whether this agency has authority to oversee industrial pretreatment programs. True if authorized, False otherwise.',
    `primacy_agency_flag` BOOLEAN COMMENT 'Indicates whether this agency has primacy authority for Safe Drinking Water Act (SDWA) enforcement in its jurisdiction. True if primacy agency, False otherwise.',
    `primacy_status` STRING COMMENT 'Indicates whether this agency is a primacy agency under the Safe Drinking Water Act (SDWA) or Clean Water Act (CWA), meaning it has been delegated primary enforcement authority by EPA (primacy_agency, non_primacy, not_applicable).. Valid values are `primacy_agency|non_primacy|not_applicable`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the agency contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the agency for utility compliance matters.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the agency contact.. Valid values are `^+?[0-9s-()]{10,20}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the agency.',
    `primary_program` STRING COMMENT '',
    `primary_regulatory_program` STRING COMMENT 'The main regulatory program or statute administered by this agency relevant to water utilities (e.g., SDWA, CWA, NPDES, OSHA, Rate Regulation).',
    `region_code` STRING COMMENT 'Regional designation or code if the agency operates within a specific region (e.g., EPA Region 9, Water Board Region 4).',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework for the region (US=EPA/AWWA/NPDWR/UCMR/NPDES; EU=Drinking Water Directive 2020/2184; REACH; Water Framework Directive; Urban Wastewater Treatment Directive; OTHER=Other national/regional frameworks).',
    `regulatory_program` STRING COMMENT 'Primary regulatory program or framework administered by the agency (e.g., NPDES, SDWA Primacy, Pretreatment, Lead and Copper Rule).',
    `regulatory_region` STRING COMMENT 'Regulatory region Allowed regions: US,EU,OTHER.',
    `regulatory_region_code` STRING COMMENT 'ISO region code identifying the jurisdiction this agency operates in (US, EU, OTHER). Enables multi-jurisdictional regulatory agency modeling.',
    `reporting_frequency_default` STRING COMMENT 'Default or most common reporting frequency required by this agency for compliance reports (monthly, quarterly, semi-annual, annual, event-driven, as-required).. Valid values are `monthly|quarterly|semi_annual|annual|event_driven|as_required`',
    `reporting_system_name` STRING COMMENT 'Name of the electronic reporting system used by the agency (e.g., NetDMR, SDWIS, state-specific portal).',
    `state` STRING COMMENT 'Two-letter state or province code where the regulatory agency office is located.. Valid values are `^[A-Z]{2}$`',
    `state_province` STRING COMMENT 'Two-letter state or province code for the agencys physical mailing address (e.g., WI, IL, CA).. Valid values are `^[A-Z]{2}$`',
    `submission_credentials_reference` STRING COMMENT 'Reference identifier or location for stored login credentials or API keys used to access the agencys submission portal. Should reference a secure credential vault, not store actual credentials.',
    `submission_portal_name` STRING COMMENT 'Name of the online submission portal or system (e.g., NetDMR, State Environmental Portal, OSHA Injury Tracking Application).',
    `submission_portal_url` STRING COMMENT 'URL for the online portal or system used to submit compliance reports, permits, or other regulatory documents to this agency (e.g., NetDMR, state e-reporting system).. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    `termination_date` DATE COMMENT 'Date when this agencys jurisdiction or regulatory authority over the utility ended or will end. Null if still active.',
    `us_reference_path` STRING COMMENT 'US reference path: EPA/AWWA/NPDWR/UCMR/NPDES citation chain.',
    `us_regulatory_framework` STRING COMMENT 'US frameworks administered (e.g. EPA,AWWA,NPDWR,UCMR,NPDES).',
    `website_url` STRING COMMENT 'Official website URL for the regulatory agency.',
    CONSTRAINT pk_regulatory_agency PRIMARY KEY(`regulatory_agency_id`)
) COMMENT 'Master reference table for regulatory_agency. Referenced by: compliance.regulatory_submission.regulatory_agency_id, treatment.mor_submission.regulatory_agency_id, treatment.treatment_permit.regulatory_agency_id, treatment.treatment_violation.regulatory_agency_id';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_original_submission_regulatory_submission_id` FOREIGN KEY (`original_submission_regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_parent_regulatory_agency_id` FOREIGN KEY (`parent_regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'PWS ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `administrative_record_url` SET TAGS ('dbx_business_glossary_term' = 'Administrative Record URL');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_directive_basis` SET TAGS ('dbx_business_glossary_term' = 'EU Directive Basis');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_reference_path` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `fee_due_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction_permit_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `major_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Major/Minor');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `modification_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `modification_reason` SET TAGS ('dbx_business_glossary_term' = 'Modification Reason');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `permit_description` SET TAGS ('dbx_business_glossary_term' = 'Permit Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `permitted_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Flow MGD');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `special_conditions_description` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `special_conditions_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `us_reference_path` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `watershed_name` SET TAGS ('dbx_business_glossary_term' = 'Watershed Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evaluation Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_schedule_milestone` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Milestone');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_text` SET TAGS ('dbx_business_glossary_term' = 'Condition Text');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `detection_limit_requirement` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Priority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `mixing_zone_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixing Zone Allowed');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `mixing_zone_description` SET TAGS ('dbx_business_glossary_term' = 'Mixing Zone Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `modification_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `modification_reason` SET TAGS ('dbx_business_glossary_term' = 'Modification Reason');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `monitoring_location` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `numeric_limit` SET TAGS ('dbx_business_glossary_term' = 'Numeric Limit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `public_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `quality_assurance_requirement` SET TAGS ('dbx_business_glossary_term' = 'QA Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `record_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Period');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `seasonal_period` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `seasonal_variation_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Variation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `technology_requirement` SET TAGS ('dbx_business_glossary_term' = 'Technology Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `violation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Violation Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `water_quality_standard_basis` SET TAGS ('dbx_business_glossary_term' = 'WQS Basis');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicable_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicable_system_size` SET TAGS ('dbx_business_glossary_term' = 'Applicable System Size');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `ccr_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'CCR Reporting Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Priority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'EU Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_parametric_value` SET TAGS ('dbx_business_glossary_term' = 'EU Parametric Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_parametric_value_unit` SET TAGS ('dbx_business_glossary_term' = 'EU Parametric Value Unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_reference_path` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'EU Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_regulatory_framework` SET TAGS ('dbx_eu_reference_path' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `internal_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `international_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'International Standard Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_compliance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mcl_unit` SET TAGS ('dbx_business_glossary_term' = 'MCL Unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'MCL Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mclg_unit` SET TAGS ('dbx_business_glossary_term' = 'MCLG Unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mclg_value` SET TAGS ('dbx_business_glossary_term' = 'MCLG Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reach_pfas_class_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'REACH PFAS Class Scope');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reach_pfas_class_scope_flag` SET TAGS ('dbx_eu_reference_path' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_url` SET TAGS ('dbx_business_glossary_term' = 'Regulation URL');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_category` SET TAGS ('dbx_business_glossary_term' = 'Requirement Category');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_title` SET TAGS ('dbx_business_glossary_term' = 'Requirement Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `superseded_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded Requirement Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `us_reference_path` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `us_regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'US Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `us_regulatory_framework` SET TAGS ('dbx_us_reference_path' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `wfd_surface_water_status_basis` SET TAGS ('dbx_business_glossary_term' = 'WFD Surface Water Status Basis');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `wfd_surface_water_status_basis` SET TAGS ('dbx_eu_reference_path' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `completed_by` SET TAGS ('dbx_business_glossary_term' = 'Completed By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_person` SET TAGS ('dbx_business_glossary_term' = 'Contact Person');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_person` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_of_fulfillment` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Fulfillment');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `recurrence_interval` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` SET TAGS ('dbx_subdomain' = 'enforcement_tracking');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_id` SET TAGS ('dbx_reconciled_depth' = '80');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_id` SET TAGS ('dbx_depth_tier' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `process_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Process Reading Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `affected_population` SET TAGS ('dbx_business_glossary_term' = 'Affected Population');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `agency_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `begin_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Begin Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `compliance_period_begin` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Begin');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `compliance_period_begin_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Begin');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `compliance_period_end` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period End');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `compliance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period End');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'CA Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'CA Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Violation End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `enforcement_action_pending` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Pending');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `enforcement_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Taken');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `health_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Based');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `health_based_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `health_based_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `health_effects_statement` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Statement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `health_effects_statement` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `health_effects_statement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `is_health_based` SET TAGS ('dbx_business_glossary_term' = 'Health-Based Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `is_health_based` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `is_health_based` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `is_public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Limit Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'MCL Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `population_affected` SET TAGS ('dbx_business_glossary_term' = 'Population Affected');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `public_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `public_notification_issued_date` SET TAGS ('dbx_business_glossary_term' = 'PN Issued Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulation_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulation Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_agency_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Notified Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `reported_to_epa_date` SET TAGS ('dbx_business_glossary_term' = 'Reported to EPA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `reported_to_state_date` SET TAGS ('dbx_business_glossary_term' = 'Reported to State');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `resolved_date` SET TAGS ('dbx_business_glossary_term' = 'Resolved Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `return_to_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Compliance Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `rtc_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Compliance Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `sdwis_violation_number` SET TAGS ('dbx_business_glossary_term' = 'SDWIS Violation ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_number` SET TAGS ('dbx_business_glossary_term' = 'Violation Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_subdomain' = 'enforcement_tracking');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Violation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'issued|under_review|response_submitted|in_negotiation|resolved|closed');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_summary` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'notice_of_violation|administrative_order|consent_order|compliance_schedule|civil_penalty|criminal_referral');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `appeal_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `board_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Board Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `civil_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Civil Penalty Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `civil_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `compliance_schedule_final_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Final Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `compliance_schedule_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `issuing_agency_region` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Region or District');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Assigned');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_firm_name` SET TAGS ('dbx_business_glossary_term' = 'External Legal Firm Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_firm_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `penalty_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Paid Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `penalty_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `penalty_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `public_notice_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'compliance_achieved|consent_order_executed|penalty_paid|dismissed|under_appeal');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `sep_description` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Environmental Project (SEP) Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `sep_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Environmental Project (SEP) Estimated Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `sep_estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `supplemental_environmental_project_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Environmental Project (SEP) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_subdomain' = 'enforcement_tracking');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `corrective_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Scheduled Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspecting_agency` SET TAGS ('dbx_business_glossary_term' = 'Inspecting Agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_report_received_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_report_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_report_status` SET TAGS ('dbx_value_regex' = 'draft|final|under_review|accepted|disputed');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|report_pending|closed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Inspector Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Inspector Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_title` SET TAGS ('dbx_business_glossary_term' = 'Inspector Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `significant_deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Classification');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `significant_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `utility_representative_title` SET TAGS ('dbx_business_glossary_term' = 'Utility Representative Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `violation_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Identified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'enforcement_tracking');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `original_submission_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original Submission Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `acknowledgment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `acknowledgment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_comments` SET TAGS ('dbx_business_glossary_term' = 'Agency Comments');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_response_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_response_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_response_type` SET TAGS ('dbx_value_regex' = 'accepted|rejected|request_for_information|notice_of_violation|enforcement_action|no_response');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `exceedance_count` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `is_late_submission` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `noncompliance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Noncompliance Explanation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `public_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `resubmission_required` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_file_format` SET TAGS ('dbx_business_glossary_term' = 'Submission File Format');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_file_format` SET TAGS ('dbx_value_regex' = 'PDF|XML|CSV|Excel|paper|other');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_file_path` SET TAGS ('dbx_business_glossary_term' = 'Submission File Path');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'NetDMR|state_portal|email|paper|fax|hand_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|accepted|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_subdomain' = 'enforcement_tracking');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Regulatory Agency Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Main Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_business_glossary_term' = 'Agency Main Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-()]{10,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_short_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Short Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_short_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|dissolved');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_website_url` SET TAGS ('dbx_business_glossary_term' = 'Agency Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `business_hours` SET TAGS ('dbx_business_glossary_term' = 'Business Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `enforcement_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Authority Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `enforcement_authority_level` SET TAGS ('dbx_value_regex' = 'primary|delegated|advisory|none');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_directive_scope` SET TAGS ('dbx_business_glossary_term' = 'EU Directive Scope');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_member_state` SET TAGS ('dbx_business_glossary_term' = 'EU Member State');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_member_state_code` SET TAGS ('dbx_business_glossary_term' = 'EU Member State Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_reference_path` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'EU Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_regulatory_framework` SET TAGS ('dbx_eu_reference_path' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `inspection_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Months');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `inspection_frequency_typical` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Typical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `inspection_frequency_typical` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|as_needed|risk_based');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Geographic Area');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_value_regex' = 'federal|state|regional|local|international');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `notification_deadline_hours` SET TAGS ('dbx_business_glossary_term' = 'Notification Deadline Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `npdes_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Authority Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_id_legacy` SET TAGS ('dbx_business_glossary_term' = 'Parent Agency Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `pretreatment_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Authority Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primacy_agency_flag` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primacy_status` SET TAGS ('dbx_business_glossary_term' = 'Primacy Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primacy_status` SET TAGS ('dbx_value_regex' = 'primacy_agency|non_primacy|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-()]{10,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_frequency_default` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency Default');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_frequency_default` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|event_driven|as_required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_system_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting System Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_system_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_credentials_reference` SET TAGS ('dbx_business_glossary_term' = 'Submission Credentials Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_credentials_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_credentials_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_name` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `us_reference_path` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `us_regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'US Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `us_regulatory_framework` SET TAGS ('dbx_us_reference_path' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
