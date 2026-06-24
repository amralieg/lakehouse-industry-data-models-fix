-- Schema for Domain: volunteer | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-06-23 02:07:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`volunteer` COMMENT 'Source systems: UNV systems, organization-specific VMS platforms. Volunteer lifecycle management. Systems of record: UNV unified volunteer platform, custom VMS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` (
    `volunteer_id` BIGINT COMMENT 'Unique identifier for the volunteer record. Primary key for the volunteer entity.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Volunteers are frequently also donors in nonprofits. Linking enables integrated constituent relationship management, lifetime value analysis across giving and service, unified recognition programs, an',
    `country_id` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the volunteers residential address.',
    `address_line_1` STRING COMMENT 'First line of the volunteers residential address, typically street number and name.',
    `address_line_2` STRING COMMENT 'Second line of the volunteers residential address, typically apartment or unit number.',
    `availability_hours_per_week` DECIMAL(18,2) COMMENT 'Number of hours per week the volunteer is available to contribute, used for scheduling and capacity planning.',
    `availability_status` STRING COMMENT 'Current availability status of the volunteer for new assignments. Available indicates ready for deployment, unavailable indicates temporarily not available, on assignment indicates currently deployed, on leave indicates scheduled absence, and inactive indicates not currently volunteering.. Valid values are `available|unavailable|on assignment|on leave|inactive`',
    `background_check_date` DATE COMMENT 'Date when the most recent background check was completed for the volunteer.',
    `background_check_status` STRING COMMENT 'Status of the volunteers background check or vetting process. Not required indicates no check needed for this role, pending indicates check requested, in progress indicates check underway, cleared indicates check passed, flagged indicates issues identified, and expired indicates check needs renewal.. Valid values are `not required|pending|in progress|cleared|flagged|expired`',
    `certifications` STRING COMMENT 'Comma-separated list of professional certifications, licenses, and credentials held by the volunteer, such as first aid, WASH (Water Sanitation and Hygiene) training, PSS (Psychosocial Support) certification, or medical licenses.',
    `city` STRING COMMENT 'City or municipality of the volunteers residential address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the volunteer record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Date of birth of the volunteer, used for age verification, insurance, and compliance purposes.',
    `email_address` STRING COMMENT 'Primary email address for volunteer communication, coordination, and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the volunteers designated emergency contact person.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the volunteers designated emergency contact person.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the volunteer, such as spouse, parent, sibling, or friend.',
    `external_volunteer_code` STRING COMMENT 'Business identifier for the volunteer as known in Microsoft Dynamics 365 for Nonprofits or other external systems. Used for cross-system reconciliation and integration.',
    `first_name` STRING COMMENT 'The given name of the volunteer.',
    `first_volunteer_date` DATE COMMENT 'Date of the volunteers first volunteer activity or assignment with the organization.',
    `gender` STRING COMMENT 'Self-identified gender of the volunteer, used for demographic reporting and program planning.. Valid values are `male|female|non-binary|prefer not to say|other`',
    `geographic_base` STRING COMMENT 'Primary geographic location or region where the volunteer is based and prefers to serve, used for matching volunteers to local programs and field operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the volunteer record was last updated or modified.',
    `last_name` STRING COMMENT 'The family name or surname of the volunteer.',
    `last_volunteer_date` DATE COMMENT 'Date of the volunteers most recent volunteer activity or assignment with the organization.',
    `middle_name` STRING COMMENT 'The middle name or initial of the volunteer, if applicable.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the volunteer, used for SMS notifications and field coordination.',
    `nationality` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the volunteers nationality or citizenship.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text notes and comments about the volunteer, including special considerations, preferences, feedback, and coordination details.',
    `onboarding_completion_date` DATE COMMENT 'Date when the volunteer completed all onboarding requirements and became eligible for deployment.',
    `onboarding_status` STRING COMMENT 'Current status of the volunteers onboarding process. Pending indicates application received, in progress indicates onboarding steps underway, completed indicates fully onboarded and ready for deployment, expired indicates onboarding credentials need renewal, and inactive indicates volunteer is not currently active.. Valid values are `pending|in progress|completed|expired|inactive`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the volunteer.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the volunteers residential address.',
    `preferred_name` STRING COMMENT 'The name the volunteer prefers to be called, which may differ from their legal name.',
    `primary_language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the volunteers primary or preferred language for communication.. Valid values are `^[a-z]{2}$`',
    `recognition_level` STRING COMMENT 'Recognition tier or award level assigned to the volunteer based on their contribution hours, impact, and tenure. Used for volunteer appreciation programs and engagement tracking.. Valid values are `bronze|silver|gold|platinum|lifetime`',
    `skills` STRING COMMENT 'Comma-separated list of skills, competencies, and professional qualifications the volunteer possesses, used for matching volunteers to program needs and deployment opportunities.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the volunteers residential address.',
    `total_volunteer_hours` DECIMAL(18,2) COMMENT 'Cumulative total number of hours the volunteer has contributed across all assignments and programs since registration.',
    `volunteer_type` STRING COMMENT 'Classification of the volunteer based on their role and engagement model. Community health workers provide ongoing health services, field volunteers support program delivery, event-based supporters assist with specific events, skilled professionals offer specialized expertise, youth volunteers are under 25, and corporate volunteers come through employer partnerships.. Valid values are `community health worker|field volunteer|event-based supporter|skilled professional|youth volunteer|corporate volunteer`',
    `willing_to_travel` BOOLEAN COMMENT 'Indicates whether the volunteer is willing to travel outside their geographic base for assignments, deployments, or emergency response.',
    CONSTRAINT pk_volunteer PRIMARY KEY(`volunteer_id`)
) COMMENT 'Volunteer - core entity in the volunteer domain supporting humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`application` (
    `application_id` BIGINT COMMENT 'Unique identifier for the volunteer application record. Primary key.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Applications are submitted to and processed by specific country offices for local recruitment, background checks, and onboarding coordination. Essential for decentralized volunteer management and comp',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: NGOs run emergency surge recruitment drives tied to specific declared emergencies. Linking application to emergency enables tracking of surge recruitment pipelines per emergency, supporting emergency ',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project for which the volunteer is applying.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Volunteers often apply to work specifically with a partner organization rather than directly with the lead NGO. Common in localization strategies where partners recruit and manage volunteers. Essentia',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Volunteer applications are submitted for roles at specific field sites. Site-specific volunteer recruitment is standard NGO practice — linking application to project_site enables site managers to trac',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_role. Business justification: Volunteer applications are submitted FOR a specific volunteer role. The application has denormalized volunteer_role_type (STRING) which should be normalized to FK to volunteer_role catalog. This allow',
    `volunteer_id` BIGINT COMMENT 'Reference to the constituent or prospective volunteer who submitted this application.',
    `application_date` DATE COMMENT 'The date on which the volunteer application was submitted by the applicant.',
    `application_number` STRING COMMENT 'Externally visible unique application reference number assigned to this volunteer application for tracking and communication purposes.. Valid values are `^VA-[0-9]{8}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the volunteer application in the recruitment and onboarding workflow. [ENUM-REF-CANDIDATE: submitted|under_review|screening|interview_scheduled|accepted|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `background_check_completed_date` DATE COMMENT 'The date on which the background check was completed.',
    `background_check_outcome` STRING COMMENT 'The final outcome or result of the background check process.. Valid values are `cleared|conditional|not_cleared`',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a background check is required for this volunteer application based on role sensitivity and organizational policy.',
    `background_check_status` STRING COMMENT 'Current status of the background check process for the applicant.. Valid values are `not_required|pending|in_progress|cleared|failed|expired`',
    `code_of_conduct_signed` BOOLEAN COMMENT 'Indicates whether the volunteer has signed the organizations code of conduct and ethical standards agreement.',
    `commitment_duration_months` STRING COMMENT 'The number of months the applicant is willing to commit to the volunteer role.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this volunteer application record was first created in the system.',
    `decision_date` DATE COMMENT 'The date on which the final decision on the volunteer application was made.',
    `decision_made_by` STRING COMMENT 'Name or identifier of the staff member or committee who made the final decision on the application.',
    `decision_status` STRING COMMENT 'The final decision status on the volunteer application: whether the applicant has been accepted, rejected, or placed on a waitlist.. Valid values are `pending|accepted|rejected|waitlisted`',
    `emergency_contact_provided` BOOLEAN COMMENT 'Indicates whether the volunteer has provided emergency contact information as part of the onboarding process.',
    `hours_per_week` DECIMAL(18,2) COMMENT 'The number of hours per week the applicant is available to volunteer.',
    `interview_completed_date` DATE COMMENT 'The date on which the interview was conducted.',
    `interview_notes` STRING COMMENT 'Internal notes and observations recorded by the interviewer during or after the volunteer interview.',
    `interview_outcome` STRING COMMENT 'The outcome or recommendation resulting from the volunteer interview.. Valid values are `recommended|not_recommended|conditional`',
    `interview_required` BOOLEAN COMMENT 'Indicates whether an interview is required as part of the volunteer application process for this role.',
    `interview_scheduled_date` TIMESTAMP COMMENT 'The date and time when the interview with the applicant is scheduled.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages the applicant speaks, relevant for field operations and beneficiary communication.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this volunteer application record was last updated or modified.',
    `motivation_statement` STRING COMMENT 'Applicants written statement explaining their motivation for volunteering and alignment with the organizations mission.',
    `onboarding_completed_date` DATE COMMENT 'The date on which the volunteer successfully completed all onboarding requirements and is ready for deployment.',
    `onboarding_start_date` DATE COMMENT 'The date on which the volunteer onboarding process began.',
    `onboarding_status` STRING COMMENT 'Status of the volunteer onboarding process, including orientation, training, and administrative setup.. Valid values are `not_started|in_progress|completed|incomplete`',
    `orientation_completed` BOOLEAN COMMENT 'Indicates whether the volunteer has completed the required orientation session introducing them to the organizations mission, values, and policies.',
    `preferred_start_date` DATE COMMENT 'The date on which the applicant indicates they are available to begin volunteering.',
    `previous_volunteer_experience` STRING COMMENT 'Narrative description of the applicants prior volunteer experience with this organization or other NGOs, CSOs, or INGOs.',
    `recruitment_channel` STRING COMMENT 'The channel or source through which the applicant learned about the volunteer opportunity and submitted their application.. Valid values are `website|social_media|referral|event|partner_organization|direct_outreach`',
    `reference_check_completed_date` DATE COMMENT 'The date on which reference checks were completed.',
    `reference_check_status` STRING COMMENT 'Status of the reference check process, including verification of applicants professional or personal references.. Valid values are `not_started|in_progress|completed|satisfactory|unsatisfactory`',
    `rejection_reason` STRING COMMENT 'Explanation or reason provided for rejecting the volunteer application, if applicable.',
    `safeguarding_policy_acknowledged` BOOLEAN COMMENT 'Indicates whether the volunteer has acknowledged and agreed to the organizations safeguarding and protection policies.',
    `screening_completed_date` DATE COMMENT 'The date on which the initial screening process was completed.',
    `screening_status` STRING COMMENT 'Status of the initial screening process to assess applicant suitability and alignment with volunteer role requirements.. Valid values are `not_started|in_progress|completed|cleared|flagged`',
    `skills_offered` STRING COMMENT 'Comma-separated list or narrative description of the skills, competencies, and expertise the applicant brings to the volunteer role.',
    `training_completed` BOOLEAN COMMENT 'Indicates whether the volunteer has completed all required role-specific training modules.',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Application - core entity in the volunteer domain supporting humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`role` (
    `role_id` BIGINT COMMENT 'Unique identifier for the volunteer role. Primary key for the volunteer role catalog.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a formal background check or police clearance is required before assignment to this volunteer role, typically for roles involving vulnerable populations.',
    `role_code` STRING COMMENT 'Unique business identifier code for the volunteer role used across systems and documentation.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this volunteer role record was first created in the system.',
    `deployment_context` STRING COMMENT 'The operational context in which this volunteer role is typically deployed, aligned with program phases and humanitarian response cycles. [ENUM-REF-CANDIDATE: Emergency Response|Development Program|Advocacy Campaign|Community Outreach|Capacity Building|Disaster Relief|Long-Term Recovery — 7 candidates stripped; promote to reference product]',
    `role_description` STRING COMMENT 'Comprehensive description of the volunteer role including responsibilities, typical activities, and expected contributions to program outcomes.',
    `effective_end_date` DATE COMMENT 'Date when this volunteer role is scheduled to be discontinued or archived. Null for ongoing roles with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this volunteer role became or will become active and available for volunteer assignments.',
    `estimated_time_commitment_hours` DECIMAL(18,2) COMMENT 'Expected number of volunteer hours per week or per assignment period for this role, used for scheduling and capacity planning.',
    `functional_area` STRING COMMENT 'The primary program or operational area where this volunteer role is deployed. WASH (Water Sanitation and Hygiene), GBV (Gender-Based Violence), PSS (Psychosocial Support), MEAL (Monitoring Evaluation Accountability and Learning), ICT4D (Information and Communication Technology for Development). [ENUM-REF-CANDIDATE: WASH|GBV|PSS|Nutrition|Logistics|Health|Education|Protection|Shelter|Livelihoods|MEAL|Communications|Fundraising|Administration|ICT4D — 15 candidates stripped; promote to reference product]',
    `insurance_coverage_required` BOOLEAN COMMENT 'Indicates whether the organization must provide or verify insurance coverage (medical, liability, travel) for volunteers in this role.',
    `language_requirements` STRING COMMENT 'Languages required or preferred for this volunteer role, including proficiency levels, to ensure effective communication with beneficiaries and team members.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that most recently updated this volunteer role record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this volunteer role record was most recently updated.',
    `maximum_concurrent_assignments` STRING COMMENT 'Maximum number of volunteers that can be simultaneously assigned to this role, used for capacity planning and deployment management.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age in years that a volunteer must be to be eligible for this role, based on legal, safety, and program requirements.',
    `physical_demands` STRING COMMENT 'Level of physical exertion and mobility required for this volunteer role, ranging from sedentary office work to strenuous field activities.. Valid values are `None|Light|Moderate|Heavy|Extreme`',
    `preferred_skills` STRING COMMENT 'Comma-separated list of desirable but not mandatory skills that would enhance volunteer effectiveness in this role.',
    `recognition_program_eligible` BOOLEAN COMMENT 'Indicates whether volunteers in this role are eligible for formal recognition programs, awards, or certificates upon completion.',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether this volunteer role can be performed remotely or requires physical presence at a specific location.',
    `reporting_requirements` STRING COMMENT 'Description of reporting obligations for volunteers in this role, including frequency, format, and content of activity reports or timesheets.',
    `required_skills` STRING COMMENT 'Comma-separated list of essential skills, competencies, and technical abilities required to perform this volunteer role effectively.',
    `risk_level` STRING COMMENT 'Security and safety risk classification for this volunteer role based on deployment context, location, and nature of activities.. Valid values are `Low|Medium|High|Critical`',
    `role_status` STRING COMMENT 'Current lifecycle status of the volunteer role indicating whether it is available for recruitment and assignment.. Valid values are `Active|Inactive|Suspended|Under Review|Archived`',
    `role_type` STRING COMMENT 'Classification of the volunteer role by engagement model and location context.. Valid values are `Field|Office|Remote|Hybrid|Event-Based|Ongoing`',
    `safeguarding_training_required` BOOLEAN COMMENT 'Indicates whether completion of organizational safeguarding and protection training is mandatory before deployment in this role.',
    `stipend_amount` DECIMAL(18,2) COMMENT 'Standard stipend or per diem amount provided to volunteers in this role, if applicable. Null if no stipend is provided.',
    `stipend_eligible` BOOLEAN COMMENT 'Indicates whether volunteers in this role are eligible to receive a stipend, per diem, or other financial support to cover expenses.',
    `supervision_level` STRING COMMENT 'Level of supervision and oversight required for volunteers in this role, ranging from independent work to intensive direct supervision.. Valid values are `Independent|Minimal|Moderate|Close|Intensive`',
    `time_commitment_unit` STRING COMMENT 'Unit of measure for the estimated time commitment (e.g., hours per week, total hours for event-based roles).. Valid values are `Per Week|Per Month|Per Assignment|Per Event|Total`',
    `title` STRING COMMENT 'The official title of the volunteer role as presented to volunteers and used in recruitment materials.',
    `travel_required` BOOLEAN COMMENT 'Indicates whether this volunteer role requires travel to field sites, beneficiary locations, or other operational areas.',
    `typical_assignment_duration_days` STRING COMMENT 'Standard length of a volunteer assignment in this role measured in days, used for planning and volunteer expectation setting.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this volunteer role record.',
    CONSTRAINT pk_role PRIMARY KEY(`role_id`)
) COMMENT 'Role - core entity in the volunteer domain supporting humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`deployment` (
    `deployment_id` BIGINT COMMENT 'Unique identifier for the volunteer deployment record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Volunteer deployments under consortium or partnership agreements require tracking which agreement governs the deployment for compliance, insurance, liability determination, and donor reporting on part',
    `application_id` BIGINT COMMENT 'Foreign key linking to volunteer.application. Business justification: A volunteer deployment is the operational outcome of an approved application. The application captures the screening, interview, background check, and approval process; the deployment captures the act',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to field.assessment. Business justification: NGOs deploy volunteers specifically to conduct field assessments (KIIs, FGDs, PDM surveys). Linking volunteer_deployment to the assessment they supported enables MEL reporting on volunteer contributio',
    `award_id` BIGINT COMMENT 'Identifier of the grant or funding source supporting this volunteer deployment position.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to donor.campaign. Business justification: Donor stewardship reports show volunteers deployed under a specific fundraising campaign (e.g., a campaign funds a field deployment). This link enables campaign impact reporting — X volunteers deploy',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to partnership.consortium. Business justification: Volunteers are deployed under consortium-managed humanitarian programs. A direct consortium_id on volunteer_deployment enables reporting of volunteer contributions by consortium, supports consortium-l',
    `country_id` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the volunteer is deployed.',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office or regional office coordinating this volunteer deployment.',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Volunteers support distribution operations (loading trucks, beneficiary registration, crowd management, distribution site setup). Linking deployments to specific distribution orders enables accurate v',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan. Business justification: Distribution Workforce Planning: NGO operations assign volunteer deployments to execute a specific distribution plan. This link enables donor reporting and operational queries on which volunteers wer',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency surge deployments are a core NGO volunteer management scenario. Linking volunteer_deployment to the triggering emergency enables surge capacity reporting, CERF/flash appeal documentation, an',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Donor funds frequently specify volunteer deployment requirements as grant conditions. Linking volunteer_deployment to donor_fund enables fund-level compliance reporting (deployments financed per fund)',
    `intervention_id` BIGINT COMMENT 'Identifier of the program to which the volunteer is assigned.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Volunteers are routinely deployed to work with/through partner organizations in field operations. Essential for tracking volunteer placement arrangements, liability coverage, partnership performance m',
    `project_site_id` BIGINT COMMENT 'Identifier of the field location or project site where the volunteer is deployed.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: NGO donor reporting requires aggregating volunteer deployment contributions within defined reporting periods. MEL teams must reconcile deployment hours and outputs against each reporting cycle for ind',
    `role_id` BIGINT COMMENT 'Identifier of the role or position the volunteer is performing during this deployment.',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Volunteer deployments executed by partner organizations under subawards must be tracked against the specific subaward for compliance, expenditure responsibility reporting, and subaward closeout. award',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer being deployed to the program or field operation.',
    `volunteer_team_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_team. Business justification: Volunteer deployments can be team-based assignments where the volunteer is deployed as part of a team structure. Not all deployments are team-based (many are individual), so this FK is nullable. This ',
    `actual_end_date` DATE COMMENT 'The actual date the volunteer completed or left the deployment, which may differ from the scheduled deployment end date.',
    `actual_hours` DECIMAL(18,2) COMMENT 'The total number of volunteer hours actually contributed during this deployment, tracked for MEL and donor reporting.',
    `actual_start_date` DATE COMMENT 'The actual date the volunteer began work on the deployment, which may differ from the scheduled deployment start date.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this deployment record was first created in the system.',
    `deployment_number` STRING COMMENT 'Human-readable unique business identifier for the deployment assignment, used for tracking and reporting.. Valid values are `^VD-[0-9]{6,10}$`',
    `deployment_status` STRING COMMENT 'Current lifecycle status of the volunteer deployment: active (currently deployed), completed (assignment finished), withdrawn (volunteer left early), suspended (temporarily paused), pending (approved but not started), or cancelled (assignment cancelled before start).. Valid values are `active|completed|withdrawn|suspended|pending|cancelled`',
    `deployment_type` STRING COMMENT 'Classification of the deployment based on the nature of the assignment: emergency response, development program, event support, capacity building, advocacy campaign, or disaster relief.. Valid values are `emergency_response|development_program|event_support|capacity_building|advocacy_campaign|disaster_relief`',
    `end_date` DATE COMMENT 'Date when the volunteer deployment to the partner organization ended or is scheduled to end. Null indicates an ongoing deployment.',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'The full-time equivalent contribution of the volunteer during this deployment, expressed as a decimal (e.g., 0.5000 for half-time, 1.0000 for full-time).',
    `hours_contributed` DECIMAL(18,2) COMMENT 'Total number of hours the volunteer has contributed during this specific deployment to this partner organization. Used for tracking volunteer engagement and reporting.',
    `location_name` STRING COMMENT 'The name of the specific location, community, or facility where the volunteer is deployed.',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified this deployment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this deployment record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments about the deployment, including coordination details, performance observations, or special circumstances.',
    `orientation_completed_date` DATE COMMENT 'The date when the volunteer completed the deployment-specific orientation or onboarding.',
    `orientation_completed_flag` BOOLEAN COMMENT 'Indicates whether the volunteer has completed the required orientation or onboarding for this specific deployment.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Performance assessment score for the volunteer during this deployment, typically on a scale (e.g., 1.00 to 5.00). Reflects the partner organizations evaluation of the volunteers effectiveness in this specific assignment.',
    `planned_hours` DECIMAL(18,2) COMMENT 'The total number of volunteer hours planned or expected for this deployment assignment.',
    `priority` STRING COMMENT 'The priority level of this deployment assignment, indicating urgency and importance for resource allocation and coordination.. Valid values are `low|medium|high|critical|emergency`',
    `recognition_awarded_flag` BOOLEAN COMMENT 'Indicates whether the volunteer received formal recognition or an award for their contribution during this deployment.',
    `region` STRING COMMENT 'The administrative region, province, or district within the country where the volunteer is deployed.',
    `remote_deployment_flag` BOOLEAN COMMENT 'Indicates whether this is a remote or virtual deployment where the volunteer contributes remotely rather than being physically present at the project site.',
    `role` STRING COMMENT 'Specific role or function the volunteer performs during this deployment (e.g., Community Health Worker, Field Coordinator, Training Facilitator). The same volunteer may have different roles at different partner organizations.',
    `security_clearance_level` STRING COMMENT 'The level of security clearance required or obtained for this deployment, particularly relevant for high-risk or conflict-affected areas.. Valid values are `none|basic|standard|enhanced|critical`',
    `source_system_code` STRING COMMENT 'The unique identifier of this deployment record in the source system.',
    `special_conditions` STRING COMMENT 'Any special conditions, requirements, or accommodations associated with this deployment (e.g., remote work, hazard pay equivalent, specific equipment needs).',
    `start_date` DATE COMMENT 'Date when the volunteer deployment to the partner organization began. Tracks the beginning of the assignment period.',
    `volunteer_deployment_status` STRING COMMENT 'Current lifecycle status of the deployment. Active indicates ongoing assignment, Completed indicates successfully finished deployment, Suspended indicates temporarily paused, Cancelled indicates terminated before completion.',
    `withdrawal_date` DATE COMMENT 'The date when the volunteer withdrew from or was removed from the deployment.',
    `withdrawal_reason` STRING COMMENT 'The reason provided when a volunteer withdraws from or is removed from a deployment before completion.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this deployment record.',
    CONSTRAINT pk_deployment PRIMARY KEY(`deployment_id`)
) COMMENT 'Volunteer Deployment - core entity in the volunteer domain supporting humanitarian operations. [SSOT: dependent alias of canonical field.field_deployment; defer to canonical for shared attributes and link via field_deployment_id.]';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` (
    `hour_log_id` BIGINT COMMENT 'Unique identifier for the volunteer hour log entry. Primary key for the hour log record.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to field.assessment. Business justification: Volunteers conducting household surveys or KIIs log hours against specific assessments. Linking hour_log to assessment enables donor reporting on volunteer in-kind contributions to assessment activiti',
    `award_budget_line_id` BIGINT COMMENT 'Foreign key linking to grant.award_budget_line. Business justification: NGO financial management requires allocating volunteer hours (including in-kind value) to specific award budget lines for cost-share tracking, indirect cost base calculation, and donor financial repor',
    `budget_plan_line_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan_line. Business justification: Donor compliance reporting (USAID, EU) requires in-kind volunteer hours to be allocated against specific budget line items. NGO finance teams use this link to calculate fair-market-value of volunteer ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to donor.campaign. Business justification: NGO donor reports require volunteer labor costs attributed per fundraising campaign (e.g., gala staffing, phone banks). Linking hour_log to campaign enables campaign ROI reports that include in-kind v',
    `case_record_id` BIGINT COMMENT 'Foreign key linking to beneficiary.case_record. Business justification: Volunteers log hours against specific protection/GBV case records for case management reporting and donor accountability. This enables total volunteer time per case calculation, case closure analysis,',
    `component_id` BIGINT COMMENT 'Identifier of the program or project to which the volunteer hours are attributed. Enables program-level effort tracking.',
    `deployment_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_deployment. Business justification: An hour_log entry records hours worked by a volunteer in the context of a specific deployment. volunteer_deployment is the operational parent record that defines the scope, role, and assignment contex',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Volunteer hours during distributions must be attributed to specific events for donor reporting, cost allocation, and activity-based costing. Required for grant compliance and in-kind contribution valu',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Volunteer hours directly supporting specific distribution orders (packing commodities, transport escort, distribution point setup) must be linked to distribution orders for accurate in-kind contributi',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Volunteer hours contributed during emergency response must be attributed to the specific emergency for flash appeal reporting and CERF in-kind contribution valuation. This is a standard NGO donor acco',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Volunteer in-kind hours (in_kind_value, fair_market_value_rate on hour_log) must be attributed to a donor fund for cost-share matching compliance. Many grants require in-kind volunteer contributions a',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Volunteer hours are tracked against specific indicators for donor reporting (e.g., volunteer hours contributed to health education as indicator). Required for USAID VKR, EU in-kind contribution repo',
    `project_site_id` BIGINT COMMENT 'Identifier of the field project site or location where the volunteer hours were contributed. Links to field operations site master.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Volunteers log hours against specific beneficiaries they serve for direct service delivery tracking. Required for donor reporting, impact measurement, and demonstrating beneficiary reach. Standard pra',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: In-kind volunteer time valuation is a standard NGO donor reporting requirement. Hour logs must be aggregated per reporting period to calculate in-kind contributions for financial reports and donor sub',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_role. Business justification: Hour logs record time worked in the context of performing a specific volunteer role. The hour_log table has skill_utilized (STRING) which is a denormalized representation of the role/skill context. No',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer who contributed the hours. Links to the volunteer master record.',
    `volunteer_team_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_team. Business justification: Hour logs can be recorded in the context of team-based activities (the is_group_activity flag on hour_log indicates group work). Linking hour_log directly to volunteer_team enables team-level hour agg',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Volunteer hours logged at warehouse locations (sorting in-kind donations, physical inventory counts, emergency kit assembly) must capture warehouse location for cost center allocation, in-kind contrib',
    `activity_description` STRING COMMENT 'Detailed narrative description of the volunteer activity performed during the logged hours. Provides context for the contribution.',
    `activity_type` STRING COMMENT 'Classification of the volunteer activity performed. Categorizes the nature of the volunteer contribution for reporting and analysis.. Valid values are `direct_service|administrative_support|fundraising_event|training_facilitation|community_outreach|monitoring_evaluation`',
    `approval_status` STRING COMMENT 'Current approval status of the volunteer hour log entry. Tracks the workflow state of the timesheet record.. Valid values are `pending|approved|rejected|under_review|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the volunteer hours were approved. Records the moment of supervisor sign-off.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for this hour log entry. Supports institutional donor compliance and audit requirements.',
    `beneficiary_count` STRING COMMENT 'Number of beneficiaries directly served or impacted during the volunteer activity. Supports MEL indicator calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the hour log record was first created in the system. System audit field for record lifecycle tracking.',
    `device_code` STRING COMMENT 'Identifier of the device used to submit or verify the volunteer hours. Supports digital check-in and GPS verification methods.',
    `donor_report_eligible` BOOLEAN COMMENT 'Flag indicating whether the volunteer hours are eligible for inclusion in donor reports and institutional compliance reporting.',
    `end_time` TIMESTAMP COMMENT 'Timestamp when the volunteer activity ended. Used to calculate duration and validate claimed hours.',
    `fair_market_value_rate` DECIMAL(18,2) COMMENT 'Fair market value rate per hour used to calculate the in-kind contribution value of volunteer hours. Based on IRS guidelines or local equivalents.',
    `hours_claimed` DECIMAL(18,2) COMMENT 'Number of volunteer hours claimed or self-reported by the volunteer for the activity. Initial submission value before verification.',
    `hours_verified` DECIMAL(18,2) COMMENT 'Number of volunteer hours verified and approved by a supervisor or through automated validation. Final accepted value for reporting.',
    `in_kind_value` DECIMAL(18,2) COMMENT 'Calculated in-kind contribution value of the volunteer hours (hours_verified × fair_market_value_rate). Used for donor reporting and financial statements.',
    `is_group_activity` BOOLEAN COMMENT 'Flag indicating whether the volunteer activity was performed as part of a group or team (true) versus individually (false).',
    `is_overtime` BOOLEAN COMMENT 'Flag indicating whether the volunteer hours exceed the standard expected commitment for the period. Used for volunteer engagement monitoring.',
    `is_virtual` BOOLEAN COMMENT 'Flag indicating whether the volunteer activity was performed virtually or remotely (true) versus on-site (false).',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the volunteer activity location. Supports GPS-based verification and spatial analysis.',
    `location_name` STRING COMMENT 'Name or description of the specific location where the volunteer hours were contributed. Provides geographic context.',
    `log_date` DATE COMMENT 'The calendar date on which the volunteer hours were contributed. Primary business event date for timesheet reporting.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the volunteer activity location. Supports GPS-based verification and spatial analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the hour log record was last modified. System audit field for change tracking and compliance.',
    `notes` STRING COMMENT 'Additional notes or comments about the volunteer hour log entry. Captures supervisor feedback, exceptions, or contextual information.',
    `recognition_milestone_triggered` BOOLEAN COMMENT 'Flag indicating whether this hour log entry triggered a volunteer recognition milestone (e.g., 100 hours, 500 hours). Used to automate recognition workflows.',
    `rejection_reason` STRING COMMENT 'Reason provided by the supervisor for rejecting the volunteer hour log entry. Populated only when approval_status is rejected.',
    `start_time` TIMESTAMP COMMENT 'Timestamp when the volunteer activity started. Provides precise timing for shift-based or event-based volunteer work.',
    `submission_method` STRING COMMENT 'Method or channel through which the volunteer submitted the hour log entry. Tracks data collection channel for quality assessment.. Valid values are `mobile_app|web_portal|paper_form|sms|email|kiosk`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the volunteer hour log entry was initially submitted by the volunteer. Records the moment of timesheet submission.',
    `verification_method` STRING COMMENT 'Method used to verify the volunteer hours. Indicates the level of validation applied to the hour log entry.. Valid values are `supervisor_signoff|digital_checkin|gps_verification|self_reported|biometric_scan|event_roster`',
    CONSTRAINT pk_hour_log PRIMARY KEY(`hour_log_id`)
) COMMENT 'Hour Log - core entity in the volunteer domain supporting humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`training` (
    `training_id` BIGINT COMMENT 'Unique identifier for the training program. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Training programs are frequently grant-funded deliverables; donor reporting requires linking training activities to the funding award. The existing plain-text funding_source column is a denormalized',
    `capacity_building_plan_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_building_plan. Business justification: Capacity building plans prescribe specific training activities for partner staff and volunteers. Linking training to the commissioning capacity_building_plan is required to track plan execution, repor',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Specialized commodity handling training (cold chain management for vaccines, hazmat handling, pharmaceutical storage protocols, food safety for nutrition commodities) must link to specific commodity t',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: NGO interventions mandate specific volunteer trainings (e.g., safeguarding, CHS, SPHERE standards) as part of their design. Program managers need to identify which trainings are required by each inter',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partner organizations frequently deliver training to volunteers (local context, safeguarding, technical skills). Tracking the delivering partner is essential for quality assurance, certification valid',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Subawards to partner organizations frequently include training as a contractual deliverable. Subaward compliance monitoring and FSRS/expenditure responsibility reporting require direct linkage between',
    `accrediting_body` STRING COMMENT 'Official organization or institution that accredits or endorses this training program, such as SPHERE Association, CHS Alliance, or national certification bodies.',
    `assessment_method` STRING COMMENT 'Method used to assess volunteer competency and completion: written exam, practical demonstration, project submission, peer review, or no formal assessment.. Valid values are `written_exam|practical_demonstration|project_submission|peer_review|no_assessment`',
    `available_languages` STRING COMMENT 'Comma-separated list of ISO 639-3 language codes for all languages in which this training is available, supporting multilingual volunteer populations.',
    `training_category` STRING COMMENT 'Classification of the training program. Categories include safety and security, technical skills, Core Humanitarian Standard (CHS) orientation, SPHERE standards, Gender-Based Violence (GBV) awareness, Protection from Sexual Exploitation and Abuse (PSEA), first aid, and other capacity-building areas.. Valid values are `safety_and_security|technical_skills|chs_orientation|sphere_standards|gbv_awareness|psea`',
    `certification_awarded` STRING COMMENT 'Name of the certificate or credential awarded to volunteers upon successful completion of the training program.',
    `certification_validity_months` STRING COMMENT 'Number of months the certification remains valid before renewal or recertification is required. Null if certification does not expire.',
    `chs_standard_alignment` STRING COMMENT 'Specific Core Humanitarian Standard (CHS) commitments that this training addresses, ensuring accountability and quality in humanitarian response.',
    `training_code` STRING COMMENT 'Externally-known unique code for the training program used in volunteer systems and communications.. Valid values are `^[A-Z0-9]{6,12}$`',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Average cost incurred by the organization per volunteer participant for delivering this training, including materials, facilitator fees, and venue costs. Used for budget planning and grant reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training program record was first created in the system.',
    `delivery_modality` STRING COMMENT 'Method by which the training is delivered to volunteers: in-person classroom, e-learning online, blended (combination), virtual instructor-led, or self-paced.. Valid values are `in_person|e_learning|blended|virtual_instructor_led|self_paced`',
    `training_description` STRING COMMENT 'Detailed description of the training program content, learning objectives, and expected outcomes for volunteers.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training program measured in hours, including all sessions and modules.',
    `effective_from_date` DATE COMMENT 'Date when this training program becomes available for volunteer enrollment and delivery.',
    `effective_until_date` DATE COMMENT 'Date when this training program is scheduled to be retired or replaced. Null if no end date is planned.',
    `facilitator_name` STRING COMMENT 'Name of the primary facilitator or instructor responsible for delivering the training program.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this training is mandatory for specific volunteer roles or deployment types. True if required, False if optional.',
    `language` STRING COMMENT 'Primary language in which the training is delivered, using ISO 639-3 three-letter language codes (e.g., ENG for English, FRA for French, ARA for Arabic).. Valid values are `^[A-Z]{3}$`',
    `last_review_date` DATE COMMENT 'Date when the training content and materials were last reviewed and updated to ensure relevance and accuracy.',
    `materials_url` STRING COMMENT 'Web URL where training materials, resources, and documentation can be accessed by volunteers and facilitators.. Valid values are `^https?://.*$`',
    `max_participants` STRING COMMENT 'Maximum number of volunteers that can enroll in a single session or cohort of this training program. Null if no limit.',
    `modified_by` STRING COMMENT 'Name or identifier of the staff member or partner who last modified this training program record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training program record was last modified in the system.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and update of the training program content and materials.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required for volunteers to pass the training assessment and receive certification. Null if no assessment.',
    `prerequisites` STRING COMMENT 'Required prior training, certifications, or experience that volunteers must have before enrolling in this training program.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goal (SDG) numbers that this training program supports (e.g., SDG 3 Good Health, SDG 4 Quality Education).',
    `sphere_standard_alignment` STRING COMMENT 'Specific SPHERE Humanitarian Charter and Minimum Standards chapters or technical standards that this training covers (e.g., WASH, Shelter, Health).',
    `target_audience` STRING COMMENT 'Description of the intended volunteer audience for this training, such as community health workers, field volunteers, event-based supporters, or program-specific volunteers.',
    `title` STRING COMMENT 'Full title of the training program or workshop as presented to volunteers.',
    `training_status` STRING COMMENT 'Current lifecycle status of the training program: draft (under development), active (available for enrollment), suspended (temporarily unavailable), retired (no longer offered), or under review (being updated).. Valid values are `draft|active|suspended|retired|under_review`',
    `version` STRING COMMENT 'Version number of the training program content, following semantic versioning (e.g., 1.0, 2.1), to track curriculum updates and revisions.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_by` STRING COMMENT 'Name or identifier of the staff member or partner who created this training program record in the system.',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Training - core entity in the volunteer domain supporting humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'Unique identifier for the training enrollment record. Primary key.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Training enrollment costs (enrollment_cost field) are charged to donor funds when grant-funded. The existing funding_source plain-text field is a denormalized representation of donor_fund. A proper FK',
    `intervention_id` BIGINT COMMENT 'Identifier of the program context for which this training enrollment is required or associated.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: When volunteers take training delivered by a partner organization, this link tracks the delivery partner for certification validation, quality assurance, and partnership reporting. Essential for capac',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: On-site training delivery at project sites is standard NGO practice. training_enrollment has a plain-text training_location column (denormalization signal). Linking to project_site_id normalizes this,',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Beneficiaries enroll in capacity-building training delivered or facilitated by volunteers (livelihoods, life skills, vocational training, health education). Core program activity linking beneficiary d',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Donor compliance reporting requires tracking training completions within defined reporting periods (e.g., 80% of volunteers trained by Q2). Linking training_enrollment to reporting_period enables ME',
    `training_id` BIGINT COMMENT 'Identifier of the training course in which the volunteer is enrolled.',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer enrolled in the training course.',
    `assessment_attempts` STRING COMMENT 'Number of times the volunteer attempted the training course assessment.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the volunteer on the training course assessment or examination, typically expressed as a percentage.',
    `certificate_expiry_date` DATE COMMENT 'Date on which the training certificate expires and requires renewal or recertification.',
    `certificate_issue_date` DATE COMMENT 'Date on which the training certificate was issued to the volunteer.',
    `certificate_number` STRING COMMENT 'Unique certificate reference number issued to the volunteer upon successful completion of the training course.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a certification was issued to the volunteer upon successful completion of the training course.',
    `compliance_training_category` STRING COMMENT 'Category of compliance or regulatory training that this enrollment represents, such as Protection from Sexual Exploitation and Abuse (PSEA), Core Humanitarian Standard (CHS), safeguarding, data protection, health and safety, or financial integrity. [ENUM-REF-CANDIDATE: psea|chs|safeguarding|data_protection|health_safety|financial_integrity|other — 7 candidates stripped; promote to reference product]',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development credits earned by the volunteer upon successful completion of the training course.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the training enrollment record was first created in the system.',
    `enrollment_cost` DECIMAL(18,2) COMMENT 'Cost incurred by the organization for enrolling the volunteer in the training course, including tuition, materials, and administrative fees.',
    `enrollment_date` DATE COMMENT 'Date on which the volunteer was enrolled in the training course.',
    `enrollment_source` STRING COMMENT 'Source or channel through which the volunteer was enrolled in the training course.. Valid values are `self_enrolled|manager_assigned|program_required|hr_assigned|system_triggered`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the training enrollment indicating the volunteers progress through the course.. Valid values are `registered|in_progress|completed|failed|withdrawn|cancelled`',
    `feedback_comments` DECIMAL(18,2) COMMENT 'Free-text comments provided by the volunteer regarding their experience with the training course, including suggestions for improvement.',
    `feedback_rating` DECIMAL(18,2) COMMENT 'Numeric rating provided by the volunteer evaluating the quality and effectiveness of the training course, typically on a scale of 1 to 5.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the training enrollment record was last updated or modified in the system.',
    `mandatory_training_flag` BOOLEAN COMMENT 'Indicates whether this training course is mandatory for the volunteer based on their role, program assignment, or organizational policy (e.g., PSEA, CHS, safeguarding).',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the training enrollment, including special accommodations, exceptions, or contextual information.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training course assessment, typically expressed as a percentage.',
    `recertification_due_date` DATE COMMENT 'Date by which the volunteer must complete recertification or refresher training to maintain their certification status.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the volunteer is required to undergo recertification or refresher training after the certificate expiry date.',
    `training_completion_date` DATE COMMENT 'Date on which the volunteer successfully completed the training course.',
    `training_delivery_mode` STRING COMMENT 'Mode or format in which the training course was delivered to the volunteer.. Valid values are `in_person|online|hybrid|self_paced|webinar|workshop`',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of hours the volunteer spent in the training course, including instruction, practice, and assessment time.',
    `training_language` STRING COMMENT 'Primary language in which the training course content was delivered to the volunteer.',
    `training_start_date` DATE COMMENT 'Date on which the volunteer began the training course.',
    `training_withdrawal_date` DATE COMMENT 'Date on which the volunteer withdrew from the training course before completion.',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the volunteer or organization for withdrawing from the training course before completion.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Training Enrollment - core entity in the volunteer domain supporting humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the certification record. Primary key for the certification entity.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Commodity Handling Certification Compliance: NGO supply chains require volunteers to hold specific certifications to handle commodities (e.g., cold chain cert for vaccines, hazmat cert for hazardous m',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partner organizations frequently issue or co-accredit safeguarding, CHS, and technical certifications for volunteers in joint programs. Linking certification to the issuing partner org enables credent',
    `training_enrollment_id` BIGINT COMMENT 'Foreign key linking to volunteer.training_enrollment. Business justification: A certification record is frequently generated as a direct result of a training enrollment completion. The training_enrollment table tracks certification_issued_flag, certificate_number, certificate_i',
    `training_id` BIGINT COMMENT 'Foreign key linking to volunteer.training. Business justification: A certification is often awarded upon completion of a specific training program. The training table has a certification_awarded field indicating which certification a training confers. Linking certifi',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer who holds this certification. Links to the volunteer master record.',
    `accreditation_body` STRING COMMENT 'Name of the accreditation or regulatory body that oversees the issuing organization (e.g., national medical board, international humanitarian standards body). Used for credential validation.',
    `assessment_passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the certification assessment. Used to determine whether the volunteer met competency standards.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score or grade achieved on the certification assessment or examination. Null if no formal assessment was conducted.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued by the certifying body. Used for verification and audit purposes.',
    `certification_type` STRING COMMENT 'Type of certification record: professional license (e.g., nursing, medical), certificate (e.g., first aid, SPHERE practitioner), training completion, self-assessed proficiency, verified competency, or compliance certificate (e.g., Protection from Sexual Exploitation and Abuse (PSEA), safeguarding).. Valid values are `professional_license|certificate|training_completion|self_assessed|verified_competency|compliance_certificate`',
    `compliance_category` STRING COMMENT 'Regulatory or organizational compliance category this certification satisfies: Protection from Sexual Exploitation and Abuse (PSEA), safeguarding, data protection, security clearance, health and safety, ethics, or none for non-compliance certifications. [ENUM-REF-CANDIDATE: psea|safeguarding|data_protection|security|health_safety|ethics|none — 7 candidates stripped; promote to reference product]',
    `continuing_education_hours` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development hours required for renewal. Null if not applicable.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to obtain or renew the certification. Used for volunteer investment tracking and reimbursement processing.',
    `cost_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount.',
    `country_of_issue` STRING COMMENT 'Three-letter ISO country code of the country where the certification was issued. Relevant for professional licenses and country-specific credentials.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Used for audit trail and data lineage tracking.',
    `deployment_eligible` BOOLEAN COMMENT 'Indicates whether this certification qualifies the volunteer for field deployment. True for certifications that meet deployment readiness criteria (verified, current, and role-appropriate).',
    `evidence_document_reference` STRING COMMENT 'Reference identifier or file path to the supporting documentation (certificate scan, transcript, license copy) stored in the document management system.',
    `expiry_date` DATE COMMENT 'Date when the certification expires and requires renewal. Null for certifications with no expiration (e.g., academic degrees, lifetime licenses).',
    `issue_date` DATE COMMENT 'Date when the certification or credential was originally issued to the volunteer.',
    `issuing_body` STRING COMMENT 'Name of the organization, institution, or authority that issued the certification (e.g., Red Cross, Sphere Association, Ministry of Health, professional licensing board, internal training department).',
    `language_of_certification` STRING COMMENT 'Primary language in which the certification training and assessment were conducted. Important for language-specific skill matching and deployment planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was most recently updated. Used for audit trail and change tracking.',
    `last_verified_date` DATE COMMENT 'Date when the certification was most recently verified by the organization through documentation review or third-party confirmation.',
    `mandatory_for_role` BOOLEAN COMMENT 'Indicates whether this certification is mandatory (required) for the volunteers assigned role versus preferred (nice-to-have). Used for deployment readiness assessment and compliance tracking.',
    `certification_name` STRING COMMENT 'Full name of the certification, credential, or training program (e.g., Certified Emergency Medical Technician, SPHERE Practitioner Certificate, PSEA Compliance Training, Community Health Worker Level 2).',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the certification, including special conditions, restrictions, verification challenges, or other relevant information for volunteer coordinators.',
    `proficiency_level` STRING COMMENT 'Level of proficiency or competency in the skill: beginner (basic awareness), intermediate (can perform with supervision), advanced (can perform independently), expert (can train others), master (recognized authority).. Valid values are `beginner|intermediate|advanced|expert|master`',
    `recognized_by_organization` BOOLEAN COMMENT 'Indicates whether this certification is formally recognized and accepted by the organization for volunteer deployment and role assignment. False for certifications that are recorded but not organizationally endorsed.',
    `reimbursed_by_organization` BOOLEAN COMMENT 'Indicates whether the organization reimbursed the volunteer for the cost of obtaining this certification. Used for financial tracking and volunteer benefit reporting.',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals for time-limited certifications. Null if renewal is not required or frequency is irregular.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether this certification requires periodic renewal to remain valid. True for time-limited certifications (e.g., first aid, PSEA training), false for permanent credentials.',
    `skill_category` STRING COMMENT 'Primary category of the skill or competency. Aligns with organizational skill taxonomy including medical, logistics, language, psychosocial support (PSS), Water Sanitation and Hygiene (WASH), Information and Communication Technology for Development (ICT4D), community mobilization, protection, nutrition, and education. [ENUM-REF-CANDIDATE: medical|logistics|language|psychosocial|wash|ict4d|community_mobilization|protection|nutrition|education — 10 candidates stripped; promote to reference product]',
    `skill_name` STRING COMMENT 'Specific name of the skill or competency (e.g., First Aid, Community Health Worker Training, SPHERE Standards, Gender-Based Violence (GBV) Response, Mid-Upper Arm Circumference (MUAC) Screening, Psychosocial Support (PSS) Facilitation).',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of training or instruction hours completed to earn this certification. Used for volunteer contribution tracking and competency assessment.',
    `verification_status` STRING COMMENT 'Current verification status of the certification: verified (documentation confirmed), pending verification (under review), self-reported (not yet verified), expired (past validity date), revoked (withdrawn by issuer), not verified (no documentation provided).. Valid values are `verified|pending_verification|self_reported|expired|revoked|not_verified`',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Certification - core entity in the volunteer domain supporting humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` (
    `volunteer_team_id` BIGINT COMMENT 'Unique identifier for the volunteer team. Primary key.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: NGO program components (e.g., livelihoods, WASH, protection) each have dedicated volunteer teams. Component managers need to identify their assigned teams for resource planning, budget allocation repo',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Volunteer teams operate under country office administrative oversight for compliance, budget allocation, and reporting. Required for organizational hierarchy, resource management, and country-level vo',
    `field_team_id` BIGINT COMMENT 'Canonical SSOT reference to field.field_team (this product is a non-authoritative duplicate). SSOT link to canonical field.field_team.',
    `intervention_id` BIGINT COMMENT 'Identifier of the program or project to which this volunteer team is affiliated and deployed.',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer who serves as the team lead or coordinator. May be null if led by staff.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: NGO volunteer teams are routinely co-deployed with or hosted by a partner organization. Tracking the implementing partner at team level is required for partner performance reporting, resource attribut',
    `project_site_id` BIGINT COMMENT 'Identifier of the primary field project site or geographic location where this team operates.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Warehouse-Based Team Assignment: NGO logistics operations assign volunteer teams a home warehouse for supply operations (receiving, sorting, distribution staging). Enables which teams are based at th',
    `beneficiaries_served_count` STRING COMMENT 'Cumulative count of unique beneficiaries or Persons of Concern (PoC) served by this team since formation.',
    `budget_allocation` DECIMAL(18,2) COMMENT 'The financial budget allocated to support this volunteer teams operations, including training, supplies, and recognition activities. Stored in the organizations base currency.',
    `communication_channel` STRING COMMENT 'The primary communication channel or platform used for team coordination and information sharing. [ENUM-REF-CANDIDATE: whatsapp|email|sms|radio|in_person|microsoft_teams|other — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this volunteer team record was first created in the system.',
    `current_member_count` STRING COMMENT 'The current number of active volunteers who are members of this team.',
    `dissolution_date` DATE COMMENT 'The date on which the volunteer team was officially dissolved or deactivated. Null if the team is still active.',
    `equipment_assigned` STRING COMMENT 'Description or list of equipment, supplies, or Non-Food Items (NFI) assigned to the team for operational use (e.g., Mobile tablets, first aid kits, distribution tents, hygiene kits).',
    `formation_date` DATE COMMENT 'The date on which the volunteer team was officially formed and became operational.',
    `geographic_area` STRING COMMENT 'Textual description of the geographic area, district, camp, or community where the team is deployed (e.g., District 5, Northern Province, Refugee Camp B, Sector 3).',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this team record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this volunteer team record was last updated in the system.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent performance review or evaluation conducted for this team.',
    `meeting_frequency` STRING COMMENT 'The regular frequency at which the team holds coordination or planning meetings.. Valid values are `daily|weekly|biweekly|monthly|as_needed|none`',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context about the teams operations, challenges, achievements, or special considerations.',
    `operational_hours` DOUBLE COMMENT 'Textual description of the typical operational hours or shift schedule for the team (e.g., 08:00-17:00 Mon-Fri, 24/7 rotation, Event-based).',
    `performance_rating` STRING COMMENT 'Overall performance assessment or rating of the team based on Monitoring Evaluation and Learning (MEL) criteria, service delivery quality, and beneficiary feedback.. Valid values are `excellent|good|satisfactory|needs_improvement|not_rated`',
    `primary_language` STRING COMMENT 'The primary language used for communication and coordination within the team and with beneficiaries (e.g., English, French, Arabic, Swahili).',
    `recognition_awards_count` STRING COMMENT 'Total number of recognition awards, certificates, or commendations received by the team for outstanding service.',
    `required_certifications` STRING COMMENT 'Comma-separated list of certifications or training modules required for team membership (e.g., First Aid, SPHERE Standards, Protection Principles, PSS Basics).',
    `safety_incidents_count` STRING COMMENT 'Total number of safety or security incidents involving team members during operations.',
    `target_member_count` STRING COMMENT 'The planned or target number of volunteers intended to be part of this team for optimal operational capacity.',
    `team_code` STRING COMMENT 'Short alphanumeric code or identifier used for quick reference and operational communication (e.g., CHW-D5, EDT-ALPHA, PSS-RCB).',
    `team_name` STRING COMMENT 'The official name or designation of the volunteer team (e.g., Community Health Worker Group - District 5, Emergency Distribution Team Alpha, PSS Support Group - Refugee Camp B).',
    `team_type` STRING COMMENT 'Classification of the volunteer team based on its primary function and operational focus. PSS refers to Psychosocial Support, WASH refers to Water Sanitation and Hygiene. [ENUM-REF-CANDIDATE: community_health_worker_group|distribution_team|pss_support_group|event_crew|wash_team|nutrition_outreach_team|education_support_team|protection_response_team|logistics_support_team|other — 10 candidates stripped; promote to reference product]',
    `total_volunteer_hours` DECIMAL(18,2) COMMENT 'Cumulative total of volunteer hours contributed by all team members since team formation.',
    `training_completion_required` BOOLEAN COMMENT 'Indicates whether all team members are required to complete specific training or certification before joining the team.',
    `volunteer_team_status` STRING COMMENT 'Current operational status of the volunteer team in its lifecycle.. Valid values are `active|inactive|suspended|disbanded|on_hold|forming`',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this team record.',
    CONSTRAINT pk_volunteer_team PRIMARY KEY(`volunteer_team_id`)
) COMMENT 'Volunteer Team - core entity in the volunteer domain supporting humanitarian operations. [SSOT: dependent alias of canonical field.field_team; defer to canonical for shared attributes and link via field_team_id.]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_application_id` FOREIGN KEY (`application_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`application`(`application_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ADD CONSTRAINT `fk_volunteer_deployment_volunteer_team_id` FOREIGN KEY (`volunteer_team_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_team`(`volunteer_team_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_deployment_id` FOREIGN KEY (`deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`deployment`(`deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_volunteer_team_id` FOREIGN KEY (`volunteer_team_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_team`(`volunteer_team_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`training`(`training_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_training_enrollment_id` FOREIGN KEY (`training_enrollment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`training_enrollment`(`training_enrollment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`training`(`training_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`volunteer` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`volunteer` SET TAGS ('dbx_domain' = 'volunteer');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` SET TAGS ('dbx_subdomain' = 'volunteer_management');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Identifier');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Country Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `country_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_'pii_address'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_'pii_staff']' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_'pii_address'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_'pii_staff']' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `availability_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Availability Hours Per Week');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `availability_hours_per_week` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Availability Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|on assignment|on leave|inactive');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `availability_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `background_check_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not required|pending|in progress|cleared|flagged|expired');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `background_check_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `certifications` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Certifications');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `certifications` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Volunteer City');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `city` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Date of Birth');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_dob'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_standard_reference' = 'UNHCR registration standards; Sphere beneficiary data minimum');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Email Address');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_'pii_email'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Emergency Contact Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_'pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Emergency Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_'pii_phone'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Emergency Contact Relationship');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `external_volunteer_code` SET TAGS ('dbx_business_glossary_term' = 'External Volunteer Identifier');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `external_volunteer_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `external_volunteer_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `external_volunteer_code` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer First Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_volunteer_date` SET TAGS ('dbx_business_glossary_term' = 'First Volunteer Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_volunteer_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Gender');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|prefer not to say|other');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_'pii'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_'pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `geographic_base` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Geographic Base');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `geographic_base` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `geographic_base` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Last Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_volunteer_date` SET TAGS ('dbx_business_glossary_term' = 'Last Volunteer Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_volunteer_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Middle Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Mobile Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_classification' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Nationality');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Onboarding Completion Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Onboarding Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'pending|in progress|completed|expired|inactive');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Phone Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_'pii_phone'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_'reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_'pii_staff'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_'pii_classification' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_'lookup_review' = 'no_target]');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Postal Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Preferred Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'pii_staff']' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Primary Language');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `primary_language` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `primary_language` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Recognition Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `recognition_level` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|lifetime');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `recognition_level` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `skills` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Skills');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `skills` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Volunteer State or Province');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `state_province` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `total_volunteer_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Volunteer Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `total_volunteer_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `volunteer_type` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `volunteer_type` SET TAGS ('dbx_value_regex' = 'community health worker|field volunteer|event-based supporter|skilled professional|youth volunteer|corporate volunteer');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `volunteer_type` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `willing_to_travel` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Willing to Travel');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `willing_to_travel` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` SET TAGS ('dbx_subdomain' = 'volunteer_management');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Application ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `country_office_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `role_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^VA-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_completed_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_outcome` SET TAGS ('dbx_business_glossary_term' = 'Background Check Outcome');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_outcome` SET TAGS ('dbx_value_regex' = 'cleared|conditional|not_cleared');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_outcome` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_required` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|cleared|failed|expired');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `code_of_conduct_signed` SET TAGS ('dbx_business_glossary_term' = 'Code of Conduct Signed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `code_of_conduct_signed` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `commitment_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Commitment Duration (Months)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `commitment_duration_months` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_made_by` SET TAGS ('dbx_business_glossary_term' = 'Decision Made By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_made_by` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_made_by` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Decision Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|waitlisted');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `emergency_contact_provided` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Provided');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `emergency_contact_provided` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `emergency_contact_provided` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Hours Per Week');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `hours_per_week` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_completed_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_notes` SET TAGS ('dbx_business_glossary_term' = 'Interview Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_notes` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_outcome` SET TAGS ('dbx_business_glossary_term' = 'Interview Outcome');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_outcome` SET TAGS ('dbx_value_regex' = 'recommended|not_recommended|conditional');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_outcome` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_required` SET TAGS ('dbx_business_glossary_term' = 'Interview Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_required` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Scheduled Date and Time');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_scheduled_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `motivation_statement` SET TAGS ('dbx_business_glossary_term' = 'Motivation Statement');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `motivation_statement` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_completed_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_start_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_start_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|incomplete');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `orientation_completed` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `orientation_completed` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `preferred_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preferred Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `preferred_start_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `previous_volunteer_experience` SET TAGS ('dbx_business_glossary_term' = 'Previous Volunteer Experience');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `previous_volunteer_experience` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Channel');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_value_regex' = 'website|social_media|referral|event|partner_organization|direct_outreach');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `reference_check_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Reference Check Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `reference_check_completed_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_business_glossary_term' = 'Reference Check Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|satisfactory|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `safeguarding_policy_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Policy Acknowledged');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `safeguarding_policy_acknowledged` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `screening_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `screening_completed_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|cleared|flagged');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `screening_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `skills_offered` SET TAGS ('dbx_business_glossary_term' = 'Skills Offered');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `skills_offered` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `training_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Completed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `training_completed` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` SET TAGS ('dbx_subdomain' = 'volunteer_management');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `background_check_required` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_code` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `deployment_context` SET TAGS ('dbx_business_glossary_term' = 'Deployment Context');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `deployment_context` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_description` SET TAGS ('dbx_business_glossary_term' = 'Role Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_description` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `estimated_time_commitment_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time Commitment Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `estimated_time_commitment_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `functional_area` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `insurance_coverage_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `insurance_coverage_required` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `insurance_coverage_required` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `language_requirements` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `language_requirements` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `maximum_concurrent_assignments` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Assignments');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `maximum_concurrent_assignments` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `physical_demands` SET TAGS ('dbx_business_glossary_term' = 'Physical Demands');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `physical_demands` SET TAGS ('dbx_value_regex' = 'None|Light|Moderate|Heavy|Extreme');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `physical_demands` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `preferred_skills` SET TAGS ('dbx_business_glossary_term' = 'Preferred Skills');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `preferred_skills` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `recognition_program_eligible` SET TAGS ('dbx_business_glossary_term' = 'Recognition Program Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `recognition_program_eligible` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `required_skills` SET TAGS ('dbx_business_glossary_term' = 'Required Skills');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `required_skills` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `risk_level` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Under Review|Archived');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'Field|Office|Remote|Hybrid|Event-Based|Ongoing');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_type` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `safeguarding_training_required` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Training Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `safeguarding_training_required` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_amount` SET TAGS ('dbx_business_glossary_term' = 'Stipend Amount');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_amount` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_eligible` SET TAGS ('dbx_business_glossary_term' = 'Stipend Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_eligible` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `supervision_level` SET TAGS ('dbx_business_glossary_term' = 'Supervision Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `supervision_level` SET TAGS ('dbx_value_regex' = 'Independent|Minimal|Moderate|Close|Intensive');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `supervision_level` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `time_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Time Commitment Unit');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `time_commitment_unit` SET TAGS ('dbx_value_regex' = 'Per Week|Per Month|Per Assignment|Per Event|Total');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `time_commitment_unit` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `title` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `travel_required` SET TAGS ('dbx_business_glossary_term' = 'Travel Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `travel_required` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `typical_assignment_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Typical Assignment Duration Days');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `typical_assignment_duration_days` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `created_by` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `created_by` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` SET TAGS ('dbx_subdomain' = 'volunteer_management');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Deployment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `award_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment Country Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `role_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `volunteer_team_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `volunteer_team_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_business_glossary_term' = 'Deployment Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_value_regex' = '^VD-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'active|completed|withdrawn|suspended|pending|cancelled');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_type` SET TAGS ('dbx_business_glossary_term' = 'Deployment Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_type` SET TAGS ('dbx_value_regex' = 'emergency_response|development_program|event_support|capacity_building|advocacy_campaign|disaster_relief');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `deployment_type` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `end_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `fte_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Contribution');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `fte_equivalent` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `hours_contributed` SET TAGS ('dbx_business_glossary_term' = 'Hours Contributed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `hours_contributed` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Deployment Location Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `location_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `modified_by` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `modified_by` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `orientation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `orientation_completed_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `orientation_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `orientation_completed_flag` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Deployment Priority');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical|emergency');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `priority` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `recognition_awarded_flag` SET TAGS ('dbx_business_glossary_term' = 'Recognition Awarded Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `recognition_awarded_flag` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Deployment Region');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `region` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `remote_deployment_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Deployment Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `remote_deployment_flag` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Deployment Role');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `role` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|enhanced|critical');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `special_conditions` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `start_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `volunteer_deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `volunteer_deployment_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `created_by` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`deployment` ALTER COLUMN `created_by` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` SET TAGS ('dbx_subdomain' = 'volunteer_management');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `hour_log_id` SET TAGS ('dbx_business_glossary_term' = 'Hour Log ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `award_budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `budget_plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Line Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `component_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Deployment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `indicator_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `role_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `volunteer_team_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `activity_description` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'direct_service|administrative_support|fundraising_event|training_facilitation|community_outreach|monitoring_evaluation');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `activity_type` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review|auto_approved');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `approval_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `device_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `device_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `device_code` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `donor_report_eligible` SET TAGS ('dbx_business_glossary_term' = 'Donor Report Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `donor_report_eligible` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `end_time` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `fair_market_value_rate` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Rate');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `fair_market_value_rate` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `hours_claimed` SET TAGS ('dbx_business_glossary_term' = 'Hours Claimed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `hours_claimed` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `hours_verified` SET TAGS ('dbx_business_glossary_term' = 'Hours Verified');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `hours_verified` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `in_kind_value` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Value');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `in_kind_value` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `is_group_activity` SET TAGS ('dbx_business_glossary_term' = 'Is Group Activity');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `is_group_activity` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `is_overtime` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `is_virtual` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `location_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `log_date` SET TAGS ('dbx_business_glossary_term' = 'Log Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `log_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `recognition_milestone_triggered` SET TAGS ('dbx_business_glossary_term' = 'Recognition Milestone Triggered');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `recognition_milestone_triggered` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `start_time` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'mobile_app|web_portal|paper_form|sms|email|kiosk');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `submission_method` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'supervisor_signoff|digital_checkin|gps_verification|self_reported|biometric_scan|event_roster');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `capacity_building_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `commodity_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'written_exam|practical_demonstration|project_submission|peer_review|no_assessment');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `assessment_method` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `available_languages` SET TAGS ('dbx_business_glossary_term' = 'Available Languages');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `available_languages` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `available_languages` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'safety_and_security|technical_skills|chs_orientation|sphere_standards|gbv_awareness|psea');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `certification_awarded` SET TAGS ('dbx_business_glossary_term' = 'Certification Awarded');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `certification_awarded` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `certification_validity_months` SET TAGS ('dbx_business_glossary_term' = 'Certification Validity in Months');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `certification_validity_months` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `chs_standard_alignment` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Alignment');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `chs_standard_alignment` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_code` SET TAGS ('dbx_business_glossary_term' = 'Training Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_code` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost per Participant');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'in_person|e_learning|blended|virtual_instructor_led|self_paced');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_description` SET TAGS ('dbx_business_glossary_term' = 'Training Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_description` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `duration_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_['pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_'pii_staff']' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Training');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Training Language');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `language` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `language` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `last_review_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `materials_url` SET TAGS ('dbx_business_glossary_term' = 'Training Materials URL');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `materials_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `materials_url` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `max_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `max_participants` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `modified_by` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `modified_by` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `next_review_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `prerequisites` SET TAGS ('dbx_business_glossary_term' = 'Training Prerequisites');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `prerequisites` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_standard_reference' = 'UN Sustainable Development Goals indicator framework (A/RES/71/313)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `sphere_standard_alignment` SET TAGS ('dbx_business_glossary_term' = 'SPHERE Standard Alignment');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `sphere_standard_alignment` SET TAGS ('dbx_standard_reference' = 'Sphere Handbook 2018 minimum standards');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `target_audience` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Training Title');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `title` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|under_review');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Training Version');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `version` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `created_by` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `created_by` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `assessment_attempts` SET TAGS ('dbx_business_glossary_term' = 'Assessment Attempts');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `assessment_attempts` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `compliance_training_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `compliance_training_category` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credits');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_cost` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cost');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_cost` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'self_enrolled|manager_assigned|program_required|hr_assigned|system_triggered');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'registered|in_progress|completed|failed|withdrawn|cancelled');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `feedback_rating` SET TAGS ('dbx_business_glossary_term' = 'Feedback Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `feedback_rating` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `mandatory_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `mandatory_training_flag` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Mode');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_delivery_mode` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|self_paced|webinar|workshop');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_delivery_mode` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_language` SET TAGS ('dbx_business_glossary_term' = 'Training Language');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_language` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_language` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_start_date` SET TAGS ('dbx_business_glossary_term' = 'Training Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_start_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Training Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_withdrawal_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `assessment_passing_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Passing Score');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `assessment_passing_score` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'professional_license|certificate|training_completion|self_assessed|verified_competency|compliance_certificate');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `compliance_category` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `continuing_education_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `continuing_education_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `cost_currency` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `country_of_issue` SET TAGS ('dbx_business_glossary_term' = 'Country of Issue');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `country_of_issue` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `deployment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Deployment Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `deployment_eligible` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `language_of_certification` SET TAGS ('dbx_business_glossary_term' = 'Language of Certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `language_of_certification` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `language_of_certification` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `mandatory_for_role` SET TAGS ('dbx_business_glossary_term' = 'Mandatory for Role');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `mandatory_for_role` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_['pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_'pii_staff']' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|expert|master');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `recognized_by_organization` SET TAGS ('dbx_business_glossary_term' = 'Recognized by Organization');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `recognized_by_organization` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `reimbursed_by_organization` SET TAGS ('dbx_business_glossary_term' = 'Reimbursed by Organization');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `reimbursed_by_organization` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_category` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_business_glossary_term' = 'Skill Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_['pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_'pii_staff']' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|self_reported|expired|revoked|not_verified');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` SET TAGS ('dbx_subdomain' = 'volunteer_management');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Team ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `country_office_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `field_team_id` SET TAGS ('dbx_ssot_canonical_ref' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `field_team_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Team Lead Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `beneficiaries_served_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiaries Served Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `beneficiaries_served_count` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Communication Channel');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `communication_channel` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `current_member_count` SET TAGS ('dbx_business_glossary_term' = 'Current Member Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `current_member_count` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Team Dissolution Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `equipment_assigned` SET TAGS ('dbx_business_glossary_term' = 'Equipment Assigned');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `equipment_assigned` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Team Formation Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `formation_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area of Operation');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `geographic_area` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `geographic_area` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_sensitivity' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|as_needed|none');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Team Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `operational_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Team Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|not_rated');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `primary_language` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `primary_language` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `recognition_awards_count` SET TAGS ('dbx_business_glossary_term' = 'Recognition Awards Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `recognition_awards_count` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `required_certifications` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `safety_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incidents Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `safety_incidents_count` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `target_member_count` SET TAGS ('dbx_business_glossary_term' = 'Target Member Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `target_member_count` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_code` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_name` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_name` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `team_type` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `total_volunteer_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Volunteer Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `total_volunteer_hours` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `training_completion_required` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `training_completion_required` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_status` SET TAGS ('dbx_business_glossary_term' = 'Team Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|disbanded|on_hold|forming');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_status` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `created_by` SET TAGS ('dbx_standard_reference' = 'ILO Manual on the Measurement of Volunteer Work; UNV conditions of service; IATI participating-org (accountable/implementing)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `created_by` SET TAGS ('dbx_sensitivity' = 'pii_staff');
