-- Schema for Domain: compliance | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`compliance` COMMENT 'Environmental, health, and safety (EHS) compliance management. Tracks permits (air, water, waste), regulatory inspections, incident reporting, corrective actions, environmental monitoring data, audit trails, training certifications (CDL, HAZWOPER), violation notices, and regulatory submissions (SWIS, CERCLA, state reports). Ensures adherence to EPA, OSHA, DOT, Clean Air Act, Clean Water Act, and state/local regulations. Supports ISO 14001 and ISO 45001 frameworks. Integrates with Enviance EHS and SAP EHS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`permit` (
    `permit_id` BIGINT COMMENT 'Unique identifier for the environmental or operational permit record. Primary key for the permit entity.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Permits often specify approved vendors for permitted activities (hazmat disposal, monitoring equipment). Procurement must verify vendor is permit-approved before issuing POs. Essential for regulatory ',
    `facility_id` BIGINT COMMENT 'Reference to the Waste Management facility or site to which this permit applies. Links the permit to the physical location where regulated activities occur.',
    `application_date` DATE COMMENT 'Date on which Waste Management submitted the permit application to the regulatory agency. Used to track processing timelines and compliance with timely renewal requirements.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the permitted capacity. Standardizes capacity reporting across different permit types and regulatory frameworks.. Valid values are `tons_per_day|tons_per_year|gallons_per_day|cubic_yards|million_gallons_per_day`',
    `compliance_officer_email` STRING COMMENT 'Email address of the compliance officer responsible for this permit. Used for regulatory correspondence and internal compliance tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `compliance_officer_name` STRING COMMENT 'Name of the Waste Management employee responsible for ensuring compliance with this permit. Primary point of contact for regulatory agency communications.',
    `compliance_officer_phone` STRING COMMENT 'Phone number of the compliance officer responsible for this permit. Enables direct communication with the regulatory agency and internal stakeholders.',
    `conditions` STRING COMMENT 'Specific conditions, limitations, and operational requirements imposed by the regulatory agency as part of the permit. Includes monitoring frequencies, reporting obligations, and operational constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the Enviance EHS or SAP EHS system. Used for audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date on which the permit becomes legally binding and the facility is authorized to conduct the permitted activities. Marks the start of the permit term.',
    `epa_id_number` STRING COMMENT 'Unique EPA identification number assigned to the facility for tracking purposes under federal environmental programs. Required for RCRA hazardous waste facilities and other federally regulated sites.',
    `expiration_date` DATE COMMENT 'Date on which the permit expires and the facility must cease permitted activities unless a renewal or extension is granted. Nullable for permits with indefinite terms subject to periodic review.',
    `financial_assurance_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of financial assurance required by the permit. Represents the estimated cost of closure, post-closure care, and corrective action.',
    `financial_assurance_required` BOOLEAN COMMENT 'Indicates whether the permit requires financial assurance instruments (bonds, letters of credit, trust funds) to ensure closure and post-closure care funding. Common for landfill and TSDF permits.',
    `financial_assurance_type` STRING COMMENT 'Type of financial assurance instrument used to meet the permit requirement. Determines the mechanism by which closure and post-closure funds are secured.. Valid values are `surety_bond|letter_of_credit|trust_fund|insurance|corporate_guarantee`',
    `inspection_frequency` STRING COMMENT 'Frequency at which the regulatory agency conducts inspections of the permitted facility. Determines the cadence of regulatory oversight and compliance verification.. Valid values are `weekly|monthly|quarterly|annually|as_required`',
    `issue_date` DATE COMMENT 'Date on which the regulatory agency officially issued the permit. May differ from the effective date if the permit is issued in advance of the authorized activity start date.',
    `issuing_agency` STRING COMMENT 'Name of the regulatory authority that issued the permit. May be federal (EPA), state (Department of Environmental Quality), or local (Local Enforcement Agency, LEA).',
    `issuing_agency_jurisdiction` STRING COMMENT 'Jurisdictional level of the issuing regulatory agency. Determines the hierarchy of regulatory oversight and appeal processes.. Valid values are `federal|state|local`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection conducted by the issuing agency. Used to track inspection history and anticipate future inspections.',
    `last_violation_date` DATE COMMENT 'Date of the most recent violation or notice of non-compliance issued against this permit. Nullable if no violations have occurred.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this permit record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was last updated in the Enviance EHS or SAP EHS system. Used for audit trail and change tracking.',
    `monitoring_requirements` STRING COMMENT 'Description of the environmental monitoring and testing requirements mandated by the permit. Includes parameters to be monitored, sampling frequencies, and analytical methods.',
    `next_inspection_date` DATE COMMENT 'Anticipated date of the next regulatory inspection. May be scheduled by the agency or estimated based on historical inspection frequency.',
    `permit_number` STRING COMMENT 'Official permit number assigned by the issuing regulatory agency. This is the externally-known identifier used in all regulatory correspondence and compliance reporting.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit. Indicates whether the permit is in force, awaiting approval, or has been terminated or suspended by the regulatory authority.. Valid values are `active|pending|expired|suspended|revoked|under_renewal`',
    `permit_tier` STRING COMMENT 'Regulatory classification of the permit based on the scale and environmental impact of the permitted activities. Major permits typically require more stringent monitoring and reporting.. Valid values are `tier_1|tier_2|tier_3|major|minor`',
    `permit_type` STRING COMMENT 'Classification of the permit based on the environmental or operational domain it regulates. Determines applicable regulatory framework and compliance requirements.. Valid values are `air_quality|water_discharge|solid_waste_facility|rcra_hazardous_waste|stormwater|land_use`',
    `permitted_activities` STRING COMMENT 'Detailed description of the activities authorized under this permit. May include waste acceptance types, treatment processes, discharge points, emission sources, or operational constraints.',
    `permitted_capacity` DECIMAL(18,2) COMMENT 'Maximum operational capacity authorized by the permit. Units vary by permit type: TPD (Tons Per Day) for waste facilities, gallons per day for water discharge, tons per year for air emissions.',
    `public_notice_date` DATE COMMENT 'Date on which public notice of the permit action was published. Marks the start of the public comment period.',
    `public_notice_required` BOOLEAN COMMENT 'Indicates whether the permit issuance, renewal, or modification requires public notice and comment period. Common for major permits and significant permit modifications.',
    `regulatory_program` STRING COMMENT 'Name of the specific regulatory program under which the permit is issued. Examples include RCRA Subtitle C, RCRA Subtitle D, Title V Operating Permit, NPDES, or state-specific programs.',
    `renewal_due_date` DATE COMMENT 'Date by which the permit renewal application must be submitted to the regulatory agency to avoid lapse of authorization. Typically set months in advance of the expiration date.',
    `renewal_status` STRING COMMENT 'Current status of the permit renewal process. Tracks whether a renewal application is required, has been submitted, is under agency review, or has been decided.. Valid values are `not_required|pending_submission|submitted|under_review|approved|denied`',
    `reporting_frequency` STRING COMMENT 'Frequency at which compliance reports must be submitted to the regulatory agency. Determines the cadence of regulatory submissions and data collection.. Valid values are `daily|weekly|monthly|quarterly|annually|as_required`',
    `state_permit_number` STRING COMMENT 'State-specific permit identifier assigned by the state environmental quality department. Used for state-level tracking and reporting in addition to the primary permit number.',
    `subtype` STRING COMMENT 'Detailed classification within the permit type. Examples include Title V Operating Permit, NSR (New Source Review), NPDES (National Pollutant Discharge Elimination System), TSDF (Treatment Storage and Disposal Facility), or municipal solid waste landfill permit.',
    `violation_count` STRING COMMENT 'Total number of violations or notices of non-compliance issued against this permit since its effective date. Used to track compliance performance and regulatory risk.',
    CONSTRAINT pk_permit PRIMARY KEY(`permit_id`)
) COMMENT 'Master record for all environmental and operational permits held by Waste Management facilities and operations. Covers air quality permits (Title V, NSR), water discharge permits (NPDES), solid waste facility permits, RCRA hazardous waste permits, stormwater permits, and land use permits. Tracks permit number, issuing regulatory agency (EPA, state DEQ, LEA), permit type, facility/site association, effective and expiration dates, permitted limits and conditions, renewal status, and permit tier classification. Authoritative SSOT for all regulatory permit identities. Sourced from Enviance EHS and SAP EHS modules.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`permit_condition` (
    `permit_condition_id` BIGINT COMMENT 'Unique identifier for the permit condition. Primary key.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Permit conditions specify emission limits for individual sources (e.g., Flare 001 shall not exceed 500 lbs/hr NOx). Compliance tracking and deviation reporting require linking conditions to specific',
    `permit_id` BIGINT COMMENT 'Reference to the parent permit to which this condition is attached. Links to the permit master entity.',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: Permit conditions frequently reference specific materials with usage limits (e.g., max 500 gallons solvent X/month). Procurement must check permit limits before ordering regulated materials to preve',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Permit conditions implement specific regulatory requirements (e.g., a permit condition limiting NOx emissions implements a Clean Air Act requirement). This FK replaces the denormalized regulatory_cita',
    `averaging_period` STRING COMMENT 'The time period over which the limit is calculated or averaged (e.g., hourly, daily, monthly, annual, 30-day rolling). Null for instantaneous limits.',
    `compliance_schedule` STRING COMMENT 'Description of any phased compliance schedule or milestone dates specified in the condition (e.g., interim limits, construction deadlines, operational milestones).',
    `compliance_status` STRING COMMENT 'Current compliance status of this condition based on the most recent monitoring or inspection. Updated as monitoring data is received.. Valid values are `compliant|non_compliant|pending_verification|not_applicable|under_review`',
    `condition_category` STRING COMMENT 'Broad environmental or operational category to which the condition applies. Used for grouping and reporting. [ENUM-REF-CANDIDATE: air_quality|water_quality|waste_management|hazardous_materials|noise|odor|safety|operational|administrative — 9 candidates stripped; promote to reference product]',
    `condition_description` STRING COMMENT 'Full text description of the permit condition as written in the permit document. Specifies the enforceable requirement in detail.',
    `condition_number` STRING COMMENT 'The official condition number or identifier as specified in the permit document. Used for regulatory citation and tracking.',
    `condition_type` STRING COMMENT 'Classification of the permit condition by regulatory purpose. Determines the nature of the enforceable requirement. [ENUM-REF-CANDIDATE: emission_limit|discharge_limit|operational_restriction|monitoring_requirement|reporting_requirement|compliance_schedule|record_keeping|best_management_practice — 8 candidates stripped; promote to reference product]',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is currently required for this condition due to a violation, deviation, or non-compliance event.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this permit condition record was first created in the system. Audit trail field.',
    `deviation_threshold` DECIMAL(18,2) COMMENT 'The numeric threshold at which a deviation or exceedance must be reported or triggers corrective action. May differ from the limit_value.',
    `deviation_threshold_unit` STRING COMMENT 'Unit of measure for the deviation threshold. Required when deviation_threshold is populated.',
    `effective_date` DATE COMMENT 'The date on which this permit condition becomes enforceable. May differ from the permit effective date if the condition has a delayed or phased implementation.',
    `enforcement_priority` STRING COMMENT 'The regulatory enforcement priority level assigned to this condition. High-priority conditions receive heightened scrutiny and faster enforcement response.. Valid values are `high|medium|low`',
    `expiration_date` DATE COMMENT 'The date on which this condition ceases to be enforceable. Null if the condition remains in effect for the life of the permit.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the condition is currently active and enforceable. False if the condition has been superseded, suspended, or expired.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether this condition is designated as critical or high-priority for compliance tracking. Violations of critical conditions may trigger immediate enforcement action.',
    `last_compliance_check_date` DATE COMMENT 'The date of the most recent compliance verification, monitoring event, or inspection for this condition.',
    `last_violation_date` DATE COMMENT 'The date of the most recent violation or exceedance of this condition. Null if no violations have occurred.',
    `limit_type` STRING COMMENT 'Specifies whether the limit is a maximum allowable value, minimum required value, range, or time-averaged value. Defines how compliance is measured.. Valid values are `maximum|minimum|range|average|instantaneous|rolling_average`',
    `limit_unit_of_measure` STRING COMMENT 'The unit of measure for the limit value (e.g., ppm, mg/L, tons per day, decibels, cubic meters per hour). Required when limit_value is populated.',
    `limit_value` DECIMAL(18,2) COMMENT 'The numeric threshold, limit, or target value specified in the condition (e.g., emission rate, discharge concentration, operational parameter). Null if the condition is qualitative.',
    `modified_by` STRING COMMENT 'The user or system account that last modified this permit condition record. Audit trail field.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this permit condition record was last modified. Audit trail field.',
    `monitoring_frequency` STRING COMMENT 'How often monitoring or measurement must be performed (e.g., continuous, daily, weekly, monthly, quarterly, annually, per event).',
    `monitoring_method` STRING COMMENT 'The required method, protocol, or technology for monitoring compliance with this condition (e.g., EPA Method 9, continuous emission monitoring system, grab sampling, visual inspection).',
    `next_compliance_check_date` DATE COMMENT 'The scheduled date for the next compliance verification, monitoring event, or inspection for this condition. Used for proactive compliance management.',
    `notes` STRING COMMENT 'Free-text field for additional context, clarifications, or operational notes related to this permit condition. Used for internal compliance management.',
    `regulatory_citation` STRING COMMENT 'The specific regulation, statute, or code section that mandates this condition (e.g., 40 CFR 258.40, Clean Air Act Section 112). Provides legal basis for enforcement.',
    `reporting_deadline_days` STRING COMMENT 'Number of days after the monitoring period or event by which the report must be submitted. Null if no specific deadline is defined.',
    `reporting_frequency` STRING COMMENT 'How often compliance data or monitoring results must be reported to the regulatory authority (e.g., monthly, quarterly, annually, upon exceedance).',
    `responsible_party` STRING COMMENT 'The internal department, role, or individual responsible for ensuring compliance with this condition (e.g., Environmental Manager, Operations Supervisor, EHS Coordinator).',
    `violation_count` STRING COMMENT 'The cumulative number of violations or exceedances recorded for this condition since the permit was issued. Used for enforcement trend analysis.',
    `created_by` STRING COMMENT 'The user or system account that created this permit condition record. Audit trail field.',
    CONSTRAINT pk_permit_condition PRIMARY KEY(`permit_condition_id`)
) COMMENT 'Individual enforceable conditions and limitations attached to a specific permit. Each permit may carry dozens of conditions specifying emission limits, discharge thresholds, operational restrictions, monitoring frequencies, reporting deadlines, and compliance schedules. Tracks condition number, regulatory citation, limit value and unit of measure, monitoring method, deviation threshold, and whether the condition is currently active. Enables condition-level compliance tracking and violation detection. Child entity of permit.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement record. Primary key.',
    `applicability_scope` STRING COMMENT 'Describes the scope of operations, facility types, waste streams, or activities to which this regulatory requirement applies (e.g., All MSW landfills, Hazardous waste TSDFs, Commercial vehicle operators with CDL, MRF operations handling recyclables).',
    `citation_number` STRING COMMENT 'The official citation or reference number of the regulation (e.g., 40 CFR 258.40, 29 CFR 1910.120, 49 CFR 172.101). This is the externally-known unique identifier for the regulatory requirement.',
    `compliance_frequency` STRING COMMENT 'The frequency at which compliance with this requirement must be demonstrated or reported (e.g., Annual, Quarterly, Continuous, Event-Driven). [ENUM-REF-CANDIDATE: One-Time|Daily|Weekly|Monthly|Quarterly|Semi-Annual|Annual|Biennial|Event-Driven|Continuous — 10 candidates stripped; promote to reference product]',
    `compliance_obligation_summary` STRING COMMENT 'A concise summary of the key compliance obligations imposed by this requirement, written for operational and compliance teams.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory requirement record was first created in the system.',
    `documentation_required` BOOLEAN COMMENT 'Indicates whether this requirement mandates the creation and retention of specific documentation or records (True/False).',
    `effective_date` DATE COMMENT 'The date on which this regulatory requirement became or will become legally effective and enforceable.',
    `expiration_date` DATE COMMENT 'The date on which this regulatory requirement expires or is superseded, if applicable. Null for requirements with no defined expiration.',
    `facility_type_applicability` STRING COMMENT 'The specific facility types to which this requirement applies (e.g., Landfill, MRF, Transfer Station, WTE Facility, TSDF, Fleet Maintenance Facility). Pipe-separated list if multiple types apply.',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether this requirement mandates periodic inspections by regulatory authorities or third parties (True/False).',
    `internal_policy_reference` STRING COMMENT 'Reference to the internal company policy, procedure, or standard operating procedure (SOP) that implements this regulatory requirement.',
    `iso_clause_reference` STRING COMMENT 'The specific ISO 14001 or ISO 45001 clause or requirement that this regulatory requirement supports or maps to, if applicable.',
    `jurisdiction` STRING COMMENT 'The jurisdictional level at which this regulatory requirement applies (Federal, State, Local, or International).. Valid values are `Federal|State|Local|International`',
    `jurisdiction_geography` STRING COMMENT 'The specific geographic area or political subdivision where this requirement applies (e.g., USA, California, Harris County). Uses 3-letter country codes for national jurisdictions.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'The maximum monetary penalty amount (in USD) that can be assessed for a single violation of this requirement, if defined by the regulation.',
    `monitoring_required` BOOLEAN COMMENT 'Indicates whether this requirement mandates ongoing environmental or operational monitoring (e.g., air quality, groundwater, LFG, LEL) (True/False).',
    `operation_type_applicability` STRING COMMENT 'The operational activities to which this requirement applies (e.g., Collection, Hauling, Processing, Disposal, Treatment, Storage, Transport). Pipe-separated list if multiple operations apply.',
    `penalty_severity` STRING COMMENT 'The severity classification of penalties or enforcement actions associated with non-compliance with this requirement (Low, Medium, High, Critical).. Valid values are `Low|Medium|High|Critical`',
    `permit_required` BOOLEAN COMMENT 'Indicates whether this requirement mandates obtaining a specific permit or authorization (e.g., air permit, water discharge permit, waste handling permit) (True/False).',
    `regulation_title` STRING COMMENT 'The full official title or name of the regulation or regulatory requirement.',
    `regulatory_body` STRING COMMENT 'The governing body or agency that issued and enforces this regulatory requirement (e.g., EPA, OSHA, DOT, State Environmental Quality Department, Local Solid Waste Authority). [ENUM-REF-CANDIDATE: EPA|OSHA|DOT|State Environmental Agency|Local Enforcement Agency|SWANA|NWRA|ISO — 8 candidates stripped; promote to reference product]',
    `regulatory_framework` STRING COMMENT 'The overarching regulatory framework or act under which this requirement falls (e.g., RCRA, CERCLA, Clean Air Act, Clean Water Act, ISO 14001, ISO 45001). [ENUM-REF-CANDIDATE: RCRA|CERCLA|CAA|CWA|TSCA|OSHA|DOT HAZMAT|ISO 14001|ISO 45001|State Solid Waste Code — 10 candidates stripped; promote to reference product]',
    `regulatory_requirement_description` STRING COMMENT 'A detailed textual description of the regulatory requirement, including the specific obligations, standards, or actions mandated by the regulation.',
    `regulatory_requirement_status` STRING COMMENT 'The current lifecycle status of this regulatory requirement (Active, Proposed, Superseded, Repealed, Under Review, Pending).. Valid values are `Active|Proposed|Superseded|Repealed|Under Review|Pending`',
    `reporting_deadline_days` STRING COMMENT 'The number of days within which a report or submission must be filed after the triggering event or period end, if applicable.',
    `reporting_required` BOOLEAN COMMENT 'Indicates whether this requirement mandates periodic or event-driven reporting to regulatory authorities (e.g., SWIS submissions, CERCLA notifications, incident reports) (True/False).',
    `requirement_type` STRING COMMENT 'The category or type of compliance obligation imposed by this requirement (e.g., Permit, Inspection, Monitoring, Reporting, Training, Record Keeping, Operational Standard, Emission Limit). [ENUM-REF-CANDIDATE: Permit|Inspection|Monitoring|Reporting|Training|Record Keeping|Operational Standard|Design Standard|Emission Limit|Discharge Limit — 10 candidates stripped; promote to reference product]',
    `revision_date` DATE COMMENT 'The date of the most recent revision or amendment to this regulatory requirement.',
    `risk_level` STRING COMMENT 'The assessed risk level to the organization if this requirement is not met (Low, Medium, High, Critical), based on potential operational, financial, legal, and reputational impact.. Valid values are `Low|Medium|High|Critical`',
    `source_document_url` STRING COMMENT 'The web URL or hyperlink to the official source document or regulatory text (e.g., Federal Register, EPA website, state regulatory portal).',
    `training_required` BOOLEAN COMMENT 'Indicates whether this requirement mandates specific training or certification for personnel (e.g., CDL, HAZWOPER, OSHA 40-hour) (True/False).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory requirement record was last updated or modified in the system.',
    `waste_stream_applicability` STRING COMMENT 'The waste stream categories to which this requirement applies (e.g., MSW, C&D, Hazardous Waste, Recyclables, LFG, Leachate). Pipe-separated list if multiple streams apply.',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Reference catalog of applicable federal, state, and local regulatory requirements governing Waste Management operations. Covers EPA regulations (RCRA, CERCLA, CAA, CWA), OSHA standards (29 CFR 1910, 1926), DOT hazmat transport rules (49 CFR), state solid waste codes, and ISO 14001/45001 framework clauses. Each record captures the regulation citation, regulatory body, applicability scope (facility type, waste stream, operation type), effective date, and compliance obligation type. Used to map permits, inspections, and corrective actions to specific regulatory drivers.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` (
    `compliance_inspection_id` BIGINT COMMENT 'Unique identifier for the compliance inspection record. Primary key for the compliance inspection entity.',
    `audit_program_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_program. Business justification: Internal compliance audits are conducted under structured audit programs (ISO 14001, ISO 45001, corporate EHS programs). This FK links inspections to their governing audit program, enabling program ef',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility, site, or operational location where the inspection was conducted. Links to the facility master data.',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: EPA GHGRP compliance inspections verify GHG inventory data quality, calculation methods, and supporting documentation. Inspectors review the facilitys inventory to ensure regulatory compliance. Links',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Inspections evaluate vendor-provided services (waste hauler performance, TSDF compliance). Findings feed vendor performance ratings and re-qualification decisions. Critical for vendor management and c',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Inspections are performed by internal employees. Tracking inspector_employee_id enables workload balancing, qualification verification, audit trail compliance, and performance management for inspectio',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Compliance inspections verify adherence to permit conditions. While inspections may review multiple permits, each inspection record typically focuses on a primary permit. This FK replaces the denormal',
    `actual_inspection_date` DATE COMMENT 'Date on which the inspection was actually conducted. This is the primary business event date for the inspection.',
    `checklist_used` STRING COMMENT 'Name or identifier of the standardized inspection checklist or audit protocol used during the inspection. Ensures consistency and completeness of inspection coverage.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions are required as a result of the inspection findings. True if any findings require remediation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the Enviance EHS system. Audit trail field for data governance.',
    `critical_findings_count` STRING COMMENT 'Number of findings classified as critical or high-severity, requiring immediate corrective action. Subset of total findings.',
    `end_time` TIMESTAMP COMMENT 'Timestamp when the inspection concluded on-site. Used to calculate inspection duration and for audit trail purposes.',
    `facility_epa_number` STRING COMMENT 'EPA-assigned unique 12-character identifier for the facility, required for RCRA-regulated facilities. Format: 2-letter state code + 9-digit number.. Valid values are `^[A-Z]{2}[0-9]{9}$`',
    `follow_up_due_date` DATE COMMENT 'Date by which corrective actions must be completed and documented, or by which a follow-up inspection is required. Null if no follow-up is needed.',
    `frequency_requirement` STRING COMMENT 'Required frequency for this type of inspection based on regulatory requirements or internal policy. Supports compliance calendar planning.. Valid values are `annual|semi_annual|quarterly|monthly|as_needed|triggered`',
    `inspecting_authority` STRING COMMENT 'Name of the regulatory agency, local enforcement body, or designation of internal audit team conducting the inspection (e.g., U.S. EPA Region 5, California DTSC, Internal EHS Audit Team).',
    `inspection_number` STRING COMMENT 'Externally-known unique business identifier for the inspection, typically assigned by the inspecting authority or internal audit system. Format varies by authority (e.g., EPA-2024001234, OSHA-INS-456789).. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `inspection_result` STRING COMMENT 'Overall outcome of the inspection. Indicates whether the facility passed, failed, or requires follow-up action based on findings.. Valid values are `pass|fail|conditional_pass|no_violations_observed|violations_cited|follow_up_required`',
    `inspection_scope` STRING COMMENT 'Detailed description of the areas, processes, permits, or compliance requirements covered during the inspection. Defines the boundaries and focus areas of the inspection activity.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection. Tracks progression from scheduling through completion and closure, including any administrative states.. Valid values are `scheduled|in_progress|completed|report_pending|closed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection based on the regulatory framework or internal audit program. Determines the scope, checklist, and compliance requirements evaluated.. Valid values are `EPA Compliance Evaluation|OSHA Safety Inspection|DOT Vehicle Inspection|LEA Solid Waste Inspection|Internal EHS Audit|RCRA Facility Assessment`',
    `inspector_badge_number` STRING COMMENT 'Official badge or credential number of the external regulatory inspector. Applicable only to government agency inspections; null for internal audits.',
    `iso_14001_audit` BOOLEAN COMMENT 'Indicates whether this inspection was conducted as part of an ISO 14001 Environmental Management System audit or certification process.',
    `iso_45001_audit` BOOLEAN COMMENT 'Indicates whether this inspection was conducted as part of an ISO 45001 Occupational Health and Safety Management System audit or certification process.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last updated in the Enviance EHS system. Audit trail field for data governance.',
    `major_findings_count` STRING COMMENT 'Number of findings classified as major or medium-severity, requiring corrective action within a defined timeframe. Subset of total findings.',
    `minor_findings_count` STRING COMMENT 'Number of findings classified as minor or low-severity, requiring corrective action but not posing immediate risk. Subset of total findings.',
    `next_scheduled_inspection_date` DATE COMMENT 'Date on which the next inspection of this type is scheduled for this facility, based on regulatory frequency requirements or internal audit schedule.',
    `notes` STRING COMMENT 'Free-text field for additional observations, context, or comments recorded by the inspector or audit team during the inspection. May include operational observations, best practices noted, or areas of concern.',
    `notice_of_violation_issued` BOOLEAN COMMENT 'Indicates whether a formal Notice of Violation was issued by the regulatory authority as a result of the inspection findings.',
    `number_of_findings` STRING COMMENT 'Total count of deficiencies, violations, observations, or non-conformances identified during the inspection. Zero indicates no issues found.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed as a result of violations found during the inspection, in USD. Null if no penalty was assessed.',
    `regulatory_program` STRING COMMENT 'Primary federal, state, or local regulatory program under which the inspection was conducted. Determines applicable compliance requirements and enforcement authority. [ENUM-REF-CANDIDATE: RCRA|Clean Air Act|Clean Water Act|CERCLA|TSCA|EPCRA|OSHA|DOT|State Solid Waste|Local Ordinance — 10 candidates stripped; promote to reference product]',
    `report_url` STRING COMMENT 'URL or file path to the official inspection report document stored in the document management system. Provides access to the full inspection findings and recommendations.',
    `scheduled_date` DATE COMMENT 'Date on which the inspection was originally scheduled to occur. May differ from actual inspection date if rescheduled.',
    `source_system` STRING COMMENT 'Name of the operational system from which this inspection record was sourced. Primarily Enviance EHS, with some records from SAP EHS or manual entry.. Valid values are `Enviance EHS|SAP EHS|Manual Entry`',
    `source_system_code` STRING COMMENT 'Unique identifier of this inspection record in the source operational system. Enables traceability and reconciliation with source data.',
    `start_time` TIMESTAMP COMMENT 'Timestamp when the inspection commenced on-site. Used to calculate inspection duration and for audit trail purposes.',
    `violations_cited` STRING COMMENT 'Comma-separated list or detailed description of specific regulatory violations, permit conditions, or standards cited during the inspection. References specific CFR sections, permit conditions, or internal policy violations.',
    CONSTRAINT pk_compliance_inspection PRIMARY KEY(`compliance_inspection_id`)
) COMMENT 'Records of regulatory inspections and internal compliance audits conducted at Waste Management facilities and operations. Covers EPA/state agency inspections, OSHA workplace safety inspections, DOT vehicle and driver inspections, LEA solid waste inspections, and internal EHS audits. Tracks inspection ID, inspection type, inspecting authority or internal auditor, facility/site inspected, scheduled and actual inspection date, inspection scope, overall result (pass/fail/conditional), number of findings, and follow-up due date. Sourced from Enviance EHS. Central operational record for all compliance verification activities.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`inspection_finding` (
    `inspection_finding_id` BIGINT COMMENT 'Unique identifier for the inspection finding record. Primary key.',
    `compliance_inspection_id` BIGINT COMMENT 'Reference to the parent inspection event during which this finding was identified. Links to the inspection record.',
    `corrective_action_id` BIGINT COMMENT 'Reference to the corrective action record initiated to address this finding. Links to the corrective action management workflow.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the specific equipment or asset involved in the finding, if applicable. Links to the asset management system for tracking equipment-related compliance issues.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Findings cite specific permit conditions that were violated (e.g., exceeded emission limit, missed monitoring deadline). This FK links findings to the specific permit condition, enabling condition-lev',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Inspection findings often relate to permit condition violations. This FK links findings to the permit that was violated, enabling permit-centric compliance tracking and violation trend analysis.',
    `previous_finding_inspection_finding_id` BIGINT COMMENT 'Reference to the prior finding record if this is a repeat finding. Enables tracking of recurrence patterns and corrective action effectiveness.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Findings cite regulatory requirements (CFR citations, state regulations). This FK replaces the denormalized regulatory_citation STRING field with a structured relationship to the regulatory_requiremen',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Findings assign corrective action responsibility to specific employees. Linking enables accountability tracking, performance reviews tied to compliance outcomes, and workload analysis for corrective a',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Critical inspection findings may escalate to formal violation notices issued by regulatory agencies. This FK links findings to the resulting violation notice, enabling escalation tracking and enforcem',
    `closure_date` DATE COMMENT 'Date on which the finding was officially closed after verification of corrective action completion and effectiveness. Null if finding remains open.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a formal corrective action plan is required to address this finding. True for violations and significant non-conformances; false for informational observations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this finding record was first created in the system. Part of audit trail.',
    `due_date` DATE COMMENT 'Target date by which the finding must be resolved or corrective action completed. Typically set based on severity and regulatory requirements.',
    `environmental_impact` STRING COMMENT 'Assessment of the actual or potential environmental impact of the condition identified in the finding. None indicates no environmental consequence; low indicates minimal impact; medium indicates localized impact; high indicates significant impact; severe indicates widespread or long-term environmental harm.. Valid values are `none|low|medium|high|severe`',
    `facility_area` STRING COMMENT 'Specific location, department, or operational area within the facility where the finding was identified (e.g., Landfill Cell 3, MRF Sorting Line, Fleet Maintenance Bay, Leachate Collection System). Enables spatial tracking and accountability.',
    `finding_number` STRING COMMENT 'Business identifier for the finding, typically a sequential or hierarchical number within the parent inspection (e.g., F-001, 1.1, 2.3). Used for external reference and reporting.',
    `finding_type` STRING COMMENT 'Classification of the finding based on its regulatory or operational significance. Violation indicates a regulatory breach; observation is a noted condition without immediate compliance impact; recommendation suggests improvement; non-conformance indicates deviation from internal standards; opportunity for improvement highlights process enhancement areas; best practice recognizes exemplary performance.. Valid values are `violation|observation|recommendation|non_conformance|opportunity_for_improvement|best_practice`',
    `health_safety_impact` STRING COMMENT 'Assessment of the actual or potential health and safety impact of the condition identified in the finding. None indicates no health/safety consequence; low indicates minimal risk; medium indicates manageable risk; high indicates significant risk; severe indicates imminent danger.. Valid values are `none|low|medium|high|severe`',
    `inspection_finding_description` STRING COMMENT 'Detailed narrative description of the deficiency, observation, or condition identified during the inspection. Includes context, evidence observed, and specific circumstances. Critical for understanding the nature and scope of the finding.',
    `inspection_finding_status` STRING COMMENT 'Current lifecycle status of the finding. Open indicates newly identified and not yet addressed; in progress indicates corrective action underway; pending verification indicates action completed awaiting validation; closed indicates verified resolution; deferred indicates postponed resolution with documented justification.. Valid values are `open|in_progress|pending_verification|closed|deferred`',
    `inspector_name` STRING COMMENT 'Name of the inspector or auditor who identified and documented this finding. May be an internal auditor, regulatory agency inspector, or third-party auditor.',
    `inspector_organization` STRING COMMENT 'Organization or agency the inspector represents (e.g., EPA Region 5, State DEQ, Internal EHS Team, Third-Party Auditor). Provides context for the findings authority and follow-up requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this finding record was last updated. Tracks the most recent change to the record for audit and data quality purposes.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the finding. May include inspector observations, management responses, or follow-up actions.',
    `notification_date` DATE COMMENT 'Date on which formal notification of the finding was sent. Used to track compliance with notification timelines.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether formal notification of this finding has been sent to responsible parties, management, or regulatory authorities as required.',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the potential penalty amount. Waste Management primarily operates in USD.. Valid values are `USD`',
    `photographic_evidence_url` STRING COMMENT 'Reference URL or file path to photographic or video evidence documenting the finding. Supports objective verification and audit trail.',
    `potential_penalty_amount` DECIMAL(18,2) COMMENT 'Estimated or assessed monetary penalty associated with this finding if it results in a regulatory violation. Used for financial risk assessment and reserve planning.',
    `regulation_category` STRING COMMENT 'High-level categorization of the regulatory domain to which this finding pertains. Enables grouping and analysis of findings by compliance area. [ENUM-REF-CANDIDATE: air_quality|water_quality|waste_management|hazardous_materials|occupational_safety|environmental_monitoring|permit_compliance|reporting|other — 9 candidates stripped; promote to reference product]',
    `regulatory_citation` STRING COMMENT 'Specific regulatory code, statute, or standard section violated or referenced by this finding (e.g., 40 CFR 258.21, OSHA 1910.134, RCRA Subtitle D). Provides legal traceability and compliance context.',
    `repeat_finding` BOOLEAN COMMENT 'Indicates whether this finding is a recurrence of a previously identified and closed issue. Repeat findings may trigger escalated enforcement or management review.',
    `root_cause` STRING COMMENT 'Documented root cause of the finding as determined through root cause analysis. Identifies underlying systemic issues rather than symptoms.',
    `root_cause_analysis_completed` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis has been conducted for this finding. Typically required for major or critical findings to prevent recurrence.',
    `severity` STRING COMMENT 'Severity classification of the finding. Critical indicates immediate threat to health, safety, or environment requiring urgent action; major indicates significant regulatory or operational risk; moderate indicates manageable risk with defined timeline; minor indicates low-impact issue; informational indicates no immediate action required.. Valid values are `critical|major|moderate|minor|informational`',
    `verification_date` DATE COMMENT 'Date on which the finding closure was verified. May differ from closure date if verification occurs after corrective action completion.',
    `verification_method` STRING COMMENT 'Method used to verify closure of the finding (e.g., follow-up inspection, document review, photographic evidence, testing results). Documents the evidence basis for closure.',
    `verified_by` STRING COMMENT 'Name or identifier of the individual who verified the closure of the finding. Provides accountability for closure decisions.',
    CONSTRAINT pk_inspection_finding PRIMARY KEY(`inspection_finding_id`)
) COMMENT 'Individual findings, deficiencies, and observations identified during a regulatory inspection or internal audit. Each finding is linked to a parent inspection record and captures the finding type (violation, observation, recommendation), regulatory citation violated, description of the deficiency, severity classification, responsible facility area, and whether a corrective action has been initiated. Enables granular tracking of inspection outcomes and drives the corrective action workflow. Child entity of inspection.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`violation_notice` (
    `violation_notice_id` BIGINT COMMENT 'Unique identifier for the violation notice record. Primary key.',
    `compliance_inspection_id` BIGINT COMMENT 'Identifier of the regulatory inspection or audit that resulted in the violation notice, if applicable.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the violation occurred.',
    `incident_id` BIGINT COMMENT 'Identifier of the environmental, health, or safety incident that triggered the violation notice, if applicable.',
    `permit_id` BIGINT COMMENT 'Identifier of the environmental permit associated with the violation, if the violation relates to permit non-compliance.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Violation notices cite specific regulatory requirements that were violated. This FK replaces the denormalized regulatory_citation STRING field with a structured relationship, enabling requirement-leve',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Violations can be caused by vendor non-compliance (hauler delivered to non-permitted facility, contractor exceeded limits). Essential for vendor accountability, corrective action tracking, and contrac',
    `agency_office` STRING COMMENT 'Specific office, region, or district within the issuing agency responsible for the enforcement action.',
    `appeal_filed_date` DATE COMMENT 'Date on which the company filed a formal appeal or contest of the violation notice.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the company filed a formal appeal or contested the violation notice with the regulatory agency or administrative law body.',
    `appeal_outcome` STRING COMMENT 'Final outcome of the appeal process, if an appeal was filed.. Valid values are `upheld|overturned|modified|withdrawn|pending`',
    `corrective_action_required` STRING COMMENT 'Description of the corrective actions, remediation measures, or compliance steps required by the regulatory agency to resolve the violation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the violation notice record was first created in the system.',
    `facility_epa_number` STRING COMMENT 'EPA-assigned identification number for the facility, used for federal environmental compliance tracking.',
    `issuing_agency` STRING COMMENT 'Name of the regulatory agency that issued the violation notice (e.g., EPA, state environmental agency, OSHA, DOT, local enforcement agency).',
    `legal_counsel_assigned` STRING COMMENT 'Name of the internal or external legal counsel assigned to manage the violation notice and enforcement action.',
    `notes` STRING COMMENT 'Additional internal notes, comments, or context related to the violation notice, response strategy, or resolution process.',
    `notice_issued_date` DATE COMMENT 'Date on which the regulatory agency officially issued the notice of violation to the company.',
    `notice_number` STRING COMMENT 'Official notice number assigned by the issuing regulatory agency. This is the externally-known identifier for the enforcement action.',
    `notice_received_date` DATE COMMENT 'Date on which the company received the violation notice from the regulatory agency.',
    `notice_type` STRING COMMENT 'Classification of the enforcement action type issued by the regulatory agency.. Valid values are `notice_of_violation|administrative_order|consent_decree|civil_penalty|criminal_referral|warning_letter`',
    `penalty_assessed_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed by the regulatory agency for the violation, in USD.',
    `penalty_paid_amount` DECIMAL(18,2) COMMENT 'Actual monetary penalty amount paid by the company to the regulatory agency, in USD. May differ from assessed amount due to settlement or negotiation.',
    `penalty_payment_date` DATE COMMENT 'Date on which the penalty payment was made to the regulatory agency.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the violation notice is subject to public disclosure or has been publicly reported by the regulatory agency.',
    `regulatory_citation` STRING COMMENT 'Specific regulation, code section, or permit condition that was violated, as cited by the regulatory agency.',
    `regulatory_program` STRING COMMENT 'The regulatory program or statute under which the violation was cited (e.g., RCRA, Clean Air Act, Clean Water Act, OSHA, DOT).',
    `resolution_date` DATE COMMENT 'Date on which the violation notice was officially resolved, settled, or closed by the regulatory agency.',
    `response_due_date` DATE COMMENT 'Deadline by which the company must submit a formal response or corrective action plan to the regulatory agency.',
    `response_submitted_date` DATE COMMENT 'Date on which the company submitted its formal response or corrective action plan to the regulatory agency.',
    `responsible_party` STRING COMMENT 'Name or title of the internal party, department, or manager responsible for addressing the violation and implementing corrective actions.',
    `settlement_agreement_flag` BOOLEAN COMMENT 'Indicates whether the violation was resolved through a formal settlement agreement or consent decree with the regulatory agency.',
    `settlement_agreement_number` STRING COMMENT 'Official reference number or identifier for the settlement agreement or consent decree, if applicable.',
    `source_system` STRING COMMENT 'System of record from which the violation notice data was sourced.. Valid values are `enviance_ehs|sap_ehs|manual_entry`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the violation notice record was last updated in the system.',
    `violation_category` STRING COMMENT 'High-level classification of the violation type based on the environmental, health, or safety domain. [ENUM-REF-CANDIDATE: air_quality|water_quality|waste_management|hazardous_materials|occupational_safety|transportation|permit_compliance|reporting — 8 candidates stripped; promote to reference product]',
    `violation_date` DATE COMMENT 'Date on which the violation or non-compliance event occurred as documented by the regulatory agency.',
    `violation_description` STRING COMMENT 'Detailed narrative description of the violation, non-compliance event, or deficiency as documented in the notice.',
    `violation_severity` STRING COMMENT 'Severity level of the violation as assessed by the regulatory agency or internal EHS team.. Valid values are `minor|moderate|major|critical`',
    `violation_status` STRING COMMENT 'Current lifecycle status of the violation notice and enforcement action. [ENUM-REF-CANDIDATE: open|under_review|response_submitted|resolved|settled|appealed|closed — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_violation_notice PRIMARY KEY(`violation_notice_id`)
) COMMENT 'Formal notices of violation (NOV) and enforcement actions received from regulatory agencies including EPA, state environmental agencies, OSHA, and DOT. Tracks notice number, issuing agency, violation date, regulatory citation, facility and operation involved, violation description, penalty amount assessed, response deadline, settlement status, and final resolution. Distinct from inspection findings in that it represents an official agency-issued enforcement document with legal standing and potential financial liability. Sourced from Enviance EHS and SAP EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` (
    `regulatory_corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective or preventive action record. Primary key.',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_initiative. Business justification: Corrective actions from air quality violations may be fulfilled through carbon reduction initiatives (installing emission controls, fuel switching, process improvements). Links regulatory compliance o',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Corrective actions are triggered by inspection findings. This FK links corrective actions to the inspection that identified the deficiency, replacing the denormalized triggering_event_type/triggering_',
    `facility_id` BIGINT COMMENT 'Identifier of the facility (landfill, MRF, transfer station, WTE plant, TSDF) where the corrective or preventive action is being implemented.',
    `inspection_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.inspection_finding. Business justification: Corrective actions address specific inspection findings. This FK links corrective actions to the finding that triggered them, enabling finding-level CAPA tracking and closure verification. This comple',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Corrective actions may be required to restore permit compliance after violations. This FK links corrective actions to the permit that was violated, enabling permit-centric CAPA tracking and compliance',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Corrective actions require procurement of equipment, services, materials (install scrubber, engage remediation consultant). Tracks compliance-driven capital/operational spend and links regulatory obli',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Corrective actions require employee ownership for completion tracking. Linking supports performance management, workload planning, escalation workflows, and regulatory audit trails demonstrating indiv',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Regulatory corrective actions often require safety program modifications (updating procedures, enhancing training, adding controls). This link tracks which programs were updated in response to regulat',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Corrective actions are required by violation notices issued by regulatory agencies. This FK links corrective actions to the violation notice that mandated them, enabling enforcement action tracking an',
    `action_description` STRING COMMENT 'Detailed description of the corrective or preventive action required, including specific steps, procedures, or changes to be implemented.',
    `action_number` STRING COMMENT 'Business identifier for the corrective or preventive action, typically generated by the EHS system (Enviance) or SAP EHS module. Used for tracking and reporting.',
    `action_status` STRING COMMENT 'Current lifecycle status of the corrective or preventive action. Tracks progression from identification through closure.. Valid values are `open|in_progress|pending_verification|verified|closed|cancelled`',
    `action_title` STRING COMMENT 'Brief, descriptive title summarizing the corrective or preventive action.',
    `action_type` STRING COMMENT 'Indicates whether the action is corrective (addressing an existing nonconformity), preventive (addressing a potential nonconformity), or both.. Valid values are `corrective|preventive|both`',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective or preventive action was completed. Null if action is still open or in progress.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost in US dollars incurred to implement the corrective or preventive action. Null if action is not yet completed or costs have not been finalized.',
    `closure_date` DATE COMMENT 'Date when the corrective or preventive action was formally closed after successful verification. Null if action is not yet closed.',
    `closure_notes` STRING COMMENT 'Notes or comments documenting the closure of the action, including any final observations, lessons learned, or follow-up recommendations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective or preventive action record was first created in the system.',
    `environmental_impact_category` STRING COMMENT 'Category of environmental impact addressed by the action (e.g., air emissions, water discharge, waste management, soil contamination, noise, odor, landfill gas, leachate).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost in US dollars to implement the corrective or preventive action, including labor, materials, equipment, and contractor costs.',
    `external_reference_number` STRING COMMENT 'External reference number from regulatory agency correspondence, violation notice, or third-party audit report that this action addresses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective or preventive action record was last updated.',
    `management_review_date` DATE COMMENT 'Date when the corrective or preventive action was reviewed by management. Null if management review has not occurred or is not required.',
    `management_review_required` BOOLEAN COMMENT 'Indicates whether the corrective or preventive action requires formal management review before closure, typically for high-priority or high-cost actions.',
    `priority_level` STRING COMMENT 'Priority classification of the corrective or preventive action based on risk severity, regulatory urgency, and potential impact.. Valid values are `critical|high|medium|low`',
    `recurrence_risk` STRING COMMENT 'Assessment of the risk that the nonconformity or incident will recur after the corrective or preventive action is implemented.. Valid values are `high|medium|low|eliminated`',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency involved (e.g., EPA, OSHA, DOT, state environmental quality department, local enforcement agency) if the action was triggered by a regulatory event.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory citation, code section, or permit condition that the corrective or preventive action addresses (e.g., 40 CFR 258.21, OSHA 1910.120, permit condition 3.2.1).',
    `responsible_department` STRING COMMENT 'Department or functional area responsible for implementing the action (e.g., Operations, Maintenance, EHS, Fleet, Engineering).',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause analysis performed to identify the underlying cause of the nonconformity or potential nonconformity. May reference methodologies such as 5 Whys, Fishbone Diagram, or Fault Tree Analysis.',
    `safety_impact_category` STRING COMMENT 'Category of occupational health and safety impact addressed by the action (e.g., hazardous waste exposure, equipment safety, PPE compliance, confined space, fall protection, vehicle safety).',
    `source_system` STRING COMMENT 'System of record where the corrective or preventive action was originally created and managed (e.g., Enviance EHS, SAP EHS module, manual entry).. Valid values are `enviance_ehs|sap_ehs|manual_entry|other`',
    `target_completion_date` DATE COMMENT 'Planned or required date by which the corrective or preventive action must be completed. May be driven by regulatory deadlines or internal commitments.',
    `triggering_event_reference` STRING COMMENT 'Reference identifier to the source event that triggered this action (e.g., inspection ID, incident ID, audit finding ID, violation notice number). Enables traceability to the root cause.',
    `triggering_event_type` STRING COMMENT 'The type of event that initiated this corrective or preventive action (e.g., regulatory inspection, violation notice, environmental incident, internal audit finding, customer complaint, or proactive self-identification).. Valid values are `inspection|violation_notice|incident|audit|complaint|self_identified`',
    `verification_date` DATE COMMENT 'Date when the effectiveness of the corrective or preventive action was verified. Null if verification has not yet occurred.',
    `verification_method` STRING COMMENT 'Method used to verify the effectiveness of the corrective or preventive action (e.g., follow-up inspection, document review, testing, monitoring data analysis, management review).',
    `verification_status` STRING COMMENT 'Status of the verification process indicating whether the action has been verified as effective, ineffective, or is pending verification.. Valid values are `not_verified|verified_effective|verified_ineffective|pending_verification`',
    `verified_by_name` STRING COMMENT 'Name of the individual who verified the effectiveness of the corrective or preventive action.',
    CONSTRAINT pk_regulatory_corrective_action PRIMARY KEY(`regulatory_corrective_action_id`)
) COMMENT 'Corrective and preventive actions (CAPA) initiated in response to inspection findings, violation notices, incidents, or internal audit observations. Tracks action ID, triggering event reference, action type (corrective/preventive), description of required action, responsible party, target completion date, actual completion date, verification method, and closure status. Supports the full CAPA lifecycle from identification through verification and closure. Integrates with Enviance EHS CAPA module and SAP EHS. Supports ISO 14001 and ISO 45001 continual improvement requirements.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`ehs_incident` (
    `ehs_incident_id` BIGINT COMMENT 'Unique identifier for the EHS incident record. Primary key.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Incidents may be discovered during compliance inspections or internal audits. This FK links incidents to the inspection that identified them, supporting inspection follow-up and corrective action trac',
    `employee_id` BIGINT COMMENT 'Identifier of the employee involved in the incident if the injured party is a company employee. Null for contractors or third parties.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the incident occurred (landfill, MRF, transfer station, WTE plant, or administrative office).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Incidents frequently involve vendor personnel or equipment (contractor injury, vendor vehicle accident). Essential for vendor safety performance tracking, insurance claims, and vendor qualification de',
    `jha_id` BIGINT COMMENT 'Foreign key linking to safety.jha. Business justification: When incidents occur during tasks with JHAs, linking enables root cause analysis of whether JHA controls were adequate or followed. Essential for JHA effectiveness review and continuous improvement. R',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: EHS incidents (injuries, environmental releases, near-misses) may involve permit violations or occur during permitted activities. This FK links incidents to relevant permits, supporting permit complia',
    `regulatory_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_corrective_action. Business justification: Incidents trigger corrective and preventive actions (CAPA). This FK links incidents to the corrective actions taken to address root causes and prevent recurrence, enabling CAPA tracking and closure ve',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: EHS incidents should link to the safety program under which the incident occurred for program effectiveness tracking and continuous improvement. Enables analysis of which safety programs are preventin',
    `vehicle_id` BIGINT COMMENT 'Identifier of the fleet vehicle involved in the incident if the incident type is vehicle accident. Null if not a vehicle incident.',
    `body_part_affected` STRING COMMENT 'Specific body part(s) injured in the incident (e.g., left hand, lower back, eyes). Null if no personal injury occurred.',
    `corrective_action_completed_date` DATE COMMENT 'Actual date on which all corrective actions were verified as complete. Null if actions not yet complete.',
    `corrective_action_description` STRING COMMENT 'Summary of corrective actions identified to address root causes and prevent recurrence. Null if no corrective action required.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which corrective actions must be completed. Null if no corrective action required.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions were identified as necessary to prevent recurrence of the incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the incident record was first created in the EHS system.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the injured employee was unable to work as a result of the incident. Zero if no time lost. Used for OSHA DART rate calculation.',
    `days_of_job_transfer` STRING COMMENT 'Number of calendar days the injured employee was transferred to another job as a result of the incident. Zero if no transfer occurred.',
    `days_of_restricted_work` STRING COMMENT 'Number of calendar days the injured employee was on restricted or light duty as a result of the incident. Zero if no restriction. Used for OSHA DART rate calculation.',
    `environmental_media_affected` STRING COMMENT 'The environmental medium impacted by a release or spill incident. Applicable only to environmental release incidents.. Valid values are `air|water|soil|groundwater|none`',
    `immediate_cause` STRING COMMENT 'The direct, proximate cause of the incident as observed at the time of occurrence (e.g., equipment failure, slip and fall, vehicle collision).',
    `incident_date` DATE COMMENT 'The calendar date on which the incident occurred.',
    `incident_description` STRING COMMENT 'Comprehensive narrative description of what happened during the incident, including sequence of events, conditions, and immediate observations.',
    `incident_number` STRING COMMENT 'Business-facing unique incident tracking number assigned by the EHS system for external reference and reporting.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident record. Open indicates initial reporting; under investigation means root cause analysis in progress; corrective action pending means investigation complete but actions not yet implemented; closed means all actions complete and incident resolved.. Valid values are `open|under_investigation|corrective_action_pending|closed`',
    `incident_time` TIMESTAMP COMMENT 'The precise date and time when the incident occurred, including timezone information.',
    `incident_type` STRING COMMENT 'Classification of the incident based on severity and regulatory reporting requirements. OSHA recordable requires formal logging; first aid is minor treatment; near-miss had potential but no actual harm; environmental release involves spills or emissions; property damage affects assets; vehicle accident involves fleet collision.. Valid values are `osha_recordable|first_aid|near_miss|environmental_release|property_damage|vehicle_accident`',
    `injured_party_name` STRING COMMENT 'Full name of the person injured or affected by the incident. Null if incident did not involve personal injury.',
    `injury_type` STRING COMMENT 'Classification of the physical injury sustained. Null if incident did not result in personal injury. [ENUM-REF-CANDIDATE: laceration|fracture|sprain|burn|contusion|amputation|respiratory|other — 8 candidates stripped; promote to reference product]',
    `investigation_completed_date` DATE COMMENT 'Date on which the formal incident investigation was completed and root cause analysis finalized. Null if investigation not yet complete.',
    `investigator_name` STRING COMMENT 'Name of the EHS professional or manager who led the incident investigation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the incident record was last updated in the EHS system.',
    `location_description` STRING COMMENT 'Detailed description of the specific location within the facility where the incident occurred (e.g., tipping floor, sorting line, landfill cell 5, maintenance bay).',
    `material_released` STRING COMMENT 'Description of the hazardous or non-hazardous material released during an environmental incident (e.g., diesel fuel, leachate, hydraulic fluid). Null if not an environmental release.',
    `notification_date` DATE COMMENT 'Date on which the regulatory agency was notified of the incident. Null if no notification required.',
    `notification_method` STRING COMMENT 'Method used to notify the regulatory agency (phone, email, online portal, written report, in-person). Null if no notification required.. Valid values are `phone|email|online_portal|written_report|in_person`',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA criteria for recordability on the OSHA 300 log (death, days away from work, restricted work, medical treatment beyond first aid, loss of consciousness, or significant injury/illness diagnosed by healthcare professional).',
    `ppe_in_use_flag` BOOLEAN COMMENT 'Indicates whether the injured party was wearing required personal protective equipment at the time of the incident. Null if not applicable.',
    `ppe_type` STRING COMMENT 'Description of the PPE that was (or should have been) in use at the time of the incident (e.g., hard hat, safety glasses, gloves, respirator, steel-toed boots). Null if not applicable.',
    `property_damage_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of property damage resulting from the incident in USD. Null if no property damage occurred.',
    `regulatory_agency_notified` STRING COMMENT 'Name of the regulatory agency (EPA, OSHA, DOT, state environmental agency, local fire department) that was notified of the incident. Null if no notification required.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the incident triggers a mandatory regulatory reporting obligation to EPA, OSHA, DOT, or state/local agencies.',
    `release_quantity` DECIMAL(18,2) COMMENT 'Estimated quantity of material released during an environmental incident. Null if not an environmental release.',
    `release_quantity_unit` STRING COMMENT 'Unit of measure for the release quantity (gallons, liters, pounds, kilograms, cubic yards, tons).. Valid values are `gallons|liters|pounds|kilograms|cubic_yards|tons`',
    `reported_by_name` STRING COMMENT 'Name of the individual who initially reported the incident to the EHS department or management.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first reported to the EHS system or management.',
    `root_cause_classification` STRING COMMENT 'High-level classification of the underlying root cause determined through incident investigation. Human error includes training gaps or procedural non-compliance; equipment failure is mechanical breakdown; process deficiency is inadequate procedure; environmental condition is weather or site hazard; management system is organizational control weakness.. Valid values are `human_error|equipment_failure|process_deficiency|environmental_condition|management_system|other`',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the root cause analysis findings, including contributing factors and systemic issues identified.',
    `witness_names` STRING COMMENT 'Comma-separated list of names of individuals who witnessed the incident. Used for investigation purposes. Null if no witnesses.',
    CONSTRAINT pk_ehs_incident PRIMARY KEY(`ehs_incident_id`)
) COMMENT 'Environmental, health, and safety incident records capturing workplace injuries, near-misses, environmental releases, spills, fires, and property damage events. Tracks incident ID, incident type (OSHA recordable, first aid, near-miss, environmental release, property damage), date/time and location, description, injured party or affected media, immediate cause, root cause classification, OSHA recordability determination, days away from work, regulatory reporting obligation triggered, and notification status. Sourced from Enviance EHS. Distinct from violation_notice (agency-issued) — this is the internal incident record. Supports OSHA 300 log, EPA emergency notification, and DOT accident reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` (
    `compliance_environmental_monitoring_id` BIGINT COMMENT 'Unique identifier for the environmental monitoring measurement record.',
    `corrective_action_id` BIGINT COMMENT 'Reference to the corrective action record initiated in response to this monitoring result, if applicable.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Environmental monitoring stations measure emissions from specific physical sources (stacks, vents, landfill gas wells). Compliance monitoring programs require linking sample data to the emission sourc',
    `facility_id` BIGINT COMMENT 'Reference to the Waste Management facility where the environmental monitoring measurement was taken.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Monitoring programs use contracted laboratories and sampling services. Links lab certification verification, chain-of-custody, performance evaluation, and payment processing. Laboratory_name is denorm',
    `monitoring_program_id` BIGINT COMMENT 'Reference to the environmental monitoring program under which this measurement was collected.',
    `monitoring_station_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_station. Business justification: Environmental monitoring records are collected at fixed monitoring stations (groundwater wells, air monitoring stations, leachate sampling points). This FK replaces the denormalized monitoring_locatio',
    `permit_id` BIGINT COMMENT 'Reference to the environmental permit (air, water, waste) that mandates this monitoring activity.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Environmental monitoring is conducted to satisfy regulatory requirements (Clean Water Act discharge monitoring, landfill groundwater monitoring under Subtitle D). This FK links monitoring records to t',
    `environmental_sample_id` BIGINT COMMENT 'Unique identifier assigned to the physical sample collected, used for chain-of-custody tracking and laboratory analysis correlation.',
    `analysis_completion_date` DATE COMMENT 'Date when the laboratory analysis was completed and results were finalized.',
    `comments` STRING COMMENT 'Additional notes, observations, or contextual information about the monitoring event, sample collection, or result interpretation.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether the monitoring result triggered the need for corrective action due to exceedance, trend analysis, or other compliance concern.',
    `data_qualifier` STRING COMMENT 'Code or flag indicating special conditions affecting the measurement result, such as J (estimated value), U (non-detect), B (blank contamination), or other EPA-standard qualifiers.',
    `data_source_system` STRING COMMENT 'The operational system from which this monitoring record was sourced, typically Enviance EHS or SAP EHS module.',
    `detection_limit` DECIMAL(18,2) COMMENT 'The minimum concentration or value that the analytical method can reliably detect for this parameter. Values below this threshold may be reported as non-detect or below detection limit.',
    `exceedance_flag` BOOLEAN COMMENT 'Indicates whether the measured value exceeded the regulatory limit, triggering potential compliance action or reporting requirements.',
    `laboratory_certification_number` STRING COMMENT 'The certification or accreditation number of the laboratory that performed the analysis, demonstrating compliance with quality assurance requirements.',
    `measured_value` DECIMAL(18,2) COMMENT 'The numeric value of the environmental parameter measured during the monitoring event.',
    `monitoring_event_number` STRING COMMENT 'Business identifier for the monitoring event, used for tracking and reporting purposes.',
    `monitoring_frequency` STRING COMMENT 'The required frequency at which this monitoring parameter must be measured as specified by the permit or regulatory requirement. [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|monthly|quarterly|semi_annual|annual|event_based — 9 candidates stripped; promote to reference product]',
    `monitoring_program_type` STRING COMMENT 'Type of environmental monitoring program. Ambient air monitors outdoor air quality, stack emissions track facility discharge, NPDES (National Pollutant Discharge Elimination System) effluent monitors wastewater discharge, groundwater well tracks subsurface water quality, LFG (Landfill Gas) LEL (Lower Explosive Limit) methane monitors landfill gas concentrations, leachate monitors liquid drainage from landfills, soil monitors ground contamination, surface water tracks nearby water bodies, and stormwater monitors runoff quality. [ENUM-REF-CANDIDATE: ambient_air|stack_emissions|npdes_effluent|groundwater_well|lfg_lel_methane|leachate|soil|surface_water|stormwater — 9 candidates stripped; promote to reference product]',
    `parameter_measured` STRING COMMENT 'The specific environmental parameter or pollutant measured in this monitoring event. Examples include CO2e (Carbon Dioxide Equivalent), methane, BOD (Biochemical Oxygen Demand), pH, VOCs (Volatile Organic Compounds), TSS (Total Suspended Solids), heavy metals, nitrogen oxides, sulfur dioxide, particulate matter, and other regulated substances.',
    `quality_assurance_flag` STRING COMMENT 'Indicates whether the measurement passed quality assurance and quality control (QA/QC) checks including calibration verification, blank analysis, duplicate samples, and spike recoveries.. Valid values are `passed|failed|pending|not_applicable`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring record was first created in the Enviance EHS system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring record was last modified in the Enviance EHS system.',
    `regulatory_limit` DECIMAL(18,2) COMMENT 'The maximum allowable concentration or value for this parameter as specified by the applicable environmental permit, regulation, or standard. Used for compliance comparison.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether this monitoring result must be included in regulatory reports submitted to EPA, state agencies, or local authorities (e.g., SWIS, air quality reports, discharge monitoring reports).',
    `reporting_period` STRING COMMENT 'The regulatory reporting period to which this monitoring result applies, typically expressed as a month, quarter, or year (e.g., 2024-Q1, January 2024).',
    `sample_collection_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental sample was collected or the measurement was taken in the field.',
    `sampler_name` STRING COMMENT 'Name of the individual or team who collected the environmental sample or performed the field measurement.',
    `sampling_method` STRING COMMENT 'The EPA-approved or industry-standard method used to collect and analyze the environmental sample. Examples include EPA Method 8260 for VOCs, EPA Method 25 for stack emissions, Standard Methods for water quality, and ASTM methods for soil analysis.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed. Examples include ppm (parts per million), ppb (parts per billion), mg/L (milligrams per liter), ug/m3 (micrograms per cubic meter), percent LEL, pH units, tons per day, and other standard environmental measurement units.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sample collection, relevant for ambient air, surface water, and stormwater monitoring where meteorological factors affect results.',
    CONSTRAINT pk_compliance_environmental_monitoring PRIMARY KEY(`compliance_environmental_monitoring_id`)
) COMMENT 'Environmental monitoring measurement records capturing air emissions, water quality, groundwater, leachate, landfill gas (LFG), and soil monitoring data collected at Waste Management facilities. Tracks monitoring event ID, monitoring program type (ambient air, stack emissions, NPDES effluent, groundwater well, LFG LEL/methane), monitoring location/station, sample date and time, parameter measured (CO2e, methane, BOD, pH, VOCs), measured value, unit of measure, detection limit, regulatory limit for comparison, exceedance flag, sampling method, and laboratory reference. Supports permit condition compliance verification and regulatory reporting (SWIS, state air reports). Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`monitoring_station` (
    `monitoring_station_id` BIGINT COMMENT 'Unique identifier for the environmental monitoring station. Primary key for the monitoring station entity.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Monitoring equipment is vendor-supplied with maintenance contracts. Tracks equipment warranty, calibration service scheduling, and vendor performance for critical compliance infrastructure.',
    `facility_id` BIGINT COMMENT 'Reference to the Waste Management facility where this monitoring station is located (landfill, MRF, WTE plant, TSDF, etc.).',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Monitoring stations (groundwater wells, air quality monitors, meteorological stations) are capital assets requiring depreciation, maintenance scheduling, insurance, and lifecycle management. Links com',
    `permit_id` BIGINT COMMENT 'Reference to the environmental permit that mandates or governs this monitoring station (air permit, water discharge permit, solid waste permit, etc.).',
    `access_restrictions` STRING COMMENT 'Description of any physical access restrictions, safety requirements, or special procedures needed to reach or service this monitoring station (e.g., Requires confined space entry permit, Active landfill area - escort required, Locked enclosure).',
    `activation_date` DATE COMMENT 'Date when the monitoring station was activated and began collecting compliance data. May differ from installation date if there was a commissioning period.',
    `analyte_list` STRING COMMENT 'Comma-separated list or reference to the suite of parameters, chemicals, or constituents monitored at this station (e.g., Appendix I VOCs, Appendix II metals, LFG composition, pH, conductivity, turbidity). Defines the scope of environmental monitoring.',
    `casing_diameter_inches` DECIMAL(18,2) COMMENT 'Inner diameter of the well casing in inches. Determines sampling equipment compatibility and flow capacity. Applicable to wells only.',
    `casing_material` STRING COMMENT 'Material composition of the well casing. Affects chemical compatibility and longevity. Applicable to wells and probes.. Valid values are `pvc|stainless_steel|hdpe|carbon_steel`',
    `communication_method` STRING COMMENT 'Method by which monitoring data is transmitted from the station to central systems (cellular modem, satellite uplink, radio telemetry, hardwired connection, or manual collection).. Valid values are `cellular|satellite|radio|hardwired|manual`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring station record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_logger_code` STRING COMMENT 'Identifier for the electronic data logger or telemetry device that collects and transmits measurements from this station. Used for data integration and troubleshooting.',
    `deactivation_date` DATE COMMENT 'Date when the monitoring station was deactivated, abandoned, or decommissioned. Null for active stations. Marks the end of the stations operational lifecycle.',
    `deactivation_reason` STRING COMMENT 'Explanation for why the monitoring station was deactivated (e.g., Permit requirement ended, Well damaged beyond repair, Facility closure, Replaced by new station). Null for active stations.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation of the monitoring station above mean sea level in feet. Critical for groundwater flow analysis and air quality modeling.',
    `equipment_serial_number` STRING COMMENT 'Manufacturer serial number of the primary monitoring equipment at this station. Used for warranty tracking, calibration records, and maintenance history.',
    `equipment_type` STRING COMMENT 'Type or model of monitoring equipment or instrumentation installed at the station (e.g., Continuous Air Monitor Model XYZ, Submersible Pump, Flow Meter). Used for maintenance planning and calibration tracking.',
    `inspection_frequency_days` STRING COMMENT 'Required interval in days between physical inspections of the monitoring station, as specified by permit, regulation, or internal policy.',
    `installation_contractor` STRING COMMENT 'Name of the contractor or vendor who installed the monitoring station. Used for warranty tracking and quality assurance.',
    `installation_date` DATE COMMENT 'Date when the monitoring station was physically installed and became operational. Marks the beginning of the stations monitoring history.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration or verification of monitoring equipment at this station. Critical for data quality assurance and regulatory compliance.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the monitoring station for structural integrity, accessibility, and proper operation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring station record was most recently updated. Used for audit trail and change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the monitoring station in decimal degrees (WGS84 datum). Used for spatial analysis, regulatory reporting, and GIS mapping.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the monitoring station in decimal degrees (WGS84 datum). Used for spatial analysis, regulatory reporting, and GIS mapping.',
    `monitoring_purpose` STRING COMMENT 'Primary purpose or phase of the monitoring program this station supports (detection monitoring, assessment monitoring, corrective action, etc.). Determines sampling frequency and analyte list.. Valid values are `detection|assessment|corrective_action|background|compliance|operational`',
    `monitoring_station_status` STRING COMMENT 'Current operational status of the monitoring station. Determines whether the station is included in active monitoring schedules and compliance reporting.. Valid values are `active|inactive|abandoned|under_construction|decommissioned|temporarily_offline`',
    `monitoring_zone` STRING COMMENT 'Designated monitoring zone or area within the facility (e.g., Upgradient, Downgradient, Cell 3 Perimeter, North Boundary). Used for spatial grouping and compliance zone tracking.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration or verification of monitoring equipment. Used for preventive maintenance scheduling and compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, historical context, or operational notes about the monitoring station that do not fit in structured fields.',
    `regulatory_designation` STRING COMMENT 'Official regulatory identifier or designation assigned by permitting authority (e.g., NPDES outfall number, well ID per state permit, EPA monitoring point ID). Used in compliance reporting and permit tracking.',
    `responsible_party` STRING COMMENT 'Name or role of the person, team, or contractor responsible for maintaining and sampling this monitoring station. Used for accountability and work assignment.',
    `sampling_frequency` STRING COMMENT 'Required or planned frequency for collecting samples or measurements at this station, as specified by permit or monitoring plan. [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|biweekly|monthly|quarterly|semiannual|annual|event_based — 10 candidates stripped; promote to reference product]',
    `screen_interval_bottom_ft` DECIMAL(18,2) COMMENT 'Depth to the bottom of the well screen interval from ground surface in feet. Defines the lower boundary of the monitored zone. Applicable to wells only.',
    `screen_interval_top_ft` DECIMAL(18,2) COMMENT 'Depth to the top of the well screen interval from ground surface in feet. Defines the upper boundary of the monitored zone. Applicable to wells only.',
    `station_code` STRING COMMENT 'Business identifier for the monitoring station, often used in regulatory reporting and field operations. May include facility prefix and station type abbreviation.. Valid values are `^[A-Z0-9]{4,20}$`',
    `station_name` STRING COMMENT 'Human-readable name or designation for the monitoring station (e.g., North Boundary Well MW-12, LFG Probe GP-05, NPDES Outfall 001).',
    `station_type` STRING COMMENT 'Classification of the monitoring station based on the environmental medium and purpose. Determines the types of measurements collected and regulatory requirements applicable. [ENUM-REF-CANDIDATE: groundwater_well|lfg_extraction_well|lfg_monitoring_probe|air_quality_station|stormwater_outfall|leachate_collection_point|npdes_discharge_point|surface_water_monitoring|soil_gas_probe|meteorological_station — 10 candidates stripped; promote to reference product]',
    `well_depth_ft` DECIMAL(18,2) COMMENT 'Total depth of the monitoring well from ground surface to bottom in feet. Applicable only to groundwater wells and LFG extraction wells. Null for other station types.',
    CONSTRAINT pk_monitoring_station PRIMARY KEY(`monitoring_station_id`)
) COMMENT 'Master record for fixed environmental monitoring stations and sampling locations at Waste Management facilities. Covers groundwater monitoring wells, LFG extraction and monitoring probes, air quality monitoring stations, stormwater outfalls, leachate collection points, and NPDES discharge points. Tracks station ID, station type, facility association, geographic coordinates (lat/long), installation date, regulatory designation (e.g., NPDES outfall number, well ID per permit), active status, and associated permit. Provides the spatial and regulatory context for all environmental_monitoring measurement records.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Submissions require vendor data (Tier II reports use vendor SDS, disposal reports need TSDF certifications). Tracks vendor data quality and timeliness for regulatory deadlines and audit trails.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility for which this regulatory submission is filed. Links submission to the operating location.',
    `original_submission_regulatory_submission_id` BIGINT COMMENT 'Identifier of the original regulatory submission that this record amends, if applicable. Links amended submissions to their original filing.',
    `permit_id` BIGINT COMMENT 'Identifier of the environmental permit associated with this regulatory submission, if applicable. Links submission to the governing permit.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who prepared the regulatory submission. Tracks accountability for report preparation.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory submissions fulfill specific regulatory reporting requirements (annual emissions inventory, discharge monitoring reports, hazardous waste manifests). This FK replaces the denormalized regul',
    `scheduled_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.scheduled_obligation. Business justification: Regulatory submissions fulfill scheduled compliance obligations. This FK links submissions to the scheduled obligation that triggered them, enabling obligation fulfillment tracking and deadline compli',
    `tertiary_regulatory_submitted_by_employee_id` BIGINT COMMENT 'Identifier of the employee who executed the submission to the regulatory agency. Tracks final submission action.',
    `agency_comments` STRING COMMENT 'Comments or feedback provided by the regulatory agency regarding the submission. Captures agency instructions, deficiency notices, or acceptance notes.',
    `agency_jurisdiction` STRING COMMENT 'Level of government jurisdiction for the filing agency (federal, state, local, or regional).. Valid values are `Federal|State|Local|Regional`',
    `agency_response_date` DATE COMMENT 'Date on which the regulatory agency provided a formal response to the submission (acceptance, rejection, or request for additional information).',
    `agency_response_status` STRING COMMENT 'Status of the regulatory agencys response to the submission. Tracks whether the filing was accepted, rejected, or requires follow-up.. Valid values are `Accepted|Rejected|Additional Information Requested|Under Review|No Response`',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this submission is an amendment to a previously filed report. True if this is an amended submission, false if original.',
    `amendment_reason` STRING COMMENT 'Explanation of why the original submission was amended. Documents the business justification for the corrected filing.',
    `certification_date` DATE COMMENT 'Date on which the authorized official certified the regulatory submission. Establishes legal accountability for the report contents.',
    `certification_statement` STRING COMMENT 'Text of the certification statement signed by the authorized representative, attesting to the accuracy and completeness of the submission under penalty of law.',
    `certifying_official_name` STRING COMMENT 'Name of the authorized company official who certified the regulatory submission. Typically a facility manager, environmental manager, or corporate officer.',
    `certifying_official_title` STRING COMMENT 'Job title of the authorized official who certified the submission (e.g., Environmental Manager, Facility Manager, Vice President of EHS).',
    `compliance_year` STRING COMMENT 'Calendar year for which compliance is being reported. Facilitates year-over-year compliance tracking and trend analysis.',
    `confirmation_number` STRING COMMENT 'Confirmation or tracking number issued by the regulatory agency upon receipt of the submission. Serves as proof of filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory submission record was first created in the system. Audit trail for record creation.',
    `document_file_path` STRING COMMENT 'File path or storage location of the submitted regulatory report document. Enables retrieval of the original submission for audit and reference.',
    `document_format` STRING COMMENT 'File format of the submitted regulatory report (PDF, XML, Excel, etc.). Identifies the technical format used for submission.. Valid values are `PDF|XML|Excel|Word|CSV|EDI`',
    `due_date` DATE COMMENT 'Regulatory deadline by which the submission must be filed. Used to track compliance with filing timelines.',
    `facility_epa_number` STRING COMMENT 'EPA-assigned identification number for the facility covered by this submission. Required for RCRA and other federal reporting.',
    `filing_agency` STRING COMMENT 'Name of the government agency or regulatory body to which the report is submitted (e.g., EPA, state environmental quality department, local enforcement agency).',
    `late_submission_flag` BOOLEAN COMMENT 'Indicates whether the submission was filed after the regulatory deadline. True if late, false if on time. Used to track compliance with filing timelines.',
    `late_submission_reason` STRING COMMENT 'Explanation for why the submission was filed late, if applicable. Documents the circumstances that caused the delay.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the regulatory submission. Captures context, special circumstances, or internal coordination details.',
    `regulatory_program` STRING COMMENT 'The regulatory program under which this submission is required. Identifies the governing environmental or safety framework. [ENUM-REF-CANDIDATE: RCRA|SWIS|NPDES|Title V|CERCLA|EPCRA|OSHA|GHG Reporting — 8 candidates stripped; promote to reference product]',
    `report_type` STRING COMMENT 'Classification of the regulatory report being submitted. Identifies the specific regulatory program and reporting requirement. [ENUM-REF-CANDIDATE: RCRA Biennial Report|SWIS Report|NPDES DMR|Title V Certification|CERCLA Tier II|EPCRA Tier II|OSHA 300A Summary|GHG Emissions Report|State Environmental Report|Air Quality Report|Water Discharge Report|Hazardous Waste Manifest|LFG Monitoring Report|Leachate Analysis Report — promote to reference product]',
    `reporting_period_end` DATE COMMENT 'End date of the period covered by this regulatory submission. Defines the close of the compliance reporting window.',
    `reporting_period_start` DATE COMMENT 'Start date of the period covered by this regulatory submission. Defines the beginning of the compliance reporting window.',
    `submission_date` DATE COMMENT 'Date on which the regulatory report was submitted to the filing agency. Principal business event timestamp for this transaction.',
    `submission_method` STRING COMMENT 'Method by which the report was submitted to the regulatory agency (electronic portal, paper mail, email, etc.).. Valid values are `Electronic|Paper|Portal|Email|Certified Mail`',
    `submission_number` STRING COMMENT 'Business identifier for the regulatory submission, typically assigned by the submitting organization or regulatory agency. Used for external reference and tracking.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission. Tracks the submission through preparation, filing, and agency review stages. [ENUM-REF-CANDIDATE: Draft|Submitted|Accepted|Rejected|Under Review|Amended|Withdrawn — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory submission record was last modified. Audit trail for record changes.',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Records of formal regulatory reports and submissions filed with government agencies by Waste Management. Covers annual RCRA biennial reports, SWIS solid waste reports, NPDES discharge monitoring reports (DMR), Title V annual compliance certifications, CERCLA/EPCRA Tier II chemical inventory reports, OSHA 300A annual summaries, GHG emissions reports (EPA Subpart HH/TT), and state-specific environmental reports. Tracks submission ID, report type, regulatory program, filing agency, reporting period, submission date, submission method (electronic/paper), confirmation number, and submission status. Sourced from Enviance EHS and SAP EHS. Provides the audit trail for all external regulatory filings.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`training_certification` (
    `training_certification_id` BIGINT COMMENT 'Unique identifier for the training certification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this certification. Links to workforce domain employee master data.',
    `training_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.training_requirement. Business justification: Training certifications fulfill specific training requirements (HAZWOPER, CDL, OSHA 40-hour, DOT HazMat). This FK replaces the denormalized certification_type STRING field with a structured relationsh',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Certifications are vendor-provided (OSHA HAZWOPER training, equipment certifications). Links vendor qualification, training cost tracking, and regulatory compliance verification. Training_provider is ',
    `attachment_url` STRING COMMENT 'The file path or URL to the scanned copy of the certification document stored in the document management system. Used for audit and verification purposes.',
    `cdl_class` STRING COMMENT 'For CDL certifications, the license class indicating the type and weight of vehicle the driver is authorized to operate. Class A: combination vehicles over 26,001 lbs; Class B: heavy straight vehicles over 26,001 lbs; Class C: vehicles designed to transport 16+ passengers or hazmat.. Valid values are `CLASS_A|CLASS_B|CLASS_C`',
    `certification_number` STRING COMMENT 'The unique certificate or license number issued by the certifying body. Examples include CDL number, HAZWOPER certificate number, OSHA card number.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Active indicates valid and in good standing; Expired indicates past expiration date; Suspended or Revoked indicates regulatory action; Pending Renewal indicates renewal process initiated.. Valid values are `ACTIVE|EXPIRED|SUSPENDED|REVOKED|PENDING_RENEWAL`',
    `certification_type` STRING COMMENT 'The category of training or certification. Includes Commercial Driver License (CDL), Hazardous Waste Operations and Emergency Response (HAZWOPER) 40-hour initial and 8-hour refresher, Department of Transportation (DOT) hazmat transport, Occupational Safety and Health Administration (OSHA) 10-hour and 30-hour safety, confined space entry, forklift operator, Environmental Protection Agency (EPA) Risk Management Plan (RMP), and ISO 14001/45001 internal auditor certifications. [ENUM-REF-CANDIDATE: CDL|HAZWOPER_40HR|HAZWOPER_8HR_REFRESHER|DOT_HAZMAT|OSHA_10HR|OSHA_30HR|CONFINED_SPACE|FORKLIFT_OPERATOR|EPA_RMP|ISO_14001_AUDITOR|ISO_45001_AUDITOR|FIRST_AID_CPR — 12 candidates stripped; promote to reference product]',
    `completion_date` DATE COMMENT 'The date on which the employee successfully completed the training or certification program.',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this certification is a mandatory regulatory or company compliance requirement for the employees role. True for required certifications (e.g., CDL for drivers, HAZWOPER for hazmat handlers); False for optional professional development.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred for this training or certification, including tuition, materials, travel, and exam fees. Used for training budget tracking and cost allocation.',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the training cost. Waste Management primarily operates in USD.. Valid values are `USD`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was first created in the system. Used for audit trail and data lineage.',
    `endorsement_codes` STRING COMMENT 'For CDL certifications, the endorsement codes indicating specialized vehicle or cargo authorization. Examples: H (Hazardous Materials), N (Tank Vehicle), T (Double/Triple Trailers), P (Passenger). Pipe-separated if multiple endorsements.',
    `expiration_date` DATE COMMENT 'The date on which the certification expires and requires renewal. Null for certifications with no expiration (e.g., some OSHA 30-hour cards).',
    `instructor_name` STRING COMMENT 'The name of the instructor or trainer who conducted the training session, if applicable.',
    `issue_date` DATE COMMENT 'The date on which the certification was officially issued by the certifying body. May differ from completion date due to processing time.',
    `issuing_body` STRING COMMENT 'The organization or regulatory authority that issued the certification. Examples include state Department of Motor Vehicles (DMV), OSHA Training Institute Education Centers, EPA-approved training providers, ISO registrars.',
    `issuing_state` STRING COMMENT 'For state-issued certifications (e.g., CDL), the two-letter state code of the issuing jurisdiction. Examples: TX, CA, IL, NY.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, or comments related to the certification. May include details on accommodations, retake history, or special circumstances.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the employee passed, failed, is currently in progress, or did not complete the certification assessment.. Valid values are `PASS|FAIL|IN_PROGRESS|INCOMPLETE`',
    `regulatory_authority` STRING COMMENT 'The primary regulatory body or standard-setting organization governing this certification. Examples: Department of Transportation (DOT), Occupational Safety and Health Administration (OSHA), Environmental Protection Agency (EPA), State Department of Motor Vehicles (DMV), International Organization for Standardization (ISO), or Internal company policy.. Valid values are `DOT|OSHA|EPA|STATE_DMV|ISO|INTERNAL`',
    `renewal_frequency_months` STRING COMMENT 'The number of months between required renewals. Examples: 12 months for HAZWOPER refresher, 24 months for First Aid/CPR, 60 months for CDL renewal. Null if no renewal required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this certification requires periodic renewal. True for CDL, HAZWOPER refresher, DOT hazmat; False for one-time certifications.',
    `restriction_codes` STRING COMMENT 'For CDL certifications, the restriction codes limiting driving privileges. Examples: L (No Air Brake Equipped CMV), Z (No Full Air Brake Equipped CMV), E (No Manual Transmission). Pipe-separated if multiple restrictions.',
    `score` DECIMAL(18,2) COMMENT 'The numerical score or percentage achieved on the certification exam or assessment, if applicable. Null for certifications without scored assessments.',
    `source_system` STRING COMMENT 'The operational system from which this certification record originated. Primary sources are Enviance EHS for compliance training and Workday HCM for general employee training records.. Valid values are `ENVIANCE_EHS|WORKDAY_HCM|MANUAL_ENTRY`',
    `training_delivery_method` STRING COMMENT 'The method by which the training was delivered. In-person classroom, online e-learning, blended (combination), or on-the-job practical training.. Valid values are `IN_PERSON|ONLINE|BLENDED|ON_THE_JOB`',
    `training_hours` DECIMAL(18,2) COMMENT 'The total number of instructional hours completed for this certification. Examples: 40 hours for HAZWOPER initial, 8 hours for HAZWOPER refresher, 10 or 30 hours for OSHA safety training.',
    `training_location` STRING COMMENT 'The physical location or facility where the training was conducted. May be a Waste Management facility, training center, or external provider location. Null for online training.',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified by Waste Management HR or EHS personnel. Used for audit trail and compliance validation.',
    `verification_method` STRING COMMENT 'The method used to verify the authenticity and validity of the certification. Document review of physical certificate, online registry check with issuing body, third-party verification service, or employee self-attestation.. Valid values are `DOCUMENT_REVIEW|REGISTRY_CHECK|THIRD_PARTY_VERIFICATION|SELF_ATTESTATION`',
    `verified_by` STRING COMMENT 'The name or employee ID of the Waste Management personnel who verified the certification. Typically an EHS coordinator or HR specialist.',
    CONSTRAINT pk_training_certification PRIMARY KEY(`training_certification_id`)
) COMMENT 'Records of compliance-required training completions and professional certifications held by Waste Management employees. Covers CDL (Commercial Driver License) endorsements, HAZWOPER 40-hour and 8-hour refresher certifications, DOT hazmat transport training, OSHA 10/30-hour safety training, confined space entry certification, forklift operator certification, EPA RMP training, and ISO 14001/45001 internal auditor certification. Tracks certification ID, employee reference, certification type, issuing body, completion date, expiration date, training hours, pass/fail status, and renewal requirement. Distinct from workforce domain employee records — this is the compliance-specific training obligation and certification record. Sourced from Enviance EHS and Workday HCM.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`training_requirement` (
    `training_requirement_id` BIGINT COMMENT 'Unique identifier for the training requirement record. Primary key.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Training requirements implement regulatory requirements (OSHA 1910.120 HAZWOPER training, DOT 49 CFR 172.704 HazMat training). This FK replaces the denormalized regulatory_citation STRING field with a',
    `superseded_by_requirement_training_requirement_id` BIGINT COMMENT 'Reference to the training_requirement_id that replaces this requirement when regulatory standards change or training programs are updated. Null if not superseded.',
    `accreditation_body` STRING COMMENT 'Name of the organization that must accredit the training provider (e.g., OSHA, EPA, State DMV, IACET, ANSI). Null if no specific accreditation required.',
    `applicable_facility_types` STRING COMMENT 'Comma-separated list or description of facility types where this training is mandatory (e.g., Landfill, MRF, TSDF, Transfer Station, WTE Facility, Fleet Maintenance Yard, Hazardous Waste Storage).',
    `applicable_job_roles` STRING COMMENT 'Comma-separated list or description of job roles/positions to which this training requirement applies (e.g., CDL Driver, Hazmat Handler, MRF Sorter, Landfill Operator, Maintenance Technician, Environmental Compliance Manager).',
    `applicable_regulatory_programs` STRING COMMENT 'Comma-separated list of regulatory programs or permits that trigger this training requirement (e.g., RCRA Part B Permit, Air Quality Permit, NPDES Permit, DOT Hazmat Transportation, OSHA PSM).',
    `business_justification` STRING COMMENT 'Narrative explanation of why this training is required, including regulatory mandate, risk mitigation, operational necessity, or industry best practice rationale.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether successful completion must result in a formal certification or credential (True) or if attendance/completion record is sufficient (False).',
    `competency_assessment_required_flag` BOOLEAN COMMENT 'Indicates whether a formal competency assessment (exam, practical demonstration, skills test) is required in addition to training attendance.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost per employee to complete this training requirement, including tuition, materials, travel, and lost productivity. Used for compliance budget planning.',
    `created_by_user` STRING COMMENT 'Username or identifier of the person who created this training requirement record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training requirement record was first created in the system.',
    `documentation_retention_years` STRING COMMENT 'Minimum number of years training records must be retained to satisfy regulatory and audit requirements (e.g., OSHA requires 3 years for most training, EPA RCRA requires duration of employment plus 3 years).',
    `effective_date` DATE COMMENT 'Date from which this training requirement becomes mandatory and enforceable.',
    `expiration_date` DATE COMMENT 'Date after which this training requirement is no longer mandatory. Null for ongoing requirements.',
    `frequency_interval_months` STRING COMMENT 'Number of months between required training completions for recurring requirements. Null for one-time or event-driven training.',
    `frequency_type` STRING COMMENT 'Recurrence pattern for the training requirement (e.g., initial upon hire, annual refresher, triennial recertification, event-driven upon role change). [ENUM-REF-CANDIDATE: initial|annual|biennial|triennial|quinquennial|one_time|event_driven — 7 candidates stripped; promote to reference product]',
    `grace_period_days` STRING COMMENT 'Number of days after expiration during which the employee may continue working while completing recertification. Null if no grace period allowed.',
    `iso_14001_competence_flag` BOOLEAN COMMENT 'Indicates whether this training requirement is part of the ISO 14001 Environmental Management System competence framework.',
    `iso_45001_competence_flag` BOOLEAN COMMENT 'Indicates whether this training requirement is part of the ISO 45001 Occupational Health and Safety Management System competence framework.',
    `language_requirements` STRING COMMENT 'Languages in which training must be available to ensure comprehension by all applicable employees (e.g., English, Spanish). OSHA requires training in language understood by employee.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the person who last modified this training requirement record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training requirement record was last updated.',
    `minimum_passing_score_percent` DECIMAL(18,2) COMMENT 'Minimum percentage score required on competency assessment to satisfy the training requirement. Null if no assessment or no minimum score defined.',
    `minimum_training_hours` DECIMAL(18,2) COMMENT 'Minimum contact hours required to satisfy the training obligation (e.g., 40 hours for HAZWOPER initial, 8 hours for annual refresher, 10 hours for OSHA General Industry).',
    `prerequisite_training_codes` STRING COMMENT 'Comma-separated list of training_type_code values that must be completed before this training can be taken (e.g., HAZWOPER_40HR must precede HAZWOPER_SUPERVISOR).',
    `regulatory_citation` STRING COMMENT 'Legal or regulatory reference mandating this training (e.g., 29 CFR 1910.120 for HAZWOPER, 49 CFR 172.704 for DOT Hazmat, 40 CFR 265.16 for RCRA personnel training, OSHA 1910.178 for forklift operation).',
    `requirement_status` STRING COMMENT 'Current lifecycle state of the training requirement. Active requirements are enforced in compliance gap analysis.. Valid values are `active|inactive|superseded|pending_review`',
    `third_party_certification_flag` BOOLEAN COMMENT 'Indicates whether the certification must be issued by an external accredited body (True) or can be issued internally (False). Examples: CDL requires state DMV, HAZWOPER may require accredited training provider.',
    `training_category` STRING COMMENT 'High-level classification of the training requirement domain.. Valid values are `safety|environmental|operational|regulatory|technical|leadership`',
    `training_delivery_methods` STRING COMMENT 'Comma-separated list of acceptable delivery formats (e.g., classroom, online, blended, hands-on, on-the-job, simulator). Some regulatory training may restrict delivery methods.',
    `training_name` STRING COMMENT 'Full descriptive name of the training program (e.g., 40-Hour HAZWOPER Initial Training, Commercial Driver License Class A Certification, OSHA 10-Hour General Industry Safety).',
    `training_provider_type` STRING COMMENT 'Classification of acceptable training provider sources for this requirement.. Valid values are `internal|external_accredited|external_vendor|government_agency|industry_association`',
    `training_type_code` STRING COMMENT 'Standardized code identifying the specific training program (e.g., HAZWOPER_40HR, CDL_CLASS_A, OSHA_10HR, DOT_HAZMAT, RCRA_HANDLER, CONFINED_SPACE, FORKLIFT_CERT).. Valid values are `^[A-Z0-9_]{2,20}$`',
    CONSTRAINT pk_training_requirement PRIMARY KEY(`training_requirement_id`)
) COMMENT 'Reference catalog defining mandatory compliance training obligations applicable to specific job roles, facility types, and regulatory programs at Waste Management. Maps training type to the regulatory citation requiring it (e.g., HAZWOPER required by 29 CFR 1910.120 for hazmat workers), required frequency (initial, annual, triennial), minimum training hours, applicable employee roles (CDL driver, hazmat handler, MRF sorter, landfill operator), and whether a third-party certification is required. Used to identify training gaps by comparing requirements against training_certification records. Supports ISO 45001 competence management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`air_emission_event` (
    `air_emission_event_id` BIGINT COMMENT 'Unique identifier for the air emission event record. Primary key for tracking individual emission episodes at Waste Management facilities.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Emission events may be discovered during regulatory inspections or internal compliance audits. This FK links events to the inspection that identified them, supporting root cause analysis and inspectio',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracking which employee detected emission events supports training effectiveness analysis, incident response performance evaluation, and recognition programs for proactive environmental monitoring in ',
    `emergency_action_plan_id` BIGINT COMMENT 'Foreign key linking to safety.emergency_action_plan. Business justification: Air emission events trigger emergency response procedures. This link documents which emergency plan was activated and ensures regulatory reporting includes emergency response actions. Required for Tit',
    `emission_source_id` BIGINT COMMENT 'Identifier of the specific emission unit or source at the facility (e.g., flare, stack, combustion unit, landfill gas collection system, fugitive source). Corresponds to permit-defined emission points.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility where the air emission event occurred. Links to landfill, waste-to-energy plant, transfer station, or materials recovery facility.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Emission units (engines, flares, stacks, vents) are fixed assets. Linking emission events to asset records enables maintenance trigger analysis, asset performance tracking, regulatory reporting by equ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Air emission events are governed by air quality permits. Each emission event occurs under the authority of a specific permit that defines allowable emission limits. The permit_id FK enables tracking w',
    `regulatory_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_corrective_action. Business justification: Emission events that exceed permit limits or regulatory thresholds trigger corrective actions. This FK links emission events to the corrective actions taken to address the deviation, enabling tracking',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Emission events result from vendor equipment failure or service issues (control equipment malfunction, contractor error). Essential for vendor accountability, warranty claims, and performance evaluati',
    `agency_contact_name` STRING COMMENT 'Name of the regulatory agency representative or inspector who was contacted regarding the emission event.',
    `agency_name` STRING COMMENT 'Name of the regulatory agency notified (e.g., U.S. Environmental Protection Agency, State Department of Environmental Quality, Local Air Quality Management District).',
    `agency_notified_date` DATE COMMENT 'Actual date when the regulatory agency (EPA, state air quality agency, or local enforcement agency) was notified of the emission event. Used to verify compliance with notification deadlines.',
    `air_emission_event_status` STRING COMMENT 'Current status of the emission event record in the EHS management system. Open indicates active event; under investigation means root cause analysis in progress; corrective action pending means actions identified but not completed; reported means regulatory notification submitted; closed means all actions complete and event resolved.. Valid values are `open|under_investigation|corrective_action_pending|closed|reported`',
    `cause_description` STRING COMMENT 'Detailed narrative describing the root cause of the emission event. Includes equipment failure details, operational upset conditions, weather events, human error, or other contributing factors. Required for regulatory deviation reports.',
    `community_impact_flag` BOOLEAN COMMENT 'Indicates whether the emission event resulted in off-site impacts, odor complaints, or community concerns. True if complaints were received or visible plume extended beyond facility boundary.',
    `complaint_count` STRING COMMENT 'Number of community complaints received related to this emission event. Includes odor complaints, visible emission concerns, and health-related inquiries.',
    `corrective_action_taken` STRING COMMENT 'Description of immediate and long-term corrective actions implemented to stop the emission event and prevent recurrence. Includes equipment repairs, operational adjustments, enhanced monitoring, and preventive maintenance measures.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this emission event record was first created in the Enviance EHS system. Audit trail for data governance and compliance tracking.',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the emission event was first detected or identified. May differ from event start time if detection was delayed.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether the emission event constitutes a deviation from permit requirements under Clean Air Act Title V. True if permit limits were exceeded or monitoring/recordkeeping requirements were not met.',
    `emission_quantity_unit` STRING COMMENT 'Unit of measure for the estimated emission quantity. Typically pounds or tons for mass-based pollutants, cubic feet or cubic meters for volumetric measurements.. Valid values are `pounds|tons|kilograms|metric_tons|cubic_feet|cubic_meters`',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether the emission event resulted in regulatory enforcement action such as Notice of Violation (NOV), penalty assessment, consent order, or compliance schedule. True if formal enforcement was initiated.',
    `estimated_emission_quantity` DECIMAL(18,2) COMMENT 'Estimated quantity of pollutant released during the event. Calculated using emission factors, continuous emission monitoring system (CEMS) data, or engineering estimates. Reported in units specified by emission_quantity_unit.',
    `event_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the emission event in hours. Calculated from start and end timestamps. Used for regulatory reporting and compliance assessment.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the air emission event concluded or was brought under control. Used to calculate total event duration and emission quantity.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the air emission event began. Critical for calculating duration and determining regulatory notification deadlines.',
    `event_type` STRING COMMENT 'Classification of the air emission event. Excess emission indicates permit limit exceedance; SSM (Startup Shutdown Malfunction) covers operational transitions; fugitive emission refers to uncontrolled releases; emergency release covers unplanned incidents; routine release covers normal operations; opacity exceedance indicates visible emission violations.. Valid values are `excess_emission|startup_shutdown_malfunction|fugitive_emission|emergency_release|routine_release|opacity_exceedance`',
    `last_modified_by` STRING COMMENT 'Username or employee identifier of the person who last modified this emission event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this emission event record was last updated in the Enviance EHS system. Tracks changes to event details, corrective actions, or status updates.',
    `monitoring_method` STRING COMMENT 'Method used to detect and quantify the emission event. CEMS (Continuous Emission Monitoring System) for real-time data; parametric monitoring for surrogate parameters; visual observation for opacity; calculation using emission factors; engineering estimate for unmonitored sources.. Valid values are `CEMS|parametric_monitoring|visual_observation|calculation|engineering_estimate`',
    `notification_deadline_date` DATE COMMENT 'Date by which regulatory notification or deviation report must be submitted to the appropriate agency. Calculated based on event type and applicable regulations (typically 24 hours for emergencies, 30 days for deviations).',
    `notification_method` STRING COMMENT 'Method used to notify the regulatory agency of the emission event (phone call, email, written report, electronic submission portal, in-person notification).. Valid values are `phone|email|written_report|electronic_portal|in_person`',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether the emission event triggered a regulatory notification requirement to EPA, state air quality agency, or local enforcement agency. True if immediate notification (within 24 hours) or deviation reporting is required.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed by regulatory agency for the emission event violation, if applicable. Reported in U.S. dollars.',
    `permit_limit_unit` STRING COMMENT 'Unit of measure for the permit limit (e.g., pounds per hour, tons per year, parts per million, percent opacity, grains per dry standard cubic foot).. Valid values are `pounds_per_hour|tons_per_year|ppm|percent_opacity|grains_per_dscf`',
    `permit_limit_value` DECIMAL(18,2) COMMENT 'The regulatory permit limit for the pollutant and emission unit that was exceeded or approached during this event. Used to determine if event constitutes a deviation or violation.',
    `pollutant_code` STRING COMMENT 'EPA-standardized code for the primary air pollutant involved in the emission event (e.g., PM10, PM2.5, SO2, NOx, VOC, CO, CO2e, CH4, H2S). May reference multiple pollutants for complex events.',
    `pollutant_name` STRING COMMENT 'Full name of the air pollutant released during the event (e.g., Particulate Matter 10 micrometers, Sulfur Dioxide, Nitrogen Oxides, Volatile Organic Compounds, Carbon Monoxide, Methane, Hydrogen Sulfide).',
    `preventive_action_planned` STRING COMMENT 'Description of planned preventive measures to avoid similar emission events in the future. May include capital improvements, enhanced training, revised procedures, or increased inspection frequency.',
    `report_reference_number` STRING COMMENT 'Reference number or tracking identifier assigned by the regulatory agency or internal EHS system for the deviation report or notification associated with this emission event.',
    `severity_level` STRING COMMENT 'Internal classification of emission event severity based on magnitude of exceedance, duration, community impact, and regulatory significance. Minor events have minimal impact; critical events pose significant environmental or health risks.. Valid values are `minor|moderate|major|critical`',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of the emission event. Relevant for fugitive dust events, odor complaints, and dispersion modeling. Includes wind speed, wind direction, temperature, precipitation.',
    `wind_direction` STRING COMMENT 'Wind direction at the time of the emission event (e.g., N, NE, E, SE, S, SW, W, NW, or degrees from north). Used to assess potential off-site impacts and community exposure.',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Wind speed in miles per hour at the time of the emission event. Critical for fugitive emission events and dispersion analysis.',
    `created_by` STRING COMMENT 'Username or employee identifier of the person who created this emission event record in the EHS system.',
    CONSTRAINT pk_air_emission_event PRIMARY KEY(`air_emission_event_id`)
) COMMENT 'Records of air emission events including scheduled and unscheduled emission releases, excess emission episodes, startup/shutdown/malfunction (SSM) events, and fugitive dust events at Waste Management facilities. Tracks event ID, facility and emission unit, event type (excess emission, SSM, fugitive), pollutant(s) affected, event start and end datetime, estimated emission quantity, cause description, corrective actions taken, regulatory notification requirement triggered, and agency notification date. Supports Clean Air Act Title V deviation reporting and state air quality agency notification obligations. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`spill_release` (
    `spill_release_id` BIGINT COMMENT 'Unique identifier for the spill or release incident record.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Spills may be discovered during compliance inspections or internal audits. This FK links spill records to the inspection that identified them, supporting inspection follow-up and corrective action tra',
    `emergency_action_plan_id` BIGINT COMMENT 'Foreign key linking to safety.emergency_action_plan. Business justification: Spill releases trigger emergency action plans. Required for SPCC and RCRA contingency plan documentation. This link documents which emergency plan was activated, ensures response actions followed appr',
    `facility_id` BIGINT COMMENT 'Reference to the facility where the spill occurred, if applicable.',
    `incident_id` BIGINT COMMENT 'Reference to the broader environmental, health, and safety incident record if the spill is part of a larger incident event.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Spills and environmental releases may violate permit conditions (e.g., stormwater discharge permit, hazardous waste storage permit). This FK links spill records to the permit that was violated, enabli',
    `regulatory_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_corrective_action. Business justification: Spills trigger corrective actions to address root causes and prevent recurrence. This FK links spill records to the corrective actions taken, enabling CAPA tracking and closure verification for enviro',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Spill incidents require employee accountability for response actions. Linking enables root cause analysis tied to personnel, training gap identification, performance management, and regulatory reporti',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Spills involve vendor materials or services (fuel delivery overfill, contractor chemical handling error). Links vendor liability determination, insurance coordination, and performance tracking. Cleanu',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Reportable spills that exceed regulatory thresholds may result in violation notices from EPA or state agencies. This FK links spill records to the resulting violation notice, enabling enforcement acti',
    `affected_media` STRING COMMENT 'Environmental media impacted by the spill (e.g., soil, surface water, groundwater, air, pavement, multiple media).. Valid values are `soil|surface_water|groundwater|air|pavement|multiple`',
    `agency_notified` STRING COMMENT 'Name of the regulatory agency or agencies notified of the spill (e.g., National Response Center, state environmental agency, local emergency response).',
    `cas_number` STRING COMMENT 'CAS registry number uniquely identifying the chemical substance released, if applicable.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `cause_category` STRING COMMENT 'High-level classification of the root cause of the spill (e.g., equipment failure, human error, natural event, third-party action, unknown).. Valid values are `equipment_failure|human_error|natural_event|third_party|unknown`',
    `cause_description` STRING COMMENT 'Detailed narrative description of the root cause and contributing factors that led to the spill incident.',
    `cleanup_completion_date` DATE COMMENT 'Date on which all cleanup and remediation activities were completed and the site was restored.',
    `cleanup_start_date` DATE COMMENT 'Date on which cleanup and remediation activities commenced.',
    `containment_actions` STRING COMMENT 'Description of immediate containment and response actions taken to control the spill (e.g., deployment of absorbent materials, berms, booms, or other containment measures).',
    `corrective_actions` STRING COMMENT 'Description of corrective and preventive actions implemented to prevent recurrence of similar spill incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spill release record was first created in the system.',
    `discovery_date` DATE COMMENT 'The date on which the spill or release was first discovered by personnel.',
    `disposal_facility_epa_number` STRING COMMENT 'EPA identification number of the disposal facility where contaminated waste was sent.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}$`',
    `disposal_facility_name` STRING COMMENT 'Name of the Treatment, Storage, and Disposal Facility (TSDF) where contaminated waste was sent for final disposal.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Total estimated cost of the spill incident including cleanup, disposal, regulatory fines, and remediation expenses.',
    `estimated_quantity` DECIMAL(18,2) COMMENT 'Estimated volume or mass of material released during the spill incident.',
    `facility_epa_number` STRING COMMENT 'EPA-issued identification number for the facility where the spill occurred, used for regulatory tracking and reporting.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}$`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the spill location in decimal degrees.',
    `location_address` STRING COMMENT 'Street address or specific location description where the spill occurred.',
    `location_city` STRING COMMENT 'City where the spill occurred.',
    `location_state` STRING COMMENT 'Two-letter state code where the spill occurred.. Valid values are `^[A-Z]{2}$`',
    `location_type` STRING COMMENT 'Classification of the location where the spill occurred (e.g., facility, roadway, transfer station, landfill, Materials Recovery Facility, customer site).. Valid values are `facility|roadway|transfer_station|landfill|mrf|customer_site`',
    `location_zip_code` STRING COMMENT 'ZIP code of the location where the spill occurred.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the spill location in decimal degrees.',
    `material_released` STRING COMMENT 'Detailed description or name of the specific material or substance that was released during the spill (e.g., diesel fuel, hydraulic fluid, leachate, hazardous waste).',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or comments related to the spill incident and response activities.',
    `notification_confirmation_number` STRING COMMENT 'Confirmation or reference number provided by the regulatory agency upon notification of the spill.',
    `notification_date` DATE COMMENT 'Date on which regulatory agencies were notified of the spill incident.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the estimated quantity of material released (e.g., gallons, liters, pounds, kilograms, tons, cubic yards).. Valid values are `gallons|liters|pounds|kilograms|tons|cubic_yards`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the spill is reportable to regulatory agencies under federal, state, or local requirements.',
    `release_type` STRING COMMENT 'Classification of the material released during the spill incident (e.g., leachate, fuel, hazardous material, stormwater, chemical, oil).. Valid values are `leachate|fuel|hazmat|stormwater|chemical|oil`',
    `reportable_quantity_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the spill quantity exceeded the CERCLA Reportable Quantity threshold requiring federal notification.',
    `source_system` STRING COMMENT 'Name of the source system from which the spill release record originated (e.g., Enviance EHS).',
    `spill_date` DATE COMMENT 'The date on which the spill or release incident occurred.',
    `spill_status` STRING COMMENT 'Current lifecycle status of the spill incident (e.g., reported, contained, cleanup in progress, cleanup complete, closed).. Valid values are `reported|contained|cleanup_in_progress|cleanup_complete|closed`',
    `spill_time` TIMESTAMP COMMENT 'The precise timestamp when the spill or release incident was discovered or occurred.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transported, if applicable.. Valid values are `^UN[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the spill release record was last modified or updated.',
    `waste_disposed_quantity` DECIMAL(18,2) COMMENT 'Quantity of contaminated material or waste generated and disposed of as a result of the cleanup activities.',
    `waste_disposed_unit` STRING COMMENT 'Unit of measure for the quantity of waste disposed (e.g., gallons, liters, pounds, kilograms, tons, cubic yards).. Valid values are `gallons|liters|pounds|kilograms|tons|cubic_yards`',
    CONSTRAINT pk_spill_release PRIMARY KEY(`spill_release_id`)
) COMMENT 'Records of chemical, fuel, leachate, and hazardous material spills and environmental releases at Waste Management facilities and during transport operations. Tracks spill ID, release type (leachate, fuel, hazmat, stormwater), location (facility, roadway, transfer station), date and time, material released, estimated quantity, affected environmental media (soil, surface water, groundwater), immediate containment actions, regulatory reportability determination (CERCLA RQ threshold, state spill reporting), agency notification date and confirmation, and cleanup completion status. Supports CERCLA Section 103, EPCRA Section 304, and Clean Water Act spill reporting. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` (
    `scheduled_obligation_id` BIGINT COMMENT 'Unique identifier for the scheduled compliance obligation. Primary key for the scheduled obligation entity.',
    `facility_id` BIGINT COMMENT 'Foreign key reference to the facility responsible for fulfilling this scheduled obligation. Links to the facility master data.',
    `permit_id` BIGINT COMMENT 'Foreign key reference to the environmental permit associated with this obligation. Applicable when the obligation is driven by a specific permit condition.',
    `reduction_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.reduction_target. Business justification: Scheduled compliance obligations (permit-mandated emission reduction deadlines, phase-out schedules) may be driven by or aligned with corporate reduction targets. Tracks regulatory milestones that sup',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key reference to the regulatory requirement that drives this scheduled obligation. Links to the master regulatory requirement catalog.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory obligations must be assigned to employees for accountability. Linking enables workload planning, automated reminders, performance tracking, and audit documentation showing who is responsibl',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of labor hours spent completing this obligation. Used for performance tracking and future estimation refinement.',
    `agency_contact_email` STRING COMMENT 'Email address of the regulatory agency contact person. Organizational contact information classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_contact_name` STRING COMMENT 'Name of the regulatory agency contact person for this obligation. Used for questions or clarifications regarding compliance requirements.',
    `agency_contact_phone` STRING COMMENT 'Phone number of the regulatory agency contact person. Organizational contact information classified as confidential.',
    `completed_by` STRING COMMENT 'Name or identifier of the individual who completed this obligation. May differ from the originally assigned responsible party.',
    `completion_date` DATE COMMENT 'The actual date when this obligation was completed. Null if the obligation is still pending or in progress.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the obligation was marked as completed in the system. Provides audit trail for compliance verification.',
    `confirmation_number` STRING COMMENT 'Confirmation or tracking number received from the regulatory agency upon submission. Provides proof of submission for audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scheduled obligation record was first created in the system. Part of the audit trail for compliance tracking.',
    `days_until_due` STRING COMMENT 'Calculated number of days remaining until the obligation due date. Negative values indicate overdue obligations. Used for prioritization and escalation.',
    `documentation_required` STRING COMMENT 'Description of the documentation, reports, or records that must be prepared or submitted to fulfill this obligation. May include forms, certifications, monitoring data, or supporting evidence.',
    `due_date` DATE COMMENT 'The date by which this scheduled obligation must be completed to maintain regulatory compliance. Critical for compliance calendar management and deadline tracking.',
    `escalation_date` DATE COMMENT 'The date when this obligation was escalated to management or senior leadership. Null if no escalation has occurred.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this obligation has been escalated to management due to approaching deadline, complexity, or risk. True if escalated, false otherwise.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete this obligation. Used for resource planning and workload management.',
    `next_occurrence_date` DATE COMMENT 'The due date of the next scheduled occurrence of this recurring obligation. Automatically calculated based on recurrence frequency and pattern.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this scheduled obligation. Used for context and collaboration.',
    `obligation_description` STRING COMMENT 'Detailed description of the scheduled compliance obligation, including specific requirements, deliverables, and any special instructions for completion.',
    `obligation_number` STRING COMMENT 'Business-facing unique identifier for the scheduled obligation, formatted as OBL- followed by 8 digits. Used for tracking and reference in compliance communications.. Valid values are `^OBL-[0-9]{8}$`',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the scheduled obligation. Tracks whether the obligation is awaiting action, being worked on, completed, or past due.. Valid values are `pending|in_progress|completed|overdue|cancelled|deferred`',
    `obligation_title` STRING COMMENT 'Short descriptive title of the scheduled compliance obligation. Provides a human-readable summary of the task.',
    `obligation_type` STRING COMMENT 'Classification of the scheduled compliance obligation. Defines the nature of the regulatory task that must be completed. [ENUM-REF-CANDIDATE: permit_renewal|monitoring_report|regulatory_filing|compliance_certification|inspection|sampling|training_certification — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Business priority assigned to this obligation based on regulatory risk, penalty severity, and business impact. Critical obligations require immediate attention.. Valid values are `critical|high|medium|low`',
    `recurrence_frequency` STRING COMMENT 'The frequency at which this obligation recurs. Defines the schedule pattern for recurring compliance tasks such as quarterly monitoring reports or annual certifications. [ENUM-REF-CANDIDATE: one_time|daily|weekly|monthly|quarterly|semi_annual|annual|biennial|as_needed — 9 candidates stripped; promote to reference product]',
    `recurrence_pattern` STRING COMMENT 'Detailed recurrence pattern specification for complex schedules. May include specific days of month, week numbers, or custom scheduling rules.',
    `regulatory_agency` STRING COMMENT 'The government agency or regulatory body to which this obligation must be reported or submitted. Examples include EPA, state environmental departments, or local enforcement agencies.',
    `regulatory_driver` STRING COMMENT 'The specific regulation, permit condition, or regulatory citation that mandates this obligation. May reference EPA regulations, RCRA requirements, state environmental codes, or specific permit conditions.',
    `responsible_department` STRING COMMENT 'The department or functional area within the facility responsible for completing this obligation. Examples include Environmental Compliance, Operations, Safety, or Landfill Management.',
    `risk_level` STRING COMMENT 'Assessment of the regulatory and business risk associated with non-compliance. Based on potential penalties, environmental impact, and reputational consequences.. Valid values are `very_high|high|medium|low|very_low`',
    `scheduled_start_date` DATE COMMENT 'The planned date when work on this obligation should begin. Used for proactive task planning and resource allocation.',
    `source_system` STRING COMMENT 'The operational system from which this scheduled obligation record originated. Typically Enviance EHS Compliance Calendar Module or SAP S/4HANA EHS.',
    `submission_date` DATE COMMENT 'The date when compliance documentation was submitted to the regulatory agency. Null if submission has not yet occurred.',
    `submission_method` STRING COMMENT 'The method by which compliance documentation must be submitted to the regulatory agency. Examples include electronic portal, certified mail, or in-person delivery.. Valid values are `electronic|mail|in_person|email|portal|not_applicable`',
    `submission_required_flag` BOOLEAN COMMENT 'Indicates whether this obligation requires formal submission of documentation or reports to a regulatory agency. True if submission is required, false otherwise.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether specialized training or certification is required to complete this obligation. True if training is required, false otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this scheduled obligation record was last modified. Tracks the most recent change to any field in the record.',
    CONSTRAINT pk_scheduled_obligation PRIMARY KEY(`scheduled_obligation_id`)
) COMMENT 'Scheduled compliance obligations and recurring regulatory tasks that Waste Management must fulfill on defined frequencies. Covers permit renewal deadlines, quarterly monitoring report submissions, annual regulatory filings, semi-annual compliance certifications, monthly LFG monitoring rounds, and periodic waste characterization sampling. Tracks obligation ID, obligation type, regulatory driver (permit condition or regulation citation), responsible facility and department, due date, recurrence frequency, assigned responsible party, completion status, and days until due. Acts as the compliance calendar and task management backbone. Sourced from Enviance EHS compliance calendar module.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`audit_program` (
    `audit_program_id` BIGINT COMMENT 'Unique identifier for the audit program record. Primary key.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `owner_employee_id` BIGINT COMMENT 'Identifier of the corporate or regional EHS manager who owns and oversees this audit program. References workforce or employee master data.',
    `primary_lead_auditor_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `applicable_facilities` STRING COMMENT 'Comma-separated list or description of facilities covered by this audit program (e.g., All MRF facilities, Landfill sites in Region 3, TSDF facilities).',
    `approval_authority` STRING COMMENT 'Name or title of the executive or management authority who approved this audit program (e.g., VP of EHS, Chief Compliance Officer).',
    `approval_date` DATE COMMENT 'Date on which the audit program was formally approved by management.',
    `audit_frequency` STRING COMMENT 'Scheduled frequency at which audits under this program are conducted (Annual, Semi-Annual, Quarterly, Monthly, Biennial, Ad-Hoc).. Valid values are `Annual|Semi-Annual|Quarterly|Monthly|Biennial|Ad-Hoc`',
    `audit_methodology` STRING COMMENT 'Description of the audit methodology and approach used in this program (e.g., Process-based audit, Risk-based audit, Compliance checklist audit).',
    `audit_team_members` STRING COMMENT 'Comma-separated list of names or identifiers of additional audit team members assigned to this program.',
    `audit_type` STRING COMMENT 'Classification of the audit program by its primary focus and regulatory or standards framework (ISO 14001 internal audit, RCRA compliance audit, OSHA VPP audit, operational compliance review, ISO 45001 internal audit, integrated EHS audit).. Valid values are `ISO 14001 Internal Audit|RCRA Compliance Audit|OSHA VPP Audit|Operational Compliance Review|ISO 45001 Internal Audit|Integrated EHS Audit`',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated for this audit program, covering auditor time, travel, training, and related expenses.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `certification_body` STRING COMMENT 'Name of the external certification or accreditation body associated with this audit program, if applicable (e.g., BSI, DNV, UL).',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are mandatory for findings identified under this audit program (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit program record was first created in the source system.',
    `distribution_list` STRING COMMENT 'Comma-separated list of roles, departments, or individuals who receive audit reports and findings from this program.',
    `documentation_requirements` STRING COMMENT 'Description of documentation and records required to be reviewed or produced as part of audits under this program.',
    `effective_end_date` DATE COMMENT 'Date on which the audit program is scheduled to end or be reviewed for renewal. Nullable for ongoing programs.',
    `effective_start_date` DATE COMMENT 'Date on which the audit program becomes effective and audits under this program may commence.',
    `external_certification_flag` BOOLEAN COMMENT 'Indicates whether this audit program supports external certification or accreditation (e.g., ISO 14001, ISO 45001 certification) (True/False).',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Indicates whether follow-up audits are required to verify closure of corrective actions (True/False).',
    `iso_clauses` STRING COMMENT 'Specific ISO standard clauses addressed by this audit program (e.g., ISO 14001:2015 Clause 9.2, ISO 45001:2018 Clause 9.2).',
    `last_review_date` DATE COMMENT 'Date of the most recent management review of the audit program.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next management review of the audit program to assess effectiveness and make adjustments.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to the audit program.',
    `program_code` STRING COMMENT 'Unique business identifier code for the audit program, used for external reference and reporting. Typically follows organizational coding standards.. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_name` STRING COMMENT 'Descriptive name of the audit program (e.g., ISO 14001 Internal Audit Program FY2024, RCRA Compliance Audit Program).',
    `program_objectives` STRING COMMENT 'Stated objectives and goals of the audit program, including compliance verification, process improvement, risk mitigation, and certification maintenance.',
    `program_status` STRING COMMENT 'Current lifecycle status of the audit program (Active, Inactive, Suspended, Under Review, Archived).. Valid values are `Active|Inactive|Suspended|Under Review|Archived`',
    `regulatory_standards` STRING COMMENT 'List of applicable regulatory standards, frameworks, and requirements covered by this audit program (e.g., RCRA 40 CFR Part 264, ISO 14001:2015, OSHA 29 CFR 1910, Clean Air Act Title V).',
    `reporting_template` STRING COMMENT 'Name or reference to the standard reporting template or format used for audit reports generated under this program.',
    `risk_level` STRING COMMENT 'Overall risk level associated with the areas covered by this audit program, used for prioritization and resource allocation (Critical, High, Medium, Low).. Valid values are `Critical|High|Medium|Low`',
    `scope_description` STRING COMMENT 'Detailed description of the audit program scope, including applicable facilities, operations, processes, and regulatory or standards requirements covered.',
    `source_system` STRING COMMENT 'Name of the source system from which this audit program record originated (e.g., Enviance EHS, SAP EHS).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit program record was last updated in the source system.',
    CONSTRAINT pk_audit_program PRIMARY KEY(`audit_program_id`)
) COMMENT 'Master records for internal EHS audit programs conducted by Waste Managements corporate and regional EHS teams. Defines the audit program name, audit type (ISO 14001 internal audit, RCRA compliance audit, OSHA VPP audit, operational compliance review), audit scope and applicable facilities, audit frequency, lead auditor assignment, applicable regulatory standards and ISO clauses, and program status. Parent entity for individual inspection records generated under the program. Supports ISO 14001 Clause 9.2 internal audit requirements and corporate EHS governance. Sourced from Enviance EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` (
    `chemical_inventory_id` BIGINT COMMENT 'Unique identifier for the chemical inventory record. Primary key for the chemical inventory product.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Chemicals stored/used at facilities can be emission sources (fugitive VOC emissions, refrigerant leaks). Tracking which chemicals are associated with which emission sources supports air quality compli',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility where the chemical is stored or used. Links to the facility master data.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Chemicals in inventory represent hazards that must be in the hazard register. This link ensures all chemical hazards (flammability, toxicity, reactivity) are captured for risk management. Required for',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Chemical storage and usage at waste management facilities is governed by permits (RCRA hazardous waste permits, air permits for VOC storage, etc.). This FK links inventory records to the permit that a',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Chemicals sourced from vendors with regulatory certifications. Links vendor qualification for hazmat supply, SDS management, and regulatory reporting. Manufacturer_name already listed for removal unde',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Chemical inventory records at facilities should link to approved waste profiles for proper hazmat classification and handling procedures. This ensures consistency between compliance tracking and hazma',
    `average_daily_quantity` DECIMAL(18,2) COMMENT 'Average amount of the chemical present at the facility on a daily basis during the reporting year. Used for EPCRA Tier II reporting.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance. Used for precise identification in regulatory reporting.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `cercla_reportable_quantity` DECIMAL(18,2) COMMENT 'CERCLA reportable quantity in pounds. Releases of this amount or more within a 24-hour period must be reported to the National Response Center. Null if no RQ established.',
    `confidential_location_flag` BOOLEAN COMMENT 'Indicates whether the specific storage location is withheld from public disclosure in Tier II reporting due to trade secret or security concerns. Requires substantiation to state authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this chemical inventory record was first created in the Enviance EHS system. Used for audit trail and data lineage.',
    `ehs_flag` BOOLEAN COMMENT 'Indicates whether the chemical is listed as an Extremely Hazardous Substance under EPCRA Section 302. EHS chemicals trigger emergency planning and release reporting requirements.',
    `ehs_threshold_planning_quantity` DECIMAL(18,2) COMMENT 'EPCRA Section 302 threshold planning quantity for the EHS chemical in pounds. Facilities storing amounts at or above the TPQ must notify the SERC and LEPC. Null if not an EHS.',
    `epcra_section_313_flag` BOOLEAN COMMENT 'Indicates whether the chemical is a listed toxic chemical under EPCRA Section 313 requiring annual TRI reporting if threshold quantities are manufactured, processed, or otherwise used.',
    `ghs_environmental_hazard_class` STRING COMMENT 'GHS environmental hazard classification (e.g., hazardous to the aquatic environment acute category 1, chronic category 2). Derived from Section 2 of the SDS.',
    `ghs_health_hazard_class` STRING COMMENT 'GHS health hazard classification (e.g., acute toxicity category 3, carcinogenicity category 1A, skin corrosion category 1B). Derived from Section 2 of the SDS.',
    `ghs_physical_hazard_class` STRING COMMENT 'GHS physical hazard classification (e.g., flammable liquid category 2, oxidizing solid category 1, explosive division 1.1). Derived from Section 2 of the SDS.',
    `hmis_rating` STRING COMMENT 'HMIS rating in format Health-Flammability-Physical-PPE (e.g., 2-3-1-B). Used for workplace labeling and employee right-to-know programs.. Valid values are `^[0-4]-[0-4]-[0-4]-[A-Z]$`',
    `inventory_status` STRING COMMENT 'Current status of the chemical in facility inventory (active, depleted, discontinued, pending removal). Used to maintain accurate reporting and trigger re-ordering or disposal actions.. Valid values are `active|depleted|discontinued|pending_removal`',
    `last_inventory_date` DATE COMMENT 'Date of the most recent physical inventory verification for this chemical. EPCRA Tier II requires annual inventory updates; more frequent verification may be required for PSM-covered chemicals.',
    `manufacturer_name` STRING COMMENT 'Name of the chemical manufacturer or supplier as listed on the SDS and product label. Used for product traceability and supplier management.',
    `maximum_quantity_stored` DECIMAL(18,2) COMMENT 'Maximum amount of the chemical present at the facility at any time during the reporting year. Used for EPCRA Tier II threshold determination.',
    `nfpa_rating` STRING COMMENT 'NFPA 704 diamond rating in format Health-Flammability-Instability-Special (e.g., 2-3-1-OX). Used for emergency response and facility placarding.. Valid values are `^[0-4]-[0-4]-[0-4](-[A-Z]{0,3})?$`',
    `notes` STRING COMMENT 'Additional notes or comments regarding the chemical inventory record, including special handling instructions, regulatory exemptions, or facility-specific considerations.',
    `physical_state` STRING COMMENT 'Physical form of the chemical at ambient conditions (solid, liquid, gas, sludge, or compressed gas). Determines storage and handling requirements.. Valid values are `solid|liquid|gas|sludge|compressed_gas`',
    `product_identifier` STRING COMMENT 'Manufacturers product code, catalog number, or SKU for the specific chemical product. Used for procurement and inventory tracking.',
    `psm_covered_flag` BOOLEAN COMMENT 'Indicates whether the chemical is present in quantities that trigger OSHA Process Safety Management requirements (10,000 lbs threshold for most flammables, specific thresholds for listed chemicals).',
    `psm_threshold_quantity` DECIMAL(18,2) COMMENT 'OSHA PSM threshold quantity for the chemical in pounds. Facilities with amounts at or above this threshold must implement PSM program elements. Null if not a PSM-covered chemical.',
    `quantity_unit` STRING COMMENT 'Unit of measure for maximum and average daily quantities (pounds, kilograms, gallons, liters, cubic feet, cubic meters). Must be consistent with EPCRA reporting requirements.. Valid values are `pounds|kilograms|gallons|liters|cubic_feet|cubic_meters`',
    `rcra_generator_status_impact` STRING COMMENT 'Impact of this chemical on the facilitys RCRA hazardous waste generator status classification (none, conditionally exempt, small quantity, large quantity). Based on monthly generation quantities.. Valid values are `none|conditionally_exempt|small_quantity|large_quantity`',
    `reporting_year` STRING COMMENT 'Calendar year for which this inventory record applies. EPCRA Tier II reports are due by March 1 for the previous calendar year.',
    `sds_document_url` STRING COMMENT 'URL or file path to the electronic copy of the Safety Data Sheet in the Enviance EHS document management system. SDS must be readily accessible to employees.',
    `sds_revision_date` DATE COMMENT 'Date of the most recent revision of the Safety Data Sheet for this chemical. SDS must be updated within three months of new hazard information becoming available.',
    `source_system` STRING COMMENT 'Name of the source system from which this chemical inventory record originated (typically Enviance EHS chemical management module). Used for data lineage and integration troubleshooting.',
    `storage_condition` STRING COMMENT 'Special storage conditions required for the chemical (ambient, refrigerated, heated, pressurized, inert atmosphere). Derived from Section 7 of the SDS.. Valid values are `ambient|refrigerated|heated|pressurized|inert_atmosphere`',
    `storage_location` STRING COMMENT 'Specific location within the facility where the chemical is stored (e.g., building number, room, tank ID, outdoor storage area). Used for emergency response planning.',
    `storage_type` STRING COMMENT 'Type of container or storage system used for the chemical (tank, drum, tote, cylinder, bag, bulk storage, other). Determines inspection and containment requirements. [ENUM-REF-CANDIDATE: tank|drum|tote|cylinder|bag|bulk_storage|other — 7 candidates stripped; promote to reference product]',
    `tier_ii_reporting_flag` BOOLEAN COMMENT 'Indicates whether this chemical must be included in the annual EPCRA Tier II inventory report submitted to SERC, LEPC, and local fire department (threshold: 10,000 lbs or EHS TPQ).',
    `un_na_number` STRING COMMENT 'Four-digit identification number assigned by the United Nations or Department of Transportation for hazardous materials transport. Used on shipping papers and placards.. Valid values are `^(UN|NA)[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this chemical inventory record was last modified in the Enviance EHS system. Used for audit trail and change tracking.',
    CONSTRAINT pk_chemical_inventory PRIMARY KEY(`chemical_inventory_id`)
) COMMENT 'Facility-level inventory of hazardous chemicals and substances stored or used at Waste Management sites, maintained for EPCRA Tier II reporting, RCRA generator status determination, and process safety management (PSM) threshold tracking. Tracks chemical name, CAS number, EPA waste code if applicable, physical and health hazard classifications (GHS/SDS), maximum quantity stored, average daily quantity, storage location within facility, container type, and whether the chemical exceeds CERCLA reportable quantity or EPCRA Section 312 threshold. Updated at least annually for Tier II submission. Sourced from Enviance EHS chemical management module.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` (
    `ghg_regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the greenhouse gas regulatory submission record.',
    `facility_id` BIGINT COMMENT 'Reference to the Waste Management facility subject to GHG reporting requirements.',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: GHG regulatory submissions (EPA GHGRP, state programs) are prepared from compiled GHG inventories. The submission references the underlying inventory data that was verified and certified. Standard reg',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: GHG emissions reporting is required under air permits (Title V, EPA Subpart HH for landfills). This FK links GHG submissions to the air permit that governs emission reporting requirements, enabling pe',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: GHG regulatory submissions are a specialized type of regulatory submission. This FK links the detailed GHG calculation record to the parent regulatory submission record, enabling unified submission tr',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GHG submissions require employee ownership for data quality and regulatory accountability. Linking supports audit trails, workload management for sustainability staff, and performance tracking for cli',
    `activity_data_input` STRING COMMENT 'Description of the activity data inputs used in the emission calculation (e.g., waste in place tonnage, fuel consumption volume, vehicle miles traveled).',
    `activity_data_unit` STRING COMMENT 'Unit of measure for the activity data (e.g., metric tons, gallons, cubic feet, vehicle miles).',
    `activity_data_value` DECIMAL(18,2) COMMENT 'Numeric value of the activity data used in the emission calculation.',
    `calculated_co2e_quantity` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions calculated and expressed in metric tons of carbon dioxide equivalent (CO2e) using EPA-specified global warming potentials.',
    `calculation_methodology` STRING COMMENT 'EPA-approved calculation methodology tier used to quantify GHG emissions (Tier 1-4, direct measurement, mass balance, or continuous emissions monitoring system). [ENUM-REF-CANDIDATE: tier_1|tier_2|tier_3|tier_4|direct_measurement|mass_balance|cems — 7 candidates stripped; promote to reference product]',
    `calculation_notes` STRING COMMENT 'Additional notes, assumptions, or explanations regarding the GHG emission calculation methodology and data sources.',
    `co2e_unit` STRING COMMENT 'Unit of measure for the calculated CO2e quantity, standardized as metric tons CO2e per EPA requirements.. Valid values are `metric_tons_co2e`',
    `corporate_sustainability_flag` BOOLEAN COMMENT 'Indicates whether this submission is also used for corporate sustainability GHG inventory and ESG reporting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GHG regulatory submission record was first created in the system.',
    `data_quality_rating` STRING COMMENT 'Assessment of the quality and reliability of the activity data and emission factors used in the calculation.. Valid values are `high|medium|low`',
    `emission_factor_applied` DECIMAL(18,2) COMMENT 'EPA-approved emission factor applied in the GHG calculation (e.g., methane generation rate constant, CO2 emission factor per fuel type).',
    `emission_factor_unit` STRING COMMENT 'Unit of measure for the emission factor (e.g., kg CO2e per gallon, metric tons CH4 per metric ton waste).',
    `emission_source_type` STRING COMMENT 'Category of emission source being reported: landfill gas methane (Subpart HH), waste-to-energy combustion (Subpart C), stationary combustion, mobile fleet sources, or fugitive emissions.. Valid values are `lfg_methane|wte_combustion|stationary_combustion|mobile_source|fugitive`',
    `epa_confirmation_number` STRING COMMENT 'Confirmation number issued by EPA e-GGRT portal upon successful submission of the GHG report.',
    `epa_subpart` STRING COMMENT 'Specific EPA 40 CFR Part 98 subpart under which the emissions are being reported (e.g., Subpart HH for landfills, Subpart C for stationary combustion).',
    `facility_epa_number` STRING COMMENT 'EPA-assigned facility identifier used for regulatory reporting and tracking.',
    `facility_type` STRING COMMENT 'Classification of the facility type for GHG reporting purposes (landfill, waste-to-energy, materials recovery facility, transfer station, fleet depot, treatment storage disposal facility).. Valid values are `landfill|wte|mrf|transfer_station|fleet_depot|tsdf`',
    `ghg_pollutant` STRING COMMENT 'Specific greenhouse gas pollutant being reported: methane (CH4), carbon dioxide (CO2), nitrous oxide (N2O), hydrofluorocarbons (HFC), perfluorocarbons (PFC), sulfur hexafluoride (SF6), or nitrogen trifluoride (NF3). [ENUM-REF-CANDIDATE: CH4|CO2|N2O|HFC|PFC|SF6|NF3 — 7 candidates stripped; promote to reference product]',
    `global_warming_potential` DECIMAL(18,2) COMMENT 'EPA-specified global warming potential factor used to convert the GHG pollutant to CO2 equivalent (e.g., CH4 = 25, N2O = 298).',
    `reporting_threshold_met_flag` BOOLEAN COMMENT 'Indicates whether the facility met the EPA reporting threshold for mandatory GHG reporting (typically 25,000 metric tons CO2e per year).',
    `reporting_year` STRING COMMENT 'Calendar year for which greenhouse gas emissions are being reported.',
    `revision_number` STRING COMMENT 'Version number of the GHG submission if the report has been revised or resubmitted after initial filing.',
    `revision_reason` STRING COMMENT 'Explanation for why the GHG submission was revised or resubmitted after the initial filing.',
    `source_system` STRING COMMENT 'Name of the operational system from which the GHG emission data was sourced (e.g., Enviance EHS, SAP EHS, sustainability domain feeds).',
    `submission_date` DATE COMMENT 'Date when the GHG emission report was submitted to EPA e-GGRT portal.',
    `submission_deadline_date` DATE COMMENT 'Regulatory deadline date by which the GHG report must be submitted to EPA (typically March 31 following the reporting year).',
    `submission_number` STRING COMMENT 'Unique business identifier for the GHG regulatory submission assigned by the reporting system or EPA e-GGRT portal.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the GHG regulatory submission in the EPA e-GGRT workflow.. Valid values are `draft|submitted|accepted|rejected|resubmitted|withdrawn`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the GHG regulatory submission record was last modified in the system.',
    `verification_date` DATE COMMENT 'Date when the GHG emission calculation and submission were verified or quality-assured.',
    `verification_status` STRING COMMENT 'Status of third-party verification or internal quality assurance review of the GHG emission calculation and submission.. Valid values are `pending|verified|failed|not_required`',
    `verifier_name` STRING COMMENT 'Name of the third-party verifier or internal auditor who verified the GHG emission calculation.',
    CONSTRAINT pk_ghg_regulatory_submission PRIMARY KEY(`ghg_regulatory_submission_id`)
) COMMENT 'Greenhouse gas (GHG) emission calculation and reporting records for Waste Management facilities subject to EPA Mandatory Reporting Rule (40 CFR Part 98). Covers landfill gas (LFG) methane emissions (Subpart HH), WTE combustion emissions (Subpart C), fleet mobile source emissions, and stationary combustion sources. Tracks emission record ID, facility, reporting year, emission source type, GHG pollutant (CH4, CO2, N2O), calculation methodology, activity data inputs, emission factor applied, calculated CO2e quantity (metric tons), and verification status. Supports EPA e-GGRT annual submission and corporate sustainability GHG inventory. Sourced from Enviance EHS and sustainability domain feeds.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the environmental, health, and safety risk assessment record.',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: Risk assessments evaluate hazards of specific materials. Procurement must consider findings when sourcing alternatives or approving new materials. Links risk management to procurement decisions for sa',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Risk assessments may be triggered by inspection findings that identify hazards or compliance gaps. This FK links risk assessments to the inspection that triggered them, enabling inspection-driven risk',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Risk assessments require qualified employees. Linking enables competency verification, workload tracking for EHS staff, audit trails for ISO 14001/45001 compliance, and quality assurance of assessment',
    `corrective_action_id` BIGINT COMMENT 'Reference to the formal corrective action record created to address risks identified in this assessment. Links to the regulatory_corrective_action product for tracking implementation of recommended controls.',
    `facility_id` BIGINT COMMENT 'Reference to the Waste Management facility where the assessed operation, process, or activity occurs. Links to landfill, Materials Recovery Facility (MRF), transfer station, Waste-to-Energy (WTE) plant, or other operational site.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Risk assessments feed the hazard register. This link ensures identified compliance risks are captured in the facilitys master hazard inventory. Required for ISO 14001 and ISO 45001 integration, demon',
    `incident_id` BIGINT COMMENT 'Reference to a specific EHS incident that triggered this risk assessment. Applicable when the assessment is conducted as part of incident investigation or root cause analysis.',
    `jha_id` BIGINT COMMENT 'Foreign key linking to safety.jha. Business justification: Risk assessments often identify hazards that require JHA development or updates. This link tracks which JHAs were created or revised based on risk assessment findings. Essential for demonstrating cont',
    `permit_id` BIGINT COMMENT 'Reference to the environmental or operational permit under which this risk assessment is conducted. Applicable when the assessment is required by permit conditions (e.g., air permit, water discharge permit, RCRA permit).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Risk assessments evaluate compliance with regulatory requirements under ISO 14001 and ISO 45001 frameworks. This FK replaces the denormalized regulatory_citation STRING field with a structured relatio',
    `assessment_date` DATE COMMENT 'Date when the risk assessment was conducted or completed. Represents the principal business event timestamp for this assessment record.',
    `assessment_number` STRING COMMENT 'Business-facing unique identifier or reference number for the risk assessment, used for tracking and reporting purposes.',
    `assessment_reviewed_by` STRING COMMENT 'Name or identifier of the individual who reviewed and approved the risk assessment. Typically a senior EHS manager or facility director.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment. Draft indicates initial preparation, In Review indicates management or EHS review in progress, Approved indicates formal acceptance, Active indicates current operational use, Superseded indicates replaced by newer assessment, Archived indicates historical record retention.. Valid values are `draft|in_review|approved|active|superseded|archived`',
    `assessment_type` STRING COMMENT 'Classification of the risk assessment methodology applied. Job Hazard Analysis (JHA) evaluates task-level hazards, Process Hazard Analysis (PHA) evaluates process-level risks, Environmental Aspect and Impact Assessment evaluates environmental consequences, and Operational Risk Review evaluates broader operational risks.. Valid values are `job_hazard_analysis|process_hazard_analysis|environmental_aspect_impact|operational_risk_review|facility_risk_assessment|activity_risk_assessment`',
    `associated_risk_or_impact` STRING COMMENT 'Description of the potential consequence or impact if the identified hazard or environmental aspect is realized. For safety, examples include injury, illness, or fatality. For environmental, examples include air quality degradation, water contamination, soil pollution, or contribution to climate change (CO2e emissions).',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether this risk assessment has identified the need for formal corrective action to address unacceptable residual risk. True if corrective action is required, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was first created in the system. Used for audit trail and data lineage purposes.',
    `environmental_impact_category` STRING COMMENT 'Classification of the environmental impact associated with the identified environmental aspect. Used for ISO 14001 environmental aspect and impact assessments. [ENUM-REF-CANDIDATE: air_emissions|water_discharge|soil_contamination|waste_generation|noise|odor|greenhouse_gas|resource_depletion — 8 candidates stripped; promote to reference product]',
    `existing_controls` STRING COMMENT 'Description of current control measures, safeguards, or mitigation strategies already in place to manage the identified hazard or environmental aspect. Examples include engineering controls (guards, ventilation), administrative controls (procedures, training, permits), or Personal Protective Equipment (PPE) requirements.',
    `hazard_category` STRING COMMENT 'Classification of the identified hazard or environmental aspect. Physical hazards include struck-by, caught-in, fall hazards. Chemical hazards include exposure to hazardous substances. Biological hazards include exposure to pathogens. Ergonomic hazards include repetitive motion or lifting. Environmental aspects include emissions, discharges, waste generation. Operational hazards include equipment failure or process upset. Regulatory hazards include non-compliance risk. [ENUM-REF-CANDIDATE: physical|chemical|biological|ergonomic|environmental|operational|regulatory — 7 candidates stripped; promote to reference product]',
    `hazard_identified` STRING COMMENT 'Description of the specific hazard, environmental aspect, or risk factor identified during the assessment. For occupational safety, examples include struck-by hazards from moving vehicles, exposure to hazardous waste, ergonomic strain, or confined space entry risks. For environmental aspects, examples include air emissions, wastewater discharge, soil contamination, or greenhouse gas (GHG) emissions.',
    `iso_clause_reference` STRING COMMENT 'Reference to the specific ISO 14001 or ISO 45001 clause that this risk assessment fulfills. Typically Clause 6.1 (Actions to address risks and opportunities) or Clause 6.1.2 (Hazard identification and assessment of risks and opportunities).',
    `likelihood_rating` STRING COMMENT 'Numerical rating representing the probability or frequency that the identified hazard or environmental aspect will occur. Typically scored on a scale of 1 to 5, where 1 is rare and 5 is almost certain. Used in conjunction with severity rating to calculate risk priority.',
    `management_review_date` DATE COMMENT 'Date when this risk assessment was reviewed by senior management as part of the ISO 14001 or ISO 45001 management review process.',
    `management_review_required_flag` BOOLEAN COMMENT 'Indicates whether this risk assessment requires formal management review due to high residual risk level or significant operational impact. True if management review is required, False otherwise.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic review or reassessment of this risk assessment. ISO 14001 and ISO 45001 require periodic review of risk assessments to ensure continued relevance and accuracy.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to this risk assessment. May include stakeholder input, lessons learned, or special considerations.',
    `operation_scope` STRING COMMENT 'Description of the specific operation, process, activity, or work area covered by this risk assessment. Examples include residential collection route operations, landfill cell compaction, MRF sorting line operations, hazardous waste handling, fleet maintenance activities, or leachate management.',
    `ppe_required` STRING COMMENT 'Description of Personal Protective Equipment (PPE) required to manage the identified hazard. Examples include hard hats, safety glasses, gloves, respirators, hearing protection, high-visibility vests, or chemical-resistant suits.',
    `recommended_additional_controls` STRING COMMENT 'Description of recommended additional control measures, safeguards, or mitigation strategies to further reduce residual risk to an acceptable level. May include engineering improvements, enhanced training, revised procedures, or additional PPE.',
    `regulatory_citation` STRING COMMENT 'Reference to applicable regulatory requirement, standard, or permit condition that drives this risk assessment. Examples include EPA regulations, OSHA standards (29 CFR 1910), DOT requirements (49 CFR), RCRA requirements, Clean Air Act provisions, or state environmental regulations.',
    `residual_risk_level` STRING COMMENT 'Classification of the remaining risk level after existing controls are applied. Low indicates acceptable risk with current controls. Medium indicates risk requiring monitoring. High indicates risk requiring additional controls. Very High indicates unacceptable risk requiring immediate action.. Valid values are `low|medium|high|very_high`',
    `review_date` DATE COMMENT 'Date when the risk assessment was formally reviewed and approved by management or EHS leadership.',
    `risk_priority_number` STRING COMMENT 'Calculated risk priority score, typically the product of likelihood rating and severity rating. Used to rank and prioritize risks for control implementation. Higher RPN values indicate higher priority for risk mitigation.',
    `safety_impact_category` STRING COMMENT 'Classification of the occupational health and safety impact associated with the identified hazard. Used for ISO 45001 hazard identification and risk assessments.. Valid values are `injury|illness|fatality|near_miss|property_damage`',
    `severity_rating` STRING COMMENT 'Numerical rating representing the magnitude of harm or impact if the identified hazard or environmental aspect is realized. Typically scored on a scale of 1 to 5, where 1 is negligible and 5 is catastrophic. Used in conjunction with likelihood rating to calculate risk priority.',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this risk assessment data originated. Typically Enviance EHS or SAP EHS module.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether this risk assessment has identified the need for specific training to manage the identified hazard or environmental aspect. True if training is required, False otherwise. Examples include HAZWOPER training, CDL training, confined space entry training, or equipment-specific training.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was last modified in the system. Used for audit trail and change tracking purposes.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'EHS risk assessments conducted for Waste Management operations, facilities, and activities under ISO 14001 and ISO 45001 frameworks. Covers job hazard analyses (JHA), process hazard analyses (PHA), environmental aspect and impact assessments, and operational risk reviews. Tracks assessment ID, assessment type, facility and operation scope, assessment date, identified hazard or environmental aspect, associated risk or impact, likelihood rating, severity rating, risk priority number (RPN), existing controls, residual risk level, and recommended additional controls. Supports ISO 14001 Clause 6.1 and ISO 45001 Clause 6.1 hazard identification and risk assessment obligations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`regulated_facility` (
    `regulated_facility_id` BIGINT COMMENT 'Unique identifier for the regulated facility record. Primary key for compliance tracking and regulatory reporting. [ROLE: MASTER_RESOURCE]',
    `facility_id` BIGINT COMMENT 'EPA Facility Registry Service (FRS) identifier. Unique federal identifier assigned by EPA for tracking environmental compliance across all federal programs.',
    `active_violations_count` STRING COMMENT 'Current number of unresolved regulatory violations at this facility. Calculated from violation_notice records with status = open or pending. Used for compliance risk assessment.',
    `address_line_1` STRING COMMENT 'Primary street address of the regulated facility. Used for regulatory correspondence, inspection scheduling, and emergency response coordination.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number, suite, or unit. Optional field for additional location details.',
    `applicable_regulatory_programs` STRING COMMENT 'Comma-separated list of federal and state environmental programs applicable to this facility. Examples: RCRA Subtitle D, Title V Air, NPDES Water, SPCC, EPCRA Tier II, SWIS. Determines compliance obligations and reporting requirements.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the design capacity value. TPD = Tons Per Day (common for landfills and WTE), cubic yards (transfer stations), tons per hour (MRFs).. Valid values are `tons_per_day|cubic_yards|tons_per_hour|gallons|cubic_meters`',
    `city` STRING COMMENT 'City or municipality where the facility is located. Used for local jurisdiction compliance and LEA coordination.',
    `compliance_risk_level` STRING COMMENT 'Overall compliance risk assessment for the facility. Low = no violations, good compliance history; Medium = minor violations or aging permits; High = multiple violations or major non-compliance; Critical = enforcement action pending or operations at risk. Used for prioritizing compliance resources.. Valid values are `low|medium|high|critical`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the facility location. Determines applicable national environmental regulations and international reporting requirements.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulated facility record was first created in the system. Used for data lineage and audit trail purposes.',
    `design_capacity` DECIMAL(18,2) COMMENT 'Maximum permitted operational capacity of the facility. Units vary by facility type: TPD (Tons Per Day) for landfills and WTE plants, cubic yards for transfer stations, tons per hour for MRFs. Used for permit compliance and capacity planning.',
    `facility_closure_date` DATE COMMENT 'Date the facility permanently ceased operations. Null for active facilities. Used for post-closure monitoring and long-term stewardship tracking.',
    `facility_code` STRING COMMENT 'Internal business identifier code for the facility. Used for cross-system integration with SAP EHS, Enviance, and operational systems.',
    `facility_name` STRING COMMENT 'Official business name of the regulated facility as registered with regulatory agencies. Used for permit applications, inspection reports, and regulatory correspondence.',
    `facility_opened_date` DATE COMMENT 'Date the facility first began operations. Used for facility age analysis, permit history tracking, and closure planning.',
    `facility_type` STRING COMMENT 'Classification of the facility based on its primary operational function. Determines applicable regulatory programs and compliance requirements. MRF = Materials Recovery Facility, WTE = Waste-to-Energy, TSDF = Treatment Storage and Disposal Facility. [ENUM-REF-CANDIDATE: landfill|mrf|transfer_station|wte_plant|tsdf|hauling_depot|collection_yard|maintenance_facility|administrative_office — 9 candidates stripped; promote to reference product]',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 14001 Environmental Management System certification. True = certified, False = not certified. Certification demonstrates commitment to environmental performance improvement.',
    `iso_45001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 45001 Occupational Health and Safety Management System certification. True = certified, False = not certified. Certification demonstrates commitment to worker safety.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection conducted at this facility. Used for compliance tracking and inspection frequency analysis.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility in decimal degrees. Used for GIS mapping, environmental monitoring zone determination, and emergency response planning.',
    `lea_jurisdiction` STRING COMMENT 'Name of the Local Enforcement Agency with jurisdiction over this facility. LEAs conduct inspections and enforce state solid waste regulations at the local level.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility in decimal degrees. Used for GIS mapping, environmental monitoring zone determination, and emergency response planning.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code classifying the facilitys primary business activity. Used for regulatory applicability determination and industry benchmarking. Common codes: 562111 (Solid Waste Collection), 562212 (Solid Waste Landfill), 562213 (Solid Waste Combustors and Incinerators), 562920 (Materials Recovery Facilities).',
    `next_scheduled_inspection_date` DATE COMMENT 'Anticipated date of the next regulatory inspection. Based on inspection frequency requirements and agency scheduling. Used for preparation and resource planning.',
    `notes` STRING COMMENT 'Free-text field for additional regulatory or operational notes about the facility. Used for documenting special conditions, historical context, or unique compliance considerations.',
    `operating_permit_number` STRING COMMENT 'Primary operating permit number issued by the state or local regulatory agency. Required for legal operation of the facility. Links to detailed permit records in Enviance EHS.',
    `operational_status` STRING COMMENT 'Current operational state of the facility independent of regulatory status. Operational = actively processing waste, Non-operational = temporarily idle, Seasonal = operates during specific periods, Standby = ready but not active, Decommissioned = permanently shut down.. Valid values are `operational|non_operational|seasonal|standby|decommissioned`',
    `permit_expiration_date` DATE COMMENT 'Expiration date of the primary operating permit. Critical for compliance tracking and permit renewal planning. Facilities cannot operate beyond this date without renewal.',
    `permitted_waste_types` STRING COMMENT 'Comma-separated list of waste types the facility is permitted to accept. Examples: MSW (Municipal Solid Waste), C&D (Construction and Demolition), industrial, hazardous, medical, e-waste, universal waste. Determines operational scope and compliance requirements.',
    `post_closure_monitoring_end_date` DATE COMMENT 'Date when post-closure monitoring obligations end. Typically 30 years after closure for landfills. Null if monitoring not required or facility still active.',
    `post_closure_monitoring_required` BOOLEAN COMMENT 'Indicates whether the facility requires post-closure environmental monitoring after operations cease. True = monitoring required (typical for landfills), False = no monitoring required. Determines long-term compliance obligations.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the facility location. Used for geographic analysis and regulatory jurisdiction determination.',
    `primary_regulatory_contact_email` STRING COMMENT 'Email address of the primary regulatory contact. Used for regulatory correspondence, inspection notifications, and compliance alerts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_regulatory_contact_name` STRING COMMENT 'Full name of the primary internal contact responsible for regulatory compliance at this facility. Typically the facility manager, EHS manager, or compliance officer.',
    `primary_regulatory_contact_phone` STRING COMMENT 'Phone number of the primary regulatory contact. Used for urgent regulatory communications and emergency response coordination.',
    `rcra_generator_status` STRING COMMENT 'RCRA hazardous waste generator classification. LQG = Large Quantity Generator (≥1000 kg/month), SQG = Small Quantity Generator (100-1000 kg/month), VSQG = Very Small Quantity Generator (<100 kg/month). Determines hazardous waste management requirements.. Valid values are `lqg|sqg|vsqg|not_applicable`',
    `regional_epa_office` STRING COMMENT 'EPA regional office with jurisdiction over this facility. Determines which EPA regional office handles permits, inspections, and enforcement actions. [ENUM-REF-CANDIDATE: region_1|region_2|region_3|region_4|region_5|region_6|region_7|region_8|region_9|region_10 — 10 candidates stripped; promote to reference product]',
    `regulatory_status` STRING COMMENT 'Current regulatory compliance status of the facility. Active = operational and compliant, Inactive = temporarily non-operational, Pending closure = in closure process, Closed = permanently closed, Suspended = operations halted due to violations, Under review = regulatory investigation in progress.. Valid values are `active|inactive|pending_closure|closed|suspended|under_review`',
    `sic_code` STRING COMMENT 'Four-digit SIC code for legacy regulatory reporting. Still required by some state agencies and EPA programs. Common codes: 4953 (Refuse Systems), 4212 (Local Trucking Without Storage).',
    `source_system` STRING COMMENT 'System of record that originated this regulated facility data. Enviance EHS = primary compliance system, SAP EHS = enterprise EHS module, Manual entry = data entered directly by compliance staff.. Valid values are `enviance_ehs|sap_ehs|manual_entry`',
    `state_province` STRING COMMENT 'State or province code where the facility is located. Determines applicable state environmental regulations and reporting requirements.',
    `title_v_designation` STRING COMMENT 'Clean Air Act Title V operating permit classification. Major source = emissions exceed threshold limits, Minor source = below thresholds, Synthetic minor = voluntarily limited emissions. Determines air quality monitoring and reporting requirements.. Valid values are `major_source|minor_source|synthetic_minor|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulated facility record was last modified. Used for change tracking and data quality monitoring.',
    CONSTRAINT pk_regulated_facility PRIMARY KEY(`regulated_facility_id`)
) COMMENT 'Compliance-specific master record for each regulated facility or operational site within Waste Managements portfolio, capturing the regulatory identity and classification attributes needed for EHS compliance management. Tracks facility ID, facility name, physical address, EPA facility ID (FRS ID), state facility ID, facility type (landfill, MRF, transfer station, WTE plant, TSDF, hauling depot), RCRA generator status (LQG/SQG/VSQG), Title V major/minor source designation, applicable regulatory programs, primary regulatory contact, and compliance status. Distinct from the asset domains facility master — this record owns the regulatory classification and agency-facing identity of each site. Sourced from Enviance EHS and SAP EHS.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`facility_audit` (
    `facility_audit_id` BIGINT COMMENT 'Unique identifier for this facility audit record. Primary key.',
    `audit_program_id` BIGINT COMMENT 'Foreign key linking to the audit program under which this facility audit was conducted',
    `regulated_facility_id` BIGINT COMMENT 'Foreign key linking to the regulated facility that was audited',
    `audit_completion_date` DATE COMMENT 'Date on which the audit was completed and findings were finalized.',
    `audit_date` DATE COMMENT 'Date on which the audit was conducted at this facility. Explicitly identified in detection phase.',
    `audit_report_reference` STRING COMMENT 'Reference number or document identifier for the audit report generated from this facility audit.',
    `audit_result` STRING COMMENT 'Overall result or outcome of the facility audit. Explicitly identified in detection phase.',
    `audit_status` STRING COMMENT 'Current status of this facility audit execution. Explicitly identified in detection phase.',
    `auditor_assigned` STRING COMMENT 'Name or identifier of the auditor assigned to conduct this specific facility audit. Explicitly identified in detection phase.',
    `certification_outcome` STRING COMMENT 'Certification status resulting from this facility audit, if applicable to external certification programs. Explicitly identified in detection phase.',
    `critical_findings_count` BIGINT COMMENT 'Number of critical or high-severity findings identified during this facility audit. Explicitly identified in detection phase.',
    `findings_count` BIGINT COMMENT 'Total number of findings identified during this facility audit. Explicitly identified in detection phase.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next audit of this facility under this audit program. Explicitly identified in detection phase.',
    CONSTRAINT pk_facility_audit PRIMARY KEY(`facility_audit_id`)
) COMMENT 'This association product represents the execution of an audit program at a specific regulated facility. It captures the audit event including scheduling, execution, findings, and outcomes. Each record links one audit_program to one regulated_facility with attributes that exist only in the context of this specific audit execution.. Existence Justification: In Waste Management EHS compliance operations, audit programs are executed across multiple facilities, and each facility is subject to multiple audit programs (ISO 14001, RCRA, OSHA VPP, operational reviews). Compliance managers actively schedule facility audits by selecting facilities for each program cycle, assign auditors, track execution, and manage findings. The facility audit is a recognized operational entity with substantial relationship data including audit dates, results, findings counts, auditor assignments, and certification outcomes.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`permit_requirement` (
    `permit_requirement_id` BIGINT COMMENT 'Unique identifier for this permit-requirement mapping record. Primary key.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to the permit that must satisfy this regulatory requirement',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement that applies to this permit',
    `applicability_determination` STRING COMMENT 'Documented determination of how and why this regulatory requirement applies to this specific permit. Captures the legal and operational reasoning for the mapping.',
    `citation_reference` STRING COMMENT 'Specific citation or section reference from the regulatory requirement that applies to this permit. Allows for granular tracking when only portions of a requirement apply.',
    `compliance_status` STRING COMMENT 'Current compliance status of this permit with respect to this specific regulatory requirement. Tracks whether the permit holder is meeting the obligation.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this permit-requirement mapping was created in the system.',
    `effective_date` DATE COMMENT 'Date on which this regulatory requirement became applicable to this specific permit. May differ from the requirements general effective date based on permit-specific circumstances.',
    `exemption_claimed` BOOLEAN COMMENT 'Indicates whether an exemption from this regulatory requirement has been claimed for this permit. If true, exemption documentation should be maintained.',
    `expiration_date` DATE COMMENT 'Date on which this regulatory requirement ceases to apply to this specific permit. May be due to permit expiration, requirement sunset, or exemption grant.',
    `last_compliance_verification_date` DATE COMMENT 'Date on which compliance with this requirement was last verified for this permit through inspection, audit, or self-assessment.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this permit-requirement mapping was last modified.',
    `monitoring_frequency_override` STRING COMMENT 'Permit-specific monitoring frequency that overrides the default monitoring requirement. Captures permit conditions that impose more or less frequent monitoring than the base requirement.',
    `next_compliance_verification_date` DATE COMMENT 'Scheduled date for the next compliance verification activity for this permit-requirement combination.',
    `notes` STRING COMMENT 'Free-text notes documenting compliance activities, issues, or special circumstances related to this permit-requirement mapping.',
    `reporting_frequency_override` STRING COMMENT 'Permit-specific reporting frequency that overrides the default reporting requirement. Captures permit conditions that impose different reporting schedules than the base requirement.',
    `responsible_officer_name` STRING COMMENT 'Name of the compliance officer or facility manager responsible for ensuring this specific permit meets this specific requirement.',
    CONSTRAINT pk_permit_requirement PRIMARY KEY(`permit_requirement_id`)
) COMMENT 'This association product represents the regulatory compliance mapping between permit and regulatory_requirement. It captures the specific requirements that each permit must satisfy and tracks compliance status, applicability determinations, and requirement-specific monitoring and reporting obligations. Each record links one permit to one regulatory_requirement with attributes that exist only in the context of this relationship.. Existence Justification: In environmental compliance operations, permits must satisfy multiple regulatory requirements simultaneously (e.g., a landfill permit implements RCRA Subtitle D requirements, state solid waste codes, air quality standards, and stormwater management rules). Conversely, each regulatory requirement applies to multiple permits across different facilities and permit types. Compliance officers actively manage these mappings during permit application, renewal, and ongoing compliance monitoring, tracking status, applicability determinations, and requirement-specific obligations for each permit-requirement combination.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`monitoring_program` (
    `monitoring_program_id` BIGINT COMMENT 'Primary key for monitoring_program',
    `facility_id` BIGINT COMMENT 'Reference to the waste management facility where this monitoring program is conducted.',
    `permit_id` BIGINT COMMENT 'Reference to the environmental permit that requires or authorizes this monitoring program.',
    `parent_monitoring_program_id` BIGINT COMMENT 'Self-referencing FK on monitoring_program (parent_monitoring_program_id)',
    `action_level` DECIMAL(18,2) COMMENT 'Threshold value that triggers corrective action or enhanced monitoring when exceeded, typically set below the regulatory limit.',
    `analytical_method` STRING COMMENT 'Laboratory analytical method or technique used to analyze collected samples, typically referenced by EPA method number or standard protocol.',
    `chain_of_custody_required` BOOLEAN COMMENT 'Indicates whether formal chain of custody documentation is required for sample handling and transport.',
    `compliance_status` STRING COMMENT 'Current compliance status of the monitoring program based on recent monitoring results and regulatory requirements.',
    `corrective_action_plan_reference` STRING COMMENT 'Document reference or identifier for any corrective action plan associated with non-compliance or exceedances detected by this program.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this monitoring program record was first created in the system.',
    `data_management_system` STRING COMMENT 'Name of the software system or database used to store, manage, and report monitoring data (e.g., Enviance EHS, SAP EHS).',
    `data_validation_level` STRING COMMENT 'EPA data validation level applied to analytical results, indicating the rigor of quality assurance review.',
    `effective_end_date` DATE COMMENT 'Date when the monitoring program is scheduled to terminate or was terminated, nullable for ongoing programs.',
    `effective_start_date` DATE COMMENT 'Date when the monitoring program became or will become active and monitoring activities commenced.',
    `estimated_annual_cost` DECIMAL(18,2) COMMENT 'Projected annual cost in USD for conducting this monitoring program, including sampling, analysis, reporting, and labor.',
    `iso_14001_applicable` BOOLEAN COMMENT 'Indicates whether this monitoring program is part of the organizations ISO 14001 Environmental Management System certification scope.',
    `iso_45001_applicable` BOOLEAN COMMENT 'Indicates whether this monitoring program supports ISO 45001 Occupational Health and Safety Management System requirements.',
    `laboratory_certification_number` STRING COMMENT 'Official certification or accreditation number of the laboratory authorized to perform environmental analyses.',
    `laboratory_name` STRING COMMENT 'Name of the certified laboratory performing analytical testing for samples collected under this program.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection or audit of this monitoring program.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this monitoring program record was most recently updated or modified.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this monitoring program record.',
    `monitoring_frequency` STRING COMMENT 'Required frequency at which monitoring activities must be performed as specified by regulatory requirements or permit conditions.',
    `monitoring_location_count` STRING COMMENT 'Total number of distinct sampling or monitoring locations included in this program.',
    `next_inspection_date` DATE COMMENT 'Scheduled or anticipated date for the next regulatory inspection or audit of this monitoring program.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or renewal of the monitoring program requirements.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to the monitoring program.',
    `parameter_monitored` STRING COMMENT 'Specific environmental parameter, pollutant, or constituent being measured by this monitoring program (e.g., PM2.5, BOD, lead, methane).',
    `program_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the monitoring program for regulatory reporting and internal tracking.',
    `program_description` STRING COMMENT 'Detailed narrative description of the monitoring programs objectives, scope, and methodology.',
    `program_name` STRING COMMENT 'Human-readable name of the monitoring program describing its purpose and scope.',
    `program_status` STRING COMMENT 'Current lifecycle status of the monitoring program indicating whether it is operational, suspended, or terminated.',
    `program_type` STRING COMMENT 'Classification of the monitoring program based on the environmental medium or parameter being monitored.',
    `public_disclosure_required` BOOLEAN COMMENT 'Indicates whether monitoring results must be made available to the public through regulatory reporting portals or community right-to-know requirements.',
    `quality_assurance_plan_reference` STRING COMMENT 'Document reference or identifier for the Quality Assurance Project Plan (QAPP) governing data quality objectives and procedures for this program.',
    `regulatory_agency` STRING COMMENT 'Name of the federal, state, or local regulatory agency that oversees this monitoring program and receives compliance reports.',
    `regulatory_framework` STRING COMMENT 'Primary federal or state regulatory framework that mandates or governs this monitoring program.',
    `regulatory_limit` DECIMAL(18,2) COMMENT 'Maximum allowable concentration or level for the monitored parameter as specified by regulatory standards or permit conditions.',
    `reporting_frequency` STRING COMMENT 'Required frequency for submitting monitoring results to regulatory agencies or internal stakeholders.',
    `responsible_party` STRING COMMENT 'Name of the individual, department, or contractor responsible for executing and managing this monitoring program.',
    `sampling_method` STRING COMMENT 'Standardized methodology or protocol used for collecting environmental samples, including EPA method numbers or industry standards.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measurement for the monitored parameter (e.g., mg/L, ppm, µg/m³, dBA).',
    CONSTRAINT pk_monitoring_program PRIMARY KEY(`monitoring_program_id`)
) COMMENT 'Master reference table for monitoring_program. Referenced by monitoring_program_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`environmental_sample` (
    `environmental_sample_id` BIGINT COMMENT 'Primary key for environmental_sample',
    `employee_id` BIGINT COMMENT 'Reference to the employee who physically collected the sample.',
    `facility_id` BIGINT COMMENT 'Reference to the waste management facility where the sample was collected.',
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory facility that will analyze or has analyzed the sample.',
    `monitoring_station_id` BIGINT COMMENT 'Reference to the specific monitoring location or station where the sample was collected.',
    `permit_id` BIGINT COMMENT 'Reference to the environmental permit under which this sample was collected.',
    `sampling_event_id` BIGINT COMMENT 'Reference to the broader sampling event or campaign of which this sample is part.',
    `analysis_completed_date` DATE COMMENT 'Date when laboratory analysis was completed.',
    `analysis_due_date` DATE COMMENT 'Date by which laboratory analysis must be completed to meet holding time requirements.',
    `blank_sample_flag` BOOLEAN COMMENT 'Indicates whether this is a quality control blank sample used to detect contamination.',
    `chain_of_custody_number` STRING COMMENT 'Unique tracking number for the chain of custody documentation accompanying the sample.',
    `collection_method` STRING COMMENT 'Technique used to collect the environmental sample.',
    `collection_temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature of the sample at the time of collection.',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental sample was physically collected in the field.',
    `compliance_exceedance_flag` BOOLEAN COMMENT 'Indicates whether any analyte in this sample exceeded regulatory limits.',
    `composite_sample_flag` BOOLEAN COMMENT 'Indicates whether this sample is a composite of multiple sub-samples collected over time or space.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sample record was first created in the system.',
    `duplicate_sample_flag` BOOLEAN COMMENT 'Indicates whether this sample is a quality control duplicate of another sample.',
    `holding_time_hours` STRING COMMENT 'Maximum allowable time between sample collection and analysis completion, as specified by regulatory method.',
    `ph_level` DECIMAL(18,2) COMMENT 'Acidity or alkalinity measurement of the sample at collection, on a scale of 0-14.',
    `preservation_method` STRING COMMENT 'Technique used to preserve sample integrity during transport and storage.',
    `regulatory_program` STRING COMMENT 'Federal or state environmental program under which the sample is required.',
    `rejection_reason` STRING COMMENT 'Explanation for why the sample was rejected by the laboratory or deemed invalid, if applicable.',
    `reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this sample result must be included in regulatory reporting submissions.',
    `sample_depth_meters` DECIMAL(18,2) COMMENT 'Depth below surface at which the sample was collected, applicable for groundwater, soil, and sediment samples.',
    `sample_description` STRING COMMENT 'Free-text description of the sample appearance, odor, or other observable characteristics at collection.',
    `sample_matrix` STRING COMMENT 'Physical state or composition of the sample material.',
    `sample_notes` STRING COMMENT 'Additional notes or comments about the sample collection, handling, or analysis.',
    `sample_number` STRING COMMENT 'Externally-known unique business identifier for the environmental sample, used in regulatory submissions and laboratory tracking.',
    `sample_status` STRING COMMENT 'Current lifecycle status of the environmental sample from collection through analysis completion.',
    `sample_type` STRING COMMENT 'Classification of the environmental medium being sampled.',
    `sample_volume` DECIMAL(18,2) COMMENT 'Quantity of sample collected, measured in the unit specified by volume_unit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this sample record was last modified.',
    `volume_unit` STRING COMMENT 'Unit of measurement for the sample volume.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sample collection, relevant for outdoor sampling.',
    CONSTRAINT pk_environmental_sample PRIMARY KEY(`environmental_sample_id`)
) COMMENT 'Master reference table for environmental_sample. Referenced by sample_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`laboratory` (
    `laboratory_id` BIGINT COMMENT 'Primary key for laboratory',
    `accreditation_body` STRING COMMENT 'Name of the regulatory or certification body that granted accreditation to the laboratory (e.g., NELAP, A2LA, state environmental agency).',
    `accreditation_effective_date` DATE COMMENT 'Date when the laboratory accreditation became effective and valid.',
    `accreditation_expiration_date` DATE COMMENT 'Date when the current laboratory accreditation expires and requires renewal.',
    `accreditation_number` STRING COMMENT 'Unique certificate or accreditation number issued by the accrediting body.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the laboratory indicating its certification standing with regulatory bodies.',
    `address_line_1` STRING COMMENT 'Primary street address line of the laboratory facility location.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information of the laboratory facility.',
    `certification_iso_14001` BOOLEAN COMMENT 'Indicates whether the laboratory holds ISO 14001 certification for environmental management systems.',
    `certification_iso_45001` BOOLEAN COMMENT 'Indicates whether the laboratory holds ISO 45001 certification for occupational health and safety management systems.',
    `city` STRING COMMENT 'City where the laboratory facility is located.',
    `closure_date` DATE COMMENT 'Date when the laboratory ceased operations or was decommissioned, if applicable.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the laboratory is located (e.g., USA, CAN, MEX).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the laboratory record was first created in the system.',
    `established_date` DATE COMMENT 'Date when the laboratory was established or first became operational.',
    `hazardous_waste_handler_id` STRING COMMENT 'EPA-issued identification number for the laboratory as a hazardous waste handler, required for laboratories that generate or handle hazardous waste.',
    `laboratory_code` STRING COMMENT 'Unique business identifier code assigned to the laboratory for external reference and regulatory reporting.',
    `laboratory_name` STRING COMMENT 'Official name of the laboratory facility or testing center.',
    `laboratory_type` STRING COMMENT 'Classification of the laboratory based on its primary testing focus and specialization.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external quality audit conducted at the laboratory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the laboratory record was last updated or modified in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the laboratory facility location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the laboratory facility location in decimal degrees.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next required quality audit of the laboratory.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the laboratory, including special conditions, restrictions, or operational considerations.',
    `operational_status` STRING COMMENT 'Current operational status of the laboratory indicating whether it is actively conducting testing or temporarily unavailable.',
    `ownership_type` STRING COMMENT 'Classification indicating whether the laboratory is owned and operated internally by Waste Management or is an external contracted facility.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the laboratory facility address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary laboratory contact for official communications and coordination.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person or laboratory director responsible for laboratory operations.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the laboratory contact or operations center.',
    `quality_management_system` STRING COMMENT 'Name or description of the quality management system framework implemented by the laboratory (e.g., ISO 9001, ISO/IEC 17025, NELAP QA Manual).',
    `scope_of_accreditation` STRING COMMENT 'Detailed description of the testing methods, analytes, and matrices for which the laboratory is accredited.',
    `state_province` STRING COMMENT 'State or province where the laboratory facility is located.',
    `testing_capabilities` STRING COMMENT 'Comprehensive list or description of analytical testing capabilities and methods available at the laboratory (e.g., metals analysis, volatile organic compounds, microbiology).',
    `turnaround_time_days` STRING COMMENT 'Standard turnaround time in days for the laboratory to complete testing and deliver results.',
    CONSTRAINT pk_laboratory PRIMARY KEY(`laboratory_id`)
) COMMENT 'Master reference table for laboratory. Referenced by laboratory_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`compliance`.`sampling_event` (
    `sampling_event_id` BIGINT COMMENT 'Primary key for sampling_event',
    `actual_sampling_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sample was physically collected in the field. This is the principal business event timestamp for the sampling event.',
    `ambient_temperature` DECIMAL(18,2) COMMENT 'Ambient air temperature at the time of sampling, measured in degrees Celsius, relevant for certain environmental monitoring requirements.',
    `analysis_completed_timestamp` TIMESTAMP COMMENT 'Date and time when laboratory analysis was completed and results were finalized.',
    `analysis_requested` STRING COMMENT 'Description of the analytical tests or parameter suite requested for this sample (e.g., VOCs, metals, pH, BOD, total coliform).',
    `chain_of_custody_number` STRING COMMENT 'Unique tracking number for the chain of custody documentation that accompanies the sample from collection through analysis, ensuring sample integrity and legal defensibility.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether the sampling results require corrective action per permit conditions or regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sampling event record was first created in the system.',
    `event_number` STRING COMMENT 'Business identifier for the sampling event, typically formatted with facility code prefix and sequential number for external reference and regulatory reporting.',
    `exceedance_detected` BOOLEAN COMMENT 'Indicates whether any analytical results from this sampling event exceeded regulatory limits or action levels, triggering potential corrective action or reporting requirements.',
    `facility_id` BIGINT COMMENT 'Reference to the waste management facility where the sampling event occurred (landfill, transfer station, recycling center, or treatment facility).',
    `field_conductivity` DECIMAL(18,2) COMMENT 'Electrical conductivity of the sample measured in the field, in microsiemens per centimeter, used as an indicator of dissolved solids in water samples.',
    `field_dissolved_oxygen` DECIMAL(18,2) COMMENT 'Dissolved oxygen concentration measured in the field, in milligrams per liter, critical for water quality assessment.',
    `field_ph` DECIMAL(18,2) COMMENT 'pH measurement taken in the field at the time of sample collection, required for water and leachate samples as pH can change during transport.',
    `field_temperature` DECIMAL(18,2) COMMENT 'Temperature of the sample medium measured in the field at time of collection, in degrees Celsius, required for water quality monitoring.',
    `holding_time_compliant` BOOLEAN COMMENT 'Indicates whether the sample was analyzed within the required holding time specified by the analytical method. Non-compliance may affect data usability.',
    `laboratory_id` BIGINT COMMENT 'Reference to the certified analytical laboratory that will perform or has performed the sample analysis.',
    `laboratory_sample_id` STRING COMMENT 'Unique identifier assigned by the analytical laboratory to track the sample through their internal processes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the sampling location in decimal degrees for spatial analysis and regulatory reporting.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the sampling location in decimal degrees for spatial analysis and regulatory reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this sampling event record was last modified in the system.',
    `monitoring_frequency` STRING COMMENT 'Required frequency of sampling as specified in the permit or monitoring plan: daily, weekly, monthly, quarterly, semi-annual, annual, or event-based (triggered by specific conditions).',
    `notes` STRING COMMENT 'Free-text field for additional observations, deviations from standard procedures, or other relevant information about the sampling event.',
    `parent_sampling_event_id` BIGINT COMMENT 'Reference to the parent sampling event if this is a quality control sample (duplicate or split) associated with another primary sample.',
    `permit_id` BIGINT COMMENT 'Reference to the environmental permit under which this sampling event is conducted (air quality, water discharge, waste handling permit).',
    `preservation_method` STRING COMMENT 'Chemical or physical preservation technique applied to the sample to maintain integrity during transport and storage (e.g., acidification, refrigeration, freezing).',
    `quality_control_type` STRING COMMENT 'Indicates if this is a quality control sample: field blank, trip blank, equipment blank, field duplicate, matrix spike, or none (regular sample).',
    `regulator_submission_date` DATE COMMENT 'Date when the sampling results were officially submitted to the regulatory agency.',
    `regulatory_program` STRING COMMENT 'Federal or state environmental program under which the sampling is required: RCRA (Resource Conservation and Recovery Act), CERCLA (Superfund), CAA (Clean Air Act), CWA (Clean Water Act), NPDES (National Pollutant Discharge Elimination System), SWIS (Solid Waste Information System), or state-specific program.',
    `reported_to_regulator` BOOLEAN COMMENT 'Indicates whether the sampling results have been submitted to the appropriate regulatory agency as required by permit or regulation.',
    `sample_container_type` STRING COMMENT 'Type of container used to collect and preserve the sample (e.g., glass bottle, plastic jar, Tedlar bag, stainless steel canister) as specified by analytical method requirements.',
    `sample_depth` DECIMAL(18,2) COMMENT 'Depth at which the sample was collected, measured in feet or meters below ground surface or water surface, critical for groundwater and soil sampling.',
    `sample_depth_unit` STRING COMMENT 'Unit of measure for sample depth: feet, meters, or inches.',
    `sample_matrix` STRING COMMENT 'Physical state or medium of the sample collected: liquid (water, leachate), solid (soil, waste), gas (air, landfill gas), sludge, or sediment.',
    `sample_received_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was received by the analytical laboratory, used to verify holding time compliance.',
    `sample_volume` DECIMAL(18,2) COMMENT 'Volume of sample collected, measured in milliliters or liters, required for laboratory analysis and quality control.',
    `sample_volume_unit` STRING COMMENT 'Unit of measure for the sample volume: milliliters, liters, cubic meters, or gallons.',
    `sampler_certification_number` STRING COMMENT 'Professional certification or license number of the individual who collected the sample, required for certain regulated sampling activities.',
    `sampler_employee_id` BIGINT COMMENT 'Reference to the employee or contractor who physically collected the sample, required for chain of custody and quality assurance.',
    `sampling_location_description` STRING COMMENT 'Detailed description of the physical location where the sample was collected, including well number, monitoring point identifier, or specific area within the facility.',
    `sampling_method` STRING COMMENT 'Technique used to collect the sample: grab sample (single point in time), composite sample (multiple samples combined), continuous monitoring, or passive sampling device.',
    `sampling_type` STRING COMMENT 'Category of environmental sampling conducted: groundwater monitoring, surface water, air quality, soil contamination, leachate analysis, landfill gas emissions, stormwater runoff, or waste characterization.',
    `scheduled_date` DATE COMMENT 'Planned date for the sampling event as defined in the monitoring plan or permit schedule.',
    `sampling_event_status` STRING COMMENT 'Current lifecycle status of the sampling event: scheduled, collected, in transit to lab, received by lab, analysis in progress, analysis complete, results reviewed, results reported to regulatory agency, or cancelled.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sampling (temperature, precipitation, wind) that may affect sample quality or interpretation of results.',
    CONSTRAINT pk_sampling_event PRIMARY KEY(`sampling_event_id`)
) COMMENT 'Master reference table for sampling_event. Referenced by sampling_event_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`audit_program`(`audit_program_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_previous_finding_inspection_finding_id` FOREIGN KEY (`previous_finding_inspection_finding_id`) REFERENCES `waste_management_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ADD CONSTRAINT `fk_compliance_violation_notice_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ADD CONSTRAINT `fk_compliance_violation_notice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ADD CONSTRAINT `fk_compliance_violation_notice_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `waste_management_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ADD CONSTRAINT `fk_compliance_compliance_environmental_monitoring_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ADD CONSTRAINT `fk_compliance_compliance_environmental_monitoring_monitoring_station_id` FOREIGN KEY (`monitoring_station_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_station`(`monitoring_station_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ADD CONSTRAINT `fk_compliance_compliance_environmental_monitoring_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ADD CONSTRAINT `fk_compliance_compliance_environmental_monitoring_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ADD CONSTRAINT `fk_compliance_compliance_environmental_monitoring_environmental_sample_id` FOREIGN KEY (`environmental_sample_id`) REFERENCES `waste_management_ecm`.`compliance`.`environmental_sample`(`environmental_sample_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ADD CONSTRAINT `fk_compliance_monitoring_station_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_original_submission_regulatory_submission_id` FOREIGN KEY (`original_submission_regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_scheduled_obligation_id` FOREIGN KEY (`scheduled_obligation_id`) REFERENCES `waste_management_ecm`.`compliance`.`scheduled_obligation`(`scheduled_obligation_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ADD CONSTRAINT `fk_compliance_training_certification_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ADD CONSTRAINT `fk_compliance_training_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ADD CONSTRAINT `fk_compliance_training_requirement_superseded_by_requirement_training_requirement_id` FOREIGN KEY (`superseded_by_requirement_training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ADD CONSTRAINT `fk_compliance_air_emission_event_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ADD CONSTRAINT `fk_compliance_air_emission_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ADD CONSTRAINT `fk_compliance_air_emission_event_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ADD CONSTRAINT `fk_compliance_spill_release_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ADD CONSTRAINT `fk_compliance_spill_release_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ADD CONSTRAINT `fk_compliance_spill_release_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ADD CONSTRAINT `fk_compliance_spill_release_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ADD CONSTRAINT `fk_compliance_scheduled_obligation_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ADD CONSTRAINT `fk_compliance_scheduled_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ADD CONSTRAINT `fk_compliance_chemical_inventory_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ADD CONSTRAINT `fk_compliance_ghg_regulatory_submission_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ADD CONSTRAINT `fk_compliance_ghg_regulatory_submission_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ADD CONSTRAINT `fk_compliance_facility_audit_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`audit_program`(`audit_program_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ADD CONSTRAINT `fk_compliance_facility_audit_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ADD CONSTRAINT `fk_compliance_permit_requirement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ADD CONSTRAINT `fk_compliance_permit_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_program` ADD CONSTRAINT `fk_compliance_monitoring_program_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_program` ADD CONSTRAINT `fk_compliance_monitoring_program_parent_monitoring_program_id` FOREIGN KEY (`parent_monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_sample` ADD CONSTRAINT `fk_compliance_environmental_sample_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `waste_management_ecm`.`compliance`.`laboratory`(`laboratory_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_sample` ADD CONSTRAINT `fk_compliance_environmental_sample_monitoring_station_id` FOREIGN KEY (`monitoring_station_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_station`(`monitoring_station_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_sample` ADD CONSTRAINT `fk_compliance_environmental_sample_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_sample` ADD CONSTRAINT `fk_compliance_environmental_sample_sampling_event_id` FOREIGN KEY (`sampling_event_id`) REFERENCES `waste_management_ecm`.`compliance`.`sampling_event`(`sampling_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `waste_management_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Application Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'tons_per_day|tons_per_year|gallons_per_day|cubic_yards|million_gallons_per_day');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Email Address');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_officer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_officer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Phone Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_officer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions and Limitations');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `epa_id_number` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Identification Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `epa_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `epa_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `financial_assurance_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `financial_assurance_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Instrument Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `financial_assurance_type` SET TAGS ('dbx_value_regex' = 'surety_bond|letter_of_credit|trust_fund|insurance|corporate_guarantee');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Frequency');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annually|as_required');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Agency');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `issuing_agency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Jurisdiction Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `issuing_agency_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state|local');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `last_violation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Permit Violation Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `monitoring_requirements` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Requirements');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Regulatory Inspection Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|revoked|under_renewal');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permit_tier` SET TAGS ('dbx_business_glossary_term' = 'Permit Tier Classification');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permit_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|major|minor');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'air_quality|water_discharge|solid_waste_facility|rcra_hazardous_waste|stormwater|land_use');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permitted_activities` SET TAGS ('dbx_business_glossary_term' = 'Permitted Activities Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `permitted_capacity` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Publication Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `public_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending_submission|submitted|under_review|approved|denied');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|as_required');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `state_permit_number` SET TAGS ('dbx_business_glossary_term' = 'State Permit Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Permit Subtype');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Violation Count');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `averaging_period` SET TAGS ('dbx_business_glossary_term' = 'Averaging Period');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `compliance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_verification|not_applicable|under_review');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `deviation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Deviation Threshold');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `deviation_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Deviation Threshold Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Priority');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Condition Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `last_compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Check Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `last_violation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Violation Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'maximum|minimum|range|average|instantaneous|rolling_average');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `limit_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Limit Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Limit Value');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `next_compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Check Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `reporting_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Reporting Deadline Days');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `citation_number` SET TAGS ('dbx_business_glossary_term' = 'Regulation Citation Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frequency');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_obligation_summary` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Summary');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `facility_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Facility Type Applicability');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `internal_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `iso_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Clause Reference');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'Federal|State|Local|International');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction_geography` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Geography');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `operation_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Operation Type Applicability');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_severity` SET TAGS ('dbx_business_glossary_term' = 'Penalty Severity');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_severity` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `permit_required` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_title` SET TAGS ('dbx_business_glossary_term' = 'Regulation Title');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_status` SET TAGS ('dbx_value_regex' = 'Active|Proposed|Superseded|Repealed|Under Review|Pending');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Reporting Deadline Days');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Reporting Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `source_document_url` SET TAGS ('dbx_business_glossary_term' = 'Source Document Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `waste_stream_applicability` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Applicability');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` SET TAGS ('dbx_subdomain' = 'audit_oversight');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspected Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `actual_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Inspection Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `checklist_used` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Used');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `facility_epa_number` SET TAGS ('dbx_business_glossary_term' = 'Facility EPA (Environmental Protection Agency) ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `facility_epa_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `frequency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Requirement');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `frequency_requirement` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|as_needed|triggered');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspecting_authority` SET TAGS ('dbx_business_glossary_term' = 'Inspecting Authority');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|no_violations_observed|violations_cited|follow_up_required');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|report_pending|closed|cancelled');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'EPA Compliance Evaluation|OSHA Safety Inspection|DOT Vehicle Inspection|LEA Solid Waste Inspection|Internal EHS Audit|RCRA Facility Assessment');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspector_badge_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Badge Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `inspector_badge_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `iso_14001_audit` SET TAGS ('dbx_business_glossary_term' = 'ISO (International Organization for Standardization) 14001 Audit');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `iso_45001_audit` SET TAGS ('dbx_business_glossary_term' = 'ISO (International Organization for Standardization) 45001 Audit');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `next_scheduled_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `notice_of_violation_issued` SET TAGS ('dbx_business_glossary_term' = 'Notice of Violation (NOV) Issued');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `number_of_findings` SET TAGS ('dbx_business_glossary_term' = 'Number of Findings');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report URL (Uniform Resource Locator)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Enviance EHS|SAP EHS|Manual Entry');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ALTER COLUMN `violations_cited` SET TAGS ('dbx_business_glossary_term' = 'Violations Cited');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` SET TAGS ('dbx_subdomain' = 'audit_oversight');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `previous_finding_inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `environmental_impact` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `environmental_impact` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|severe');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `facility_area` SET TAGS ('dbx_business_glossary_term' = 'Facility Area');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'violation|observation|recommendation|non_conformance|opportunity_for_improvement|best_practice');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `health_safety_impact` SET TAGS ('dbx_business_glossary_term' = 'Health and Safety Impact');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `health_safety_impact` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|severe');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `health_safety_impact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `health_safety_impact` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `inspection_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `inspection_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `inspection_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|closed|deferred');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `inspector_organization` SET TAGS ('dbx_business_glossary_term' = 'Inspector Organization');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Finding Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `photographic_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Photographic Evidence Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `potential_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Potential Penalty Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `potential_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `regulation_category` SET TAGS ('dbx_business_glossary_term' = 'Regulation Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `repeat_finding` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `root_cause_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Completed Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor|informational');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `agency_office` SET TAGS ('dbx_business_glossary_term' = 'Agency Office or Region');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|withdrawn|pending');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `facility_epa_number` SET TAGS ('dbx_business_glossary_term' = 'Facility EPA (Environmental Protection Agency) ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Agency');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Assigned');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `notice_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Issued Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_business_glossary_term' = 'Notice of Violation (NOV) Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `notice_received_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Received Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_business_glossary_term' = 'Notice Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_value_regex' = 'notice_of_violation|administrative_order|consent_decree|civil_penalty|criminal_referral|warning_letter');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `penalty_assessed_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Assessed Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `penalty_assessed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `penalty_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Paid Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `penalty_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `penalty_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `settlement_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `settlement_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'enviance_ehs|sap_ehs|manual_entry');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `violation_severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `violation_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ALTER COLUMN `violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `regulatory_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Corrective Action ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Initiative Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|verified|closed|cancelled');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `action_title` SET TAGS ('dbx_business_glossary_term' = 'Action Title');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|both');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (USD)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `management_review_date` SET TAGS ('dbx_business_glossary_term' = 'Management Review Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `management_review_required` SET TAGS ('dbx_business_glossary_term' = 'Management Review Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `recurrence_risk` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Risk');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `recurrence_risk` SET TAGS ('dbx_value_regex' = 'high|medium|low|eliminated');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `safety_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'enviance_ehs|sap_ehs|manual_entry|other');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `triggering_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Reference');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_value_regex' = 'inspection|violation_notice|incident|audit|complaint|self_identified');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|verified_effective|verified_ineffective|pending_verification');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `ehs_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Health and Safety (EHS) Incident ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Involved Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Jha Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `regulatory_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Corrective Action Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `days_of_job_transfer` SET TAGS ('dbx_business_glossary_term' = 'Days of Job Transfer');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `days_of_restricted_work` SET TAGS ('dbx_business_glossary_term' = 'Days of Restricted Work');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `environmental_media_affected` SET TAGS ('dbx_business_glossary_term' = 'Environmental Media Affected');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `environmental_media_affected` SET TAGS ('dbx_value_regex' = 'air|water|soil|groundwater|none');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `immediate_cause` SET TAGS ('dbx_business_glossary_term' = 'Immediate Cause');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|corrective_action_pending|closed');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'osha_recordable|first_aid|near_miss|environmental_release|property_damage|vehicle_accident');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_business_glossary_term' = 'Injured Party Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `injured_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Investigator Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `material_released` SET TAGS ('dbx_business_glossary_term' = 'Material Released');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'phone|email|online_portal|written_report|in_person');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `ppe_in_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) In Use Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `ppe_type` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `property_damage_amount` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `regulatory_agency_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Notified');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `release_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `release_quantity_unit` SET TAGS ('dbx_value_regex' = 'gallons|liters|pounds|kilograms|cubic_yards|tons');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_value_regex' = 'human_error|equipment_failure|process_deficiency|environmental_condition|management_system|other');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `compliance_environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Environmental Monitoring ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `monitoring_program_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `monitoring_station_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Station Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `environmental_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `analysis_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `data_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Data Qualifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `laboratory_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Certification Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `monitoring_event_number` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Event Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `monitoring_program_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `parameter_measured` SET TAGS ('dbx_business_glossary_term' = 'Parameter Measured');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `quality_assurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `quality_assurance_flag` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `regulatory_limit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `sample_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `sampler_name` SET TAGS ('dbx_business_glossary_term' = 'Sampler Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_environmental_monitoring` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `monitoring_station_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Station ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `analyte_list` SET TAGS ('dbx_business_glossary_term' = 'Analyte List');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `casing_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Casing Diameter (Inches)');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `casing_material` SET TAGS ('dbx_business_glossary_term' = 'Casing Material');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `casing_material` SET TAGS ('dbx_value_regex' = 'pvc|stainless_steel|hdpe|carbon_steel');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `communication_method` SET TAGS ('dbx_business_glossary_term' = 'Communication Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `communication_method` SET TAGS ('dbx_value_regex' = 'cellular|satellite|radio|hardwired|manual');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `data_logger_code` SET TAGS ('dbx_business_glossary_term' = 'Data Logger ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency (Days)');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `installation_contractor` SET TAGS ('dbx_business_glossary_term' = 'Installation Contractor');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `monitoring_purpose` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Purpose');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `monitoring_purpose` SET TAGS ('dbx_value_regex' = 'detection|assessment|corrective_action|background|compliance|operational');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `monitoring_station_status` SET TAGS ('dbx_business_glossary_term' = 'Station Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `monitoring_station_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|under_construction|decommissioned|temporarily_offline');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `monitoring_zone` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Zone');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Station Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `regulatory_designation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Designation');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `screen_interval_bottom_ft` SET TAGS ('dbx_business_glossary_term' = 'Screen Interval Bottom (Feet)');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `screen_interval_top_ft` SET TAGS ('dbx_business_glossary_term' = 'Screen Interval Top (Feet)');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `station_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Station Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Station Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ALTER COLUMN `well_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Well Depth (Feet)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Data Provider Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `original_submission_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original Submission Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `scheduled_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Obligation Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `tertiary_regulatory_submitted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `tertiary_regulatory_submitted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `tertiary_regulatory_submitted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_comments` SET TAGS ('dbx_business_glossary_term' = 'Agency Comments');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Agency Jurisdiction');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_jurisdiction` SET TAGS ('dbx_value_regex' = 'Federal|State|Local|Regional');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_response_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_response_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_response_status` SET TAGS ('dbx_value_regex' = 'Accepted|Rejected|Additional Information Requested|Under Review|No Response');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Certification Statement');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `certifying_official_title` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Title');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'PDF|XML|Excel|Word|CSV|EDI');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `facility_epa_number` SET TAGS ('dbx_business_glossary_term' = 'Facility EPA (Environmental Protection Agency) Identification Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `filing_agency` SET TAGS ('dbx_business_glossary_term' = 'Filing Agency');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `late_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `late_submission_reason` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Reason');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Electronic|Paper|Portal|Email|Certified Mail');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `training_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Training Certification ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Training Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `cdl_class` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Class');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `cdl_class` SET TAGS ('dbx_value_regex' = 'CLASS_A|CLASS_B|CLASS_C');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|EXPIRED|SUSPENDED|REVOKED|PENDING_RENEWAL');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `endorsement_codes` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Endorsement Codes');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|IN_PROGRESS|INCOMPLETE');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'DOT|OSHA|EPA|STATE_DMV|ISO|INTERNAL');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency Months');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `restriction_codes` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Restriction Codes');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Certification Score');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ENVIANCE_EHS|WORKDAY_HCM|MANUAL_ENTRY');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_value_regex' = 'IN_PERSON|ONLINE|BLENDED|ON_THE_JOB');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'DOCUMENT_REVIEW|REGISTRY_CHECK|THIRD_PARTY_VERIFICATION|SELF_ATTESTATION');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `superseded_by_requirement_training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Requirement ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `applicable_facility_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Types');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `applicable_job_roles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Roles');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `applicable_regulatory_programs` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Programs');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `competency_assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `documentation_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Documentation Retention (Years)');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `frequency_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval (Months)');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `frequency_type` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (Days)');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `iso_14001_competence_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Competence Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `iso_45001_competence_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Competence Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `minimum_passing_score_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Passing Score (Percent)');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `minimum_training_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Training Hours');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `prerequisite_training_codes` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Training Codes');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|pending_review');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `third_party_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Certification Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'safety|environmental|operational|regulatory|technical|leadership');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_delivery_methods` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Methods');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_name` SET TAGS ('dbx_business_glossary_term' = 'Training Program Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_provider_type` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_provider_type` SET TAGS ('dbx_value_regex' = 'internal|external_accredited|external_vendor|government_agency|industry_association');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_type_code` SET TAGS ('dbx_business_glossary_term' = 'Training Type Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`training_requirement` ALTER COLUMN `training_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `air_emission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Air Emission Event ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Detected By Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `emergency_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Unit ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Unit Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `regulatory_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Corrective Action Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `agency_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Notification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `air_emission_event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `air_emission_event_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|corrective_action_pending|closed|reported');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Cause Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `community_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Community Impact Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Community Complaint Count');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Detection Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Deviation Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `emission_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Quantity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `emission_quantity_unit` SET TAGS ('dbx_value_regex' = 'pounds|tons|kilograms|metric_tons|cubic_feet|cubic_meters');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `estimated_emission_quantity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Emission Quantity');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `event_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Event Duration Hours');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'excess_emission|startup_shutdown_malfunction|fugitive_emission|emergency_release|routine_release|opacity_exceedance');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Emission Monitoring Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_value_regex' = 'CEMS|parametric_monitoring|visual_observation|calculation|engineering_estimate');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `notification_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Deadline Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'phone|email|written_report|electronic_portal|in_person');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `permit_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `permit_limit_unit` SET TAGS ('dbx_value_regex' = 'pounds_per_hour|tons_per_year|ppm|percent_opacity|grains_per_dscf');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `permit_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Value');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `pollutant_code` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `pollutant_name` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `preventive_action_planned` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Planned');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Event Severity Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions During Event');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `wind_direction` SET TAGS ('dbx_business_glossary_term' = 'Wind Direction');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed Miles Per Hour');
ALTER TABLE `waste_management_ecm`.`compliance`.`air_emission_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `spill_release_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Release ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `emergency_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Action Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `regulatory_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Corrective Action Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `affected_media` SET TAGS ('dbx_business_glossary_term' = 'Affected Environmental Media');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `affected_media` SET TAGS ('dbx_value_regex' = 'soil|surface_water|groundwater|air|pavement|multiple');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `agency_notified` SET TAGS ('dbx_business_glossary_term' = 'Agency Notified');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `cause_category` SET TAGS ('dbx_business_glossary_term' = 'Cause Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `cause_category` SET TAGS ('dbx_value_regex' = 'equipment_failure|human_error|natural_event|third_party|unknown');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Cause Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `cleanup_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Completion Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `cleanup_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cleanup Start Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `containment_actions` SET TAGS ('dbx_business_glossary_term' = 'Immediate Containment Actions');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `disposal_facility_epa_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Environmental Protection Agency (EPA) ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `disposal_facility_epa_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `disposal_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `estimated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Quantity');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `facility_epa_number` SET TAGS ('dbx_business_glossary_term' = 'Facility Environmental Protection Agency (EPA) ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `facility_epa_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Location Address');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_state` SET TAGS ('dbx_business_glossary_term' = 'Location State');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'facility|roadway|transfer_station|landfill|mrf|customer_site');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Location ZIP Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `location_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `material_released` SET TAGS ('dbx_business_glossary_term' = 'Material Released');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `notification_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Confirmation Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'gallons|liters|pounds|kilograms|tons|cubic_yards');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'leachate|fuel|hazmat|stormwater|chemical|oil');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `reportable_quantity_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable Quantity (RQ) Exceeded Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `spill_date` SET TAGS ('dbx_business_glossary_term' = 'Spill Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `spill_status` SET TAGS ('dbx_business_glossary_term' = 'Spill Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `spill_status` SET TAGS ('dbx_value_regex' = 'reported|contained|cleanup_in_progress|cleanup_complete|closed');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `spill_time` SET TAGS ('dbx_business_glossary_term' = 'Spill Time');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `waste_disposed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposed Quantity');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `waste_disposed_unit` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposed Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`spill_release` ALTER COLUMN `waste_disposed_unit` SET TAGS ('dbx_value_regex' = 'gallons|liters|pounds|kilograms|tons|cubic_yards');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `scheduled_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Obligation ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `reduction_target_id` SET TAGS ('dbx_business_glossary_term' = 'Reduction Target Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Email Address');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `completed_by` SET TAGS ('dbx_business_glossary_term' = 'Completed By');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `completed_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `days_until_due` SET TAGS ('dbx_business_glossary_term' = 'Days Until Due');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `next_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Occurrence Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_value_regex' = '^OBL-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|overdue|cancelled|deferred');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'very_high|high|medium|low|very_low');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|in_person|email|portal|not_applicable');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `submission_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Submission Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`scheduled_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` SET TAGS ('dbx_subdomain' = 'audit_oversight');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `primary_lead_auditor_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `applicable_facilities` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facilities');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Semi-Annual|Quarterly|Monthly|Biennial|Ad-Hoc');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'ISO 14001 Internal Audit|RCRA Compliance Audit|OSHA VPP Audit|Operational Compliance Review|ISO 45001 Internal Audit|Integrated EHS Audit');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `documentation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirements');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `external_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'External Certification Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `iso_clauses` SET TAGS ('dbx_business_glossary_term' = 'ISO Clauses');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_objectives` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Objectives');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Under Review|Archived');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `regulatory_standards` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standards');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `reporting_template` SET TAGS ('dbx_business_glossary_term' = 'Reporting Template');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Description');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`audit_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `chemical_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Inventory ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `average_daily_quantity` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Quantity');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `cercla_reportable_quantity` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Environmental Response, Compensation, and Liability Act (CERCLA) Reportable Quantity (RQ)');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `confidential_location_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Location Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `ehs_flag` SET TAGS ('dbx_business_glossary_term' = 'Extremely Hazardous Substance (EHS) Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `ehs_threshold_planning_quantity` SET TAGS ('dbx_business_glossary_term' = 'Extremely Hazardous Substance (EHS) Threshold Planning Quantity (TPQ)');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `epcra_section_313_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Planning and Community Right-to-Know Act (EPCRA) Section 313 Toxic Release Inventory (TRI) Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `ghs_environmental_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Environmental Hazard Class');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `ghs_health_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Health Hazard Class');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `ghs_health_hazard_class` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `ghs_health_hazard_class` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `ghs_physical_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Physical Hazard Class');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `hmis_rating` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Identification System (HMIS) Rating');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `hmis_rating` SET TAGS ('dbx_value_regex' = '^[0-4]-[0-4]-[0-4]-[A-Z]$');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|depleted|discontinued|pending_removal');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `last_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `maximum_quantity_stored` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity Stored');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `nfpa_rating` SET TAGS ('dbx_business_glossary_term' = 'National Fire Protection Association (NFPA) 704 Rating');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `nfpa_rating` SET TAGS ('dbx_value_regex' = '^[0-4]-[0-4]-[0-4](-[A-Z]{0,3})?$');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|sludge|compressed_gas');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `product_identifier` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `psm_covered_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Covered Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `psm_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Threshold Quantity');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'pounds|kilograms|gallons|liters|cubic_feet|cubic_meters');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `rcra_generator_status_impact` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Generator Status Impact');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `rcra_generator_status_impact` SET TAGS ('dbx_value_regex' = 'none|conditionally_exempt|small_quantity|large_quantity');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `sds_document_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document URL');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `sds_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Revision Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|heated|pressurized|inert_atmosphere');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `storage_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `tier_ii_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Tier II Reporting Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `un_na_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations/North America (UN/NA) Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `un_na_number` SET TAGS ('dbx_value_regex' = '^(UN|NA)[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`chemical_inventory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `ghg_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Regulatory Submission ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `activity_data_input` SET TAGS ('dbx_business_glossary_term' = 'Activity Data Input');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `activity_data_unit` SET TAGS ('dbx_business_glossary_term' = 'Activity Data Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `activity_data_value` SET TAGS ('dbx_business_glossary_term' = 'Activity Data Value');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `calculated_co2e_quantity` SET TAGS ('dbx_business_glossary_term' = 'Calculated Carbon Dioxide Equivalent (CO2e) Quantity');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `calculation_notes` SET TAGS ('dbx_business_glossary_term' = 'Calculation Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `co2e_unit` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `co2e_unit` SET TAGS ('dbx_value_regex' = 'metric_tons_co2e');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `corporate_sustainability_flag` SET TAGS ('dbx_business_glossary_term' = 'Corporate Sustainability Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `emission_factor_applied` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Applied');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `emission_factor_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `emission_source_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `emission_source_type` SET TAGS ('dbx_value_regex' = 'lfg_methane|wte_combustion|stationary_combustion|mobile_source|fugitive');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `epa_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Confirmation Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `epa_subpart` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Subpart');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `facility_epa_number` SET TAGS ('dbx_business_glossary_term' = 'Facility Environmental Protection Agency (EPA) ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'landfill|wte|mrf|transfer_station|fleet_depot|tsdf');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `ghg_pollutant` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Pollutant');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `global_warming_potential` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP)');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `reporting_threshold_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Met Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `submission_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|resubmitted|withdrawn');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed|not_required');
ALTER TABLE `waste_management_ecm`.`compliance`.`ghg_regulatory_submission` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'audit_oversight');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Assessed Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Conducted By Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Jha Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reviewed By');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|active|superseded|archived');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'job_hazard_analysis|process_hazard_analysis|environmental_aspect_impact|operational_risk_review|facility_risk_assessment|activity_risk_assessment');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `associated_risk_or_impact` SET TAGS ('dbx_business_glossary_term' = 'Associated Risk or Impact');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `existing_controls` SET TAGS ('dbx_business_glossary_term' = 'Existing Controls');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `hazard_identified` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identified');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `iso_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'ISO Clause Reference');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `management_review_date` SET TAGS ('dbx_business_glossary_term' = 'Management Review Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `management_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management Review Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `operation_scope` SET TAGS ('dbx_business_glossary_term' = 'Operation Scope');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `recommended_additional_controls` SET TAGS ('dbx_business_glossary_term' = 'Recommended Additional Controls');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `risk_priority_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority Number (RPN)');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `safety_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Category');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `safety_impact_category` SET TAGS ('dbx_value_regex' = 'injury|illness|fatality|near_miss|property_damage');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `waste_management_ecm`.`compliance`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Facility ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `active_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Active Violations Count');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `applicable_regulatory_programs` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Programs');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'tons_per_day|cubic_yards|tons_per_hour|gallons|cubic_meters');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Level');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `design_capacity` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `facility_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Closure Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `facility_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Opened Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `iso_45001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Certified');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `lea_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Local Enforcement Agency (LEA) Jurisdiction');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `next_scheduled_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `operating_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Number');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|non_operational|seasonal|standby|decommissioned');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `permitted_waste_types` SET TAGS ('dbx_business_glossary_term' = 'Permitted Waste Types');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `post_closure_monitoring_end_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Closure Monitoring End Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `post_closure_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Closure Monitoring Required');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Contact Email');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Contact Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Contact Phone');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `primary_regulatory_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `rcra_generator_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Generator Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `rcra_generator_status` SET TAGS ('dbx_value_regex' = 'lqg|sqg|vsqg|not_applicable');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `regional_epa_office` SET TAGS ('dbx_business_glossary_term' = 'Regional Environmental Protection Agency (EPA) Office');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_closure|closed|suspended|under_review');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'enviance_ehs|sap_ehs|manual_entry');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `title_v_designation` SET TAGS ('dbx_business_glossary_term' = 'Title V Air Permit Designation');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `title_v_designation` SET TAGS ('dbx_value_regex' = 'major_source|minor_source|synthetic_minor|not_applicable');
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` SET TAGS ('dbx_subdomain' = 'audit_oversight');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` SET TAGS ('dbx_association_edges' = 'compliance.audit_program,compliance.regulated_facility');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `facility_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Audit ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Audit - Audit Program Id');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Audit - Regulated Facility Id');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `audit_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Completion Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `auditor_assigned` SET TAGS ('dbx_business_glossary_term' = 'Auditor Assigned');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `certification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Certification Outcome');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `waste_management_ecm`.`compliance`.`facility_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` SET TAGS ('dbx_association_edges' = 'compliance.permit,compliance.regulatory_requirement');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `permit_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Requirement Mapping ID');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Requirement - Permit Id');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Requirement - Regulatory Requirement Id');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `applicability_determination` SET TAGS ('dbx_business_glossary_term' = 'Applicability Determination');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `citation_reference` SET TAGS ('dbx_business_glossary_term' = 'Citation Reference');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `exemption_claimed` SET TAGS ('dbx_business_glossary_term' = 'Exemption Claimed');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Expiration Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `last_compliance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Verification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `monitoring_frequency_override` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Override');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `next_compliance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Verification Date');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `reporting_frequency_override` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency Override');
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_requirement` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Name');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_program` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_program` ALTER COLUMN `monitoring_program_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_program` ALTER COLUMN `parent_monitoring_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_program` ALTER COLUMN `estimated_annual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_sample` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_sample` ALTER COLUMN `environmental_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sample Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`laboratory` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`compliance`.`sampling_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`compliance`.`sampling_event` SET TAGS ('dbx_subdomain' = 'environmental_reporting');
ALTER TABLE `waste_management_ecm`.`compliance`.`sampling_event` ALTER COLUMN `sampling_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Event Identifier');
