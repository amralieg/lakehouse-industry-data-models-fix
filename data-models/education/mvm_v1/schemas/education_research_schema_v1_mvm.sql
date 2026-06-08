-- Schema for Domain: research | Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:14:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`research` COMMENT 'Governs the full sponsored research lifecycle including grant proposals, award management, IRB protocol compliance, subaward administration, and PI tracking. Manages funding sources (NSF, NIH), F&A rates, IDC recovery, research expenditures, and closeout processes. Integrates with Kuali Research and supports RAE assessments and federal sponsor reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`research`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the sponsored research grant proposal. Primary key for the proposal entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Grant proposals are submitted under a specific academic program for IPEDS program-level research activity reporting, F&A rate assignment, and sponsored programs office routing. Higher-ed research admi',
    `cip_code_id` BIGINT COMMENT 'Foreign key linking to curriculum.cip_code. Business justification: Federal sponsors (NSF, NIH) and IPEDS require CIP code classification on grant proposals for discipline-level research expenditure reporting. The existing research_area_code/description are denormaliz',
    `idc_rate_id` BIGINT COMMENT 'Foreign key linking to research.idc_rate. Business justification: proposal currently stores idc_rate_type as a denormalized STRING (e.g., on-campus, off-campus) and fa_rate_percentage as a decimal. The idc_rate table is the authoritative reference for negotiated',
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
    `third_party_contract_id` BIGINT COMMENT 'Foreign key linking to billing.third_party_contract. Business justification: External research sponsors (e.g., DoD, corporate partners) often have third-party billing contracts covering tuition/fees for student researchers on their awards. Linking research_award to third_party',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Award budgets are administered within a cost center for departmental financial reporting, overhead allocation, and budget control. Sponsored research offices require cost center attribution to produce',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Award budgets fund faculty course releases (buyouts). When a grant buys out a course section, the award_budget must reference that course_section to track the release, support effort reporting, and re',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.fee_schedule. Business justification: Grant budget preparation requires referencing the applicable tuition fee schedule to calculate tuition remission costs for graduate student researchers. Higher-ed grants administrators routinely look ',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Award budgets draw from restricted sponsored program finance funds. Fund accounting is foundational in higher-ed; linking award budgets to finance funds supports fund balance reporting, restriction co',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Award budget periods must align with fiscal periods for period-end close, encumbrance rollover, and financial reporting. Grants accountants use this link to process budget carryforwards and generate p',
    `idc_rate_id` BIGINT COMMENT 'Foreign key linking to research.idc_rate. Business justification: award_budget has fa_rate_percentage which should be normalized via FK to idc_rate master table. Budget periods apply specific IDC rates that were in effect during that period; linking to the rate agre',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Award budgets must be mapped to chart-of-accounts ledger accounts for FASB/NACUBO financial reporting and budget-to-ledger reconciliation. Sponsored research accountants require this link to post dire',
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
    `employee_id` BIGINT COMMENT 'The institutional employee identifier linking the PI to the Human Resources system. Required for effort certification and payroll integration.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: PI eligibility determination, effort certification, and research activity reporting by department require linking PIs to their home org unit. Role-prefixed home_org_unit_id is used since no existing',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: PI office building assignment supports facilities space surveys (FICM/IPEDS reporting), PI directory services, and space utilization planning. The existing office_location plain-text field is a denorm',
    `position_id` BIGINT COMMENT 'Foreign key linking to hr.position. Business justification: NIH salary cap compliance, effort certification, and PI eligibility verification require linking PIs to their HR position. Institutional base salary calculations and appointment-type validation for sp',
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
    `instructor_id` BIGINT COMMENT 'FK to faculty.instructor.instructor_id — PI-to-faculty identity resolution is required for teaching load analysis, effort certification validation, and sponsored research compliance reporting. Without this link, institutions cannot answer w',
    `kuali_research_person_number` STRING COMMENT 'The unique person identifier assigned to the principal investigator in the Kuali Research system, used for linking proposals, awards, protocols, and compliance records.',
    `last_name` STRING COMMENT 'The legal last name (surname) of the principal investigator as recorded in institutional HR systems.',
    `middle_name` STRING COMMENT 'The middle name or initial of the principal investigator.',
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
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Subrecipients submit invoices that are processed as AP invoices. Linking subaward to the AP invoice supports subrecipient invoice approval workflows, monitoring, and FFATA federal reporting requiremen',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Uniform Guidance requires pass-through entities to monitor and audit subrecipients. The subaward already has single_audit_required flag; linking to audit tracks which audit examined each subrecipient ',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Subawards are funded from grant accounts. This link supports subrecipient cost tracking against the parent grant account budget — required for federal financial reporting (SF-425) and subrecipient mon',
    `idc_rate_id` BIGINT COMMENT 'Foreign key linking to research.idc_rate. Business justification: subaward has indirect_cost_rate which should be normalized via FK to idc_rate master table. Subawards apply specific IDC rates (either the subrecipients negotiated rate or a rate specified in the pri',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Subaward monitoring requires institutional liaison for compliance oversight, invoice review, reporting coordination, and subrecipient communication. Essential for post-award office workload distributi',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to finance.purchase_order. Business justification: Subawards are encumbered via purchase orders in the financial system. Linking subaward to the PO supports encumbrance tracking, financial commitment reporting, and procurement compliance on federally-',
    `research_award_id` BIGINT COMMENT 'Reference to the parent prime sponsored research award under which this subaward is issued.',
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
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Accreditors (SACSCOC, HLC, ABET) require program-level human subjects compliance reporting during self-study. IRB protocols must be traceable to academic programs. Existing college_name and department',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: IRB protocols are subject to OHRP for-cause audits and routine institutional compliance audits. Linking irb_protocol to audit supports tracking audit findings against specific protocols and managing O',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: IRB protocol management assigns staff coordinator for submission tracking, PI correspondence, continuing review scheduling, and compliance monitoring. Critical for IRB office workload management and r',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: AAHRPP accreditation and federal human subjects reporting (45 CFR 46) require tracking IRB protocols by academic department. Departmental IRB workload reporting and protocol administration depend on t',
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
    `consent_waiver_status` STRING COMMENT 'Indicates whether the IRB has granted a waiver or alteration of informed consent requirements for this protocol.. Valid values are `full_consent|waiver_granted|waiver_of_documentation|alteration_approved|not_applicable`',
    `continuing_review_due_date` DATE COMMENT 'Date by which the PI must submit a continuing review application to maintain active IRB approval. Critical for compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IRB protocol record was first created in the system. Used for audit trail and data lineage.',
    `data_safety_monitoring_plan` STRING COMMENT 'Description of the data and safety monitoring procedures in place for this protocol, including frequency of monitoring and responsible parties.',
    `data_safety_monitoring_required` BOOLEAN COMMENT 'Indicates whether the protocol requires a formal data and safety monitoring plan or Data Safety Monitoring Board (DSMB). Typically required for higher-risk studies.',
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

CREATE OR REPLACE TABLE `education_ecm`.`research`.`expenditure` (
    `expenditure_id` BIGINT COMMENT 'Primary key for expenditure',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Research expenditures originating from vendor invoices must link to the source AP invoice for audit trail and invoice-to-expenditure reconciliation required by federal sponsors under 2 CFR 200 documen',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Uniform Guidance (2 CFR 200) single audits and sponsor audits sample research expenditure transactions. Linking expenditure to audit enables post-audit finding remediation tracking and supports audit ',
    `award_account_id` BIGINT COMMENT 'Foreign key linking to research.award_account. Business justification: expenditure currently stores award_account_number as a denormalized STRING. award_account is the authoritative financial account record for sponsored research. Adding award_account_id normalizes this ',
    `award_budget_id` BIGINT COMMENT 'Foreign key linking to research.award_budget. Business justification: expenditure has budget_period column indicating expenditures are tracked against specific budget periods. Adding award_budget_id FK links expenditures to the budget period record, enabling budget vari',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Research expenditures include building maintenance, utilities, and renovations charged to awards. Cost accounting systems require building-level tracking for facilities and administrative cost allocat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Research expenditures are charged to cost centers for departmental financial reporting and F&A overhead allocation. The department_code plain attribute is a denormalization signal; cost_center_id enab',
    `employee_id` BIGINT COMMENT 'Reference to the employee if this expenditure represents salary, wages, or fringe benefits charged to the award.',
    `faculty_assignment_id` BIGINT COMMENT 'Foreign key linking to instruction.faculty_assignment. Business justification: Research expenditures charging faculty salary to grants must link to specific teaching assignments for effort certification and audit compliance. OMB Uniform Guidance requires reconciling grant-funded',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Research expenditures are charged against specific finance funds (restricted sponsored funds). This link supports fund balance reporting, restriction compliance monitoring, and fund-level expenditure ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Research expenditures must be associated with fiscal periods for period-end close, effort certification alignment, and IPEDS financial reporting. The fiscal_year and fiscal_period plain text attribute',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Research expenditures are charged against grant accounts — the primary financial control mechanism in sponsored research. This link supports expenditure-to-grant-account reconciliation, available bala',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Research expenditures generate journal entries for GL posting. Transaction-level link required for audit trail, financial statement preparation, and reconciliation between research administration syst',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Every research expenditure transaction must post to a GL ledger account — this is a core financial control requirement. The object_code plain attribute is a denormalization signal; the proper FK to le',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Indirect cost recovery allocation, departmental budget monitoring, and sponsored project financial reporting require linking expenditures to org units. Cost allocation reports and F&A rate calculation',
    `position_id` BIGINT COMMENT 'Foreign key linking to hr.position. Business justification: Effort certification (2 CFR 200 Subpart E) and payroll distribution to sponsored projects require linking personnel expenditures to specific HR positions. Salary cap compliance audits and fringe benef',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the principal investigator responsible for the research award under which this expenditure is charged.',
    `proposal_id` BIGINT COMMENT 'Reference to the research project or program under which this expenditure is organized for tracking and reporting purposes.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to finance.purchase_order. Business justification: Research expenditures for goods and services originate from purchase orders. Linking expenditure to the source PO supports encumbrance liquidation tracking and procurement compliance audits on sponsor',
    `research_award_id` BIGINT COMMENT 'Reference to the sponsored research award under which this expenditure is charged.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Lab-specific expenditures (equipment installation, specialized renovations, room modifications) are charged to awards at room level. Space cost allocation and chargeback systems require room-level exp',
    `sponsor_id` BIGINT COMMENT 'Reference to the external funding agency or sponsor providing the research award (e.g., NSF, NIH, private foundation).',
    `subaward_id` BIGINT COMMENT 'Reference to the subaward agreement if this expenditure is associated with a subcontract to another institution or organization.',
    `tuition_charge_id` BIGINT COMMENT 'Foreign key linking to billing.tuition_charge. Business justification: Research expenditures frequently include tuition payments for graduate research assistants charged to sponsored projects. Linking expenditures to tuition charges enables accurate award accounting, spo',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier if this expenditure represents a payment to an external party for goods or services.',
    `allocable_flag` BOOLEAN COMMENT 'Indicates whether the expenditure is allocable to the research award according to the benefit received by the project.',
    `allowable_flag` BOOLEAN COMMENT 'Indicates whether the expenditure is allowable under the terms and conditions of the sponsor award and federal cost principles.',
    `audit_flag` BOOLEAN COMMENT 'Indicates whether this expenditure has been flagged for audit review or compliance verification.',
    `available_balance` DECIMAL(18,2) COMMENT 'The remaining unspent and unencumbered balance available on the award account after this transaction.',
    `budget_period` STRING COMMENT 'The budget period number within the award lifecycle during which this expenditure occurred (e.g., Year 1, Year 2).',
    `closeout_flag` BOOLEAN COMMENT 'Indicates whether this expenditure is part of the award closeout process and final financial reporting to the sponsor.',
    `cost_share_flag` BOOLEAN COMMENT 'Indicates whether this expenditure represents institutional cost sharing or matching funds required by the sponsor.',
    `cumulative_expenditure_to_date` DECIMAL(18,2) COMMENT 'The total cumulative expenditure amount charged to the award account from inception through this transaction date.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the transaction amount (e.g., USD for US Dollar).. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `education_ecm`.`research`.`award_account` (
    `award_account_id` BIGINT COMMENT 'Unique identifier for the award account record. Primary key for the award account entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Financial account management assigned to specific grant accountant or business officer for reconciliation, financial reporting, and closeout. Critical for post-award office portfolio management and ef',
    `advancement_fund_id` BIGINT COMMENT 'Foreign key linking to advancement.advancement_fund. Business justification: Fund reconciliation and donor stewardship reporting: research award accounts funded by donor gifts must be reconciled against the advancement fund balance. Research finance and gift officers jointly p',
    `award_budget_id` BIGINT COMMENT 'Foreign key linking to research.award_budget. Business justification: Award accounts are established based on approved budgets. The accounts total_authorized_budget comes from a specific approved budget version. Adding award_budget_id FK links the account to its govern',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Award accounts are administered within cost centers for financial reporting and overhead allocation. The organization_code plain text attribute is a denormalization signal; cost_center_id enables prop',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Award accounts post F&A cost recovery to specific ledger accounts. The fa_recovery_account_linkage plain text attribute is a direct denormalization signal. Role-prefixed fa_recovery_ distinguishes thi',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Award account project periods must align with fiscal periods for year-end close, carryforward processing, and financial reporting. Grants accountants require this link to process period-end award acco',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: The award_account (research administration system) and grant_account (financial system) represent the same sponsored project from two perspectives. This link enables reconciliation between Kuali Resea',
    `idc_rate_id` BIGINT COMMENT 'Foreign key linking to research.idc_rate. Business justification: award_account has fa_rate_percentage and idc_rate_type which should be normalized via FK to idc_rate master table. Award accounts apply specific negotiated IDC rate agreements; linking provides full r',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Award account financial reporting, indirect cost recovery, and departmental research portfolio management require linking award accounts to org units. Sponsored project closeout and financial reportin',
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
    `fund_code` STRING COMMENT 'The institutional fund code or fund type that classifies the source of funds for this account (e.g., federal, state, private foundation, corporate). Used for financial reporting and compliance segregation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `human_subjects_flag` BOOLEAN COMMENT 'Indicates whether this award involves research with human subjects requiring Institutional Review Board (IRB) oversight and approval per federal regulations.',
    `last_financial_report_date` DATE COMMENT 'The date the most recent financial report (Federal Financial Report, invoice, or expenditure report) was submitted to the sponsor for this award account.',
    `modified_by` STRING COMMENT 'The username or identifier of the system user who last modified this award account record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time this award account record was last modified. Updated whenever any field in the record changes. Used for audit trail and change tracking.',
    `mtdc_base` DECIMAL(18,2) COMMENT 'The Modified Total Direct Cost base amount used for calculating F&A costs. Excludes equipment, capital expenditures, subaward amounts over $25K, and other items per 2 CFR 200.',
    `next_financial_report_due_date` DATE COMMENT 'The date the next financial report is due to the sponsor per the award terms and reporting schedule. Used for compliance tracking and deadline management.',
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
    `employee_id` BIGINT COMMENT 'Reference to the individual assigned to this proposal. May link to employee, faculty, or external collaborator records.',
    `faculty_assignment_id` BIGINT COMMENT 'Foreign key linking to instruction.faculty_assignment. Business justification: Sponsored programs offices must verify proposed effort percentages against existing teaching assignments during proposal preparation. Linking proposal personnel to their faculty_assignment supports ef',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.fee_schedule. Business justification: Proposal budgets for graduate student personnel must include tuition remission costs calculated from the applicable fee schedule. Grants administrators reference fee schedules during proposal preparat',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Sponsored research effort reporting (2 CFR 200) and budget justification require linking personnel to their home department org unit. Role-prefixed home_org_unit_id distinguishes from the proposals',
    `position_id` BIGINT COMMENT 'Foreign key linking to hr.position. Business justification: NIH salary cap compliance and effort reporting (2 CFR 200) require linking proposal personnel to their HR position to validate institutional base salary and appointment type. Sponsor budget justificat',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: proposal_personnel tracks PI, Co-PI, and senior personnel roles on proposals. When the personnel member holds a PI role, they should be directly linked to the authoritative principal_investigator reco',
    `profile_id` BIGINT COMMENT 'Foreign key linking to student.profile. Business justification: Graduate and undergraduate student researchers named on proposals require direct identity resolution to the student record for eligibility verification, enrollment confirmation, and visa/export-contro',
    `proposal_id` BIGINT COMMENT 'Reference to the grant proposal to which this personnel member is assigned.',
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

CREATE OR REPLACE TABLE `education_ecm`.`research`.`compliance_event` (
    `compliance_event_id` BIGINT COMMENT 'Primary key for compliance_event',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Research compliance events are frequently discovered during audits. Linking compliance_event to audit replaces the denormalized audit_report_reference text field with a proper FK, enabling corrective ',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: EHS and regulatory compliance reporting requires identifying the campus building where a compliance incident (biosafety violation, IACUC finding, audit finding) occurred. Incident location is mandator',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Compliance events on sponsored research (audit findings, corrective actions) have financial impacts tracked against grant accounts. The financial_impact_amount attribute requires a grant account refer',
    `irb_protocol_id` BIGINT COMMENT 'Reference to the IRB protocol associated with this compliance event, if applicable to human subjects research.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Departmental compliance reporting and corrective action assignment require linking compliance events to org units. Federal audit findings (2 CFR 200) and sponsor notifications must be attributed to sp',
    `previous_event_compliance_event_id` BIGINT COMMENT 'Reference to a previous compliance event record if this is a repeat or related finding.',
    `principal_investigator_id` BIGINT COMMENT 'Reference to the principal investigator associated with the research activity under compliance review.',
    `proposal_id` BIGINT COMMENT 'Reference to the research proposal associated with this compliance event, if applicable.',
    `research_award_id` BIGINT COMMENT 'Reference to the sponsored research award associated with this compliance event, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Corrective action tracking and regulatory audit response require identifying the responsible institutional employee for each compliance event. Federal sponsor notifications and internal audit reports ',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Regulatory and EHS incident reporting requires room-level precision for compliance events (e.g., a specific BSL-2 lab where a biosafety incident occurred). Room-level tracking supports corrective acti',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to research.sponsor. Business justification: compliance_event currently stores sponsor_agency_name as a denormalized STRING. The sponsor table is the authoritative reference for all funding sponsors. Adding sponsor_id normalizes this relationshi',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to research.subaward. Business justification: Compliance events frequently arise from subaward monitoring activities — subrecipient audit findings, monitoring visit results, and corrective action plans are all compliance events tied to a specific',
    `audit_finding_flag` BOOLEAN COMMENT 'Indicates whether this compliance event originated from an internal or external audit finding.',
    `corrective_action_completion_date` DATE COMMENT 'The actual date on which all corrective actions were completed and verified.',
    `corrective_action_due_date` DATE COMMENT 'The target date by which corrective actions must be completed to resolve the compliance event.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of the corrective action plan developed to address the compliance event and prevent recurrence.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan implementation.. Valid values are `not_started|in_progress|completed|overdue|verified`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this compliance event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (typically USD for U.S. institutions).. Valid values are `^[A-Z]{3}$`',
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
    `severity_level` STRING COMMENT 'Assessment of the severity or risk level of the compliance event, used to prioritize response and corrective actions.. Valid values are `critical|high|medium|low|informational`',
    `sponsor_notification_date` DATE COMMENT 'The date on which the sponsoring agency was formally notified of the compliance event.',
    `sponsor_notified_flag` BOOLEAN COMMENT 'Indicates whether the sponsoring agency has been formally notified of this compliance event, as required by federal regulations.',
    `systemic_issue_flag` BOOLEAN COMMENT 'Indicates whether this compliance event represents a systemic institutional issue requiring broader policy or process changes.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this compliance event record.',
    CONSTRAINT pk_compliance_event PRIMARY KEY(`compliance_event_id`)
) COMMENT 'Transactional record capturing compliance-related events, findings, and corrective actions associated with sponsored research activities. Captures event type (audit finding, protocol deviation, adverse event, noncompliance report, suspension, debarment notice, sponsor site visit finding), event date, associated award or protocol, severity level, description, corrective action plan, corrective action due date, corrective action completion date, regulatory body notified, and resolution status. Supports institutional research compliance program management and federal agency reporting obligations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`research`.`proposal` ADD CONSTRAINT `fk_research_proposal_idc_rate_id` FOREIGN KEY (`idc_rate_id`) REFERENCES `education_ecm`.`research`.`idc_rate`(`idc_rate_id`);
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
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ADD CONSTRAINT `fk_research_irb_protocol_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_award_account_id` FOREIGN KEY (`award_account_id`) REFERENCES `education_ecm`.`research`.`award_account`(`award_account_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `education_ecm`.`research`.`award_budget`(`award_budget_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`expenditure` ADD CONSTRAINT `fk_research_expenditure_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `education_ecm`.`research`.`subaward`(`subaward_id`);
ALTER TABLE `education_ecm`.`research`.`idc_rate` ADD CONSTRAINT `fk_research_idc_rate_prior_rate_agreement_idc_rate_id` FOREIGN KEY (`prior_rate_agreement_idc_rate_id`) REFERENCES `education_ecm`.`research`.`idc_rate`(`idc_rate_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `education_ecm`.`research`.`award_budget`(`award_budget_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_idc_rate_id` FOREIGN KEY (`idc_rate_id`) REFERENCES `education_ecm`.`research`.`idc_rate`(`idc_rate_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`award_account` ADD CONSTRAINT `fk_research_award_account_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ADD CONSTRAINT `fk_research_proposal_personnel_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_irb_protocol_id` FOREIGN KEY (`irb_protocol_id`) REFERENCES `education_ecm`.`research`.`irb_protocol`(`irb_protocol_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_previous_event_compliance_event_id` FOREIGN KEY (`previous_event_compliance_event_id`) REFERENCES `education_ecm`.`research`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `education_ecm`.`research`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `education_ecm`.`research`.`proposal`(`proposal_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_research_award_id` FOREIGN KEY (`research_award_id`) REFERENCES `education_ecm`.`research`.`research_award`(`research_award_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_sponsor_id` FOREIGN KEY (`sponsor_id`) REFERENCES `education_ecm`.`research`.`sponsor`(`sponsor_id`);
ALTER TABLE `education_ecm`.`research`.`compliance_event` ADD CONSTRAINT `fk_research_compliance_event_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `education_ecm`.`research`.`subaward`(`subaward_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`research` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`research` SET TAGS ('dbx_domain' = 'research');
ALTER TABLE `education_ecm`.`research`.`proposal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`proposal` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Code Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `sponsor_award_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Award Number');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `sponsor_program_announcement` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Program Announcement');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Proposal Title');
ALTER TABLE `education_ecm`.`research`.`proposal` ALTER COLUMN `vertebrate_animals_flag` SET TAGS ('dbx_business_glossary_term' = 'Vertebrate Animals Research Flag');
ALTER TABLE `education_ecm`.`research`.`research_award` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`research_award` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`research`.`research_award` ALTER COLUMN `third_party_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Contract Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`research`.`award_budget` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Preparer Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_budget` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`research`.`principal_investigator` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Office Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `kuali_research_person_number` SET TAGS ('dbx_business_glossary_term' = 'Kuali Research Person Identifier');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`research`.`principal_investigator` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `education_ecm`.`research`.`sponsor` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
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
ALTER TABLE `education_ecm`.`research`.`subaward` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Contact Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`subaward` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Prime Award Identifier (ID)');
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
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Coordinator Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `consent_waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Waiver Status');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `consent_waiver_status` SET TAGS ('dbx_value_regex' = 'full_consent|waiver_granted|waiver_of_documentation|alteration_approved|not_applicable');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `continuing_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Continuing Review Due Date');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `data_safety_monitoring_plan` SET TAGS ('dbx_business_glossary_term' = 'Data Safety Monitoring Plan');
ALTER TABLE `education_ecm`.`research`.`irb_protocol` ALTER COLUMN `data_safety_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Data Safety Monitoring Required');
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
ALTER TABLE `education_ecm`.`research`.`expenditure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`research`.`expenditure` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Identifier');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `award_account_id` SET TAGS ('dbx_business_glossary_term' = 'Award Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `faculty_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `tuition_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Tuition Charge Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `allocable_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocable Cost Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `allowable_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `closeout_flag` SET TAGS ('dbx_business_glossary_term' = 'Closeout Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `cost_share_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Flag');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `cumulative_expenditure_to_date` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure To Date');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`research`.`expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `education_ecm`.`research`.`idc_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`research`.`idc_rate` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
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
ALTER TABLE `education_ecm`.`research`.`award_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`research`.`award_account` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `award_account_id` SET TAGS ('dbx_business_glossary_term' = 'Award Account Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Advancement Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fa Recovery Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `idc_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Idc Rate Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `human_subjects_flag` SET TAGS ('dbx_business_glossary_term' = 'Human Subjects Research Flag');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `last_financial_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Financial Report Date');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `mtdc_base` SET TAGS ('dbx_business_glossary_term' = 'Modified Total Direct Cost (MTDC) Base');
ALTER TABLE `education_ecm`.`research`.`award_account` ALTER COLUMN `next_financial_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Financial Report Due Date');
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
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `proposal_personnel_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Personnel Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Person Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `faculty_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`proposal_personnel` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
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
ALTER TABLE `education_ecm`.`research`.`compliance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`research`.`compliance_event` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Identifier');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `irb_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `previous_event_compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Compliance Event Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `audit_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Flag');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|verified');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Severity Level');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `sponsor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notification Date');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `sponsor_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notified Flag');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `systemic_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Systemic Issue Flag');
ALTER TABLE `education_ecm`.`research`.`compliance_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
