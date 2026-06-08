-- Schema for Domain: research | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`research` COMMENT 'Governs the full sponsored research lifecycle including grant proposals, award management, IRB protocol compliance, subaward administration, and PI tracking. Manages funding sources (NSF, NIH), F&A rates, IDC recovery, research expenditures, and closeout processes. Integrates with Kuali Research and supports RAE assessments and federal sponsor reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`research`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the sponsored research grant proposal. Primary key for the proposal entity.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Proposals created and managed in research administration systems. Business need: tracking which system manages each proposal, supporting system integrations, audit trails. The kuali_research_proposal_',
    `identity_account_id` BIGINT COMMENT 'Identifier of the user who last modified the proposal record. Used for audit trail and accountability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Proposal development involves research administrators who draft budgets, coordinate submissions, ensure compliance, distinct from PI. Essential for pre-award office workload analysis, training needs a',
    `principal_investigator_id` BIGINT COMMENT 'Unique identifier for the Principal Investigator (PI) who is the lead researcher responsible for the scientific and technical direction of the project.',
    `org_unit_id` BIGINT COMMENT 'FK to hr.org_unit',
    `proposal_org_unit_id` BIGINT COMMENT 'Unique identifier for the academic or research department that is the primary organizational unit responsible for the proposal.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Proposals requesting facility construction or major renovation funds must specify target buildings. Pre-award planning, feasibility assessments, and institutional commitment letters require linking pr',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Proposals must document compliance with specific regulatory requirements (45 CFR 46 for human subjects, Animal Welfare Act, EAR/ITAR) for sponsor review and institutional approval. Required for pre-aw',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to research.sponsor. Business justification: proposal has sponsor_agency_name which should be normalized via FK to sponsor master table. Proposals are submitted to sponsors; this is a critical relationship for accessing sponsor requirements, sub',
    `abstract` STRING COMMENT 'Executive summary or abstract of the research proposal describing the project objectives, methodology, and expected outcomes. Used for internal review and reporting.',
    `activity_type` STRING COMMENT 'Primary type of sponsored activity proposed (research, instruction, public service, or other). Used for institutional reporting and cost accounting.. Valid values are `research|instruction|public_service|other_sponsored_activity`',
    `biohazard_flag` BOOLEAN COMMENT 'Boolean indicator of whether the proposed research involves biohazardous materials and requires Institutional Biosafety Committee (IBC) approval.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the proposal budget (typically USD for U.S. institutions). Required for international collaborations and multi-currency proposals.. Valid values are `^[A-Z]{3}$`',
    `cfda_number` STRING COMMENT 'Five-digit CFDA number identifying the federal program under which funding is requested. Required for federal grant proposals and used for compliance reporting.. Valid values are `^[0-9]{2}.[0-9]{3}$`',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'Total amount of institutional cost sharing or matching funds committed in the proposal. Represents the institutions financial contribution to the project.',
    `cost_sharing_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the sponsor requires institutional cost sharing or matching funds as a condition of the award.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal record was first created in the system. Used for audit trail and data lineage tracking.',
    `decision_date` DATE COMMENT 'Date the sponsoring agency communicated their funding decision (awarded, declined, or deferred). Marks the conclusion of the proposal review process.',
    `direct_cost_amount` DECIMAL(18,2) COMMENT 'Total direct costs requested in the proposal budget, including salaries, equipment, supplies, and travel. Excludes indirect costs.',
    `fa_rate_percentage` DECIMAL(18,2) COMMENT 'Facilities and Administrative (F&A) indirect cost rate percentage applied to the proposal budget. This is the negotiated rate approved by the federal cognizant agency.',
    `human_subjects_flag` BOOLEAN COMMENT 'Boolean indicator of whether the proposed research involves human subjects and requires Institutional Review Board (IRB) approval.',
    `iacuc_approval_status` STRING COMMENT 'Current status of Institutional Animal Care and Use Committee (IACUC) approval for vertebrate animal research. Required for proposals involving animal subjects.. Valid values are `not_required|pending|approved|deferred`',
    `ibc_approval_status` STRING COMMENT 'Current status of Institutional Biosafety Committee (IBC) approval for biohazard research. Required for proposals involving recombinant DNA or biohazardous materials.. Valid values are `not_required|pending|approved|deferred`',
    `idc_rate_type` STRING COMMENT 'Type of indirect cost rate applied to the proposal (e.g., on-campus research, off-campus research, MTDC base). Determines which institutional F&A rate is used.. Valid values are `on_campus|off_campus|modified_total_direct_cost|total_direct_cost`',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Total indirect costs (also known as Facilities and Administrative or F&A costs) requested in the proposal budget. Calculated by applying the institutional IDC rate to the direct cost base.',
    `irb_approval_status` STRING COMMENT 'Current status of Institutional Review Board (IRB) approval for human subjects research. Required for proposals involving human participants.. Valid values are `not_required|pending|approved|exempt|deferred`',
    `kuali_research_proposal_number` STRING COMMENT 'Unique identifier for the proposal in the Kuali Research system. Used for integration and cross-reference with the source system of record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal record was last updated or modified. Used for audit trail and change tracking.',
    `project_duration_months` STRING COMMENT 'Total duration of the proposed project period expressed in months. Calculated from project start and end dates.',
    `project_end_date` DATE COMMENT 'Proposed end date for the research project period. Marks the conclusion of the project performance period if the proposal is awarded.',
    `project_start_date` DATE COMMENT 'Proposed start date for the research project period. Marks the beginning of the project performance period if the proposal is awarded.',
    `proposal_number` STRING COMMENT 'Externally-known unique proposal number assigned by the institution for tracking and reference. This is the business identifier used in communications with sponsors and internal stakeholders.. Valid values are `^[A-Z0-9]{6,20}$`',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the proposal indicating its position in the pre-award workflow. Tracks progression from initial draft through final agency decision.. Valid values are `draft|submitted|under_review|awarded|declined|withdrawn`',
    `proposal_type` STRING COMMENT 'Classification of the proposal indicating whether it is a new submission, continuation of existing funding, renewal, supplement, or revision. Used for sponsor reporting and internal tracking.. Valid values are `new|continuation|renewal|supplement|revision`',
    `requested_budget_amount` DECIMAL(18,2) COMMENT 'Total budget amount requested from the sponsor in the proposal, including both direct and indirect costs. This is the principal monetary value for the proposal.',
    `research_area_code` STRING COMMENT 'Code or classification identifying the primary research discipline or field of study for the proposal (e.g., NSF directorate code, NIH institute code).',
    `research_area_description` STRING COMMENT 'Textual description of the primary research discipline or field of study for the proposal (e.g., Biological Sciences, Engineering, Social Sciences).',
    `sponsor_award_number` STRING COMMENT 'Award or grant number assigned by the sponsoring agency if the proposal is funded. Links the proposal to the post-award grant record.',
    `sponsor_program_announcement` STRING COMMENT 'Program announcement, solicitation number, or funding opportunity announcement (FOA) number under which the proposal is submitted. Links the proposal to the specific sponsor funding mechanism.',
    `submission_date` DATE COMMENT 'Date the proposal was officially submitted to the sponsoring agency. This is the principal business event timestamp for the proposal transaction.',
    `submission_deadline` DATE COMMENT 'Final deadline date by which the proposal must be submitted to the sponsor. Used for internal tracking and compliance monitoring.',
    `title` STRING COMMENT 'Full title of the sponsored research proposal as submitted to the funding agency. This is the official project name that appears on all grant documentation.',
    `vertebrate_animals_flag` BOOLEAN COMMENT 'Boolean indicator of whether the proposed research involves vertebrate animals and requires Institutional Animal Care and Use Committee (IACUC) approval.',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Master record for a sponsored research grant proposal submitted to an external funding agency (NSF, NIH, DOE, etc.). Captures the full proposal lifecycle from pre-submission through agency decision, including proposal number, title, abstract, submission deadline, sponsor agency, program announcement, requested budget, F&A rate applied, submission date, status (draft, submitted, awarded, declined, withdrawn), PI information, lead department, CFDA number, project period start/end, indirect cost rate type, and Kuali Research proposal ID. Serves as the authoritative source for all pre-award activity.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`research_award` (
    `research_award_id` BIGINT COMMENT 'Unique system identifier for the research award record. Primary key for the research_award product.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Research awards are often administratively housed within academic programs for accreditation reporting (AACSB, ABET), strategic planning, and institutional research metrics. Programs track total resea',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Research awards managed in enterprise research administration systems (Kuali Research, InfoEd, Cayuse). Business need: system integration tracking, data lineage for audits, identifying source system f',
    `idc_rate_id` BIGINT COMMENT 'Foreign key linking to research.idc_rate. Business justification: research_award has indirect_cost_rate which should be normalized via FK to idc_rate master table. Awards are governed by specific IDC rate agreements negotiated with the cognizant agency; linking prov',
    `org_unit_id` BIGINT COMMENT 'Reference to the primary academic or administrative unit (department, college, center) responsible for administering the award.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Research awards frequently fund building construction, renovation, and major equipment installations. Capital project accounting, F&A rate calculations, and federal reporting require linking awards to',
    `sponsor_id` BIGINT COMMENT 'Reference to the funding sponsor or agency providing the award. Links to sponsor master data for agency details.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Awards fund lab-specific renovations, equipment installations, and specialized room configurations. Facilities management tracks which awards funded room improvements for depreciation, maintenance cos',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the faculty member designated as the Principal Investigator responsible for scientific and administrative leadership of the project.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Research awards require operational project manager distinct from PI for day-to-day administration, effort tracking, compliance monitoring, and sponsor communication. Essential for workload analysis a',
    `proposal_id` BIGINT COMMENT 'Reference to the originating proposal record that resulted in this award. Links award to pre-award proposal data.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Awards carry ongoing regulatory compliance obligations (OMB Uniform Guidance reporting, data management, records retention). Links award to specific federal/sponsor requirements for post-award complia',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Graduate research assistantships and fellowships directly fund student accounts. Universities track which awards pay student stipends and tuition, essential for financial aid reporting and award budge',
    `account_number` STRING COMMENT 'Financial system account number assigned to track expenditures and revenues for this award in the institutional general ledger.',
    `activity_type` STRING COMMENT 'Classification of the primary purpose of the sponsored activity for institutional reporting and cost accounting.. Valid values are `research|instruction|public_service|other_sponsored_activity`',
    `animal_subjects_approval_required_flag` BOOLEAN COMMENT 'Indicates whether the research involves animal subjects and requires Institutional Animal Care and Use Committee (IACUC) approval.',
    `award_number` STRING COMMENT 'Institution-assigned unique award number used for internal tracking and reference across financial, compliance, and reporting systems.',
    `award_status` STRING COMMENT 'Current lifecycle status of the award indicating its operational state and whether expenditures and activities are permitted.. Valid values are `active|no_cost_extension|closed|terminated|suspended|pending`',
    `award_type` STRING COMMENT 'Classification of the award mechanism indicating the legal and administrative relationship between sponsor and institution.. Valid values are `grant|contract|cooperative_agreement|fellowship|subaward|other`',
    `budget_end_date` DATE COMMENT 'End date of the current budget period, after which a new budget period begins or the award concludes.',
    `budget_start_date` DATE COMMENT 'Start date of the current budget period for multi-year awards with incremental funding releases.',
    `carryforward_allowed_flag` BOOLEAN COMMENT 'Indicates whether unspent funds from one budget period may be carried forward to the next budget period without prior approval.',
    `cfda_number` STRING COMMENT 'Five-digit federal program identifier used for tracking and reporting federal awards (format: XX.XXX).. Valid values are `^[0-9]{2}.[0-9]{3}$`',
    `closeout_date` DATE COMMENT 'Date on which all administrative and financial closeout activities were completed and the award was officially closed.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'Institutional or third-party contribution committed to the project beyond the sponsor funding, as required by award terms.',
    `cost_sharing_required_flag` BOOLEAN COMMENT 'Indicates whether the award terms mandate institutional or third-party cost sharing contributions.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this award record was first created in the research administration system.',
    `direct_cost_amount` DECIMAL(18,2) COMMENT 'Portion of the total award allocated to direct project costs including personnel, equipment, supplies, and travel.',
    `effective_date` DATE COMMENT 'Date on which the award becomes legally effective and binding between sponsor and institution.',
    `execution_date` DATE COMMENT 'Date on which the award agreement was signed and executed by authorized institutional officials.',
    `human_subjects_approval_required_flag` BOOLEAN COMMENT 'Indicates whether the research involves human subjects and requires Institutional Review Board (IRB) approval and oversight.',
    `iacuc_protocol_number` STRING COMMENT 'Identifier for the IACUC protocol governing animal research activities under this award.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Facilities and Administrative cost recovery amount calculated based on negotiated IDC rate applied to direct cost base.',
    `irb_protocol_number` STRING COMMENT 'Identifier for the IRB protocol governing human subjects research activities under this award.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this award record was most recently updated or modified.',
    `no_cost_extension_date` DATE COMMENT 'Extended project end date granted through a no-cost extension approval, superseding the original project end date.',
    `no_cost_extension_flag` BOOLEAN COMMENT 'Indicates whether the award has been granted a no-cost extension to extend the project period without additional funding.',
    `payment_method` STRING COMMENT 'Mechanism by which the sponsor disburses funds to the institution (advance payment, reimbursement, or letter of credit).. Valid values are `advance|reimbursement|letter_of_credit`',
    `payment_schedule` STRING COMMENT 'Description of the timing and conditions under which sponsor payments are made throughout the award period.',
    `program_code` STRING COMMENT 'Sponsor-specific program or funding opportunity identifier used for classification and reporting.',
    `project_end_date` DATE COMMENT 'Official end date of the project period, after which no new obligations may be incurred without extension approval.',
    `project_start_date` DATE COMMENT 'Official start date of the project period during which research activities and expenditures are authorized.',
    `reporting_frequency` STRING COMMENT 'Required frequency for submitting technical and financial progress reports to the sponsor.. Valid values are `annual|semi_annual|quarterly|monthly|final_only`',
    `sponsor_award_number` STRING COMMENT 'External award identifier assigned by the funding sponsor or agency. Used for sponsor reporting and correspondence.',
    `title` STRING COMMENT 'Full descriptive title of the research award as stated in the award notice or agreement.',
    `total_award_amount` DECIMAL(18,2) COMMENT 'Total funding amount committed by the sponsor for the entire project period, including all direct and indirect costs.',
    CONSTRAINT pk_research_award PRIMARY KEY(`research_award_id`)
) COMMENT 'Master record representing a funded sponsored research award granted by an external sponsor to the institution. Captures award number, title, sponsor award ID, funding agency, award type (grant, contract, cooperative agreement, fellowship), total award amount, direct costs, F&A/IDC amount, project period, budget period, award date, award status (active, no-cost extension, closed, terminated), CFDA number, program code, cost-sharing requirements, carryforward provisions, and link to originating proposal. The authoritative SSOT for all post-award financial and compliance activity. Sourced from Kuali Research Awards module.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`award_budget` (
    `award_budget_id` BIGINT COMMENT 'Unique identifier for the award budget record. Primary key for the award budget entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Budget development and modification tracked to specific research administrator for audit trail, workload analysis, and accountability. Critical for pre-award office management and effort certification',
    `idc_rate_id` BIGINT COMMENT 'Foreign key linking to research.idc_rate. Business justification: award_budget has fa_rate_percentage which should be normalized via FK to idc_rate master table. Budget periods apply specific IDC rates that were in effect during that period; linking to the rate agre',
    `research_award_id` BIGINT COMMENT 'Reference to the parent sponsored research award for which this budget is defined.',
    `approved_by` STRING COMMENT 'Name or identifier of the sponsor representative or institutional official who approved the budget.',
    `approved_date` DATE COMMENT 'Date when the budget was officially approved by the sponsoring agency.',
    `budget_justification_text` STRING COMMENT 'Detailed narrative justification for the budget request, explaining the necessity and reasonableness of each cost category.',
    `budget_modification_number` STRING COMMENT 'Sequential number tracking approved budget modifications or amendments submitted after the initial award.',
    `budget_notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the budget record for internal tracking and reference.',
    `budget_number` STRING COMMENT 'Human-readable business identifier for the budget record, typically assigned by the research administration office or sponsor.',
    `budget_period_number` STRING COMMENT 'Sequential number identifying the budget period within a multi-year award (e.g., Year 1, Year 2).',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget record indicating its approval and operational state. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|revised|active|closed — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget indicating whether it is an initial award budget, continuation budget, supplemental budget, or revision.. Valid values are `initial|continuation|supplement|no_cost_extension|revised`',
    `budget_version` STRING COMMENT 'Version number of the budget, incremented when modifications or revisions are submitted to the sponsor.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'Total institutional cost-sharing commitment for the budget period, representing resources contributed by the institution that are not reimbursed by the sponsor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget record was first created in the research administration system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the budget amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `equipment_costs` DECIMAL(18,2) COMMENT 'Total costs for equipment purchases with a unit acquisition cost of $5,000 or more and a useful life of more than one year.',
    `fringe_benefit_costs` DECIMAL(18,2) COMMENT 'Total fringe benefits associated with personnel costs, including health insurance, retirement contributions, and other employee benefits.',
    `modification_description` STRING COMMENT 'Narrative description of the budget modification, explaining the rationale and changes made to the original approved budget.',
    `modified_by` STRING COMMENT 'Username or identifier of the research administrator or PI who last modified the budget record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget record was last modified or updated.',
    `mtdc_base` DECIMAL(18,2) COMMENT 'The base amount used to calculate F&A costs, excluding equipment, capital expenditures, subcontract amounts over $25,000, and other exclusions per OMB Uniform Guidance.',
    `other_direct_costs` DECIMAL(18,2) COMMENT 'Total costs for miscellaneous direct expenses not classified in other categories, such as publication costs, participant support, and consultant fees.',
    `period_end_date` DATE COMMENT 'End date of the budget period by which all approved funds must be expended or obligated.',
    `period_start_date` DATE COMMENT 'Start date of the budget period during which the approved funds are available for expenditure.',
    `personnel_costs` DECIMAL(18,2) COMMENT 'Total salary and wage costs for all personnel charged to the award including Principal Investigator (PI), co-investigators, research staff, and students.',
    `sponsor_approved_amount` DECIMAL(18,2) COMMENT 'The total budget amount formally approved by the sponsoring agency for the budget period, which may differ from the requested amount.',
    `subcontract_costs` DECIMAL(18,2) COMMENT 'Total costs for subawards issued to other institutions or organizations to perform a portion of the research scope of work.',
    `submitted_date` DATE COMMENT 'Date when the budget was formally submitted to the sponsor for review and approval.',
    `supplies_costs` DECIMAL(18,2) COMMENT 'Total costs for consumable supplies, laboratory materials, and other items with a unit cost below the equipment threshold.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total budget for the period, calculated as the sum of total direct costs and total F&A costs.',
    `total_direct_costs` DECIMAL(18,2) COMMENT 'Sum of all direct cost categories including personnel, fringe, equipment, travel, supplies, subcontracts, and other direct costs for the budget period.',
    `total_fa_costs` DECIMAL(18,2) COMMENT 'Total indirect costs calculated based on the institutions negotiated F&A rate applied to the modified total direct costs base.',
    `travel_costs` DECIMAL(18,2) COMMENT 'Total costs for domestic and international travel necessary for the conduct of the research project, including airfare, lodging, meals, and ground transportation.',
    `unrecovered_fa_amount` DECIMAL(18,2) COMMENT 'The difference between the F&A costs calculated at the institutions negotiated rate and the amount actually recovered from the sponsor, representing institutional cost sharing.',
    `created_by` STRING COMMENT 'Username or identifier of the research administrator or PI who created the budget record.',
    CONSTRAINT pk_award_budget PRIMARY KEY(`award_budget_id`)
) COMMENT 'Detailed budget record associated with a sponsored research award, tracking approved budget by period, cost category, and object code. Captures budget period number, period start/end dates, total direct costs, total F&A costs, total award budget, budget by major cost category (personnel, fringe, equipment, travel, supplies, subcontracts, other direct costs), approved modifications, sponsor-approved budget, institutional cost-sharing commitments, and budget status. Supports NACUBO-compliant financial reporting and federal sponsor drawdown reconciliation.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`principal_investigator` (
    `principal_investigator_id` BIGINT COMMENT 'Unique identifier for the principal investigator record in the research administration system.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: Many faculty PIs are institutional alumni. Advancement tracks alumni giving, engagement, and career outcomes. Critical for prospect research, major gift cultivation, and stewardship. Links research le',
    `compliance_training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: PIs must complete required compliance training (RCR, human subjects, COI disclosure, export control) before proposal submission or award activation. Required for eligibility verification and sponsor c',
    `employee_id` BIGINT COMMENT 'The institutional employee identifier linking the PI to the Human Resources system. Required for effort certification and payroll integration.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: PIs require institutional accounts for research system access (proposal submission, award management, IRB protocols). Business need: access provisioning, authentication to research systems, audit trai',
    `instructor_id` BIGINT COMMENT 'FK to faculty.instructor.instructor_id — PI-to-faculty identity resolution is required for teaching load analysis, effort certification validation, and sponsored research compliance reporting. Without this link, institutions cannot answer w',
    `academic_rank` STRING COMMENT 'The current academic rank or title of the principal investigator within the institution (e.g., Professor, Associate Professor, Assistant Professor, Research Scientist).. Valid values are `Professor|Associate Professor|Assistant Professor|Research Professor|Research Scientist|Postdoctoral Fellow`',
    `active_award_count` STRING COMMENT 'The current number of active sponsored research awards on which this individual is serving as principal investigator or co-principal investigator.',
    `appointment_type` STRING COMMENT 'The type of faculty appointment held by the principal investigator (e.g., full-time, part-time, adjunct, visiting, joint appointment).. Valid values are `Full-Time|Part-Time|Adjunct|Visiting|Joint Appointment`',
    `college_school_code` STRING COMMENT 'The code identifying the college or school within which the PIs home department resides.',
    `college_school_name` STRING COMMENT 'The full name of the college or school within which the PIs home department resides (e.g., College of Arts and Sciences, School of Medicine).',
    `conflict_of_interest_disclosure_date` DATE COMMENT 'The date on which the PI last submitted or updated their financial conflict of interest disclosure.',
    `conflict_of_interest_disclosure_status` STRING COMMENT 'The current status of the PIs financial conflict of interest disclosure as required by federal regulations and institutional policy.. Valid values are `Current|Overdue|Not Required|Under Review|Disclosed`',
    `cumulative_award_count` STRING COMMENT 'The total number of sponsored research awards on which this individual has served as principal investigator or co-principal investigator over their career at the institution.',
    `effort_certification_eligible_flag` BOOLEAN COMMENT 'Indicates whether the principal investigator is required to complete effort certification reporting for sponsored projects. True if eligible, False otherwise.',
    `email_address` STRING COMMENT 'The institutional email address of the principal investigator used for official research administration communications and sponsor correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `federal_debarment_check_date` DATE COMMENT 'The date on which the most recent federal debarment check was performed.',
    `federal_debarment_check_status` STRING COMMENT 'The result of the most recent check against the federal System for Award Management (SAM) Exclusions database to verify the PI is not debarred, suspended, or otherwise excluded from receiving federal awards.. Valid values are `Clear|Flagged|Pending|Not Checked|Expired`',
    `first_name` STRING COMMENT 'The legal first name of the principal investigator as recorded in institutional HR systems.',
    `home_department_code` STRING COMMENT 'The code identifying the primary academic department to which the principal investigator is appointed.',
    `home_department_name` STRING COMMENT 'The full name of the primary academic department to which the principal investigator is appointed (e.g., Department of Chemistry, School of Engineering).',
    `kuali_research_person_number` STRING COMMENT 'The unique person identifier assigned to the principal investigator in the Kuali Research system, used for linking proposals, awards, protocols, and compliance records.',
    `last_name` STRING COMMENT 'The legal last name (surname) of the principal investigator as recorded in institutional HR systems.',
    `middle_name` STRING COMMENT 'The middle name or initial of the principal investigator.',
    `office_location` STRING COMMENT 'The building and room number of the principal investigators primary office location on campus.',
    `orcid_identifier` STRING COMMENT 'The unique ORCID identifier for the principal investigator, providing a persistent digital identifier that distinguishes them from other researchers.. Valid values are `^d{4}-d{4}-d{4}-d{3}[0-9X]$`',
    `phone_number` STRING COMMENT 'The primary institutional phone number for the principal investigator.',
    `pi_eligibility_effective_date` DATE COMMENT 'The date on which the current PI eligibility status became effective.',
    `pi_eligibility_status` STRING COMMENT 'The current eligibility status of the individual to serve as a principal investigator on sponsored research projects, as determined by the Office of Sponsored Programs.. Valid values are `Eligible|Ineligible|Conditional|Suspended|Under Review`',
    `pi_status` STRING COMMENT 'The current operational status of the principal investigator record in the research administration system.. Valid values are `Active|Inactive|On Leave|Retired|Terminated`',
    `primary_research_area` STRING COMMENT 'The primary field or discipline of research expertise for the principal investigator (e.g., Molecular Biology, Computer Science, Materials Engineering).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this principal investigator record was first created in the research administration system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this principal investigator record was last modified in the research administration system.',
    `tenure_status` STRING COMMENT 'The tenure status of the principal investigator within the institution.. Valid values are `Tenured|Tenure-Track|Non-Tenure-Track|Emeritus|Not Applicable`',
    `total_active_funding_amount` DECIMAL(18,2) COMMENT 'The total dollar amount of active sponsored research funding currently under the PIs direction across all active awards. Expressed in USD.',
    CONSTRAINT pk_principal_investigator PRIMARY KEY(`principal_investigator_id`)
) COMMENT 'Master record for a Principal Investigator (PI) or Co-PI authorized to direct sponsored research at the institution. Captures PI employee ID, name, academic rank, home department, college/school, effort certification eligibility, PI eligibility status, cumulative award count, total active funding, ORCID identifier, federal debarment check status and date, conflict of interest disclosure status, responsible conduct of research (RCR) training completion, human subjects (CITI) training completion, animal care training completion, export control certification, and Kuali Research person ID. Distinct from the faculty domains general faculty record — this entity tracks research-specific credentials, compliance certifications, funding portfolio, and eligibility determinations required by the Office of Sponsored Programs.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`sponsor` (
    `sponsor_id` BIGINT COMMENT 'Unique identifier for the external funding sponsor. Primary key for the sponsor master reference table.',
    `parent_sponsor_id` BIGINT COMMENT 'Foreign key reference to the parent sponsor organization for hierarchical sponsor structures. For example, individual NIH institutes (NHLBI, NCI) may reference NIH as parent. Null for top-level sponsors.',
    `acronym` STRING COMMENT 'Commonly used abbreviation or acronym for the sponsor organization (e.g., NSF, NIH, DOD, NASA, NEH). Used in informal communications and reporting dashboards.. Valid values are `^[A-Z]{2,10}$`',
    `address_line1` STRING COMMENT 'First line of the sponsor organizations primary mailing address. Used for official correspondence and award documentation.',
    `address_line2` STRING COMMENT 'Second line of the sponsor organizations mailing address (suite, floor, building, etc.). Null if not applicable.',
    `allows_cost_sharing` BOOLEAN COMMENT 'Boolean flag indicating whether the sponsor permits or requires institutional cost sharing (matching funds) on awards. True if cost sharing is allowed or required; False if prohibited.',
    `audit_requirement_threshold` DECIMAL(18,2) COMMENT 'Minimum cumulative award amount (in USD) that triggers Single Audit Act (A-133) or Uniform Guidance audit requirements for this sponsor. Typically $750,000 for federal sponsors. Null for sponsors without audit thresholds.',
    `cfda_program_list` STRING COMMENT 'Comma-separated list of CFDA program numbers administered by this federal sponsor (e.g., 47.041, 47.049, 47.050 for NSF). Null for non-federal sponsors. Used for federal compliance reporting and IPEDS surveys.',
    `city` STRING COMMENT 'City name of the sponsor organizations primary mailing address.',
    `closeout_report_required` BOOLEAN COMMENT 'Boolean flag indicating whether the sponsor requires a formal closeout report (technical and/or financial) upon award completion. True for most federal sponsors and many foundations.',
    `contact_email` STRING COMMENT 'Primary email address for the sponsors program officer or grants administrator. Used for official correspondence regarding proposals and awards.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Full name of the primary program officer or grants administrator at the sponsor organization. Serves as the main point of contact for proposal inquiries and award administration.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the sponsors program officer or grants administrator. Includes country code, area code, and extension if applicable.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the sponsor organizations primary location (e.g., USA, GBR, CAN). Used to classify domestic vs. foreign sponsors for compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `duns_number` STRING COMMENT 'Nine-digit DUNS number assigned by Dun & Bradstreet to uniquely identify the sponsor organization. Legacy identifier being replaced by UEI but still required for historical awards.. Valid values are `^[0-9]{9}$`',
    `federal_agency_code` STRING COMMENT 'Standard federal agency abbreviation for U.S. government sponsors (e.g., NSF, NIH, DOD, DOE, NASA, ED). Null for non-federal sponsors. Used for federal compliance reporting and IPEDS surveys.. Valid values are `^[A-Z]{2,4}$`',
    `idc_rate_cap_percentage` DECIMAL(18,2) COMMENT 'Maximum indirect cost rate percentage allowed by this sponsor, expressed as a decimal (e.g., 10.00 for 10%). Null if sponsor accepts institutions negotiated rate without cap.',
    `indirect_cost_negotiation_status` STRING COMMENT 'Sponsors policy on indirect cost recovery. Determines whether institutions federally negotiated F&A rate applies or if sponsor-specific rate caps are enforced.. Valid values are `accepts_negotiated_rate|requires_sponsor_rate|no_idc_allowed|not_applicable`',
    `is_federal_sponsor` BOOLEAN COMMENT 'Boolean flag indicating whether the sponsor is a U.S. federal government agency. True for federal agencies (NSF, NIH, DOD, etc.); False for all other sponsor types. Determines applicability of federal compliance requirements.',
    `notes` STRING COMMENT 'Free-text field for research administrators to capture sponsor-specific policies, special requirements, historical context, or other relevant information not captured in structured fields.',
    `payment_mechanism` STRING COMMENT 'Primary method by which the sponsor disburses award funds to the institution. Determines cash flow management and drawdown procedures for awarded grants.. Valid values are `letter_of_credit|reimbursement|advance|milestone|not_specified`',
    `payment_terms_days` STRING COMMENT 'Standard number of days from invoice submission to payment for reimbursement-based sponsors. Null for letter-of-credit or advance payment mechanisms.',
    `portal_url` STRING COMMENT 'Web address of the sponsors online grant management portal or system. Used by Principal Investigators (PIs) and research administrators for proposal submission, award management, and reporting.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the sponsor organizations primary mailing address. Format varies by country.',
    `preferred_submission_system` STRING COMMENT 'Primary electronic system or platform required by the sponsor for proposal submissions. Federal agencies typically mandate specific systems (Grants.gov for most agencies, FastLane for NSF, eRA Commons for NIH). [ENUM-REF-CANDIDATE: grants_gov|fastlane|era_commons|workspace|sponsor_portal|email|not_specified — 7 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sponsor record was first created in the research administration system. Used for audit trail and data lineage tracking.',
    `record_updated_by` STRING COMMENT 'Username or identifier of the research administrator who last modified this sponsor record. Used for audit trail and accountability.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sponsor record was last modified. Updated whenever any attribute value changes. Used for audit trail and change tracking.',
    `requires_cost_sharing` BOOLEAN COMMENT 'Boolean flag indicating whether the sponsor mandates institutional cost sharing as a condition of award. True if cost sharing is required; False if optional or not allowed.',
    `requires_iacuc_approval` BOOLEAN COMMENT 'Boolean flag indicating whether the sponsor mandates IACUC protocol approval for research involving vertebrate animals. True for federal sponsors and most foundations funding animal research.',
    `requires_institutional_review_board` BOOLEAN COMMENT 'Boolean flag indicating whether the sponsor mandates IRB protocol approval for human subjects research. True for most federal sponsors and many foundations; False for sponsors that do not fund human subjects research.',
    `sam_expiration_date` DATE COMMENT 'Date when the sponsors SAM.gov registration expires. Federal sponsors must renew annually. Null for non-federal sponsors.',
    `sam_registration_status` STRING COMMENT 'Current registration status of the sponsor in SAM.gov. Federal sponsors must maintain active SAM registration to award grants. Non-federal sponsors are marked not_applicable.. Valid values are `registered|expired|not_registered|not_applicable`',
    `sponsor_code` STRING COMMENT 'Institution-assigned unique alphanumeric code for the sponsor. Used as the business identifier in proposal routing, award setup, and financial reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `sponsor_name` STRING COMMENT 'Full legal name of the funding sponsor organization as registered with federal or state authorities. Used for official proposal submissions and award documents.',
    `sponsor_status` STRING COMMENT 'Current lifecycle status of the sponsor record. Active sponsors are eligible for new proposal submissions; inactive sponsors are retained for historical award management only.. Valid values are `active|inactive|suspended|archived`',
    `sponsor_type` STRING COMMENT 'Primary classification of the sponsor entity. Determines applicable compliance requirements, reporting obligations, and indirect cost policies.. Valid values are `federal_agency|state_agency|foundation|corporation|foreign_entity|other`',
    `state_province` STRING COMMENT 'State, province, or region of the sponsor organizations primary mailing address. Use standard two-letter abbreviations for U.S. states.',
    `uei_number` STRING COMMENT 'Twelve-character alphanumeric Unique Entity Identifier assigned by SAM.gov to replace DUNS. Required for all federal grant applications submitted after April 2022.. Valid values are `^[A-Z0-9]{12}$`',
    `website_url` STRING COMMENT 'Primary web address of the sponsor organizations public website. Provides access to funding opportunity announcements, program guidelines, and sponsor policies.',
    CONSTRAINT pk_sponsor PRIMARY KEY(`sponsor_id`)
) COMMENT 'Master reference record for external funding sponsors including federal agencies (NSF, NIH, DOD, DOE, NASA), state agencies, foundations, corporations, and foreign entities. Captures sponsor name, sponsor type, DUNS/UEI number, SAM.gov registration status, federal agency code, CFDA program list, indirect cost negotiation status, payment mechanism (letter of credit, reimbursement, advance), sponsor portal URL, sponsor contact information, and preferred submission system (Grants.gov, FastLane, eRA Commons, Workspace). Serves as the SSOT for all sponsor identity data across proposals and awards.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`subaward` (
    `subaward_id` BIGINT COMMENT 'Unique identifier for the subaward record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Subaward monitoring generates audit findings per OMB Uniform Guidance 200.332 subrecipient monitoring requirements. Links subaward to findings for risk assessment, corrective action, and pass-through ',
    `idc_rate_id` BIGINT COMMENT 'Foreign key linking to research.idc_rate. Business justification: subaward has indirect_cost_rate which should be normalized via FK to idc_rate master table. Subawards apply specific IDC rates (either the subrecipients negotiated rate or a rate specified in the pri',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Subaward monitoring requires institutional liaison for compliance oversight, invoice review, reporting coordination, and subrecipient communication. Essential for post-award office workload distributi',
    `research_award_id` BIGINT COMMENT 'Reference to the parent prime sponsored research award under which this subaward is issued.',
    `subrecipient_id` BIGINT COMMENT 'Foreign key linking to research.subrecipient. Business justification: subaward currently has denormalized subrecipient attributes (organization_name, duns_number, uei). Adding subrecipient_id FK normalizes this relationship and allows joining to the subrecipient master ',
    `closeout_date` DATE COMMENT 'Date on which the subaward was officially closed out after all financial and administrative requirements were satisfied.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'Total amount of cost sharing or matching funds that the subrecipient has committed to provide, if applicable.',
    `cost_sharing_required` BOOLEAN COMMENT 'Indicates whether the subrecipient is required to provide cost sharing or matching funds as a condition of the subaward.',
    `created_by_user` STRING COMMENT 'Username or identifier of the research administrator who created this subaward record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subaward record was first created in the research administration system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this subaward record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `executed_amount` DECIMAL(18,2) COMMENT 'Amount currently executed and available for expenditure under the subaward. May differ from total amount if incremental funding is used.',
    `execution_date` DATE COMMENT 'Date on which the subaward agreement was fully executed by all parties. Represents the official start of the contractual relationship.',
    `federal_award_identification_number` STRING COMMENT 'Federal Award Identification Number assigned by the prime sponsor to the parent award. Required for FFATA subaward reporting.',
    `federal_flow_down_clauses_applicable` BOOLEAN COMMENT 'Indicates whether federal flow-down clauses and requirements from the prime award must be incorporated into the subaward agreement. Typically true for federally-funded subawards.',
    `invoicing_frequency` STRING COMMENT 'Frequency at which the subrecipient is permitted to submit invoices for reimbursement or payment under the subaward terms.. Valid values are `monthly|quarterly|milestone|cost_reimbursement|other`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the research administrator who last modified this subaward record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this subaward record was last modified in the research administration system.',
    `monitoring_risk_level` STRING COMMENT 'Risk assessment level assigned to the subrecipient for monitoring purposes. Determines frequency and intensity of oversight activities required under OMB Uniform Guidance.. Valid values are `low|medium|high|critical`',
    `payment_terms` STRING COMMENT 'Description of the payment terms and conditions, including timing, method, and any advance payment provisions applicable to the subaward.',
    `period_of_performance_end_date` DATE COMMENT 'Date on which the subaward period of performance ends. Subrecipient must complete all work and incur all allowable costs by this date.',
    `period_of_performance_start_date` DATE COMMENT 'Date on which the subaward period of performance begins. Subrecipient may incur allowable costs starting from this date.',
    `prime_sponsor_name` STRING COMMENT 'Name of the federal or non-federal sponsor providing funding for the prime award under which this subaward is issued (e.g., NSF, NIH, DOE).',
    `scope_of_work_summary` STRING COMMENT 'High-level summary of the research activities, deliverables, and objectives that the subrecipient is responsible for under this subaward.',
    `single_audit_required` BOOLEAN COMMENT 'Indicates whether the subrecipient is required to undergo a Single Audit under the OMB Uniform Guidance. Required if subrecipient expends $750,000 or more in federal awards in a fiscal year.',
    `subaward_number` STRING COMMENT 'Externally-known unique identifier for the subaward, typically assigned by the institutions research administration office. Used for tracking and reporting.',
    `subaward_status` STRING COMMENT 'Current lifecycle status of the subaward. Pending indicates awaiting execution; executed indicates signed but not yet active; active indicates work in progress; suspended indicates temporary hold; closed indicates normal completion; terminated indicates early cancellation.. Valid values are `pending|executed|active|suspended|closed|terminated`',
    `subaward_type` STRING COMMENT 'Classification of the subaward instrument. Distinguishes between subcontracts (procurement), subgrants (assistance), consortium agreements, consultant agreements, vendor agreements, and other arrangements.. Valid values are `subcontract|subgrant|consortium_agreement|consultant_agreement|vendor_agreement|other`',
    `subrecipient_address_line1` STRING COMMENT 'First line of the subrecipient organizations official mailing address.',
    `subrecipient_address_line2` STRING COMMENT 'Second line of the subrecipient organizations official mailing address (suite, building, department).',
    `subrecipient_city` STRING COMMENT 'City of the subrecipient organizations official mailing address.',
    `subrecipient_contact_email` STRING COMMENT 'Email address of the primary administrative contact at the subrecipient organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `subrecipient_contact_name` STRING COMMENT 'Name of the primary administrative contact at the subrecipient organization for subaward management and compliance matters.',
    `subrecipient_contact_phone` STRING COMMENT 'Phone number of the primary administrative contact at the subrecipient organization.',
    `subrecipient_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the subrecipient organizations location.. Valid values are `^[A-Z]{3}$`',
    `subrecipient_pi_email` STRING COMMENT 'Primary email address of the subrecipient PI for official communications regarding the subaward.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `subrecipient_pi_name` STRING COMMENT 'Full name of the Principal Investigator at the subrecipient organization who is responsible for the scientific and technical direction of the subaward project.',
    `subrecipient_postal_code` STRING COMMENT 'Postal or ZIP code of the subrecipient organizations official mailing address.',
    `subrecipient_state_province` STRING COMMENT 'State or province of the subrecipient organizations official mailing address.',
    `termination_date` DATE COMMENT 'Date on which the subaward was terminated prior to the scheduled end date, if applicable.',
    `termination_reason` STRING COMMENT 'Explanation of the reason for early termination of the subaward, if applicable. May include convenience, cause, or mutual agreement.',
    `total_subaward_amount` DECIMAL(18,2) COMMENT 'Total obligated amount of the subaward over its entire period of performance, including all modifications and amendments.',
    CONSTRAINT pk_subaward PRIMARY KEY(`subaward_id`)
) COMMENT 'Transactional record for a subaward issued to a subrecipient organization under a prime sponsored research award. Captures subaward number, subrecipient organization name, subrecipient DUNS/UEI, subrecipient PI name, subaward type (subcontract, subgrant), total subaward amount, executed amount, period of performance, scope of work summary, monitoring risk level, subrecipient audit requirement (Single Audit threshold), invoicing frequency, payment terms, subaward status (pending, executed, active, closed), and federal flow-down clause applicability. Supports OMB Uniform Guidance 2 CFR 200 subrecipient monitoring requirements.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`irb_protocol` (
    `irb_protocol_id` BIGINT COMMENT 'Primary key for irb_protocol',
    `course_id` BIGINT COMMENT 'Foreign key linking to curriculum.course. Business justification: Research methods courses (especially graduate-level) require IRB approval for student research projects conducted as course assignments. IRB offices track protocols by course for annual reporting and ',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Course-based research (undergraduate research courses, capstone projects, thesis courses) requires IRB approval when involving human subjects. IRB offices review course syllabi for research components',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: IRB protocols managed in specialized human subjects compliance systems (HRPP software, IRBNet, Cayuse Human Ethics). Business need: regulatory compliance tracking, system integration for protocol revi',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: IRB protocol management assigns staff coordinator for submission tracking, PI correspondence, continuing review scheduling, and compliance monitoring. Critical for IRB office workload management and r',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the faculty or researcher serving as the Principal Investigator responsible for the conduct of this research study.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: IRB protocols implement specific federal regulations (45 CFR 46 Common Rule, FDA 21 CFR 50/56). Direct link required for regulatory compliance reporting, OHRP/FDA audits, and accreditation reviews (AA',
    `research_award_id` BIGINT COMMENT 'Reference to the grant award funding this research protocol. Links IRB protocol to sponsored research administration records.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: IRB protocols must document exact rooms where human subjects research occurs for compliance audits, emergency response, and regulatory inspections. OHRP and FDA audits require room-level documentation',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to research.sponsor. Business justification: irb_protocol has federal_sponsor_name which should be normalized via FK to sponsor master table. Federally-funded human subjects research has specific compliance requirements tied to the sponsor.',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to compliance.training_program. Business justification: IRB protocols require specific training programs (CITI Human Subjects Protection, GCP for clinical trials). Links protocol to required training for personnel authorization and regulatory compliance ve',
    `actual_enrollment` STRING COMMENT 'The actual number of human subjects enrolled in the study to date. Updated throughout the study lifecycle.',
    `adverse_event_count` STRING COMMENT 'Total number of adverse events reported for this protocol to date. Used for safety monitoring and continuing review.',
    `amendment_count` STRING COMMENT 'Total number of amendments or modifications submitted and approved for this protocol since initial approval.',
    `approval_date` DATE COMMENT 'Date on which the IRB granted approval for the research protocol to commence. This is the effective start date for the protocol.',
    `clinical_trial_flag` BOOLEAN COMMENT 'Indicates whether the protocol is a clinical trial as defined by NIH and FDA. Clinical trials have additional registration and reporting requirements.',
    `clinicaltrials_gov_number` STRING COMMENT 'The unique NCT number assigned by ClinicalTrials.gov for clinical trials subject to registration requirements. Required for applicable clinical trials.. Valid values are `^NCT[0-9]{8}$`',
    `closure_date` DATE COMMENT 'Date on which the protocol was officially closed by the IRB. Indicates completion of all research activities and final reporting.',
    `college_name` STRING COMMENT 'College or school within the institution to which the research protocol is affiliated. Used for institutional reporting and compliance tracking.',
    `consent_waiver_status` STRING COMMENT 'Indicates whether the IRB has granted a waiver or alteration of informed consent requirements for this protocol.. Valid values are `full_consent|waiver_granted|waiver_of_documentation|alteration_approved|not_applicable`',
    `continuing_review_due_date` DATE COMMENT 'Date by which the PI must submit a continuing review application to maintain active IRB approval. Critical for compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IRB protocol record was first created in the system. Used for audit trail and data lineage.',
    `data_safety_monitoring_plan` STRING COMMENT 'Description of the data and safety monitoring procedures in place for this protocol, including frequency of monitoring and responsible parties.',
    `data_safety_monitoring_required` BOOLEAN COMMENT 'Indicates whether the protocol requires a formal data and safety monitoring plan or Data Safety Monitoring Board (DSMB). Typically required for higher-risk studies.',
    `department_name` STRING COMMENT 'Academic department or organizational unit to which the Principal Investigator is affiliated. Used for institutional reporting and resource allocation.',
    `estimated_enrollment` STRING COMMENT 'The anticipated total number of human subjects to be enrolled in the research study. Used for risk assessment and resource planning.',
    `expiration_date` DATE COMMENT 'Date on which the current IRB approval expires. Research activities must cease or continuing review must be completed before this date.',
    `fda_regulated_flag` BOOLEAN COMMENT 'Indicates whether the research involves FDA-regulated products (drugs, biologics, devices) and is subject to FDA regulations in addition to Common Rule.',
    `funding_source_type` STRING COMMENT 'Primary category of funding supporting this research protocol. Determines applicable regulatory requirements and reporting obligations.. Valid values are `federal|industry|foundation|internal|unfunded`',
    `hipaa_authorization_required` BOOLEAN COMMENT 'Indicates whether the protocol requires HIPAA authorization for use and disclosure of protected health information (PHI). Applicable to research involving medical records or health data.',
    `initial_approval_date` DATE COMMENT 'Date of the very first IRB approval for this protocol. Distinct from approval_date which may reflect a continuing review approval.',
    `irb_of_record` STRING COMMENT 'Name of the IRB serving as the single IRB of record for multi-site research. For single-site studies, this is the institutions own IRB.',
    `kuali_research_protocol_number` STRING COMMENT 'The unique protocol identifier in the Kuali Research system of record. Used for integration and data lineage tracking.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent protocol amendment approval. Used for version control and compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this IRB protocol record. Used for audit trail and change tracking.',
    `multi_site_flag` BOOLEAN COMMENT 'Indicates whether the research is conducted at multiple sites or institutions. Multi-site studies may use a single IRB of record or require local IRB review at each site.',
    `protocol_number` STRING COMMENT 'The externally-known unique protocol number assigned by the IRB office. This is the business identifier used in all communications, submissions, and regulatory reporting.. Valid values are `^[A-Z0-9]{2,4}-[0-9]{4,8}(-[A-Z0-9]{1,4})?$`',
    `protocol_status` STRING COMMENT 'Current lifecycle status of the IRB protocol. Tracks the protocol through submission, review, approval, active research, and closure phases.. Valid values are `pending|approved|suspended|closed|expired|withdrawn`',
    `protocol_title` STRING COMMENT 'The full title of the research study as submitted to the IRB. This is the official name of the research project.',
    `protocol_version_number` STRING COMMENT 'Version number of the protocol document. Incremented with each amendment or modification approved by the IRB.. Valid values are `^[0-9]{1,3}(.[0-9]{1,2})?$`',
    `review_category` STRING COMMENT 'Specific regulatory category under which the protocol was reviewed (e.g., exempt category 1-8, expedited category 1-9). Provides granular classification within study type.',
    `risk_level` STRING COMMENT 'IRB assessment of the level of risk to human subjects participating in the research. Determines review requirements and monitoring intensity.. Valid values are `minimal|more_than_minimal|high`',
    `serious_adverse_event_count` STRING COMMENT 'Total number of serious adverse events (SAEs) reported for this protocol. SAEs require expedited reporting to the IRB and sponsor.',
    `study_type` STRING COMMENT 'Classification of the research study based on the level of IRB review required. Determines the review pathway and approval authority.. Valid values are `exempt|expedited|full_board|not_human_subjects`',
    `subject_population_description` STRING COMMENT 'Narrative description of the human subjects population to be enrolled in the study, including inclusion and exclusion criteria, vulnerable populations, and demographic characteristics.',
    `submission_date` DATE COMMENT 'Date on which the protocol was originally submitted to the IRB for review.',
    `vulnerable_population_flag` BOOLEAN COMMENT 'Indicates whether the study involves vulnerable populations such as children, prisoners, pregnant women, or cognitively impaired individuals. Triggers additional regulatory protections.',
    `vulnerable_population_types` STRING COMMENT 'Specific types of vulnerable populations included in the study (e.g., children, prisoners, pregnant women, economically disadvantaged, cognitively impaired). Pipe-separated list if multiple.',
    CONSTRAINT pk_irb_protocol PRIMARY KEY(`irb_protocol_id`)
) COMMENT 'Master record for an Institutional Review Board (IRB) protocol governing human subjects research. Captures protocol number, protocol title, PI name, study type (exempt, expedited, full board), review category, approval date, expiration date, protocol status (pending, approved, suspended, closed, expired), subject population description, estimated enrollment, risk level classification, consent waiver status, data safety monitoring requirements, adverse event reporting history, continuing review due date, and Kuali Research IRB protocol ID. Required for OHRP compliance and federal research assurance (FWA) reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`iacuc_protocol` (
    `iacuc_protocol_id` BIGINT COMMENT 'Unique system identifier for the IACUC protocol record. Primary key for the protocol entity.',
    `course_id` BIGINT COMMENT 'Foreign key linking to curriculum.course. Business justification: Laboratory courses in biology, veterinary medicine, and animal science require IACUC approval for teaching protocols involving live animals. Compliance offices track protocols by course for USDA and A',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Laboratory courses involving animal subjects (biology, veterinary medicine, psychology labs) require IACUC approval before students can work with animals. IACUC offices review course protocols; regist',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: IACUC protocols managed in animal research compliance systems. Business need: regulatory compliance tracking, system integration for protocol management, audit trails for USDA/AAALAC inspections. Esse',
    `employee_id` BIGINT COMMENT 'Reference to the licensed veterinarian assigned to provide oversight and care for animals used in this protocol. Required by federal regulations.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: IACUC protocols mandate specific animal housing and procedure rooms for USDA/OLAW compliance. Regulatory inspections, veterinary oversight, and emergency response require precise room documentation. R',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the faculty or research staff member who is the Principal Investigator (PI) responsible for the protocol. The PI holds primary accountability for protocol compliance and animal welfare.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: IACUC protocols implement PHS Policy on Humane Care and Use of Laboratory Animals and Animal Welfare Act regulations. Required for OLAW/USDA reporting, AAALAC accreditation, and regulatory compliance ',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: iacuc_protocol has grant_number and funding_source indicating some protocols are grant-funded. Adding award_id FK links grant-funded animal research protocols to their funding source. This is an optio',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to compliance.training_program. Business justification: IACUC protocols require specific training programs (animal care, species-specific handling, IACUC procedures). Links protocol to required training for personnel qualification and AAALAC accreditation ',
    `aaalac_accreditation_relevant` BOOLEAN COMMENT 'Indicates whether this protocol is relevant to the institutions AAALAC International accreditation status. AAALAC accreditation is a voluntary peer-review program for animal care and use programs.',
    `alternatives_databases_searched` STRING COMMENT 'List of databases and sources consulted during the alternatives search (e.g., PubMed, AGRICOLA, Web of Science). Required documentation for USDA compliance.',
    `alternatives_search_conducted` BOOLEAN COMMENT 'Indicates whether the PI conducted and documented a search for alternatives to procedures that may cause more than momentary or slight pain or distress. Required by USDA regulations.',
    `alternatives_search_date` DATE COMMENT 'The date the alternatives search was conducted. Must be documented for USDA-covered species protocols involving more than momentary pain or distress.',
    `animal_use_justification` STRING COMMENT 'The scientific rationale provided by the PI for the use of animals in this research, including justification for the species selected and the number of animals requested. Required element of IACUC protocol review.',
    `annual_review_date` DATE COMMENT 'The date of the most recent annual review or continuing review of the protocol. Some institutions require annual reviews in addition to the mandatory three-year review.',
    `approval_date` DATE COMMENT 'The date the IACUC granted approval for the protocol. This is the official start date for the three-year approval period mandated by federal regulations.',
    `approved_animal_count` STRING COMMENT 'The total number of animals approved for use in this protocol over the three-year approval period. Used for census tracking and regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this protocol record was first created in the system. Used for audit trail and data lineage tracking.',
    `euthanasia_method` STRING COMMENT 'The method(s) of euthanasia that will be used for animals in this protocol. Must be consistent with AVMA Guidelines on Euthanasia unless scientifically justified otherwise.',
    `expiration_date` DATE COMMENT 'The date the protocol approval expires. Federal regulations require IACUC protocols to be reviewed and re-approved at least once every three years.',
    `field_study_indicator` BOOLEAN COMMENT 'Indicates whether the protocol involves field studies (research conducted in natural environments outside of laboratory settings). Field studies have different regulatory considerations.',
    `funding_source` STRING COMMENT 'The sponsor or funding agency supporting the research (e.g., National Science Foundation (NSF), National Institutes of Health (NIH), institutional funds, private foundation). Critical for compliance reporting and grant management.',
    `hazardous_agents_used` STRING COMMENT 'Description of any hazardous biological, chemical, or radioactive agents used in the protocol. Requires coordination with institutional biosafety, radiation safety, and occupational health programs.',
    `last_amendment_date` DATE COMMENT 'The date of the most recent approved amendment to the protocol. Used for tracking protocol change history and compliance monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this protocol record was last modified in the system. Used for audit trail, change tracking, and data quality monitoring.',
    `pain_distress_category` STRING COMMENT 'USDA pain and distress classification for the protocol. Category B: animals being bred, conditioned, or held but not yet used; C: no pain or distress; D: pain or distress with appropriate anesthetics/analgesics; E: pain or distress without relief for scientific necessity.. Valid values are `B|C|D|E`',
    `phs_assurance_number` STRING COMMENT 'The institutions PHS Assurance number (Animal Welfare Assurance) on file with the Office of Laboratory Animal Welfare (OLAW). Required for PHS-funded research involving vertebrate animals.',
    `protocol_amendment_count` STRING COMMENT 'The number of amendments submitted and approved for this protocol since initial approval. Tracks protocol modifications over its lifecycle.',
    `protocol_keywords` STRING COMMENT 'Comma-separated keywords or tags describing the research area, procedures, or scientific focus of the protocol. Used for searching, categorization, and reporting.',
    `protocol_number` STRING COMMENT 'The externally-known business identifier assigned to the IACUC protocol by the institution. Used for tracking, reporting, and communication with investigators and regulatory bodies.',
    `protocol_status` STRING COMMENT 'Current lifecycle status of the IACUC protocol. Tracks the protocol from initial submission through approval, active use, and eventual closure or expiration. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|suspended|expired|terminated|closed — 9 candidates stripped; promote to reference product]',
    `protocol_title` STRING COMMENT 'The full descriptive title of the research protocol as submitted by the Principal Investigator (PI). Describes the nature and purpose of the animal research study.',
    `review_type` STRING COMMENT 'The type of IACUC review conducted for this protocol. Full Committee Review (FCR) involves the entire IACUC; Designated Member Review (DMR) is conducted by one or more qualified members; Veterinary Verification and Consultation (VVC) is for minor changes.. Valid values are `full_committee|designated_member|veterinary_verification_consultation`',
    `species_used` STRING COMMENT 'Comma-separated list or description of vertebrate animal species used in the protocol (e.g., mice, rats, rabbits, non-human primates, dogs, cats, pigs). Critical for USDA reporting and animal welfare assessment.',
    `submission_date` DATE COMMENT 'The date the protocol was formally submitted to the IACUC for review. Marks the beginning of the regulatory review timeline.',
    `survival_surgery_performed` BOOLEAN COMMENT 'Indicates whether the protocol involves survival surgery (procedures where animals recover from anesthesia). Survival surgeries require enhanced veterinary oversight and aseptic technique.',
    `three_year_review_date` DATE COMMENT 'The scheduled date for the mandatory three-year continuing review of the protocol by the IACUC. Required by federal regulations to ensure ongoing compliance and animal welfare.',
    `training_requirements` STRING COMMENT 'Description of training requirements for personnel working on this protocol, including species-specific training, procedural training, and occupational health clearances.',
    `usda_registration_required` BOOLEAN COMMENT 'Indicates whether this protocol involves USDA-covered species (all warm-blooded animals except rats, mice, and birds bred for research) and therefore requires USDA registration and annual reporting.',
    `veterinary_care_oversight` STRING COMMENT 'Description of veterinary oversight and care provisions for animals in this protocol, including attending veterinarian assignment and consultation arrangements.',
    CONSTRAINT pk_iacuc_protocol PRIMARY KEY(`iacuc_protocol_id`)
) COMMENT 'Master record for an Institutional Animal Care and Use Committee (IACUC) protocol governing vertebrate animal research. Captures protocol number, title, PI, species used, animal use justification, pain/distress category (USDA categories B-E), approved animal numbers, protocol approval date, expiration date, protocol status, three-year review cycle dates, veterinary oversight assignments, housing location, and AAALAC accreditation relevance. Supports USDA Animal Welfare Act compliance and PHS Policy on Humane Care and Use of Laboratory Animals reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`expenditure` (
    `expenditure_id` BIGINT COMMENT 'Primary key for expenditure',
    `award_budget_id` BIGINT COMMENT 'Foreign key linking to research.award_budget. Business justification: expenditure has budget_period column indicating expenditures are tracked against specific budget periods. Adding award_budget_id FK links expenditures to the budget period record, enabling budget vari',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Research expenditures include building maintenance, utilities, and renovations charged to awards. Cost accounting systems require building-level tracking for facilities and administrative cost allocat',
    `employee_id` BIGINT COMMENT 'Reference to the employee if this expenditure represents salary, wages, or fringe benefits charged to the award.',
    `faculty_assignment_id` BIGINT COMMENT 'Foreign key linking to instruction.faculty_assignment. Business justification: Research expenditures charging faculty salary to grants must link to specific teaching assignments for effort certification and audit compliance. OMB Uniform Guidance requires reconciling grant-funded',
    `finance_vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier if this expenditure represents a payment to an external party for goods or services.',
    `identity_account_id` BIGINT COMMENT 'The system user identifier of the person who posted or approved the expenditure transaction in the financial system.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Research expenditures generate journal entries for GL posting. Transaction-level link required for audit trail, financial statement preparation, and reconciliation between research administration syst',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the principal investigator responsible for the research award under which this expenditure is charged.',
    `proposal_id` BIGINT COMMENT 'Reference to the research project or program under which this expenditure is organized for tracking and reporting purposes.',
    `research_award_id` BIGINT COMMENT 'Reference to the sponsored research award under which this expenditure is charged.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Lab-specific expenditures (equipment installation, specialized renovations, room modifications) are charged to awards at room level. Space cost allocation and chargeback systems require room-level exp',
    `sponsor_id` BIGINT COMMENT 'Reference to the external funding agency or sponsor providing the research award (e.g., NSF, NIH, private foundation).',
    `subaward_id` BIGINT COMMENT 'Reference to the subaward agreement if this expenditure is associated with a subcontract to another institution or organization.',
    `tuition_charge_id` BIGINT COMMENT 'Foreign key linking to billing.tuition_charge. Business justification: Research expenditures frequently include tuition payments for graduate research assistants charged to sponsored projects. Linking expenditures to tuition charges enables accurate award accounting, spo',
    `allocable_flag` BOOLEAN COMMENT 'Indicates whether the expenditure is allocable to the research award according to the benefit received by the project.',
    `allowable_flag` BOOLEAN COMMENT 'Indicates whether the expenditure is allowable under the terms and conditions of the sponsor award and federal cost principles.',
    `audit_flag` BOOLEAN COMMENT 'Indicates whether this expenditure has been flagged for audit review or compliance verification.',
    `available_balance` DECIMAL(18,2) COMMENT 'The remaining unspent and unencumbered balance available on the award account after this transaction.',
    `award_account_number` STRING COMMENT 'The financial account number assigned to the sponsored research award in the general ledger system. Used for tracking expenditures and budget allocations.. Valid values are `^[A-Z0-9]{8,15}$`',
    `budget_period` STRING COMMENT 'The budget period number within the award lifecycle during which this expenditure occurred (e.g., Year 1, Year 2).',
    `closeout_flag` BOOLEAN COMMENT 'Indicates whether this expenditure is part of the award closeout process and final financial reporting to the sponsor.',
    `cost_share_flag` BOOLEAN COMMENT 'Indicates whether this expenditure represents institutional cost sharing or matching funds required by the sponsor.',
    `cumulative_expenditure_to_date` DECIMAL(18,2) COMMENT 'The total cumulative expenditure amount charged to the award account from inception through this transaction date.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the transaction amount (e.g., USD for US Dollar).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The academic or administrative department code responsible for managing the expenditure.. Valid values are `^[A-Z0-9]{4,8}$`',
    `direct_cost_flag` BOOLEAN COMMENT 'Indicates whether this expenditure is classified as a direct cost (true) or indirect cost (false) for federal reporting purposes.',
    `effort_percentage` DECIMAL(18,2) COMMENT 'The percentage of an employees total compensated effort devoted to this research award, used for salary cost allocation and effort reporting.',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'The amount of funds reserved or committed for future payment but not yet expended (e.g., purchase orders, contracts).',
    `expenditure_category` STRING COMMENT 'The high-level categorization of the expenditure aligned with federal sponsor reporting requirements and budget categories. [ENUM-REF-CANDIDATE: salaries|fringe_benefits|travel|supplies|equipment|subcontracts|other_direct_costs|indirect_costs — 8 candidates stripped; promote to reference product]',
    `expenditure_description` STRING COMMENT 'A detailed textual description of the expenditure transaction providing context about the goods, services, or purpose of the charge.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the transaction was posted, typically numbered 1-12.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the expenditure transaction occurred, typically represented as a four-digit year (e.g., 2024).',
    `grant_number` STRING COMMENT 'The sponsor-assigned grant or award number for external identification and reporting (e.g., NSF award number, NIH grant number).. Valid values are `^[A-Z0-9-]{8,20}$`',
    `idc_amount` DECIMAL(18,2) COMMENT 'The calculated indirect cost (facilities and administrative) amount recovered on this expenditure transaction.',
    `idc_rate` DECIMAL(18,2) COMMENT 'The facilities and administrative (F&A) indirect cost rate applied to this expenditure for overhead recovery, expressed as a decimal (e.g., 0.5400 for 54%).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the expenditure record was last updated or modified in the system.',
    `object_code` STRING COMMENT 'The financial object code that classifies the nature of the expenditure in the chart of accounts (e.g., salaries, supplies, travel).. Valid values are `^[0-9]{4,6}$`',
    `object_code_description` STRING COMMENT 'The descriptive name of the object code providing human-readable classification of the expenditure type.',
    `posted_timestamp` TIMESTAMP COMMENT 'The date and time when the expenditure transaction was posted to the financial system.',
    `reasonable_flag` BOOLEAN COMMENT 'Indicates whether the expenditure is reasonable in nature and amount for the performance of the research award.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the expenditure transaction charged to the award account. Positive values represent charges; negative values represent credits or reversals.',
    `transaction_date` DATE COMMENT 'The date when the expenditure transaction was posted to the award account in the financial system.',
    `transaction_number` STRING COMMENT 'The unique transaction identifier or journal entry reference number from the source financial system.. Valid values are `^[A-Z0-9-]{10,20}$`',
    `transaction_source_system` STRING COMMENT 'The name of the source financial system from which this expenditure transaction originated (e.g., PeopleSoft Financials, Kuali Research).',
    `transaction_status` STRING COMMENT 'The current processing status of the expenditure transaction in the financial system workflow.. Valid values are `posted|pending|reversed|voided|approved|rejected`',
    CONSTRAINT pk_expenditure PRIMARY KEY(`expenditure_id`)
) COMMENT 'Transactional record capturing actual expenditures charged to a sponsored research award account. Captures transaction date, fiscal year, fiscal period, award account number, object code, object code description, expenditure category (salaries, fringe, travel, supplies, equipment, subcontracts, IDC), transaction amount, cumulative expenditure to date, encumbrance amount, available balance, transaction source system (PeopleSoft), journal entry reference, and expenditure status. Supports federal financial reporting (SF-425 Federal Financial Report), IPEDS research expenditure reporting, and IDC recovery calculations.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`effort_certification` (
    `effort_certification_id` BIGINT COMMENT 'Unique identifier for the effort certification record. Primary key for the effort certification transaction.',
    `award_budget_id` BIGINT COMMENT 'Foreign key linking to research.award_budget. Business justification: Effort certifications validate that actual effort matches budgeted effort for a specific period. Adding award_budget_id FK links effort certifications to the budget period, enabling comparison of cert',
    `fiscal_period_id` BIGINT COMMENT 'Identifier of the certification period (typically semester or academic year) during which the effort was expended. Links to the certification period reference table.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Effort certifications submitted by certifiers using institutional accounts. Business need: authentication for certification submissions, audit trails for compliance, linking certifier identity to inst',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Effort certification requires identifying specific course sections taught during certification period to calculate instructional effort percentage. Auditors trace certified effort to actual course ros',
    `faculty_assignment_id` BIGINT COMMENT 'Foreign key linking to instruction.faculty_assignment. Business justification: Effort certification is the primary business process linking research and instruction. Faculty certify salary charged to grants matches actual effort by reconciling research awards against teaching as',
    `grant_expenditure_id` BIGINT COMMENT 'Foreign key linking to finance.grant_expenditure. Business justification: Effort certifications validate salary charges recorded as grant expenditures. Direct link required for OMB Uniform Guidance compliance audits, cost allocation validation, and after-the-fact effort adj',
    `employee_id` BIGINT COMMENT 'Identifier of the employee (faculty, staff, or graduate student) whose effort is being certified. Links to the personnel record in the HR system.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Effort certification implements OMB Uniform Guidance 2 CFR 200.430 salary cost allocation requirements. Direct link required for A-133/Single Audit compliance, questioned cost defense, and federal aud',
    `research_award_id` BIGINT COMMENT 'Identifier of the sponsored research award against which the effort is being certified. Links to the award record in the research administration system.',
    `student_athlete_id` BIGINT COMMENT 'Foreign key linking to athletics.student_athlete. Business justification: Tracks effort certification for student-athletes employed on research awards. Required for federal compliance (OMB Uniform Guidance), salary cost allocation verification, and ensuring research employm',
    `adjustment_justification` STRING COMMENT 'Detailed narrative justification for any significant variance between proposed and certified effort. Required for audit documentation and sponsor reporting.',
    `adjustment_reason_code` STRING COMMENT 'Standardized code indicating the reason for any adjustment between proposed and certified effort. Used for audit trail and trend analysis.. Valid values are `scope_change|personnel_change|effort_reallocation|error_correction|cost_sharing_adjustment|other`',
    `appointment_type` STRING COMMENT 'Classification of the employees appointment type at the institution. Determines applicable effort reporting requirements and compensation rules.. Valid values are `faculty|staff|postdoc|graduate_student|undergraduate_student|visiting_scholar`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the effort certification was officially approved and finalized. Represents the completion of the certification lifecycle.',
    `certification_comments` STRING COMMENT 'Free-text comments or notes provided by the certifier regarding the effort certification. May include explanations, clarifications, or special circumstances.',
    `certification_date` DATE COMMENT 'Date on which the effort was officially certified by the authorized individual. Represents the business event timestamp for the certification action.',
    `certification_due_date` DATE COMMENT 'Deadline by which the effort certification must be completed to maintain compliance with federal and institutional policies. Typically 90-120 days after period end.',
    `certification_method` STRING COMMENT 'Method by which the effort certification was completed. Indicates whether the certification was submitted electronically, on paper, auto-generated by the system, or completed retrospectively.. Valid values are `electronic|paper|system_generated|retrospective`',
    `certification_number` STRING COMMENT 'Business identifier for the effort certification transaction, typically formatted as a human-readable reference number for tracking and audit purposes.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the effort certification. Indicates whether the certification is awaiting review, has been approved, requires adjustment, or has been rejected.. Valid values are `pending|certified|rejected|adjusted|overdue|withdrawn`',
    `certified_effort_percentage` DECIMAL(18,2) COMMENT 'The actual percentage of the employees total effort expended on this award during the certification period, as certified by the employee or authorized representative. Expressed as a percentage (e.g., 30.00 for 30%).',
    `certifier_name` STRING COMMENT 'Full name of the individual who certified the effort. Captured for audit trail and compliance documentation purposes.',
    `certifier_role` STRING COMMENT 'Role of the individual who certified the effort. Indicates the authority level and relationship to the employee whose effort is being certified.. Valid values are `employee|supervisor|pi|department_chair|dean|authorized_representative`',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this effort certification meets all federal and institutional compliance requirements. False indicates a compliance issue requiring resolution.',
    `compliance_issue_description` STRING COMMENT 'Detailed description of any compliance issues identified with this effort certification, such as late submission, excessive variance, or missing documentation. Null if no issues exist.',
    `cost_shared_fringe_amount` DECIMAL(18,2) COMMENT 'Fringe benefits amount contributed by the institution as cost sharing for this award during the certification period, calculated on the cost-shared salary amount.',
    `cost_shared_salary_amount` DECIMAL(18,2) COMMENT 'Salary amount contributed by the institution as cost sharing or matching funds for this award during the certification period. Represents institutional commitment not charged to the sponsor.',
    `cost_transfer_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the cost transfer required to align charges with certified effort. Positive values indicate charges to be moved to the award; negative values indicate charges to be moved off the award.',
    `cost_transfer_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a cost transfer is required based on the variance between proposed and certified effort. True triggers a financial adjustment workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the effort certification record was first created in the system. Audit trail field for record lifecycle tracking.',
    `effort_variance_percentage` DECIMAL(18,2) COMMENT 'The difference between certified effort and proposed effort, expressed as a percentage. Positive values indicate over-commitment; negative values indicate under-commitment. Used to trigger cost transfer or rebudgeting actions.',
    `federal_agency_code` STRING COMMENT 'Standard code identifying the federal agency sponsoring the award (e.g., NSF, NIH, DOE, DOD). Used for federal reporting and compliance tracking. Null for non-federal awards.',
    `fringe_benefits_charged_amount` DECIMAL(18,2) COMMENT 'Total fringe benefits amount charged to the award during the certification period, calculated based on the institutions approved fringe benefit rate applied to the salary charged amount.',
    `institutional_base_salary` DECIMAL(18,2) COMMENT 'The employees institutional base salary (IBS) during the certification period, used as the denominator for calculating effort percentages. Represents the employees annual compensation for their primary appointment.',
    `modified_by` STRING COMMENT 'Username or identifier of the individual who last modified the effort certification record. Audit trail field for accountability and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the effort certification record was last modified. Audit trail field for tracking changes and updates to the certification.',
    `period_end_date` DATE COMMENT 'End date of the certification period during which the effort was expended. Defines the boundary of the reporting window.',
    `period_start_date` DATE COMMENT 'Start date of the certification period during which the effort was expended. Typically aligns with semester or fiscal year boundaries.',
    `pi_approval_date` DATE COMMENT 'Date on which the Principal Investigator approved the effort certification. Null if PI approval is not required or has not yet been obtained.',
    `pi_approval_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether Principal Investigator approval is required for this effort certification, typically based on institutional policy or variance thresholds.',
    `proposed_effort_percentage` DECIMAL(18,2) COMMENT 'The originally proposed or budgeted percentage of the employees total effort allocated to this award during the certification period. Expressed as a percentage (e.g., 25.00 for 25%).',
    `salary_charged_amount` DECIMAL(18,2) COMMENT 'Total salary amount charged to the award during the certification period, expressed in the institutions base currency. Represents direct personnel costs allocated to the sponsored project.',
    `sponsor_type` STRING COMMENT 'Classification of the funding sponsor for the award. Federal sponsors have the most stringent effort reporting requirements under OMB Uniform Guidance. [ENUM-REF-CANDIDATE: federal|state|local|private|industry|foundation|internal — 7 candidates stripped; promote to reference product]',
    `submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the effort certification was initially submitted for review. Captures the moment the certification entered the approval workflow.',
    `total_compensation_amount` DECIMAL(18,2) COMMENT 'Total compensation (salary plus fringe benefits) charged and cost-shared for this employee on this award during the certification period. Sum of all salary and fringe components.',
    CONSTRAINT pk_effort_certification PRIMARY KEY(`effort_certification_id`)
) COMMENT 'Transactional record documenting the certified effort of personnel (faculty, staff, graduate students) working on sponsored research awards during a certification period. Captures employee ID, award account, certification period (semester or academic year), proposed effort percentage, certified effort percentage, salary charged to award, cost-shared salary, certifier name, certification date, certification status (pending, certified, rejected, adjusted), and compliance flag. Required under OMB Uniform Guidance 2 CFR 200.430 for personnel cost documentation on federal awards.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`idc_rate` (
    `idc_rate_id` BIGINT COMMENT 'Primary key for idc_rate',
    `prior_rate_agreement_idc_rate_id` BIGINT COMMENT 'Reference to the previous rate agreement that this rate supersedes or replaces. Enables tracking of rate history and changes over time.',
    `administrative_rate_component` DECIMAL(18,2) COMMENT 'The administrative portion of the F&A rate, covering general administration, departmental administration, and sponsored projects administration costs. Typically 26% of the total rate.',
    `applicable_fiscal_year` STRING COMMENT 'The institutions fiscal year to which this rate applies. Used for multi-year rate agreements where different rates may apply to different fiscal periods.',
    `approved_by_official` STRING COMMENT 'Name and title of the cognizant agency official who approved and signed the rate agreement. Used for verification and audit trail.',
    `carryforward_provision` STRING COMMENT 'Description of any carryforward provisions in the rate agreement that allow over- or under-recovery of IDC in one period to be adjusted in subsequent periods.',
    `cognizant_agency` STRING COMMENT 'The federal agency responsible for negotiating and approving the institutions IDC rates. Typically DHHS (Department of Health and Human Services) or ONR (Office of Naval Research) for most universities.. Valid values are `dhhs|onr|doe|nasa|usda|other`',
    `cost_base_type` STRING COMMENT 'The cost base to which the rate percentage is applied. MTDC (Modified Total Direct Costs) is most common and excludes equipment, capital expenditures, subawards over $25K, and other specified costs.. Valid values are `mtdc|tdc|salaries_wages|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IDC rate record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'The date on which this IDC rate expires and is no longer applicable to new awards. Nullable for open-ended agreements or provisional rates pending final negotiation.',
    `effective_start_date` DATE COMMENT 'The date on which this IDC rate becomes effective and applicable to sponsored awards. Typically aligns with the institutions fiscal year start.',
    `equipment_exclusion_threshold` DECIMAL(18,2) COMMENT 'The dollar threshold above which equipment purchases are excluded from the MTDC base for IDC calculation. Typically $5,000 per federal capitalization policies.',
    `facilities_rate_component` DECIMAL(18,2) COMMENT 'The facilities portion of the F&A rate, covering depreciation, interest, operations and maintenance, and library costs. Combined with administrative component to form total F&A rate.',
    `fringe_benefit_rate_included` BOOLEAN COMMENT 'Indicates whether fringe benefit costs are included in the IDC rate calculation or treated separately. True if fringe is part of the rate; false if fringe is calculated independently.',
    `institutional_signatory` STRING COMMENT 'Name and title of the institutional official (typically CFO or VP for Research) who signed the rate agreement on behalf of the university.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this IDC rate record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IDC rate record was last modified. Used for audit trail and change tracking.',
    `mtdc_exclusion_threshold` DECIMAL(18,2) COMMENT 'The dollar threshold above which certain costs (e.g., subawards, equipment) are excluded from the MTDC base. Commonly $25,000 for subawards per federal guidelines.',
    `negotiation_date` DATE COMMENT 'The date on which the rate agreement was formally negotiated and executed between the institution and the cognizant federal agency.',
    `rate_agreement_document_reference` STRING COMMENT 'Reference identifier or file path to the official rate agreement document signed by the cognizant agency. Used for audit trail and compliance verification.',
    `rate_agreement_number` STRING COMMENT 'Official agreement number assigned by the cognizant federal agency for this negotiated rate agreement. Serves as the business identifier for the rate record.',
    `rate_audit_date` DATE COMMENT 'The date of the most recent audit or review of the IDC rate calculation by the cognizant agency or external auditors. Used for compliance tracking.',
    `rate_calculation_methodology` STRING COMMENT 'Description of the methodology used to calculate the IDC rate, including cost pools, allocation bases, and any special adjustments. Documents the technical approach for audit and compliance purposes.',
    `rate_cap_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable IDC rate percentage imposed by specific sponsors or programs. Some federal programs (e.g., training grants) cap IDC at 8%. Nullable if no cap applies.',
    `rate_determination_type` STRING COMMENT 'Classification of the rate determination method. Predetermined rates are negotiated in advance for a multi-year period; provisional rates are temporary pending final rate calculation; fixed rates remain constant; final rates are determined after actual costs are known.. Valid values are `predetermined|provisional|fixed|final|temporary`',
    `rate_negotiation_notes` STRING COMMENT 'Free-text notes documenting special conditions, exceptions, or context from the rate negotiation process. Used for institutional memory and future negotiations.',
    `rate_percentage` DECIMAL(18,2) COMMENT 'The negotiated percentage rate applied to the cost base to calculate indirect cost recovery. Expressed as a percentage (e.g., 54.50 for 54.5%).',
    `rate_proposal_submission_date` DATE COMMENT 'The date on which the institution submitted its IDC rate proposal to the cognizant agency for review and negotiation.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the rate agreement. Active rates are currently in use; expired rates are past their end date; superseded rates have been replaced by newer agreements; pending rates await approval; draft rates are under negotiation.. Valid values are `active|expired|superseded|pending|draft`',
    `rate_type` STRING COMMENT 'Classification of the rate based on the type of sponsored activity and location. On-campus research typically has higher rates than off-campus due to facility usage.. Valid values are `on_campus_research|off_campus_research|instruction|other_sponsored_activities|organized_research|public_service`',
    `special_rate_conditions` STRING COMMENT 'Documentation of any special conditions, restrictions, or requirements attached to this rate agreement by the cognizant agency or specific sponsors.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this IDC rate record. Used for audit trail and accountability.',
    CONSTRAINT pk_idc_rate PRIMARY KEY(`idc_rate_id`)
) COMMENT 'Reference record for negotiated Facilities and Administrative (F&A) / Indirect Cost (IDC) rates established between the institution and its federal cognizant agency (typically DHHS or ONR). Captures rate type (on-campus research, off-campus research, instruction, other sponsored activities), rate percentage, applicable base (MTDC - Modified Total Direct Costs), effective start date, effective end date, negotiation agreement date, cognizant federal agency, rate agreement document reference, and predetermined vs. fixed vs. provisional rate designation. Governs IDC recovery calculations on all federal awards.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`award_modification` (
    `award_modification_id` BIGINT COMMENT 'Unique identifier for the award modification record. Primary key.',
    `award_budget_id` BIGINT COMMENT 'Foreign key linking to research.award_budget. Business justification: Award modifications that change funding amounts or scope result in new budget versions. Adding award_budget_id FK links modifications to the resulting budget version, providing traceability from modif',
    `employee_id` BIGINT COMMENT 'User identifier of the research administrator or system user who created this modification record. Part of the audit trail for accountability and compliance.',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the Principal Investigator (PI) before this modification. Populated when modification_type is pi_change. Links to the principal_investigator record.',
    `research_award_id` BIGINT COMMENT 'Reference to the parent sponsored research award being modified. Links to the original award record in the research award system.',
    `approved_by_name` STRING COMMENT 'Name of the institutional authorized organizational representative or research administrator who approved this modification on behalf of the institution.',
    `approved_by_title` STRING COMMENT 'Title or role of the institutional representative who approved this modification. Typically Director of Sponsored Programs, Associate Vice President for Research, or Authorized Organizational Representative.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to this modification record. May include sponsor notices, revised budgets, PI (Principal Investigator) justification letters, or institutional approval forms.',
    `carryforward_amount` DECIMAL(18,2) COMMENT 'The amount of unobligated funds being carried forward to the next budget period. Populated when modification_type is carryforward_approval. Subject to sponsor policies and percentage thresholds.',
    `closeout_impact_flag` BOOLEAN COMMENT 'Indicates whether this modification affects the award closeout process, timeline, or requirements. Important for final reporting and financial reconciliation.',
    `cost_sharing_change_flag` BOOLEAN COMMENT 'Indicates whether this modification alters the institutional cost sharing commitment. Cost sharing changes require institutional approval and sponsor notification.',
    `fa_rate_change_flag` BOOLEAN COMMENT 'Indicates whether this modification includes a change to the Facilities and Administrative (F&A) cost rate (also known as Indirect Cost (IDC) rate). Typically occurs with negotiated rate agreements or budget revisions.',
    `federal_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this modification must be reported to federal agencies through Research Performance Progress Report (RPPR), Federal Financial Report (FFR), or other compliance mechanisms.',
    `institutional_approval_date` DATE COMMENT 'The date the institutions authorized organizational representative or research administration office approved the modification internally before sponsor submission or after sponsor-initiated changes.',
    `justification_narrative` STRING COMMENT 'Detailed business and scientific rationale for the modification request. Required for sponsor review and institutional approval. Explains why the change is necessary and how it supports the research objectives.',
    `modification_amount_change` DECIMAL(18,2) COMMENT 'The net change in award funding resulting from this modification. Positive for supplements and incremental funding; zero for no-cost extensions; negative for de-obligations.',
    `modification_date` DATE COMMENT 'The date on which the modification becomes effective. Typically the sponsor approval date or a future date specified in the modification agreement.',
    `modification_initiator` STRING COMMENT 'Identifies the party that initiated the modification request. Sponsor-initiated modifications are typically administrative or compliance-driven; institution-initiated modifications are requested by the PI (Principal Investigator) or research administration.. Valid values are `sponsor|institution|pi|department|compliance_office|other`',
    `modification_notes` STRING COMMENT 'Additional internal notes, comments, or administrative details about the modification. Used for institutional record-keeping and audit trail documentation.',
    `modification_number` STRING COMMENT 'Sequential or sponsor-assigned identifier for this modification within the award lifecycle. Typically follows format MOD-001, A001, or Amendment 1.',
    `modification_request_date` DATE COMMENT 'The date the institution submitted the modification request to the sponsor or initiated the internal change request.',
    `modification_status` STRING COMMENT 'Current workflow state of the modification request. Tracks progression from draft through institutional and sponsor approval to final execution or rejection. [ENUM-REF-CANDIDATE: draft|submitted|under_review|sponsor_approved|institutionally_approved|executed|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `modification_type` STRING COMMENT 'Classification of the modification action. Budget revision adjusts funding amounts; no-cost extension extends timeline without additional funds; scope change alters research objectives; PI (Principal Investigator) change updates project leadership; period extension modifies performance period; supplement adds incremental funding; carryforward approval permits unspent funds to roll forward; administrative correction fixes clerical errors. [ENUM-REF-CANDIDATE: budget_revision|no_cost_extension|scope_change|pi_change|period_extension|supplement|carryforward_approval|administrative_correction|other — 9 candidates stripped; promote to reference product]',
    `new_award_amount` DECIMAL(18,2) COMMENT 'The total award funding amount after this modification is applied. Represents the cumulative funding commitment from the sponsor.',
    `new_end_date` DATE COMMENT 'The award performance period end date after this modification is applied. Reflects timeline extensions granted through no-cost extensions or funded period extensions.',
    `new_start_date` DATE COMMENT 'The award performance period start date after this modification is applied. Captures any retroactive or prospective adjustments to the project start date.',
    `originating_request_reference` STRING COMMENT 'Reference to the internal request or workflow that initiated this modification. May link to a PI request form, departmental approval, or compliance requirement.',
    `previous_award_amount` DECIMAL(18,2) COMMENT 'The total award funding amount before this modification. Provides baseline for calculating the net change in funding.',
    `previous_end_date` DATE COMMENT 'The award performance period end date before this modification. Establishes the baseline timeline for no-cost extensions and period extensions.',
    `previous_start_date` DATE COMMENT 'The award performance period start date before this modification. Rarely changed but may be adjusted in administrative corrections or retroactive modifications.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this modification record was first created in the research administration system. Part of the audit trail for compliance and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this modification record was last updated. Tracks the most recent change to any field in the record for audit and data quality purposes.',
    `scope_change_description` STRING COMMENT 'Detailed description of changes to research objectives, aims, methodologies, or deliverables when modification_type is scope_change. Documents how the project scope is being altered.',
    `sponsor_approval_date` DATE COMMENT 'The date the sponsoring agency officially approved the modification. Critical for compliance and audit trail documentation.',
    `sponsor_modification_notice_number` STRING COMMENT 'The official notice or amendment number assigned by the sponsoring agency. Used for sponsor-initiated modifications and federal reporting.',
    `sponsor_program_officer_email` STRING COMMENT 'Email address of the sponsoring agency program officer for correspondence regarding this modification.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sponsor_program_officer_name` STRING COMMENT 'Name of the sponsoring agency program officer or grants management specialist who processed and approved this modification on the sponsor side.',
    `terms_and_conditions_updated_flag` BOOLEAN COMMENT 'Indicates whether this modification includes changes to the award terms and conditions, special conditions, or compliance requirements.',
    CONSTRAINT pk_award_modification PRIMARY KEY(`award_modification_id`)
) COMMENT 'Transactional record capturing formal modifications to an existing sponsored research award, including sponsor-initiated amendments and institution-initiated change requests. Captures modification number, modification type (budget revision, no-cost extension, scope change, PI change, period extension, supplement, carryforward approval), modification date, previous award amount, new award amount, previous end date, new end date, justification narrative, sponsor approval date, modification status, and originating request reference. Provides a complete audit trail of award changes required for federal compliance and closeout.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`conflict_of_interest` (
    `conflict_of_interest_id` BIGINT COMMENT 'Primary key for conflict_of_interest',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: COI disclosures managed in specialized compliance systems (COI module in Kuali Research, standalone COI systems). Business need: system integration for disclosure tracking, compliance reporting, audit',
    `principal_investigator_id` BIGINT COMMENT 'Identifier of the investigator making the disclosure.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: COI disclosures implement 42 CFR 50 Subpart F (PHS) and NSF financial conflict regulations. Required for sponsor reporting, FCOI public accessibility requirements, and retrospective review compliance.',
    `research_award_id` BIGINT COMMENT 'Identifier of the sponsored research award to which this disclosure relates.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: COI disclosure review assigned to specific compliance officer for relatedness determination, FCOI finding, and management plan oversight per PHS and NSF regulations. Essential for compliance office wo',
    `annual_update_date` DATE COMMENT 'Date of the most recent annual update to the conflict of interest disclosure, as required by PHS FCOI regulations for ongoing disclosures.',
    `bias_finding_flag` BOOLEAN COMMENT 'Indicates whether the retrospective review identified bias in the design, conduct, or reporting of the PHS-funded research.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations recorded by the reviewer or investigator regarding the disclosure.',
    `disclosure_date` DATE COMMENT 'Date on which the investigator submitted the conflict of interest disclosure.',
    `disclosure_number` STRING COMMENT 'Business identifier for the conflict of interest disclosure, typically assigned by the institutional FCOI office or Kuali Research system.',
    `disclosure_period_end_date` DATE COMMENT 'End date of the period covered by this disclosure.',
    `disclosure_period_start_date` DATE COMMENT 'Start date of the period covered by this disclosure, typically the 12-month period preceding the disclosure.',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the conflict of interest disclosure.. Valid values are `draft|submitted|under_review|approved|rejected|closed`',
    `dollar_value_range` STRING COMMENT 'Range of dollar value for the significant financial interest, as required by PHS FCOI regulations.. Valid values are `0_to_5000|5001_to_10000|10001_to_20000|20001_to_100000|over_100000|not_disclosed`',
    `entity_name` STRING COMMENT 'Name of the external entity (company, organization, institution) with which the investigator has a significant financial interest.',
    `entity_type` STRING COMMENT 'Type of external entity (publicly traded corporation, privately held company, nonprofit organization, government agency, academic institution, or other).. Valid values are `publicly_traded|privately_held|nonprofit|government|academic|other`',
    `fcoi_finding_date` DATE COMMENT 'Date on which the institutional FCOI office made the FCOI finding determination.',
    `fcoi_finding_flag` BOOLEAN COMMENT 'Indicates whether the institutional FCOI office determined that a financial conflict of interest exists (true if FCOI exists, false if no FCOI).',
    `kuali_research_disclosure_number` STRING COMMENT 'External system identifier from Kuali Research system where the disclosure was originally created and managed.',
    `management_plan_approval_date` DATE COMMENT 'Date on which the institutional FCOI office or designated official approved the management plan.',
    `management_plan_approved_by` STRING COMMENT 'Name and title of the institutional official who approved the management plan.',
    `management_plan_description` STRING COMMENT 'Detailed description of the management plan implemented to manage, reduce, or eliminate the FCOI, including specific conditions and restrictions imposed.',
    `management_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a management plan is required to manage, reduce, or eliminate the identified financial conflict of interest.',
    `mitigation_report_date` DATE COMMENT 'Date on which the mitigation report was submitted to the PHS awarding component.',
    `mitigation_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether a mitigation report was submitted to the PHS awarding component documenting actions taken to eliminate or mitigate the effect of bias found in the retrospective review.',
    `public_accessibility_date` DATE COMMENT 'Date on which the FCOI information was made publicly accessible, typically via institutional website or public registry.',
    `public_accessibility_flag` BOOLEAN COMMENT 'Indicates whether information about this FCOI must be made publicly accessible, as required by PHS FCOI regulations for certain senior/key personnel.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this conflict of interest disclosure record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this conflict of interest disclosure record was last updated in the system.',
    `relatedness_determination` STRING COMMENT 'Determination by the institutional FCOI office as to whether the significant financial interest is related to the investigators institutional responsibilities and sponsored research.. Valid values are `related|not_related|pending_review`',
    `relatedness_determination_date` DATE COMMENT 'Date on which the institutional FCOI office made the relatedness determination.',
    `relatedness_justification` STRING COMMENT 'Justification and rationale for the relatedness determination, documenting why the SFI is or is not related to institutional responsibilities.',
    `retrospective_review_completion_date` DATE COMMENT 'Date on which the retrospective review of the investigators research was completed.',
    `retrospective_review_required_flag` BOOLEAN COMMENT 'Indicates whether a retrospective review of the investigators research is required due to failure to comply with FCOI policy or management plan.',
    `review_completion_date` DATE COMMENT 'Date on which the institutional review of the disclosure was completed.',
    `sfi_description` STRING COMMENT 'Detailed description of the significant financial interest, including nature of the relationship and activities involved.',
    `sfi_type` STRING COMMENT 'Type of significant financial interest disclosed by the investigator (equity ownership, income, intellectual property rights, board position, consulting arrangement, or other).. Valid values are `equity|income|intellectual_property|board_position|consulting|other`',
    `sponsor_notification_date` DATE COMMENT 'Date on which the institution notified the PHS awarding component (NSF, NIH, etc.) of the identified FCOI.',
    `sponsor_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the institution is required to notify the PHS awarding component of the identified FCOI prior to expenditure of funds.',
    CONSTRAINT pk_conflict_of_interest PRIMARY KEY(`conflict_of_interest_id`)
) COMMENT 'Master record tracking financial conflict of interest (FCOI) disclosures made by investigators on sponsored research projects. Captures investigator ID, disclosure date, disclosure period, significant financial interest (SFI) type (equity, income, intellectual property), entity name, dollar value range, relatedness determination, FCOI finding (yes/no), management plan required flag, management plan description, management plan approval date, annual update date, and disclosure status. Required under 42 CFR Part 50 Subpart F (PHS FCOI regulations) and institutional FCOI policy.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`award_account` (
    `award_account_id` BIGINT COMMENT 'Unique identifier for the award account record. Primary key for the award account entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Financial account management assigned to specific grant accountant or business officer for reconciliation, financial reporting, and closeout. Critical for post-award office portfolio management and ef',
    `award_budget_id` BIGINT COMMENT 'Foreign key linking to research.award_budget. Business justification: Award accounts are established based on approved budgets. The accounts total_authorized_budget comes from a specific approved budget version. Adding award_budget_id FK links the account to its govern',
    `idc_rate_id` BIGINT COMMENT 'Foreign key linking to research.idc_rate. Business justification: award_account has fa_rate_percentage and idc_rate_type which should be normalized via FK to idc_rate master table. Award accounts apply specific negotiated IDC rate agreements; linking provides full r',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Award accounts fund building operations, maintenance, and utilities. Financial reporting and cost allocation require linking accounts to buildings for facilities cost recovery, utility chargeback calc',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Award accounts pay for room-specific costs including lab setup, specialized equipment, and room modifications. Space chargeback systems and cost allocation models require room-level account linkage fo',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the Principal Investigator responsible for this award account. The PI has primary accountability for scientific and financial stewardship of the project.',
    `research_award_id` BIGINT COMMENT 'Reference to the sponsored research award that this account was established to support. Links the financial account to the underlying award agreement.',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to research.sponsor. Business justification: award_account has sponsor_agency_name which should be normalized via FK to sponsor master table. This allows joining to get full sponsor details (type, contact info, payment terms, etc.) rather than s',
    `account_close_date` DATE COMMENT 'The date the award account was officially closed after all expenditures were finalized, final reports submitted, and residual balances resolved. Nullable for active accounts.',
    `account_notes` STRING COMMENT 'Free-text field for grants accounting staff to record special instructions, restrictions, compliance notes, or other important information about this award account.',
    `account_number` STRING COMMENT 'The institutional project or grant account number assigned by grants accounting or the ERP system. This is the externally-known identifier used in financial transactions, journal entries, and sponsor reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `account_open_date` DATE COMMENT 'The date the award account was opened and made available for charging expenditures. Typically coincides with the award start date or the date of award execution.',
    `account_status` STRING COMMENT 'Current lifecycle status of the award account. Open accounts accept charges; restricted accounts require special approval; closed accounts are finalized; pending closeout accounts are in the 90-day closeout window; suspended accounts are temporarily frozen; pre-award accounts are established before formal award receipt.. Valid values are `open|restricted|closed|pending_closeout|suspended|pre_award`',
    `account_title` STRING COMMENT 'Descriptive title of the award account, typically derived from the project title or sponsor program name. Used for human-readable identification in financial reports and dashboards.',
    `activity_type` STRING COMMENT 'The primary functional category of sponsored activity supported by this account. Used for IPEDS reporting and institutional cost allocation.. Valid values are `research|instruction|public_service|other_sponsored`',
    `available_balance` DECIMAL(18,2) COMMENT 'The remaining unspent and unencumbered budget available for new commitments. Calculated as total authorized budget minus expenditures minus encumbrances.',
    `award_type` STRING COMMENT 'The legal instrument type under which the award was made. Determines compliance requirements, intellectual property rights, and reporting obligations.. Valid values are `grant|contract|cooperative_agreement|subaward|gift`',
    `budget_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the budget and financial amounts in this award account (e.g., USD, EUR, GBP). Most U.S. institutions use USD exclusively.. Valid values are `^[A-Z]{3}$`',
    `cfda_number` STRING COMMENT 'The CFDA number identifying the federal program under which this award was made. Required for federal awards and used in Single Audit reporting and SEFA schedules.. Valid values are `^[0-9]{2}.[0-9]{3}$`',
    `cost_sharing_account_flag` BOOLEAN COMMENT 'Indicates whether this account is designated for tracking institutional cost sharing or matching contributions required by the sponsor. True if this is a cost-sharing account.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'The total amount of committed institutional cost sharing or matching funds for this award, as specified in the proposal and award agreement. Must be tracked and documented per sponsor requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this award account record was first created in the system. Used for audit trail and data lineage tracking.',
    `erp_project_code` STRING COMMENT 'The project or grant identifier in the institutional ERP system (Oracle PeopleSoft Financials) that corresponds to this award account. Used for system integration and financial transaction posting.. Valid values are `^[A-Z0-9]{6,30}$`',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether this award involves research subject to export control regulations (ITAR, EAR) requiring special compliance procedures and technology transfer review.',
    `fa_recovery_account_linkage` STRING COMMENT 'The institutional account number where recovered F&A (indirect cost) revenue from this award is deposited. Links the project account to the institutional IDC recovery distribution mechanism.. Valid values are `^[A-Z0-9]{6,20}$`',
    `fund_code` STRING COMMENT 'The institutional fund code or fund type that classifies the source of funds for this account (e.g., federal, state, private foundation, corporate). Used for financial reporting and compliance segregation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `human_subjects_flag` BOOLEAN COMMENT 'Indicates whether this award involves research with human subjects requiring Institutional Review Board (IRB) oversight and approval per federal regulations.',
    `last_financial_report_date` DATE COMMENT 'The date the most recent financial report (Federal Financial Report, invoice, or expenditure report) was submitted to the sponsor for this award account.',
    `modified_by` STRING COMMENT 'The username or identifier of the system user who last modified this award account record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time this award account record was last modified. Updated whenever any field in the record changes. Used for audit trail and change tracking.',
    `mtdc_base` DECIMAL(18,2) COMMENT 'The Modified Total Direct Cost base amount used for calculating F&A costs. Excludes equipment, capital expenditures, subaward amounts over $25K, and other items per 2 CFR 200.',
    `next_financial_report_due_date` DATE COMMENT 'The date the next financial report is due to the sponsor per the award terms and reporting schedule. Used for compliance tracking and deadline management.',
    `organization_code` STRING COMMENT 'The institutional organization or department code responsible for administering this award account. Typically the PIs home department or the lead research unit.. Valid values are `^[A-Z0-9]{2,10}$`',
    `project_end_date` DATE COMMENT 'The official end date of the project period of performance as specified in the award agreement. Defines the end of the allowable cost period, after which closeout procedures begin.',
    `project_start_date` DATE COMMENT 'The official start date of the project period of performance as specified in the award agreement. Defines the beginning of the allowable cost period.',
    `residual_balance_disposition` STRING COMMENT 'Specifies how any remaining unspent balance at account closeout will be handled per sponsor terms and institutional policy. Options include returning funds to sponsor, retaining for institutional use, transferring to PI discretionary account, or carrying forward to a continuation award.. Valid values are `return_to_sponsor|retain_institutional|transfer_to_pi|carryforward_approved`',
    `sponsor_award_number` STRING COMMENT 'The unique award or grant number assigned by the sponsoring agency. This is the external identifier used in all sponsor correspondence and reporting.',
    `total_authorized_budget` DECIMAL(18,2) COMMENT 'The total budget amount authorized by the sponsor for this award account, including all approved modifications and amendments. Represents the cumulative funding ceiling.',
    `total_encumbrances` DECIMAL(18,2) COMMENT 'The total amount of outstanding commitments and obligations (purchase orders, contracts, payroll commitments) that have been encumbered against this award account but not yet expended.',
    `total_expenditures_to_date` DECIMAL(18,2) COMMENT 'The cumulative total of all posted expenditures charged to this award account from inception through the current reporting period. Includes direct and indirect costs.',
    `unrecovered_fa_amount` DECIMAL(18,2) COMMENT 'The amount of F&A costs that were incurred but not recovered from the sponsor due to rate caps, waivers, or sponsor policy limitations. Represents institutional cost sharing.',
    `vertebrate_animals_flag` BOOLEAN COMMENT 'Indicates whether this award involves research with vertebrate animals requiring Institutional Animal Care and Use Committee (IACUC) oversight and approval per federal regulations.',
    `created_by` STRING COMMENT 'The username or identifier of the system user who created this award account record. Used for audit trail and accountability.',
    CONSTRAINT pk_award_account PRIMARY KEY(`award_account_id`)
) COMMENT 'Master record for the institutional financial account (project/grant account) established to receive and track expenditures for a sponsored research award. Captures account number (project ID), account title, fund code, organization code, PI employee ID, award ID, account open date, account close date, total authorized budget, total expenditures to date, total encumbrances, available balance, account status (open, restricted, closed, pending closeout), cost-sharing account flag, residual balance disposition, F&A recovery account linkage, and ERP project ID. The financial SSOT linking research awards to institutional accounting within the research domain. Distinct from the finance domains general ledger accounts — this is the research-specific project account managed by grants accounting staff.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`proposal_personnel` (
    `proposal_personnel_id` BIGINT COMMENT 'Unique identifier for the proposal personnel association record. Primary key for this entity.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: Research personnel often include alumni postdocs, research scientists, or collaborators. Advancement needs this for engagement tracking, prospect identification, and demonstrating continued institutio',
    `compliance_training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: Research personnel must complete protocol-specific training (IRB, IACUC, biosafety) before project work begins. Required for protocol approval, personnel authorization lists, and regulatory compliance',
    `employee_id` BIGINT COMMENT 'Reference to the individual assigned to this proposal. May link to employee, faculty, or external collaborator records.',
    `identity_account_id` BIGINT COMMENT 'Identifier of the system user who added this personnel member to the proposal.',
    `last_modified_by_user_identity_account_id` BIGINT COMMENT 'Identifier of the system user who last modified this personnel record.',
    `proposal_id` BIGINT COMMENT 'Reference to the grant proposal to which this personnel member is assigned.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Graduate students listed as proposal personnel receive tuition and stipend support from awarded grants. Universities must track which student accounts are funded by which proposals for financial aid p',
    `student_athlete_id` BIGINT COMMENT 'Foreign key linking to athletics.student_athlete. Business justification: Identifies student-athletes employed as research assistants on grant proposals. Required for effort certification, eligibility verification (employment cannot exceed NCAA limits), and institutional re',
    `academic_rank` STRING COMMENT 'Academic or professional rank of the personnel member at the time of proposal submission. Used for biosketches and to determine eligibility for certain roles (e.g., PI eligibility often requires faculty rank). [ENUM-REF-CANDIDATE: Professor|Associate Professor|Assistant Professor|Instructor|Lecturer|Research Scientist|Postdoctoral Associate|Graduate Student|Undergraduate Student|Staff — 10 candidates stripped; promote to reference product]',
    `academic_year_effort_percentage` DECIMAL(18,2) COMMENT 'Percentage of the individuals academic year time (typically 9 months for faculty on academic-year appointments) committed to this project. Expressed as a percentage (0.00 to 100.00). Used for effort reporting and budget justification.',
    `added_date` DATE COMMENT 'Date this personnel member was added to the proposal team.',
    `appointment_type` STRING COMMENT 'Type of appointment for this personnel member on the project. Academic Year (9-month) is typical for faculty. Calendar Year (12-month) is typical for research staff. Summer appointments are for faculty during summer months. Hourly is for part-time or student workers. Stipend is for graduate students and postdocs receiving fixed payments.. Valid values are `Academic Year|Calendar Year|Summer|Hourly|Stipend`',
    `biosketch_required_flag` BOOLEAN COMMENT 'Indicates whether a biographical sketch (biosketch) is required for this personnel member as part of the proposal submission. Typically required for PI, Co-PIs, and senior personnel; not required for graduate students or undergraduates.',
    `biosketch_submitted_flag` BOOLEAN COMMENT 'Indicates whether the biographical sketch for this personnel member has been submitted as part of the proposal package.',
    `calendar_year_effort_percentage` DECIMAL(18,2) COMMENT 'Percentage of the individuals calendar year time (12 months) committed to this project. Expressed as a percentage (0.00 to 100.00). Used for personnel on 12-month appointments or when aggregating academic year and summer effort.',
    `citizenship_status` STRING COMMENT 'Citizenship or visa status of the personnel member. Required for certain sponsor programs (e.g., Department of Defense, Department of Energy) and for export control compliance.. Valid values are `US Citizen|Permanent Resident|Temporary Visa|Foreign National`',
    `college_school_name` STRING COMMENT 'Name of the college or school to which the personnel members home department belongs. Higher-level organizational unit in the institutional hierarchy.',
    `conflict_of_interest_disclosed_flag` BOOLEAN COMMENT 'Indicates whether this personnel member has disclosed any financial or personal conflicts of interest related to this proposal, as required by institutional policy and federal regulations.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'Amount of this individuals compensation that will be cost-shared (contributed by the institution rather than charged to the sponsor). Cost sharing may be mandatory (required by the sponsor) or voluntary (offered by the institution).',
    `current_and_pending_required_flag` BOOLEAN COMMENT 'Indicates whether a Current and Pending Support document is required for this personnel member. Required for senior personnel to disclose all current and pending research support to identify potential overlaps and conflicts.',
    `current_and_pending_submitted_flag` BOOLEAN COMMENT 'Indicates whether the Current and Pending Support document for this personnel member has been submitted as part of the proposal package.',
    `email_address` STRING COMMENT 'Primary institutional email address for the personnel member. Used for proposal communications and sponsor correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'First (given) name of the personnel member as it appears on the proposal and biosketches submitted to sponsors.',
    `fringe_benefit_amount` DECIMAL(18,2) COMMENT 'Total fringe benefit cost for this individual, calculated by applying the fringe benefit rate to the proposed salary amount. Part of the total personnel cost in the proposal budget.',
    `fringe_benefit_rate_percentage` DECIMAL(18,2) COMMENT 'Institutional fringe benefit rate applied to this individuals salary. Covers benefits such as health insurance, retirement contributions, and other employee benefits. Rate is typically negotiated with the federal government and varies by employee category.',
    `home_department_code` STRING COMMENT 'Code identifying the personnel members primary academic or administrative department. Used for effort reporting and cost allocation.',
    `home_department_name` STRING COMMENT 'Name of the personnel members primary academic or administrative department.',
    `institutional_base_salary` DECIMAL(18,2) COMMENT 'The individuals institutional base salary at the time of proposal submission. Used to calculate the proposed salary amount based on effort percentage. IBS is the annual compensation paid by the institution for an individuals appointment, whether that individuals time is spent on research, teaching, or other activities.',
    `key_personnel_flag` BOOLEAN COMMENT 'Indicates whether this individual is designated as key personnel on the project. Key personnel are individuals who contribute in a substantive, measurable way to the scientific development or execution of the project, whether or not they receive salaries or compensation.',
    `last_modified_date` DATE COMMENT 'Date this personnel record was last modified.',
    `last_name` STRING COMMENT 'Last (family) name of the personnel member as it appears on the proposal and biosketches submitted to sponsors.',
    `middle_name` STRING COMMENT 'Middle name or initial of the personnel member.',
    `orcid_identifier` STRING COMMENT 'Unique persistent digital identifier for this researcher, assigned by ORCID. Increasingly required by sponsors (NSF, NIH) to disambiguate researchers and link their scholarly activities. Format: 0000-0000-0000-0000.. Valid values are `^d{4}-d{4}-d{4}-d{3}[0-9X]$`',
    `person_months` DECIMAL(18,2) COMMENT 'Total person months of effort committed by this individual to the project over the entire project period. Calculated by multiplying the effort percentage by the number of months in the project period. Used in budget justification and effort reporting.',
    `personnel_notes` STRING COMMENT 'Free-text notes or comments about this personnel members role, qualifications, or participation in the proposal. Used for internal coordination and budget justification preparation.',
    `personnel_status` STRING COMMENT 'Current status of this personnel members participation in the proposal. Proposed indicates initial inclusion in the proposal. Confirmed indicates the individual has agreed to participate. Declined indicates the individual has declined participation. Replaced indicates the individual was substituted with another person. Removed indicates the individual was removed from the proposal team.. Valid values are `Proposed|Confirmed|Declined|Replaced|Removed`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the personnel member.',
    `proposed_salary_amount` DECIMAL(18,2) COMMENT 'Total salary amount requested for this individual on this proposal, calculated based on institutional base salary and proposed effort. Includes academic year and summer salary components. Expressed in the proposals budget currency.',
    `role_type` STRING COMMENT 'The role this individual will serve on the proposed project. PI (Principal Investigator) is the lead researcher responsible for the scientific and administrative conduct of the project. Co-PI (Co-Principal Investigator) shares leadership responsibilities. Senior Personnel includes faculty and other professionals with significant roles. Postdoctoral Associates, Graduate Research Assistants, and Undergraduate Researchers are trainees supported by the project.. Valid values are `PI|Co-PI|Senior Personnel|Postdoctoral Associate|Graduate Research Assistant|Undergraduate Researcher`',
    `summer_effort_percentage` DECIMAL(18,2) COMMENT 'Percentage of the individuals summer time (typically 3 months for faculty on academic-year appointments) committed to this project. Expressed as a percentage (0.00 to 100.00). Summer salary is often requested for faculty on 9-month appointments.',
    `total_compensation_amount` DECIMAL(18,2) COMMENT 'Total compensation requested for this individual, including both salary and fringe benefits. Sum of proposed_salary_amount and fringe_benefit_amount.',
    CONSTRAINT pk_proposal_personnel PRIMARY KEY(`proposal_personnel_id`)
) COMMENT 'Association record linking personnel (PI, Co-PI, senior personnel, graduate students, postdocs) to a specific grant proposal with their proposed role, effort, and compensation. Captures proposal ID, person ID, person name, role type (PI, Co-PI, Senior Personnel, Postdoctoral Associate, Graduate Research Assistant, Undergraduate Researcher), proposed effort percentage (academic year, summer, calendar year), proposed salary, fringe benefit rate, appointment type, and person status on proposal. Supports NSF and NIH biosketches, senior personnel listings, and budget justification requirements.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`award_report` (
    `award_report_id` BIGINT COMMENT 'Unique identifier for the award report record. Primary key.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Award reports submitted by users with institutional accounts. Business need: audit trails for report submissions, authentication verification, compliance tracking for sponsor reporting requirements, i',
    `employee_id` BIGINT COMMENT 'Reference to the research administrator or staff member responsible for preparing and submitting this report.',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the Principal Investigator (PI) responsible for the scientific and technical content of the report.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Award reports (RPPR, final technical reports, invention statements) are regulatory filings to federal agencies. Links report to filing tracking for compliance monitoring, late submission penalties, an',
    `research_award_id` BIGINT COMMENT 'Reference to the sponsored research award under which this report is required.',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to research.sponsor. Business justification: award_report has sponsor_agency_name which should be normalized via FK to sponsor master table. Reports are submitted to sponsors; linking provides full sponsor contact and submission system details.',
    `compliance_review_completed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the required compliance review has been completed.',
    `compliance_review_date` DATE COMMENT 'The date on which the compliance review was completed. Null if review not yet completed.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the report requires institutional compliance review before submission (e.g., export control review, conflict of interest review).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this award report record was first created in the system.',
    `days_overdue` STRING COMMENT 'Number of days the report is overdue, calculated as the difference between the current date (or submission date) and the due date. Null or zero if not overdue.',
    `due_date` DATE COMMENT 'The date by which the report must be submitted to the sponsor as specified in the award terms and conditions.',
    `extended_due_date` DATE COMMENT 'The revised due date if an extension was granted by the sponsor. Null if no extension was granted.',
    `extension_granted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the sponsor granted an extension to the report due date.',
    `extension_requested_flag` BOOLEAN COMMENT 'Boolean indicator of whether an extension to the report due date has been requested from the sponsor.',
    `federal_reporting_system` STRING COMMENT 'Name of the federal reporting system used for submission if the sponsor is a federal agency (e.g., Research Performance Progress Report (RPPR) system, Federal Financial Report (FFR) system).',
    `institutional_official_approval_date` DATE COMMENT 'The date on which the institutional authorized official (e.g., Dean of Research, Vice President for Research) approved the report for submission. Required for certain federal reports.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this award report record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this award report record was last modified.',
    `overdue_flag` BOOLEAN COMMENT 'Boolean indicator of whether the report is overdue (True if current date is past due date and report has not been submitted).',
    `pi_approval_date` DATE COMMENT 'The date on which the Principal Investigator (PI) approved the report for submission. Null if not yet approved.',
    `pi_approval_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the Principal Investigator (PI) must formally approve the report before submission.',
    `report_document_reference` STRING COMMENT 'Reference identifier or file path to the submitted report document stored in the institutional document management system.',
    `report_frequency` STRING COMMENT 'The frequency with which this type of report is required under the award terms (e.g., annual, semi-annual, quarterly, final only, ad hoc).. Valid values are `annual|semi_annual|quarterly|final_only|ad_hoc`',
    `report_notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the report preparation or submission.',
    `report_number` STRING COMMENT 'Business identifier for the report, often assigned by the institution or sponsor.',
    `report_sequence_number` STRING COMMENT 'Sequential number indicating the order of this report within the series of reports required for the award (e.g., 1 for first annual report, 2 for second annual report).',
    `report_status` STRING COMMENT 'Current lifecycle status of the report submission. Tracks whether the report is pending preparation, has been submitted, accepted by the sponsor, overdue, or waived.. Valid values are `pending|submitted|accepted|overdue|waived`',
    `report_type` STRING COMMENT 'Classification of the report required by the sponsor. Common types include progress reports, final technical reports, Federal Financial Report (SF-425), invention disclosures, equipment reports, and property reports.. Valid values are `progress_report|final_technical_report|federal_financial_report_sf425|invention_disclosure|equipment_report|property_report`',
    `reporting_period_end_date` DATE COMMENT 'The end date of the period covered by this report.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the period covered by this report.',
    `sponsor_acknowledgment_date` DATE COMMENT 'The date on which the sponsor formally acknowledged receipt or acceptance of the report. Null if not yet acknowledged.',
    `sponsor_program_name` STRING COMMENT 'Name of the specific sponsor program or funding opportunity under which the award and report requirement fall.',
    `sponsor_report_number` STRING COMMENT 'Unique identifier assigned by the sponsor to the submitted report, if applicable. Used for tracking and correspondence with the sponsor.',
    `submission_date` DATE COMMENT 'The actual date on which the report was submitted to the sponsor. Null if not yet submitted.',
    `submission_method` STRING COMMENT 'The channel or system through which the report was submitted to the sponsor. Common methods include Research.gov, Grants.gov, email, postal mail, sponsor-specific portals, NSF FastLane, and NIH eRA Commons. [ENUM-REF-CANDIDATE: research_gov|grants_gov|email|postal_mail|sponsor_portal|fastlane|era_commons — 7 candidates stripped; promote to reference product]',
    `waiver_reason` STRING COMMENT 'Explanation or justification for why the report requirement was waived by the sponsor. Populated only if report_status is waived.',
    `created_by` STRING COMMENT 'User identifier of the person who created this award report record.',
    CONSTRAINT pk_award_report PRIMARY KEY(`award_report_id`)
) COMMENT 'Transactional record tracking required technical and financial reports due to sponsors under the terms of a sponsored research award. Captures report type (progress report, final technical report, federal financial report SF-425, invention disclosure, equipment report, property report), due date, submission date, reporting period start/end, submission status (pending, submitted, accepted, overdue, waived), submission method, sponsor acknowledgment date, report document reference, and responsible staff. Supports sponsor compliance monitoring and institutional research reporting obligations.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`invention_disclosure` (
    `invention_disclosure_id` BIGINT COMMENT 'Unique identifier for the invention disclosure record. Primary key.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: Alumni inventors are high-value prospects. Advancement tracks commercialization success, patent portfolios, and startup founders for major gift cultivation. Invention disclosures demonstrate continued',
    `employee_id` BIGINT COMMENT 'Employee identifier of the primary inventor, linking to the institutional human resources system.',
    `research_award_id` BIGINT COMMENT 'Foreign key reference to the research award that funded the work leading to this invention, if applicable.',
    `bayh_dole_report_date` DATE COMMENT 'The date on which the invention disclosure was reported to the federal funding agency.',
    `bayh_dole_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the required invention disclosure report has been submitted to the federal funding agency under Bayh-Dole Act obligations.',
    `co_inventor_names` STRING COMMENT 'Semicolon-separated list of all co-inventors who contributed to the invention, excluding the primary inventor.',
    `commercialization_stage` STRING COMMENT 'Current stage of the inventions development and commercialization pathway.. Valid values are `concept|prototype|clinical_trial|market_ready|commercialized|discontinued`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invention disclosure record was first created in the system.',
    `disclosure_date` DATE COMMENT 'The date on which the invention disclosure was formally submitted to the Office of Technology Commercialization.',
    `disclosure_number` STRING COMMENT 'Institution-assigned unique business identifier for the invention disclosure, typically formatted with prefix and sequential number (e.g., OTC-2024-00123).. Valid values are `^[A-Z]{2,4}-d{4}-d{3,5}$`',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the invention disclosure in the technology transfer process. [ENUM-REF-CANDIDATE: draft|submitted|under_review|evaluated|patent_filed|licensed|abandoned|closed — 8 candidates stripped; promote to reference product]',
    `disclosure_title` STRING COMMENT 'The formal title or name of the invention as provided by the inventor(s).',
    `federal_agency_name` STRING COMMENT 'Name of the federal agency that provided funding for the research (e.g., NSF, NIH, DOE), if applicable.',
    `federal_funding_flag` BOOLEAN COMMENT 'Indicates whether the invention was developed with federal government funding, triggering Bayh-Dole Act reporting obligations.',
    `invention_category` STRING COMMENT 'Classification of the invention type based on its technical domain and nature. [ENUM-REF-CANDIDATE: software|hardware|biotechnology|pharmaceutical|medical_device|chemical_composition|process_method|other — 8 candidates stripped; promote to reference product]',
    `invention_description` STRING COMMENT 'Detailed narrative description of the invention, including technical specifications, novel features, and potential applications.',
    `inventor_department_code` STRING COMMENT 'The academic or administrative department code of the primary inventor at the time of disclosure.',
    `inventor_department_name` STRING COMMENT 'The full name of the academic or administrative department of the primary inventor.',
    `inventor_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of net revenue allocated to the inventor(s) per institutional intellectual property policy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invention disclosure record was most recently updated.',
    `license_execution_date` DATE COMMENT 'The date on which the license or option agreement was executed.',
    `licensee_organization_name` STRING COMMENT 'Name of the company or organization that has licensed or optioned the invention for commercialization.',
    `licensing_status` STRING COMMENT 'Current status of commercialization licensing efforts for the invention.. Valid values are `not_licensed|under_negotiation|licensed_exclusive|licensed_non_exclusive|option_granted|terminated`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to the invention disclosure.',
    `patent_application_number` STRING COMMENT 'The official application number assigned by the USPTO or international patent office (e.g., PCT application number).',
    `patent_counsel_name` STRING COMMENT 'Name of the patent attorney or law firm handling patent prosecution for this invention.',
    `patent_filing_date` DATE COMMENT 'The date on which the patent application was filed with the USPTO or international patent office.',
    `patent_filing_decision` STRING COMMENT 'The institutions decision on whether to pursue patent protection, abandon the disclosure, or pursue licensing without patent protection.. Valid values are `file_patent|abandon|license_without_patent|pending_decision`',
    `patent_filing_decision_date` DATE COMMENT 'The date on which the institution made the decision regarding patent filing.',
    `patent_grant_date` DATE COMMENT 'The date on which the patent was officially granted by the USPTO.',
    `patent_number` STRING COMMENT 'The official patent number assigned by the USPTO upon grant of the patent.',
    `patent_status` STRING COMMENT 'Current status of the patent application or granted patent.. Valid values are `not_filed|pending|granted|rejected|abandoned|expired`',
    `patentability_assessment_date` DATE COMMENT 'The date on which the patentability assessment was completed.',
    `patentability_assessment_status` STRING COMMENT 'Status of the internal or external patentability review conducted by patent counsel or technology transfer office.. Valid values are `not_started|in_progress|completed|deferred`',
    `patentability_opinion` STRING COMMENT 'Summary of the patent counsels opinion on the likelihood of obtaining patent protection, including novelty, non-obviousness, and utility considerations.',
    `primary_inventor_name` STRING COMMENT 'Full name of the lead inventor who made the primary contribution to the invention.',
    `prior_publication_flag` BOOLEAN COMMENT 'Indicates whether the invention has been publicly disclosed through publication, presentation, or other means prior to patent filing.',
    `public_disclosure_date` DATE COMMENT 'The date on which the invention was first publicly disclosed, if applicable. Critical for determining patent filing deadlines under the one-year grace period.',
    `public_disclosure_description` STRING COMMENT 'Description of the nature and venue of the public disclosure (e.g., journal article, conference presentation, thesis defense).',
    `revenue_to_date` DECIMAL(18,2) COMMENT 'Total revenue generated from licensing, royalties, and other commercialization activities related to this invention, in USD.',
    `technology_transfer_officer_name` STRING COMMENT 'Name of the technology transfer professional assigned to manage this disclosure.',
    CONSTRAINT pk_invention_disclosure PRIMARY KEY(`invention_disclosure_id`)
) COMMENT 'Master record for an invention disclosure filed by a faculty or staff inventor with the institutions technology transfer / Office of Technology Commercialization (OTC). Captures disclosure number, invention title, inventor names, disclosure date, invention description summary, sponsoring award reference, prior publication flag, public disclosure date, patentability assessment status, patent filing decision (file/abandon/license), patent application number, patent status, licensing status, and commercialization stage. Supports Bayh-Dole Act (35 USC 200-212) reporting obligations for federally funded inventions.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`export_control_review` (
    `export_control_review_id` BIGINT COMMENT 'Unique identifier for the export control review record. Primary key for the export control review entity.',
    `employee_id` BIGINT COMMENT 'Reference to the institutional export control officer or compliance officer responsible for conducting the review and issuing the determination.',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the principal investigator responsible for the research project being reviewed.',
    `proposal_id` BIGINT COMMENT 'Reference to the research proposal if the review is conducted during the pre-award phase. May be null if review is conducted post-award.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Export control reviews assess compliance with EAR, ITAR, OFAC sanctions. Links review to specific regulatory citation (e.g., EAR 734.8 fundamental research exclusion) for audit trail and enforcement r',
    `research_award_id` BIGINT COMMENT 'Reference to the sponsored research award or project being reviewed for export control compliance. Links to the award master record.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Export control reviews conducted by compliance officers using institutional accounts. Business need: audit trails for export control determinations, access control to sensitive reviews, compliance ver',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to research.sponsor. Business justification: export_control_review has sponsor_agency_name which should be normalized via FK to sponsor master table. Export control requirements vary by sponsor (especially federal vs. foreign sponsors).',
    `access_restriction_flag` BOOLEAN COMMENT 'Indicates whether the research sponsor or project requirements impose restrictions on participation by foreign nationals or access to project information, which may disqualify the project from the fundamental research exclusion.',
    `conditions_and_restrictions` STRING COMMENT 'Detailed description of any conditions, restrictions, or control measures that must be implemented for the research project to proceed in compliance with export control regulations.',
    `countries_of_concern` STRING COMMENT 'Comma-separated list of specific countries of concern involved in the research collaboration, travel, or technology transfer, requiring heightened export control scrutiny.',
    `country_of_concern_flag` BOOLEAN COMMENT 'Indicates whether the research involves collaboration with or travel to countries designated as countries of concern under export control regulations (e.g., State Sponsors of Terrorism, Country Groups D:1, D:5, E:1, E:2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the export control review record was first created in the system, supporting audit trail and data lineage requirements.',
    `ear_applicability_flag` BOOLEAN COMMENT 'Indicates whether the Export Administration Regulations apply to the research project based on the nature of the technology, items, or activities involved.',
    `eccn_classification` STRING COMMENT 'The Export Control Classification Number assigned to the technology or items involved in the research, identifying the specific export control category under the Commerce Control List.',
    `foreign_national_count` STRING COMMENT 'Number of foreign nationals involved in the research project, used to assess the scope of potential export control exposure.',
    `foreign_national_countries` STRING COMMENT 'Comma-separated list of countries of citizenship or permanent residence for foreign nationals involved in the project, used to assess country-specific export control restrictions.',
    `foreign_national_involvement_flag` BOOLEAN COMMENT 'Indicates whether foreign nationals (non-U.S. citizens or permanent residents) are involved in the research project as researchers, collaborators, or students, which may trigger export control requirements.',
    `fundamental_research_determination_date` DATE COMMENT 'Date when the determination regarding fundamental research exclusion eligibility was made by the export control officer.',
    `fundamental_research_exclusion_flag` BOOLEAN COMMENT 'Indicates whether the research qualifies for the fundamental research exclusion under export control regulations, which exempts basic research ordinarily published and shared within the scientific community from export licensing requirements.',
    `international_collaboration_flag` BOOLEAN COMMENT 'Indicates whether the research project involves formal collaboration with foreign institutions, organizations, or researchers.',
    `international_partner_organizations` STRING COMMENT 'Names of foreign institutions or organizations collaborating on the research project, relevant for assessing export control implications of technology sharing.',
    `itar_applicability_flag` BOOLEAN COMMENT 'Indicates whether the International Traffic in Arms Regulations apply to the research project due to involvement of defense articles, defense services, or technical data on the United States Munitions List.',
    `license_exception_code` STRING COMMENT 'Specific license exception code under EAR Part 740 that applies to the research activities, if a license exception is available (e.g., TSU, ENC, RPL).',
    `license_requirement_determination` STRING COMMENT 'Final determination regarding whether an export license is required for the research activities, technology transfer, or international collaboration involved in the project.. Valid values are `no_license_required|license_required|license_exception_available|deemed_export_license_required`',
    `license_type` STRING COMMENT 'Type of export license required if applicable, such as individual validated license, deemed export license, or specific license exception category (e.g., TSU for technology and software unrestricted).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the export control review record was last modified, supporting audit trail and change tracking requirements.',
    `monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether ongoing monitoring and periodic re-review of export control compliance is required throughout the project lifecycle.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic export control review if ongoing monitoring is required, typically for long-duration projects or high-risk activities.',
    `ofac_sanctioned_parties` STRING COMMENT 'Names of any sanctioned countries, entities, or individuals identified in the research project that trigger OFAC compliance requirements.',
    `ofac_sanctions_applicability_flag` BOOLEAN COMMENT 'Indicates whether Office of Foreign Assets Control sanctions apply to the research project due to involvement of sanctioned countries, entities, or individuals.',
    `project_description` STRING COMMENT 'Detailed description of the research project scope, objectives, and activities relevant to export control assessment.',
    `project_title` STRING COMMENT 'Title of the research project or sponsored activity being reviewed for export control compliance.',
    `publication_restriction_flag` BOOLEAN COMMENT 'Indicates whether the research sponsor has imposed restrictions on publication or dissemination of research results, which may disqualify the project from the fundamental research exclusion.',
    `review_completion_date` DATE COMMENT 'Date when the export control review was completed and a final determination was issued by the export control officer.',
    `review_number` STRING COMMENT 'Business identifier for the export control review, typically assigned by the export control office for tracking and reference purposes.',
    `review_outcome` STRING COMMENT 'Final outcome of the export control review, indicating whether the project may proceed without restrictions, requires specific conditions or controls, needs export licensing, requires modification, or is denied.. Valid values are `approved_no_restrictions|approved_with_conditions|license_required|project_modification_required|denied|referred_to_legal`',
    `review_request_date` DATE COMMENT 'Date when the export control review was formally requested by the principal investigator, department, or research administration office.',
    `review_status` STRING COMMENT 'Current lifecycle status of the export control review process, tracking progression from request through completion and final determination. [ENUM-REF-CANDIDATE: requested|in_progress|pending_information|under_review|completed|approved|denied — 7 candidates stripped; promote to reference product]',
    `review_type` STRING COMMENT 'Classification of the review based on its purpose: initial review for new projects, modification review for scope changes, renewal for continuing projects, closeout review at project end, ad hoc review for specific concerns, or incident response review following a potential violation.. Valid values are `initial|modification|renewal|closeout|ad_hoc|incident_response`',
    `reviewer_notes` STRING COMMENT 'Internal notes and observations recorded by the export control officer during the review process, documenting analysis, concerns, and rationale for determinations.',
    `risk_level` STRING COMMENT 'Overall risk assessment for export control compliance based on the nature of the technology, countries involved, and potential for unauthorized technology transfer.. Valid values are `low|moderate|high|critical`',
    `technology_description` STRING COMMENT 'Detailed description of the technology, technical data, software, or controlled items involved in the research that may be subject to export control regulations.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether export control training is required for the principal investigator and research team members as a condition of project approval.',
    `usml_category` STRING COMMENT 'The category on the United States Munitions List that applies to the defense articles or technical data involved in the research, if ITAR-controlled.',
    CONSTRAINT pk_export_control_review PRIMARY KEY(`export_control_review_id`)
) COMMENT 'Master record for an export control review conducted on a sponsored research project, technology, or international collaboration to assess compliance with EAR (Export Administration Regulations), ITAR (International Traffic in Arms Regulations), and OFAC sanctions. Captures review request date, project or award reference, technology description, foreign national involvement flag, country of concern flag, fundamental research exclusion determination, license requirement determination, license type if required, review completion date, review outcome, and responsible export control officer. Required for institutional compliance with federal export control laws.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`compliance_event` (
    `compliance_event_id` BIGINT COMMENT 'Primary key for compliance_event',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Research compliance events (protocol deviations, cost allocation errors, subrecipient monitoring failures) often result from or trigger audit findings. Required for corrective action tracking and Sing',
    `conflict_of_interest_id` BIGINT COMMENT 'Foreign key linking to research.conflict_of_interest. Business justification: Compliance events can be triggered by COI findings (e.g., undisclosed financial interests, failure to implement management plan). Adding conflict_of_interest_id FK links compliance events to their ori',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Compliance events require documented corrective action plans per institutional policy and federal requirements. Links event to CAP for closure tracking, sponsor reporting, and repeat finding preventio',
    `export_control_review_id` BIGINT COMMENT 'Foreign key linking to research.export_control_review. Business justification: Compliance events can be triggered by export control findings (e.g., unauthorized technology transfer, foreign national access violations). Adding export_control_review_id FK links compliance events t',
    `iacuc_protocol_id` BIGINT COMMENT 'Reference to the IACUC protocol associated with this compliance event, if applicable to vertebrate animal research.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to technology.incident. Business justification: Research compliance events (data breaches, unauthorized access to research data, IRB violations) often trigger IT security incidents. Business need: coordinated incident response, root cause analysis,',
    `irb_protocol_id` BIGINT COMMENT 'Reference to the IRB protocol associated with this compliance event, if applicable to human subjects research.',
    `previous_event_compliance_event_id` BIGINT COMMENT 'Reference to a previous compliance event record if this is a repeat or related finding.',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the principal investigator associated with the research activity under compliance review.',
    `proposal_id` BIGINT COMMENT 'Reference to the research proposal associated with this compliance event, if applicable.',
    `research_award_id` BIGINT COMMENT 'Reference to the sponsored research award associated with this compliance event, if applicable.',
    `audit_finding_flag` BOOLEAN COMMENT 'Indicates whether this compliance event originated from an internal or external audit finding.',
    `audit_report_reference` STRING COMMENT 'Reference number or identifier of the audit report in which this compliance event was documented, if applicable.',
    `corrective_action_completion_date` DATE COMMENT 'The actual date on which all corrective actions were completed and verified.',
    `corrective_action_due_date` DATE COMMENT 'The target date by which corrective actions must be completed to resolve the compliance event.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of the corrective action plan developed to address the compliance event and prevent recurrence.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan implementation.. Valid values are `not_started|in_progress|completed|overdue|verified`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this compliance event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (typically USD for U.S. institutions).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Code identifying the academic or administrative department associated with the research activity under compliance review.',
    `department_name` STRING COMMENT 'Name of the academic or administrative department associated with the research activity under compliance review.',
    `event_date` DATE COMMENT 'The date on which the compliance event, finding, or incident occurred or was identified.',
    `event_description` STRING COMMENT 'Detailed narrative description of the compliance event, including circumstances, findings, and any immediate actions taken.',
    `event_number` STRING COMMENT 'Business identifier for the compliance event, used for tracking and reporting purposes. May follow institutional numbering convention.',
    `event_status` STRING COMMENT 'Current lifecycle status of the compliance event indicating its resolution state.. Valid values are `open|under_investigation|corrective_action_in_progress|pending_closure|closed|escalated`',
    `event_type` STRING COMMENT 'Classification of the compliance event indicating the nature of the finding or incident. [ENUM-REF-CANDIDATE: audit_finding|protocol_deviation|adverse_event|noncompliance_report|suspension|debarment_notice|sponsor_site_visit_finding|corrective_action_request|allegation_of_misconduct|export_control_violation|conflict_of_interest_violation|financial_noncompliance — 12 candidates stripped; promote to reference product]',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the compliance event, including potential disallowed costs, penalties, or required refunds.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who last modified this compliance event record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this compliance event record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the compliance event, corrective actions, or resolution process.',
    `regulatory_body_notification_date` DATE COMMENT 'The date on which the external regulatory body was formally notified of the compliance event.',
    `regulatory_body_notified` STRING COMMENT 'Name of the external regulatory body or oversight agency that was notified of this compliance event (e.g., OHRP, FDA, NSF OIG, NIH).',
    `regulatory_citation` STRING COMMENT 'Citation of the specific federal, state, or institutional regulation, policy, or guideline that was violated or is relevant to this compliance event.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this compliance event is a repeat or recurring finding of a previously identified issue.',
    `reported_date` DATE COMMENT 'The date on which the compliance event was formally reported to the institutional compliance office or regulatory body.',
    `resolution_date` DATE COMMENT 'The date on which the compliance event was formally resolved and closed.',
    `resolution_status` STRING COMMENT 'Overall resolution status of the compliance event, indicating whether it has been satisfactorily closed.. Valid values are `unresolved|resolved|pending_verification|accepted_by_sponsor|accepted_by_regulatory_body`',
    `responsible_party_email` STRING COMMENT 'Email address of the individual or department responsible for implementing corrective actions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_name` STRING COMMENT 'Name of the individual or department responsible for implementing corrective actions and resolving the compliance event.',
    `severity_level` STRING COMMENT 'Assessment of the severity or risk level of the compliance event, used to prioritize response and corrective actions.. Valid values are `critical|high|medium|low|informational`',
    `sponsor_agency_name` STRING COMMENT 'Name of the federal or non-federal sponsor agency whose award or program is associated with this compliance event.',
    `sponsor_notification_date` DATE COMMENT 'The date on which the sponsoring agency was formally notified of the compliance event.',
    `sponsor_notified_flag` BOOLEAN COMMENT 'Indicates whether the sponsoring agency has been formally notified of this compliance event, as required by federal regulations.',
    `systemic_issue_flag` BOOLEAN COMMENT 'Indicates whether this compliance event represents a systemic institutional issue requiring broader policy or process changes.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this compliance event record.',
    CONSTRAINT pk_compliance_event PRIMARY KEY(`compliance_event_id`)
) COMMENT 'Transactional record capturing compliance-related events, findings, and corrective actions associated with sponsored research activities. Captures event type (audit finding, protocol deviation, adverse event, noncompliance report, suspension, debarment notice, sponsor site visit finding), event date, associated award or protocol, severity level, description, corrective action plan, corrective action due date, corrective action completion date, regulatory body notified, and resolution status. Supports institutional research compliance program management and federal agency reporting obligations.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`scholarly_output` (
    `scholarly_output_id` BIGINT COMMENT 'Primary key for scholarly_output',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: Alumni co-authors on institutional publications demonstrate continued scholarly engagement. Used in stewardship communications, prospect research, and demonstrating research impact to donors. Tracks a',
    `bib_record_id` BIGINT COMMENT 'Foreign key linking to library.bib_record. Business justification: Faculty publications are cataloged in library systems for institutional repository workflows, open access compliance reporting, and research impact tracking. Higher-ed institutions routinely link rese',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Faculty integrate research outputs into teaching (scholarship of teaching and learning). Accreditation bodies (AACSB, ABET, regional accreditors) require evidence that faculty scholarly work informs c',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Scholarly outputs tracked in research information management systems (Pure, Elsevier Elements, Digital Measures, Faculty180). Business need: faculty activity reporting, research impact tracking, syste',
    `iacuc_protocol_id` BIGINT COMMENT 'Foreign key linking to research.iacuc_protocol. Business justification: Scholarly outputs from animal research must cite IACUC approval in publications. Adding iacuc_protocol_id FK links publications to their governing IACUC protocol, enabling compliance tracking and ensu',
    `irb_protocol_id` BIGINT COMMENT 'Foreign key linking to research.irb_protocol. Business justification: Scholarly outputs from human subjects research must cite IRB approval in publications. Adding irb_protocol_id FK links publications to their governing IRB protocol, enabling compliance tracking and en',
    `plo_id` BIGINT COMMENT 'Foreign key linking to curriculum.plo. Business justification: Graduate programs (especially doctoral) use scholarly outputs (publications, presentations) as direct assessment evidence for program learning outcomes. Assessment cycles require mapping outputs to PL',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the primary Principal Investigator (PI) associated with the research that produced this output.',
    `research_award_id` BIGINT COMMENT 'Reference to the primary sponsored award that funded the research producing this output.',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to research.sponsor. Business justification: scholarly_output has sponsor_agency_name which should be normalized via FK to sponsor master table. Publications often acknowledge funding sponsors; linking to sponsor master provides full sponsor det',
    `student_athlete_id` BIGINT COMMENT 'Foreign key linking to athletics.student_athlete. Business justification: Tracks publications co-authored by student-athletes (graduate students, honors students). Required for institutional research productivity reporting, academic recognition programs, and demonstrating s',
    `abstract_text` STRING COMMENT 'Summary or abstract describing the content, methodology, and findings of the scholarly output.',
    `acceptance_date` DATE COMMENT 'Date when the output was accepted for publication following peer review or editorial decision.',
    `author_list` STRING COMMENT 'Comma-separated list of all authors or creators of the scholarly output in citation order, including institutional affiliations.',
    `citation_count` STRING COMMENT 'Number of times the output has been cited by other scholarly works, as tracked by citation indexing services.',
    `citation_last_updated_date` DATE COMMENT 'Date when the citation count was last refreshed from external citation tracking services.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the scholarly output record was first created in the system.',
    `doi` STRING COMMENT 'Persistent digital identifier assigned to the scholarly output for permanent citation and retrieval.. Valid values are `^10.d{4,9}/[-._;()/:A-Za-z0-9]+$`',
    `embargo_end_date` DATE COMMENT 'Date when publisher-imposed embargo restrictions expire and the output may be made openly accessible.',
    `federal_sponsor_flag` BOOLEAN COMMENT 'Indicates whether the output was produced from federally-sponsored research, triggering specific reporting and compliance requirements.',
    `funding_acknowledgment_text` STRING COMMENT 'Full text of the funding acknowledgment section listing all sponsors and grant numbers that supported the research.',
    `institutional_author_count` STRING COMMENT 'Number of authors affiliated with the institution at the time of publication.',
    `ipeds_reportable_flag` BOOLEAN COMMENT 'Indicates whether the output meets criteria for inclusion in IPEDS research and development expenditure surveys.',
    `isbn` STRING COMMENT 'Unique numeric commercial book identifier for books and book chapters.',
    `issn` STRING COMMENT 'Unique identifier for serial publications such as journals and conference proceedings.',
    `issue_number` STRING COMMENT 'Issue number within the volume of the journal or serial publication.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or subject terms describing the content and topics of the output for indexing and discovery.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter code representing the primary language in which the output is written.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified the scholarly output record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the scholarly output record was last updated or modified.',
    `open_access_status` STRING COMMENT 'Classification of the open access availability of the output. Gold = fully OA journal; Green = author-archived; Hybrid = OA option in subscription journal; Bronze = free to read without license; Closed = subscription only.. Valid values are `gold|green|hybrid|bronze|closed`',
    `open_access_url` STRING COMMENT 'Direct URL to the freely accessible version of the output in an institutional or public repository.',
    `output_notes` STRING COMMENT 'Free-text field for additional contextual information, special circumstances, or administrative notes about the scholarly output.',
    `output_number` STRING COMMENT 'Institution-assigned unique identifier or tracking number for the scholarly output, used for internal reference and cataloging purposes.',
    `output_status` STRING COMMENT 'Current lifecycle status of the scholarly output in the publication or dissemination process.. Valid values are `draft|submitted|accepted|published|embargoed|retracted`',
    `output_type` STRING COMMENT 'Classification of the scholarly output by format and medium. Determines reporting requirements and assessment eligibility. [ENUM-REF-CANDIDATE: journal_article|conference_paper|book_chapter|book|dataset|software|patent|technical_report|creative_work|thesis_dissertation — 10 candidates stripped; promote to reference product]',
    `page_range` STRING COMMENT 'Starting and ending page numbers of the output within the publication (e.g., 123-145).',
    `peer_reviewed_flag` BOOLEAN COMMENT 'Indicates whether the output underwent formal peer review prior to publication, a key criterion for research quality assessment.',
    `publication_date` DATE COMMENT 'Date when the scholarly output was officially published or made publicly available.',
    `publication_venue` STRING COMMENT 'Name of the journal, conference, publisher, or platform where the output was published or presented.',
    `rae_submission_date` DATE COMMENT 'Date when the output was submitted for inclusion in a research assessment exercise or evaluation cycle.',
    `rae_submission_eligible_flag` BOOLEAN COMMENT 'Indicates whether the output meets institutional criteria for submission to national or international research assessment exercises.',
    `repository_deposit_date` DATE COMMENT 'Date when the output was deposited into the institutional or subject repository.',
    `repository_deposit_status` STRING COMMENT 'Status of deposit into the institutional or subject repository for open access compliance.. Valid values are `not_deposited|deposited|pending_approval|rejected`',
    `research_area_code` STRING COMMENT 'Classification code representing the primary research discipline or field of study (e.g., CIP code, NSF field code).',
    `research_area_description` STRING COMMENT 'Textual description of the primary research discipline or field of study associated with the output.',
    `submission_date` DATE COMMENT 'Date when the output was submitted to the publication venue or repository for review.',
    `title` STRING COMMENT 'Full title of the scholarly output as it appears in the publication or repository.',
    `volume_number` STRING COMMENT 'Volume number of the journal or serial publication in which the output appears.',
    `created_by` STRING COMMENT 'User identifier or system account that created the scholarly output record.',
    CONSTRAINT pk_scholarly_output PRIMARY KEY(`scholarly_output_id`)
) COMMENT 'Master record tracking scholarly and creative outputs produced from sponsored and non-sponsored research activities, including publications, conference presentations, datasets, software, and creative works. Captures output type (journal article, conference paper, book chapter, dataset, software, patent, technical report), title, authors, publication venue, publication date, DOI/identifier, open access status, funding acknowledgment text, associated award IDs, embargo end date, repository deposit status, and RAE/research assessment submission eligibility. Supports IPEDS research output reporting, open access mandate compliance (NIH, NSF), and institutional RAE assessments.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`subrecipient` (
    `subrecipient_id` BIGINT COMMENT 'Unique identifier for the subrecipient organization record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the institutional grants administrator or research administrator responsible for monitoring and managing subawards to this subrecipient.',
    `idc_rate_id` BIGINT COMMENT 'Foreign key linking to research.idc_rate. Business justification: subrecipient has indirect_cost_rate_percentage, type, and effective/expiration dates which match the idc_rate structure. Subrecipients have negotiated IDC rate agreements with their cognizant agencies',
    `audit_findings_flag` BOOLEAN COMMENT 'Indicates whether the subrecipients most recent audit report contained any findings, questioned costs, or material weaknesses requiring corrective action.',
    `audit_findings_summary` STRING COMMENT 'Brief summary of any audit findings, questioned costs, or material weaknesses identified in the most recent audit report, including corrective action status.',
    `debarment_check_date` DATE COMMENT 'Date when the institution last verified the subrecipients status in the federal Excluded Parties List System (EPLS) or SAM.gov to ensure they are not debarred or suspended from receiving federal funds.',
    `debarment_status` STRING COMMENT 'Current debarment or suspension status of the subrecipient as verified through SAM.gov Excluded Parties List, indicating eligibility to receive federal funds.. Valid values are `clear|debarred|suspended|proposed_debarment`',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify the subrecipient organization. Legacy identifier being phased out in favor of UEI.. Valid values are `^[0-9]{9}$`',
    `ein` STRING COMMENT 'Federal tax identification number assigned by the IRS to the subrecipient organization for tax reporting purposes.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `ffata_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether subawards to this subrecipient must be reported to FSRS.gov under FFATA transparency requirements, typically for subawards exceeding $30,000.',
    `financial_contact_email` STRING COMMENT 'Email address of the financial contact person at the subrecipient organization for invoicing and financial reporting communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `financial_contact_name` STRING COMMENT 'Full name of the financial or accounting contact person at the subrecipient organization responsible for invoicing, financial reporting, and budget matters.',
    `kuali_research_organization_number` STRING COMMENT 'Unique identifier for this subrecipient organization in the Kuali Research system, used for system integration and data synchronization.',
    `legal_name` STRING COMMENT 'The official legal name of the subrecipient organization as registered with governing authorities and used in subaward agreements.',
    `most_recent_audit_report_date` DATE COMMENT 'Date of the subrecipients most recently completed Single Audit or financial audit report, used to assess compliance and financial health.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or institutional knowledge about the subrecipient organization relevant to subaward management and monitoring.',
    `organization_type` STRING COMMENT 'Classification of the subrecipient organization by legal and operational structure, determining applicable compliance requirements and audit thresholds.. Valid values are `university|non-profit|for-profit|government|foreign`',
    `primary_address_line1` STRING COMMENT 'First line of the subrecipient organizations primary physical or mailing address, typically containing street number and name.',
    `primary_address_line2` STRING COMMENT 'Second line of the subrecipient organizations primary address, typically containing suite, building, or department information.',
    `primary_city` STRING COMMENT 'City or municipality of the subrecipient organizations primary address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person at the subrecipient organization for official subaward communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary administrative or business contact person at the subrecipient organization for subaward coordination and communication.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number of the contact person at the subrecipient organization.',
    `primary_contact_title` STRING COMMENT 'Job title or position of the primary contact person at the subrecipient organization.',
    `primary_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the subrecipient organizations primary address (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `primary_postal_code` STRING COMMENT 'Postal or ZIP code of the subrecipient organizations primary address.',
    `primary_state_province` STRING COMMENT 'State, province, or administrative region of the subrecipient organizations primary address.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subrecipient record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this subrecipient record was last modified, used for audit trail and data currency tracking.',
    `risk_assessment_date` DATE COMMENT 'Date when the most recent risk assessment was performed to determine the subrecipients risk classification and monitoring requirements.',
    `risk_classification` STRING COMMENT 'Risk assessment classification assigned by the institution based on factors including audit history, financial stability, prior performance, and compliance record, determining monitoring intensity.. Valid values are `low|medium|high`',
    `sam_expiration_date` DATE COMMENT 'Date when the subrecipients SAM.gov registration expires, requiring renewal to maintain eligibility for federal subawards.',
    `sam_registration_date` DATE COMMENT 'Date when the subrecipient organization completed or last renewed its registration in SAM.gov.',
    `sam_registration_status` STRING COMMENT 'Current registration status of the subrecipient in the federal SAM.gov system, required for eligibility to receive federal subawards.. Valid values are `active|expired|inactive`',
    `single_audit_required_flag` BOOLEAN COMMENT 'Indicates whether the subrecipient is required to undergo a Single Audit based on federal expenditure threshold (currently $750,000 or more in federal awards expended during the fiscal year).',
    `subrecipient_status` STRING COMMENT 'Current operational status of the subrecipient indicating eligibility to receive new subawards or continue existing agreements.. Valid values are `active|inactive|suspended|debarred`',
    `total_active_subaward_amount` DECIMAL(18,2) COMMENT 'Cumulative dollar value of all currently active subaward agreements with this subrecipient organization, used for risk assessment and monitoring prioritization.',
    `total_active_subawards_count` STRING COMMENT 'Current count of active subaward agreements with this subrecipient organization, used for monitoring workload and relationship intensity.',
    `uei_number` STRING COMMENT 'Twelve-character alphanumeric identifier assigned by SAM.gov to uniquely identify the subrecipient organization. Replaces DUNS as the federal standard identifier.. Valid values are `^[A-Z0-9]{12}$`',
    CONSTRAINT pk_subrecipient PRIMARY KEY(`subrecipient_id`)
) COMMENT 'Master record for an external organization that receives a subaward from the institution to carry out a portion of a federally funded research project. Captures subrecipient legal name, DUNS/UEI number, EIN, SAM.gov registration status and expiration, organization type (university, non-profit, for-profit, government), FFATA reporting requirement flag, Single Audit requirement flag (based on federal expenditure threshold), most recent audit report date, audit findings flag, risk classification (low, medium, high), debarment check date, and responsible grants administrator. Distinct from the sponsor entity — subrecipients receive funds from the institution, sponsors provide funds to the institution.';

CREATE OR REPLACE TABLE `education_ecm`.`research`.`research_training_completion` (
    `research_training_completion_id` BIGINT COMMENT 'Primary key for research_training_completion',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to the principal investigator who completed or is required to complete the training',
    `compliance_training_completion_id` BIGINT COMMENT 'Unique identifier for this PI training completion record. Primary key for the association.',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to the specific compliance training program completed',
    `animal_care_training_completion_date` DATE COMMENT 'The date on which the principal investigator completed the most recent animal care and use training. [Moved from principal_investigator: This date represents completion of ONE specific training program (Animal Care). In the M:N model, completion dates are tracked per PI-training pair in training_completion.completion_date, eliminating training-specific date columns.]',
    `animal_care_training_completion_flag` BOOLEAN COMMENT 'Indicates whether the principal investigator has completed required animal care and use training for research involving vertebrate animals. True if completed, False otherwise. [Moved from principal_investigator: This boolean flag represents completion of ONE specific training program (Animal Care). In the M:N model, completion status is tracked per PI-training pair in training_completion.completion_status, making this redundant.]',
    `assignment_date` DATE COMMENT 'Date on which this training was assigned to the principal investigator, used to calculate completion_deadline and overdue status.',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this training completion, incremented if the PI must retake the training due to failure or recertification requirements.',
    `certificate_number` STRING COMMENT 'Unique certificate identifier issued upon successful completion, used for audit verification and sponsor documentation requirements.',
    `completion_date` DATE COMMENT 'The date on which the principal investigator successfully completed this training program, meeting the passing score requirement.',
    `completion_method` STRING COMMENT 'Method by which the principal investigator completed this training, which may differ from the training programs default delivery_modality if alternative completion pathways were used.',
    `completion_status` STRING COMMENT 'Current status of this PI-training completion record. Completed indicates successful completion with passing score. Expired indicates recertification is required. Waived indicates institutional exception granted.',
    `expiration_date` DATE COMMENT 'The date on which this training completion expires and recertification is required, calculated from completion_date plus recertification_frequency_months from the training program.',
    `export_control_certification_date` DATE COMMENT 'The date on which the principal investigator completed the most recent export control compliance certification. [Moved from principal_investigator: This date represents completion of ONE specific training program (Export Control). In the M:N model, completion dates are tracked per PI-training pair in training_completion.completion_date, eliminating training-specific date columns.]',
    `export_control_certification_flag` BOOLEAN COMMENT 'Indicates whether the principal investigator has completed required export control compliance training and certification. True if certified, False otherwise. [Moved from principal_investigator: This boolean flag represents completion of ONE specific training program (Export Control). In the M:N model, completion status is tracked per PI-training pair in training_completion.completion_status, making this redundant.]',
    `external_provider_name` STRING COMMENT 'Name of external training provider if completion was achieved through a non-institutional source, used for transfer credit and equivalency verification.',
    `human_subjects_training_completion_date` DATE COMMENT 'The date on which the principal investigator completed the most recent human subjects protection training. [Moved from principal_investigator: This date represents completion of ONE specific training program (Human Subjects). In the M:N model, completion dates are tracked per PI-training pair in training_completion.completion_date, eliminating training-specific date columns.]',
    `human_subjects_training_completion_flag` BOOLEAN COMMENT 'Indicates whether the principal investigator has completed required human subjects protection training (e.g., CITI Program training). True if completed, False otherwise. [Moved from principal_investigator: This boolean flag represents completion of ONE specific training program (Human Subjects/CITI). In the M:N model, completion status is tracked per PI-training pair in training_completion.completion_status, making this redundant.]',
    `notes` STRING COMMENT 'Free-text notes documenting special circumstances, accommodations provided, technical issues, or other contextual information relevant to this specific completion record.',
    `rcr_training_completion_date` DATE COMMENT 'The date on which the principal investigator completed the most recent Responsible Conduct of Research training. [Moved from principal_investigator: This date represents completion of ONE specific training program (RCR). In the M:N model, completion dates are tracked per PI-training pair in training_completion.completion_date, eliminating the need for training-specific date columns in the PI master record.]',
    `rcr_training_completion_flag` BOOLEAN COMMENT 'Indicates whether the principal investigator has completed required Responsible Conduct of Research training. True if completed, False otherwise. [Moved from principal_investigator: This boolean flag represents completion of ONE specific training program (Responsible Conduct of Research). In the M:N model, completion status is tracked per PI-training pair in training_completion.completion_status, making this redundant and denormalized.]',
    `recertification_due_date` DATE COMMENT 'The date by which the principal investigator must complete recertification training to maintain compliance eligibility. May differ from expiration_date if grace periods apply.',
    `score_achieved` DECIMAL(18,2) COMMENT 'Percentage score achieved by the principal investigator on the training assessment, used to determine completion status against the passing_score_percentage threshold.',
    `waiver_approval_date` DATE COMMENT 'Date on which the training waiver was officially approved by the authorized institutional official.',
    `waiver_approved_by` STRING COMMENT 'Name or employee ID of the institutional official who approved the training waiver, typically the Compliance Officer or Office of Sponsored Programs Director.',
    `waiver_justification` STRING COMMENT 'Business justification for waiver request or approval, documenting equivalent training, institutional policy exception, or sponsor-approved alternative compliance pathway.',
    `waiver_status` STRING COMMENT 'Indicates whether an institutional waiver or exception has been requested or granted for this specific PI-training requirement, typically due to equivalent prior training or role-specific exemptions.',
    CONSTRAINT pk_research_training_completion PRIMARY KEY(`research_training_completion_id`)
) COMMENT 'This association product represents the completion event between a principal investigator and a compliance training program. It captures the compliance tracking requirements mandated by federal sponsors, institutional policy, and the Office of Sponsored Programs for PI eligibility determination. Each record links one principal investigator to one training program with completion status, dates, certification details, and recertification tracking that exist only in the context of this specific PI-training completion relationship.. Existence Justification: Principal investigators must complete multiple mandatory compliance training programs (RCR, human subjects, animal care, export control, conflict of interest, financial management) to maintain eligibility for sponsored research awards. Each training program is completed by hundreds of PIs across the institution. The Office of Sponsored Programs actively manages this compliance matrix, tracking completion dates, expiration dates, recertification requirements, waiver requests, and certificate numbers for each PI-training combination to determine proposal eligibility and award activation authority.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_idc_rate_id` FOREIGN KEY (`idc_rate_id`) REFERENCES `education_ecm`.`research`.`idc_rate`(`idc_rate_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`research_award` ADD CONSTRAINT `fk_research_research_award_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_idc_rate_id` FOREIGN KEY (`idc_rate_id`) REFERENCES `education_ecm`.`research`.`idc_rate`(`idc_rate_id`);
ALTER TABLE `education_ecm`.`research`.`award_budget` ADD CONSTRAINT `fk_research_award_budget_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`sponsor` ADD CONSTRAINT `fk_research_sponsor_parent_sponsor_id` FOREIGN KEY (`parent_sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_idc_rate_id` FOREIGN KEY (`idc_rate_id`) REFERENCES `education_ecm`.`research`.`idc_rate`(`idc_rate_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`subaward` ADD CONSTRAINT `fk_research_subaward_subrecipient_id` FOREIGN KEY (`subrecipient_id`) REFERENCES `education_ecm`.`research`.`subrecipient`(`subrecipient_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ADD CONSTRAINT `fk_research_iacuc_protocol_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ADD CONSTRAINT `fk_research_iacuc_protocol_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `education_ecm`.`research`.`award_budget`(`award_budget_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `education_ecm`.`research`.`subaward`(`subaward_id`);
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `education_ecm`.`research`.`award_budget`(`award_budget_id`);
ALTER TABLE `education_ecm`.`research`.`effort_certification` ADD CONSTRAINT `fk_research_effort_certification_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`idc_rate` ADD CONSTRAINT `fk_research_idc_rate_prior_rate_agreement_idc_rate_id` FOREIGN KEY (`prior_rate_agreement_idc_rate_id`) REFERENCES `education_ecm`.`research`.`idc_rate`(`idc_rate_id`);
ALTER TABLE `education_ecm`.`research`.`award_modification` ADD CONSTRAINT `fk_research_award_modification_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `education_ecm`.`research`.`award_budget`(`award_budget_id`);
ALTER TABLE `education_ecm`.`research`.`award_modification` ADD CONSTRAINT `fk_research_award_modification_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`award_modification` ADD CONSTRAINT `fk_research_award_modification_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ADD CONSTRAINT `fk_research_conflict_of_interest_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ADD CONSTRAINT `fk_research_conflict_of_interest_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `education_ecm`.`research`.`award_budget`(`award_budget_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_idc_rate_id` FOREIGN KEY (`idc_rate_id`) REFERENCES `education_ecm`.`research`.`idc_rate`(`idc_rate_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`research`.`award_report` ADD CONSTRAINT `fk_research_award_report_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`award_report` ADD CONSTRAINT `fk_research_award_report_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`award_report` ADD CONSTRAINT `fk_research_award_report_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ADD CONSTRAINT `fk_research_invention_disclosure_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`export_control_review` ADD CONSTRAINT `fk_research_export_control_review_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`export_control_review` ADD CONSTRAINT `fk_research_export_control_review_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`research`.`export_control_review` ADD CONSTRAINT `fk_research_export_control_review_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`export_control_review` ADD CONSTRAINT `fk_research_export_control_review_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_conflict_of_interest_id` FOREIGN KEY (`conflict_of_interest_id`) REFERENCES `education_ecm`.`research`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_export_control_review_id` FOREIGN KEY (`export_control_review_id`) REFERENCES `education_ecm`.`research`.`export_control_review`(`export_control_review_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_iacuc_protocol_id` FOREIGN KEY (`iacuc_protocol_id`) REFERENCES `education_ecm`.`research`.`iacuc_protocol`(`iacuc_protocol_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_previous_event_compliance_event_id` FOREIGN KEY (`previous_event_compliance_event_id`) REFERENCES `education_ecm`.`research`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_iacuc_protocol_id` FOREIGN KEY (`iacuc_protocol_id`) REFERENCES `education_ecm`.`research`.`iacuc_protocol`(`iacuc_protocol_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ADD CONSTRAINT `fk_research_scholarly_output_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`subrecipient` ADD CONSTRAINT `fk_research_subrecipient_idc_rate_id` FOREIGN KEY (`idc_rate_id`) REFERENCES `education_ecm`.`research`.`idc_rate`(`idc_rate_id`);
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ADD CONSTRAINT `fk_research_research_training_completion_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`research` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`research` SET TAGS ('dbx_domain' = 'research');
ALTER TABLE `education_ecm`.`research`.`proposal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`proposal` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Preparer Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `proposal_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Department Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Proposal Abstract');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'research|instruction|public_service|other_sponsored_activity');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `biohazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Biohazard Research Flag');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `cfda_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{3}$');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `cost_sharing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Required Flag');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Decision Date');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `direct_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Amount');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `fa_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Rate Percentage');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `human_subjects_flag` SET TAGS ('dbx_business_glossary_term' = 'Human Subjects Research Flag');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `iacuc_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Institutional Animal Care and Use Committee (IACUC) Approval Status');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `iacuc_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|deferred');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `ibc_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Institutional Biosafety Committee (IBC) Approval Status');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `ibc_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|deferred');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `idc_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost (IDC) Rate Type');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `idc_rate_type` SET TAGS ('dbx_value_regex' = 'on_campus|off_campus|modified_total_direct_cost|total_direct_cost');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Amount (Facilities and Administrative Costs)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `irb_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Status');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `irb_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|exempt|deferred');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `kuali_research_proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Kuali Research Proposal Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `project_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Project Duration in Months');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|awarded|declined|withdrawn');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'new|continuation|renewal|supplement|revision');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `requested_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Budget Amount');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `research_area_code` SET TAGS ('dbx_business_glossary_term' = 'Research Area Code');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `research_area_description` SET TAGS ('dbx_business_glossary_term' = 'Research Area Description');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `sponsor_award_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Award Number');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `sponsor_program_announcement` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Program Announcement');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Proposal Title');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `vertebrate_animals_flag` SET TAGS ('dbx_business_glossary_term' = 'Vertebrate Animals Research Flag');
ALTER TABLE `education_ecm`.`research`.`research_award` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`research_award` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Unit Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'research|instruction|public_service|other_sponsored_activity');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `animal_subjects_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Animal Subjects Approval Required Flag');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `award_number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'active|no_cost_extension|closed|terminated|suspended|pending');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `award_type` SET TAGS ('dbx_value_regex' = 'grant|contract|cooperative_agreement|fellowship|subaward|other');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `budget_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `budget_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `carryforward_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Carryforward Allowed Flag');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `cfda_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{3}$');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Award Closeout Date');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `cost_sharing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Required Flag');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `direct_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Amount');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Award Effective Date');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Award Execution Date');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `human_subjects_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Human Subjects Approval Required Flag');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `iacuc_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Animal Care and Use Committee (IACUC) Protocol Number');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost (IDC) / Facilities and Administrative (F&A) Amount');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `no_cost_extension_date` SET TAGS ('dbx_business_glossary_term' = 'No-Cost Extension (NCE) End Date');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `no_cost_extension_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Cost Extension (NCE) Flag');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'advance|reimbursement|letter_of_credit');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Program Code');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|final_only');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `sponsor_award_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Award Title');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `total_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Award Amount');
ALTER TABLE `education_ecm`.`research`.`award_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`award_budget` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Preparer Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Budget Approved By');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approved Date');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `budget_justification_text` SET TAGS ('dbx_business_glossary_term' = 'Budget Justification Text');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `budget_modification_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Modification Number');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `budget_period_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Number');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'initial|continuation|supplement|no_cost_extension|revised');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `equipment_costs` SET TAGS ('dbx_business_glossary_term' = 'Equipment Costs');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `fringe_benefit_costs` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Costs');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `modification_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Modification Description');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Budget Record Modified By');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Record Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `mtdc_base` SET TAGS ('dbx_business_glossary_term' = 'Modified Total Direct Costs (MTDC) Base');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `other_direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Other Direct Costs');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_business_glossary_term' = 'Personnel Costs');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `sponsor_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Approved Amount');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `subcontract_costs` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Costs');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submitted Date');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `supplies_costs` SET TAGS ('dbx_business_glossary_term' = 'Supplies and Materials Costs');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `total_direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Costs');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `total_fa_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Facilities and Administrative (F&A) Costs');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `travel_costs` SET TAGS ('dbx_business_glossary_term' = 'Travel Costs');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `unrecovered_fa_amount` SET TAGS ('dbx_business_glossary_term' = 'Unrecovered Facilities and Administrative (F&A) Amount');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Budget Record Created By');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completion Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `academic_rank` SET TAGS ('dbx_business_glossary_term' = 'Academic Rank');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `academic_rank` SET TAGS ('dbx_value_regex' = 'Professor|Associate Professor|Assistant Professor|Research Professor|Research Scientist|Postdoctoral Fellow');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `active_award_count` SET TAGS ('dbx_business_glossary_term' = 'Active Award Count');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'Full-Time|Part-Time|Adjunct|Visiting|Joint Appointment');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `college_school_code` SET TAGS ('dbx_business_glossary_term' = 'College or School Code');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `college_school_name` SET TAGS ('dbx_business_glossary_term' = 'College or School Name');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `conflict_of_interest_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) Disclosure Date');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `conflict_of_interest_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) Disclosure Status');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `conflict_of_interest_disclosure_status` SET TAGS ('dbx_value_regex' = 'Current|Overdue|Not Required|Under Review|Disclosed');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `cumulative_award_count` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Award Count');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `effort_certification_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Effort Certification Eligible Flag');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `federal_debarment_check_date` SET TAGS ('dbx_business_glossary_term' = 'Federal Debarment Check Date');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `federal_debarment_check_status` SET TAGS ('dbx_business_glossary_term' = 'Federal Debarment Check Status');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `federal_debarment_check_status` SET TAGS ('dbx_value_regex' = 'Clear|Flagged|Pending|Not Checked|Expired');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `home_department_code` SET TAGS ('dbx_business_glossary_term' = 'Home Department Code');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `home_department_name` SET TAGS ('dbx_business_glossary_term' = 'Home Department Name');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `kuali_research_person_number` SET TAGS ('dbx_business_glossary_term' = 'Kuali Research Person Identifier');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `orcid_identifier` SET TAGS ('dbx_business_glossary_term' = 'Open Researcher and Contributor Identifier (ORCID)');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `orcid_identifier` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}-d{4}-d{3}[0-9X]$');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `pi_eligibility_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Eligibility Effective Date');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `pi_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Eligibility Status');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `pi_eligibility_status` SET TAGS ('dbx_value_regex' = 'Eligible|Ineligible|Conditional|Suspended|Under Review');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `pi_status` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Status');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `pi_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|On Leave|Retired|Terminated');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `primary_research_area` SET TAGS ('dbx_business_glossary_term' = 'Primary Research Area');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `tenure_status` SET TAGS ('dbx_business_glossary_term' = 'Tenure Status');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `tenure_status` SET TAGS ('dbx_value_regex' = 'Tenured|Tenure-Track|Non-Tenure-Track|Emeritus|Not Applicable');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `total_active_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Active Funding Amount');
ALTER TABLE `education_ecm`.`research`.`sponsor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`sponsor` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `parent_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sponsor Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `acronym` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Acronym');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `acronym` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Address Line 1');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Address Line 2');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `allows_cost_sharing` SET TAGS ('dbx_business_glossary_term' = 'Allows Cost Sharing Flag');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `audit_requirement_threshold` SET TAGS ('dbx_business_glossary_term' = 'Audit Requirement Threshold Amount');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `cfda_program_list` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Program List');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Sponsor City');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `closeout_report_required` SET TAGS ('dbx_business_glossary_term' = 'Closeout Report Required Flag');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Email Address');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Primary Contact Name');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Phone Number');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Country Code');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `federal_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Agency Code');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `federal_agency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `idc_rate_cap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost (IDC) Rate Cap Percentage');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `indirect_cost_negotiation_status` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost (IDC) Negotiation Status');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `indirect_cost_negotiation_status` SET TAGS ('dbx_value_regex' = 'accepts_negotiated_rate|requires_sponsor_rate|no_idc_allowed|not_applicable');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `is_federal_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Is Federal Sponsor Flag');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notes');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `payment_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Payment Mechanism');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `payment_mechanism` SET TAGS ('dbx_value_regex' = 'letter_of_credit|reimbursement|advance|milestone|not_specified');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Portal Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Postal Code');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `preferred_submission_system` SET TAGS ('dbx_business_glossary_term' = 'Preferred Submission System');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `requires_cost_sharing` SET TAGS ('dbx_business_glossary_term' = 'Requires Cost Sharing Flag');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `requires_iacuc_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Institutional Animal Care and Use Committee (IACUC) Approval Flag');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `requires_institutional_review_board` SET TAGS ('dbx_business_glossary_term' = 'Requires Institutional Review Board (IRB) Approval Flag');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sam_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'System for Award Management (SAM) Expiration Date');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sam_registration_status` SET TAGS ('dbx_business_glossary_term' = 'System for Award Management (SAM) Registration Status');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sam_registration_status` SET TAGS ('dbx_value_regex' = 'registered|expired|not_registered|not_applicable');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sponsor_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Code');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sponsor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Legal Name');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sponsor_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Status');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sponsor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Type Classification');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_value_regex' = 'federal_agency|state_agency|foundation|corporation|foreign_entity|other');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Sponsor State or Province');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `uei_number` SET TAGS ('dbx_business_glossary_term' = 'Unique Entity Identifier (UEI) Number');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `uei_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `education_ecm`.`research`.`sponsor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Website Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`research`.`subaward` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`research`.`subaward` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Contact Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Prime Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_id` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `cost_sharing_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Required');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `executed_amount` SET TAGS ('dbx_business_glossary_term' = 'Executed Amount');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `federal_award_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Award Identification Number (FAIN)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `federal_flow_down_clauses_applicable` SET TAGS ('dbx_business_glossary_term' = 'Federal Flow-Down Clauses Applicable');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Frequency');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|cost_reimbursement|other');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `monitoring_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Risk Level');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `monitoring_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance End Date');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `period_of_performance_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance Start Date');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `prime_sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Prime Sponsor Name');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `scope_of_work_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work Summary');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `single_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Required');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subaward_number` SET TAGS ('dbx_business_glossary_term' = 'Subaward Number');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('dbx_business_glossary_term' = 'Subaward Status');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('dbx_value_regex' = 'pending|executed|active|suspended|closed|terminated');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_business_glossary_term' = 'Subaward Type');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_value_regex' = 'subcontract|subgrant|consortium_agreement|consultant_agreement|vendor_agreement|other');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Address Line 1');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Address Line 2');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_city` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient City');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Contact Email Address');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Contact Name');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Contact Phone Number');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_country_code` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Country Code');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_pi_email` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Principal Investigator (PI) Email Address');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_pi_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_pi_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_pi_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_pi_name` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Principal Investigator (PI) Name');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Postal Code');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_state_province` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient State or Province');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subrecipient_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `total_subaward_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Subaward Amount');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `irb_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Protocol Identifier');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Coordinator Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Award Identifier');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Research Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `actual_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Actual Enrollment');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Count');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `clinical_trial_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Flag');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `clinicaltrials_gov_number` SET TAGS ('dbx_business_glossary_term' = 'ClinicalTrials.gov Identifier (NCT Number)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `clinicaltrials_gov_number` SET TAGS ('dbx_value_regex' = '^NCT[0-9]{8}$');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `college_name` SET TAGS ('dbx_business_glossary_term' = 'College Name');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `consent_waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Waiver Status');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `consent_waiver_status` SET TAGS ('dbx_value_regex' = 'full_consent|waiver_granted|waiver_of_documentation|alteration_approved|not_applicable');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `continuing_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Continuing Review Due Date');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `data_safety_monitoring_plan` SET TAGS ('dbx_business_glossary_term' = 'Data Safety Monitoring Plan');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `data_safety_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Data Safety Monitoring Required');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `estimated_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Estimated Enrollment');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `fda_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Regulated Flag');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Type');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_value_regex' = 'federal|industry|foundation|internal|unfunded');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `hipaa_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Required');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `initial_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Approval Date');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `irb_of_record` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) of Record');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `kuali_research_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Kuali Research Protocol Identifier');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `multi_site_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Site Research Flag');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `protocol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{4,8}(-[A-Z0-9]{1,4})?$');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `protocol_status` SET TAGS ('dbx_business_glossary_term' = 'Protocol Status');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `protocol_status` SET TAGS ('dbx_value_regex' = 'pending|approved|suspended|closed|expired|withdrawn');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `protocol_title` SET TAGS ('dbx_business_glossary_term' = 'Protocol Title');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `protocol_version_number` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version Number');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `protocol_version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}(.[0-9]{1,2})?$');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `review_category` SET TAGS ('dbx_business_glossary_term' = 'Review Category');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level Classification');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'minimal|more_than_minimal|high');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `serious_adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Adverse Event (SAE) Count');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'exempt|expedited|full_board|not_human_subjects');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `subject_population_description` SET TAGS ('dbx_business_glossary_term' = 'Subject Population Description');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `vulnerable_population_flag` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Flag');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `vulnerable_population_types` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Types');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `iacuc_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Animal Care and Use Committee (IACUC) Protocol Identifier');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Veterinarian Identifier');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `aaalac_accreditation_relevant` SET TAGS ('dbx_business_glossary_term' = 'Association for Assessment and Accreditation of Laboratory Animal Care (AAALAC) Accreditation Relevant');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `alternatives_databases_searched` SET TAGS ('dbx_business_glossary_term' = 'Alternatives Databases Searched');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `alternatives_search_conducted` SET TAGS ('dbx_business_glossary_term' = 'Alternatives Search Conducted');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `alternatives_search_date` SET TAGS ('dbx_business_glossary_term' = 'Alternatives Search Date');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `animal_use_justification` SET TAGS ('dbx_business_glossary_term' = 'Animal Use Justification');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `annual_review_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Review Date');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Approval Date');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `approved_animal_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Animal Count');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `euthanasia_method` SET TAGS ('dbx_business_glossary_term' = 'Euthanasia Method');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Expiration Date');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `field_study_indicator` SET TAGS ('dbx_business_glossary_term' = 'Field Study Indicator');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `hazardous_agents_used` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Agents Used');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `pain_distress_category` SET TAGS ('dbx_business_glossary_term' = 'United States Department of Agriculture (USDA) Pain and Distress Category');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `pain_distress_category` SET TAGS ('dbx_value_regex' = 'B|C|D|E');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `phs_assurance_number` SET TAGS ('dbx_business_glossary_term' = 'Public Health Service (PHS) Assurance Number');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `protocol_amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Protocol Amendment Count');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `protocol_keywords` SET TAGS ('dbx_business_glossary_term' = 'Protocol Keywords');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'IACUC Protocol Number');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `protocol_status` SET TAGS ('dbx_business_glossary_term' = 'Protocol Status');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `protocol_title` SET TAGS ('dbx_business_glossary_term' = 'Protocol Title');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'IACUC Review Type');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'full_committee|designated_member|veterinary_verification_consultation');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `species_used` SET TAGS ('dbx_business_glossary_term' = 'Animal Species Used');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Submission Date');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `survival_surgery_performed` SET TAGS ('dbx_business_glossary_term' = 'Survival Surgery Performed');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `three_year_review_date` SET TAGS ('dbx_business_glossary_term' = 'Three-Year Review Date');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `training_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personnel Training Requirements');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `usda_registration_required` SET TAGS ('dbx_business_glossary_term' = 'United States Department of Agriculture (USDA) Registration Required');
ALTER TABLE `education_ecm`.`research`.`iacuc_protocol` ALTER COLUMN `veterinary_care_oversight` SET TAGS ('dbx_business_glossary_term' = 'Veterinary Care Oversight');
ALTER TABLE `education_ecm`.`research`.`expenditure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`research`.`expenditure` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Identifier');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `faculty_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `finance_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `tuition_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Tuition Charge Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `allocable_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocable Cost Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `allowable_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `award_account_number` SET TAGS ('dbx_business_glossary_term' = 'Award Account Number');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `award_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `award_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `award_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `closeout_flag` SET TAGS ('dbx_business_glossary_term' = 'Closeout Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `cost_share_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `cumulative_expenditure_to_date` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure To Date');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `direct_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Category');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `expenditure_description` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Description');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `grant_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `idc_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost (IDC) Amount');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `idc_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost (IDC) Rate');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `object_code` SET TAGS ('dbx_business_glossary_term' = 'Object Code');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `object_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `object_code_description` SET TAGS ('dbx_business_glossary_term' = 'Object Code Description');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `reasonable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reasonable Cost Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,20}$');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `transaction_source_system` SET TAGS ('dbx_business_glossary_term' = 'Transaction Source System');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|voided|approved|rejected');
ALTER TABLE `education_ecm`.`research`.`effort_certification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`research`.`effort_certification` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `effort_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Effort Certification ID');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Period ID');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Certifier Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `faculty_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `grant_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Expenditure Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student Athlete Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `adjustment_justification` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Justification');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'scope_change|personnel_change|effort_reallocation|error_correction|cost_sharing_adjustment|other');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'faculty|staff|postdoc|graduate_student|undergraduate_student|visiting_scholar');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certification_comments` SET TAGS ('dbx_business_glossary_term' = 'Certification Comments');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Due Date');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certification_method` SET TAGS ('dbx_business_glossary_term' = 'Certification Method');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certification_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|system_generated|retrospective');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Effort Certification Number');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'pending|certified|rejected|adjusted|overdue|withdrawn');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certified_effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Certified Effort Percentage');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certifier_name` SET TAGS ('dbx_business_glossary_term' = 'Certifier Full Name');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certifier_role` SET TAGS ('dbx_business_glossary_term' = 'Certifier Role');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `certifier_role` SET TAGS ('dbx_value_regex' = 'employee|supervisor|pi|department_chair|dean|authorized_representative');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `compliance_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issue Description');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `cost_shared_fringe_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Shared Fringe Benefits Amount');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `cost_shared_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Shared Salary Amount');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `cost_shared_salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `cost_shared_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `cost_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Transfer Amount');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `cost_transfer_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Transfer Required Flag');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `effort_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Variance Percentage');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `federal_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Agency Code');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `fringe_benefits_charged_amount` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefits Charged Amount');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `institutional_base_salary` SET TAGS ('dbx_business_glossary_term' = 'Institutional Base Salary (IBS)');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `institutional_base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Period End Date');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Period Start Date');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `pi_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Approval Date');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `pi_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Approval Required Flag');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `proposed_effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Proposed Effort Percentage');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `salary_charged_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Charged Amount');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `salary_charged_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `salary_charged_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Type');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Compensation Amount');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`effort_certification` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`research`.`idc_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`research`.`idc_rate` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Identifier');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `prior_rate_agreement_idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Rate Agreement Identifier');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `administrative_rate_component` SET TAGS ('dbx_business_glossary_term' = 'Administrative Rate Component Percentage');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `applicable_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Applicable Fiscal Year');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `approved_by_official` SET TAGS ('dbx_business_glossary_term' = 'Approved By Official Name');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `carryforward_provision` SET TAGS ('dbx_business_glossary_term' = 'Carryforward Provision Description');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `cognizant_agency` SET TAGS ('dbx_business_glossary_term' = 'Cognizant Federal Agency');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `cognizant_agency` SET TAGS ('dbx_value_regex' = 'dhhs|onr|doe|nasa|usda|other');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `cost_base_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Base Type');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `cost_base_type` SET TAGS ('dbx_value_regex' = 'mtdc|tdc|salaries_wages|other');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective End Date');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Start Date');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `equipment_exclusion_threshold` SET TAGS ('dbx_business_glossary_term' = 'Equipment Exclusion Threshold');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `facilities_rate_component` SET TAGS ('dbx_business_glossary_term' = 'Facilities Rate Component Percentage');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `fringe_benefit_rate_included` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Rate Included Flag');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `institutional_signatory` SET TAGS ('dbx_business_glossary_term' = 'Institutional Signatory Name');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `mtdc_exclusion_threshold` SET TAGS ('dbx_business_glossary_term' = 'Modified Total Direct Costs (MTDC) Exclusion Threshold');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `negotiation_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Agreement Negotiation Date');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_agreement_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Agreement Document Reference');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Agreement Number');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Audit Date');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rate Calculation Methodology Description');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_cap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Cap Percentage');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_determination_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Determination Type');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_determination_type` SET TAGS ('dbx_value_regex' = 'predetermined|provisional|fixed|final|temporary');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_negotiation_notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Negotiation Notes');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate Percentage');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_proposal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Proposal Submission Date');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Agreement Status');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|expired|superseded|pending|draft');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Rate Type');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'on_campus_research|off_campus_research|instruction|other_sponsored_activities|organized_research|public_service');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `special_rate_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Rate Conditions Description');
ALTER TABLE `education_ecm`.`research`.`idc_rate` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`research`.`award_modification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`research`.`award_modification` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `award_modification_id` SET TAGS ('dbx_business_glossary_term' = 'Award Modification Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `carryforward_amount` SET TAGS ('dbx_business_glossary_term' = 'Carryforward Amount');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `closeout_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Closeout Impact Flag');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `cost_sharing_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Change Flag');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `fa_rate_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Rate Change Flag');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `federal_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Reporting Required Flag');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `institutional_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Approval Date');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `justification_narrative` SET TAGS ('dbx_business_glossary_term' = 'Modification Justification Narrative');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `modification_amount_change` SET TAGS ('dbx_business_glossary_term' = 'Modification Amount Change');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `modification_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Effective Date');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `modification_initiator` SET TAGS ('dbx_business_glossary_term' = 'Modification Initiator');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `modification_initiator` SET TAGS ('dbx_value_regex' = 'sponsor|institution|pi|department|compliance_office|other');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `modification_notes` SET TAGS ('dbx_business_glossary_term' = 'Modification Notes');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `modification_number` SET TAGS ('dbx_business_glossary_term' = 'Modification Number');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `modification_request_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Request Date');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `modification_status` SET TAGS ('dbx_business_glossary_term' = 'Modification Status');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `modification_type` SET TAGS ('dbx_business_glossary_term' = 'Modification Type');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `new_award_amount` SET TAGS ('dbx_business_glossary_term' = 'New Award Amount');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `new_end_date` SET TAGS ('dbx_business_glossary_term' = 'New Award End Date');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `new_start_date` SET TAGS ('dbx_business_glossary_term' = 'New Award Start Date');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `originating_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Originating Request Reference');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `previous_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Award Amount');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `previous_end_date` SET TAGS ('dbx_business_glossary_term' = 'Previous Award End Date');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `previous_start_date` SET TAGS ('dbx_business_glossary_term' = 'Previous Award Start Date');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `sponsor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Approval Date');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `sponsor_modification_notice_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Modification Notice Number');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `sponsor_program_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Program Officer Email Address');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `sponsor_program_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `sponsor_program_officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `sponsor_program_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Program Officer Name');
ALTER TABLE `education_ecm`.`research`.`award_modification` ALTER COLUMN `terms_and_conditions_updated_flag` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions Updated Flag');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Of Interest Identifier');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) ID');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `annual_update_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Update Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `bias_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Bias Finding Flag');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Number');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `disclosure_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Period End Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `disclosure_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Period Start Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|closed');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `dollar_value_range` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value Range');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `dollar_value_range` SET TAGS ('dbx_value_regex' = '0_to_5000|5001_to_10000|10001_to_20000|20001_to_100000|over_100000|not_disclosed');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `entity_name` SET TAGS ('dbx_business_glossary_term' = 'Entity Name');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'publicly_traded|privately_held|nonprofit|government|academic|other');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `fcoi_finding_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Conflict of Interest (FCOI) Finding Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `fcoi_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Conflict of Interest (FCOI) Finding Flag');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `kuali_research_disclosure_number` SET TAGS ('dbx_business_glossary_term' = 'Kuali Research Disclosure ID');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `management_plan_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Management Plan Approval Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `management_plan_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Management Plan Approved By');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `management_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Management Plan Description');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `management_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management Plan Required Flag');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `mitigation_report_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Report Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `mitigation_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Report Submitted Flag');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `public_accessibility_date` SET TAGS ('dbx_business_glossary_term' = 'Public Accessibility Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `public_accessibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Accessibility Flag');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `relatedness_determination` SET TAGS ('dbx_business_glossary_term' = 'Relatedness Determination');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `relatedness_determination` SET TAGS ('dbx_value_regex' = 'related|not_related|pending_review');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `relatedness_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Relatedness Determination Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `relatedness_justification` SET TAGS ('dbx_business_glossary_term' = 'Relatedness Justification');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `retrospective_review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Retrospective Review Completion Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `retrospective_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retrospective Review Required Flag');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `sfi_description` SET TAGS ('dbx_business_glossary_term' = 'Significant Financial Interest (SFI) Description');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `sfi_type` SET TAGS ('dbx_business_glossary_term' = 'Significant Financial Interest (SFI) Type');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `sfi_type` SET TAGS ('dbx_value_regex' = 'equity|income|intellectual_property|board_position|consulting|other');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `sponsor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notification Date');
ALTER TABLE `education_ecm`.`research`.`conflict_of_interest` ALTER COLUMN `sponsor_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notification Required Flag');
ALTER TABLE `education_ecm`.`research`.`award_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`award_account` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `award_account_id` SET TAGS ('dbx_business_glossary_term' = 'Award Account Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Award Account Number');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Award Account Status');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'open|restricted|closed|pending_closeout|suspended|pre_award');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `account_title` SET TAGS ('dbx_business_glossary_term' = 'Award Account Title');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'research|instruction|public_service|other_sponsored');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `award_type` SET TAGS ('dbx_value_regex' = 'grant|contract|cooperative_agreement|subaward|gift');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `cfda_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{3}$');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `cost_sharing_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Account Flag');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `erp_project_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Project Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `erp_project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,30}$');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `fa_recovery_account_linkage` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Recovery Account Linkage');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `fa_recovery_account_linkage` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `human_subjects_flag` SET TAGS ('dbx_business_glossary_term' = 'Human Subjects Research Flag');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `last_financial_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Financial Report Date');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `mtdc_base` SET TAGS ('dbx_business_glossary_term' = 'Modified Total Direct Cost (MTDC) Base');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `next_financial_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Financial Report Due Date');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `organization_code` SET TAGS ('dbx_business_glossary_term' = 'Organization Code');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `residual_balance_disposition` SET TAGS ('dbx_business_glossary_term' = 'Residual Balance Disposition');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `residual_balance_disposition` SET TAGS ('dbx_value_regex' = 'return_to_sponsor|retain_institutional|transfer_to_pi|carryforward_approved');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `sponsor_award_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Award Number');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `total_authorized_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Authorized Budget Amount');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `total_encumbrances` SET TAGS ('dbx_business_glossary_term' = 'Total Encumbrances');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `total_expenditures_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Expenditures to Date');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `unrecovered_fa_amount` SET TAGS ('dbx_business_glossary_term' = 'Unrecovered Facilities and Administrative (F&A) Amount');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `vertebrate_animals_flag` SET TAGS ('dbx_business_glossary_term' = 'Vertebrate Animals Research Flag');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `proposal_personnel_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Personnel Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completion Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Person Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Added By User Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student Athlete Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `academic_rank` SET TAGS ('dbx_business_glossary_term' = 'Academic Rank');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `academic_year_effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Academic Year Effort Percentage');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `added_date` SET TAGS ('dbx_business_glossary_term' = 'Personnel Added Date');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'Academic Year|Calendar Year|Summer|Hourly|Stipend');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `biosketch_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Biosketch Required Flag');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `biosketch_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Biosketch Submitted Flag');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `calendar_year_effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year Effort Percentage');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'US Citizen|Permanent Resident|Temporary Visa|Foreign National');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `college_school_name` SET TAGS ('dbx_business_glossary_term' = 'College or School Name');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `conflict_of_interest_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) Disclosed Flag');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `current_and_pending_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Current and Pending Support Required Flag');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `current_and_pending_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Current and Pending Support Submitted Flag');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Personnel Email Address');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Personnel First Name');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `fringe_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Amount');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `fringe_benefit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `fringe_benefit_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefit Rate Percentage');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `home_department_code` SET TAGS ('dbx_business_glossary_term' = 'Home Department Code');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `home_department_name` SET TAGS ('dbx_business_glossary_term' = 'Home Department Name');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `institutional_base_salary` SET TAGS ('dbx_business_glossary_term' = 'Institutional Base Salary (IBS)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `institutional_base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `key_personnel_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Personnel Flag');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Personnel Last Name');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Personnel Middle Name');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `orcid_identifier` SET TAGS ('dbx_business_glossary_term' = 'Open Researcher and Contributor Identifier (ORCID)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `orcid_identifier` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}-d{4}-d{3}[0-9X]$');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `person_months` SET TAGS ('dbx_business_glossary_term' = 'Person Months');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `personnel_notes` SET TAGS ('dbx_business_glossary_term' = 'Personnel Notes');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `personnel_status` SET TAGS ('dbx_business_glossary_term' = 'Personnel Status on Proposal');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `personnel_status` SET TAGS ('dbx_value_regex' = 'Proposed|Confirmed|Declined|Replaced|Removed');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Personnel Phone Number');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `proposed_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Proposed Salary Amount');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `proposed_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Personnel Role Type');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'PI|Co-PI|Senior Personnel|Postdoctoral Associate|Graduate Research Assistant|Undergraduate Researcher');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `summer_effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Summer Effort Percentage');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Compensation Amount');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`research`.`award_report` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `award_report_id` SET TAGS ('dbx_business_glossary_term' = 'Award Report Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `compliance_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Report Due Date');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `extension_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `federal_reporting_system` SET TAGS ('dbx_business_glossary_term' = 'Federal Reporting System');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `institutional_official_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Official Approval Date');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `pi_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Approval Date');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `pi_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Approval Required Flag');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Document Reference');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_frequency` SET TAGS ('dbx_business_glossary_term' = 'Report Frequency');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|final_only|ad_hoc');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_notes` SET TAGS ('dbx_business_glossary_term' = 'Report Notes');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Report Sequence Number');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Status');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|accepted|overdue|waived');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'progress_report|final_technical_report|federal_financial_report_sf425|invention_disclosure|equipment_report|property_report');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `sponsor_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Acknowledgment Date');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `sponsor_program_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Program Name');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `sponsor_report_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Report Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `education_ecm`.`research`.`award_report` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` SET TAGS ('dbx_subdomain' = 'innovation_transfer');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `invention_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Invention Disclosure Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Inventor Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventor Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `bayh_dole_report_date` SET TAGS ('dbx_business_glossary_term' = 'Bayh-Dole Act Report Submission Date');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `bayh_dole_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Bayh-Dole Act Report Submitted Flag');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `co_inventor_names` SET TAGS ('dbx_business_glossary_term' = 'Co-Inventor Names');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `co_inventor_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `co_inventor_names` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `commercialization_stage` SET TAGS ('dbx_business_glossary_term' = 'Commercialization Stage');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `commercialization_stage` SET TAGS ('dbx_value_regex' = 'concept|prototype|clinical_trial|market_ready|commercialized|discontinued');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Number');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-d{4}-d{3,5}$');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `disclosure_title` SET TAGS ('dbx_business_glossary_term' = 'Invention Disclosure Title');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `federal_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Federal Funding Agency Name');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `federal_funding_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Funding Flag');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `invention_category` SET TAGS ('dbx_business_glossary_term' = 'Invention Category');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `invention_description` SET TAGS ('dbx_business_glossary_term' = 'Invention Description Summary');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `inventor_department_code` SET TAGS ('dbx_business_glossary_term' = 'Inventor Home Department Code');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `inventor_department_name` SET TAGS ('dbx_business_glossary_term' = 'Inventor Home Department Name');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `inventor_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Inventor Revenue Share Percentage');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `inventor_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `license_execution_date` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Execution Date');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `licensee_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Licensee Organization Name');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'not_licensed|under_negotiation|licensed_exclusive|licensed_non_exclusive|option_granted|terminated');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Patent Counsel Name');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Filing Date');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_filing_decision` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Decision');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_filing_decision` SET TAGS ('dbx_value_regex' = 'file_patent|abandon|license_without_patent|pending_decision');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_filing_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Decision Date');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_grant_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Grant Date');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patent_status` SET TAGS ('dbx_value_regex' = 'not_filed|pending|granted|rejected|abandoned|expired');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patentability_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Patentability Assessment Completion Date');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patentability_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Patentability Assessment Status');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patentability_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `patentability_opinion` SET TAGS ('dbx_business_glossary_term' = 'Patentability Opinion Summary');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventor Name');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `primary_inventor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `prior_publication_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Publication Flag');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `public_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `public_disclosure_description` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Description');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `revenue_to_date` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Revenue to Date');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `revenue_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`invention_disclosure` ALTER COLUMN `technology_transfer_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Officer Name');
ALTER TABLE `education_ecm`.`research`.`export_control_review` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`export_control_review` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `export_control_review_id` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Export Control Officer Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `access_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `conditions_and_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Export Control Conditions and Restrictions');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `countries_of_concern` SET TAGS ('dbx_business_glossary_term' = 'Countries of Concern');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `country_of_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Country of Concern Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `ear_applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Applicability Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `eccn_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `foreign_national_count` SET TAGS ('dbx_business_glossary_term' = 'Foreign National Count');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `foreign_national_countries` SET TAGS ('dbx_business_glossary_term' = 'Foreign National Countries');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `foreign_national_involvement_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreign National Involvement Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `fundamental_research_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Fundamental Research Determination Date');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `fundamental_research_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Fundamental Research Exclusion Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `international_collaboration_flag` SET TAGS ('dbx_business_glossary_term' = 'International Collaboration Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `international_partner_organizations` SET TAGS ('dbx_business_glossary_term' = 'International Partner Organizations');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `itar_applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Applicability Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `license_exception_code` SET TAGS ('dbx_business_glossary_term' = 'License Exception Code');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `license_requirement_determination` SET TAGS ('dbx_business_glossary_term' = 'Export License Requirement Determination');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `license_requirement_determination` SET TAGS ('dbx_value_regex' = 'no_license_required|license_required|license_exception_available|deemed_export_license_required');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'Export License Type');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Ongoing Monitoring Required Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Export Control Review Date');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `ofac_sanctioned_parties` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Sanctioned Parties');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `ofac_sanctions_applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Sanctions Applicability Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Research Project Description');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `project_title` SET TAGS ('dbx_business_glossary_term' = 'Research Project Title');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `publication_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Publication Restriction Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Number');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Outcome');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'approved_no_restrictions|approved_with_conditions|license_required|project_modification_required|denied|referred_to_legal');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `review_request_date` SET TAGS ('dbx_business_glossary_term' = 'Review Request Date');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Status');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Type');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'initial|modification|renewal|closeout|ad_hoc|incident_response');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Export Control Reviewer Notes');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Export Control Risk Level');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `technology_description` SET TAGS ('dbx_business_glossary_term' = 'Technology Description');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Training Required Flag');
ALTER TABLE `education_ecm`.`research`.`export_control_review` ALTER COLUMN `usml_category` SET TAGS ('dbx_business_glossary_term' = 'United States Munitions List (USML) Category');
ALTER TABLE `education_ecm`.`research`.`compliance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`research`.`compliance_event` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Identifier');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Of Interest Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `export_control_review_id` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `iacuc_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Animal Care and Use Committee (IACUC) Protocol Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `irb_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `previous_event_compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Compliance Event Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `audit_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Flag');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|verified');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Description');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Number');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Status');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|corrective_action_in_progress|pending_closure|closed|escalated');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Type');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Notes');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `regulatory_body_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Notification Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `regulatory_body_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Notified');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Reported Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Resolution Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Resolution Status');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'unresolved|resolved|pending_verification|accepted_by_sponsor|accepted_by_regulatory_body');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Severity Level');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `sponsor_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Agency Name');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `sponsor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notification Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `sponsor_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notified Flag');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `systemic_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Systemic Issue Flag');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` SET TAGS ('dbx_subdomain' = 'innovation_transfer');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `scholarly_output_id` SET TAGS ('dbx_business_glossary_term' = 'Scholarly Output Identifier');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Bib Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `iacuc_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Iacuc Protocol Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `irb_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Protocol Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `plo_id` SET TAGS ('dbx_business_glossary_term' = 'Plo Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Identifier (PI ID)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student Athlete Author Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `abstract_text` SET TAGS ('dbx_business_glossary_term' = 'Abstract Text');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `author_list` SET TAGS ('dbx_business_glossary_term' = 'Author List');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `citation_count` SET TAGS ('dbx_business_glossary_term' = 'Citation Count');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `citation_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Citation Last Updated Date');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `doi` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Identifier (DOI)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `doi` SET TAGS ('dbx_value_regex' = '^10.d{4,9}/[-._;()/:A-Za-z0-9]+$');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `embargo_end_date` SET TAGS ('dbx_business_glossary_term' = 'Embargo End Date');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `federal_sponsor_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Sponsor Flag');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `funding_acknowledgment_text` SET TAGS ('dbx_business_glossary_term' = 'Funding Acknowledgment Text');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `institutional_author_count` SET TAGS ('dbx_business_glossary_term' = 'Institutional Author Count');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `ipeds_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Flag');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `isbn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Book Number (ISBN)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `issn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Serial Number (ISSN)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Issue Number');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `open_access_status` SET TAGS ('dbx_business_glossary_term' = 'Open Access (OA) Status');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `open_access_status` SET TAGS ('dbx_value_regex' = 'gold|green|hybrid|bronze|closed');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `open_access_url` SET TAGS ('dbx_business_glossary_term' = 'Open Access Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `output_notes` SET TAGS ('dbx_business_glossary_term' = 'Output Notes');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `output_number` SET TAGS ('dbx_business_glossary_term' = 'Output Number');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `output_status` SET TAGS ('dbx_business_glossary_term' = 'Output Status');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `output_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|published|embargoed|retracted');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `output_type` SET TAGS ('dbx_business_glossary_term' = 'Output Type');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `page_range` SET TAGS ('dbx_business_glossary_term' = 'Page Range');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `peer_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewed Flag');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `publication_venue` SET TAGS ('dbx_business_glossary_term' = 'Publication Venue');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `rae_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Research Assessment Exercise (RAE) Submission Date');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `rae_submission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Research Assessment Exercise (RAE) Submission Eligible Flag');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `repository_deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Repository Deposit Date');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `repository_deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Repository Deposit Status');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `repository_deposit_status` SET TAGS ('dbx_value_regex' = 'not_deposited|deposited|pending_approval|rejected');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `research_area_code` SET TAGS ('dbx_business_glossary_term' = 'Research Area Code');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `research_area_description` SET TAGS ('dbx_business_glossary_term' = 'Research Area Description');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Output Title');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `volume_number` SET TAGS ('dbx_business_glossary_term' = 'Volume Number');
ALTER TABLE `education_ecm`.`research`.`scholarly_output` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `education_ecm`.`research`.`subrecipient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`subrecipient` SET TAGS ('dbx_subdomain' = 'grant_administration');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `subrecipient_id` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Identifier');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Grants Administrator Identifier');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `audit_findings_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Flag');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `debarment_check_date` SET TAGS ('dbx_business_glossary_term' = 'Debarment Check Date');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `debarment_status` SET TAGS ('dbx_business_glossary_term' = 'Debarment Status');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `debarment_status` SET TAGS ('dbx_value_regex' = 'clear|debarred|suspended|proposed_debarment');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `ein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `ein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `ffata_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Funding Accountability and Transparency Act (FFATA) Reporting Required Flag');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `financial_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Financial Contact Email Address');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `financial_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `financial_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `financial_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `financial_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Financial Contact Name');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `financial_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `financial_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `kuali_research_organization_number` SET TAGS ('dbx_business_glossary_term' = 'Kuali Research Organization Identifier');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Legal Name');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `most_recent_audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Audit Report Date');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Notes');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Organization Type');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `organization_type` SET TAGS ('dbx_value_regex' = 'university|non-profit|for-profit|government|foreign');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 1');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 2');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_city` SET TAGS ('dbx_business_glossary_term' = 'Primary City');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Postal Code');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_business_glossary_term' = 'Primary State or Province');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Risk Classification');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `sam_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'System for Award Management (SAM) Expiration Date');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `sam_registration_date` SET TAGS ('dbx_business_glossary_term' = 'System for Award Management (SAM) Registration Date');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `sam_registration_status` SET TAGS ('dbx_business_glossary_term' = 'System for Award Management (SAM) Registration Status');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `sam_registration_status` SET TAGS ('dbx_value_regex' = 'active|expired|inactive');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `single_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Required Flag');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `subrecipient_status` SET TAGS ('dbx_business_glossary_term' = 'Subrecipient Status');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `subrecipient_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|debarred');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `total_active_subaward_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Active Subaward Amount');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `total_active_subawards_count` SET TAGS ('dbx_business_glossary_term' = 'Total Active Subawards Count');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `uei_number` SET TAGS ('dbx_business_glossary_term' = 'Unique Entity Identifier (UEI) Number');
ALTER TABLE `education_ecm`.`research`.`subrecipient` ALTER COLUMN `uei_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` SET TAGS ('dbx_association_edges' = 'research.principal_investigator,compliance.training_program');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `research_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'research_training_completion Identifier');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Principal Investigator Id');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Record ID');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Compliance Training Id');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `animal_care_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Animal Care and Use Training Completion Date');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `animal_care_training_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Animal Care and Use Training Completion Flag');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Date');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Training Attempt Number');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `completion_method` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Method');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `export_control_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Export Control Certification Date');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `export_control_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Certification Flag');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `external_provider_name` SET TAGS ('dbx_business_glossary_term' = 'External Training Provider');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `human_subjects_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Human Subjects Research Training Completion Date');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `human_subjects_training_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Human Subjects Research Training Completion Flag');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Notes');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `rcr_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Responsible Conduct of Research (RCR) Training Completion Date');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `rcr_training_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Responsible Conduct of Research (RCR) Training Completion Flag');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `score_achieved` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approver');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Justification');
ALTER TABLE `education_ecm`.`research`.`research_training_completion` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Status');
