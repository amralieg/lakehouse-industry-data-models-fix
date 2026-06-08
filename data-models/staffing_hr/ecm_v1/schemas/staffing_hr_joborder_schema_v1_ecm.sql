-- Schema for Domain: joborder | Business: Staffing Hr | Version: v1_ecm
-- Generated on: 2026-05-02 15:53:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `staffing_hr_ecm`.`joborder` COMMENT 'SSOT for all client requisitions (reqs) and job order demand data. Owns job order headers, position requirements, skill specifications, headcount targets, duration, bill rates, pay rates, markup percentages, SLA commitments, TTF and TTS targets, and fulfillment status lifecycle. Tracks the complete job order lifecycle from intake through closure including extensions, modifications, and cancellations. Central operational hub connecting client demand to candidate supply.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`order_header` (
    `order_header_id` BIGINT COMMENT 'Primary key for order_header',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Job orders must be associated with accounting periods for revenue recognition timing, period close processes, financial reporting compliance, and revenue cutoff determination—fundamental to accrual ac',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that originated this requisition. Links the job order to the client master record in the client domain. Supports client-level demand aggregation and SLA tracking.',
    `client_contact_id` BIGINT COMMENT 'Reference to the specific client contact (hiring manager or procurement contact) who submitted or owns this requisition. Used for communication routing and accountability tracking.',
    `location_id` BIGINT COMMENT 'Reference to the specific client work site or office location where the placed worker will report. Drives workers compensation classification, tax jurisdiction, and scheduling.',
    `client_rate_card_id` BIGINT COMMENT 'Reference to the negotiated rate card governing bill rate and pay rate ranges for this requisition. Ensures pricing compliance with client MSA terms.',
    `contract_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_schedule. Business justification: Job orders inherit bill/pay rates from contracted rate schedules. Linking enables automated rate validation, prevents off-contract pricing, supports rate variance analysis, and ensures every requisiti',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Job orders must track cost center for client billing allocation, internal P&L reporting by service line, and budget consumption tracking—fundamental to staffing operations financial management and pro',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Job orders generate revenue and must map to GL accounts for revenue recognition, financial statement preparation, and audit trail—core financial control ensuring proper revenue classification by servi',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement governing the commercial terms for this requisition. Links to the DocuSign CLM contract record. Ensures billing and compliance terms are applied correctly.',
    `preferred_supplier_list_id` BIGINT COMMENT 'Foreign key linking to vendor.preferred_supplier_list. Business justification: Orders may be restricted to preferred supplier lists by client program. Order routing eligibility, supplier access control, and PSL compliance enforcement require direct PSL reference.',
    `rate_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.rate_agreement. Business justification: Job orders are priced under specific rate agreements with suppliers. Rate validation, markup enforcement, contract compliance auditing, and invoice reconciliation require direct link to governing rate',
    `sow_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.sow_agreement. Business justification: SOW-based orders reference specific statements of work for scope, deliverables, and pricing. SOW compliance tracking, milestone management, and project-based billing require direct SOW link. Removes d',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Job orders are awarded to/fulfilled by specific suppliers. Supplier assignment drives submittal routing, performance tracking, and invoice reconciliation. Core staffing workflow requires knowing which',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS program through which this requisition was received, when applicable. Links to the Beeline VMS program configuration for rate card and supplier management rules.',
    `assignment_end_date` DATE COMMENT 'The anticipated or confirmed end date of the temporary assignment or contract engagement. Drives redeployment planning, bench management, and extension workflow triggers.',
    `bgc_required` BOOLEAN COMMENT 'Indicates whether a background check (BGC) is required for candidates on this requisition. Triggers the Sterling Background Check credentialing workflow. Governed by FCRA adverse action requirements.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate charged to the client for each worker placed on this requisition. Expressed in USD per hour for temporary and contract engagements. Core component of gross margin and spread calculations. MONETARY_TRIPLET component for TRANSACTION_HEADER role.',
    `clearance_required` STRING COMMENT 'Security clearance level required for the position. Critical for government and defense staffing engagements. Drives candidate eligibility screening and credentialing requirements.. Valid values are `none|public_trust|secret|top_secret|ts_sci`',
    `conversion_fee` DECIMAL(18,2) COMMENT 'The fee charged to the client upon permanent conversion of a temp-to-perm worker. May be expressed as a flat dollar amount or percentage of first-year salary. Applicable only when is_temp_to_perm is true.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this job order header record was first created in the system. Serves as the RECORD_AUDIT_CREATED category for the TRANSACTION_HEADER role. Used for data lineage, audit trails, and SLA baseline calculations.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary rate fields on this requisition (bill_rate, pay_rate, etc.). Supports multi-currency operations for international staffing engagements. MONETARY_TRIPLET currency component.. Valid values are `^[A-Z]{3}$`',
    `drug_screen_required` BOOLEAN COMMENT 'Indicates whether a pre-placement drug screening is required for candidates on this requisition. Triggers the credentialing workflow in Sterling Background Check upon placement.',
    `education_requirement` STRING COMMENT 'Minimum educational qualification required for candidates on this requisition. Used in candidate screening and EEOC-compliant job requirement documentation. [ENUM-REF-CANDIDATE: none|high_school|associate|bachelor|master|doctorate|professional_cert — promote to reference product]',
    `employment_classification` STRING COMMENT 'Worker tax and employment classification for this requisition. W-2 = employee on staffing firm payroll; 1099 = independent contractor; C2C = corp-to-corp engagement. Drives payroll processing, tax withholding, and co-employment risk assessment.. Valid values are `w2|1099|c2c`',
    `headcount_filled` STRING COMMENT 'Current count of positions on this requisition that have been successfully filled with an active placement. Derived operationally from placement records but stored here for fast reporting and SLA dashboards.',
    `headcount_remaining` STRING COMMENT 'Number of unfilled positions remaining on this requisition (headcount_target minus headcount_filled). Drives active recruiting prioritization and capacity planning.',
    `headcount_target` STRING COMMENT 'Total number of positions authorized by the client for this requisition. Represents the maximum number of workers that can be placed against this job order. Used for demand planning and fulfillment tracking.',
    `hours_per_week` DECIMAL(18,2) COMMENT 'Expected number of hours per week for the position. Used to determine full-time equivalent (FTE) classification, ACA benefits eligibility thresholds, and total assignment cost projections.',
    `intake_date` DATE COMMENT 'The date the requisition was formally received and entered into the ATS/CRM. Serves as the start point for Time to Fill (TTF) and Time to Start (TTS) SLA calculations. BUSINESS_EVENT_TIMESTAMP category for TRANSACTION_HEADER role.',
    `is_backfill` BOOLEAN COMMENT 'Indicates whether this requisition is a backfill for a previously vacated position rather than a new headcount addition. Backfill reqs typically have faster fill expectations and known role profiles.',
    `is_temp_to_perm` BOOLEAN COMMENT 'Indicates whether this requisition has a contractual temp-to-perm (contract-to-hire) conversion option. When true, a conversion fee schedule applies upon permanent hire. Drives conversion tracking and fee billing.',
    `job_description` STRING COMMENT 'Full narrative description of the position including responsibilities, qualifications, and working conditions as provided by the client. Source content for ATS job postings and candidate screening.',
    `job_title` STRING COMMENT 'The client-specified job title for the open position. Used in candidate matching, submittal communications, and workforce analytics. May differ from the internal job category classification.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied over the pay rate to derive the bill rate, expressed as a decimal (e.g., 0.45 = 45%). Encapsulates burden, overhead, and profit margin. Used for pricing analysis and client negotiations.',
    `min_experience_years` STRING COMMENT 'Minimum number of years of relevant work experience required for candidates to be considered for this position. Used in ATS candidate screening and quality of submission (QoS) scoring.',
    `order_status` STRING COMMENT 'Current lifecycle state of the job order requisition. Drives recruiter workflow, reporting dashboards, and SLA tracking. LIFECYCLE_STATUS category for TRANSACTION_HEADER role. Values: open (actively recruiting), filled (all headcount placed), on_hold (client-paused), cancelled (client-withdrawn), closed (administratively closed).. Valid values are `open|filled|on_hold|cancelled|closed`',
    `originating_source` STRING COMMENT 'The channel or system through which this requisition was received. Tracks demand intake source for channel analytics and process efficiency measurement. VMS = Beeline or similar; CRM = Salesforce/Bullhorn direct; Direct = client phone/email; Portal = self-service client portal.. Valid values are `vms|crm|direct|ats|email|portal`',
    `ot_bill_rate` DECIMAL(18,2) COMMENT 'The hourly bill rate charged to the client for overtime hours worked by placed workers on this requisition. Typically 1.5x the regular bill rate per FLSA requirements. Required for accurate client invoicing.',
    `ot_pay_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate for overtime hours paid to workers placed on this requisition. Must comply with FLSA 1.5x overtime rule for non-exempt workers. Drives payroll cost calculations.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate paid to the worker placed on this requisition. Expressed in USD per hour. Used to calculate spread (bill rate minus pay rate) and gross margin. Must comply with FLSA minimum wage and applicable prevailing wage requirements.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily allowance paid to the worker for travel, lodging, or meals when the assignment requires relocation or travel. Expressed in currency per day. Applicable for travel-intensive or remote assignments.',
    `position_type` STRING COMMENT 'Classification of the engagement model for this requisition. Determines billing structure, conversion fee applicability, and compliance requirements. Temp = temporary staffing; Contract-to-Hire = temp with conversion option; Direct Placement = permanent placement; SOW = Statement of Work project-based engagement.. Valid values are `temporary|contract_to_hire|direct_placement|sow`',
    `priority_level` STRING COMMENT 'Recruiter-assigned or client-designated urgency level for this requisition. Drives work queue prioritization and resource allocation. Critical = immediate fill required; High = fill within SLA; Medium = standard; Low = backfill or pipeline.. Valid values are `critical|high|medium|low`',
    `req_number` STRING COMMENT 'Externally-known, human-readable requisition number assigned at intake. Used by clients, recruiters, and VMS systems to reference the job order. Corresponds to the Bullhorn Job Order external ID or VMS requisition number. BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.. Valid values are `^REQ-[0-9]{6,10}$`',
    `shift_type` STRING COMMENT 'The work shift schedule required for this position. Drives candidate availability matching, differential pay calculations, and scheduling in Kronos Workforce Ready.. Valid values are `day|evening|night|rotating|flexible`',
    `target_start_date` DATE COMMENT 'The client-requested date by which the placed worker should begin the assignment. Used to calculate Time to Start (TTS) SLA performance and to prioritize recruiter activity.',
    `ttf_target_days` STRING COMMENT 'The SLA-committed number of calendar days from intake to first qualified submittal or fill, as agreed with the client. Used to measure recruiter and program performance against TTF KPI benchmarks.',
    `tts_target_days` STRING COMMENT 'The SLA-committed number of calendar days from requisition intake to worker start date. Distinct from TTF; measures the full cycle from demand signal to worker on-site.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this job order header record was last modified. Serves as the RECORD_AUDIT_UPDATED category for the TRANSACTION_HEADER role. Used for change detection, incremental ETL processing, and audit compliance.',
    `vms_req_number` STRING COMMENT 'The requisition number assigned by the clients VMS platform (e.g., Beeline). Distinct from the internal req_number; used for cross-system reconciliation and supplier portal submissions.',
    `work_location_type` STRING COMMENT 'Specifies whether the position requires the worker to be physically on-site, fully remote, or a hybrid arrangement. Impacts candidate sourcing geography, per diem eligibility, and tax nexus determination.. Valid values are `onsite|remote|hybrid`',
    CONSTRAINT pk_order_header PRIMARY KEY(`order_header_id`)
) COMMENT 'Core master entity representing a client requisition (req) — the authoritative job order header record and central hub of the joborder domain. Captures the full lifecycle of a client demand request from intake through closure. Stores requisition number, job title, position type (temp, contract-to-hire, direct placement, SOW), employment classification (W-2, 1099, C2C), headcount target (total positions authorized, positions filled, positions remaining), backfill indicator, priority level, order status (open, filled, cancelled, on-hold, closed), intake date, target start date, assignment end date, and originating source (VMS, CRM, direct). Central hub connecting client demand to candidate supply in the ATS/CRM. All other joborder products reference this entity via req_id.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` (
    `position_requirement_id` BIGINT COMMENT 'Unique surrogate identifier for the position requirement record. Primary key for this entity in the Silver Layer lakehouse. Entity role: MASTER_RESOURCE — represents a structured demand profile (position specification) attached to a job order requisition.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Position requirements often specify client cost center for budget authorization and departmental charge-back, enabling budget validation before submittal and accurate client billing allocation in ente',
    `order_header_id` BIGINT COMMENT 'Reference to the parent job order requisition that this position requirement is attached to. Links the position specification back to the demand record in the Job Order domain.',
    `bgc_required` BOOLEAN COMMENT 'Indicates whether a background check (BGC) is required for candidates submitting to this position. Drives the credentialing workflow in Sterling Background Check and compliance tracking.',
    `bgc_type` STRING COMMENT 'Specifies the type(s) of background check required (e.g., criminal, employment verification, education verification, credit, motor vehicle record). Drives the BGC package selection in Sterling Background Check. [ENUM-REF-CANDIDATE: criminal|employment_verification|education_verification|credit|motor_vehicle|sex_offender_registry|federal — promote to reference product]',
    `bill_rate` DECIMAL(18,2) COMMENT 'The agreed-upon hourly or periodic rate charged to the client for this position. Used in revenue recognition, spread calculation (Bill Rate minus Pay Rate), and gross margin analysis. Sourced from Bullhorn Job Order or Beeline VMS rate card.',
    `certifications_required` STRING COMMENT 'Comma-delimited list of mandatory professional certifications or licenses required for the position (e.g., PMP, RN, CPA, CDL). Drives the credentialing verification workflow and readiness status checks.',
    `client_screening_criteria` STRING COMMENT 'Free-text field capturing any client-specific screening requirements beyond standard criteria (e.g., proprietary assessments, client interviews, specific onboarding steps, NDA requirements). Sourced from client MSA or VMS program requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position requirement record was first created in the system. Used for audit trail, TTF calculation baseline, and data lineage tracking. Aligns with SOC 2 Type II audit requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary rate fields on this position requirement (pay_rate_min, pay_rate_max, bill_rate). Supports multi-currency international staffing operations.. Valid values are `^[A-Z]{3}$`',
    `drug_screen_panel` STRING COMMENT 'Specifies the drug screening panel type required for this position (e.g., 5-panel, 10-panel, 12-panel, hair follicle, oral fluid). Drives the specific test order in Sterling Background Check.. Valid values are `5_panel|10_panel|12_panel|hair_follicle|oral_fluid`',
    `drug_screen_required` BOOLEAN COMMENT 'Indicates whether a pre-placement drug screen is required for this position. Triggers the drug screening workflow in Sterling Background Check and credentialing readiness tracking.',
    `education_field_of_study` STRING COMMENT 'Specific academic discipline or field of study required or preferred for the position (e.g., Computer Science, Nursing, Accounting). Complements education_level for precise candidate qualification.',
    `education_level` STRING COMMENT 'Minimum educational attainment required for the position. Used as a screening criterion in candidate qualification. Values align with standard U.S. education levels: none, high_school, associate, bachelor, master, doctorate, professional_cert. [ENUM-REF-CANDIDATE: none|high_school|associate|bachelor|master|doctorate|professional_cert — 7 candidates stripped; promote to reference product]',
    `employment_type` STRING COMMENT 'Classification of the engagement type for this position. Drives billing model, pay structure, and compliance requirements. Values: contract (temporary staffing), temp_to_perm (Temp-to-Perm conversion eligible), direct_hire (Direct Placement/FTE), contract_to_hire (Contract-to-Hire), per_diem (Per Diem assignment), sow (Statement of Work engagement).. Valid values are `contract|temp_to_perm|direct_hire|contract_to_hire|per_diem|sow`',
    `end_date` DATE COMMENT 'Expected or confirmed end date for the position assignment. Drives assignment duration tracking, extension planning, redeployment workflows, and bench management. Nullable for permanent/direct hire positions.',
    `everify_required` BOOLEAN COMMENT 'Indicates whether E-Verify employment eligibility verification is required for this position. Mandatory for federal contractors and certain state-regulated engagements.',
    `headcount` STRING COMMENT 'Number of open positions (headcount) to be filled for this position requirement. Drives sourcing volume targets, TTF SLA tracking, and workforce planning analytics.',
    `hours_per_week` DECIMAL(18,2) COMMENT 'Expected number of hours per week for the position. Used to determine full-time equivalent (FTE) status, overtime eligibility under FLSA, and bill/pay rate calculations.',
    `job_category` STRING COMMENT 'Broad occupational category classifying the position (e.g., Information Technology, Healthcare, Finance, Engineering, Administrative). Used for workforce analytics, reporting, and candidate pool segmentation. [ENUM-REF-CANDIDATE: Information Technology|Healthcare|Finance|Engineering|Administrative|Manufacturing|Legal|Creative|Sales|Operations — promote to reference product]',
    `job_description` STRING COMMENT 'Full narrative job description including responsibilities, duties, and role overview as provided by the client. Used for candidate matching, job postings, and submittal qualification. Sourced from Bullhorn Job Order description field.',
    `job_title` STRING COMMENT 'The official job title for the open position as specified by the client. Used in candidate matching, submittal qualification, and job postings. Sourced from the Bullhorn Job Order title field.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position requirement record was last updated. Used for change tracking, SLA monitoring, and incremental data pipeline processing in the Silver Layer.',
    `max_submittals` STRING COMMENT 'Maximum number of candidate submittals the client will accept for this position. Enforces quality of submission (QoS) discipline and prevents submittal flooding in VMS-managed programs.',
    `max_years_experience` STRING COMMENT 'Maximum number of years of relevant professional experience acceptable for the position. Used to prevent over-qualification mismatches and manage bill rate expectations.',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for the position. Used as a hard filter in candidate screening and submittal qualification.',
    `pay_rate_max` DECIMAL(18,2) COMMENT 'Maximum pay rate (per hour or per period) approved for this position. Defines the upper bound of the pay rate range. Used in candidate offer negotiations and gross margin planning.',
    `pay_rate_min` DECIMAL(18,2) COMMENT 'Minimum pay rate (per hour or per period) approved for this position. Defines the lower bound of the pay rate range used in candidate offer negotiations and spread/margin calculations.',
    `physical_demands` STRING COMMENT 'DOL physical exertion classification for the position. Used for workers compensation risk rating, OSHA compliance, and candidate physical qualification screening. Aligns with DOL Dictionary of Occupational Titles (DOT) physical demand levels.. Valid values are `sedentary|light|medium|heavy|very_heavy`',
    `position_req_number` STRING COMMENT 'Externally-known alphanumeric business identifier for this position requirement, used in client communications, VMS portals, and ATS workflows. May align with the clients internal requisition number or Beeline VMS position code.',
    `position_requirement_status` STRING COMMENT 'Current lifecycle state of the position requirement. Drives operational workflows: draft (intake in progress), open (actively sourcing), on_hold (client paused), filled (placement made), cancelled (client withdrew), closed (naturally ended), expired (TTF deadline passed without fill). [ENUM-REF-CANDIDATE: draft|open|on_hold|filled|cancelled|closed|expired — 7 candidates stripped; promote to reference product]',
    `preferred_skills` STRING COMMENT 'Comma-delimited or free-text list of desired but non-mandatory skills that enhance candidate suitability. Used for secondary ranking in candidate matching and quality of submission (QoS) scoring.',
    `priority_level` STRING COMMENT 'Business priority assigned to this position requirement, used to triage recruiter effort and sourcing resources. Critical positions receive immediate attention; low priority positions are worked as capacity allows.. Valid values are `critical|high|medium|low`',
    `rate_type` STRING COMMENT 'Specifies the billing and pay rate period for this position. Determines how bill_rate and pay_rate_min/max are interpreted in payroll and billing calculations.. Valid values are `hourly|daily|weekly|monthly|fixed`',
    `required_skills` STRING COMMENT 'Comma-delimited or free-text list of mandatory technical and functional skills required for the position. Used as primary filter criteria in ATS candidate matching and submittal qualification scoring (QoS).',
    `security_clearance_level` STRING COMMENT 'U.S. government security clearance level required for the position. Critical for federal staffing engagements and OFCCP compliance. Values: none, public_trust, confidential, secret, top_secret, TS/SCI (Top Secret/Sensitive Compartmented Information).. Valid values are `none|public_trust|confidential|secret|top_secret|ts_sci`',
    `shift_type` STRING COMMENT 'The work shift schedule required for the position. Drives scheduling, differential pay calculations, and candidate availability matching in Kronos Workforce Ready.. Valid values are `day|evening|night|rotating|flexible|on_call`',
    `start_date` DATE COMMENT 'Target or confirmed start date for the position. Used in Time to Start (TTS) SLA measurement, assignment scheduling, and onboarding planning.',
    `travel_requirement` STRING COMMENT 'Expected travel frequency for the position. Used in candidate screening and per diem/expense planning. Values represent percentage of time traveling: none, occasional, up to 25%, up to 50%, up to 75%, frequent (75%+).. Valid values are `none|occasional|up_to_25_pct|up_to_50_pct|up_to_75_pct|frequent`',
    `ttf_target_days` STRING COMMENT 'Client-agreed or internal SLA target for the number of calendar days to fill this position from requisition open date. Key KPI for recruiter performance and SLA compliance reporting.',
    `tts_target_days` STRING COMMENT 'Client-agreed or internal SLA target for the number of calendar days from candidate selection to worker start date. Distinct from TTF; measures onboarding and credentialing speed.',
    `work_city` STRING COMMENT 'City where the position is physically located or where the worker is expected to report. Used for geographic candidate matching, tax jurisdiction determination, and workers compensation classification.',
    `work_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the position is located. Required for international staffing operations, GDPR applicability determination, and EOR arrangement identification.. Valid values are `^[A-Z]{3}$`',
    `work_location_type` STRING COMMENT 'Specifies whether the position requires the worker to be physically present at the client site (on_site), work fully remotely (remote), or a combination of both (hybrid). Drives candidate geographic filtering and sourcing strategy.. Valid values are `on_site|remote|hybrid`',
    `work_state` STRING COMMENT 'U.S. state (or equivalent jurisdiction) where the position is located. Critical for state-specific labor law compliance, SUTA tax assignment, workers compensation policy selection, and wage/hour determination.',
    `worker_classification` STRING COMMENT 'Tax and legal classification of the worker for this position. W-2 (employee on payroll), 1099 (Independent Contractor), Corp-to-Corp (IC through their own entity), or EOR (Employer of Record arrangement). Critical for IRS compliance and co-employment risk management.. Valid values are `w2|1099|corp_to_corp|eor`',
    CONSTRAINT pk_position_requirement PRIMARY KEY(`position_requirement_id`)
) COMMENT 'Defines the detailed position specifications attached to a requisition. Captures job description, required education level, years of experience, work location type (on-site, remote, hybrid), shift type, travel requirements, physical demands, security clearance level, drug screen requirement, background check requirement, and any client-specific screening criteria. Represents the structured demand profile that drives candidate matching and submittal qualification.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` (
    `skill_requirement_id` BIGINT COMMENT 'Unique identifier for the skill requirement record. Primary key for the skill requirement entity.',
    `order_header_id` BIGINT COMMENT 'Reference to the parent job order (requisition) that this skill requirement belongs to. Links the skill requirement to the specific client requisition.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user (recruiter, account manager, or system administrator) who created this skill requirement record. Used for audit trail and accountability.',
    `tertiary_skill_deactivated_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who deactivated this skill requirement. Null if the requirement is still active. Used for audit trail and accountability.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this skill requirement is currently active for the job order. True if active and used in candidate matching; False if deprecated or removed from requirements. Used for requirement lifecycle management.',
    `alternative_skill_names` STRING COMMENT 'Comma-separated list of synonyms or alternative names for this skill. Used to improve candidate search and matching. Examples: Java could include J2EE, Java EE, Jakarta EE.',
    `assessment_method` STRING COMMENT 'The primary method used to evaluate candidate proficiency in this skill. Resume review indicates screening from candidate documents; technical test indicates formal assessment; behavioral interview indicates structured questioning; practical demonstration indicates hands-on evaluation; certification verification indicates credential validation; reference check indicates third-party validation.. Valid values are `resume_review|technical_test|behavioral_interview|practical_demonstration|certification_verification|reference_check`',
    `certification_name` STRING COMMENT 'The name of the specific certification or credential required if certification_required_flag is True. Examples include PMP, CPA, RN, AWS Certified Solutions Architect, or Certified Welder. Null if no certification is required.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether a formal certification or credential is required for this skill. True if certification is mandatory; False if experience alone is sufficient. Used for credentialing and compliance verification.',
    `client_specific_terminology` STRING COMMENT 'Client-specific name or terminology for this skill if different from the standard skill_name. Used to align with client vocabulary in submittals and communications. Null if client uses standard terminology.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this skill requirement record was first created in the system. Used for audit trail and requirement lifecycle tracking.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'The date and time when this skill requirement was deactivated or removed from the job order. Null if the requirement is still active. Used for requirement lifecycle analysis.',
    `deactivation_reason` STRING COMMENT 'Free-text explanation of why this skill requirement was deactivated or removed from the job order. Examples include client request, requirement change, skill no longer needed, or job order modification. Null if still active.',
    `last_market_rate_survey_date` DATE COMMENT 'The date when market rate data for this skill was last surveyed or updated. Used to ensure pay rate and bill rate competitiveness. Null if no market survey has been conducted.',
    `market_demand_level` STRING COMMENT 'Assessment of current market demand for this skill. Low indicates abundant supply; moderate indicates balanced supply/demand; high indicates competitive market; critical indicates severe shortage. Used for sourcing strategy and rate negotiations.. Valid values are `low|moderate|high|critical`',
    `minimum_score_threshold` DECIMAL(18,2) COMMENT 'The minimum acceptable score (0-100 scale) a candidate must achieve for this skill to be considered qualified. Used in automated candidate screening and QoS evaluation.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this skill requirement record was last modified. Used for audit trail and change tracking.',
    `proficiency_level` STRING COMMENT 'The level of expertise or mastery required for this skill. Beginner indicates basic familiarity; intermediate indicates working knowledge; advanced indicates deep expertise; expert indicates subject matter expertise; master indicates industry-recognized authority.. Valid values are `beginner|intermediate|advanced|expert|master`',
    `requirement_type` STRING COMMENT 'Indicates whether the skill is mandatory (must-have for candidate consideration), preferred (strongly desired but not required), or nice-to-have (beneficial but not critical). Used for candidate screening and Quality of Submission (QoS) scoring.. Valid values are `mandatory|preferred|nice_to_have`',
    `skill_category` STRING COMMENT 'Classification of the skill type. Technical skills include programming languages and technical tools; soft skills include communication and leadership; industry-specific skills include domain knowledge; certifications include professional credentials; languages include spoken/written languages; tools and platforms include software applications. [ENUM-REF-CANDIDATE: technical|soft|industry_specific|certification|language|tool|platform — 7 candidates stripped; promote to reference product]',
    `skill_code` STRING COMMENT 'Standardized code or identifier for the skill from an external taxonomy or classification system. Examples include O*NET skill codes, SOC codes, or client-specific skill identifiers.',
    `skill_description` STRING COMMENT 'Detailed description of the skill requirement including specific technologies, methodologies, or competencies expected. Provides context for recruiters and candidates beyond the skill name.',
    `skill_name` STRING COMMENT 'The name of the skill, competency, or technology required for the job order. Examples include Java, Project Management, SAP, Nursing, Welding, or Communication Skills.',
    `skill_obsolescence_date` DATE COMMENT 'The date when this skill is expected to become obsolete or significantly less relevant. Used for workforce planning and skill gap analysis. Null if the skill has no known obsolescence timeline.',
    `skill_priority_rank` STRING COMMENT 'Numeric ranking indicating the relative importance of this skill within the job order. Lower numbers indicate higher priority. Used for weighted candidate matching and QoS scoring algorithms.',
    `skill_source_system` STRING COMMENT 'The name of the source system or taxonomy from which this skill requirement was derived. Examples include O*NET, client-provided skill list, internal skill taxonomy, or VMS skill catalog.',
    `skill_verification_required_flag` BOOLEAN COMMENT 'Indicates whether formal verification or validation of this skill is required before candidate submission or placement. True if verification is mandatory; False if self-reported skill is acceptable. Used for compliance and quality assurance.',
    `skill_weight_percentage` DECIMAL(18,2) COMMENT 'The percentage weight assigned to this skill in the overall candidate evaluation and QoS scoring. All skill weights for a job order should sum to 100. Used in ATS matching algorithms.',
    `training_available_flag` BOOLEAN COMMENT 'Indicates whether training or upskilling programs are available for candidates who do not fully meet this skill requirement. True if training is offered; False if candidates must possess the skill prior to placement.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'The estimated number of hours required to complete training for this skill if training_available_flag is True. Used for onboarding planning and Time to Start (TTS) calculations. Null if no training is available.',
    `years_of_experience_required` DECIMAL(18,2) COMMENT 'The minimum number of years of hands-on experience required for this specific skill. Used in candidate screening and QoS scoring. Supports fractional years (e.g., 2.5 years).',
    CONSTRAINT pk_skill_requirement PRIMARY KEY(`skill_requirement_id`)
) COMMENT 'Captures the individual skill, competency, and technology requirements associated with a requisition. Stores skill name, skill category (technical, soft, industry-specific), proficiency level required (beginner, intermediate, expert), whether the skill is mandatory or preferred, years of experience required for the skill, and certification requirement flag. Enables structured skill-based candidate matching and QoS (Quality of Submission) scoring within the ATS.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`rate_override` (
    `rate_override_id` BIGINT COMMENT 'Unique identifier for the rate override record. Primary key.',
    `contract_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_schedule. Business justification: Rate overrides deviate from contracted baseline rates. Linking the source schedule enables approval workflows (overrides exceeding contract terms require escalation), variance tracking for client bill',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Rate overrides impact revenue and margin, requiring GL account mapping for proper revenue classification, financial statement accuracy, and audit support—critical when overrides change revenue recogni',
    `order_header_id` BIGINT COMMENT 'Reference to the parent job order (requisition) for which this rate override applies.',
    `vendor_rate_card_id` BIGINT COMMENT 'External identifier of the VMS rate card from which this override was derived or against which it was validated. Links to Beeline or other VMS platform.',
    `approval_date` DATE COMMENT 'The date on which this rate override was formally approved by the authorized approver (internal management or client stakeholder).',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this rate override. May be internal manager, finance director, or client procurement contact.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate charged to the client for this job order. This is the revenue rate that appears on client invoices.',
    `burden_rate` DECIMAL(18,2) COMMENT 'The total burden cost per hour including payroll taxes (FICA, FUTA, SUTA), workers compensation insurance, benefits, and other statutory costs. Applied on top of pay rate.',
    `client_approval_date` DATE COMMENT 'The date on which the client formally approved this rate override. Nullable if client approval is not required or not yet received.',
    `client_approval_required` BOOLEAN COMMENT 'Indicates whether this rate override requires explicit client approval before activation. True if client sign-off is mandatory per MSA or VMS rules.',
    `client_approver_name` STRING COMMENT 'Name of the client contact who approved this rate override. Typically a procurement manager, hiring manager, or VMS program manager.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rate override record was first created in the system. Part of audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate override (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `dt_bill_rate` DECIMAL(18,2) COMMENT 'The hourly bill rate charged to the client for double-time hours (typically hours worked on holidays or beyond a certain threshold). Usually 2x the regular bill rate.',
    `dt_pay_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate paid to the worker for double-time hours. Typically 2x the regular pay rate, may be required by state law or client policy.',
    `effective_end_date` DATE COMMENT 'The date on which this rate override expires or is no longer applicable. Nullable for open-ended rate agreements.',
    `effective_start_date` DATE COMMENT 'The date from which this rate override becomes active and applicable to placements and billing. Part of the rate validity period.',
    `gross_margin_percentage` DECIMAL(18,2) COMMENT 'The gross margin as a percentage of the bill rate. Calculated as ((bill_rate - pay_rate) / bill_rate) * 100. Key profitability metric.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to the pay rate to calculate the bill rate. Calculated as ((bill_rate - pay_rate) / pay_rate) * 100.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rate override record was last modified. Updated whenever any field changes. Part of audit trail.',
    `msa_reference` STRING COMMENT 'Reference number or identifier of the Master Service Agreement that governs this rate override. Links to the contractual framework.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special conditions, or instructions related to this rate override. Used for internal communication and audit trail.',
    `ot_bill_rate` DECIMAL(18,2) COMMENT 'The hourly bill rate charged to the client for overtime hours (typically hours worked beyond 40 in a workweek). Usually 1.5x the regular bill rate.',
    `ot_pay_rate` DECIMAL(18,2) COMMENT 'The hourly pay rate paid to the worker for overtime hours. Must comply with FLSA overtime requirements (typically 1.5x regular pay rate).',
    `override_number` STRING COMMENT 'Business identifier for the rate override, used for tracking and reference in communications with clients and internal stakeholders.',
    `override_reason` STRING COMMENT 'Business justification for the rate override. Explains why rates differ from standard MSA or VMS rate card (e.g., specialized skills, market conditions, client negotiation, competitive pressure).',
    `override_status` STRING COMMENT 'Current lifecycle status of the rate override. Tracks approval workflow and activation state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|active|expired|superseded — 7 candidates stripped; promote to reference product]',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or unit rate paid to the placed worker for this job order. This is the base compensation rate before burden costs.',
    `per_diem_allowance` DECIMAL(18,2) COMMENT 'Daily allowance provided to the worker for meals, lodging, or incidental expenses when the assignment requires travel or work away from home location.',
    `rate_cap` DECIMAL(18,2) COMMENT 'Maximum bill rate ceiling negotiated with the client or imposed by VMS program rules. Rates cannot exceed this cap regardless of other factors.',
    `rate_floor` DECIMAL(18,2) COMMENT 'Minimum bill rate floor negotiated with the client or required by internal profitability policies. Rates cannot fall below this floor.',
    `rate_source` STRING COMMENT 'Origin or basis for the rate override. Indicates whether rates come from Master Service Agreement (MSA) rate schedule, Vendor Management System (VMS) rate card, or were specially negotiated.. Valid values are `msa_rate_schedule|vms_rate_card|negotiated|client_request|market_adjustment|competitive_bid`',
    `rate_unit` STRING COMMENT 'Unit of measure for the rates (hourly, daily, weekly, monthly, per unit, per project). Defines how rates are applied and billed.. Valid values are `hourly|daily|weekly|monthly|per_unit|per_project`',
    `requested_by` STRING COMMENT 'Name or identifier of the person who requested this rate override. Typically the account manager, recruiter, or client relationship owner.',
    `spread` DECIMAL(18,2) COMMENT 'The difference between bill rate and pay rate (bill_rate - pay_rate). Represents the gross margin before burden costs are applied.',
    CONSTRAINT pk_rate_override PRIMARY KEY(`rate_override_id`)
) COMMENT 'Stores the approved bill rate, pay rate, markup percentage, spread (bill rate minus pay rate), burden rate, and gross margin targets for a requisition. Captures OT (overtime) bill rate, DT (double time) bill rate, per diem allowance, and any client-negotiated rate caps or floors. Tracks rate effective dates, rate approval status, and the rate source (MSA rate schedule, VMS rate card, negotiated). Serves as the financial backbone of the job order connecting to billing and payroll domains.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` (
    `sla_commitment_id` BIGINT COMMENT 'Primary key for sla_commitment',
    `managed_program_id` BIGINT COMMENT 'Reference to the client VMS or MSP program under which this SLA is governed, if applicable.',
    `order_header_id` BIGINT COMMENT 'Reference to the job order (requisition) to which this SLA commitment applies.',
    `performance_scorecard_id` BIGINT COMMENT 'Foreign key linking to vendor.performance_scorecard. Business justification: SLA commitments feed supplier performance scorecards. SLA breach tracking, scorecard metric calculation, and tier review decisions require linking commitments to the scorecard period they impact.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Job order SLA commitments implement contract-level SLA terms. Linking enables breach detection (actual performance vs. contractual targets), penalty calculation, performance reporting against MSA obli',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor granted exclusive submittal rights during the exclusive period, if applicable.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this SLA commitment automatically renews upon expiration unless explicitly terminated.',
    `business_days_definition` STRING COMMENT 'Definition of business days used for SLA measurement, including which days of the week and holidays are excluded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA commitment record was first created in the system.',
    `duplicate_submittal_prevention_rule` STRING COMMENT 'Rule governing how duplicate candidate submittals from multiple vendors are handled (e.g., first submittal wins, client discretion).. Valid values are `first_submittal_wins|client_discretion|no_duplicates_allowed|timestamp_priority`',
    `escalation_contact_email` STRING COMMENT 'Email address of the escalation contact for SLA breach notifications and resolution coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_name` STRING COMMENT 'Name of the primary contact person for SLA escalation and breach resolution.',
    `escalation_contact_phone` STRING COMMENT 'Phone number of the escalation contact for urgent SLA breach communications.',
    `exclusive_period_end_date` DATE COMMENT 'Date when the exclusive submittal period expires and the requisition opens to all authorized vendors.',
    `exclusive_submittal_period_flag` BOOLEAN COMMENT 'Indicates whether an exclusive submittal period is in effect, restricting submittals to a single preferred vendor for a defined timeframe.',
    `fill_rate_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage of requisitions successfully filled within the committed timeframe, used to measure supplier performance.',
    `interview_to_offer_ratio_target` DECIMAL(18,2) COMMENT 'Target ratio of candidate interviews to offers extended, expressed as a percentage, used to measure Quality of Submission (QoS).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this SLA commitment is currently active and in effect.',
    `maximum_submittals_per_vendor` STRING COMMENT 'Maximum number of candidate submittals allowed per vendor or supplier for VMS-managed programs to ensure quality over quantity.',
    `measurement_methodology` STRING COMMENT 'Methodology used to measure SLA performance (e.g., business days excluding holidays, calendar days, hours).. Valid values are `business_days|calendar_days|hours|custom`',
    `minimum_submittals_required` STRING COMMENT 'Minimum number of qualified candidate submittals required to fulfill the SLA commitment for this requisition.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA commitment record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this SLA commitment.',
    `penalty_breach_fee_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed for SLA breach, as defined in the Master Service Agreement (MSA) or Statement of Work (SOW).',
    `penalty_breach_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty breach fee amount.. Valid values are `^[A-Z]{3}$`',
    `penalty_terms_description` STRING COMMENT 'Detailed description of penalty terms and conditions applied when SLA commitments are breached, including escalation procedures.',
    `qos_minimum_score` DECIMAL(18,2) COMMENT 'Minimum Quality of Submission (QoS) score required for candidate submittals, typically measured on a scale of 0-100.',
    `rtr_enforcement_flag` BOOLEAN COMMENT 'Indicates whether Right to Represent (RTR) rules are enforced, requiring vendors to obtain candidate authorization before submittal.',
    `sla_effective_date` DATE COMMENT 'Date when this SLA commitment becomes effective and performance measurement begins.',
    `sla_expiration_date` DATE COMMENT 'Date when this SLA commitment expires or is superseded by a new agreement.',
    `sla_status` STRING COMMENT 'Current performance status of the SLA commitment indicating whether targets are being met or have been breached.. Valid values are `on_track|at_risk|breached|waived|not_applicable`',
    `sla_tier` STRING COMMENT 'The tier or level of service commitment defining the priority and response expectations for this requisition.. Valid values are `standard|premium|vms_managed|enterprise|custom|expedited`',
    `submittal_sla_hours` STRING COMMENT 'Maximum number of hours allowed from job order receipt to first candidate submittal, as committed in the SLA.',
    `submittal_window_close_date` DATE COMMENT 'Date when the submittal window closes and no further candidate submittals will be accepted for this requisition.',
    `submittal_window_open_date` DATE COMMENT 'Date when the submittal window opens and vendors are authorized to begin submitting candidates for this requisition.',
    `ttf_target_days` STRING COMMENT 'Target number of business days from job order opening to candidate placement acceptance, as committed in the SLA.',
    `tts_target_days` STRING COMMENT 'Target number of business days from job order opening to candidate first day on assignment, as committed in the SLA.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the individual who approved the SLA waiver.',
    `waiver_approved_date` DATE COMMENT 'Date when the SLA waiver was officially approved.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a waiver has been granted exempting this requisition from standard SLA commitments due to exceptional circumstances.',
    `waiver_reason` STRING COMMENT 'Business justification for granting an SLA waiver, including circumstances and approving authority.',
    CONSTRAINT pk_sla_commitment PRIMARY KEY(`sla_commitment_id`)
) COMMENT 'Defines the SLA (Service Level Agreement) commitments and submittal governance rules attached to a requisition or client program. Captures TTF (Time to Fill) target in business days, TTS (Time to Start) target, submittal SLA (hours to first submittal), minimum submittals required per req, maximum submittals per vendor (VMS programs), submittal window open/close dates, exclusive submittal period flag, RTR (Right to Represent) enforcement flag, duplicate submittal prevention rules, interview-to-offer ratio target, fill rate target, and penalty terms for SLA breach. Tracks SLA tier (standard, premium, VMS-managed), SLA status (on-track, at-risk, breached), and measurement methodology. Enables operational SLA monitoring, QoS (Quality of Submission) governance, VMS program compliance, and client reporting.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` (
    `order_status_history_id` BIGINT COMMENT 'Unique identifier for each status transition event in the job order lifecycle. Primary key for the order status history log.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Status transitions (especially fill events) trigger revenue recognition and must be period-stamped for accurate accrual accounting, revenue cutoff, and financial close—critical for matching revenue to',
    `assignment_id` BIGINT COMMENT 'Foreign key reference to the specific placement record associated with this status event. Populated for milestone events related to candidate placement, offer, or assignment start.',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the job order (requisition) that this status event belongs to. Links each status transition to its parent job order.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the system user who initiated or triggered this status transition. Null for system-automated transitions.',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the candidate associated with this milestone event. Populated for candidate-specific milestones such as submittal, interview, offer, or start.',
    `tertiary_order_account_manager_staff_profile_id` BIGINT COMMENT 'Identifier of the client account manager responsible for the client relationship at the time of this event. Used for client service performance tracking.',
    `actual_completion_date` DATE COMMENT 'The actual date when the milestone was achieved. Used to calculate variance against target date and measure operational performance.',
    `client_feedback` STRING COMMENT 'Client comments or feedback received at this stage of the job order lifecycle. Captures client satisfaction, concerns, or specific instructions related to this status transition.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this status event triggered an escalation to management due to SLA breach, client complaint, or other critical issue.',
    `escalation_level` STRING COMMENT 'The management level to which this status event was escalated. Null if no escalation occurred.. Valid values are `none|team_lead|manager|director|vp|executive`',
    `event_type` STRING COMMENT 'Classification of the lifecycle event being recorded. Distinguishes between status transitions, milestone achievements, order modifications, extensions, cancellations, and reopenings.. Valid values are `status_change|milestone_reached|modification|extension|cancellation|reopen`',
    `headcount_filled` STRING COMMENT 'Number of positions filled at the time of this status event. Tracks partial fulfillment progress for multi-headcount requisitions.',
    `headcount_remaining` STRING COMMENT 'Number of positions still unfilled at the time of this status event. Calculated as total headcount minus headcount filled.',
    `internal_notes` STRING COMMENT 'Internal operational notes and observations recorded by the recruiting team at the time of this status event. Not shared with clients.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active status for the job order. Only one record per req_id should have is_active set to True at any given time.',
    `milestone_type` STRING COMMENT 'The specific fulfillment milestone reached in the job order lifecycle. Used to track key operational checkpoints from requisition intake through assignment completion. Null for non-milestone events. [ENUM-REF-CANDIDATE: req_received|sourcing_started|first_submittal|interview_scheduled|offer_extended|offer_accepted|placement_confirmed|worker_started|assignment_ended|req_closed — 10 candidates stripped; promote to reference product]',
    `new_status` STRING COMMENT 'The job order status after this transition event. Represents the current state of the requisition following this event. [ENUM-REF-CANDIDATE: draft|open|in_progress|on_hold|filled|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether automated notifications were sent to stakeholders (client, recruiter, candidate) for this status event.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when automated notifications were sent for this status event. Null if no notifications were sent.',
    `previous_status` STRING COMMENT 'The job order status immediately before this transition event. Null for the initial status event when the requisition is first created. [ENUM-REF-CANDIDATE: draft|open|in_progress|on_hold|filled|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for this status transition or milestone event. Critical for root cause analysis of delays, cancellations, and fulfillment patterns. [ENUM-REF-CANDIDATE: client_request|candidate_accepted|candidate_declined|position_filled|budget_cut|hiring_freeze|requirements_changed|market_conditions|internal_transfer|duplicate_req|other — 11 candidates stripped; promote to reference product]',
    `reason_notes` STRING COMMENT 'Free-text explanation providing additional context about the status transition or milestone event. Supplements the standardized reason code with specific details.',
    `record_created_by` STRING COMMENT 'System user or process identifier that created this status history record. Used for audit trail and data governance.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this status history record was first created in the database. Used for audit trail and data lineage tracking.',
    `record_updated_by` STRING COMMENT 'System user or process identifier that last modified this status history record. Used for audit trail and data governance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this status history record was last modified. Used for audit trail and change tracking.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether this milestone event breached the contractual SLA commitment. True if actual completion exceeded target date, False otherwise.',
    `sla_breach_severity` STRING COMMENT 'Classification of SLA breach severity based on the magnitude of variance. Used for escalation management and client communication prioritization.. Valid values are `none|minor|moderate|major|critical`',
    `target_date` DATE COMMENT 'The planned or Service Level Agreement (SLA) target date by which this milestone was expected to be completed. Used for variance analysis and SLA breach detection.',
    `transition_timestamp` TIMESTAMP COMMENT 'The precise date and time when this status transition or milestone event occurred. Primary business event timestamp for Time to Fill (TTF) and Time to Start (TTS) calculations.',
    `triggering_system` STRING COMMENT 'The source system or process that generated this status event. Identifies whether the transition was user-initiated, system-automated, or triggered by external integration.. Valid values are `bullhorn_ats|beeline_vms|salesforce_crm|api_integration|batch_process|manual_entry`',
    `ttf_elapsed_days` STRING COMMENT 'Cumulative business days elapsed from requisition receipt to this event. When milestone_type is placement_confirmed, this represents the complete Time to Fill metric for the job order.',
    `tts_elapsed_days` STRING COMMENT 'Cumulative business days elapsed from requisition receipt to worker start date. Populated when milestone_type is worker_started. Represents the complete Time to Start metric for the job order.',
    `variance_business_days` STRING COMMENT 'The difference in business days between target date and actual completion date. Positive values indicate late completion (SLA breach), negative values indicate early completion. Null if milestone not yet completed.',
    CONSTRAINT pk_order_status_history PRIMARY KEY(`order_status_history_id`)
) COMMENT 'Authoritative lifecycle event log for a job order, capturing every status transition and fulfillment milestone from intake through closure. Records event type (status change, milestone reached), previous status, new status, milestone type (req received, sourcing started, first submittal, interview scheduled, offer extended, placement confirmed, worker started, assignment ended), transition timestamp, target date, actual completion date, variance in business days, reason code, triggering user or system, responsible recruiter, and associated notes. Single source of truth for TTF (Time to Fill) and TTS (Time to Start) measurement, SLA breach analysis, recruiter performance benchmarking, and operational reporting. Subsumes all milestone tracking — no separate milestone entity exists.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`order_modification` (
    `order_modification_id` BIGINT COMMENT 'Unique identifier for the job order modification record. Primary key for tracking all amendments and change orders applied to requisitions.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the person who approved or rejected the modification. Typically an account manager, operations manager, or client contact with approval authority.',
    `amendment_id` BIGINT COMMENT 'Reference to the formal contract amendment document generated for this modification. Links to contract lifecycle management system.',
    `joborder_approval_workflow_id` BIGINT COMMENT 'Foreign key linking to joborder.joborder_approval_workflow. Business justification: order_modification tracks amendments and changes to requisitions. When a modification requires approval (approval_required = true), it should reference the specific approval workflow instance that gov',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the job order header being modified. Links this modification to the parent requisition.',
    `primary_order_staff_profile_id` BIGINT COMMENT 'Identifier of the person or system that requested the modification. May reference client contact, internal employee, or system user depending on requestor_type.',
    `approval_comments` STRING COMMENT 'Notes or comments provided by the approver during the approval or rejection decision. Captures conditions, concerns, or additional context.',
    `approval_date` DATE COMMENT 'Date when the modification was formally approved or rejected. Null if still pending approval or if approval is not required.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether this modification requires formal approval before implementation. Certain changes may be auto-approved based on business rules.',
    `approver_name` STRING COMMENT 'Full name of the person who approved or rejected the modification. Denormalized for audit trail and reporting.',
    `billing_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary impact of the modification on client billing. Positive for increases, negative for decreases. Used for invoice adjustments and revenue forecasting.',
    `billing_impact` STRING COMMENT 'Classification of how this modification affects client billing. Used to trigger billing adjustments and revenue recognition updates. [ENUM-REF-CANDIDATE: none|rate_increase|rate_decrease|volume_increase|volume_decrease|duration_extension|billing_adjustment — 7 candidates stripped; promote to reference product]',
    `contract_amendment_required` BOOLEAN COMMENT 'Indicates whether this modification requires a formal contract amendment or Statement of Work (SOW) update with the client.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this modification record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for billing adjustment amount. Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the approved modification becomes binding and takes effect on the requisition. Used for billing adjustments and contract amendment tracking.',
    `field_modified` STRING COMMENT 'Name of the requisition field or attribute being changed by this modification (e.g., bill_rate, headcount_target, assignment_end_date, job_title).',
    `implementation_date` DATE COMMENT 'Date when the approved modification was actually applied to the requisition record. May differ from effective_date for retroactive changes.',
    `modification_date` DATE COMMENT 'Date when the modification was requested or initiated. Principal business event timestamp for this change order.',
    `modification_number` STRING COMMENT 'Business identifier for this modification. Sequential or formatted number used to track change orders externally (e.g., MOD-001, CHG-2023-045).',
    `modification_reason` STRING COMMENT 'Business justification or explanation for the modification. Free-text field capturing why the change was requested (e.g., budget adjustment, scope expansion, client request).',
    `modification_status` STRING COMMENT 'Current lifecycle state of the modification request. Tracks approval workflow from draft through implementation or rejection.. Valid values are `draft|pending_approval|approved|rejected|implemented|cancelled`',
    `modification_type` STRING COMMENT 'Category of modification applied to the requisition. Classifies the nature of the change for reporting and contract amendment tracking.. Valid values are `rate_change|headcount_change|duration_extension|scope_change|location_change|title_change`',
    `new_value` DECIMAL(18,2) COMMENT 'Updated value of the field after the modification. Stored as string to accommodate various data types. Used for billing adjustments and contract updates.',
    `notification_date` TIMESTAMP COMMENT 'Timestamp when stakeholder notifications were sent for this modification. Used for Service Level Agreement (SLA) tracking and audit purposes.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether stakeholder notifications have been sent for this modification. Tracks communication workflow completion.',
    `old_value` DECIMAL(18,2) COMMENT 'Original value of the field before the modification. Stored as string to accommodate various data types. Critical for audit trail and contract amendment history.',
    `priority_level` STRING COMMENT 'Urgency classification for processing this modification. High priority changes may require expedited approval and implementation.. Valid values are `low|medium|high|urgent`',
    `requestor_email` STRING COMMENT 'Email address of the modification requestor. Used for notification and approval workflow communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_name` STRING COMMENT 'Full name of the person who requested the modification. Denormalized for reporting and audit trail purposes.',
    `requestor_type` STRING COMMENT 'Classification of the party who initiated the modification request. Distinguishes between client-driven changes and internal adjustments.. Valid values are `client_contact|internal_recruiter|account_manager|vms_system|hiring_manager`',
    `source_system` STRING COMMENT 'Name of the system where the modification was originated (e.g., Bullhorn, Beeline VMS, internal portal). Used for data lineage and integration tracking.',
    `source_system_code` STRING COMMENT 'Unique identifier for this modification in the source system. Enables bidirectional synchronization and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this modification record was last updated. Audit trail for tracking changes to the modification itself.',
    `vms_modification_code` STRING COMMENT 'External modification identifier from the client VMS system. Used for reconciliation and integration with VMS platforms like Beeline or Fieldglass.',
    CONSTRAINT pk_order_modification PRIMARY KEY(`order_modification_id`)
) COMMENT 'Records all amendments, modifications, and change orders applied to an existing requisition. Captures modification type (rate change, headcount change, duration extension, scope change, location change, title change), the field modified, old value, new value, modification date, requestor (client contact or internal recruiter), approval status, and approval date. Tracks the complete change history of a req from original intake through final closure. Supports contract amendment traceability and client billing adjustments.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` (
    `fulfillment_team_id` BIGINT COMMENT 'Primary key for fulfillment_team',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recruiter assignments must track to cost centers for internal labor cost allocation, profitability analysis by service line, and commission calculation—critical for staffing firm financial management ',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the job order or requisition (req) that this fulfillment team is assigned to. Links the assignment to the specific client demand being fulfilled.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key reference to the internal recruiter, sourcing specialist, account manager, or coordinator assigned to this requisition. Links to the employee or user record in the HRIS or ATS system.',
    `actual_submittal_count` STRING COMMENT 'The actual number of candidate submittals this team member has delivered for this requisition to date. Used to track progress against expected submittal targets and measure recruiter productivity and quality of submission (QoS).',
    `assignment_created_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was first created in the system. Audit field for tracking when the assignment was initially established. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `assignment_end_date` DATE COMMENT 'The date when this team member assignment ended, either due to requisition closure, fulfillment completion, reassignment to another recruiter, or order cancellation. Null if the assignment is still active. Used to calculate assignment duration and recruiter tenure on orders.',
    `assignment_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was last updated or modified. Audit field for tracking changes to assignment details, status transitions, or workload adjustments. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `assignment_notes` STRING COMMENT 'Free-text field for capturing special instructions, context, or notes related to this specific assignment. May include handoff notes from previous recruiters, client preferences, sourcing strategies, or coordination details. Used for knowledge transfer during reassignments.',
    `assignment_priority` STRING COMMENT 'The priority level assigned to this team member for working this requisition, relative to their other assignments. Helps recruiters manage their workload and focus on the most urgent or strategic orders. May differ from the requisition overall priority based on individual workload and client relationships.. Valid values are `critical|high|medium|low`',
    `assignment_reason` STRING COMMENT 'The business reason or trigger for this assignment. Indicates whether this is a new order assignment, a reassignment from another recruiter, a workload balancing action, a skill-based match, a client relationship consideration, a backfill for a departing team member, or an escalation for a struggling order. [ENUM-REF-CANDIDATE: new_order|reassignment|workload_balance|skill_match|client_relationship|backfill|escalation — 7 candidates stripped; promote to reference product]',
    `assignment_role` STRING COMMENT 'The functional role or responsibility that the assigned team member holds for this requisition. Defines whether they are the primary lead recruiter, a supporting sourcing specialist, the client-facing account manager, or an administrative coordinator. Used for performance attribution and commission split calculations.. Valid values are `lead_recruiter|sourcing_specialist|account_manager|coordinator|support_recruiter|team_lead`',
    `assignment_start_date` DATE COMMENT 'The date when this team member was assigned to work on this requisition. Marks the beginning of their responsibility for fulfillment activities and is used to calculate time-to-fill (TTF) and workload duration metrics.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this team member assignment. Indicates whether the assignment is actively being worked, has been reassigned to another recruiter, is closed due to order fulfillment or cancellation, is temporarily on hold, or is pending activation.. Valid values are `active|reassigned|closed|on_hold|pending`',
    `client_contact_authorized_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this team member is authorized to directly contact the client for this requisition. False may indicate a support role that works through the account manager. Used to manage client relationships and ensure consistent communication.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this team member is eligible to receive commission or performance credit for placements made on this requisition. May be False for coordinators or support roles that do not participate in commission plans.',
    `commission_split_percentage` DECIMAL(18,2) COMMENT 'The percentage of total commission or gross profit (GP) that this team member will receive for placements on this requisition, expressed as a decimal (e.g., 0.60 for 60%). Used in split-credit scenarios where multiple recruiters share commission. Sum of commission splits across all eligible assignments for a placement typically equals 1.00 (100%). Confidential business data.',
    `expected_submittal_count` STRING COMMENT 'The target number of candidate submittals this team member is expected to deliver for this requisition. Used for performance tracking and workload planning. May be set based on historical conversion rates, client requirements, or internal service level agreements (SLAs).',
    `performance_rating` STRING COMMENT 'Qualitative performance rating for this team member on this specific assignment, typically assessed at assignment closure or during periodic reviews. Reflects quality of submittals, client feedback, time-to-fill performance, and overall contribution to order fulfillment. Used for coaching, development, and performance management.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|not_rated`',
    `placement_count` STRING COMMENT 'The number of successful placements this team member has achieved for this requisition. Typically 0 or 1 for single-headcount orders, but may be higher for multi-headcount requisitions. Used for commission calculations and performance attribution.',
    `primary_assignment_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) identifying whether this team member is the primary or lead owner of the requisition. True indicates the main point of accountability; False indicates a supporting or secondary role. Only one assignment per requisition should typically have this flag set to True.',
    `reassignment_count` STRING COMMENT 'The number of times this requisition has been reassigned to different team members prior to this current assignment. High reassignment counts may indicate order difficulty, client issues, or internal capacity challenges. Used for operational analytics and process improvement.',
    `sourcing_channel_focus` STRING COMMENT 'Free-text or semi-structured field indicating the primary sourcing channels or strategies this team member is focusing on for this requisition (e.g., LinkedIn Recruiter, internal database, employee referrals, job boards, vendor management system (VMS) talent pools). Used for sourcing strategy tracking and channel effectiveness analysis.',
    `time_to_first_submittal_days` STRING COMMENT 'The number of calendar days from assignment start date to the first candidate submittal delivered by this team member for this requisition. Key performance indicator (KPI) for recruiter responsiveness and sourcing efficiency. Null if no submittals have been made yet.',
    `workload_weight` DECIMAL(18,2) COMMENT 'The percentage of workload or credit allocated to this team member for this requisition, expressed as a decimal (e.g., 0.50 for 50%, 1.00 for 100%). Used in split-credit scenarios where multiple recruiters share responsibility for a single order. Sum of workload weights across all active assignments for a requisition typically equals 1.00 (100%). Critical for commission splits, performance attribution, and capacity planning.',
    CONSTRAINT pk_fulfillment_team PRIMARY KEY(`fulfillment_team_id`)
) COMMENT 'Association entity linking a requisition to the internal recruiter(s), account manager(s), and sourcing team responsible for fulfillment. Captures assigned recruiter, assignment role (lead recruiter, sourcing specialist, account manager, coordinator), assignment start date, assignment end date, assignment status (active, reassigned, closed), and workload weight for split-credit scenarios. Enables recruiter workload management, performance attribution, and commission split tracking.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`vms_order` (
    `vms_order_id` BIGINT COMMENT 'Unique identifier for the VMS order record in the lakehouse. Primary key for this product.',
    `client_rate_card_id` BIGINT COMMENT 'The identifier of the VMS rate card or pricing schedule that governs this requisition. Links to the VMS platforms rate card configuration.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: VMS orders include client cost center codes for their internal accounting and our revenue recognition by client department—essential for VMS billing reconciliation and client financial reporting in ma',
    `joborder_approval_workflow_id` BIGINT COMMENT 'The identifier of the approval workflow or routing path used in the VMS platform for this requisition. Tracks the approval process and routing rules.',
    `order_header_id` BIGINT COMMENT 'The unique requisition identifier assigned by the VMS platform (Beeline, Fieldglass, Wand). This is the external systems primary identifier for the requisition.',
    `program_allocation_id` BIGINT COMMENT 'Foreign key linking to vendor.program_allocation. Business justification: VMS order distribution enforces program allocation rules (submission caps, priority rank, allocation %). Order routing logic, allocation cap enforcement, and supplier sequencing require direct allocat',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: VMS orders are distributed to specific suppliers based on tier/allocation rules. Order distribution workflow, submittal tracking, and supplier performance measurement require direct supplier link for ',
    `tier_classification_id` BIGINT COMMENT 'Foreign key linking to vendor.tier_classification. Business justification: VMS order distribution follows tier-based routing rules (Tier 1 first-look, Tier 2 cascade). Order routing logic, submission window enforcement, and supplier priority sequencing require direct tier cl',
    `vms_enrollment_id` BIGINT COMMENT 'Foreign key linking to vendor.vms_enrollment. Business justification: VMS orders only route to suppliers with active program enrollment. Order distribution eligibility checks, compliance verification, and supplier access control require direct enrollment status referenc',
    `vms_order_header_id` BIGINT COMMENT 'Foreign key reference to the internal ATS requisition (job order header). Links the VMS order to the internal job order for dual-system synchronization.',
    `vms_program_id` BIGINT COMMENT 'Foreign key reference to the VMS program under which this requisition is managed. Links to the clients VMS program configuration.',
    `approval_status` STRING COMMENT 'The current approval status of this requisition within the VMS platforms approval workflow. Indicates whether the requisition has been approved for vendor distribution.. Valid values are `Pending|Approved|Rejected|Conditional|Escalated`',
    `approved_by_name` STRING COMMENT 'The name of the person who approved this requisition in the VMS platform. Used for audit trail and accountability.',
    `approved_date` DATE COMMENT 'The date when this requisition was approved in the VMS platform and released for vendor distribution.',
    `auto_distribution_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this requisition was automatically distributed to vendors by the VMS platform based on program rules. True = auto-distributed, False = manually distributed.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this VMS order record was first created in the lakehouse. Used for audit trail and data lineage tracking.',
    `current_submittal_count` STRING COMMENT 'The current number of candidate submittals received for this requisition across all vendors. Used to track progress toward fulfillment and enforce submission caps.',
    `distribution_date` DATE COMMENT 'The date when this requisition was distributed to eligible vendors in the VMS platform. Marks the start of the vendor engagement process.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent synchronization event between the VMS platform and the internal ATS for this requisition. Used to track data freshness and identify sync issues.',
    `max_submittal_count` STRING COMMENT 'The maximum number of candidate submittals allowed per vendor for this requisition. VMS platforms enforce this limit to control submission volume and ensure quality over quantity.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this VMS order record was last modified in the lakehouse. Used for audit trail and change tracking.',
    `msp_name` STRING COMMENT 'The name of the Managed Service Provider (MSP) managing this VMS program and requisition on behalf of the client.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this VMS order. May include special instructions, clarifications, or context from the VMS platform or MSP.',
    `purchase_order_number` STRING COMMENT 'The clients purchase order number associated with this requisition. Used for financial tracking and invoice reconciliation.',
    `rtr_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether vendors must have an active Right to Represent (RTR) agreement with the candidate before submitting them for this requisition. True = RTR required, False = RTR not required.',
    `sow_reference_number` STRING COMMENT 'The reference number of the Statement of Work (SOW) associated with this requisition, if applicable. Links the requisition to a project-based SOW engagement.',
    `submission_window_close_timestamp` TIMESTAMP COMMENT 'The date and time when the submission window closes for this requisition. Vendors cannot submit candidates after this timestamp unless the window is extended.',
    `submission_window_open_timestamp` TIMESTAMP COMMENT 'The date and time when the submission window opens for vendors to submit candidates for this requisition. Vendors cannot submit before this timestamp.',
    `supplier_diversity_requirement` STRING COMMENT 'Indicates whether this requisition has supplier diversity requirements (e.g., Minority Business Enterprise, Women Business Enterprise, Service-Disabled Veteran-Owned Small Business). Used for diversity program compliance and reporting. [ENUM-REF-CANDIDATE: None|Preferred|Required|MBE|WBE|SDVOSB|HUBZone|8a — 8 candidates stripped; promote to reference product]',
    `sync_status` STRING COMMENT 'The current synchronization status between the VMS platform and the internal ATS for this requisition. Indicates whether the data is in sync or requires attention.. Valid values are `Synced|Pending|Failed|Out of Sync|Manual Override`',
    `vendor_tier` STRING COMMENT 'The vendor tier or classification level that determines which staffing suppliers are eligible to submit candidates for this requisition. Tier 1 typically has first access, followed by Tier 2 and Tier 3.. Valid values are `Tier 1|Tier 2|Tier 3|Preferred|Standard|Restricted`',
    `vendor_tier_sequence` STRING COMMENT 'The numeric sequence order for vendor tier access (1 = first tier, 2 = second tier, etc.). Used to control the waterfall release of requisitions to supplier tiers.',
    `vms_bill_rate_cap` DECIMAL(18,2) COMMENT 'The maximum bill rate allowed by the VMS program for this requisition. Vendors cannot submit candidates with bill rates exceeding this cap.',
    `vms_client_code` STRING COMMENT 'The client code or identifier used in the VMS platform. Used for cross-reference mapping between VMS and internal ATS client records.',
    `vms_client_name` STRING COMMENT 'The client name as recorded in the VMS platform. May differ from the internal ATS client name due to naming conventions or organizational structure differences.',
    `vms_department_code` STRING COMMENT 'The department or cost center code within the client organization as recorded in the VMS platform. Used for financial reporting and budget tracking.',
    `vms_department_name` STRING COMMENT 'The department or cost center name within the client organization as recorded in the VMS platform. Used for client-side reporting and cost allocation.',
    `vms_hiring_manager_email` STRING COMMENT 'The email address of the hiring manager as recorded in the VMS platform. Used for communication and notification routing.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vms_hiring_manager_name` STRING COMMENT 'The name of the hiring manager for this requisition as recorded in the VMS platform. May differ from internal ATS records.',
    `vms_import_timestamp` TIMESTAMP COMMENT 'The timestamp when this requisition was imported from the VMS platform into the internal ATS. Used for reconciliation and synchronization tracking.',
    `vms_markup_cap_percentage` DECIMAL(18,2) COMMENT 'The maximum markup percentage (bill rate minus pay rate, expressed as a percentage of pay rate) allowed by the VMS program. Enforces margin limits on supplier pricing.',
    `vms_order_status` STRING COMMENT 'The current status of the requisition within the VMS platform workflow. Reflects the VMS-specific lifecycle state which may differ from internal ATS status. [ENUM-REF-CANDIDATE: Open|Pending Approval|Approved|Submitted|In Review|Filled|Closed|Cancelled|On Hold — 9 candidates stripped; promote to reference product]',
    `vms_pay_rate_cap` DECIMAL(18,2) COMMENT 'The maximum pay rate allowed by the VMS program for this requisition. Used to enforce compensation limits and ensure budget compliance.',
    `vms_platform_name` STRING COMMENT 'The name of the VMS technology platform hosting this requisition (e.g., Beeline, Fieldglass, Wand). [ENUM-REF-CANDIDATE: Beeline|Fieldglass|Wand|Workday VNDLY|PRO Unlimited|Utmost|Other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_vms_order PRIMARY KEY(`vms_order_id`)
) COMMENT 'Captures VMS (Vendor Management System)-specific metadata for requisitions managed through platforms such as Beeline, Fieldglass, or Wand. Stores VMS requisition ID, VMS program name, MSP (Managed Service Provider) name, vendor tier eligibility, submission window timestamps, max submittal count per vendor, VMS rate caps, markup caps, RTR (Right to Represent) requirement flag, VMS order status, and cross-reference mapping to internal ATS req ID. Essential for MSP/VMS program compliance, automated req import reconciliation, and dual-system synchronization between the VMS platform and internal ATS.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`order_location` (
    `order_location_id` BIGINT COMMENT 'Unique identifier for the job order work location record. Primary key for this entity.',
    `location_id` BIGINT COMMENT 'Foreign key reference to the master client location record. Links to the client domain for master site data and facility details.',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the parent job order requisition. Links this work location to the specific req it supports.',
    `address_line_1` STRING COMMENT 'Primary street address of the work location. First line of the physical address where the worker will report.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite number, floor, building, or department. Optional address detail for the work location.',
    `badge_access_required` BOOLEAN COMMENT 'Flag indicating whether workers need security badge or access credentials for this location. Triggers badging and credentialing workflows.',
    `badge_sponsor_name` STRING COMMENT 'Name of the client contact or security coordinator responsible for issuing badges at this location. Used for onboarding coordination.',
    `city` STRING COMMENT 'City or municipality where the work location is situated. Used for payroll tax jurisdiction determination and local compliance requirements.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the work location. Determines international compliance requirements, tax treaties, and immigration rules.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish where the work location resides. Required for certain local tax jurisdictions and workers compensation rating.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work location record was first created in the system. Part of audit trail for data lineage and compliance tracking.',
    `dress_code` STRING COMMENT 'Dress code or attire requirements for this work location. May include business formal, business casual, scrubs, uniforms, or personal protective equipment (PPE) specifications.',
    `effective_end_date` DATE COMMENT 'Date when this work location is no longer active for the requisition. Nullable for ongoing assignments. Used to track location changes and assignment closures.',
    `effective_start_date` DATE COMMENT 'Date when this work location becomes active for the requisition. Workers may be assigned to this location on or after this date.',
    `is_union_site` BOOLEAN COMMENT 'Flag indicating whether this work location is covered by a union contract. Affects candidate eligibility, pay rates, and assignment terms.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the work location. Supports mapping, distance calculations, and field worker dispatch optimization.',
    `location_number` STRING COMMENT 'Business identifier for this work location assignment within the requisition. Used for tracking when a single req has multiple work sites.',
    `location_status` STRING COMMENT 'Current lifecycle status of this work location assignment. Tracks whether the location is available for new placements or has been closed.. Valid values are `active|inactive|pending|closed`',
    `location_type` STRING COMMENT 'Classification of the work location arrangement. Determines candidate matching criteria, compliance requirements, and payroll tax jurisdiction rules.. Valid values are `client_site|remote|hybrid|field|home_office|multi_site`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the work location. Supports mapping, distance calculations, and field worker dispatch optimization.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work location record was last updated. Tracks changes to location details, status transitions, or requirement modifications.',
    `notes` STRING COMMENT 'Free-text notes capturing additional location-specific requirements, special instructions, or operational details not covered by structured fields.',
    `parking_available` BOOLEAN COMMENT 'Flag indicating whether parking is available at the work location. Affects candidate acceptance and may impact compensation or reimbursement.',
    `parking_instructions` STRING COMMENT 'Details on parking arrangements, lot location, permit requirements, or parking fees. Provided to candidates during onboarding.',
    `per_diem_eligible` BOOLEAN COMMENT 'Flag indicating whether workers at this location are eligible for per diem allowances. Based on distance from home, assignment duration, and client policy.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily per diem allowance amount for workers assigned to this location. Covers meals, lodging, and incidental expenses for travel assignments.',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the work location. Used for local tax jurisdiction mapping and geographic reporting.',
    `ppe_required` STRING COMMENT 'List of required personal protective equipment for this work location. Examples include hard hats, safety glasses, steel-toed boots, gloves, or respirators.',
    `prevailing_wage_applicable` BOOLEAN COMMENT 'Flag indicating whether Davis-Bacon Act or state prevailing wage requirements apply to this work location. Mandates minimum wage rates for government-funded projects.',
    `prevailing_wage_determination` STRING COMMENT 'Department of Labor wage determination number or reference for prevailing wage rates at this location. Required for compliance on government contracts.',
    `reporting_instructions` STRING COMMENT 'Detailed instructions for workers on where to report on their first day, including building entrance, reception desk, contact person, and check-in procedures.',
    `safety_classification` STRING COMMENT 'OSHA hazard category or safety classification for the work site. Determines required safety training, personal protective equipment (PPE), and workers compensation insurance classification codes.',
    `security_clearance_level` STRING COMMENT 'Required government or client security clearance level for workers at this location. Examples include Confidential, Secret, Top Secret, or client-specific clearance designations.',
    `site_contact_email` STRING COMMENT 'Email address for the primary site contact. Used for assignment notifications, timesheet approvals, and ongoing communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `site_contact_name` STRING COMMENT 'Name of the primary client contact or supervisor at this work location. Point of contact for day-to-day assignment coordination and issue resolution.',
    `site_contact_phone` STRING COMMENT 'Phone number for the primary site contact. Used for worker check-in, emergency communication, and assignment coordination.',
    `site_name` STRING COMMENT 'The name of the client facility or work site where the worker will be assigned. May be a building name, campus identifier, or project site designation.',
    `state_province` STRING COMMENT 'State or province code for the work location. Critical for State Unemployment Tax Act (SUTA) determination, workers compensation classification, and state-specific labor law compliance.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the work location. Used for scheduling, timesheet management, and shift coordination across multiple sites.',
    `union_jurisdiction` STRING COMMENT 'Union local or jurisdiction governing this work location, if applicable. Determines collective bargaining agreement (CBA) applicability, wage rates, and work rules.',
    `workers_comp_class_code` STRING COMMENT 'NCCI or state-specific workers compensation classification code for this work location. Drives insurance premium calculation and risk assessment.',
    CONSTRAINT pk_order_location PRIMARY KEY(`order_location_id`)
) COMMENT 'Defines the work location details for a requisition, supporting multi-site deployments where a single req may have workers at multiple client facilities. Captures site name, street address, city, state, zip code, country, location type (client site, remote, hybrid, field), work site safety classification (OSHA category), and location-specific requirements (parking, badge access, union jurisdiction, prevailing wage applicability, per diem eligibility). References client domain for master site data via FK; stores req-specific overrides and work-condition details that affect candidate matching, compliance determination, payroll tax jurisdiction (SUTA state, local tax), and workers compensation classification.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`order_extension` (
    `order_extension_id` BIGINT COMMENT 'Unique identifier for the order extension record. Primary key for the order extension entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Extensions modify revenue streams and must be tracked by accounting period for proper revenue recognition, forecasting accuracy, and financial reporting—essential for revenue timing and period-end acc',
    `assignment_id` BIGINT COMMENT 'Foreign key reference to the active placement or assignment being extended. Links extension to the specific worker assignment.',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the parent job order requisition being extended. Links this extension event to the original job order.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Assignment extensions are negotiated with the supplier providing the worker. Rate renegotiation, approval workflow, and supplier performance tracking require knowing which supplier is extending the as',
    `approval_required` BOOLEAN COMMENT 'Flag indicating whether formal approval is required for this extension. Typically true for extensions with rate changes or significant duration.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the extension request. Nullable if not yet approved or if approval is not required.',
    `approving_authority` STRING COMMENT 'Role or authority level of the person who approved the extension. Defines the approval hierarchy level.. Valid values are `account_manager|client_contact|vms_coordinator|operations_manager|finance_director`',
    `benefits_eligibility_change` BOOLEAN COMMENT 'Flag indicating whether this extension triggers a change in the workers benefits eligibility status (e.g., crossing ACA threshold, tenure-based benefits).',
    `client_approval_date` DATE COMMENT 'Date when the client formally approved the extension. Nullable if client approval is not required or not yet received.',
    `client_approval_required` BOOLEAN COMMENT 'Flag indicating whether explicit client approval is required for this extension. Common for VMS programs or MSA-governed relationships.',
    `client_approver_name` STRING COMMENT 'Name of the client contact who approved the extension. Captures client-side authorization for audit and relationship management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this extension record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this extension record (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `extended_bill_rate` DECIMAL(18,2) COMMENT 'The bill rate charged to the client for the extended assignment period. May differ from the original bill rate if rate changes are negotiated.',
    `extended_markup_percentage` DECIMAL(18,2) COMMENT 'The markup percentage (bill rate minus pay rate divided by pay rate) for the extended period. Key profitability metric.',
    `extended_pay_rate` DECIMAL(18,2) COMMENT 'The pay rate paid to the worker for the extended assignment period. May differ from the original pay rate due to tenure increases or renegotiation.',
    `extended_spread` DECIMAL(18,2) COMMENT 'The gross margin spread (bill rate minus pay rate) for the extended period. Represents gross profit per hour or unit.',
    `extension_approval_date` DATE COMMENT 'Date when the extension request was formally approved by the authorized approver. Nullable if not yet approved or if rejected.',
    `extension_duration_days` STRING COMMENT 'Length of the extension period expressed in calendar days. Provides granular duration measurement for short-term extensions.',
    `extension_duration_weeks` DECIMAL(18,2) COMMENT 'Length of the extension period expressed in weeks. Calculated as the difference between extension end date and extension start date.',
    `extension_end_date` DATE COMMENT 'New end date for the assignment after the extension is applied. Replaces the previous assignment end date.',
    `extension_number` STRING COMMENT 'Business-readable identifier for this extension event. Typically sequential or formatted per business rules (e.g., EXT-2024-00123).',
    `extension_reason` STRING COMMENT 'Business reason or justification for the assignment extension. Captures why the client or business requested the extension.. Valid values are `client_request|project_continuation|backfill_pending|budget_renewal|scope_expansion|performance_excellence`',
    `extension_reason_notes` STRING COMMENT 'Free-text detailed explanation or additional context for the extension reason. Captures business justification and client feedback.',
    `extension_request_date` DATE COMMENT 'Date when the extension was formally requested by the client or internal stakeholder. Marks the beginning of the extension lifecycle.',
    `extension_sequence_number` STRING COMMENT 'Sequential number indicating which extension this is for the placement (1st extension, 2nd extension, etc.). Tracks extension history.',
    `extension_start_date` DATE COMMENT 'Effective start date of the extended assignment period. Typically the day after the original assignment end date.',
    `extension_status` STRING COMMENT 'Current lifecycle status of the extension request. Tracks the extension from initial request through approval and activation. [ENUM-REF-CANDIDATE: requested|pending_approval|approved|rejected|cancelled|active|completed — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this extension record was last modified. Audit trail for change tracking and data quality monitoring.',
    `msa_reference` STRING COMMENT 'Reference to the governing MSA or contract that authorizes this extension. Links extension to contractual terms and rate cards.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the extension. Captures operational context.',
    `original_bill_rate` DECIMAL(18,2) COMMENT 'The bill rate that was in effect before this extension. Used for comparison and rate change analysis.',
    `original_end_date` DATE COMMENT 'The original scheduled end date of the assignment before this extension was applied. Used for comparison and duration calculation.',
    `original_pay_rate` DECIMAL(18,2) COMMENT 'The pay rate that was in effect before this extension. Used for comparison and rate change analysis.',
    `projected_revenue_impact` DECIMAL(18,2) COMMENT 'Estimated additional revenue generated by this extension. Calculated based on extended duration and bill rate for forecasting purposes.',
    `rate_change_indicator` BOOLEAN COMMENT 'Flag indicating whether the bill rate or pay rate changed as part of this extension. True if either rate differs from the original.',
    `rate_type` STRING COMMENT 'Unit of measure for the bill rate and pay rate (e.g., hourly, daily, weekly). Defines how rates are applied.. Valid values are `hourly|daily|weekly|monthly|annual|per_unit`',
    `requested_by` STRING COMMENT 'Name or identifier of the person who initiated the extension request. May be internal staff or client contact.',
    `sow_reference` STRING COMMENT 'Reference to the specific SOW or project work order that this extension supports. Links extension to project scope and budget.',
    `temp_to_perm_conversion_reset` BOOLEAN COMMENT 'Flag indicating whether this extension resets the temp-to-perm conversion eligibility clock. Important for conversion fee calculation and worker expectations.',
    `vms_extension_code` STRING COMMENT 'External identifier for this extension in the clients VMS platform (e.g., Beeline). Used for system integration and reconciliation.',
    CONSTRAINT pk_order_extension PRIMARY KEY(`order_extension_id`)
) COMMENT 'Tracks assignment extension events for temporary and contract requisitions — one of the most common operational transactions in staffing. Captures extension request date, extension approved date, extension start date, new end date, extension duration in weeks, extended bill rate, extended pay rate, rate change indicator, extension reason (client request, project continuation, backfill pending, budget renewal), extension approval status, approving authority, and whether the extension triggers a temp-to-perm conversion clock reset or benefits eligibility change. Enables extension lifecycle management, revenue forecasting for ongoing assignments, and client billing adjustments for rate changes on extension.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`job_category` (
    `job_category_id` BIGINT COMMENT 'Unique identifier for the job category reference record. Primary key for the job category entity.',
    `parent_category_job_category_id` BIGINT COMMENT 'Reference to a parent job category for hierarchical classification structures, enabling multi-level workforce taxonomy.',
    `parent_job_category_id` BIGINT COMMENT 'Self-referencing FK on job_category (parent_job_category_id)',
    `average_bill_rate` DECIMAL(18,2) COMMENT 'Average bill rate for positions in this category, used for rate card development, client proposals, and margin analysis.',
    `average_pay_rate` DECIMAL(18,2) COMMENT 'Average pay rate for workers in this category, supporting candidate compensation discussions and gross margin planning.',
    `average_ttf_days` STRING COMMENT 'Historical average time to fill positions in this category, used for SLA target setting and client expectation management.',
    `bgc_requirement_level` STRING COMMENT 'Typical background check depth required for this category, aligning with client risk tolerance and regulatory requirements.. Valid values are `none|basic|standard|comprehensive|enhanced`',
    `category_code` STRING COMMENT 'Short alphanumeric code representing the job category for system integration and reporting. Used as a business key for external system references.. Valid values are `^[A-Z0-9]{2,10}$`',
    `category_description` STRING COMMENT 'Detailed description of the job category scope, typical roles included, and classification criteria to guide recruiters and hiring managers in proper categorization.',
    `category_name` STRING COMMENT 'Human-readable name of the job category used in requisitions, candidate matching, and reporting (e.g., Information Technology, Healthcare, Manufacturing, Finance).',
    `category_type` STRING COMMENT 'High-level classification of the category type to segment workforce by skill level and organizational function.. Valid values are `professional|technical|administrative|operational|executive|specialized`',
    `certification_commonly_required` STRING COMMENT 'Professional certifications or licenses commonly required or preferred for this category (e.g., PMP, CPA, RN, CDL), supporting credentialing and compliance workflows.',
    `clearance_level_required` STRING COMMENT 'Typical security clearance level required for positions in this category, relevant for government contracting and defense industry placements.. Valid values are `none|confidential|secret|top_secret`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this job category record was first created in the data platform, supporting audit trail and data lineage.',
    `drug_screen_required` BOOLEAN COMMENT 'Indicates whether drug screening is typically required for positions in this category, common in safety-sensitive roles and regulated industries.',
    `eeoc_job_category` STRING COMMENT 'EEOC EEO-1 reporting category for this job classification, required for federal contractor compliance and diversity reporting. [ENUM-REF-CANDIDATE: executive|professional|technician|sales|administrative|craft|operative|laborer|service — 9 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this job category was retired or deprecated, supporting historical reporting and data lineage.',
    `effective_start_date` DATE COMMENT 'Date when this job category became active and available for use in requisitions and candidate classification.',
    `flsa_classification` STRING COMMENT 'Typical FLSA overtime exemption status for roles in this category, guiding pay rate structures and overtime eligibility.. Valid values are `exempt|non_exempt|varies`',
    `job_category_status` STRING COMMENT 'Current lifecycle status of the job category reference record, controlling availability for new requisition creation.. Valid values are `active|inactive|deprecated|pending_review`',
    `job_family` STRING COMMENT 'Broader occupational grouping or job family that this category belongs to, enabling hierarchical classification and workforce planning analytics.',
    `market_demand_level` STRING COMMENT 'Current labor market demand level for this category based on Staffing Industry Analysts data and internal market intelligence, guiding sourcing strategy and rate negotiations.. Valid values are `low|moderate|high|critical`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this job category record was last updated, supporting change tracking and data quality monitoring.',
    `naics_code` STRING COMMENT 'Industry classification code associated with this job category for industry-specific workforce analytics and market intelligence.. Valid values are `^[0-9]{2,6}$`',
    `onet_code` STRING COMMENT 'O*NET occupational code providing detailed occupational information for skills matching, job analysis, and candidate assessment alignment.. Valid values are `^[0-9]{2}-[0-9]{4}.[0-9]{2}$`',
    `physical_demands_level` STRING COMMENT 'Typical physical demand classification for roles in this category per DOL standards, relevant for ADA compliance and workers compensation classification.. Valid values are `sedentary|light|medium|heavy|very_heavy`',
    `prevailing_wage_applicable` BOOLEAN COMMENT 'Indicates whether prevailing wage determinations typically apply to this category for government contracts and Davis-Bacon Act compliance.',
    `rate_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for average rates (e.g., USD, CAD, GBP), supporting multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `rate_unit` STRING COMMENT 'Unit of measure for average bill and pay rates, aligning with industry billing practices for this category.. Valid values are `hourly|daily|weekly|monthly|annual|per_project`',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether positions in this category are typically eligible for remote or hybrid work arrangements, supporting modern workforce planning.',
    `skill_level` STRING COMMENT 'Typical skill or experience level associated with roles in this category, used for candidate matching and rate card alignment.. Valid values are `entry|intermediate|advanced|expert|executive`',
    `soc_code` STRING COMMENT 'U.S. Department of Labor Standard Occupational Classification code for federal reporting, labor market analysis, and compliance with OFCCP requirements.. Valid values are `^[0-9]{2}-[0-9]{4}$`',
    `sort_order` STRING COMMENT 'Display sequence number for presenting job categories in user interfaces and reports, supporting consistent user experience.',
    `supplier_diversity_eligible` BOOLEAN COMMENT 'Indicates whether this category is typically included in supplier diversity programs and MSP diversity spend tracking.',
    `travel_requirement_typical` STRING COMMENT 'Typical travel expectation for roles in this category, informing candidate expectations and per diem eligibility.. Valid values are `none|minimal|moderate|frequent|extensive`',
    `typical_education_level` STRING COMMENT 'Standard education level typically required for positions in this category, guiding candidate qualification assessments. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|professional|certification|none — 8 candidates stripped; promote to reference product]',
    `typical_employment_type` STRING COMMENT 'Most common employment classification for roles in this category, guiding recruiters on typical engagement models and client expectations.. Valid values are `temporary|contract|contract_to_hire|temp_to_perm|direct_hire|permanent`',
    `typical_markup_percentage` DECIMAL(18,2) COMMENT 'Average markup percentage (bill rate minus pay rate divided by pay rate) for this category, used for pricing strategy and margin target setting.',
    `typical_min_experience_years` STRING COMMENT 'Standard minimum years of experience expected for roles in this category, used as a baseline for requisition creation and candidate screening.',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether positions in this category are typically eligible for union representation, affecting placement terms and labor relations.',
    `vms_category_mapping` STRING COMMENT 'Standard category code or name used in major VMS platforms (Beeline, Fieldglass, etc.) for integration and order distribution.',
    `worker_classification` STRING COMMENT 'Typical worker classification for this category under IRS and DOL guidelines, critical for payroll processing, tax compliance, and co-employment risk management.. Valid values are `w2|1099|ic|employee|contractor`',
    `workers_comp_class_code` STRING COMMENT 'Standard workers compensation classification code for this category, determining insurance premium rates and burden cost calculations.. Valid values are `^[0-9]{4,6}$`',
    CONSTRAINT pk_job_category PRIMARY KEY(`job_category_id`)
) COMMENT 'Reference entity defining standardized job categories, job families, and occupational classifications (SOC codes, O*NET) used to classify requisitions and match candidates';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` (
    `joborder_approval_workflow_id` BIGINT COMMENT 'Unique identifier for the job order approval workflow record. Primary key for tracking approval chain instances.',
    `order_header_id` BIGINT COMMENT 'Foreign key reference to the job order requisition being approved. Links this approval workflow to the specific job order header.',
    `staff_profile_id` BIGINT COMMENT 'Identifier of the individual or system user responsible for this approval step. May reference internal employee or client contact depending on approver_type.',
    `tertiary_joborder_escalated_to_staff_profile_id` BIGINT COMMENT 'Identifier of the higher-level approver to whom this approval was escalated. Tracks the escalation chain for audit and accountability.',
    `resubmitted_joborder_approval_workflow_id` BIGINT COMMENT 'Self-referencing FK on joborder_approval_workflow (resubmitted_joborder_approval_workflow_id)',
    `approval_comments` STRING COMMENT 'Free-text comments or notes provided by the approver explaining their decision, conditions, or concerns. Critical for audit trail and communication.',
    `approval_decision` STRING COMMENT 'The final decision rendered by the approver at this stage. Determines whether the workflow proceeds to the next stage or is halted.. Valid values are `approved|rejected|conditionally_approved|deferred|withdrawn`',
    `approval_decision_timestamp` TIMESTAMP COMMENT 'Date and time when the approver made their decision (approved, rejected, or conditionally approved). Used to calculate approval turnaround time.',
    `approval_method` STRING COMMENT 'The channel or interface through which the approver submitted their decision. Tracks user experience and system adoption patterns.. Valid values are `web_portal|email|mobile_app|vms_platform|phone|in_person`',
    `approval_request_timestamp` TIMESTAMP COMMENT 'Date and time when the approval request was submitted to this approver. Marks the start of the approval window for SLA tracking.',
    `approval_sequence_number` STRING COMMENT 'Sequential order of this approval step within the overall approval chain. Determines the routing order for multi-level approvals.',
    `approval_stage` STRING COMMENT 'The stage or level of approval within the workflow. Identifies which organizational function or authority level is reviewing the job order. [ENUM-REF-CANDIDATE: intake|recruiter_review|account_manager_review|operations_manager_review|finance_review|compliance_review|client_approval|final_approval — 8 candidates stripped; promote to reference product]',
    `approval_status` STRING COMMENT 'Current status of this approval step. Tracks the lifecycle state of the approval decision at this stage. [ENUM-REF-CANDIDATE: pending|in_review|approved|rejected|conditionally_approved|withdrawn|escalated|expired — 8 candidates stripped; promote to reference product]',
    `approval_turnaround_hours` DECIMAL(18,2) COMMENT 'Elapsed time in hours between approval request and decision. Key performance indicator for approval process efficiency and SLA compliance.',
    `approval_type` STRING COMMENT 'The type of approval being requested. Distinguishes between new job order approvals and changes to existing orders.. Valid values are `new_order|modification|extension|rate_change|headcount_increase|cancellation`',
    `approver_email` STRING COMMENT 'Email address of the approver. Used for notification delivery and audit trail documentation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `approver_name` STRING COMMENT 'Full name of the person responsible for approval at this stage. Captured for audit trail and reporting purposes.',
    `approver_role` STRING COMMENT 'Job title or functional role of the approver at the time of approval. Examples include Account Manager, Operations Director, Client Hiring Manager, VMS Program Manager.',
    `approver_type` STRING COMMENT 'Classification of the approver. Distinguishes between internal staffing company approvers and external client or program approvers.. Valid values are `internal|client|vms|msp`',
    `auto_approval_flag` BOOLEAN COMMENT 'Indicator of whether this approval was automatically granted by system rules without human intervention. True for pre-approved rate cards or standing authorizations.',
    `auto_approval_rule_code` BIGINT COMMENT 'Identifier of the business rule that triggered automatic approval. Links to rule configuration for audit and rule effectiveness analysis.',
    `client_approval_reference` STRING COMMENT 'Client-provided reference number or confirmation code for their approval. Used for client billing, dispute resolution, and audit trail.',
    `conditional_approval_requirements` STRING COMMENT 'Specific conditions or requirements that must be met before final approval is granted. Examples include rate adjustments, additional documentation, or client confirmation.',
    `conditions_met_flag` BOOLEAN COMMENT 'Indicator of whether all conditional approval requirements have been satisfied. True allows the workflow to proceed; false keeps it in pending state.',
    `conditions_met_timestamp` TIMESTAMP COMMENT 'Date and time when all conditional approval requirements were satisfied. Marks the transition from conditional to full approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was first created in the system. Establishes the audit trail baseline.',
    `delegate_approver_name` STRING COMMENT 'Full name of the delegate approver if delegation occurred. Maintains audit trail of actual decision maker.',
    `device_type` STRING COMMENT 'Type of device used to submit the approval decision. Provides insight into mobile vs desktop usage patterns for workflow optimization.. Valid values are `desktop|laptop|tablet|mobile|other`',
    `escalated_to_name` STRING COMMENT 'Full name of the escalation recipient. Provides visibility into management involvement in approval decisions.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator of whether this approval was escalated to a higher authority due to SLA breach, complexity, or policy exception. True triggers management visibility.',
    `escalation_reason` STRING COMMENT 'Explanation of why the approval was escalated. Common reasons include SLA breach, rate exception, policy override request, or approver unavailability.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the approval was escalated. Used to track escalation frequency and timing for process improvement.',
    `ip_address` STRING COMMENT 'IP address from which the approval decision was submitted. Captured for security audit and fraud prevention purposes.',
    `last_reminder_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent reminder notification sent to the approver. Used to manage reminder frequency and escalation timing.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was last updated. Tracks changes to approval status, comments, or workflow routing.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicator of whether the approval request notification was successfully sent to the approver. Used for troubleshooting communication failures.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the approval notification was sent to the approver. Establishes the start of the approvers response window.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for rejection. Enables categorization and trend analysis of approval failures. [ENUM-REF-CANDIDATE: budget_constraint|rate_too_high|headcount_freeze|insufficient_justification|compliance_issue|duplicate_order|client_declined|other — 8 candidates stripped; promote to reference product]',
    `rejection_reason_notes` STRING COMMENT 'Detailed explanation of the rejection reason. Provides context beyond the standardized rejection code for remediation and learning.',
    `reminder_count` STRING COMMENT 'Number of reminder notifications sent to the approver for this pending approval. Tracks follow-up activity and approver responsiveness.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether the approval exceeded the SLA target hours. True indicates a breach requiring escalation or management review.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target turnaround time in hours for this approval stage as defined by internal SLA or client agreement. Used to measure approval process performance.',
    `vms_approval_code` STRING COMMENT 'External approval identifier from the client VMS platform. Links internal approval workflow to client system for reconciliation and audit.',
    CONSTRAINT pk_joborder_approval_workflow PRIMARY KEY(`joborder_approval_workflow_id`)
) COMMENT 'Tracks the internal and client-side approval chain for new job orders and requisition modifications, capturing approver, approval date, status, and comments';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique identifier for the headcount plan record. Primary key for strategic workforce planning master data.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Headcount plans are period-based budgets requiring accounting period linkage for budget-to-actual variance reporting, financial forecasting, and board reporting—core to staffing program financial plan',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for which this headcount plan is defined. Links to the client master data.',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Headcount plans are authorized under MSAs and must stay within contractual capacity limits. Linking enables MSA-level capacity tracking, budget burn-down reporting, ensures planned hiring aligns with ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Headcount plans are budget-driven and must link to cost centers for financial planning, budget consumption tracking, variance analysis, and client billing forecasts—core to staffing program financial ',
    `job_category_id` BIGINT COMMENT 'Reference to the job category or job family for which headcount is being planned. Links to job classification master data.',
    `managed_program_id` BIGINT COMMENT 'Reference to the specific client program or engagement under which this headcount plan operates. Links to VMS or MSP program structures.',
    `rate_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.rate_agreement. Business justification: Headcount plans budget using negotiated rate agreements. Budget accuracy, rate validation, and financial forecasting require direct link to the rate agreement governing planned positions.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SOWs often specify headcount allocations by job category and period. Linking enables SOW-level capacity planning, burn-down tracking against contracted headcount, ensures planned hiring stays within S',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Headcount plans often designate preferred/allocated suppliers for specific categories or programs. Capacity planning, supplier allocation decisions, and budget forecasting require direct supplier desi',
    `revised_headcount_plan_id` BIGINT COMMENT 'Self-referencing FK on headcount_plan (revised_headcount_plan_id)',
    `approval_date` DATE COMMENT 'The date on which this headcount plan was approved. Marks the transition from planning to execution phase.',
    `approval_status` STRING COMMENT 'The approval status of this headcount plan. Tracks whether the plan has received necessary client and internal approvals.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name of the individual who approved this headcount plan. Provides accountability for planning decisions.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The total budget allocated for this headcount plan. Represents the financial envelope for workforce costs.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this headcount plan.. Valid values are `^[A-Z]{3}$`',
    `current_filled_headcount` STRING COMMENT 'The current number of FTE positions that have been filled and are actively working. Real-time fulfillment metric.',
    `employment_type` STRING COMMENT 'The type of employment relationship planned for this headcount. Determines placement strategy and fulfillment approach.. Valid values are `temporary|contract|contract_to_hire|temp_to_perm|direct_hire|permanent`',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this headcount plan is defined. Used for annual planning and budget alignment.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The percentage of full-time work represented by each position in this plan. Used for part-time or fractional FTE planning.',
    `hours_per_week` DECIMAL(18,2) COMMENT 'The expected number of hours per week for positions under this headcount plan. Used for FTE calculations and scheduling.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this headcount plan is currently active and in use. Used for filtering active planning records.',
    `job_title` STRING COMMENT 'The specific job title or role for which headcount is planned. May be more granular than job category.',
    `maximum_headcount` STRING COMMENT 'The maximum allowable number of FTE positions under this plan. Ceiling threshold based on budget or client constraints.',
    `minimum_headcount` STRING COMMENT 'The minimum acceptable number of FTE positions required to meet operational commitments. Floor threshold for workforce planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this headcount plan record was last modified. Audit trail for record updates.',
    `msa_reference` STRING COMMENT 'Reference to the Master Service Agreement governing this headcount plan. Links to contract terms and conditions.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special instructions, or planning assumptions related to this headcount plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the headcount plan, typically indicating the client program, fiscal period, or strategic initiative.',
    `plan_number` STRING COMMENT 'Business identifier for the headcount plan. Human-readable unique code used for tracking and reporting purposes.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the headcount plan. Tracks progression from draft through approval to active execution and eventual closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the headcount plan based on planning horizon and purpose. Determines planning cycle and refresh frequency.. Valid values are `annual|quarterly|monthly|project_based|evergreen|seasonal`',
    `planning_period_end_date` DATE COMMENT 'The end date of the planning period covered by this headcount plan. Defines the conclusion of the workforce planning horizon.',
    `planning_period_start_date` DATE COMMENT 'The start date of the planning period covered by this headcount plan. Defines the beginning of the workforce planning horizon.',
    `priority_level` STRING COMMENT 'The business priority assigned to fulfilling this headcount plan. Determines resource allocation and recruiter focus.. Valid values are `critical|high|medium|low`',
    `rate_type` STRING COMMENT 'The unit of time for which bill and pay rates are expressed. Determines rate calculation methodology.. Valid values are `hourly|daily|weekly|monthly|annual|per_diem`',
    `remaining_headcount` STRING COMMENT 'The number of FTE positions still to be filled to meet the target headcount. Calculated as target minus current filled.',
    `shift_type` STRING COMMENT 'The shift schedule for positions under this headcount plan. Impacts candidate availability and pay rate considerations.. Valid values are `day|evening|night|rotating|weekend|flexible`',
    `supplier_diversity_requirement` STRING COMMENT 'Indicates whether supplier diversity goals apply to this headcount plan. Supports client diversity and inclusion commitments.. Valid values are `required|preferred|not_applicable`',
    `target_bill_rate` DECIMAL(18,2) COMMENT 'The planned bill rate to be charged to the client for positions under this headcount plan. Used for revenue forecasting.',
    `target_gross_margin_percentage` DECIMAL(18,2) COMMENT 'The planned gross margin percentage (bill rate minus pay rate divided by bill rate) for this headcount plan. Alternative profitability metric.',
    `target_headcount` STRING COMMENT 'The planned number of Full-Time Equivalent (FTE) positions to be filled under this headcount plan. Primary planning metric.',
    `target_markup_percentage` DECIMAL(18,2) COMMENT 'The planned markup percentage (bill rate minus pay rate divided by pay rate) for this headcount plan. Key profitability metric.',
    `target_pay_rate` DECIMAL(18,2) COMMENT 'The planned pay rate to be paid to workers for positions under this headcount plan. Used for cost forecasting.',
    `work_location_type` STRING COMMENT 'The primary work location arrangement for positions under this headcount plan. Impacts sourcing and candidate requirements.. Valid values are `onsite|remote|hybrid|client_site|office`',
    `worker_classification` STRING COMMENT 'Tax and legal classification of workers planned under this headcount. Critical for compliance with IRS worker classification rules.. Valid values are `w2|1099|ic|employee|contractor`',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Strategic headcount planning master record capturing FTE targets, headcount budgets, and workforce mix ratios for client programs and job categories';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` (
    `demand_forecast_id` BIGINT COMMENT 'Unique identifier for the demand forecast record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Demand forecasts drive revenue projections and must align with accounting periods for financial planning, board reporting, and guidance—essential for matching operational forecasts to financial report',
    `client_account_id` BIGINT COMMENT 'Identifier of the client account for which demand is being forecasted. Links to the client master data.',
    `job_category_id` BIGINT COMMENT 'Identifier of the job category or job family for which demand is forecasted. Used to segment demand by skill type and role classification.',
    `managed_program_id` BIGINT COMMENT 'Identifier of the specific client program or Vendor Management System (VMS) program driving the forecasted demand.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Demand forecasts may allocate anticipated demand to specific suppliers for capacity planning. Supplier capacity reservation, pipeline planning, and allocation modeling require supplier-specific demand',
    `revised_demand_forecast_id` BIGINT COMMENT 'Self-referencing FK on demand_forecast (revised_demand_forecast_id)',
    `average_bill_rate` DECIMAL(18,2) COMMENT 'Average bill rate per hour or unit for the forecasted roles. Used for revenue projection and financial planning.',
    `average_pay_rate` DECIMAL(18,2) COMMENT 'Average pay rate per hour or unit for the forecasted roles. Used for cost projection and margin analysis.',
    `average_ttf_days` STRING COMMENT 'Average Time to Fill (TTF) in days for roles in this skill category, based on historical data. Used for capacity planning and SLA (Service Level Agreement) setting.',
    `baseline_headcount` DECIMAL(18,2) COMMENT 'Current or baseline headcount at the time the forecast was created. Provides a reference point for measuring forecasted growth or contraction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `data_source` STRING COMMENT 'Source system or data origin for the forecast (e.g., VMS, ATS, client input, analytics platform). Documents data lineage for quality and audit purposes.',
    `demand_variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between forecasted demand and baseline demand. Positive values indicate growth, negative values indicate contraction.',
    `employment_type` STRING COMMENT 'Type of employment for the forecasted demand (temporary, temp-to-perm, contract, contract-to-hire, direct hire, permanent). Aligns forecast with placement strategy.. Valid values are `temporary|temp_to_perm|contract|contract_to_hire|direct_hire|permanent`',
    `forecast_approved_by` STRING COMMENT 'Name or identifier of the user or role who approved the forecast. Provides accountability and audit trail for forecast governance.',
    `forecast_approved_date` DATE COMMENT 'Date when the forecast was approved for operational use. Marks the transition from draft to active status.',
    `forecast_confidence_level` STRING COMMENT 'Confidence level in the accuracy of the forecast (high, medium, low). Reflects data quality, historical accuracy, and market volatility considerations.. Valid values are `high|medium|low`',
    `forecast_created_date` DATE COMMENT 'Date when the forecast record was created. Distinct from the forecast period; tracks when the forecast itself was generated.',
    `forecast_granularity` STRING COMMENT 'Time granularity of the forecast period (daily, weekly, monthly, quarterly, annual). Indicates the level of temporal detail in the forecast.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `forecast_method` STRING COMMENT 'Methodology used to generate the forecast (historical trend analysis, client input, statistical model, machine learning, hybrid, manual). Documents the forecasting approach for audit and refinement.. Valid values are `historical_trend|client_input|statistical_model|machine_learning|hybrid|manual`',
    `forecast_notes` STRING COMMENT 'Free-text notes or commentary about the forecast, including assumptions, risks, and contextual information. Supports forecast interpretation and decision-making.',
    `forecast_number` STRING COMMENT 'Business-facing unique identifier for the demand forecast, used for tracking and reference in planning discussions and reports.',
    `forecast_period_end_date` DATE COMMENT 'End date of the time period for which this demand forecast applies. Defines the conclusion of the forecasted demand window.',
    `forecast_period_start_date` DATE COMMENT 'Start date of the time period for which this demand forecast applies. Defines the beginning of the forecasted demand window.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast record (draft, approved, active, archived, superseded). Tracks the operational state of the forecast.. Valid values are `draft|approved|active|archived|superseded`',
    `forecast_version` STRING COMMENT 'Version number of the forecast. Incremented when forecasts are revised or updated, enabling historical comparison and trend analysis.',
    `forecasted_fte` DECIMAL(18,2) COMMENT 'Projected demand expressed as Full-Time Equivalents (FTE), normalizing part-time and full-time roles into a standard measure. Used for capacity planning.',
    `forecasted_headcount` DECIMAL(18,2) COMMENT 'Projected number of workers or Full-Time Equivalents (FTE) needed for this skill category and time period. Core demand metric for workforce planning.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the forecast record is currently active and in use for operational planning. False indicates archived or superseded forecasts.',
    `market_demand_indicator` STRING COMMENT 'Qualitative assessment of market demand for the skill category (very high, high, moderate, low, very low). Reflects labor market tightness and talent availability.. Valid values are `very_high|high|moderate|low|very_low`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast record was last modified. Audit field for tracking updates and changes to the forecast.',
    `projected_cost` DECIMAL(18,2) COMMENT 'Total projected cost for the forecasted demand period, including pay rates, burden, and overhead. Used for margin and profitability analysis.',
    `projected_gross_margin` DECIMAL(18,2) COMMENT 'Projected gross margin (revenue minus cost) for the forecasted demand period. Core profitability metric for business planning.',
    `projected_revenue` DECIMAL(18,2) COMMENT 'Total projected revenue for the forecasted demand period, calculated from forecasted headcount and average bill rates. Key metric for financial planning.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for bill and pay rates (e.g., USD, CAD, GBP). Ensures consistent financial reporting across geographies.. Valid values are `^[A-Z]{3}$`',
    `rate_unit` STRING COMMENT 'Unit of measure for bill and pay rates (hourly, daily, weekly, monthly, annual, per unit). Defines the time or output basis for rate calculations.. Valid values are `hourly|daily|weekly|monthly|annual|per_unit`',
    `shift_type` STRING COMMENT 'Shift type or schedule pattern for the forecasted roles (day, evening, night, rotating, weekend, flexible). Used for scheduling and labor planning.. Valid values are `day|evening|night|rotating|weekend|flexible`',
    `skill_category` STRING COMMENT 'High-level skill category or competency area for the forecasted demand (e.g., IT, Healthcare, Engineering, Administrative). Used for workforce planning segmentation.',
    `talent_availability_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing the availability of qualified talent in the market for this skill category. Higher scores indicate greater talent supply.',
    `work_location_type` STRING COMMENT 'Work location modality for the forecasted demand (onsite, remote, hybrid). Reflects evolving workforce location preferences and client requirements.. Valid values are `onsite|remote|hybrid`',
    `worker_classification` STRING COMMENT 'Worker classification for the forecasted roles (W-2 employee, 1099 independent contractor, employee). Critical for compliance and cost modeling.. Valid values are `W2|1099|independent_contractor|employee`',
    CONSTRAINT pk_demand_forecast PRIMARY KEY(`demand_forecast_id`)
) COMMENT 'Time-series labor demand forecast records capturing projected worker demand by skill category, job family, client program, and time period';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Unique identifier for the workforce capacity plan record. Primary key for the capacity plan entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Capacity plans support financial forecasting and must map to accounting periods for resource cost planning, margin analysis, and revenue capacity modeling—critical for financial planning and investor ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capacity planning requires cost center linkage for resource cost modeling, profitability forecasting by service line, and internal labor allocation—essential for staffing firm financial planning and m',
    `headcount_plan_id` BIGINT COMMENT 'Foreign key linking to joborder.headcount_plan. Business justification: Capacity planning is the operational execution layer of strategic headcount planning. capacity_plan defines available worker capacity by skill pool and geography to fulfill demand, while headcount_pla',
    `job_category_id` BIGINT COMMENT 'Reference to the standardized job category classification that this capacity plan is aligned with for skill and role taxonomy.',
    `managed_program_id` BIGINT COMMENT 'Reference to the specific client program or Vendor Management System (VMS) program this capacity plan supports, if applicable.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the workforce planning manager or account manager responsible for creating and maintaining this capacity plan.',
    `program_allocation_id` BIGINT COMMENT 'Foreign key linking to vendor.program_allocation. Business justification: Capacity plans reference supplier program allocation rules (max fill %, priority rank). Capacity modeling, allocation cap enforcement, and supplier utilization tracking require direct allocation rule ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Capacity plans track supplier bench strength and available pipeline. Workforce planning, demand-supply matching, and supplier capacity utilization reporting require knowing which supplier holds the fo',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS program for which this capacity is planned, enabling alignment with Managed Service Provider (MSP) and VMS demand forecasting.',
    `revised_capacity_plan_id` BIGINT COMMENT 'Self-referencing FK on capacity_plan (revised_capacity_plan_id)',
    `approval_date` DATE COMMENT 'Date when this capacity plan was formally approved and authorized for operational use.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this capacity plan requires formal approval before activation (True) or can be activated without approval workflow (False).',
    `available_capacity_fte` DECIMAL(18,2) COMMENT 'Total available worker capacity expressed in Full-Time Equivalents (FTE) for the skill pool, geography, and time period defined in this plan.',
    `available_capacity_headcount` STRING COMMENT 'Total number of individual workers available in the capacity pool, regardless of full-time or part-time status.',
    `average_bill_rate` DECIMAL(18,2) COMMENT 'Average hourly or daily bill rate for workers in this capacity pool, used for revenue forecasting and pricing strategy.',
    `average_markup_percentage` DECIMAL(18,2) COMMENT 'Average markup percentage (bill rate minus pay rate, divided by pay rate) for this capacity pool, indicating profitability and pricing strategy.',
    `average_pay_rate` DECIMAL(18,2) COMMENT 'Average hourly or daily pay rate for workers in this capacity pool, used for cost planning and margin analysis.',
    `bench_capacity_fte` DECIMAL(18,2) COMMENT 'Number of unassigned workers currently on the bench (not placed but available for immediate deployment), expressed in FTE.',
    `capacity_gap_fte` DECIMAL(18,2) COMMENT 'Difference between forecasted demand and available capacity, expressed in FTE. Positive values indicate surplus capacity; negative values indicate capacity shortfall requiring sourcing or redeployment.',
    `capacity_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of total available capacity that is currently committed or deployed, calculated as (committed capacity / available capacity) * 100.',
    `committed_capacity_fte` DECIMAL(18,2) COMMENT 'Capacity already committed or allocated to active job orders and placements, expressed in FTE, reducing available capacity for new demand.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the primary country for this capacity plan (e.g., USA, CAN, GBR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity plan record was first created in the system, used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this capacity plan (e.g., USD, CAD, GBP, EUR).',
    `forecasted_demand_fte` DECIMAL(18,2) COMMENT 'Projected client demand for this skill pool and time period based on historical trends, pipeline analysis, and client forecasts, expressed in FTE.',
    `geography_type` STRING COMMENT 'Geographic scope or location model for the capacity plan indicating the physical or virtual work location strategy. [ENUM-REF-CANDIDATE: national|regional|state|metro|local|remote|hybrid — 7 candidates stripped; promote to reference product]',
    `labor_category` STRING COMMENT 'Broad labor classification or occupational group (e.g., IT Professional, Healthcare Clinical, Administrative Support, Skilled Trades) used for workforce segmentation and capacity planning.',
    `metro_area` STRING COMMENT 'Metropolitan statistical area (MSA) or city/region name for localized capacity planning and labor market analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity plan record was last modified, used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes, comments, or additional context about this capacity plan, including assumptions, constraints, or special considerations.',
    `onet_code` STRING COMMENT 'O*NET occupational code providing detailed occupational information and skill requirements for workforce planning and talent matching.',
    `plan_name` STRING COMMENT 'Descriptive name of the capacity plan identifying the scope, purpose, or target segment (e.g., Q1 2024 IT Staffing Capacity, Healthcare RN Pool - West Region).',
    `plan_number` STRING COMMENT 'Business-facing unique identifier or reference number for the capacity plan, used for tracking and communication purposes.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the capacity plan indicating its operational state and approval stage. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the capacity plan by planning horizon and purpose: strategic (long-term workforce strategy), tactical (medium-term resource allocation), operational (short-term fulfillment), contingency (backup capacity), seasonal (cyclical demand), or project-based (specific engagement).. Valid values are `strategic|tactical|operational|contingency|seasonal|project_based`',
    `planning_horizon_weeks` STRING COMMENT 'Duration of the capacity planning period expressed in weeks, used for short to medium-term planning cycles.',
    `planning_period_end_date` DATE COMMENT 'End date of the time period covered by this capacity plan, defining the conclusion of the planning horizon.',
    `planning_period_start_date` DATE COMMENT 'Start date of the time period covered by this capacity plan, defining the beginning of the planning horizon.',
    `rate_type` STRING COMMENT 'Unit of measure for bill and pay rates in this capacity plan (hourly, daily, weekly, monthly, annual, or project-based).. Valid values are `hourly|daily|weekly|monthly|annual|project`',
    `redeployment_capacity_fte` DECIMAL(18,2) COMMENT 'Capacity available through redeployment of workers from ending assignments or other skill pools, expressed in FTE.',
    `skill_pool_name` STRING COMMENT 'Name of the skill pool or labor category this capacity plan covers (e.g., Java Developers, Registered Nurses, Warehouse Associates, Financial Analysts).',
    `soc_code` STRING COMMENT 'U.S. Department of Labor Standard Occupational Classification code identifying the occupation type for labor market alignment and regulatory reporting.',
    `sourcing_pipeline_fte` DECIMAL(18,2) COMMENT 'Projected capacity from active sourcing and recruitment efforts expected to be available during the planning period, expressed in FTE.',
    `state_province` STRING COMMENT 'State or province where the capacity is planned, relevant for regional workforce planning and compliance with state-specific labor regulations.',
    `target_utilization_percentage` DECIMAL(18,2) COMMENT 'Desired or optimal capacity utilization rate for this skill pool and planning period, used as a performance target for workforce planning.',
    `uncommitted_capacity_fte` DECIMAL(18,2) COMMENT 'Remaining unallocated capacity available for new job order fulfillment, calculated as available capacity minus committed capacity, expressed in FTE.',
    CONSTRAINT pk_capacity_plan PRIMARY KEY(`capacity_plan_id`)
) COMMENT 'Workforce supply capacity plan defining available worker capacity by skill pool, labor category, geography, and time period for fulfillment planning';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` (
    `fte_actuals_id` BIGINT COMMENT 'Unique identifier for the FTE actuals snapshot record. Primary key for the FTE actuals data product.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: FTE actuals are the basis for period revenue recognition and must be period-stamped for financial close, revenue cutoff, and reporting—fundamental to accrual accounting and period-end revenue recognit',
    `client_account_id` BIGINT COMMENT 'Identifier of the client organization for which FTE actuals are being tracked.',
    `location_id` BIGINT COMMENT 'Identifier of the primary client location or site where workers in this segment are assigned. Enables geographic and site-level analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: FTE actuals drive revenue recognition and must map to cost centers for accurate P&L reporting, client billing reconciliation, and budget-to-actual variance analysis—fundamental to staffing operations ',
    `headcount_plan_id` BIGINT COMMENT 'Foreign key linking to joborder.headcount_plan. Business justification: fte_actuals captures periodic snapshots of actual FTE counts and compares them to planned FTE (see fte_actuals.planned_fte, fte_variance, fte_variance_percentage). The planned_fte value should be sour',
    `job_category_id` BIGINT COMMENT 'Identifier of the job category or labor category for which FTE actuals are being tracked. Enables analysis by skill type and role classification.',
    `managed_program_id` BIGINT COMMENT 'Identifier of the specific client program or engagement under which the FTE actuals are measured. Programs represent distinct workforce management arrangements within a client relationship.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: FTE actuals track which supplier provided each worker. Supplier spend analysis, performance reporting, diversity spend tracking, and invoice reconciliation require knowing supplier attribution for act',
    `vms_program_id` BIGINT COMMENT 'Identifier of the VMS program if this client engagement is managed through a vendor management system. Links FTE actuals to VMS program configuration and rate cards.',
    `prior_fte_actuals_id` BIGINT COMMENT 'Self-referencing FK on fte_actuals (prior_fte_actuals_id)',
    `actual_fte` DECIMAL(18,2) COMMENT 'The actual FTE count calculated based on hours worked relative to a standard full-time schedule. Normalizes part-time and variable-hour workers to a full-time equivalent basis for capacity planning and variance analysis.',
    `actual_headcount` DECIMAL(18,2) COMMENT 'The actual number of individual workers (headcount) active in this client program, job category, and workforce mix type at the snapshot date. Represents raw person count regardless of hours worked.',
    `attrition_rate` DECIMAL(18,2) COMMENT 'The attrition rate for this segment during the snapshot period, calculated as terminations / average headcount * 100. Key metric for workforce stability and retention program effectiveness.',
    `average_bill_rate` DECIMAL(18,2) COMMENT 'The weighted average bill rate charged to the client for workers in this segment during the snapshot period. Used for revenue forecasting and rate analysis.',
    `average_markup_percentage` DECIMAL(18,2) COMMENT 'The weighted average markup percentage for workers in this segment. Calculated as (bill rate - pay rate) / pay rate * 100. Key profitability metric.',
    `average_pay_rate` DECIMAL(18,2) COMMENT 'The weighted average pay rate paid to workers in this segment during the snapshot period. Used for cost analysis and margin calculation.',
    `average_spread` DECIMAL(18,2) COMMENT 'The weighted average spread (bill rate minus pay rate) for workers in this segment. Represents gross margin per hour before burden costs.',
    `bench_count` DECIMAL(18,2) COMMENT 'The number of workers (headcount or FTE) who are on the staffing firms payroll but not currently assigned to a billable client engagement. Key metric for capacity planning and redeployment.',
    `billable_hours` DECIMAL(18,2) COMMENT 'The total number of hours that are billable to the client during the snapshot period. May differ from total hours worked if certain hours are non-billable (training, bench time, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this FTE actuals record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary values in this record (USD, EUR, GBP, CAD, etc.).. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The source system or process that generated this FTE actuals snapshot (e.g., Kronos Workforce Ready, TempWorks Payroll, manual calculation). Used for data lineage and quality assessment.',
    `department_name` STRING COMMENT 'The name of the client department or business unit to which these FTE actuals are allocated. Enables organizational analysis.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'The total number of double-time hours worked during the snapshot period. Typically hours worked on holidays or beyond daily/weekly overtime thresholds per contract terms.',
    `fte_variance` DECIMAL(18,2) COMMENT 'The difference between actual FTE and planned FTE (actual minus planned). Positive values indicate overstaffing; negative values indicate understaffing relative to plan.',
    `fte_variance_percentage` DECIMAL(18,2) COMMENT 'The FTE variance expressed as a percentage of planned FTE. Calculated as (actual FTE - planned FTE) / planned FTE * 100. Enables normalized comparison across programs of different sizes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this FTE actuals record was last modified. Used for audit trail and change tracking.',
    `new_hire_count` DECIMAL(18,2) COMMENT 'The number of new workers hired and onboarded into this segment during the snapshot period. Used for recruitment velocity and onboarding capacity analysis.',
    `non_billable_hours` DECIMAL(18,2) COMMENT 'The total number of hours worked that are not billable to the client (training, administrative time, bench time, paid time off). Used for utilization analysis.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'The total number of overtime hours worked during the snapshot period. Typically hours worked beyond 40 hours per week or 8 hours per day, depending on jurisdiction and contract terms.',
    `planned_fte` DECIMAL(18,2) COMMENT 'The planned or target FTE count for this client program, job category, and workforce mix type as of the snapshot date. Used for variance analysis against actual FTE.',
    `projected_cost` DECIMAL(18,2) COMMENT 'The projected cost (payroll and burden) for this segment based on actual FTE, average pay rate, burden rate, and expected hours. Used for cost forecasting and margin analysis.',
    `projected_gross_margin` DECIMAL(18,2) COMMENT 'The projected gross margin (revenue minus cost) for this segment. Key profitability metric for program and portfolio management.',
    `projected_revenue` DECIMAL(18,2) COMMENT 'The projected revenue for this segment based on actual FTE, average bill rate, and expected hours. Used for financial forecasting and variance analysis.',
    `redeployment_count` DECIMAL(18,2) COMMENT 'The number of workers who were redeployed from bench or another assignment to this client program during the snapshot period. Measures internal mobility and talent optimization.',
    `regular_hours` DECIMAL(18,2) COMMENT 'The total number of regular (non-overtime) hours worked during the snapshot period. Excludes overtime and double-time hours.',
    `shift_type` STRING COMMENT 'The primary shift schedule for workers in this segment (first shift, second shift, third shift, rotating, weekend, on-call). Used for scheduling and premium pay analysis.. Valid values are `first_shift|second_shift|third_shift|rotating|weekend|on_call`',
    `snapshot_date` DATE COMMENT 'The date on which this FTE actuals snapshot was taken. Represents the point-in-time measurement of actual headcount and FTE values.',
    `snapshot_period_type` STRING COMMENT 'The granularity or frequency of the FTE actuals snapshot measurement (daily, weekly, monthly, quarterly, annual).. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `snapshot_status` STRING COMMENT 'The status of this FTE actuals snapshot (draft, preliminary, final, revised). Indicates whether the data is still being validated or is approved for reporting.. Valid values are `draft|preliminary|final|revised`',
    `termination_count` DECIMAL(18,2) COMMENT 'The number of workers who terminated or completed their assignments in this segment during the snapshot period. Used for attrition and retention analysis.',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'The total number of hours worked by all workers in this segment during the snapshot period. Used to calculate actual FTE and for billing and payroll validation.',
    `union_status` STRING COMMENT 'Indicates whether workers in this segment are covered by a union collective bargaining agreement (union, non-union, mixed). Critical for labor relations and compliance.. Valid values are `union|non_union|mixed`',
    `utilization_rate` DECIMAL(18,2) COMMENT 'The percentage of total hours worked that are billable to clients. Calculated as billable hours / total hours worked * 100. Key performance indicator for staffing firm profitability.',
    `work_location_type` STRING COMMENT 'The primary work location arrangement for workers in this segment (onsite at client location, remote, hybrid). Used for workforce planning and real estate analysis.. Valid values are `onsite|remote|hybrid`',
    `worker_classification` STRING COMMENT 'The tax and legal classification of workers included in this FTE count (W-2 employee, 1099 independent contractor). Critical for compliance and payroll tax reporting.. Valid values are `w2|1099|employee|contractor`',
    `workforce_mix_type` STRING COMMENT 'The employment classification or workforce segment type (temporary, contract, contract-to-hire, temp-to-perm, direct hire, permanent, independent contractor). Critical for analyzing workforce composition and contingent vs. permanent labor mix. [ENUM-REF-CANDIDATE: temporary|contract|contract_to_hire|temp_to_perm|direct_hire|permanent|independent_contractor — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_fte_actuals PRIMARY KEY(`fte_actuals_id`)
) COMMENT 'Periodic snapshot of actual FTE counts by client program, labor category, and workforce mix type for tracking against headcount plan targets';

-- ========= FOREIGN KEYS =========
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ADD CONSTRAINT `fk_joborder_position_requirement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ADD CONSTRAINT `fk_joborder_skill_requirement_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ADD CONSTRAINT `fk_joborder_rate_override_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ADD CONSTRAINT `fk_joborder_sla_commitment_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ADD CONSTRAINT `fk_joborder_order_status_history_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ADD CONSTRAINT `fk_joborder_order_modification_joborder_approval_workflow_id` FOREIGN KEY (`joborder_approval_workflow_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow`(`joborder_approval_workflow_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ADD CONSTRAINT `fk_joborder_order_modification_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ADD CONSTRAINT `fk_joborder_fulfillment_team_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_joborder_approval_workflow_id` FOREIGN KEY (`joborder_approval_workflow_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow`(`joborder_approval_workflow_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ADD CONSTRAINT `fk_joborder_vms_order_vms_order_header_id` FOREIGN KEY (`vms_order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ADD CONSTRAINT `fk_joborder_order_location_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ADD CONSTRAINT `fk_joborder_order_extension_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ADD CONSTRAINT `fk_joborder_job_category_parent_category_job_category_id` FOREIGN KEY (`parent_category_job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ADD CONSTRAINT `fk_joborder_job_category_parent_job_category_id` FOREIGN KEY (`parent_job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ADD CONSTRAINT `fk_joborder_joborder_approval_workflow_order_header_id` FOREIGN KEY (`order_header_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`order_header`(`order_header_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ADD CONSTRAINT `fk_joborder_joborder_approval_workflow_resubmitted_joborder_approval_workflow_id` FOREIGN KEY (`resubmitted_joborder_approval_workflow_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow`(`joborder_approval_workflow_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ADD CONSTRAINT `fk_joborder_headcount_plan_revised_headcount_plan_id` FOREIGN KEY (`revised_headcount_plan_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ADD CONSTRAINT `fk_joborder_demand_forecast_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ADD CONSTRAINT `fk_joborder_demand_forecast_revised_demand_forecast_id` FOREIGN KEY (`revised_demand_forecast_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_headcount_plan_id` FOREIGN KEY (`headcount_plan_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ADD CONSTRAINT `fk_joborder_capacity_plan_revised_capacity_plan_id` FOREIGN KEY (`revised_capacity_plan_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`capacity_plan`(`capacity_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_headcount_plan_id` FOREIGN KEY (`headcount_plan_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_job_category_id` FOREIGN KEY (`job_category_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`job_category`(`job_category_id`);
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ADD CONSTRAINT `fk_joborder_fte_actuals_prior_fte_actuals_id` FOREIGN KEY (`prior_fte_actuals_id`) REFERENCES `staffing_hr_ecm`.`joborder`.`fte_actuals`(`fte_actuals_id`);

-- ========= TAGS =========
ALTER SCHEMA `staffing_hr_ecm`.`joborder` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `staffing_hr_ecm`.`joborder` SET TAGS ('dbx_domain' = 'joborder');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Identifier');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Client Location ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `client_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `contract_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Schedule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `preferred_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier List Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `rate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `sow_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `bgc_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Required Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `clearance_required` SET TAGS ('dbx_value_regex' = 'none|public_trust|secret|top_secret|ts_sci');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `conversion_fee` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `conversion_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `drug_screen_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `education_requirement` SET TAGS ('dbx_business_glossary_term' = 'Education Requirement');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `employment_classification` SET TAGS ('dbx_business_glossary_term' = 'Employment Classification');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `employment_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|c2c');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `headcount_filled` SET TAGS ('dbx_business_glossary_term' = 'Headcount Filled');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `headcount_remaining` SET TAGS ('dbx_business_glossary_term' = 'Headcount Remaining');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `headcount_target` SET TAGS ('dbx_business_glossary_term' = 'Headcount Target');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Hours Per Week');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `intake_date` SET TAGS ('dbx_business_glossary_term' = 'Intake Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `is_backfill` SET TAGS ('dbx_business_glossary_term' = 'Backfill Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `is_temp_to_perm` SET TAGS ('dbx_business_glossary_term' = 'Temp-to-Perm Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `min_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Job Order Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'open|filled|on_hold|cancelled|closed');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `originating_source` SET TAGS ('dbx_business_glossary_term' = 'Originating Source');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `originating_source` SET TAGS ('dbx_value_regex' = 'vms|crm|direct|ats|email|portal');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `ot_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `ot_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `ot_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `ot_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'temporary|contract_to_hire|direct_placement|sow');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `req_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `req_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|flexible');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `ttf_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (TTF) Target Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `tts_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Start (TTS) Target Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_header` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `position_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Position Requirement ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `bgc_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `bgc_type` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `client_screening_criteria` SET TAGS ('dbx_business_glossary_term' = 'Client-Specific Screening Criteria');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `drug_screen_panel` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Panel Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `drug_screen_panel` SET TAGS ('dbx_value_regex' = '5_panel|10_panel|12_panel|hair_follicle|oral_fluid');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `drug_screen_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `education_field_of_study` SET TAGS ('dbx_business_glossary_term' = 'Required Field of Study');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'contract|temp_to_perm|direct_hire|contract_to_hire|per_diem|sow');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Position End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `everify_required` SET TAGS ('dbx_business_glossary_term' = 'E-Verify Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `headcount` SET TAGS ('dbx_business_glossary_term' = 'Headcount Target');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Hours Per Week');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `job_category` SET TAGS ('dbx_business_glossary_term' = 'Job Category');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `max_submittals` SET TAGS ('dbx_business_glossary_term' = 'Maximum Submittals Allowed');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `max_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Maximum Years of Experience');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `pay_rate_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `pay_rate_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `pay_rate_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `pay_rate_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `physical_demands` SET TAGS ('dbx_business_glossary_term' = 'Physical Demands Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `physical_demands` SET TAGS ('dbx_value_regex' = 'sedentary|light|medium|heavy|very_heavy');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `position_req_number` SET TAGS ('dbx_business_glossary_term' = 'Position Requirement Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `position_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Position Requirement Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `preferred_skills` SET TAGS ('dbx_business_glossary_term' = 'Preferred Skills');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Position Priority Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|fixed');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `required_skills` SET TAGS ('dbx_business_glossary_term' = 'Required Skills');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|public_trust|confidential|secret|top_secret|ts_sci');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|flexible|on_call');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Position Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_value_regex' = 'none|occasional|up_to_25_pct|up_to_50_pct|up_to_75_pct|frequent');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `ttf_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (TTF) Target Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `tts_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Start (TTS) Target Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `work_city` SET TAGS ('dbx_business_glossary_term' = 'Work Location City');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `work_country` SET TAGS ('dbx_business_glossary_term' = 'Work Location Country');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `work_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `work_state` SET TAGS ('dbx_business_glossary_term' = 'Work Location State');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`position_requirement` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|corp_to_corp|eor');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirement ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `tertiary_skill_deactivated_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Deactivated By User ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `alternative_skill_names` SET TAGS ('dbx_business_glossary_term' = 'Alternative Skill Names');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'resume_review|technical_test|behavioral_interview|practical_demonstration|certification_verification|reference_check');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `client_specific_terminology` SET TAGS ('dbx_business_glossary_term' = 'Client-Specific Terminology');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `last_market_rate_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Market Rate Survey Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `market_demand_level` SET TAGS ('dbx_business_glossary_term' = 'Market Demand Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `market_demand_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `minimum_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Score Threshold');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|expert|master');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'mandatory|preferred|nice_to_have');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_code` SET TAGS ('dbx_business_glossary_term' = 'Skill Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_description` SET TAGS ('dbx_business_glossary_term' = 'Skill Description');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_name` SET TAGS ('dbx_business_glossary_term' = 'Skill Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Skill Obsolescence Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Skill Priority Rank');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_source_system` SET TAGS ('dbx_business_glossary_term' = 'Skill Source System');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Skill Verification Required Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `skill_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Skill Weight Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `training_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Available Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`skill_requirement` ALTER COLUMN `years_of_experience_required` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `rate_override_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Override ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `contract_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Schedule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Rate Card ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `burden_rate` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `burden_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `client_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `client_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Client Approver Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `dt_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `dt_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `dt_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `dt_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `msa_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Reference');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Override Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `ot_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `ot_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `ot_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `ot_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `override_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Override Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `override_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Override Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `per_diem_allowance` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Allowance');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `per_diem_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `rate_cap` SET TAGS ('dbx_business_glossary_term' = 'Rate Cap');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `rate_cap` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `rate_floor` SET TAGS ('dbx_business_glossary_term' = 'Rate Floor');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `rate_floor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'msa_rate_schedule|vms_rate_card|negotiated|client_request|market_adjustment|competitive_bid');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|per_unit|per_project');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `spread` SET TAGS ('dbx_business_glossary_term' = 'Spread (Bill Rate minus Pay Rate)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`rate_override` ALTER COLUMN `spread` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Commitment Identifier');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Client Program ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Submittal Vendor ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `business_days_definition` SET TAGS ('dbx_business_glossary_term' = 'Business Days Definition');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `duplicate_submittal_prevention_rule` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Submittal Prevention Rule');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `duplicate_submittal_prevention_rule` SET TAGS ('dbx_value_regex' = 'first_submittal_wins|client_discretion|no_duplicates_allowed|timestamp_priority');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `exclusive_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Period End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `exclusive_submittal_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Submittal Period Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `fill_rate_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `interview_to_offer_ratio_target` SET TAGS ('dbx_business_glossary_term' = 'Interview to Offer Ratio Target');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `maximum_submittals_per_vendor` SET TAGS ('dbx_business_glossary_term' = 'Maximum Submittals Per Vendor');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_value_regex' = 'business_days|calendar_days|hours|custom');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `minimum_submittals_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Submittals Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `penalty_breach_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Breach Fee Amount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `penalty_breach_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `penalty_breach_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Breach Fee Currency');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `penalty_breach_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `penalty_terms_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Terms Description');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `penalty_terms_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `qos_minimum_score` SET TAGS ('dbx_business_glossary_term' = 'Quality of Submission (QoS) Minimum Score');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `rtr_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Right to Represent (RTR) Enforcement Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `sla_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Effective Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `sla_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'on_track|at_risk|breached|waived|not_applicable');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|vms_managed|enterprise|custom|expedited');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `submittal_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Submittal Service Level Agreement (SLA) Hours');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `submittal_window_close_date` SET TAGS ('dbx_business_glossary_term' = 'Submittal Window Close Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `submittal_window_open_date` SET TAGS ('dbx_business_glossary_term' = 'Submittal Window Open Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `ttf_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (TTF) Target Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `tts_target_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Start (TTS) Target Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`sla_commitment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `order_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status History ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering User ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `tertiary_order_account_manager_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `client_feedback` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|team_lead|manager|director|vp|executive');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'status_change|milestone_reached|modification|extension|cancellation|reopen');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `headcount_filled` SET TAGS ('dbx_business_glossary_term' = 'Headcount Filled');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `headcount_remaining` SET TAGS ('dbx_business_glossary_term' = 'Headcount Remaining');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Reason Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `sla_breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Severity');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `sla_breach_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|critical');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transition Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `triggering_system` SET TAGS ('dbx_business_glossary_term' = 'Triggering System');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `triggering_system` SET TAGS ('dbx_value_regex' = 'bullhorn_ats|beeline_vms|salesforce_crm|api_integration|batch_process|manual_entry');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `ttf_elapsed_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (TTF) Elapsed Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `tts_elapsed_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Start (TTS) Elapsed Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_status_history` ALTER COLUMN `variance_business_days` SET TAGS ('dbx_business_glossary_term' = 'Variance in Business Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `order_modification_id` SET TAGS ('dbx_business_glossary_term' = 'Order Modification ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `joborder_approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Joborder Approval Workflow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `primary_order_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `billing_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Amount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `billing_impact` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `contract_amendment_required` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Required Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `field_modified` SET TAGS ('dbx_business_glossary_term' = 'Field Modified');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `modification_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `modification_number` SET TAGS ('dbx_business_glossary_term' = 'Modification Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `modification_reason` SET TAGS ('dbx_business_glossary_term' = 'Modification Reason');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `modification_status` SET TAGS ('dbx_business_glossary_term' = 'Modification Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `modification_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|implemented|cancelled');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `modification_type` SET TAGS ('dbx_business_glossary_term' = 'Modification Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `modification_type` SET TAGS ('dbx_value_regex' = 'rate_change|headcount_change|duration_extension|scope_change|location_change|title_change');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `old_value` SET TAGS ('dbx_business_glossary_term' = 'Old Value');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `requestor_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `requestor_type` SET TAGS ('dbx_business_glossary_term' = 'Requestor Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `requestor_type` SET TAGS ('dbx_value_regex' = 'client_contact|internal_recruiter|account_manager|vms_system|hiring_manager');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_modification` ALTER COLUMN `vms_modification_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Modification ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `fulfillment_team_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Team Identifier');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `actual_submittal_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Submittal Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_role` SET TAGS ('dbx_value_regex' = 'lead_recruiter|sourcing_specialist|account_manager|coordinator|support_recruiter|team_lead');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|reassigned|closed|on_hold|pending');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `client_contact_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Authorized Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `commission_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `commission_split_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `expected_submittal_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Submittal Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Assignment Performance Rating');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|not_rated');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `placement_count` SET TAGS ('dbx_business_glossary_term' = 'Placement Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `primary_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `sourcing_channel_focus` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channel Focus');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `time_to_first_submittal_days` SET TAGS ('dbx_business_glossary_term' = 'Time to First Submittal (Days)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fulfillment_team` ALTER COLUMN `workload_weight` SET TAGS ('dbx_business_glossary_term' = 'Workload Weight Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Order ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `client_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Rate Card ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `joborder_approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `program_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Allocation Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `tier_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Classification Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Enrollment Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Rejected|Conditional|Escalated');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `auto_distribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Distribution Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `current_submittal_count` SET TAGS ('dbx_business_glossary_term' = 'Current Submittal Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `max_submittal_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Submittal Count Per Vendor');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `msp_name` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'VMS Order Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `rtr_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Right to Represent (RTR) Required Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `sow_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Reference Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `submission_window_close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Window Close Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `submission_window_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Window Open Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `supplier_diversity_requirement` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Requirement');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `sync_status` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `sync_status` SET TAGS ('dbx_value_regex' = 'Synced|Pending|Failed|Out of Sync|Manual Override');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier Eligibility');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Preferred|Standard|Restricted');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vendor_tier_sequence` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_bill_rate_cap` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Bill Rate Cap');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_bill_rate_cap` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_client_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Client Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_client_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Client Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_department_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Department Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_department_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Department Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_hiring_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Hiring Manager Email');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_hiring_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_hiring_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_hiring_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_hiring_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Hiring Manager Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_import_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Import Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_markup_cap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Markup Cap Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_markup_cap_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_order_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Order Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_pay_rate_cap` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Pay Rate Cap');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_pay_rate_cap` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`vms_order` ALTER COLUMN `vms_platform_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Platform Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `order_location_id` SET TAGS ('dbx_business_glossary_term' = 'Order Location ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Client Location ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `badge_access_required` SET TAGS ('dbx_business_glossary_term' = 'Badge Access Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `badge_sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Badge Sponsor Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `dress_code` SET TAGS ('dbx_business_glossary_term' = 'Dress Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `is_union_site` SET TAGS ('dbx_business_glossary_term' = 'Is Union Site');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `location_number` SET TAGS ('dbx_business_glossary_term' = 'Location Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'client_site|remote|hybrid|field|home_office|multi_site');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Location Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `parking_available` SET TAGS ('dbx_business_glossary_term' = 'Parking Available');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `parking_instructions` SET TAGS ('dbx_business_glossary_term' = 'Parking Instructions');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `per_diem_eligible` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Eligible');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `prevailing_wage_applicable` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Wage Applicable');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `prevailing_wage_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `prevailing_wage_applicable` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `prevailing_wage_determination` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Wage Determination Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `prevailing_wage_determination` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `prevailing_wage_determination` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `reporting_instructions` SET TAGS ('dbx_business_glossary_term' = 'Reporting Instructions');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Safety Classification');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Email Address');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Work Site Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `union_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Union Jurisdiction');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_location` ALTER COLUMN `workers_comp_class_code` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (Workers Comp) Classification Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `order_extension_id` SET TAGS ('dbx_business_glossary_term' = 'Order Extension Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Role');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `approving_authority` SET TAGS ('dbx_value_regex' = 'account_manager|client_contact|vms_coordinator|operations_manager|finance_director');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `benefits_eligibility_change` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligibility Change Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `client_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `client_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Client Approver Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extended_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Extended Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extended_markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Extended Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extended_markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extended_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Extended Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extended_spread` SET TAGS ('dbx_business_glossary_term' = 'Extended Spread Amount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extended_spread` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Approval Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Extension Duration in Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_duration_weeks` SET TAGS ('dbx_business_glossary_term' = 'Extension Duration in Weeks');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Extension End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_number` SET TAGS ('dbx_business_glossary_term' = 'Extension Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_reason` SET TAGS ('dbx_value_regex' = 'client_request|project_continuation|backfill_pending|budget_renewal|scope_expansion|performance_excellence');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_request_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Request Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Extension Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `extension_status` SET TAGS ('dbx_business_glossary_term' = 'Extension Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `msa_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Reference');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Extension Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `original_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Original Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Assignment End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `original_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Original Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `projected_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Projected Revenue Impact');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `projected_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `rate_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|annual|per_unit');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `sow_reference` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Reference');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `temp_to_perm_conversion_reset` SET TAGS ('dbx_business_glossary_term' = 'Temp-to-Perm (Temporary-to-Permanent) Conversion Clock Reset Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`order_extension` ALTER COLUMN `vms_extension_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Extension Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `parent_category_job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Job Category Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `parent_job_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `average_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `average_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `average_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `average_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `average_ttf_days` SET TAGS ('dbx_business_glossary_term' = 'Average Time to Fill (TTF) Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `bgc_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Requirement Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `bgc_requirement_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|comprehensive|enhanced');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Job Category Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Job Category Description');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Job Category Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Job Category Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'professional|technical|administrative|operational|executive|specialized');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `certification_commonly_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Commonly Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `clearance_level_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level Required');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `clearance_level_required` SET TAGS ('dbx_value_regex' = 'none|confidential|secret|top_secret');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `drug_screen_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `eeoc_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity Commission (EEOC) Job Category');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|varies');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `job_category_status` SET TAGS ('dbx_business_glossary_term' = 'Job Category Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `job_category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_review');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `market_demand_level` SET TAGS ('dbx_business_glossary_term' = 'Market Demand Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `market_demand_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,6}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `onet_code` SET TAGS ('dbx_business_glossary_term' = 'Occupational Information Network (O*NET) Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `onet_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{4}.[0-9]{2}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `physical_demands_level` SET TAGS ('dbx_business_glossary_term' = 'Physical Demands Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `physical_demands_level` SET TAGS ('dbx_value_regex' = 'sedentary|light|medium|heavy|very_heavy');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `prevailing_wage_applicable` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Wage Applicable Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `prevailing_wage_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `prevailing_wage_applicable` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|annual|per_project');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|expert|executive');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `soc_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Occupational Classification (SOC) Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `soc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `supplier_diversity_eligible` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `travel_requirement_typical` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Typical');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `travel_requirement_typical` SET TAGS ('dbx_value_regex' = 'none|minimal|moderate|frequent|extensive');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `typical_education_level` SET TAGS ('dbx_business_glossary_term' = 'Typical Education Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `typical_employment_type` SET TAGS ('dbx_business_glossary_term' = 'Typical Employment Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `typical_employment_type` SET TAGS ('dbx_value_regex' = 'temporary|contract|contract_to_hire|temp_to_perm|direct_hire|permanent');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `typical_markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Typical Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `typical_markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `typical_min_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Typical Minimum Experience Years');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `vms_category_mapping` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Category Mapping');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|ic|employee|contractor');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `workers_comp_class_code` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (Workers Comp) Class Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`job_category` ALTER COLUMN `workers_comp_class_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` SET TAGS ('dbx_subdomain' = 'requisition_management');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `joborder_approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order Approval Workflow ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `tertiary_joborder_escalated_to_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `resubmitted_joborder_approval_workflow_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditionally_approved|deferred|withdrawn');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_method` SET TAGS ('dbx_business_glossary_term' = 'Approval Method');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_method` SET TAGS ('dbx_value_regex' = 'web_portal|email|mobile_app|vms_platform|phone|in_person');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Request Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Stage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_turnaround_hours` SET TAGS ('dbx_business_glossary_term' = 'Approval Turnaround Hours');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approval_type` SET TAGS ('dbx_value_regex' = 'new_order|modification|extension|rate_change|headcount_increase|cancellation');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_business_glossary_term' = 'Approver Email Address');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approver_type` SET TAGS ('dbx_business_glossary_term' = 'Approver Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `approver_type` SET TAGS ('dbx_value_regex' = 'internal|client|vms|msp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `auto_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Approval Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `auto_approval_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Auto Approval Rule ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `client_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Reference');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `conditional_approval_requirements` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Requirements');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `conditions_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Conditions Met Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `conditions_met_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conditions Met Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `delegate_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Delegate Approver Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `delegate_approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|laptop|tablet|mobile|other');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `escalated_to_name` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `escalated_to_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `last_reminder_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `rejection_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`joborder_approval_workflow` ALTER COLUMN `vms_approval_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Approval ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Client Program ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `rate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `revised_headcount_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `current_filled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Filled Headcount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'temporary|contract|contract_to_hire|temp_to_perm|direct_hire|permanent');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Hours Per Week');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `maximum_headcount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Headcount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `minimum_headcount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Headcount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `msa_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Reference');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|project_based|evergreen|seasonal');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|annual|per_diem');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `remaining_headcount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Headcount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|weekend|flexible');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `supplier_diversity_requirement` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Requirement');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `supplier_diversity_requirement` SET TAGS ('dbx_value_regex' = 'required|preferred|not_applicable');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `target_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `target_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `target_gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Margin Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `target_gross_margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `target_headcount` SET TAGS ('dbx_business_glossary_term' = 'Target Headcount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `target_markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `target_markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `target_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `target_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid|client_site|office');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`headcount_plan` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|ic|employee|contractor');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Client Program ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `revised_demand_forecast_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `average_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `average_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `average_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `average_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `average_ttf_days` SET TAGS ('dbx_business_glossary_term' = 'Average Time to Fill (TTF) Days');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `baseline_headcount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Headcount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `demand_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Demand Variance Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'temporary|temp_to_perm|contract|contract_to_hire|direct_hire|permanent');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approved By');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approved Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_created_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Created Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_granularity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Granularity');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_granularity` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'historical_trend|client_input|statistical_model|machine_learning|hybrid|manual');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|archived|superseded');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecasted_fte` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Full-Time Equivalent (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `forecasted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Headcount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `market_demand_indicator` SET TAGS ('dbx_business_glossary_term' = 'Market Demand Indicator');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `market_demand_indicator` SET TAGS ('dbx_value_regex' = 'very_high|high|moderate|low|very_low');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `projected_cost` SET TAGS ('dbx_business_glossary_term' = 'Projected Cost');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `projected_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `projected_gross_margin` SET TAGS ('dbx_business_glossary_term' = 'Projected Gross Margin');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `projected_gross_margin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `projected_revenue` SET TAGS ('dbx_business_glossary_term' = 'Projected Revenue');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `projected_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|annual|per_unit');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|weekend|flexible');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `talent_availability_score` SET TAGS ('dbx_business_glossary_term' = 'Talent Availability Score');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`demand_forecast` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'W2|1099|independent_contractor|employee');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Client Program Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `program_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Allocation Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program Identifier (ID)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `revised_capacity_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `available_capacity_fte` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity in Full-Time Equivalents (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `available_capacity_headcount` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Headcount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `average_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `average_markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Average Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `average_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `bench_capacity_fte` SET TAGS ('dbx_business_glossary_term' = 'Bench Capacity in Full-Time Equivalents (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `capacity_gap_fte` SET TAGS ('dbx_business_glossary_term' = 'Capacity Gap in Full-Time Equivalents (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `capacity_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `committed_capacity_fte` SET TAGS ('dbx_business_glossary_term' = 'Committed Capacity in Full-Time Equivalents (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `forecasted_demand_fte` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Demand in Full-Time Equivalents (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `geography_type` SET TAGS ('dbx_business_glossary_term' = 'Geography Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `metro_area` SET TAGS ('dbx_business_glossary_term' = 'Metropolitan Area');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Notes');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `onet_code` SET TAGS ('dbx_business_glossary_term' = 'Occupational Information Network (O*NET) Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Number');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'strategic|tactical|operational|contingency|seasonal|project_based');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `planning_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon in Weeks');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|annual|project');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `redeployment_capacity_fte` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Capacity in Full-Time Equivalents (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `skill_pool_name` SET TAGS ('dbx_business_glossary_term' = 'Skill Pool Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `soc_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Occupational Classification (SOC) Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `sourcing_pipeline_fte` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Pipeline in Full-Time Equivalents (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `target_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Utilization Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`capacity_plan` ALTER COLUMN `uncommitted_capacity_fte` SET TAGS ('dbx_business_glossary_term' = 'Uncommitted Capacity in Full-Time Equivalents (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` SET TAGS ('dbx_subdomain' = 'workforce_planning');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `fte_actuals_id` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Actuals ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Client Location ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Client Program ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `prior_fte_actuals_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `actual_fte` SET TAGS ('dbx_business_glossary_term' = 'Actual Full-Time Equivalent (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `attrition_rate` SET TAGS ('dbx_business_glossary_term' = 'Attrition Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `average_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `average_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `average_markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Average Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `average_markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `average_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `average_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `average_spread` SET TAGS ('dbx_business_glossary_term' = 'Average Spread');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `average_spread` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `bench_count` SET TAGS ('dbx_business_glossary_term' = 'Bench Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `billable_hours` SET TAGS ('dbx_business_glossary_term' = 'Billable Hours');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Hours');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `fte_variance` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Variance');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `fte_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Variance Percentage');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `new_hire_count` SET TAGS ('dbx_business_glossary_term' = 'New Hire Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `non_billable_hours` SET TAGS ('dbx_business_glossary_term' = 'Non-Billable Hours');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `planned_fte` SET TAGS ('dbx_business_glossary_term' = 'Planned Full-Time Equivalent (FTE)');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `projected_cost` SET TAGS ('dbx_business_glossary_term' = 'Projected Cost');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `projected_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `projected_gross_margin` SET TAGS ('dbx_business_glossary_term' = 'Projected Gross Margin');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `projected_gross_margin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `projected_revenue` SET TAGS ('dbx_business_glossary_term' = 'Projected Revenue');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `projected_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `redeployment_count` SET TAGS ('dbx_business_glossary_term' = 'Redeployment Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'first_shift|second_shift|third_shift|rotating|weekend|on_call');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `snapshot_period_type` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Period Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `snapshot_period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|revised');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `termination_count` SET TAGS ('dbx_business_glossary_term' = 'Termination Count');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `total_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `union_status` SET TAGS ('dbx_business_glossary_term' = 'Union Status');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `union_status` SET TAGS ('dbx_value_regex' = 'union|non_union|mixed');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'onsite|remote|hybrid');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|employee|contractor');
ALTER TABLE `staffing_hr_ecm`.`joborder`.`fte_actuals` ALTER COLUMN `workforce_mix_type` SET TAGS ('dbx_business_glossary_term' = 'Workforce Mix Type');
